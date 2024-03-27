import processing.core.*;
import processing.data.Table;
import processing.data.TableRow;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

ArrayList<Flight> flights = new ArrayList<Flight>();
ArrayList<Flight> matchingFlights = new ArrayList<Flight>(); // 存储匹配的航班
String startDate = "", endDate = "", airportCode = "";
boolean buttonPressed = false, visualizeButtonPressed = false, submitPressed = false;
int buttonX = 250, buttonY = 220, visualizeButtonX = 250, visualizeButtonY = 300, buttonWidth = 100, buttonHeight = 40;
int inputBoxY = 30, inputBoxWidth = 200, inputBoxHeight = 30, margin = 10;
int currentInputBox = -1; // -1: none, 0: startDate, 1: endDate, 2: airportCode
PApplet inputScreen;
FlightInfoScreen flightInfoScreen;
FlightVisualizationScreen flightVisualizationScreen;
String userInputText = ""; // 用户输入的文本
int returnButtonX = 250; // 可以和其他按钮保持一致或根据需要调整
int returnButtonY = 400; // 应该不同于其他按钮，避免重叠
int returnButtonWidth = 100;
int returnButtonHeight = 40;


void setup() {
  size(1300, 1100);
  inputScreen = this;
  flightInfoScreen = new FlightInfoScreen();
  flightVisualizationScreen = new FlightVisualizationScreen();
  loadFlights("flights_full.csv");
  textAlign(CENTER, CENTER);
}

void loadFlights(String filename) {
  Table table = loadTable(filename, "header");

  for (TableRow row : table.rows()) {
    String iataCode = row.getString("MKT_CARRIER");
    String flightNumber = row.getString("MKT_CARRIER_FL_NUM");
    String origin = row.getString("ORIGIN");
    String originCityName = row.getString("ORIGIN_CITY_NAME");
    String originState = row.getString("ORIGIN_STATE_ABR");
    String originWac = row.getString("ORIGIN_WAC");
    String dest = row.getString("DEST");
    String destCityName = row.getString("DEST_CITY_NAME");
    String destState = row.getString("DEST_STATE_ABR");
    String destWac = row.getString("DEST_WAC");
    String flightDate = row.getString("FL_DATE");
    String cancelled = row.getString("CANCELLED");
    String diverted = row.getString("DIVERTED");

    Airport airport = new Airport(origin, originCityName, originState, originWac, dest, destCityName, destState, destWac);
    FlightDateInfo dateInfo = new FlightDateInfo(flightDate, cancelled, diverted);
    Flight flight = new Flight(iataCode, flightNumber, origin, dest, airport, dateInfo);
    flights.add(flight);
  }
}

void draw() {
  background(255);
  if (!submitPressed) {
    drawInputBoxes();
    drawSubmitButton();
  } else {
    flightInfoScreen.display();
  }
}

void drawInputBoxes() {
  for (int i = 0; i < 3; i++) {
    String textToDisplay = "";
    String placeholder = i == 0 ? "Start Date (MM/dd/yyyy hh:mm:ss AM/PM)" :
                        i == 1 ? "End Date (MM/dd/yyyy hh:mm:ss AM/PM)" :
                        "Airport Code (IATA)";
                        
    if (i == 0 && !startDate.isEmpty()) textToDisplay = startDate;
    else if (i == 1 && !endDate.isEmpty()) textToDisplay = endDate;
    else if (i == 2 && !airportCode.isEmpty()) textToDisplay = airportCode;
    else if (currentInputBox == i) textToDisplay = userInputText;
    else textToDisplay = placeholder;

    drawInputBox(i, textToDisplay, placeholder);
  }
}

void drawInputBox(int order, String text, String placeholder) {
  int boxY = inputBoxY + (order * (inputBoxHeight + margin));
  fill(currentInputBox == order ? 230 : 255);
  stroke(0);
  rect(200, boxY, inputBoxWidth, inputBoxHeight, 5);
  fill(0);
  textAlign(LEFT, CENTER);
  float textX = 205;
  text(text, textX, boxY + inputBoxHeight / 2);
}

void mousePressed() {
  // 在用户点击其他输入框之前，保存当前输入框的内容
  if (currentInputBox == 0) startDate = userInputText;
  else if (currentInputBox == 1) endDate = userInputText;
  else if (currentInputBox == 2) airportCode = userInputText;

  for (int i = 0; i < 3; i++) {
    int boxY = inputBoxY + (i * (inputBoxHeight + margin));
    if (mouseX >= 200 && mouseX <= 200 + inputBoxWidth && mouseY >= boxY && mouseY <= boxY + inputBoxHeight) {
      currentInputBox = i;
      userInputText = (currentInputBox == 0) ? startDate : (currentInputBox == 1) ? endDate : (currentInputBox == 2) ? airportCode : "";
      return;
    }
  }

  // 检查是否点击了提交按钮
  if (!submitPressed && overButton()) {
    buttonPressed = true;
    displayMatchingFlights(); // 显示匹配的航班信息
  } else if (submitPressed) {
    // 如果已提交，检查是否点击了返回按钮
    if (overReturnButton()) {
      submitPressed = false;
      userInputText = "";
      currentInputBox = -1;
    } else if (overVisualizeButton()) {
      // 当点击可视化按钮时，调用显示柱状图的逻辑，此时需要传递airportCode作为第二个参数
      flightVisualizationScreen.setData(matchingFlights, airportCode); // 注意这里的改动，加入airportCode作为第二个参数
      flightVisualizationScreen.display(); // 这里直接调用显示柱状图的方法
    }
  } else {
    currentInputBox = -1;
    userInputText = "";
  }
}




void keyPressed() {
  if (currentInputBox != -1) {
    if (keyCode == BACKSPACE && userInputText.length() > 0) {
      // 删除最后一个字符
      userInputText = userInputText.substring(0, userInputText.length() - 1);
    } else if (keyCode == ENTER) {
      // 用户完成输入，根据当前输入框更新对应变量
      if (currentInputBox == 0) startDate = userInputText;
      else if (currentInputBox == 1) endDate = userInputText;
      else if (currentInputBox == 2) airportCode = userInputText;

      userInputText = ""; // 准备下一个输入
      currentInputBox = -1; // 重置当前输入框
    } else if (key >= 32 && key <= 126) { // 接受可打印字符
      userInputText += key;
    }
  }
}

void displayMatchingFlights() {
  if (!buttonPressed) return;

  matchingFlights.clear();

  for (Flight flight : flights) {
    if (flight.matchesCriteria(startDate, endDate, airportCode)) {
      matchingFlights.add(flight);
    }
  }

  submitPressed = true; // 标记已提交，准备显示匹配的航班
}

void drawSubmitButton() {
  fill(200); // 设置按钮的填充颜色
  if (overButton()) fill(150); // 如果鼠标悬停在按钮上，改变填充颜色
  rect(buttonX, buttonY, buttonWidth, buttonHeight, 5); // 绘制按钮
  fill(0); // 设置文字颜色为黑色
  text("Submit", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2); // 在按钮中央绘制"Submit"文字
}

void drawReturnButton() {
  fill(200);
  if (overReturnButton()) fill(150);
  rect(returnButtonX, returnButtonY, returnButtonWidth, returnButtonHeight, 5);
  fill(0);
  text("Return", returnButtonX + returnButtonWidth / 2, returnButtonY + returnButtonHeight / 2);
}

void drawVisualizeButton() {
  fill(200); // 设置按钮的填充颜色
  if (overVisualizeButton()) fill(150); // 如果鼠标悬停在按钮上，改变填充颜色
  rect(visualizeButtonX, visualizeButtonY, buttonWidth, buttonHeight, 5); // 绘制按钮
  fill(0); // 设置文字颜色为黑色
  text("Visualize", visualizeButtonX + buttonWidth / 2, visualizeButtonY + buttonHeight / 2); // 在按钮中央绘制"Visualize"文字
}



boolean overButton() {
  return mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY && mouseY <= buttonY + buttonHeight;
}

boolean overReturnButton() {
  return mouseX >= returnButtonX && mouseX <= returnButtonX + returnButtonWidth && mouseY >= returnButtonY && mouseY <= returnButtonY + returnButtonHeight;
}

boolean overVisualizeButton() {
  return mouseX >= visualizeButtonX && mouseX <= visualizeButtonX + buttonWidth && mouseY >= visualizeButtonY && mouseY <= visualizeButtonY + buttonHeight;
}

// 补充你的其他类定义（如Airport, Flight, FlightDateInfo等）...

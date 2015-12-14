package com.vbanthia.androidsampleapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;


public class MainActivity extends Activity implements View.OnClickListener{

    private EditText leftInput;
    private EditText rightInput;
    private Button addButton;
    private Button subButton;
    private Button mulButton;
    private Button divButton;
    private Button resetButton;
    private TextView resultText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Initialize view
        leftInput  = (EditText) findViewById(R.id.inputFieldLeft);
        rightInput = (EditText) findViewById(R.id.inputFieldRight);
        addButton  = (Button)   findViewById(R.id.additionButton);
        subButton  = (Button)   findViewById(R.id.subtractButton);
        mulButton  = (Button)   findViewById(R.id.multiplicationButton);
        divButton  = (Button)   findViewById(R.id.divisionButton);
        resetButton = (Button)  findViewById(R.id.resetButton);
        resultText = (TextView) findViewById(R.id.resultTextView);

        addButton.setOnClickListener(this);
        subButton.setOnClickListener(this);
        mulButton.setOnClickListener(this);
        divButton.setOnClickListener(this);
        resetButton.setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {
        if (view.getId() == R.id.resetButton) {
            leftInput.setText("");
            rightInput.setText("");
            return;
        }

        float left, right;
        try {
            left = Float.parseFloat(leftInput.getText().toString());
            right = Float.parseFloat(rightInput.getText().toString());
        } catch (Exception e) {
            showError();
            return;
        }

        String operation = "";
        float result = 0;

        switch (view.getId()) {
            case R.id.additionButton:
                operation = "+";
                result = left + right;
                break;
            case R.id.subtractButton:
                operation = "-";
                // Intentional Bug. Let's see if Appium can catch it or not!
                // It should be '-' instead of +
                result = left + right;
                break;
            case R.id.multiplicationButton:
                operation = "*";
                result = left * right;
                break;
            case R.id.divisionButton:
                operation = "/";
                result = left / right;
                break;
            default:
                break;
        }

        resultText.setText(String.format("%.2f %s %.2f = %.2f", left, operation, right, result));
    }

    private void showError() {
        String errorMsg = "Please, fill the input fields correctly";
        resultText.setText(errorMsg);
    }
}

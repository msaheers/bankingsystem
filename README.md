# COBOL Banking System

## Overview

A simple banking system developed in COBOL to understand how legacy banking applications work. This project simulates basic banking operations using sequential file processing.

## Features

* User login with Account Number and PIN
* Deposit money
* Withdraw money
* View account balance
* Change account PIN
* Read account information from a text file
* Save updated account information to a new file

## Technologies

* COBOL (GnuCOBOL)
* WSL (Ubuntu)
* Git & GitHub

## Project Structure

```text
bankingsystem.cob
accounts.txt
accounts_new.txt
README.md
```

## What I Learned

* COBOL program structure

  * Identification Division
  * Environment Division
  * Data Division
  * Procedure Division

* Variables and Working Storage

* User input using `ACCEPT`

* Output using `DISPLAY`

* Conditional statements (`IF`, `ELSE`)

* Loops using `PERFORM`

* File handling

  * OPEN
  * READ
  * WRITE
  * CLOSE

* Sequential file processing

* Searching records inside a file

* Login authentication

* Updating data in memory

* Building records using the `STRING` statement

* Writing updated records into a new file

* Basic transaction logic for deposits and withdrawals

* Version control with Git and GitHub

## Notes

This project uses sequential text files instead of a database. Updated records are written to `accounts_new.txt`. After the program finishes, replace the original file with:

```bash
cp accounts_new.txt accounts.txt
```

This simulates a simple file-based persistence mechanism commonly used in legacy batch-processing systems.

## Future Improvements

* Replace text files with an SQL database
* Store transaction history
* Improve PIN validation and security
* Add support for multiple bank accounts

## Sources 

Overstackflow. 
AI - Chatgpt basic plan ( Not just doing CTRL+C || CTRL + V, througout the journey of my COBOL project, I treated gpt as my professor, asked questions, and made sure that to breakdown all the logic behind, 
Took notes, kept debugging, had many debugging scenerios, I made myself in a position to stress myself, how to put an effort rather getting an answer in quick succession. 
I prompted in a way that AI doesnt give me answers, just hints. 
Once I understood the errros, I took the notes, and referred those NOTES when it kept repeating the same errors, once I understood the logic behind the errors, It was much easier to debug. 
Primary source that I really got the base in regards to COBOL is from the FreeCodeCamp : 

```bash
https://www.youtube.com/watch?v=RdMAEdGvtLA&t=977s
```

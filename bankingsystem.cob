            IDENTIFICATION DIVISION.
            PROGRAM-ID. BANK.

            ENVIRONMENT DIVISION.
            INPUT-OUTPUT SECTION.
            FILE-CONTROL.

            SELECT ACCOUNT-FILE
            ASSIGN TO "accounts.txt"
            ORGANIZATION IS LINE SEQUENTIAL.

            SELECT NEW-ACCOUNT-FILE
            ASSIGN TO "accounts_new.txt"
            ORGANIZATION IS LINE SEQUENTIAL.

            DATA DIVISION.

            FILE SECTION.

            FD ACCOUNT-FILE.

            01 ACCOUNT-RECORD.
                05 FILE-ACCOUNT-NUMBER PIC X(4).
                05 FILLER PIC X.
                05 FILE-PIN  PIC X(4).
                05 FILLER PIC X.
                05 FILE-BALANCE PIC X(7).

            FD NEW-ACCOUNT-FILE.

            01 NEW-ACCOUNT-RECORD PIC X(30).



            WORKING-STORAGE SECTION.
            
            01 BALANCE            PIC 9(7) VALUE 1000.
            01 BAL-DISPLAY        PIC Z(7).
            
            01 DEPOSIT-AMOUNT     PIC 9(5).
            01 WITHDRAW-AMOUNT    PIC 9(5).
            
            01 MENU-OPTION        PIC 9 VALUE 0.
            01 TRANSACTION-COUNT  PIC 9(5) VALUE 0.


            01 LOGIN-ATTEMPTS    PIC 9 VALUE 0.

            01 EOF-FLAG           PIC X VALUE "N".

            01 ACCOUNT-NUMBER    PIC 9(4).
            01 ENTERED-PIN       PIC 9(4).

            01 LOGIN-SUCCESS     PIC X VALUE "N".
            01 NEW-PIN           PIC 9(4).

            01 LOGGED-IN-ACCOUNT     PIC 9(4).
            01 SAVE-PIN              PIC 9(4).
            01 SAVE-BALANCE          PIC X(7).

            01 SAVE-PIN-TEXT         PIC X(4).
            01 SAVE-BALANCE-TEXT     PIC X(7).

            01 WS-EOF PIC X VALUE "N".
            
			
            PROCEDURE DIVISION.

                OPEN INPUT ACCOUNT-FILE

                DISPLAY "ENTER ACCOUNT NUMBER:"
                ACCEPT ACCOUNT-NUMBER

                DISPLAY "ENTER PIN:"
                ACCEPT ENTERED-PIN

            PERFORM UNTIL EOF-FLAG = "Y"

            READ ACCOUNT-FILE
                        AT END 
                            MOVE "Y" TO EOF-FLAG
                        NOT AT END
                    
            IF FUNCTION NUMVAL(FILE-ACCOUNT-NUMBER) = ACCOUNT-NUMBER
                AND ENTERED-PIN = FUNCTION NUMVAL(FILE-PIN)

                MOVE FUNCTION NUMVAL(FILE-BALANCE) TO BALANCE
                MOVE "Y" TO LOGIN-SUCCESS
                MOVE "Y" TO EOF-FLAG

            END-IF

            END-READ
            END-PERFORM

            CLOSE ACCOUNT-FILE

		    IF LOGIN-SUCCESS NOT = "Y"
                    DISPLAY "INVALID ACCOUNT OR PIN"
                    STOP RUN
            END-IF

            DISPLAY "LOGIN SUCCESSFUL"

            MOVE ACCOUNT-NUMBER TO LOGGED-IN-ACCOUNT
            MOVE ENTERED-PIN TO SAVE-PIN
            MOVE BALANCE TO SAVE-BALANCE
        
                PERFORM UNTIL MENU-OPTION = 4
        
                DISPLAY "======================="
                DISPLAY "BANK MENU"
                DISPLAY "======================="
                DISPLAY "1 - Deposit"
                DISPLAY "2 - Withdraw"
                DISPLAY "3 - Show Balance"
                DISPLAY "4 - Exit"
                DISPLAY "5 - Change Pin"
                DISPLAY "Choose Option: "
                
                ACCEPT MENU-OPTION
                

	            IF MENU-OPTION = 1

                DISPLAY "Enter deposit amount: "
                ACCEPT DEPOSIT-AMOUNT
                    
			    IF DEPOSIT-AMOUNT > 0
				    ADD DEPOSIT-AMOUNT TO BALANCE
                    MOVE BALANCE TO SAVE-BALANCE
                    ADD 1 TO TRANSACTION-COUNT


				    MOVE BALANCE TO BAL-DISPLAY

                    DISPLAY "Deposit successful"
                    DISPLAY "CURRENT BALANCE:" 
				    BAL-DISPLAY
                ELSE
				    DISPLAY "INVALID DEPOSIT AMOUNT"
                END-IF

			    END-IF
        
                IF MENU-OPTION = 2

                    DISPLAY "Enter withdrawal amount: "
                    ACCEPT WITHDRAW-AMOUNT
    
                    IF WITHDRAW-AMOUNT > BALANCE
                    DISPLAY "INSUFFICIENT FUNDS"
                    ELSE
                    SUBTRACT WITHDRAW-AMOUNT FROM BALANCE
                    MOVE BALANCE TO SAVE-BALANCE
                    ADD 1 TO TRANSACTION-COUNT
                    
					    MOVE BALANCE TO BAL-DISPLAY

                    DISPLAY "Withdrawal successful"
				    DISPLAY "CURRENT BALANCE: " 
					    BAL-DISPLAY
					    END-IF

			            END-IF
        
                        IF MENU-OPTION = 3
                            MOVE BALANCE TO BAL-DISPLAY
                            DISPLAY "CURRENT BALANCE:" BAL-DISPLAY
                        END-IF

                        IF MENU-OPTION = 5
                            DISPLAY "ENTER NEW PIN:"
                            ACCEPT NEW-PIN
						    
							IF NEW-PIN = 0000
                                DISPLAY "INVALID PIN"
					
                            ELSE

                            MOVE NEW-PIN TO SAVE-PIN
                            DISPLAY "PIN UPDATED SUCCESSFULLY"
                                    
                            END-IF
                        END-IF
        
                        IF MENU-OPTION NOT = 1 
				            AND MENU-OPTION NOT = 2 
				            AND MENU-OPTION NOT = 3 
				            AND MENU-OPTION NOT = 4
                            AND MENU-OPTION NOT = 5
                            DISPLAY "INVALID OPTION"
                        END-IF
        
            END-PERFORM

                PERFORM SAVE-ACCOUNT

                DISPLAY "ACCOUNT SAVED SUCCESSFULLY"
                DISPLAY "THANK YOU FOR USING THE BANKING SYSTEM"
                DISPLAY "TOTAL TRANSACTIONS: "
                DISPLAY TRANSACTION-COUNT.

                STOP RUN.

                SAVE-ACCOUNT.

                    OPEN INPUT ACCOUNT-FILE
                    OPEN OUTPUT NEW-ACCOUNT-FILE

                    MOVE "N" TO WS-EOF

            PERFORM UNTIL WS-EOF = "Y"

            READ ACCOUNT-FILE
                            AT END
                                MOVE "Y" TO WS-EOF
                            NOT AT END

            IF FUNCTION NUMVAL(FILE-ACCOUNT-NUMBER) = LOGGED-IN-ACCOUNT
                        MOVE SAVE-PIN TO SAVE-PIN-TEXT
                        MOVE SAVE-BALANCE TO SAVE-BALANCE-TEXT
                        
						STRING
                            FILE-ACCOUNT-NUMBER
                            ","
                            SAVE-PIN-TEXT
                            ","
                            SAVE-BALANCE-TEXT
                        DELIMITED BY SIZE
                        INTO NEW-ACCOUNT-RECORD
                        END-STRING

                 
                        WRITE NEW-ACCOUNT-RECORD

            END-READ

            END-PERFORM

                CLOSE ACCOUNT-FILE
                CLOSE NEW-ACCOUNT-FILE.
				

                


               







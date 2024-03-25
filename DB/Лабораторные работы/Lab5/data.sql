
-- -----------------------  TEST_CASES -----------------------------------------

Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('���������� � �������', '���������� � ������� ���������� ���� �������', '���������', 5, 2);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('�������� � �������', '�������� � ������� ���������� �������', '�������', 5, 2);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('�������� �������������', '�������� ������ ���� ��������� � ����������', '��� �������� ���������', 2, 1);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('��������', '�������� ������ ��������', '������ ������������� ����������', 9, 7);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('��������', '�������� ������������ ���������� ������� �������� ����������', '���������', 3, 5);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('������-���������', '�������� ������������ ���������� ������� �������-��������� ����������', '���������', 8, 5);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('���������� ������', '���������� ������ �� ����� ������������ � �������', '���������', 8, 6);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('UI', '������������ ����������������� ���������� �� ������ �����������', '���������', 8, 9);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('������� ������', '�������� ������ ���������� � �������� �������', '��� �������� �����������', 9, 4);


Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('������������ �����������', '�������� ���������������� ����������� � �������', '�������� ����������� ������������', 3, 1);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('������������ �������� ������ ������������', '�������� ����������� �������� ������ ������������ � �������', '����� ������������ ������� ������', 4, 1);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('������������ ���������� �������', '�������� ���������������� ���������� ������� �� ����������', '������ ������� �������������', 2, 3);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('������������ ������ �������', '�������� ���������������� ������ ������� �� �������� ������', '������ ������� �������', 3, 3);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('������������ �������������� �������', '�������� ���������������� �������������� ������� ������������', '������� ������������ ������� ��������������', 5, 5);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('������������ ����� ������', '�������� ���������������� ����� ������ ������������', '������ ������� �������', 4, 5);
-- ----------------------- TEST SUITE ---------------------------------------

Insert into TEST_SUITES(TITLE, DESCRIPTION) values('�����', '�������� ������ ����������� ������ ��� ���������� � ������� � ����������');
Insert into TEST_SUITES(TITLE, DESCRIPTION) values('�����', '�������� ������ ������ ��� ����������� ������������� � ��������� ����������');
Insert into TEST_SUITES(TITLE, DESCRIPTION) values('�������', '�������� ��������, ��� ���������� � ������������');
Insert into TEST_SUITES(TITLE, DESCRIPTION) values('���������������� ��������', '�������� ������������ ������ �� ����������������� ��������');
Insert into TEST_SUITES(TITLE, DESCRIPTION) values('Frontend', '�������� ���������������� ����� ����������');


-------------- TEST CASES STATUSES ----------------------
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('NOT EXECUTED', '2024-12-14', 1);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('EXECUTED', '2025-03-12', 1);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('EXECUTED', '2025-03-15', 2);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('NOT EXECUTED', '2025-01-01', 3);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('EXECUTED', '2025-01-10', 3);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('NOT EXECUTED', '2025-03-20', 4);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('NOT EXECUTED', '2025-02-15', 5);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('EXECUTED', '2025-02-28', 5);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('NOT EXECUTED', '2025-02-28', 6);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('NOT EXECUTED', '2025-04-04', 7);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('NOT EXECUTED', '2025-04-15', 8);
insert into TEST_CASE_STATUSES(STATUS, DATE_SET, TEST_CASE_ID) values('NOT EXECUTED', '2025-06-15', 9);

---------------------------- TEST APPS -----------------------------------
insert into APPS(DATE_CREATION, NAME, TEST_SUITE_ID) Values('2024-12-14', 'Comp.by', 1);
insert into APPS(DATE_CREATION, NAME, TEST_SUITE_ID) Values('2024-04-05', '��� "��� �����"', 2);
insert into APPS(DATE_CREATION, NAME, TEST_SUITE_ID) Values('2024-09-22', 'Call of War', 3);
insert into APPS(DATE_CREATION, NAME, TEST_SUITE_ID) Values('2024-07-16', 'Bel Maps', 4);
insert into APPS(DATE_CREATION, NAME, TEST_SUITE_ID) Values('2024-04-22', 'Trading', 5);


-------------------------- STEPS -------------------------

insert into STEPS(STEP, TEST_CASE_ID) values('������� ����', 1);
insert into STEPS(STEP, TEST_CASE_ID) values('������� �����', 1);
insert into STEPS(STEP, TEST_CASE_ID) values('�������� �� ������ "�������� � �������"', 1);
insert into STEPS(STEP, TEST_CASE_ID) values('������� � �������', 1);
insert into STEPS(STEP, TEST_CASE_ID) values('����� ���������� ����� � �������', 1);

insert into STEPS(STEP, TEST_CASE_ID) values('������� �������', 2);
insert into STEPS(STEP, TEST_CASE_ID) values('�������� �� ������ "������� � �������"', 2);
insert into STEPS(STEP, TEST_CASE_ID) values('������������� ��������', 2);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� �� ������� ������ � �������', 2);

insert into STEPS(STEP, TEST_CASE_ID) values('��������� ��� ��������', 3);

insert into STEPS(STEP, TEST_CASE_ID) values('����� � ����', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� �������� �� ����������� �� ��������� 100', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� �������� �� ����������� ���� �� ��������� 10', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� �������� �� ����������� ���� �� ��������� 1000', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� �������� � �������� �� ��������� 100', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� �������� � ��������  ���� �� ��������� 10', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� �������� � ��������  ���� �� ��������� 1000', 4);


insert into STEPS(STEP, TEST_CASE_ID) values('��������� ����������', 5);
insert into STEPS(STEP, TEST_CASE_ID) values('������ ����', 5);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� �������� � �����������', 5);
insert into STEPS(STEP, TEST_CASE_ID) values('�������� �������', 5);
insert into STEPS(STEP, TEST_CASE_ID) values('�������� ��������', 5);


insert into STEPS(STEP, TEST_CASE_ID) values('��������� ����������', 6);
insert into STEPS(STEP, TEST_CASE_ID) values('������ ����', 6);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� �������� � �����������', 6);
insert into STEPS(STEP, TEST_CASE_ID) values('�������� �������', 6);
insert into STEPS(STEP, TEST_CASE_ID) values('�������� ������', 6);


insert into STEPS(STEP, TEST_CASE_ID) values('����� � �������', 7);
insert into STEPS(STEP, TEST_CASE_ID) values('�������� �� "�������� �����"', 7);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� ������', 7);
insert into STEPS(STEP, TEST_CASE_ID) values('�����������', 7);

insert into STEPS(STEP, TEST_CASE_ID) values('��������� ������ ������', 8);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� ������������ ���������', 8);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� ������� ���������', 8);

insert into STEPS(STEP, TEST_CASE_ID) values('��������� ������������ ����� �����', 9);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� ������������ ����� ������ ��������', 9);
insert into STEPS(STEP, TEST_CASE_ID) values('��������� ������������ ����� ��� � �������', 9);


------------------------ DEFECTS -------------------------
insert into DEFECTS(DESCRIPTION, SEVERITY, PRIORITY) values ('������������ �������', 5, 3);
insert into DEFECTS(DESCRIPTION, SEVERITY, PRIORITY) values ('������ ����� �� �������', 5, 5);


---------------------- DEFECTS STATUSES -----------------------
insert into DEFECT_STATUSES(STATUS, DATE_SET, DEFECT_ID) values('NOT RESOLVED', '2025-01-01', 1);
insert into DEFECT_STATUSES(STATUS, DATE_SET, DEFECT_ID) values('RESOLVED', '2025-01-10', 1);


insert into DEFECT_STATUSES(STATUS, DATE_SET, DEFECT_ID) values('NOT RESOLVED', '2025-02-15', 2);


---------------------- TEST RUNS -----------------------------

insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (3, 2, '2025-03-10', '2025-03-12', 'OK', NULL, 3);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (1, 1, '2025-03-10', '2025-03-12', 'OK', NULL, 3);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (1, 2, '2025-03-12', '2025-03-15', 'OK', NULL, 1);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (2, 5, '2025-02-15', '2025-02-15', 'ERROR', 2, 1);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (2, 5, '2026-01-01', '2026-01-03', 'ERROR', 1, 4);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (4, 3, '2026-01-04', '2026-01-10', 'OK', NULL, 4);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (1, 4, '2027-07-25', '2027-11-30', 'OK', NULL, 2);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (2, 7, '2027-04-04', '2027-09-17', 'OK', NULL, 6);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (1, 8, '2029-01-04', '2029-01-10', 'OK', NULL, 8);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (4, 9, '2028-12-12', '2029-02-15', 'OK', NULL, 3);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (4, 9, '2027-12-12', '2028-02-15', 'OK', NULL, 4);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (4, 9, '2028-12-12', '2029-02-15', 'OK', NULL, 4);
insert into TEST_RUNS(TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID) values (4, 9, '2029-02-05', '2029-02-15', 'OK', NULL, 4);






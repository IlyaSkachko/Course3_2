
-- -----------------------  TEST_CASES -----------------------------------------

Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Добавление в корзину', 'Добавление в корзину различного рода товаров', 'Добавлено', 5, 2);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Удаление с корзины', 'Удаление с корзины добавленых товаров', 'Удалено', 5, 2);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Проверка маршрутизации', 'Проверка работы всех маршрутов в приложении', 'Все маршруты корректны', 2, 1);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Стрельба', 'Проверка физики стрельбы', 'Физика соответствует реальности', 9, 7);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Мощность', 'Проверка корректности выполнения замеров мощности автомобиля', 'Корректно', 3, 5);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Развал-схождения', 'Проверка корректности выполнения замеров развала-схождения автомобиля', 'Корректно', 8, 5);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Оформление заказа', 'Оформление заказа на товар добавленного в корзину', 'Оформлено', 8, 6);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('UI', 'Тестирование пользовательского интерфейса на разных устройствах', 'Корректно', 8, 9);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Входные данные', 'Проверка работы приложения с входными данными', 'Все проверки выполняются', 9, 4);


Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Тестирование авторизации', 'Проверка функциональности авторизации в системе', 'Успешная авторизация пользователя', 3, 1);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Тестирование создания нового пользователя', 'Проверка возможности создания нового пользователя в системе', 'Новый пользователь успешно создан', 4, 1);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Тестирование фильтрации товаров', 'Проверка функциональности фильтрации товаров по категориям', 'Товары успешно отфильтрованы', 2, 3);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Тестирование поиска товаров', 'Проверка функциональности поиска товаров по ключевым словам', 'Товары успешно найдены', 3, 3);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Тестирование редактирования профиля', 'Проверка функциональности редактирования профиля пользователя', 'Профиль пользователя успешно отредактирован', 5, 5);
Insert into TEST_CASES(TITLE, DESCRIPTION, EXPECTED_RESULT, PRIORITY, USER_ID) values('Тестирование смены пароля', 'Проверка функциональности смены пароля пользователя', 'Пароль успешно изменен', 4, 5);
-- ----------------------- TEST SUITE ---------------------------------------

Insert into TEST_SUITES(TITLE, DESCRIPTION) values('Заказ', 'Проверка работы корретности заказа его добавления в корзину и оформление');
Insert into TEST_SUITES(TITLE, DESCRIPTION) values('Стенд', 'Проверка работы стенда для определения характеристик и состояния автомобиля');
Insert into TEST_SUITES(TITLE, DESCRIPTION) values('Гемплей', 'Проверка геймплея, его логичности и корректности');
Insert into TEST_SUITES(TITLE, DESCRIPTION) values('Пользовательский сценарий', 'Проверка правильности работы по пользовательскому сценарию');
Insert into TEST_SUITES(TITLE, DESCRIPTION) values('Frontend', 'Проверка пользовательской части приложения');


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
insert into APPS(DATE_CREATION, NAME, TEST_SUITE_ID) Values('2024-04-05', 'СТО "Как домой"', 2);
insert into APPS(DATE_CREATION, NAME, TEST_SUITE_ID) Values('2024-09-22', 'Call of War', 3);
insert into APPS(DATE_CREATION, NAME, TEST_SUITE_ID) Values('2024-07-16', 'Bel Maps', 4);
insert into APPS(DATE_CREATION, NAME, TEST_SUITE_ID) Values('2024-04-22', 'Trading', 5);


-------------------------- STEPS -------------------------

insert into STEPS(STEP, TEST_CASE_ID) values('Открыть сайт', 1);
insert into STEPS(STEP, TEST_CASE_ID) values('Выбрать товар', 1);
insert into STEPS(STEP, TEST_CASE_ID) values('Кликнуть на кнопку "добавить в корзину"', 1);
insert into STEPS(STEP, TEST_CASE_ID) values('Перейти в корзину', 1);
insert into STEPS(STEP, TEST_CASE_ID) values('Найти добавленый товар в корзине', 1);

insert into STEPS(STEP, TEST_CASE_ID) values('Открыть корзину', 2);
insert into STEPS(STEP, TEST_CASE_ID) values('Кликнуть на кнопку "Удалить с корзины"', 2);
insert into STEPS(STEP, TEST_CASE_ID) values('Перезагрузить страницу', 2);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить на наличие товара в корзине', 2);

insert into STEPS(STEP, TEST_CASE_ID) values('Проверить все маршруты', 3);

insert into STEPS(STEP, TEST_CASE_ID) values('Зайти в игру', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить стрельбу не перемещаясь на растоянии 100', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить стрельбу не перемещаясь стоя на растоянии 10', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить стрельбу не перемещаясь стоя на растоянии 1000', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить стрельбу в движении на растоянии 100', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить стрельбу в движении  стоя на растоянии 10', 4);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить стрельбу в движении  стоя на растоянии 1000', 4);


insert into STEPS(STEP, TEST_CASE_ID) values('Запустить приложение', 5);
insert into STEPS(STEP, TEST_CASE_ID) values('Нажать пуск', 5);
insert into STEPS(STEP, TEST_CASE_ID) values('Выполнить действия с автомобилем', 5);
insert into STEPS(STEP, TEST_CASE_ID) values('Получить графики', 5);
insert into STEPS(STEP, TEST_CASE_ID) values('Получить мощность', 5);


insert into STEPS(STEP, TEST_CASE_ID) values('Запустить приложение', 6);
insert into STEPS(STEP, TEST_CASE_ID) values('Нажать пуск', 6);
insert into STEPS(STEP, TEST_CASE_ID) values('Выполнить действия с автомобилем', 6);
insert into STEPS(STEP, TEST_CASE_ID) values('Получить графики', 6);
insert into STEPS(STEP, TEST_CASE_ID) values('Получить замеры', 6);


insert into STEPS(STEP, TEST_CASE_ID) values('Зайти в корзину', 7);
insert into STEPS(STEP, TEST_CASE_ID) values('кликнуть на "Оформить заказ"', 7);
insert into STEPS(STEP, TEST_CASE_ID) values('Заполнить данные', 7);
insert into STEPS(STEP, TEST_CASE_ID) values('Подтвердить', 7);

insert into STEPS(STEP, TEST_CASE_ID) values('Проверить размер шрифта', 8);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить расположение элементов', 8);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить размеры элементов', 8);

insert into STEPS(STEP, TEST_CASE_ID) values('Проверить корректность ввода почты', 9);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить корректность ввода номера телефона', 9);
insert into STEPS(STEP, TEST_CASE_ID) values('Проверить корректность ввода имя и фамилии', 9);


------------------------ DEFECTS -------------------------
insert into DEFECTS(DESCRIPTION, SEVERITY, PRIORITY) values ('Неккоректный маршурт', 5, 3);
insert into DEFECTS(DESCRIPTION, SEVERITY, PRIORITY) values ('График вышел за пределы', 5, 5);


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






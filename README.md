# bgu-rfikt-diplom
LaTeX-шаблон дипломной работы с оформлением согласно официальной рекомендации для студентов факультета РФиКТ БГУ

О проекте
===============================================

**Pull request'ы приветствуются!**

Данный проект является шаблоном дипломной работы для верстки в системе LaTeX, предназначенным для студентов факультета РФиКТ БГУ. Оформление в достаточной мере подогнано под официальные рекомендации к курсовым и дипломным работам. В шаблоне реализованы:
* оглавление
* подсчет количества страниц, рисунков, таблиц, источников, приложений для реферата
* список источников

Для подробностей см. пункт "Описание файлов шаблона"

Инструкция по использованию шаблона
===============================================

Во-первых, необходимо изучить мануалы по LaTeX.

Во-вторых, данный шаблон для корректной работы, помимо собственно LaTeX, требует наличия установленных в системе утилит **xelatex** и **bibtexu**, которые нужно установить в систему.

Ubuntu
-------------------------------------
Установка LaTeX и всех необходимых для работы шаблона пакетов:

$ sudo apt-get install texlive-full

Использование шаблона:
* build.sh --- скрипт для корректной компиляции документа совместно со списком литературы и оглавлением
* clean.sh --- скрипт для удаления файлов, созданных при компиляции
* copy-to-destination.sh --- скрипт для создания резервной копии pdf, путь необходимо исправить

Windows и другие ОС
-------------------------------------
Установку LaTeX+кириллицы+XeLaTeX+BiBTeXu гуглите сами.
Команды для компиляции аналогичны таковым в скрипте build.sh

Описание файлов шаблона
===============================================

*Курсивом* выделены исполняемые скрипты, **полужирным начертанием** --- файлы, подлежащие редактированию, обычным начертанием --- вспомогательные файлы, не подлежащие редактированию/запуску.

* *build.sh*                   --- скрипт для корректной полной компиляции документа со списком литературы и оглавлением
* *clean.sh*                   --- скрипт для удаления файлов, созданных при компиляции
* **copy-to-destination.sh**   --- опциональный скрипт для создания резервной копии pdf
* compile.sh                   --- вспомогательный скрипт компиляции
* compile-bibliography.sh      --- вспомогательный скрипт компиляции
* **diploma.tex**              --- главный файл документа; содержит описание структуры диплома и названия глав, включает остальные файлы
* **diploma-preamble.tex**     --- преамбула документа; содержит описание оформления диплома, название диплома, имя автора, ключевые слова документа и другие настройки
* **diploma-abstract-ru.tex**  --- реферат к диплому на русском языке
* **diploma-abstract-by.tex**  --- реферат к диплому на белорусском языке
* **diploma-abstract-en.tex**  --- реферат к диплому на английском языке
* **diploma-introduction.tex** --- введение к диплому
* **diploma-chapter-1.tex**    --- первая глава диплома
* **chapter1/**                --- файлы разделов первой главы
* **diploma-chapter-2.tex**    --- вторая глава диплома
* **chapter2/**                --- файлы разделов второй главы
* **diploma-chapter-3.tex**    --- третья глава диплома
* **chapter3/**                --- файлы разделов третьей главы
* **diploma-conclusion.tex**   --- заключение к диплому
* **diploma-attachment.tex**   --- приложение к диплому
* **pics/**                    --- папка для размещения иллюстраций, используемых в дипломе
* **diploma-bibliography.bib** --- библиографическая информация (описание использованных источников)
* diploma-dummy-page.tex       --- текст-заглушка объемом приблизительно полторы страницы
* gost705.bst                  --- файл из проекта disser, описание оформления списка литературы согласно российскому ГОСТу, неполное (не для всех типов источников BibTeX выдает красивый выход), но у меня прокатило
* example.pdf                  --- пример, результат компиляции данного шаблона


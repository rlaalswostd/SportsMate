<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sportsmate</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            font-family: Arial, sans-serif;
        }

        #main {
            width: 100%;
            height: 100%;
            background-image: url("resources/img/jeremy-lapak-CVvFVQ_-oUg-unsplash.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
            overflow: hidden;
            position: relative;
        }

        .main_title {
            font-size: 8rem;
            color: white;
            text-align: center;
            margin: 0;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .intro {
            width: 100%;
            height: 100%;
            background-color: #121212;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            min-height: 500px;
            min-width: 800px;
        }

        .intro_window {
            width: 100%;
            max-width: 900px;
            height: 65%;
            background-color: #1e1e1e;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 300px;
            min-height: 300px;
        }

        .intro_header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #ffffff;
            border-bottom: 1px solid #d6d6d6;
        }

        .header_title {
            margin: 0;
            font-size: 1rem;
            font-weight: bold;
            color: #000;
        }

        .window-controls {
            display: flex;
        }

        .window-minimize,
        .window-maximize,
        .window-close {
            width: 12px;
            height: 12px;
            margin-left: 8px;
            border-radius: 50%;
            cursor: pointer;
        }

        .window-minimize { background-color: #f7d54a; }
        .window-maximize { background-color: #62c462; }
        .window-close { background-color: #ee5f5b; }

        .intro_window_content {
            padding: 20px;
            text-align: center;
            color: #ffffff;
            background-color: #17171b;
            flex: 1;
        }

        .intro_text {
            font-size: 1.5rem;
            line-height: 1.5;
            margin-bottom: 30px;
        }

        .go_home {
            margin-top: 25px;
        }

        .go_btn {
            background-color: #C0D6E4; 
            color: #000;
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            font-size: 1.25rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .go_btn:hover {
            background-color: #A0BCC4;
        }


        @media (max-width: 975px) {
            .main_title {
                font-size: 5rem;
            }

            .intro_window {
                width: 80%;
                height: 65%;
            }

            .intro_text {
                font-size: 1.2rem;
            }

            .go_btn {
                font-size: 1rem;
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>
<div id="main">
    <h2 class="main_title">Sportsmate</h2>
</div>

<div class="intro">
    <div class="intro_window">
        <div class="intro_header">
            <div class="header_title">www.sportsmate.com</div>
            <div class="window-controls">
                <div class="window-minimize"></div>
                <div class="window-maximize"></div>
                <div class="window-close"></div>
            </div>
        </div>

        <div class="intro_window_content">
            <div class="intro_text">
                <h2>Sportsmate란?</h2>
                <p style="line-height: 60px">
                    함께 운동할 친구를 찾고 계신가요? <br>
                    Sportsmate를 통해 운동 파트너를 쉽게 찾을 수 있습니다. <br>
                    이제 혼자가 아닌, 함께 운동할 친구를 찾아서 <br>
                    건강하고 활기찬 라이프스타일을 즐길 수 있어요!
                </p>

                <p>▽</p>

                <div class="go_home">
                    <button class="go_btn" onclick="location.href='/mvcboard/MainHome.do'">
                        <b>바로 가기</b>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

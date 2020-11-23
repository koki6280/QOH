$(function() {
	$('#tutorial').click(function() {
		introJs()
		 .setOptions({
		 	nextLabel: '次→',
		 	prevLabel: '←前',
		 	skipLabel: 'スキップ',
		 	doneLabel: '終了',
		 	exitOnOverlayClick: false,
		 	showStepNumbers: false,

		 	steps: [
		 	{
		 		intro:
		 		  '<b>QOHへようこそ！</b><br>簡単にQOHの使い方をご紹介します！',
		 	},
		 	{
		 		element: '#introjs-step1',
		 		intro: '『STEP1』タグを入力してください',
		 	},
		 	{
		 		element: '#introjs-step2',
		 		intro: '『STEP2』本文を入力してください',
		 	},
		 	{
		 		element: '#introjs-step3',
		 		intro: '『STEP3』[運動時間]を入力してください',
		 	},
		 	{
		 		element: '#introjs-step4',
		 		intro: '『STEP4』[睡眠時間]を入力してください',
		 	},
		 	{
		 		element: '#introjs-step5',
		 		intro: '『STEP5』[喫煙本数]を入力してください',
		 	},
		 	{
		 		element: '#introjs-step6',
		 		intro: '『STEP6』[飲酒量]を入力してください',
		 	},
		 	{
		 		element: '#introjs-step7',
		 		intro: '『STEP7』クリックで画像を選んでください',
		 	},
		 	{
		 		element: '#introjs-step8',
		 		intro: '最後に[投稿]ボタンを押して投稿します！',
		 	},
		 	],
		 })
		 .start();
	});
});
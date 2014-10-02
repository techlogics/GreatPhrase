//
//  ViewController.m
//  GreatPhrase
//
//  Created by kenichi on 9/28/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//
//
//
//
//
//
/******************************************************************
- "次へ"ボタンでランダムに名言を表示する機能の実装 ->
- "一覧ボタン"にすべての名言を表示する機能の実装 ->
- ローカル通知の実装 -> UILocalNotification
- "★"でお気に入り機能の実装 ->
- 
-
*******************************************************************/

#import "ViewController.h"
#import "WikiViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _phraseList = @{
                    @"0":@{@"phrase0":@"墓場で一番の金持ちになることは私には重要ではない。夜眠るとき、我々は素晴らしいことをしたと言えること、それが重要だ。",
                           @"name0":@"スティーブ・ジョブズ",
                           @"url0":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"1":@{@"phrase1":@"私は持っているテクノロジーをすべて引き替えにしても、ソクラテスとの午後のひとときを選ぶね。",
                           @"name1":@"スティーブ・ジョブズ",
                           @"url1":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"2":@{@"phrase2":@"我々がすることと同じくらい、我々がしないことを私は誇りに思う。",
                           @"name2":@"スティーブ・ジョブズ",
                           @"url2":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"3":@{@"phrase3":@"重要なことに集中する唯一の方法は「ノー」と言うことだ。",
                           @"name3":@"スティーブ・ジョブズ",
                           @"url3":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"4":@{@"phrase4":@"デザインとは、単なる視覚や感覚のことではない。デザインとは、どうやって動くかだ。",
                           @"name4":@"スティーブ・ジョブズ",
                           @"url4":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"5":@{@"phrase5":@"量より質が重要だ。2本の二塁打より、1本のホームランのほうがずっといい。",
                           @"name5":@"スティーブ・ジョブズ",
                           @"url5":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"6":@{@"phrase6":@"自分もいつかは死ぬ。それを思い出すことは、失うものなど何もないということを気づかせてくれる最善の方法です。",
                           @"name6":@"スティーブ・ジョブズ",
                           @"url6":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"7":@{@"phrase7":@"私は、本当に好きな物事しか続けられないと確信している。何が好きなのかを探しなさい。あなたの仕事にも、恋人にも。",
                           @"name7":@"スティーブ・ジョブズ",
                           @"url7":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"8":@{@"phrase8":@"結果の平等はともかく、機会というものは誰にでも平等であると固く信じている。",
                           @"name8":@"スティーブ・ジョブズ",
                           @"url8":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"9":@{@"phrase9":@"未来を見て、点を結ぶことはできない。過去を振り返って点を結ぶだけだ。だから、いつかどうにかして点は結ばれると 信じなければならない。",
                           @"name9":@"スティーブ・ジョブズ",
                           @"url9":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"10":@{@"phrase10":@"もし今日が人生最後の日だとしたら、今やろうとしていることは 本当に自分のやりたいことだろうか？",
                            @"name10":@"スティーブ・ジョブズ",
                            @"url10":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"11":@{@"phrase11":@"最も重要な決定とは、何をするかではなく、何をしないかを決めることだ。",
                            @"name11":@"スティーブ・ジョブズ",
                            @"url11":@"http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%82%A3%E3%83%BC%E3%83%96%E3%83%BB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%BA"},
                    @"12":@{@"phrase12":@"アイデアの秘訣は執念である",
                            @"name12":@"湯川秀樹",
                            @"url12":@"http://ja.wikipedia.org/wiki/%E6%B9%AF%E5%B7%9D%E7%A7%80%E6%A8%B9"},
                    @"13":@{@"phrase13":@"天才とは努力する凡才のことである。",
                            @"name13":@"アルベルト・アインシュタイン",
                            @"url13":@"http://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%AB%E3%83%99%E3%83%AB%E3%83%88%E3%83%BB%E3%82%A2%E3%82%A4%E3%83%B3%E3%82%B7%E3%83%A5%E3%82%BF%E3%82%A4%E3%83%B3"},
                    @"14":@{@"phrase14":@"私は失敗したことがない。ただ、1万通りの、うまく行かない方法を見つけただけだ。",
                            @"name14":@"トーマス・エジソン",
                            @"url14":@"http://ja.wikipedia.org/wiki/%E3%83%88%E3%83%BC%E3%83%9E%E3%82%B9%E3%83%BB%E3%82%A8%E3%82%B8%E3%82%BD%E3%83%B3"},
                    @"15":@{@"phrase15":@"朝7時に起き、夜11時に就寝すれば、たっぷり16時間ある。大抵の人は一日中なにか仕事をしている。ただ一つ違うのは、彼らの仕事は非常に多岐にわたり、私はたった一つの仕事にすべてのエネルギーを集中する点だ。",
                            @"name15":@"トーマス・エジソン",
                            @"url15":@"http://ja.wikipedia.org/wiki/%E3%83%88%E3%83%BC%E3%83%9E%E3%82%B9%E3%83%BB%E3%82%A8%E3%82%B8%E3%82%BD%E3%83%B3"},
                    @"16":@{@"phrase16":@"時間だけは神様が平等に与えて下さった。これをいかに有効に使うかはその人の才覚であって、うまく利用した人がこの世の中の成功者なんだ。",
                            @"name16":@"本田宗一郎",
                            @"url16":@"http://ja.wikipedia.org/wiki/%E6%9C%AC%E7%94%B0%E5%AE%97%E4%B8%80%E9%83%8E"},
                    @"17":@{@"phrase17":@"社長なんて偉くもなんともない。課長、部長、包丁、盲腸と同じだ。要するに命令系統をはっきりさせる記号にすぎない。",
                            @"name17":@"本田宗一郎",
                            @"url17":@"http://ja.wikipedia.org/wiki/%E6%9C%AC%E7%94%B0%E5%AE%97%E4%B8%80%E9%83%8E"},
                    @"18":@{@"phrase18":@"壁というのは、できる人にしかやってこない。超えられる可能性がある人にしかやってこない。だから、壁がある時はチャンスだと思っている。",
                            @"name18":@"イチロー",
                            @"url18":@"http://ja.wikipedia.org/wiki/%E3%82%A4%E3%83%81%E3%83%AD%E3%83%BC"},
                    @"19":@{@"phrase19":@"万策尽きたと思うな。自ら断崖絶壁の淵にたて。その時はじめて新たなる風は必ず吹く。",
                            @"name19":@"松下幸之助",
                            @"url19":@"http://ja.wikipedia.org/wiki/%E6%9D%BE%E4%B8%8B%E5%B9%B8%E4%B9%8B%E5%8A%A9"},
                    @"20":@{@"phrase20":@"世界には、きみ以外には誰も歩むことのできない唯一の道がある。その道はどこに行き着くのか、と問うてはならない。ひたすら進め。",
                            @"name20":@"ニーチェ",
                            @"url20":@"http://ja.wikipedia.org/wiki/%E3%83%95%E3%83%AA%E3%83%BC%E3%83%89%E3%83%AA%E3%83%92%E3%83%BB%E3%83%8B%E3%83%BC%E3%83%81%E3%82%A7"},
                    @"21":@{@"phrase21":@"人生とは今日一日のことである。",
                            @"name21":@"デール・カーネギー",
                            @"url21":@"http://ja.wikipedia.org/wiki/%E3%83%87%E3%83%BC%E3%83%AB%E3%83%BB%E3%82%AB%E3%83%BC%E3%83%8D%E3%82%AE%E3%83%BC"},
                    @"22":@{@"phrase22":@"たいていの成功者は他人が時間を浪費している間に先へ進む。これは私が長年、この眼で見てきたことである。",
                            @"name22":@"ヘンリー・フォード",
                            @"url22":@"http://ja.wikipedia.org/wiki/%E3%83%98%E3%83%B3%E3%83%AA%E3%83%BC%E3%83%BB%E3%83%95%E3%82%A9%E3%83%BC%E3%83%89"},
                    @"23":@{@"phrase23":@"言い訳が得意な者が、他の事が得意であることは滅多にない。",
                            @"name23":@"ベンジャミン・フランクリン",
                            @"url23":@"http://ja.wikipedia.org/wiki/%E3%83%99%E3%83%B3%E3%82%B8%E3%83%A3%E3%83%9F%E3%83%B3%E3%83%BB%E3%83%95%E3%83%A9%E3%83%B3%E3%82%AF%E3%83%AA%E3%83%B3"},
                    @"24":@{@"phrase24":@"食欲がないのに食べるのが健康に悪いように、欲望を伴わぬ勉強は記憶を損ない、記憶したことを保存しない。",
                            @"name24":@"レオナルド・ダ・ヴィンチ",
                            @"url24":@"http://ja.wikipedia.org/wiki/%E3%83%AC%E3%82%AA%E3%83%8A%E3%83%AB%E3%83%89%E3%83%BB%E3%83%80%E3%83%BB%E3%83%B4%E3%82%A3%E3%83%B3%E3%83%81"},
                    @"25":@{@"phrase25":@"グーグルでも、アップルでも、フリーソフトでも、すばらしい競争相手だし、僕らの気を引き締めてくれるよ。",
                            @"name25":@"ビル・ゲイツ",
                            @"url25":@"http://ja.wikipedia.org/wiki/%E3%83%93%E3%83%AB%E3%83%BB%E3%82%B2%E3%82%A4%E3%83%84"},
                    @"26":@{@"phrase26":@"なぜファーストクラスに乗らないかって、だってエコノミーでも到着する時間は同じだろ。",
                            @"name26":@"ビル・ゲイツ",
                            @"url26":@"http://ja.wikipedia.org/wiki/%E3%83%93%E3%83%AB%E3%83%BB%E3%82%B2%E3%82%A4%E3%83%84"},
                    @"27":@{@"phrase27":@"自分が出したアイデアを、少なくとも一回は人に笑われるようでなければ、独創的な発想をしているとは言えない。",
                            @"name27":@"ビル・ゲイツ",
                            @"url27":@"http://ja.wikipedia.org/wiki/%E3%83%93%E3%83%AB%E3%83%BB%E3%82%B2%E3%82%A4%E3%83%84"},
                    @"28":@{@"phrase28":@"しなくちゃいけない仕事には、何か楽しめる要素があるもの。",
                            @"name28":@"ウォルト・ディズニー",
                            @"url28":@"http://ja.wikipedia.org/wiki/%E3%82%A6%E3%82%A9%E3%83%AB%E3%83%88%E3%83%BB%E3%83%87%E3%82%A3%E3%82%BA%E3%83%8B%E3%83%BC"},
                    @"29":@{@"phrase29":@"私は何も学びとることがないほど無知な人に出会ったことはない。",
                            @"name29":@"ガリレオ・ガリレイ",
                            @"url29":@"http://ja.wikipedia.org/wiki/%E3%82%AC%E3%83%AA%E3%83%AC%E3%82%AA%E3%83%BB%E3%82%AC%E3%83%AA%E3%83%AC%E3%82%A4"},
                    @"30":@{@"phrase30":@"人が不可能と思うとき、やりたくないと決めているのだ。",
                            @"name30":@"スピノザ",
                            @"url30":@"http://ja.wikipedia.org/wiki/%E3%83%90%E3%83%BC%E3%83%AB%E3%83%BC%E3%83%95%E3%83%BB%E3%83%87%E3%83%BB%E3%82%B9%E3%83%94%E3%83%8E%E3%82%B6"},
                    @"31":@{@"phrase31":@"もし私が他人よりも鮮明に物事が見えたとすれば、それは、私が巨人の肩の上に立っているからだ。",
                            @"name31":@"アイザック・ニュートン",
                            @"url31":@"http://ja.wikipedia.org/wiki/%E3%82%A2%E3%82%A4%E3%82%B6%E3%83%83%E3%82%AF%E3%83%BB%E3%83%8B%E3%83%A5%E3%83%BC%E3%83%88%E3%83%B3"},
                    @"32":@{@"phrase32":@"この世で何より悪いのは、噂の種にされるより、噂の種にもならぬこと。",
                            @"name32":@"オスカー・ワイルド",
                            @"url32":@"http://ja.wikipedia.org/wiki/%E3%82%AA%E3%82%B9%E3%82%AB%E3%83%BC%E3%83%BB%E3%83%AF%E3%82%A4%E3%83%AB%E3%83%89"},
                    @"33":@{@"phrase33":@"最大の名誉は、決して倒れないことではない。倒れるたびに起き上がることである。",
                            @"name33":@"孔子",
                            @"url33":@"http://ja.wikipedia.org/wiki/%E5%AD%94%E5%AD%90"},
                    @"34":@{@"phrase34":@"１つのドアが閉まれば、もう１つのドアが必ず開きます。それはバランスをとるための、自然の法則なのです。",
                            @"name34":@"ブライアン・アダムス",
                            @"url34":@"http://ja.wikipedia.org/wiki/%E3%83%96%E3%83%A9%E3%82%A4%E3%82%A2%E3%83%B3%E3%83%BB%E3%82%A2%E3%83%80%E3%83%A0%E3%82%B9"},
                    @"35":@{@"phrase35":@"やるべきことはやる。自分がどうなろうとも、いかなる障害、危険、圧力があろうとも。これは人間道徳の基本。",
                            @"name35":@"ジョン・　F・ケネディ",
                            @"url35":@"http://ja.wikipedia.org/wiki/%E3%82%B8%E3%83%A7%E3%83%B3%E3%83%BBF%E3%83%BB%E3%82%B1%E3%83%8D%E3%83%87%E3%82%A3"},
                    @"36":@{@"phrase36":@"気に入らないものは、棄てておくか、あるいは改善するかである。",
                            @"name36":@"ゲーテ",
                            @"url36":@"http://ja.wikipedia.org/wiki/%E3%83%A8%E3%83%8F%E3%83%B3%E3%83%BB%E3%83%B4%E3%82%A9%E3%83%AB%E3%83%95%E3%82%AC%E3%83%B3%E3%82%B0%E3%83%BB%E3%83%95%E3%82%A9%E3%83%B3%E3%83%BB%E3%82%B2%E3%83%BC%E3%83%86"},
                    @"37":@{@"phrase37":@"幸福であろうと決めた、その心の程度に応じて人は幸福をつかむ。",
                            @"name37":@"エイブラハム・リンカーン",
                            @"url37":@"http://ja.wikipedia.org/wiki/%E3%82%A8%E3%82%A4%E3%83%96%E3%83%A9%E3%83%8F%E3%83%A0%E3%83%BB%E3%83%AA%E3%83%B3%E3%82%AB%E3%83%BC%E3%83%B3"},
                    @"38":@{@"phrase38":@"運命は神の考えるものだ。人間は人間らしく働ければそれで結構だ。",
                            @"name38":@"夏目漱石",
                            @"url38":@"http://ja.wikipedia.org/wiki/%E5%A4%8F%E7%9B%AE%E6%BC%B1%E7%9F%B3"},
                    @"39":@{@"phrase39":@"人生を幸福にするためには、日常の些事を愛さなければならぬ",
                            @"name39":@"芥川龍之介",
                            @"url39":@"http://ja.wikipedia.org/wiki/%E8%8A%A5%E5%B7%9D%E9%BE%8D%E4%B9%8B%E4%BB%8B"},
                    @"40":@{@"phrase40":@"ひとりで見る夢は夢でしかない。しかし誰かと見る夢は現実だ。",
                            @"name40":@"オノ・ヨーコ",
                            @"url40":@"http://ja.wikipedia.org/wiki/%E3%82%AA%E3%83%8E%E3%83%BB%E3%83%A8%E3%83%BC%E3%82%B3"},
                    @"41":@{@"phrase41":@"攻撃目標一点に行動を集約せよ。むだな事はするな。",
                            @"name41":@"織田信長",
                            @"url41":@"http://ja.wikipedia.org/wiki/%E7%B9%94%E7%94%B0%E4%BF%A1%E9%95%B7"},
                    @"42":@{@"phrase42":@"自分がみにくいアヒルだと思っていたころは、こんなたくさんの幸せがあるなんて、思ってもみなかった。",
                            @"name42":@"アンデルセン",
                            @"url42":@"http://ja.wikipedia.org/wiki/%E3%83%8F%E3%83%B3%E3%82%B9%E3%83%BB%E3%82%AF%E3%83%AA%E3%82%B9%E3%83%81%E3%83%A3%E3%83%B3%E3%83%BB%E3%82%A2%E3%83%B3%E3%83%87%E3%83%AB%E3%82%BB%E3%83%B3"},
                    @"43":@{@"phrase43":@"人生もフットボールも原則は同じだ。ラインに向かって突っ込め、ファウルするな。ボールから身をかわすな。ラインに向かって突っ込め。",
                            @"name43":@"セオドア・ルーズベルト",
                            @"url43":@"http://ja.wikipedia.org/wiki/%E3%82%BB%E3%82%AA%E3%83%89%E3%82%A2%E3%83%BB%E3%83%AB%E3%83%BC%E3%82%BA%E3%83%99%E3%83%AB%E3%83%88"},
                    @"44":@{@"phrase44":@"人は必要に迫られるとすぐに実力を発揮する。",
                            @"name44":@"ピタゴラス",
                            @"url44":@"http://ja.wikipedia.org/wiki/%E3%83%94%E3%82%BF%E3%82%B4%E3%83%A9%E3%82%B9"},
                    @"45":@{@"phrase45":@"勝つことばかり知りて、負くることを知らねば、害その身に至る。",
                            @"name45":@"徳川家康",
                            @"url45":@"http://ja.wikipedia.org/wiki/%E5%BE%B3%E5%B7%9D%E5%AE%B6%E5%BA%B7"},
                    @"46":@{@"phrase46":@"夢中で日を過ごしておれば、いつかはわかる時が来る。",
                            @"name46":@"坂本龍馬",
                            @"url46":@"http://ja.wikipedia.org/wiki/%E5%9D%82%E6%9C%AC%E9%BE%8D%E9%A6%AC"},
                    @"47":@{@"phrase47":@"人生に失敗がないと、人生を失敗する。",
                            @"name47":@"斎藤茂太",
                            @"url47":@"http://ja.wikipedia.org/wiki/%E6%96%8E%E8%97%A4%E8%8C%82%E5%A4%AA"},
                    @"48":@{@"phrase48":@"人生という試合で最も重要なのは、休憩時間の得点である。",
                            @"name48":@"ナポレオン・ボナパルト",
                            @"url48":@"http://ja.wikipedia.org/wiki/%E3%83%8A%E3%83%9D%E3%83%AC%E3%82%AA%E3%83%B3%E3%83%BB%E3%83%9C%E3%83%8A%E3%83%91%E3%83%AB%E3%83%88"},
                    @"49":@{@"phrase49":@"死を前にしたとき、みじめな気持ちで人生を振り返らなくてはならないとしたら、いやな出来事や逃したチャンス、やり残したことばかりを思い出すとしたら、それはとても不幸なことだと思うの。",
                            @"name49":@"オードリー・ヘップバーン",
                            @"url49":@"http://ja.wikipedia.org/wiki/%E3%82%AA%E3%83%BC%E3%83%89%E3%83%AA%E3%83%BC%E3%83%BB%E3%83%98%E3%83%97%E3%83%90%E3%83%BC%E3%83%B3"},
                    };
    
    // スワイプで名言切り替え -> swipeRight, swipeLeft
    UISwipeGestureRecognizer * rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    rightSwipe.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:rightSwipe];
    UISwipeGestureRecognizer * leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    leftSwipe.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:leftSwipe];
    
    _phraseLabel.numberOfLines = 0; // 行数無制限
    _phraseLabel.lineBreakMode = NSLineBreakByWordWrapping;
    int randomKey = arc4random() % 50;
    _phraseLabel.text = [_phraseList valueForKeyPath:[NSString stringWithFormat:@"%d.phrase%d", randomKey, randomKey]];
    NSString * name = [_phraseList valueForKeyPath:[NSString stringWithFormat:@"%d.name%d", randomKey, randomKey]];
    [_name setTitle:name forState:UIControlStateNormal];
    _wikiUrl = [_phraseList valueForKeyPath:[NSString stringWithFormat:@"%d.url%d", randomKey, randomKey]];
    
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now = [NSDate date];
    NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate: now];
    // 時間帯を固定
    [componentsForFireDate setHour: 8];
    [componentsForFireDate setMinute:0] ;
    [componentsForFireDate setSecond:0] ;
    [componentsForFireDate setTimeZone:[NSTimeZone defaultTimeZone]];
    UILocalNotification* notifyAlarm = [[UILocalNotification alloc] init];
    // 一日ごとに通知を送る
    notifyAlarm.repeatInterval = NSCalendarUnitDay;
    
    notifyAlarm.fireDate = [calendar dateFromComponents:componentsForFireDate];
    NSLog(@"fireDate is %@",notifyAlarm.fireDate);
    notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
    notifyAlarm.alertBody = [_phraseList valueForKeyPath:[NSString stringWithFormat:@"%d.name%d:%d.phrase%d", randomKey, randomKey, randomKey, randomKey]]; // 通知するメッセージ
    notifyAlarm.alertAction = @"Open"; // ダイアログで表示されたときのボタンの文言
    //UILocalNotificationを実行する
    [[UIApplication sharedApplication] scheduleLocalNotification:notifyAlarm];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)swipeRight:(UIGestureRecognizer *)gesture
{
    int randomKey = arc4random() % 50;
    _phraseLabel.text = [_phraseList valueForKeyPath:[NSString stringWithFormat:@"%d.phrase%d", randomKey, randomKey]];
    NSString * name = [_phraseList valueForKeyPath:[NSString stringWithFormat:@"%d.name%d", randomKey, randomKey]];
    [_name setTitle:name forState:UIControlStateNormal];
    _wikiUrl = [_phraseList valueForKeyPath:[NSString stringWithFormat:@"%d.url%d", randomKey, randomKey]];
}

- (void)swipeLeft:(UIGestureRecognizer *)gesture
{
    int randomKey = arc4random() % 50;
    _phraseLabel.text = [_phraseList valueForKeyPath:[NSString stringWithFormat:@"%d.phrase%d", randomKey, randomKey]];
    NSString * name = [_phraseList valueForKeyPath:[NSString stringWithFormat:@"%d.name%d", randomKey, randomKey]];
    [_name setTitle:name forState:UIControlStateNormal];
    _wikiUrl = [_phraseList valueForKeyPath:[NSString stringWithFormat:@"%d.url%d", randomKey, randomKey]];
}

// お気に入りに登録
- (IBAction)favorite:(id)sender
{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"wikiSegue"] ) {
        WikiViewController *wikiViewController = [segue destinationViewController];
        wikiViewController.url = _wikiUrl;
    }
}

@end

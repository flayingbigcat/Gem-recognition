-- MySQL dump 10.13  Distrib 8.0.35, for Win64 (x86_64)
--
-- Host: localhost    Database: web
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `create_img`
--

DROP TABLE IF EXISTS `create_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `create_img` (
  `user_id` int DEFAULT NULL,
  `create_img_time` varchar(255) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `prompt` text,
  `negative_prompt` text,
  `steps` int DEFAULT NULL,
  `height` int DEFAULT NULL,
  `width` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `create_img`
--

LOCK TABLES `create_img` WRITE;
/*!40000 ALTER TABLE `create_img` DISABLE KEYS */;
INSERT INTO `create_img` VALUES (NULL,'',NULL,NULL,NULL,NULL,NULL,NULL),(7,'2024-05-29 16:38:19','IMG/Save_gem/img_to_img/1716971899.png','a dog','',20,512,512),(7,'2024-05-29 16:43:10','IMG/Save_gem/img_to_img/1716972190.png','a expensive bracelet','expensive',20,512,512),(7,'2024-05-29 17:24:53','IMG/Save_gem/img_to_img/1716974693.png','bracelet','',20,512,512);
/*!40000 ALTER TABLE `create_img` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gems`
--

DROP TABLE IF EXISTS `gems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gems` (
  `gem_id` int NOT NULL AUTO_INCREMENT,
  `gem_name` varchar(255) NOT NULL,
  `gem_content` text,
  PRIMARY KEY (`gem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gems`
--

LOCK TABLES `gems` WRITE;
/*!40000 ALTER TABLE `gems` DISABLE KEYS */;
INSERT INTO `gems` VALUES (2,'铁铝榴石','铁铝榴石（Almandine ）名称源自小亚细亚的阿拉班达（Alabanda），为古代切割和加工石榴子石的地方。铁铝榴石通常呈暗红色至棕红色的半透明状晶体，部份属贵重者，作深红透明状，是宝石界中最常见的深红色石榴子石，称为贵榴石，有时光凭外表，很难与镁铝榴石区分。宝石级铁铝榴石常见的颜色以红色色调为主，包括褐红色、粉红、橙红等。铁铝榴石为均质体矿物，但在偏光镜下很多铁铝榴石可有异常消光。铁铝榴石含有相当多的针状包裹体，在其切割琢磨呈戒面时，会有星状出现，称为星彩铁铝榴石（StarAlmandine）。铁铝榴石是中温和高温的变质相矿物，主要产于区域变质岩、花岗岩和一些火成岩中。'),(3,'蓝锥矿晶体','蓝锥矿又名硅钡钛矿是一种稀有含有钡和钛的蓝色硅酸盐矿物，在热液换质作用的蛇纹岩中被发现。蓝锥矿在短波紫外线下会有亮蓝色到蓝白色的萤光反应，而越能在长波之下清楚见到红色萤光的蓝锥矿晶体越是稀有。蓝锥矿刻面宝石具有鲜明的外观，但宝石一般很小，干净无暇的刻面裸石极少有重于1ct的，多用于收藏。主要产自蛇纹岩中与柱晶石、钠沸石等伴生，目前全球唯一宝石级蓝锥矿晶体仅产于美国加州圣本尼托县，产量十分稀少。在1907年美国的地质学家乔治·劳德伯克首次使用benitoite这个英文名称来命名在美国加利福尼亚州圣贝尼托县内圣贝尼托河旁发现的矿物，其英文名称取自当地地名。虽然陆续在其他地方有发现到蓝锥矿，但是目前为止只有在加利福尼亚州产有质量最好且可以做为半宝石的矿物晶体，因此在1985年，蓝锥矿成为加利福尼亚州的州石。'),(4,'金绿柱石','金绿柱石（Heliodor），也称黄色绿柱石，是绿柱石族家族中的一员。颜色有绿黄色、橙色、黄棕色、黄褐色、金黄色、淡柠檬黄色，其英文名来源于希腊语的“太阳”。绿柱石颜色很丰富，可从无色一直到褐色，具有不同程度的颜色、饱和度和明亮度。常见的主要品种有祖母绿、海蓝宝石、绿色绿柱石、黄色绿柱石、粉色绿柱石（摩根石）、红色绿柱石（Bixbite）、Maxixe蓝色绿柱石等。'),(5,'红玛瑙','红玛瑙是常见的硅氧矿物，它基本上就是石英，很多性质都与石英相同。红玛瑙在矿物学上还属于玉髓的变种。\r\n红玛瑙是一种低级别的宝石，但人类将它加工成工艺品的历史却很久了。红色的玛瑙，即古代的赤玉。红玛瑙中有东红玛瑙和西红玛瑙之分。前者是指天然含铁的玛瑙经加热处理后形成的红玛瑙，又称“烧红玛瑙”，其中包括鲜红色，橙红色。东红玛瑙一名，因早年这种玛瑙来自日本，故而得名。后者是指天然的红色玛瑙，其中有暗红色者，也有艳红色者，中国古代出土的玛瑙均属西红玛瑙，这玛瑙多来自西方，故而得名。当红玛瑙有细纹带构造时，则属于缠丝玛瑙中的品种。中国市场上产的蓝玛瑙制品，多半由人工染色而成，其色浓均，易与天然者区分。玛瑙也是水晶家族成员，它是隐晶族，它的六面晶状非常细小，必须通过显微镜才能看得清。按颜色和纹路玛瑙可分为条纹玛瑙、缠丝玛瑙、苔藓玛瑙、角砾玛瑙、豹纹玛瑙、水玛瑙、苔纹玛瑙、红玛瑙、缟玛瑙等。红玛瑙的颜色多种多样，而且常常是呈多种颜色的。一般为半透明到不透明。有的红玛瑙里面还有水，叫水胆玛瑙。这样的玛瑙摇动时还能发出水声，很是奇特。'),(6,'猫眼石','猫眼石(opal)，即“具有猫眼效应的金绿宝石”。又称“猫儿眼”、“猫睛”、“猫精”、东方猫眼，是珠宝中稀有而名贵的品种变石猫眼也称亚历山大猫眼石，即有变色又有猫眼现象。猫眼石是金绿宝石中最稀有珍贵的一种，全球只有斯里兰卡出产，价格相当昂贵，10克拉以上国内商场很难见到。由于猫眼石表现出的光现象与猫的眼睛一样，灵活明亮，能够随着光线的强弱而变化，因此而得名。这种光学效应，称为“猫眼效应”。猫眼石在矿物学中是金绿宝石（Chrysoberyl）中的一种，属金绿宝石族矿物。金绿宝石是含铍铝氧化物，化学分子式为 BeAl2O4。属斜方晶系。晶体形态常呈短柱状或板状。严格说来，“猫眼”并不是宝石的名称，而是某些宝石上呈现的一种光学现象。即磨成半球形的宝石用强光照射时，表面会出现一条细窄明亮的反光，叫做“猫眼闪光”或“猫眼活光”，然后根据宝石是什么来命名，如果宝石是石英，则叫“石英猫眼”，如果是金绿宝石，则叫“金绿猫眼”。可能具有猫眼闪光的宝石种类很多，据统计可能多达30种，市场上较常见的除石英猫眼和金绿猫眼外，主要还有“辉石猫眼”、“海蓝宝石猫眼”等。由于金绿猫眼最为著名也最珍贵，习惯上它也简称为“猫眼”，其它猫眼则不可这样称呼。'),(7,'赛黄晶','赛黄晶（Danburite）英文名称来自发现地美国康涅狄格州的丹伯里（Danbury）。英国伦敦大英自然历史博物馆收藏一粒产自于缅甸的黄色阶梯刻面型的赛黄晶，重138.61ct；美国华盛顿史密斯博物馆一粒缅甸产的黄色赛黄金，重18.4ct；日本产的一粒无色赛黄晶，重7.9ct。赛黄晶之所以叫赛黄晶，是因为它的成分跟黄晶非常相似，但是毕竟是略有区别，所以中文翻译成了赛黄晶。'),(8,'钻石','钻石是指经过琢磨的金刚石，金刚石是一种天然矿物，是钻石的原石。简单地讲，钻石是在地球深部高压、高温条件下形成的一种由碳元素组成的单质晶体。钻石是目前世界上已知的最硬的一种自然物质。钻石产量稀少，通常为无色晶体，具有高度的折光特性，能折射出多彩的光泽。钻石不仅可以用作首饰，工业上也用来作为高级的切削和研磨材料。'),(9,'翡翠','翡翠（jadeite），也称翡翠玉jadeites、翠玉、缅甸玉，是玉的一种。翡翠的正确定义是以硬玉矿物为主的辉石类矿物组成的纤维状集合体。但是翡翠并不等于硬玉 。翡翠是在地质作用下形成的达到玉级的石质多晶集合体，主要由硬玉或硬玉及钠质（钠铬辉石）和钠钙质辉石（绿辉石）组成，可含有角闪石、长石、铬铁矿、褐铁矿等。产翡翠的缅甸勐拱、密支那一带，距我国云南边境只有150公里。在明朝万历年间，此地曾属永昌府（今云南省保山市）管辖。由于历史的原因，被称为“东方瑰宝”的翡翠经云南腾冲、瑞丽等边城输入我国。'),(10,'萤石','萤石（Fluorite）又称氟石。自然界中较常见的一种矿物，可以与其他多种矿物共生，世界多地均产， 有5个有效变种。等轴晶系，主要成分是氟化钙（CaF₂）。结晶为八面体和立方体。晶体呈玻璃光泽，颜色鲜艳多变，质脆，莫氏硬度为4，熔点1360℃，具有完全解理的性质。部分样本在受摩擦、加热、紫外线照射等情况下可以发光。该矿物来自火山岩浆，在岩浆冷却过程中，被岩浆分离出来的气水溶液内含氟，在溶液沿裂隙上升的过程里，气水溶液中的氟离子与周围岩石中的钙离子结合，形成氟化钙，冷却结晶后即形成萤石。存在于花岗岩、伟晶岩、正长岩等岩石内。'),(11,'红石榴石','红榴石又称红石榴石，是石榴石中铝榴石系列中的镁铝榴石，属于常见的石榴石品种。红石榴石的红色可让人拥有难以抗拒的魅力，招来幸福与永恒的爱情，增加自信，是女性之石。产于亚利桑那、南非、阿根廷、澳大利亚、巴西、缅甸、苏格兰、瑞士及坦桑尼亚、莫桑比克。'),(12,'钙铝榴石','钙铝榴石是钙榴石类最常见的一种石榴石，颜色多种多样，主要有绿色、黄绿色、黄色、褐红色及乳白色等。 钙铝榴石的颜色是从无色至黑色的，根据其元素含量不同而颜色不同。其英文名称源自首先被发现、呈独特醋栗色的钙铝榴石。呈棕色是由锰和铁内含物引起的。钙铝榴石出现于1803年，源于希腊语的“火”和“出现”，钙铝榴石也叫波西米亚榴石或开普红宝石。'),(13,'堇青石','堇青石（Cordierite或Iolite，Dichroite）来自希腊文中的Violet，寓意其呈紫罗兰色，Dichroite来自希腊文“双色”，指宝石具有很强的多色性。由于堇青石有像蓝宝石一样的蓝色，有人称之为“水蓝宝石”（water sapphire）。堇青石是一种硅酸盐矿物，通常具有浅蓝或浅紫色，玻璃光泽，透明至半透明 。堇青石还具有一个特点，具有明显的多色性（三色性），在不同的方向上发出不同颜色的光线。品优色美的堇青石被当作宝石，除此以外，堇青石由于耐火性好、受热膨胀率低，普遍作为汽车净化器的蜂窝状载体材料来使用。堇青石产于片岩、片麻岩及蚀变火成岩中。人们因此也称堇青石为二色石。人工可以合成镁堇青石，用于耐火材料。堇青石原石一般重4-5克拉，更大的也有发现。堇青石一般切割成传统的形状，最受欢迎的颜色是蓝紫色。'),(14,'玉','玉是矿石中比较高贵的一种。玉石富含多种元素，如锌、铁、铜、锰、镁、钴、硒、铬、钛、锂、钙、钾、钠等。玉之润可消除浮躁之心，玉之色可愉悦烦闷之心，玉之纯可净化污浊之心。所以君子爱玉，希望在玉身上寻到天然之灵气。玉乃石之美者，色阳性润质纯为上品。宝石也如此。其价值高低并不完全取决于成份，色泽、质感、雕工往往是其价值所在。\r\n在西方宝石学中，玉的英文名称为Jade，来源于西班牙侵略者，他们把由墨西哥掠夺来的玉起名为Pieda be ijade ，玉(ijade)是词的最后一个字。'),(15,'紫锂辉石','紫锂辉石Spodumene是一种含锂元素的矿物，颜色有紫、红、黄、绿等多种颜色。由透明无色至紫色的，称为“紫锂辉石”、绿色的“绿锂辉石”，而红色、紫红色和黄色的，则没有特别的名称，是锂辉石的变种。全球最大的紫锂辉石原石重5500克拉，尺寸210mm×110mm×48mm。有多种颜色，最常见的为黄灰色。两种宝石变种胆子粉红色的紫锂辉石（因锰而产生）和鲜艳祖母绿色的翠绿锂辉石（颜色因铬而产生）。尽管完全的解理使之易碎，但仍很受收集者青睐。从不同方向观赏时，会看到无色和两种主题色。常被切磨成盘式刻面，以展示最美丽的色彩。粉红色可能会褪色，但可经辐射增色，辄醉阵净化。'),(16,'拉长石','拉长石（Labradorite）是斜长石的一种，是由钠长石（NaAlSi3O8，符号Ab)和钙长石（CaAl2Si2O8，符号An）组成的类质同象系列，通常用An分子的百分含量来表示斜长石的成分，拉长石属中性斜长石，An含量50－70%。纯净而色泽美丽的斜长石可作宝石，但并非很名贵。拉长石比较常见，被人们用作装饰材料，其中有些有晕彩的拉长石还被当作宝石。拉长石一般为灰、褐到黑色，可作宝石的拉长石有红、蓝、绿色的晕彩。拉长石的晶体可长达2米，产在辉长岩、苏长岩、玄武岩、粒玄岩等岩石中。拉长石又称光谱石，因为它可以闪现出像太阳的七彩光芒而得名。广泛出现于各种中、基性和超基性岩中。其中只有极少数可用作宝石。'),(17,'孔雀石','孔雀石是一种碳酸盐矿物，主要成分为Cu2(OH)2CO3，颜色深绿到鲜艳绿，丝绢光泽或玻璃光泽，半透明至不透明，莫氏硬度3.5-4.5。孔雀石产于铜矿的地表，近地表氧化带，与赤铜矿、蓝铜矿、铜蓝、硅孔雀石等共生，是原生铜矿的重要找矿标志矿物，也是一种玉料。孔雀石是一种碳酸盐矿物，主要成分为Cu2(OH)2CO3，其中CuO质量分数71.9%，CO2质量分数19.9%，H2O质量分数8.15%。成分中含有锌（可达12%）；还含有Ca、Fe、Si、Ti、Na、Pb、Mn、V等元素。'),(18,'黑玛瑙','黑玛瑙是自然界中的一种玛瑙，也是一种胶体矿物，在矿物学中，它属于玉髓类。黑玛瑙象征坚毅，是应用广泛玉料，古代人们常以“珍珠玛瑙”来形容财富。国外很多的传说中提到黑玛瑙能给佩戴黑玛瑙者带来愉快和信心，带来美梦。学者把黑玛瑙视为宝石中的第三眼，象征友善的爱心，也代表希望。黑玛瑙英文名称black agate，主要因玛瑙中含有较多有机质引起。纯黑的整块玛瑙在自然界极少见，多为因有机质含量不均而呈现出深浅不同的条带。黑玛瑙主要成分为Sio2（二氧化硅），质地很纯时为灰色，若含有各种色素离子时便呈现红、黑、蓝、绿等各色，并具有或深或浅的环带构造。这些条带可以具有不同的颜色(红，蓝，紫，绿，黑，白等等)，如果是呈黑白相间的条带，就称为缟黑玛瑙。呈红白条带者就称为缠丝黑玛瑙。如果缟黑玛瑙中的黑条带很宽，就可单独切割出来加工成黑玛瑙珠子。其中难免仍有很细的白色条带，在阳光下就可见到。所以，在黑玛瑙珠子中见到有白色的微细条纹，是很正常的。'),(19,'珍珠','珍珠，又称蚌珠、濂珠，是一种古老的有机宝石，主要产于珍珠贝类和珠母贝类软体动物体内。珍珠为贝类内分泌作用而生成的含碳酸钙的矿物珠粒，由大量微小的文石晶体集合而成的。种类丰富，形状各异，色彩斑斓。根据地质学和考古学的研究证明，在两亿年前，地球上就已经有了珍珠 。珍珠药用在中国已有2000余年历史。在国际宝石界还将珍珠列为六月生辰的幸运石，结婚十三周年和三十周年的纪念石。具有瑰丽色彩和高雅气质的珍珠，象征着健康、纯洁、富有和幸福，自古以来为人们所喜爱。珍珠分为淡水珍珠和海水珍珠两种。中国的淡水珠主要养殖区在诸暨、常德、苏州、江西、湖北、安徽。珍珠有白色系、红色系、黄色系、深色系和杂色系五种，多数不透明。'),(20,'蔷薇石英','蔷薇石英是石英的一种，它因有着漂亮的粉红色而受到人们的喜爱。这种粉红色可能是由于含钛所造成的。蔷薇石英的抛光面可以呈现出星状光芒，这是由于它含有细针状金红石包裹体的缘故。蔷薇石英可称之为粉晶、玫瑰水晶、芙蓉石。硬度7级，比重2.65。其化学成分主要为二氧化硅，透明或半透明。断口贝壳状，呈油脂光泽。一般为粉红色。芙蓉石以颜色浓艳，质地纯净，水头足，无棉绺者为最好。而颜色浅谈、质地混杂、有棉、有绺、有石筋者均属不佳。芙蓉石，质地匀润，半透明者，可以磨出较为清晰的六射星光来。'),(21,'红纹石(菱锰矿)','菱锰矿最早发现于阿根廷，因而有“阿根廷石”的名称。优美的色泽使之有“印加玫瑰”的别名。英文名称“Rhodochrosite”来自希腊语“rhodon”和“chrosis”，寓意矿物的玫瑰色特征。商业名称为红纹石。'),(22,'蓝宝石','蓝宝石（Sapphire）是除红宝石之外的刚玉宝石的通称，主要成分是氧化铝（Al₂O₃）。蓝宝石可以有粉红、黄、绿、白等颜色，甚至在同一颗石有多种颜色，其中蓝色的蓝宝石是由于其中混有少量钛（Ti）和铁（Fe）杂质所致。蓝宝石最大的特点是颜色不均，可见平行六方柱面排列的，深浅不同的平直色带和生长纹。聚片双晶发育，常见百叶窗式双晶纹。裂理多沿双晶面裂开。二色性强。世界不同产地的蓝宝石除上述共同的特点之外，亦因产地不同各具特色。天然蓝宝石在泰国、斯里兰卡、马达加斯加、老挝、柬埔寨、中国（山东昌乐、海南、重庆江津的石笋山）均有发现。1980年代在中国东部沿海一带的玄武岩中，相继发现了许多蓝宝石矿床。'),(23,'坦桑石','坦桑石也称黝帘石（saualpite，Zoisite），为硅酸盐矿物。早期被用作装饰材料，自1967年在坦桑尼亚发现了蓝紫色的透明晶体之后，它在宝石业中的地位日益提高。为纪念当时新成立的坦桑尼亚共和国，被命名为坦桑石（Tanzanite）,它在国外还被称为丹泉石。坦桑石最初被误以为是橄榄石，随后又被误以为是蓝线石。最终被一个坦桑尼亚的地质学家Lan McCloud正确定名。这是一种世界公认的新兴宝石。这种宝石首次于1967年在赤道雪山脚下的阿鲁沙地区被发现。1969年，蒂凡尼（Tiffany）公司把它推向了国际珠宝市场。'),(24,'磷铝石','磷铝石（variscite ）是一种磷酸盐矿物，它是由富含磷酸盐矿物的水与含有铝的岩石起化学反应而产生的。磷铝石一般呈绿色，可作为非常好看的石料饰面或当作次要宝石。磷铝石具有多孔的特点，可以用来吸附油脂。磷铝石颜色范围广泛，从白色、粉红、绿色和蓝色到金黄色，以及更罕见的无色。铝可部分地被铬和铁置换，是该矿物呈绿色的原因。亮绿至绿蓝色的磷铝石块体被用作雕刻或装饰材料。透明以至半透明的大型晶体也存在，但由于硬度低，仅为收藏者切磨。此外，还发现解理佳或密实的矿块。磷铝石有“激励宝石“之称，可以鼓励人们积极的面对生活，给人以希望和勇气。磷铝石作为宝石材料的历史悠久，主要流传于西方国家。宝石级磷铝石的主要产地有美国犹他州和内华达州、澳大利亚昆士兰、捷克等。市场所见“美国苹果绿”玉石品种也多为美国产绿色磷铝石。'),(25,'锆石','锆石（英文名称：zircon）又称锆英石，日本称之为“风信子石”，它是十二月生辰石，象征成功。它是一种硅酸盐矿物，化学式是ZrSiO₄。它是提炼金属锆的主要矿石，含有Hf、Th、U、TR等混入物。锆石广泛存在于酸性火成岩，也产于变质岩和其他沉积物中。锆石的化学性质很稳定，所以在河流的砂砾中也可以见到宝石级的锆石。锆石有很多种，不同的锆石会有不同的颜色，如黑、白、橙、褐、绿或无色透明等等。经过切割后的宝石级锆石很像是钻石。锆石过去还被叫作锆英石。'),(26,'变石(紫翠玉)','变石的英文名称为Alexandrite，俄文名称“Александрит”，音译为“亚历山大石”。变石也称亚历山大石，古称紫翠玉。据传说1830年，在俄国沙皇亚历山大二世生日那一天，发现了变石，故将这种宝石命名为“亚历山大石”。由于它具有在阳光下呈绿色，在烛光和白炽灯下呈红色的变色效应，许多诗人赞誉变石为“白昼里的祖母绿，黑夜里的红宝石”。据说1830年变石首次被发现于俄罗斯乌拉尔一个开采祖母绿的矿山上，矿工们将这种有变色效应的宝石献给了俄国皇太子亚历山大二世，在他21岁生日的时候，将这种新发现的奇异宝石镶在了自己的王冠上，并赐名为“亚历山大石”，意为变石。变石和猫眼一样，在矿物学中属于金绿宝石，只是由于具有不同的光学特点而成为两种不同的宝石。');
/*!40000 ALTER TABLE `gems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rec_gem`
--

DROP TABLE IF EXISTS `rec_gem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rec_gem` (
  `user_id` int DEFAULT NULL,
  `gem_content` text,
  `gem_img_url` varchar(255) DEFAULT NULL,
  `gem_name` varchar(100) DEFAULT NULL,
  `rec_time` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rec_gem`
--

LOCK TABLES `rec_gem` WRITE;
/*!40000 ALTER TABLE `rec_gem` DISABLE KEYS */;
INSERT INTO `rec_gem` VALUES (NULL,'菱锰矿最早发现于阿根廷，因而有“阿根廷石”的名称。优美的色泽使之有“印加玫瑰”的别名。英文名称“Rhodochrosite”来自希腊语“rhodon”和“chrosis”，寓意矿物的玫瑰色特征。商业名称为红纹石。','http://127.0.0.1:9200/IMG/Rec_gem_img/rhodochrosite_0.jpg','红纹石（菱锰矿）','2024-05-11'),(NULL,'红玛瑙是常见的硅氧矿物，它基本上就是石英，很多性质都与石英相同。红玛瑙在矿物学上还属于玉髓的变种。\r\n红玛瑙是一种低级别的宝石，但人类将它加工成工艺品的历史却很久了。红色的玛瑙，即古代的赤玉。红玛瑙中有东红玛瑙和西红玛瑙之分。前者是指天然含铁的玛瑙经加热处理后形成的红玛瑙，又称“烧红玛瑙”，其中包括鲜红色，橙红色。东红玛瑙一名，因早年这种玛瑙来自日本，故而得名。后者是指天然的红色玛瑙，其中有暗红色者，也有艳红色者，中国古代出土的玛瑙均属西红玛瑙，这玛瑙多来自西方，故而得名。当红玛瑙有细纹带构造时，则属于缠丝玛瑙中的品种。中国市场上产的蓝玛瑙制品，多半由人工染色而成，其色浓均，易与天然者区分。玛瑙也是水晶家族成员，它是隐晶族，它的六面晶状非常细小，必须通过显微镜才能看得清。按颜色和纹路玛瑙可分为条纹玛瑙、缠丝玛瑙、苔藓玛瑙、角砾玛瑙、豹纹玛瑙、水玛瑙、苔纹玛瑙、红玛瑙、缟玛瑙等。红玛瑙的颜色多种多样，而且常常是呈多种颜色的。一般为半透明到不透明。有的红玛瑙里面还有水，叫水胆玛瑙。这样的玛瑙摇动时还能发出水声，很是奇特。','http://127.0.0.1:9200/IMG/Rec_gem_img/carnelian_0.jpg','红玛瑙','2024-05-11'),(NULL,'赛黄晶（Danburite）英文名称来自发现地美国康涅狄格州的丹伯里（Danbury）。英国伦敦大英自然历史博物馆收藏一粒产自于缅甸的黄色阶梯刻面型的赛黄晶，重138.61ct；美国华盛顿史密斯博物馆一粒缅甸产的黄色赛黄金，重18.4ct；日本产的一粒无色赛黄晶，重7.9ct。赛黄晶之所以叫赛黄晶，是因为它的成分跟黄晶非常相似，但是毕竟是略有区别，所以中文翻译成了赛黄晶。','http://127.0.0.1:9200/IMG/Rec_gem_img/danburite_0.jpg','赛黄晶','2024-05-11'),(NULL,'蓝宝石（Sapphire）是除红宝石之外的刚玉宝石的通称，主要成分是氧化铝（Al₂O₃）。蓝宝石可以有粉红、黄、绿、白等颜色，甚至在同一颗石有多种颜色，其中蓝色的蓝宝石是由于其中混有少量钛（Ti）和铁（Fe）杂质所致。蓝宝石最大的特点是颜色不均，可见平行六方柱面排列的，深浅不同的平直色带和生长纹。聚片双晶发育，常见百叶窗式双晶纹。裂理多沿双晶面裂开。二色性强。世界不同产地的蓝宝石除上述共同的特点之外，亦因产地不同各具特色。天然蓝宝石在泰国、斯里兰卡、马达加斯加、老挝、柬埔寨、中国（山东昌乐、海南、重庆江津的石笋山）均有发现。1980年代在中国东部沿海一带的玄武岩中，相继发现了许多蓝宝石矿床。','http://127.0.0.1:9200/IMG/Rec_gem_img/sapphire blue_0.jpg','蓝宝石','2024-05-11'),(3,'蓝宝石（Sapphire）是除红宝石之外的刚玉宝石的通称，主要成分是氧化铝（Al₂O₃）。蓝宝石可以有粉红、黄、绿、白等颜色，甚至在同一颗石有多种颜色，其中蓝色的蓝宝石是由于其中混有少量钛（Ti）和铁（Fe）杂质所致。蓝宝石最大的特点是颜色不均，可见平行六方柱面排列的，深浅不同的平直色带和生长纹。聚片双晶发育，常见百叶窗式双晶纹。裂理多沿双晶面裂开。二色性强。世界不同产地的蓝宝石除上述共同的特点之外，亦因产地不同各具特色。天然蓝宝石在泰国、斯里兰卡、马达加斯加、老挝、柬埔寨、中国（山东昌乐、海南、重庆江津的石笋山）均有发现。1980年代在中国东部沿海一带的玄武岩中，相继发现了许多蓝宝石矿床。','http://127.0.0.1:9200/IMG/Rec_gem_img/tanzanite_0.jpg','蓝宝石','2024-05-12'),(3,'蓝宝石（Sapphire）是除红宝石之外的刚玉宝石的通称，主要成分是氧化铝（Al₂O₃）。蓝宝石可以有粉红、黄、绿、白等颜色，甚至在同一颗石有多种颜色，其中蓝色的蓝宝石是由于其中混有少量钛（Ti）和铁（Fe）杂质所致。蓝宝石最大的特点是颜色不均，可见平行六方柱面排列的，深浅不同的平直色带和生长纹。聚片双晶发育，常见百叶窗式双晶纹。裂理多沿双晶面裂开。二色性强。世界不同产地的蓝宝石除上述共同的特点之外，亦因产地不同各具特色。天然蓝宝石在泰国、斯里兰卡、马达加斯加、老挝、柬埔寨、中国（山东昌乐、海南、重庆江津的石笋山）均有发现。1980年代在中国东部沿海一带的玄武岩中，相继发现了许多蓝宝石矿床。','http://127.0.0.1:9200/IMG/Rec_gem_img/sapphire blue_0.jpg','蓝宝石','2024-05-12'),(3,'珍珠，又称蚌珠、濂珠，是一种古老的有机宝石，主要产于珍珠贝类和珠母贝类软体动物体内。珍珠为贝类内分泌作用而生成的含碳酸钙的矿物珠粒，由大量微小的文石晶体集合而成的。种类丰富，形状各异，色彩斑斓。根据地质学和考古学的研究证明，在两亿年前，地球上就已经有了珍珠 。珍珠药用在中国已有2000余年历史。在国际宝石界还将珍珠列为六月生辰的幸运石，结婚十三周年和三十周年的纪念石。具有瑰丽色彩和高雅气质的珍珠，象征着健康、纯洁、富有和幸福，自古以来为人们所喜爱。珍珠分为淡水珍珠和海水珍珠两种。中国的淡水珠主要养殖区在诸暨、常德、苏州、江西、湖北、安徽。珍珠有白色系、红色系、黄色系、深色系和杂色系五种，多数不透明。','http://127.0.0.1:9200/IMG/Rec_gem_img/pearl_0.jpg','珍珠','2024-05-12'),(3,'蓝宝石（Sapphire）是除红宝石之外的刚玉宝石的通称，主要成分是氧化铝（Al₂O₃）。蓝宝石可以有粉红、黄、绿、白等颜色，甚至在同一颗石有多种颜色，其中蓝色的蓝宝石是由于其中混有少量钛（Ti）和铁（Fe）杂质所致。蓝宝石最大的特点是颜色不均，可见平行六方柱面排列的，深浅不同的平直色带和生长纹。聚片双晶发育，常见百叶窗式双晶纹。裂理多沿双晶面裂开。二色性强。世界不同产地的蓝宝石除上述共同的特点之外，亦因产地不同各具特色。天然蓝宝石在泰国、斯里兰卡、马达加斯加、老挝、柬埔寨、中国（山东昌乐、海南、重庆江津的石笋山）均有发现。1980年代在中国东部沿海一带的玄武岩中，相继发现了许多蓝宝石矿床。','http://127.0.0.1:9200/IMG/Rec_gem_img/sapphire blue_22.jpg','蓝宝石','2024-05-12'),(3,'堇青石（Cordierite或Iolite，Dichroite）来自希腊文中的Violet，寓意其呈紫罗兰色，Dichroite来自希腊文“双色”，指宝石具有很强的多色性。由于堇青石有像蓝宝石一样的蓝色，有人称之为“水蓝宝石”（water sapphire）。堇青石是一种硅酸盐矿物，通常具有浅蓝或浅紫色，玻璃光泽，透明至半透明 。堇青石还具有一个特点，具有明显的多色性（三色性），在不同的方向上发出不同颜色的光线。品优色美的堇青石被当作宝石，除此以外，堇青石由于耐火性好、受热膨胀率低，普遍作为汽车净化器的蜂窝状载体材料来使用。堇青石产于片岩、片麻岩及蚀变火成岩中。人们因此也称堇青石为二色石。人工可以合成镁堇青石，用于耐火材料。堇青石原石一般重4-5克拉，更大的也有发现。堇青石一般切割成传统的形状，最受欢迎的颜色是蓝紫色。','http://127.0.0.1:9200/IMG/Rec_gem_img/iolite_35.jpg','堇青石','2024-05-12'),(3,'红榴石又称红石榴石，是石榴石中铝榴石系列中的镁铝榴石，属于常见的石榴石品种。红石榴石的红色可让人拥有难以抗拒的魅力，招来幸福与永恒的爱情，增加自信，是女性之石。产于亚利桑那、南非、阿根廷、澳大利亚、巴西、缅甸、苏格兰、瑞士及坦桑尼亚、莫桑比克。','http://127.0.0.1:9200/IMG/Rec_gem_img/garnet red_38.jpg','红石榴石','2024-05-12'),(3,'铁铝榴石（Almandine ）名称源自小亚细亚的阿拉班达（Alabanda），为古代切割和加工石榴子石的地方。铁铝榴石通常呈暗红色至棕红色的半透明状晶体，部份属贵重者，作深红透明状，是宝石界中最常见的深红色石榴子石，称为贵榴石，有时光凭外表，很难与镁铝榴石区分。宝石级铁铝榴石常见的颜色以红色色调为主，包括褐红色、粉红、橙红等。铁铝榴石为均质体矿物，但在偏光镜下很多铁铝榴石可有异常消光。铁铝榴石含有相当多的针状包裹体，在其切割琢磨呈戒面时，会有星状出现，称为星彩铁铝榴石（StarAlmandine）。铁铝榴石是中温和高温的变质相矿物，主要产于区域变质岩、花岗岩和一些火成岩中。','http://127.0.0.1:9200/IMG/Rec_gem_img/almandine_12.jpg','铁铝榴石','2024-05-12'),(7,'铁铝榴石（Almandine ）名称源自小亚细亚的阿拉班达（Alabanda），为古代切割和加工石榴子石的地方。铁铝榴石通常呈暗红色至棕红色的半透明状晶体，部份属贵重者，作深红透明状，是宝石界中最常见的深红色石榴子石，称为贵榴石，有时光凭外表，很难与镁铝榴石区分。宝石级铁铝榴石常见的颜色以红色色调为主，包括褐红色、粉红、橙红等。铁铝榴石为均质体矿物，但在偏光镜下很多铁铝榴石可有异常消光。铁铝榴石含有相当多的针状包裹体，在其切割琢磨呈戒面时，会有星状出现，称为星彩铁铝榴石（StarAlmandine）。铁铝榴石是中温和高温的变质相矿物，主要产于区域变质岩、花岗岩和一些火成岩中。','http://127.0.0.1:9200/IMG/Rec_gem_img/almandine_10.jpg','铁铝榴石','2024-05-29 16:54:07'),(7,'铁铝榴石（Almandine ）名称源自小亚细亚的阿拉班达（Alabanda），为古代切割和加工石榴子石的地方。铁铝榴石通常呈暗红色至棕红色的半透明状晶体，部份属贵重者，作深红透明状，是宝石界中最常见的深红色石榴子石，称为贵榴石，有时光凭外表，很难与镁铝榴石区分。宝石级铁铝榴石常见的颜色以红色色调为主，包括褐红色、粉红、橙红等。铁铝榴石为均质体矿物，但在偏光镜下很多铁铝榴石可有异常消光。铁铝榴石含有相当多的针状包裹体，在其切割琢磨呈戒面时，会有星状出现，称为星彩铁铝榴石（StarAlmandine）。铁铝榴石是中温和高温的变质相矿物，主要产于区域变质岩、花岗岩和一些火成岩中。','http://127.0.0.1:9200/IMG/Rec_gem_img/almandine_7.jpg','铁铝榴石','2024-05-30 11:55:29');
/*!40000 ALTER TABLE `rec_gem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `product_id` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `seller_email` varchar(255) DEFAULT NULL,
  `seller_phone` varchar(50) DEFAULT NULL,
  `shipping_address` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `product_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES ('100','金绿柱石戒指','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:21:44'),('gem_101','堇青石项链','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:25:46'),('gem_102','紫翠玉戒指','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:27:23'),('gem_103','蓝宝石耳环','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:28:50'),('gem_104','皓石扳指','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:30:17'),('gem_105','蓝宝石水滴型项链','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:31:40'),('gem_106','蓝锥矿晶项链','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:33:15'),('gem_107','萤石耳环','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:34:35'),('gem_108','钻石戒指','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:35:59'),('gem_109','紫翠玉锥形项链','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:37:56'),('gem_110','红石榴石戒指','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:39:19'),('gem_111','皓石戒指','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:40:42'),('gem_112','堇青石手链','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:42:03'),('gem_113','钻石花型手链','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:42:58'),('gem_114','蓝宝石方形镶嵌戒指','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:43:41'),('gem_115','钻石花型项链','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:44:40');
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller_copy`
--

DROP TABLE IF EXISTS `seller_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller_copy` (
  `product_id` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `seller_email` varchar(255) DEFAULT NULL,
  `seller_phone` varchar(50) DEFAULT NULL,
  `shipping_address` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `product_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller_copy`
--

LOCK TABLES `seller_copy` WRITE;
/*!40000 ALTER TABLE `seller_copy` DISABLE KEYS */;
INSERT INTO `seller_copy` VALUES ('100','蓝宝石戒指','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 08:02:52'),('101','紫色皓石','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 08:11:24'),('102','蔷薇石英','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 08:16:09'),('103','堇青石','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 08:50:38'),('104','萤石','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 08:52:41'),('105','紫翠玉','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 09:40:19'),('106','翡翠石','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 09:42:18'),('107','猫眼石','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 09:43:38'),('108','钻石','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 09:44:53'),('109','紫锂辉石','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 09:46:16'),('110','石榴石','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 09:47:48'),('111','珍珠','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 09:49:07'),('112','孔雀石','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 09:50:13'),('113','赛黄晶','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 09:51:45'),('114','红玛瑙','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 09:55:46'),('115','磷铝石','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:09:12'),('116','黑玛瑙','1635509014@qq.com','15078321222','梧州学院a12',7,'2024-05-30 10:12:12');
/*!40000 ALTER TABLE `seller_copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop`
--

DROP TABLE IF EXISTS `shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop` (
  `product_id` int NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` varchar(255) DEFAULT NULL,
  `product_imageSrc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `product_description` text,
  `product_imageSrc2` varchar(255) DEFAULT NULL,
  `product_imageSrc1` varchar(255) DEFAULT NULL,
  `product_description1` text,
  `user_id` int DEFAULT NULL,
  `product_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop`
--

LOCK TABLES `shop` WRITE;
/*!40000 ALTER TABLE `shop` DISABLE KEYS */;
INSERT INTO `shop` VALUES (101,'紫色皓石','480元/克','http://127.0.0.1:9200/IMG/Product_img/kunzite_1_1717063127.jpg','紫色皓石，又称紫水晶，是一种迷人的宝石，因其深受欢迎而备受人们喜爱。它常常呈现出深紫色至浅紫色的色调，有时还带有透明度或白色的条纹。紫色皓石被广泛用于珠宝饰品的制作，如项链、戒指和手镯，展现出其高贵和优雅。除了其美丽的外观，紫色皓石还被认为具有平衡身心、提升智慧和吸引爱情的作用，因此在灵性和能量治疗领域备受推崇。','http://127.0.0.1:9200/IMG/Product_img/kunzite_1_1717063127.jpg','http://127.0.0.1:9200/IMG/Product_img/kunzite_5_1717063127.jpg',NULL,7,'2024-05-30 08:11:24'),(102,'蔷薇石英','79元/克','http://127.0.0.1:9200/IMG/Product_img/nina-plobner-yI6au5ZCmR0-unsplash_1717060425.jpg','蔷薇石英是一种罕见而迷人的宝石，以其粉红色和白色晶体结构而著称。其形成于含有钠铝硅酸盐的岩石中，因而呈现出独特的花纹，仿佛绽放的蔷薇花。蔷薇石英象征着爱与美好，被认为能够平衡情绪、增强爱情和促进心灵治愈。常被用于珠宝首饰的制作，如项链、戒指和手链，展现出其柔美和浪漫的魅力。','http://127.0.0.1:9200/IMG/Product_img/edz-norton-0FIaSHVHMdo-unsplash_1717060425.jpg','http://127.0.0.1:9200/IMG/Product_img/caleb-jack-gWy6GasRpo0-unsplash_1717060425.jpg',NULL,7,'2024-05-30 08:16:09'),(104,'萤石','25.2元/克','http://127.0.0.1:9200/IMG/Product_img/clido-delua-5tYc5-gSrD8-unsplash_1717059161.jpg','萤石是一种独特而神奇的宝石，因其在黑暗中能够发出独特的荧光而得名。它的颜色多样，包括透明、浅黄、粉红、蓝色等，且常常呈现出带有斑点或条纹的美丽图案。萤石具有治愈和净化能量的传说，被认为能够平衡情绪、提升洞察力和促进内心的平静。它常被用于制作吊坠、耳环和戒指等珠宝饰品，展现出其独特的魅力和美感。','http://127.0.0.1:9200/IMG/Product_img/dulcey-lima-qsVdNQubLrQ-unsplash_1717059161.jpg','http://127.0.0.1:9200/IMG/Product_img/irina-iacob-Q5SEqVCmmF8-unsplash_1717059161.jpg',NULL,7,'2024-05-30 08:52:41'),(105,'紫翠玉','0.5元/克','http://127.0.0.1:9200/IMG/Product_img/alexandrite_5_1717062019.jpg','紫翠玉是一种罕见而珍贵的宝石，它结合了紫晶和翠玉的特点。其色泽如同夜幕中的紫色，散发着神秘的光芒，又带有翠玉的清新气息。紫翠玉被视为吉祥之石，具有平衡身心、提升智慧和招财聚福的功效。它常被用于珠宝饰品的制作，如吊坠、耳环和手镯，展现出其独特的魅力和珍贵的价值。紫翠玉不仅是一种宝石，更是一种象征着吉祥和美好的文化符号。','http://127.0.0.1:9200/IMG/Product_img/alexandrite_9_1717062019.jpg','http://127.0.0.1:9200/IMG/Product_img/alexandrite_8_1717062019.jpg',NULL,7,'2024-05-30 09:40:19'),(106,'翡翠石','20000元/克','http://127.0.0.1:9200/IMG/Product_img/emerald_9_1717062137.jpg','翡翠石是一种古老而珍贵的宝石，因其独特的颜色和光泽而备受珍藏。它常见的颜色有浓绿、浅绿、深绿等，还有罕见的紫、红和白色。翡翠石在古代被视为幸运之石，象征着长寿、富贵和安康。它被广泛用于珠宝饰品的制作，如吊坠、手镯和戒指，展现出其高雅和珍贵的特质。翡翠石不仅是一种宝石，更是一种承载着文化和历史的珍贵瑰宝。','http://127.0.0.1:9200/IMG/Product_img/emerald_15_1717062137.jpg','http://127.0.0.1:9200/IMG/Product_img/emerald_12_1717062137.jpg',NULL,7,'2024-05-30 09:42:17'),(107,'猫眼石','0.33元/克','http://127.0.0.1:9200/IMG/Product_img/fluorite_6_1717062218.jpg','猫眼石是一种神秘而迷人的宝石，以其独特的光学效应而闻名。它在光线照射下会呈现出一条明亮的光带，犹如猫眼睛般闪烁。这种效应被称为“猫眼效应”或“猫眼光”。猫眼石常见的颜色有金黄色、绿色、蓝色和棕色等。它被认为具有保护、平衡和引导能量的功效，常被用于佛教护身符和珠宝饰品的制作。猫眼石不仅具有美丽的外观，更是一种富有灵性和神秘色彩的宝石。','http://127.0.0.1:9200/IMG/Product_img/fluorite_9_1717062218.jpg','http://127.0.0.1:9200/IMG/Product_img/fluorite_7_1717062218.jpg',NULL,7,'2024-05-30 09:43:38'),(108,'钻石','40000元/克','http://127.0.0.1:9200/IMG/Product_img/diamond_1_1717062293.jpg','钻石是地球上最硬、最耐磨的天然物质，也是最受欢迎和珍贵的宝石之一。它由碳元素在高压、高温下形成，具有卓越的抛光和光学性质。钻石通常呈现出透明或略带色彩的外观，但也有被加工成各种彩色的“彩钻”。钻石常被用于珠宝饰品，如戒指、项链和耳环，因其独特的光彩和永恒的价值而备受追捧。除了美丽外观，钻石还象征着爱情、承诺和永恒，成为珠宝界中的至高之物。','http://127.0.0.1:9200/IMG/Product_img/diamond_6_1717062293.jpg','http://127.0.0.1:9200/IMG/Product_img/diamond_2_1717062293.jpg',NULL,7,'2024-05-30 09:44:53'),(109,'紫锂辉石','690元/克','http://127.0.0.1:9200/IMG/Product_img/iolite_7_1717062376.jpg','紫锂辉石是一种稀有且珍贵的宝石，其名字源自于其紫色的颜色和含有锂的成分。它通常呈现出深紫色至浅紫色的外观，有时也带有灰色、粉红色或蓝色的色调。紫锂辉石具有独特的透明度和光泽，常常被用于珠宝饰品的制作，如吊坠、戒指和耳环。除了其美丽的外观，紫锂辉石还被认为具有平衡情绪、提升洞察力和增强直觉的作用，因此在灵性和能量治疗领域也备受推崇。','http://127.0.0.1:9200/IMG/Product_img/iolite_10_1717062376.jpg','http://127.0.0.1:9200/IMG/Product_img/iolite_9_1717062376.jpg',NULL,7,'2024-05-30 09:46:16'),(110,'石榴石','51元/克','http://127.0.0.1:9200/IMG/Product_img/garnet red_1_1717062468.jpg','石榴石是一种迷人的宝石，其色彩丰富多变，包括红色、橙色、绿色和紫色等。它因形似石榴果籽而得名，散发出独特的光泽和色彩。石榴石被视为幸运之石，象征着热情、活力和成功。在古代，它被认为具有驱邪、保平安的作用。常被用于珠宝首饰的制作，如戒指、耳环和项链，展现出其华丽和高雅的气质。','http://127.0.0.1:9200/IMG/Product_img/garnet red_5_1717062468.jpg','http://127.0.0.1:9200/IMG/Product_img/garnet red_2_1717062468.jpg',NULL,7,'2024-05-30 09:47:48'),(111,'珍珠','10000元/克','http://127.0.0.1:9200/IMG/Product_img/pearl_2_1717062547.jpg','珍珠是一种由软体动物，如牡蛎和贝类，分泌的珍贵宝石。它形成于这些生物体内的外壳内，通常是作为一种对外部刺激的反应，比如沙粒或寄生虫。珍珠的颜色和大小取决于生长环境和物种，有白色、粉色、黑色等各种色彩。其光泽独特迷人，有时带有细微的光泽。珍珠被广泛用于珠宝饰品，如项链、耳环和手镯，因其优雅和高贵而备受推崇。它也象征着纯洁、优雅和财富，是一种古老而珍贵的宝石。','http://127.0.0.1:9200/IMG/Product_img/pearl_8_1717062547.jpg','http://127.0.0.1:9200/IMG/Product_img/pearl_6_1717062547.jpg',NULL,7,'2024-05-30 09:49:07'),(112,'孔雀石','0.99元/克','http://127.0.0.1:9200/IMG/Product_img/malachite_7_1717062613.jpg','孔雀石，也称翡翠矿，是一种矿物宝石，属于硅酸盐类。其颜色多样，从深绿色到浅绿色，甚至带有蓝色和黄色。孔雀石常见的颜色是浓绿色，有时会呈现出独特的斑纹和纹理。它因其色彩鲜艳和光泽而备受喜爱，并被广泛用于珠宝饰品的制作。孔雀石被认为具有吸收负能量、平衡身心和增强直觉的功效，因此在矿石疗法和能量治疗中被广泛使用。这种宝石也是6月的传统出生石，象征着和平与幸福。','http://127.0.0.1:9200/IMG/Product_img/malachite_14_1717062613.jpg','http://127.0.0.1:9200/IMG/Product_img/malachite_10_1717062613.jpg',NULL,7,'2024-05-30 09:50:13'),(113,'赛黄晶','311元/克','http://127.0.0.1:9200/IMG/Product_img/quartz beer_0_1717062705.jpg','赛黄晶，也称黄玉，是一种稀有的宝石，其色泽从淡黄到金黄不等，有时还带有绿色或棕色的斑纹。赛黄晶具有独特的透明度和光泽，常常被用于珠宝饰品的制作，如项链、耳环和戒指。它被认为具有平衡身心、提升智慧和吸引财富的功效，因此在矿石疗法和灵性实践中备受推崇。赛黄晶也被视为一种幸运石，能够带来好运和积极的能量。','http://127.0.0.1:9200/IMG/Product_img/quartz beer_2_1717062705.jpg','http://127.0.0.1:9200/IMG/Product_img/quartz beer_1_1717062705.jpg',NULL,7,'2024-05-30 09:51:45'),(114,'红玛瑙','0.54元/克','http://127.0.0.1:9200/IMG/Product_img/hessonite_4_1717062946.jpg','红玛瑙是一种美丽而珍贵的宝石，其色泽呈现出深红色至橙红色。它的颜色由于富含的铁氧化物而产生，光泽独特，散发出暖暖的光芒。红玛瑙常被用于珠宝饰品的制作，如吊坠、戒指和手镯，展现出其独特的魅力和高贵的气质。除了其美丽的外观，红玛瑙也被认为具有平衡身心、增强勇气和保护身体的功效。因此，在宗教、灵性和能量治疗领域中也备受推崇。','http://127.0.0.1:9200/IMG/Product_img/hessonite_8_1717062946.jpg','http://127.0.0.1:9200/IMG/Product_img/hessonite_5_1717062946.jpg',NULL,7,'2024-05-30 09:55:46'),(115,'磷铝石','50.7元/克','http://127.0.0.1:9200/IMG/Product_img/variscite_4_1717063752.jpg','磷铝石，又称为磷灰石，是一种矿物，属于正长石类。它的主要成分是磷酸盐和铝。磷铝石的颜色通常为白色、灰色或淡黄色，有时也会呈现出深一些的蓝色、绿色或红色。它具有玻璃光泽和透明至半透明的特性。磷铝石广泛分布于地壳中的火成岩和变质岩中，也常见于沉积岩中。在工业上，磷铝石常被用作磷肥的原料，同时也在化工、冶金和建材等领域有着重要的应用。','http://127.0.0.1:9200/IMG/Product_img/variscite_7_1717063752.jpg','http://127.0.0.1:9200/IMG/Product_img/variscite_5_1717063752.jpg',NULL,7,'2024-05-30 10:09:12'),(116,'黑玛瑙','14.8元/克','http://127.0.0.1:9200/IMG/Product_img/onyx black_2_1717063932.jpg','黑玛瑙是一种黑色的玛瑙宝石，它的颜色可能带有深褐色、灰色或深紫色的变种。黑玛瑙通常具有平滑的表面和良好的光泽，有时也会呈现出微微的透明度。这种宝石常被用于珠宝饰品的制作，如项链、手镯和戒指。黑玛瑙在灵性和能量治疗中也备受青睐，被认为能够平衡身心、保护能量、驱邪和提升内在力量。','http://127.0.0.1:9200/IMG/Product_img/onyx black_5_1717063932.jpg','http://127.0.0.1:9200/IMG/Product_img/onyx black_4_1717063932.jpg',NULL,7,'2024-05-30 10:12:12');
/*!40000 ALTER TABLE `shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_copy`
--

DROP TABLE IF EXISTS `shop_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_copy` (
  `product_id` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` varchar(255) DEFAULT NULL,
  `product_imageSrc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `product_description` text,
  `product_imageSrc2` varchar(255) DEFAULT NULL,
  `product_imageSrc1` varchar(255) DEFAULT NULL,
  `product_description1` text,
  `user_id` int DEFAULT NULL,
  `product_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_copy`
--

LOCK TABLES `shop_copy` WRITE;
/*!40000 ALTER TABLE `shop_copy` DISABLE KEYS */;
INSERT INTO `shop_copy` VALUES ('gem_100','金绿柱石戒指','14800.0元','http://127.0.0.1:9200/IMG/Product_img/gary-yost-2YZqPK0ieCQ-unsplash_1717064504.jpg','金绿柱石戒指是一种珍贵的宝石戒指，以其独特的金黄色和绿色柱状结构而闻名。金绿柱石，又称绿柱石，是一种矿物，属于硅酸盐类，其颜色由铁元素引起。这种宝石戒指通常呈现出金黄色和绿色相间的色彩，独具异彩。金绿柱石戒指不仅具有美丽的外观，还象征着繁荣、幸福和希望，常被用作装饰品和护身符。由于其稀有性和独特性，金绿柱石戒指在珠宝市场上备受追捧。','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-5IBDTVyjcJs-unsplash_1717064504.jpg','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-2Vsyrv3N-0I-unsplash_1717064504.jpg',NULL,7,'2024-05-30 10:21:44'),('gem_101','堇青石项链','4000.0元','http://127.0.0.1:9200/IMG/Product_img/andres-vera-CmmYT6Mm948-unsplash_1717064746.jpg','堇青石项链是一种优雅而迷人的珠宝首饰，以其特有的淡紫色堇青石为主要装饰材料。堇青石，又称紫水晶，是一种半宝石，常常呈现出淡淡的紫色，散发出神秘而优雅的气息。这种项链通常采用精致的设计和工艺制成，将堇青石镶嵌在项链的吊坠或链条上，展现出其独特的美感。堇青石项链不仅适合日常佩戴，也是各种特殊场合的完美配饰，为穿着者增添魅力和风采。','http://127.0.0.1:9200/IMG/Product_img/amirreza-tavassoli-IFtADMCp9B0-unsplash_1717064746.jpg','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-2Vsyrv3N-0I-unsplash_1717064746.jpg',NULL,7,'2024-05-30 10:25:46'),('gem_102','紫翠玉戒指','7660.0元','http://127.0.0.1:9200/IMG/Product_img/anthony-calandrelli-s9al8aIiVNU-unsplash_1717064843.jpg','紫翠玉戒指是一种精致而珍贵的珠宝首饰，以其罕见的紫色翠玉为主要装饰材料。紫翠玉，又称紫色翡翠，是一种罕见的宝石，其颜色呈现出深紫色至浅紫色的变化，常常具有独特的光泽和纹理。这种戒指通常采用优雅的设计和精湛的工艺制成，将紫翠玉镶嵌在戒指的主体上，展现出其高贵和优雅。紫翠玉戒指不仅是一种珍贵的首饰，也是一种象征着吉祥和幸福的文化符号，适合佩戴于各种特殊场合，彰显个人品味和魅力。','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-5IBDTVyjcJs-unsplash_1717064843.jpg','http://127.0.0.1:9200/IMG/Product_img/ava-everett-bNOTaFYWwkg-unsplash_1717064843.jpg',NULL,7,'2024-05-30 10:27:23'),('gem_103','蓝宝石耳环','17669.0元','http://127.0.0.1:9200/IMG/Product_img/arteum-ro-VJZdxfvFGuo-unsplash_1717064930.jpg','蓝宝石耳环是一种优雅而精致的珠宝首饰，以蓝宝石为主要装饰材料。蓝宝石是一种珍贵的宝石，具有深蓝色至浅蓝色的色调，常常具有迷人的光泽和透明度。这种耳环通常采用精美的设计和精湛的工艺制成，将蓝宝石镶嵌在耳环的吊坠或挂件上，展现出其高贵和优雅。蓝宝石耳环不仅适合日常佩戴，也是各种特殊场合的完美配饰，为穿戴者增添魅力和品位。','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-5IBDTVyjcJs-unsplash_1717064930.jpg','http://127.0.0.1:9200/IMG/Product_img/ava-everett-bNOTaFYWwkg-unsplash_1717064930.jpg',NULL,7,'2024-05-30 10:28:50'),('gem_104','皓石扳指','7707.0元','http://127.0.0.1:9200/IMG/Product_img/gary-yost-Pxexdj3Q09g-unsplash_1717065017.jpg','皓石扳指是一种华丽而典雅的珠宝首饰，以皓石为主要装饰材料。皓石，也称为白水晶，是一种透明无色的宝石，具有高度的透明度和光泽。这种扳指通常采用精致的设计和精湛的工艺制成，将皓石镶嵌在扳指的指环或顶端，展现出其纯净和高贵。皓石扳指不仅适合日常佩戴，也是各种特殊场合的完美配饰，为穿戴者增添独特的魅力和品位。','http://127.0.0.1:9200/IMG/Product_img/dulcey-lima-qsVdNQubLrQ-unsplash_1717065017.jpg','http://127.0.0.1:9200/IMG/Product_img/dan-farrell-qayNP9ccw9E-unsplash_1717065017.jpg',NULL,7,'2024-05-30 10:30:17'),('gem_105','蓝宝石水滴型项链','88888.0元','http://127.0.0.1:9200/IMG/Product_img/james-kovin-3AviqckLHxU-unsplash_1717065100.jpg','蓝宝石水滴型项链是一种优雅而迷人的珠宝首饰，以蓝宝石为主要装饰材料，呈现出水滴状的设计。蓝宝石是一种珍贵的宝石，其深蓝色和透明度令人惊叹，常被视为贵族珠宝中的佼佼者。这款项链通常由一颗水滴形蓝宝石吊坠和精致的链条组成，展现出其高贵和典雅。蓝宝石水滴型项链不仅适合日常佩戴，也是各种特殊场合的完美配饰，为穿戴者增添独特的魅力和品位。','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-5IBDTVyjcJs-unsplash_1717065100.jpg','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-2Vsyrv3N-0I-unsplash_1717065100.jpg',NULL,7,'2024-05-30 10:31:40'),('gem_106','蓝锥矿晶项链','1400.0元','http://127.0.0.1:9200/IMG/Product_img/james-kovin-hC_ZT_V4hTE-unsplash_1717065195.jpg','蓝锥矿晶项链是一种精致而独特的珠宝首饰，以蓝锥矿晶为主要装饰材料。蓝锥矿晶是一种稀有的宝石，其颜色呈现出深蓝色至浅蓝色的变化，具有迷人的光泽和透明度。这种项链通常采用优雅的设计和工艺制成，将蓝锥矿晶镶嵌在吊坠或链条上，展现出其高贵和神秘。蓝锥矿晶项链不仅适合日常佩戴，也是各种特殊场合的完美配饰，为穿戴者增添独特的魅力和品味。','http://127.0.0.1:9200/IMG/Product_img/jason-d-VKLJ-BJlszE-unsplash_1717065195.jpg','http://127.0.0.1:9200/IMG/Product_img/jason-d-k65_6C4hu2E-unsplash_1717065195.jpg',NULL,7,'2024-05-30 10:33:15'),('gem_107','萤石耳环','3600.0元','http://127.0.0.1:9200/IMG/Product_img/jenni-miska-4Vfsfjv6GJ0-unsplash_1717065275.jpg','萤石耳环是一种迷人而独特的珠宝首饰，以萤石为主要装饰材料。萤石，也称荧光石，是一种宝石级矿物，其颜色丰富多样，包括透明、浑浊、深色和浅色等，有时还会呈现出荧光效应。这种耳环通常采用精致的设计和精湛的工艺制成，将萤石镶嵌在耳环的吊坠或挂件上，展现出其独特的光泽和色彩。萤石耳环不仅适合日常佩戴，也是各种特殊场合的完美配饰，为穿戴者增添迷人的魅力和个性。','http://127.0.0.1:9200/IMG/Product_img/amirreza-tavassoli-IFtADMCp9B0-unsplash_1717065275.jpg','http://127.0.0.1:9200/IMG/Product_img/jet-stouten-lTxwC-3G_VU-unsplash_1717065275.jpg',NULL,7,'2024-05-30 10:34:35'),('gem_108','钻石戒指','66666.0元','http://127.0.0.1:9200/IMG/Product_img/pexels-laarkstudio-7436101_1717065359.jpg','钻石戒指是一种经典而珍贵的珠宝首饰，以钻石为主要装饰材料。钻石是地球上最硬、最耐磨的天然物质，因其独特的光泽和火彩而备受珍视。这种戒指通常采用精致的设计和精湛的工艺制成，将钻石镶嵌在戒指的主体上，展现出其高贵和优雅。钻石戒指不仅是一种珍贵的首饰，更是象征着爱情、承诺和永恒的象征，常被用作求婚戒指或结婚戒指。无论是日常佩戴还是特殊场合，钻石戒指都能彰显出穿戴者的品位和魅力。','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-5IBDTVyjcJs-unsplash_1717065359.jpg','http://127.0.0.1:9200/IMG/Product_img/amirreza-tavassoli-IFtADMCp9B0-unsplash_1717065359.jpg',NULL,7,'2024-05-30 10:35:59'),('gem_109','紫翠玉锥形项链','2346.0元','http://127.0.0.1:9200/IMG/Product_img/pexels-meum-mare-204165854-17498773_1717065476.jpg','紫翠玉锥形项链是一种别致而精致的珠宝首饰，以紫翠玉为主要装饰材料，呈现出锥形设计。紫翠玉，也称紫色翡翠，是一种罕见的宝石，其颜色呈现出深紫色至浅紫色的变化，常常具有独特的光泽和纹理。这种项链采用优雅的设计和精湛的工艺制成，将紫翠玉镶嵌在锥形的吊坠上，展现出其高贵和优雅。紫翠玉锥形项链不仅适合日常佩戴，也是各种特殊场合的完美配饰，为穿戴者增添独特的魅力和品味。','http://127.0.0.1:9200/IMG/Product_img/stephan-hinni-rAXxoYtwkwk-unsplash_1717065476.jpg','http://127.0.0.1:9200/IMG/Product_img/sergio-li-jgkkNYJVlbU-unsplash_1717065476.jpg',NULL,7,'2024-05-30 10:37:56'),('gem_110','红石榴石戒指','1500.0元','http://127.0.0.1:9200/IMG/Product_img/sabrianna-uiKSc7-NM2s-unsplash_1717065559.jpg','红石榴石戒指是一种迷人而典雅的珠宝首饰，以红色石榴石为主要装饰材料。红石榴石，也称为石榴石，是一种宝石级矿物，其颜色呈现出深红色至浅红色的变化，具有艳丽的色彩和迷人的光泽。这种戒指通常采用精致的设计和工艺制成，将红石榴石镶嵌在戒指的主体上，展现出其高贵和优雅。红石榴石戒指不仅适合日常佩戴，也是各种特殊场合的完美配饰，为穿戴者增添魅力和品味。','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-5IBDTVyjcJs-unsplash_1717065559.jpg','http://127.0.0.1:9200/IMG/Product_img/amirreza-tavassoli-IFtADMCp9B0-unsplash_1717065559.jpg',NULL,7,'2024-05-30 10:39:19'),('gem_111','皓石戒指','8656.0元','http://127.0.0.1:9200/IMG/Product_img/sabrianna-9poB8SBFveA-unsplash_1717065642.jpg','皓石戒指是一种精致而典雅的珠宝首饰，以皓石为主要装饰材料。皓石，也称为白水晶，是一种透明无色的宝石，具有高度的透明度和光泽。这种戒指通常采用精致的设计和精湛的工艺制成，将皓石镶嵌在戒指的主体上，展现出其纯净和高贵。皓石戒指不仅适合日常佩戴，也是各种特殊场合的完美配饰，为穿戴者增添独特的魅力和品味。','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-5IBDTVyjcJs-unsplash_1717065642.jpg','http://127.0.0.1:9200/IMG/Product_img/amirreza-tavassoli-IFtADMCp9B0-unsplash_1717065642.jpg',NULL,7,'2024-05-30 10:40:42'),('gem_112','堇青石手链','5444.0元','http://127.0.0.1:9200/IMG/Product_img/pexels-theplanetspeaks-10640630_1717065723.jpg','undefined','http://127.0.0.1:9200/IMG/Product_img/benjamin-lehman-lM1xdgK7FTk-unsplash_1717065723.jpg','http://127.0.0.1:9200/IMG/Product_img/benjamin-lehman-ET0qXpO-rLI-unsplash_1717065723.jpg',NULL,7,'2024-05-30 10:42:03'),('gem_113','钻石花型手链','59999.0元','http://127.0.0.1:9200/IMG/Product_img/pexels-the-glorious-studio-3584518-8398912_1717065778.jpg','undefined','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-5IBDTVyjcJs-unsplash_1717065778.jpg','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-2Vsyrv3N-0I-unsplash_1717065778.jpg',NULL,7,'2024-05-30 10:42:58'),('gem_114','蓝宝石方形镶嵌戒指','8799.0元','http://127.0.0.1:9200/IMG/Product_img/pexels-the-glorious-studio-3584518-18451699_1717065821.jpg','undefined','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-5IBDTVyjcJs-unsplash_1717065821.jpg','http://127.0.0.1:9200/IMG/Product_img/amirreza-tavassoli-IFtADMCp9B0-unsplash_1717065821.jpg',NULL,7,'2024-05-30 10:43:41'),('gem_115','钻石花型项链','87997.0元','http://127.0.0.1:9200/IMG/Product_img/pexels-the-glorious-studio-3584518-10361484_1717065880.jpg','undefined','http://127.0.0.1:9200/IMG/Product_img/anton-maksimov-5642-su-5IBDTVyjcJs-unsplash_1717065880.jpg','http://127.0.0.1:9200/IMG/Product_img/amirreza-tavassoli-IFtADMCp9B0-unsplash_1717065880.jpg',NULL,7,'2024-05-30 10:44:40');
/*!40000 ALTER TABLE `shop_copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_cart`
--

DROP TABLE IF EXISTS `user_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_cart` (
  `product_id` int NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` varchar(255) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int NOT NULL,
  `product_imageSrc` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_cart`
--

LOCK TABLES `user_cart` WRITE;
/*!40000 ALTER TABLE `user_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_cart_copy`
--

DROP TABLE IF EXISTS `user_cart_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_cart_copy` (
  `product_id` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` varchar(255) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int NOT NULL,
  `product_imageSrc` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_cart_copy`
--

LOCK TABLES `user_cart_copy` WRITE;
/*!40000 ALTER TABLE `user_cart_copy` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_cart_copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users1`
--

DROP TABLE IF EXISTS `users1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users1` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_sex` varchar(10) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  `user_address` text,
  `user_phone` varchar(20) DEFAULT NULL,
  `user_description` text,
  `user_imageSrc` varchar(255) DEFAULT 'user_8.jpg',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users1`
--

LOCK TABLES `users1` WRITE;
/*!40000 ALTER TABLE `users1` DISABLE KEYS */;
INSERT INTO `users1` VALUES (1,'男','戴云熙','yunxi59@gmail.com','gyqYyNxZP7','760 Diplomacy Drive','5067 116251','To successfully establish a new connection to local/remote server - no matter via SSL or SSH, set the database login information in the General tab. To successfully establish a new                    ','http://127.0.0.1:9200/IMG/User_img/user_3.jpg'),(2,'女','Man Hui Mei','huimeiman823@icloud.com','XsEZBMZh5S','664 Earle Rd','5702 608437','After comparing data, the window shows the number of records that will be inserted, updated or deleted in the target. The Navigation pane employs tree structure which allows you to                    ','http://127.0.0.1:9200/IMG/User_img/user_1.jpg'),(3,'男','Tsui Kar Yan','kytsui@gmail.com','TxmBrmqask','Export Wizard allows you to export data from tables, collections, views, or query results to any available formats. Champions keep playing until they get it right. If you wait, all                    ','614-617-8470','1-6-14, Marunouchi, Chiyoda-ku','http://127.0.0.1:9200/IMG/User_img/user_4.jpg'),(4,'男','lwj','jiehongji6@mail.com','jMW5xbFdH3','9 Wicklow Road','718-467-8709','In a Telnet session, all communications, including username and password, are transmitted in plain-text, allowing anyone to listen-in on your session and steal passwords and other information.','http://127.0.0.1:9200/IMG/User_img/user_7.jpg'),(5,'女','Choi Yu Ling','choyl5@gmail.com','txojqmA6Ax','920 Edward Ave, Braunstone Town','10-340-5944','HTTP Tunneling is a method for connecting to a server that uses the same protocol (http://) and the same port (port 80) as a web server does. Optimism is the one quality more associated               ','http://127.0.0.1:9200/IMG/User_img/user_8.jpg'),(6,'女','Carmen Castro','cc1945@mail.com','OeHTE2mndk','1-1-2 Deshiro, Nishinari Ward','164-3229-3589','How we spend our days is, of course, how we spend our lives. The reason why a great man is great is that he resolves to be a great man. The first step is as good as half over.                         ','http://127.0.0.1:9200/IMG/User_img/user_4.jpg'),(7,'男','lllll','fredholmes@yahoo.com','zHfKYoAwAM','951 West Chang\'an Avenue, Xicheng District','188-8663-1613','Navicat Monitor is a safe, simple and agentless remote server monitoring tool that is packed with powerful features to make your monitoring effective as possible. It can also manage                   ','http://127.0.0.1:9200/IMG/User_img/user_5.jpg'),(8,'男','yuzai321','duyun@gmail.com','RyVFfdUw0w','梧州学院a12','18278051640','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Laborum ipsum dicta quod, quia doloremque aut deserunt commodi quis. Totam a consequatur beatae nostrum, earum consequuntur? Eveniet consequatur ipsum dicta recusandae.','http://127.0.0.1:9200/IMG/User_img/user_2.jpg'),(9,'女','Chin Wai Man','waiman2@mail.com','5JqReqzS2z','5-4-18 Kikusui 3 Jo, Shiroishi Ward,','173-0628-9993','In the middle of winter I at last discovered that there was in me an invincible summer. If the Show objects under schema in navigation pane option is checked at the Preferences window,                ','http://127.0.0.1:9200/IMG/User_img/user_7.jpg'),(38,'男','yxz','1841046262@qq.com','hdjdifhrjfu3892','柳州市恒大城二期','18278051640','小辣鸡','http://127.0.0.1:9200/IMG/User_img/user_8.jpg'),(39,NULL,'vbdfxvsdxbsdr','1741046262@qq.com','sedgsregsdrgherh',NULL,NULL,NULL,'http://127.0.0.1:9200/IMG/User_img/user_9.jpg');
/*!40000 ALTER TABLE `users1` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-30 18:50:49

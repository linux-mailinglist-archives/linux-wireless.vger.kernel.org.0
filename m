Return-Path: <linux-wireless+bounces-19830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70574A5405D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 03:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7B316DFF9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 02:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F85BE46;
	Thu,  6 Mar 2025 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Kr+1fGsg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2B18DB38
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227129; cv=none; b=b0Ca2lBNiJzVhX2b4hc70xHXQ/s/j3ydaEQc++eBn0CSpzVmo+R4K00zXuPqLPL9AnibgYkt6Fl0R/vKn8s885OhpKUn4LiJtjVNgB/qRaU7FTYOBZoP0WwQ2mdNXdr58EZi6NQC13C/9F2/SdPJOlZ+2VUbE+V3/BTok7yuzJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227129; c=relaxed/simple;
	bh=o31eNPDAgzPzHfLmaf1Yy4aC3NQ2DuT8sliClEJE5OM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syUcUNSVT5aPS+1epqTSsM/VpfNAtl9j8tsZ/7n1chqSJ2ah27kVAlHAz0ZtQYq3//lrkLXLiwV418myE0jZKEuYgjbQ0CXHRKwhfhKrcM94HVXJriFzraEEAayB/t9FGtQ9fjSjyQQRLKRZ9kT8q9QnMi9ChBON8cVWgudJ/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Kr+1fGsg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5262C3lG42495371, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741227123; bh=o31eNPDAgzPzHfLmaf1Yy4aC3NQ2DuT8sliClEJE5OM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Kr+1fGsgrod4FS8JmqrtgoIVFBXp45QTksPTc6K/MFJqpGih6K5fZnqR9DBXlO5B0
	 L1QBSFwUjDilLKePkFEHoPWolp8jAdxj9nthxU1JOAdvTcJvJxnqFU531TX2aUEoKj
	 DQPwDaTv+ZxFZDntLNyodlC41R0QMghSt/1+JrYUCvLT9NYsfITDVq2bn0k7avN6/+
	 /B/EduHDdPQ5O7tmnJ1kRtJXWfWfHxwAHRlQSb5aFGSKsUMcYZl30jJxL4+Dk9dQc5
	 vsVrw0251x+xx4SzVN+0p5sD72Deh+WFElSV8/ySwiTogM2esbRSK+XwUtj2BKkBGT
	 rFcOi4azzQQWA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5262C3lG42495371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 10:12:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 10:12:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 6 Mar
 2025 10:12:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>
Subject: [PATCH rtw-next 1/5] wifi: rtw89: add support for negative values of dBm to linear conversion
Date: Thu, 6 Mar 2025 10:11:40 +0800
Message-ID: <20250306021144.12854-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306021144.12854-1-pkshih@realtek.com>
References: <20250306021144.12854-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Kuan-Chung Chen <damon.chen@realtek.com>

Enhanced the dBm to linear conversion function to accommodate negative
dBm values and improved the precision from 1 dBm to 0.25 dBm.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtw89/rtw8852b_common.c  |   6 +-
 drivers/net/wireless/realtek/rtw89/util.c     | 215 +++++++++++-------
 drivers/net/wireless/realtek/rtw89/util.h     |   8 +-
 3 files changed, 137 insertions(+), 92 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 0e094ce9c9b0..99c9505b3cbd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -621,9 +621,9 @@ static void rtw8852bt_ext_loss_avg_update(struct rtw89_dev *rtwdev,
 	if (ext_loss_a == ext_loss_b) {
 		ext_loss_avg = ext_loss_a;
 	} else {
-		linear = rtw89_db_2_linear(abs(ext_loss_a - ext_loss_b)) + 1;
-		linear = DIV_ROUND_CLOSEST_ULL(linear / 2, 1 << RTW89_LINEAR_FRAC_BITS);
-		ext_loss_avg = rtw89_linear_2_db(linear);
+		linear = rtw89_db_to_linear(abs(ext_loss_a - ext_loss_b)) + 1;
+		linear /= 2;
+		ext_loss_avg = rtw89_linear_to_db(linear);
 		ext_loss_avg += min(ext_loss_a, ext_loss_b);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/util.c b/drivers/net/wireless/realtek/rtw89/util.c
index 33be26873473..073714db26f2 100644
--- a/drivers/net/wireless/realtek/rtw89/util.c
+++ b/drivers/net/wireless/realtek/rtw89/util.c
@@ -4,106 +4,151 @@
 
 #include "util.h"
 
-#define FRAC_ROWS 3
-#define FRAC_ROW_MAX (FRAC_ROWS - 1)
-#define NORM_ROW_MIN FRAC_ROWS
-
-static const u32 db_invert_table[12][8] = {
-	/* rows 0~2 in unit of U(32,3) */
-	{10, 13, 16, 20, 25, 32, 40, 50},
-	{64, 80, 101, 128, 160, 201, 256, 318},
-	{401, 505, 635, 800, 1007, 1268, 1596, 2010},
-	/* rows 3~11 in unit of U(32,0) */
-	{316, 398, 501, 631, 794, 1000, 1259, 1585},
-	{1995, 2512, 3162, 3981, 5012, 6310, 7943, 10000},
-	{12589, 15849, 19953, 25119, 31623, 39811, 50119, 63098},
-	{79433, 100000, 125893, 158489, 199526, 251189, 316228, 398107},
-	{501187, 630957, 794328, 1000000, 1258925, 1584893, 1995262, 2511886},
-	{3162278, 3981072, 5011872, 6309573, 7943282, 1000000, 12589254,
-	 15848932},
-	{19952623, 25118864, 31622777, 39810717, 50118723, 63095734, 79432823,
-	 100000000},
-	{125892541, 158489319, 199526232, 251188643, 316227766, 398107171,
-	 501187234, 630957345},
-	{794328235, 1000000000, 1258925412, 1584893192, 1995262315, 2511886432U,
-	 3162277660U, 3981071706U},
+#define RTW89_DBM_QUARTER_FACTOR 2
+#define RTW89_MIN_DBM (-41.25 * (1 << RTW89_DBM_QUARTER_FACTOR))
+#define RTW89_MAX_DBM (96 * (1 << RTW89_DBM_QUARTER_FACTOR))
+#define RTW89_DB_INVERT_TABLE_OFFSET (-RTW89_MIN_DBM)
+
+static const u64 db_invert_table[] = {
+	/* in unit of 0.000001 */
+	75, 79, 84, 89, 94, 100, 106, 112, 119, 126, 133, 141, 150, 158, 168, 178, 188,
+	200, 211, 224, 237, 251, 266, 282, 299, 316, 335, 355, 376, 398, 422, 447, 473,
+	501, 531, 562, 596, 631, 668, 708, 750, 794, 841, 891, 944, 1000, 1059, 1122, 1189,
+	1259, 1334, 1413, 1496, 1585, 1679, 1778, 1884, 1995, 2113, 2239, 2371, 2512, 2661,
+	2818, 2985, 3162, 3350, 3548, 3758, 3981, 4217, 4467, 4732, 5012, 5309, 5623, 5957,
+	6310, 6683, 7079, 7499, 7943, 8414, 8913, 9441, 10000, 10593, 11220, 11885, 12589,
+	13335, 14125, 14962, 15849, 16788, 17783, 18836, 19953, 21135, 22387, 23714, 25119,
+	26607, 28184, 29854, 31623, 33497, 35481, 37584, 39811, 42170, 44668, 47315, 50119,
+	53088, 56234, 59566, 63096, 66834, 70795, 74989, 79433, 84140, 89125, 94406, 100000,
+	105925, 112202, 118850, 125893, 133352, 141254, 149624, 158489, 167880, 177828,
+	188365, 199526, 211349, 223872, 237137, 251189, 266073, 281838, 298538, 316228,
+	334965, 354813, 375837, 398107, 421697, 446684, 473151, 501187, 530884, 562341,
+	595662, 630957, 668344, 707946, 749894, 794328, 841395, 891251, 944061, 1000000,
+	1059254, 1122018, 1188502, 1258925, 1333521, 1412538, 1496236, 1584893, 1678804,
+	1778279, 1883649, 1995262, 2113489, 2238721, 2371374, 2511886, 2660725, 2818383,
+	2985383, 3162278, 3349654, 3548134, 3758374, 3981072, 4216965, 4466836, 4731513,
+	5011872, 5308844, 5623413, 5956621, 6309573, 6683439, 7079458, 7498942, 7943282,
+	8413951, 8912509, 9440609, 10000000, 10592537, 11220185, 11885022, 12589254,
+	13335214, 14125375, 14962357, 15848932, 16788040, 17782794, 18836491, 19952623,
+	21134890, 22387211, 23713737, 25118864, 26607251, 28183829, 29853826, 31622777,
+	33496544, 35481339, 37583740, 39810717, 42169650, 44668359, 47315126, 50118723,
+	53088444, 56234133, 59566214, 63095734, 66834392, 70794578, 74989421, 79432823,
+	84139514, 89125094, 94406088, 100000000, 105925373, 112201845, 118850223, 125892541,
+	133352143, 141253754, 149623566, 158489319, 167880402, 177827941, 188364909, 199526231,
+	211348904, 223872114, 237137371, 251188643, 266072506, 281838293, 298538262, 316227766,
+	334965439, 354813389, 375837404, 398107171, 421696503, 446683592, 473151259, 501187234,
+	530884444, 562341325, 595662144, 630957344, 668343918, 707945784, 749894209, 794328235,
+	841395142, 891250938, 944060876, 1000000000, 1059253725, 1122018454, 1188502227,
+	1258925412, 1333521432, 1412537545, 1496235656, 1584893192, 1678804018, 1778279410,
+	1883649089, 1995262315, 2113489040, 2238721139, 2371373706, 2511886432, 2660725060,
+	2818382931, 2985382619, 3162277660, 3349654392, 3548133892, 3758374043, 3981071706,
+	4216965034, 4466835922ULL, 4731512590ULL, 5011872336ULL, 5308844442ULL, 5623413252ULL,
+	5956621435ULL, 6309573445ULL, 6683439176ULL, 7079457844ULL, 7498942093ULL,
+	7943282347ULL, 8413951416ULL, 8912509381ULL, 9440608763ULL, 10000000000ULL,
+	10592537252ULL, 11220184543ULL, 11885022274ULL, 12589254118ULL, 13335214322ULL,
+	14125375446ULL, 14962356561ULL, 15848931925ULL, 16788040181ULL, 17782794100ULL,
+	18836490895ULL, 19952623150ULL, 21134890398ULL, 22387211386ULL, 23713737057ULL,
+	25118864315ULL, 26607250598ULL, 28183829313ULL, 29853826189ULL, 31622776602ULL,
+	33496543916ULL, 35481338923ULL, 37583740429ULL, 39810717055ULL, 42169650343ULL,
+	44668359215ULL, 47315125896ULL, 50118723363ULL, 53088444423ULL, 56234132519ULL,
+	59566214353ULL, 63095734448ULL, 66834391757ULL, 70794578438ULL, 74989420933ULL,
+	79432823472ULL, 84139514165ULL, 89125093813ULL, 94406087629ULL, 100000000000ULL,
+	105925372518ULL, 112201845430ULL, 118850222744ULL, 125892541179ULL, 133352143216ULL,
+	141253754462ULL, 149623565609ULL, 158489319246ULL, 167880401812ULL, 177827941004ULL,
+	188364908949ULL, 199526231497ULL, 211348903984ULL, 223872113857ULL, 237137370566ULL,
+	251188643151ULL, 266072505980ULL, 281838293126ULL, 298538261892ULL, 316227766017ULL,
+	334965439158ULL, 354813389234ULL, 375837404288ULL, 398107170553ULL, 421696503429ULL,
+	446683592151ULL, 473151258961ULL, 501187233627ULL, 530884444231ULL, 562341325190ULL,
+	595662143529ULL, 630957344480ULL, 668343917569ULL, 707945784384ULL, 749894209332ULL,
+	794328234724ULL, 841395141645ULL, 891250938134ULL, 944060876286ULL, 1000000000000ULL,
+	1059253725177ULL, 1122018454302ULL, 1188502227437ULL, 1258925411794ULL,
+	1333521432163ULL, 1412537544623ULL, 1496235656094ULL, 1584893192461ULL,
+	1678804018123ULL, 1778279410039ULL, 1883649089490ULL, 1995262314969ULL,
+	2113489039837ULL, 2238721138568ULL, 2371373705662ULL, 2511886431510ULL,
+	2660725059799ULL, 2818382931264ULL, 2985382618918ULL, 3162277660168ULL,
+	3349654391578ULL, 3548133892336ULL, 3758374042884ULL, 3981071705535ULL,
+	4216965034286ULL, 4466835921510ULL, 4731512589615ULL, 5011872336273ULL,
+	5308844442310ULL, 5623413251904ULL, 5956621435290ULL, 6309573444802ULL,
+	6683439175686ULL, 7079457843841ULL, 7498942093325ULL, 7943282347243ULL,
+	8413951416452ULL, 8912509381337ULL, 9440608762859ULL, 10000000000000ULL,
+	10592537251773ULL, 11220184543020ULL, 11885022274370ULL, 12589254117942ULL,
+	13335214321633ULL, 14125375446228ULL, 14962356560944ULL, 15848931924611ULL,
+	16788040181226ULL, 17782794100389ULL, 18836490894898ULL, 19952623149689ULL,
+	21134890398367ULL, 22387211385683ULL, 23713737056617ULL, 25118864315096ULL,
+	26607250597988ULL, 28183829312645ULL, 29853826189180ULL, 31622776601684ULL,
+	33496543915783ULL, 35481338923358ULL, 37583740428845ULL, 39810717055350ULL,
+	42169650342858ULL, 44668359215096ULL, 47315125896148ULL, 50118723362727ULL,
+	53088444423099ULL, 56234132519035ULL, 59566214352901ULL, 63095734448019ULL,
+	66834391756862ULL, 70794578438414ULL, 74989420933246ULL, 79432823472428ULL,
+	84139514164520ULL, 89125093813375ULL, 94406087628593ULL, 100000000000000ULL,
+	105925372517729ULL, 112201845430197ULL, 118850222743702ULL, 125892541179417ULL,
+	133352143216332ULL, 141253754462276ULL, 149623565609444ULL, 158489319246111ULL,
+	167880401812256ULL, 177827941003893ULL, 188364908948981ULL, 199526231496888ULL,
+	211348903983664ULL, 223872113856834ULL, 237137370566166ULL, 251188643150958ULL,
+	266072505979882ULL, 281838293126446ULL, 298538261891796ULL, 316227766016838ULL,
+	334965439157829ULL, 354813389233577ULL, 375837404288444ULL, 398107170553497ULL,
+	421696503428583ULL, 446683592150964ULL, 473151258961482ULL, 501187233627272ULL,
+	530884444230989ULL, 562341325190350ULL, 595662143529011ULL, 630957344480196ULL,
+	668343917568615ULL, 707945784384138ULL, 749894209332456ULL, 794328234724284ULL,
+	841395141645198ULL, 891250938133745ULL, 944060876285923ULL, 1000000000000000ULL,
+	1059253725177290ULL, 1122018454301970ULL, 1188502227437020ULL, 1258925411794170ULL,
+	1333521432163330ULL, 1412537544622760ULL, 1496235656094440ULL, 1584893192461110ULL,
+	1678804018122560ULL, 1778279410038920ULL, 1883649089489810ULL, 1995262314968890ULL,
+	2113489039836650ULL, 2238721138568340ULL, 2371373705661660ULL, 2511886431509590ULL,
+	2660725059798820ULL, 2818382931264460ULL, 2985382618917960ULL, 3162277660168380ULL,
+	3349654391578280ULL, 3548133892335770ULL, 3758374042884440ULL, 3981071705534970ULL
 };
 
-u32 rtw89_linear_2_db(u64 val)
+s32 rtw89_linear_to_db_quarter(u64 val)
 {
-	u8 i, j;
-	u32 dB;
-
-	for (i = 0; i < 12; i++) {
-		for (j = 0; j < 8; j++) {
-			if (i <= FRAC_ROW_MAX &&
-			    (val << RTW89_LINEAR_FRAC_BITS) <= db_invert_table[i][j])
-				goto cnt;
-			else if (i > FRAC_ROW_MAX && val <= db_invert_table[i][j])
-				goto cnt;
-		}
-	}
+	int r = ARRAY_SIZE(db_invert_table) - 1;
+	int l = 0;
+	int m;
 
-	return 96; /* maximum 96 dB */
-
-cnt:
-	/* special cases */
-	if (j == 0 && i == 0)
-		goto end;
-
-	if (i == NORM_ROW_MIN && j == 0) {
-		if (db_invert_table[NORM_ROW_MIN][0] - val >
-		    val - (db_invert_table[FRAC_ROW_MAX][7] >> RTW89_LINEAR_FRAC_BITS)) {
-			i = FRAC_ROW_MAX;
-			j = 7;
-		}
-		goto end;
-	}
+	while (l <= r) {
+		m = l + (r - l) / 2;
 
-	if (i <= FRAC_ROW_MAX)
-		val <<= RTW89_LINEAR_FRAC_BITS;
+		if (db_invert_table[m] == val)
+			return m - (s32)RTW89_DB_INVERT_TABLE_OFFSET;
 
-	/* compare difference to get precise dB */
-	if (j == 0) {
-		if (db_invert_table[i][j] - val >
-		    val - db_invert_table[i - 1][7]) {
-			i--;
-			j = 7;
-		}
-	} else {
-		if (db_invert_table[i][j] - val >
-		    val - db_invert_table[i][j - 1]) {
-			j--;
-		}
+		if (db_invert_table[m] > val)
+			r = m - 1;
+		else
+			l = m + 1;
 	}
-end:
-	dB = (i << 3) + j + 1;
 
-	return dB;
+	if (l >= ARRAY_SIZE(db_invert_table))
+		return RTW89_MAX_DBM;
+	else if (r < 0)
+		return RTW89_MIN_DBM;
+	else if (val - db_invert_table[r] <= db_invert_table[l] - val)
+		return r - (s32)RTW89_DB_INVERT_TABLE_OFFSET;
+	else
+		return l - (s32)RTW89_DB_INVERT_TABLE_OFFSET;
 }
-EXPORT_SYMBOL(rtw89_linear_2_db);
+EXPORT_SYMBOL(rtw89_linear_to_db_quarter);
 
-u64 rtw89_db_2_linear(u32 db)
+s32 rtw89_linear_to_db(u64 val)
 {
-	u64 linear;
-	u8 i, j;
-
-	if (db > 96)
-		db = 96;
-	else if (db < 1)
-		return 1;
-
-	i = (db - 1) >> 3;
-	j = (db - 1) & 0x7;
+	return rtw89_linear_to_db_quarter(val) >> RTW89_DBM_QUARTER_FACTOR;
+}
+EXPORT_SYMBOL(rtw89_linear_to_db);
 
-	linear = db_invert_table[i][j];
+u64 rtw89_db_quarter_to_linear(s32 db)
+{
+	/* supported range -41.25 to 96 dBm, in unit of 0.25 dBm */
+	db = clamp_t(s32, db, RTW89_MIN_DBM, RTW89_MAX_DBM);
+	db += (s32)RTW89_DB_INVERT_TABLE_OFFSET;
 
-	if (i >= NORM_ROW_MIN)
-		linear = linear << RTW89_LINEAR_FRAC_BITS;
+	return db_invert_table[db];
+}
+EXPORT_SYMBOL(rtw89_db_quarter_to_linear);
 
-	return linear;
+u64 rtw89_db_to_linear(s32 db)
+{
+	return rtw89_db_quarter_to_linear(db << RTW89_DBM_QUARTER_FACTOR);
 }
-EXPORT_SYMBOL(rtw89_db_2_linear);
+EXPORT_SYMBOL(rtw89_db_to_linear);
 
 void rtw89_might_trailing_ellipsis(char *buf, size_t size, ssize_t used)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index 80441e8da60b..bd08495301e4 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -6,8 +6,6 @@
 
 #include "core.h"
 
-#define RTW89_LINEAR_FRAC_BITS 3
-
 #define rtw89_iterate_vifs_bh(rtwdev, iterator, data)                          \
 	ieee80211_iterate_active_interfaces_atomic((rtwdev)->hw,               \
 			IEEE80211_IFACE_ITER_NORMAL, iterator, data)
@@ -75,8 +73,10 @@ static inline void ether_addr_copy_mask(u8 *dst, const u8 *src, u8 mask)
 	}
 }
 
-u32 rtw89_linear_2_db(u64 linear);
-u64 rtw89_db_2_linear(u32 db);
+s32 rtw89_linear_to_db_quarter(u64 val);
+s32 rtw89_linear_to_db(u64 val);
+u64 rtw89_db_quarter_to_linear(s32 db);
+u64 rtw89_db_to_linear(s32 db);
 void rtw89_might_trailing_ellipsis(char *buf, size_t size, ssize_t used);
 
 #endif
-- 
2.25.1



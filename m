Return-Path: <linux-wireless+bounces-30929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C27D38C56
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 05:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2BCD302FBE8
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 04:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958E2FE567;
	Sat, 17 Jan 2026 04:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="a1jcZ51K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C318C02E
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 04:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624969; cv=none; b=fbl5kK/hCHOq3q0ST/2QA3pmp54FMV6udM4fUXIXIweicJOMsMjas0eUsBEJcsLLX90dREI+AleghlUo743Kbqz91xsQnANnmdZ55SsDDeou0MJvHGPt2PcqRot3UVRdXWwcvK5rHeKCGapwRjNFYq4Futq9k+n/m+7OYR2oJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624969; c=relaxed/simple;
	bh=XBrrYGibOP3LnMCgo4McJP0h4IlhrAyrdiQxEnmgEqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erWAmLK6sA0XLnoNRCpRLvAuooJctkP6vCXS29rA6yizI+gPeNybXQzPuZop5C3njLAaEj/au769qxTb8KjHXnUpuDhPWGne//4aTWuZKvfAZfgsOoTEcPerarWEfrGuYBnRgpro41bdSRPIJL91TtN0c3LtI3Zw5SYsOMGBar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=a1jcZ51K; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60H4giknF2464717, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768624964; bh=ZpFTTdZYm/83LGDQ+7ulHrZrNTjooaL7OFG/cCDAu0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=a1jcZ51KTmqI+4ciYpyozE8jFZ2GJYgAf6Y3t7K4qcQmAY/cvsWFWTZKQrbslGyYy
	 S81yW/DNByoNMwh2nkGc/E2rtbFLoBWrFcUsUuKCcQVPU+pRINBTHr1vUz3JtcbLTp
	 l5fBs9ZRln6KsR6PImup7F3pYyxPXzKmtc4w734/S1a9hDbjNB7hmuubalZUnF3Ahj
	 T0CPAMAapIPQzv/tE9cejTXySq/NMArFH0l6NttSlbat7jHqxObI6QlaHU6/df9Ut3
	 RUcNHpZTKltGUxX0r7krLA6jlNnmUw33KjSDnfL65FtNpRw7xM4Wip65VpJwdgUsOq
	 dujFJ+t37+oHg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60H4giknF2464717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 12:42:44 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:45 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 12:42:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 9/9] wifi: rtw89: 8922a: add digital compensation for 2GHz
Date: Sat, 17 Jan 2026 12:41:57 +0800
Message-ID: <20260117044157.2392958-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117044157.2392958-1-pkshih@realtek.com>
References: <20260117044157.2392958-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Po-Hao Huang <phhuang@realtek.com>

This fixes transmit power too low under 2GHz connection. Previously
we missed the settings of 2GHz, add the according calibrated tables.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 57 +++++++++++++++----
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 0a3c2207dd4b..f41b66b362c4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1768,6 +1768,32 @@ static int rtw8922a_ctrl_rx_path_tmac(struct rtw89_dev *rtwdev,
 }
 
 #define DIGITAL_PWR_COMP_REG_NUM 22
+static const u32 rtw8922a_digital_pwr_comp_2g_s0_val[][DIGITAL_PWR_COMP_REG_NUM] = {
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x00000000, 0x01010000, 0x00000101,
+	 0x01010101, 0x02020201, 0x02010000, 0x03030202, 0x00000303,
+	 0x03020101, 0x06060504, 0x01010000, 0x06050403, 0x01000606,
+	 0x05040202, 0x07070706},
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x00000000, 0x01010100, 0x00000101,
+	 0x01000000, 0x01010101, 0x01010000, 0x02020202, 0x00000404,
+	 0x03020101, 0x04040303, 0x02010000, 0x03030303, 0x00000505,
+	 0x03030201, 0x05050303},
+};
+
+static const u32 rtw8922a_digital_pwr_comp_2g_s1_val[][DIGITAL_PWR_COMP_REG_NUM] = {
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x01010000, 0x01010101, 0x00000101,
+	 0x01010100, 0x01010101, 0x01010000, 0x02020202, 0x01000202,
+	 0x02020101, 0x03030202, 0x02010000, 0x05040403, 0x01000606,
+	 0x05040302, 0x07070605},
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x00000000, 0x01010100, 0x00000101,
+	 0x01010000, 0x02020201, 0x02010100, 0x03030202, 0x01000404,
+	 0x04030201, 0x05050404, 0x01010100, 0x04030303, 0x01000505,
+	 0x03030101, 0x05050404},
+};
+
 static const u32 rtw8922a_digital_pwr_comp_val[][DIGITAL_PWR_COMP_REG_NUM] = {
 	{0x012C0096, 0x044C02BC, 0x00322710, 0x015E0096, 0x03C8028A,
 	 0x0BB80708, 0x17701194, 0x02020100, 0x03030303, 0x01000303,
@@ -1782,7 +1808,7 @@ static const u32 rtw8922a_digital_pwr_comp_val[][DIGITAL_PWR_COMP_REG_NUM] = {
 };
 
 static void rtw8922a_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
-					  bool enable, u8 nss,
+					  u8 band, u8 nss,
 					  enum rtw89_rf_path path)
 {
 	static const u32 ltpc_t0[2] = {R_BE_LTPC_T0_PATH0, R_BE_LTPC_T0_PATH1};
@@ -1790,14 +1816,25 @@ static void rtw8922a_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
 	u32 addr, val;
 	u32 i;
 
-	if (nss == 1)
-		digital_pwr_comp = rtw8922a_digital_pwr_comp_val[0];
-	else
-		digital_pwr_comp = rtw8922a_digital_pwr_comp_val[1];
+	if (nss == 1) {
+		if (band == RTW89_BAND_2G)
+			digital_pwr_comp = path == RF_PATH_A ?
+				rtw8922a_digital_pwr_comp_2g_s0_val[0] :
+				rtw8922a_digital_pwr_comp_2g_s1_val[0];
+		else
+			digital_pwr_comp = rtw8922a_digital_pwr_comp_val[0];
+	} else {
+		if (band == RTW89_BAND_2G)
+			digital_pwr_comp = path == RF_PATH_A ?
+				rtw8922a_digital_pwr_comp_2g_s0_val[1] :
+				rtw8922a_digital_pwr_comp_2g_s1_val[1];
+		else
+			digital_pwr_comp = rtw8922a_digital_pwr_comp_val[1];
+	}
 
 	addr = ltpc_t0[path];
 	for (i = 0; i < DIGITAL_PWR_COMP_REG_NUM; i++, addr += 4) {
-		val = enable ? digital_pwr_comp[i] : 0;
+		val = digital_pwr_comp[i];
 		rtw89_phy_write32(rtwdev, addr, val);
 	}
 }
@@ -1806,7 +1843,7 @@ static void rtw8922a_digital_pwr_comp(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
-	bool enable = chan->band_type != RTW89_BAND_2G;
+	u8 band = chan->band_type;
 	u8 path;
 
 	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
@@ -1814,10 +1851,10 @@ static void rtw8922a_digital_pwr_comp(struct rtw89_dev *rtwdev,
 			path = RF_PATH_A;
 		else
 			path = RF_PATH_B;
-		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 1, path);
+		rtw8922a_set_digital_pwr_comp(rtwdev, band, 1, path);
 	} else {
-		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 2, RF_PATH_A);
-		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 2, RF_PATH_B);
+		rtw8922a_set_digital_pwr_comp(rtwdev, band, 2, RF_PATH_A);
+		rtw8922a_set_digital_pwr_comp(rtwdev, band, 2, RF_PATH_B);
 	}
 }
 
-- 
2.25.1



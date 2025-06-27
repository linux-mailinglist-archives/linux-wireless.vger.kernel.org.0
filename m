Return-Path: <linux-wireless+bounces-24602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB8AEAD98
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 05:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8E87A5BFB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 03:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E23819E83C;
	Fri, 27 Jun 2025 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="O1aAYKvd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808B2AD2D
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750996454; cv=none; b=bi3lHZcr99UqG5226BOAgvB9UfHI6MAfbC7NavPV9AbGI11M9+DuU7AzmnDEZsvE3NKEYUeAaEIr7vhSzU9MRN9JL4LNnewYS3zrEcp8UuB54VtwcQIYAXBI7kdr1pRO/Gk7R0VI5V4OpSwvOXMm4IPQ96Vn1wEKgPVNsgpjgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750996454; c=relaxed/simple;
	bh=60zl8TWtZXrOd9kKZmGPlqFyLOFoCzYpcch8TEooUY4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1ARp72oF4Li0EblUCcnXLW8vS2G9lZZiWAzP+37x0dt5elDo7MoCOpAzFgn5g7fz8Rj6mTA9aumahdG6MJyPH4mD8PScnO3P+X20CPrwXToNMErqqaMwj3m9cz23EaNPsSmFs7rG3lhfulLjyg9R01n/DbYwCY9BRQf+ApX1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=O1aAYKvd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55R3sAVy92042476, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750996450; bh=PpzJuFMAPQFD2U4OBxYDHDCjzEne8reR4nwll+rBYpE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=O1aAYKvdKbQOTGu6c1ZsedQeqm0f5G6K2awZ5zGbgIE9Ubg44nAroypMd8Xd+9Mv7
	 pqVBkzQq5yeYdt38UP3GXRcPjZS48cpPDaoD3CTityGugq5yfdeEBfpmxJU6ss3Bf4
	 S9VVakmY48vWQ1LY8mKPCT9CMOkfZU8SpFYbve0NRlyqart3Y4IWUeQlJfmGCOCCtr
	 n/pimRwJOctPkv+7d6POelN7y4fB2mmGhQsGo3QmYmbAvbni038pAB8QDS2N6tCxBc
	 sKGi8/D/i4Koe+6VcrHGBRX6sCDFpY21V2ROrpJ1ci7sGjq1DGUTQukq0x8ZZT8s7v
	 vR7WNg3Ex78SQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55R3sAVy92042476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 11:54:10 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Jun 2025 11:54:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 27 Jun
 2025 11:54:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 6/6] wifi: rtw89: 8851b: rfk: update IQK to 0x14
Date: Fri, 27 Jun 2025 11:53:38 +0800
Message-ID: <20250627035338.16637-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250627035201.16416-1-pkshih@realtek.com>
References: <20250627035201.16416-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Update IQK along with TX/RX clock to 960MHz and 1920MHz to improve
performance.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 47 +++++++++++++++--
 .../realtek/rtw89/rtw8851b_rfk_table.c        | 52 ++++++++-----------
 .../realtek/rtw89/rtw8851b_rfk_table.h        |  1 +
 3 files changed, 66 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 907ce6d3c1b1..7a319a6c838a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -19,7 +19,7 @@
 #define RTW8851B_RXK_GROUP_NR 4
 #define RTW8851B_RXK_GROUP_IDX_NR 2
 #define RTW8851B_TXK_GROUP_NR 1
-#define RTW8851B_IQK_VER 0x2a
+#define RTW8851B_IQK_VER 0x14
 #define RTW8851B_IQK_SS 1
 #define RTW8851B_LOK_GRAM 10
 #define RTW8851B_TSSI_PATH_NR 1
@@ -1107,10 +1107,43 @@ static void _iqk_rxclk_setting(struct rtw89_dev *rtwdev, u8 path)
 
 	rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_CKT, 0x1);
 
-	if (iqk_info->iqk_bw[path] == RTW89_CHANNEL_WIDTH_80)
+	if (iqk_info->iqk_bw[path] == RTW89_CHANNEL_WIDTH_80) {
+		rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0101);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_DPD_GDIS, 0x1);
+
+		_rxck_force(rtwdev, path, true, ADC_960M);
+
 		rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_rxclk_80_defs_tbl);
-	else
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0101);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_DPD_GDIS, 0x1);
+
+		_rxck_force(rtwdev, path, true, ADC_960M);
+
 		rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_rxclk_others_defs_tbl);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, (2)before RXK IQK\n", path);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x%x[07:10] = 0x%x\n", path,
+		    0xc0d4, rtw89_phy_read32_mask(rtwdev, 0xc0d4, GENMASK(10, 7)));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x%x[11:14] = 0x%x\n", path,
+		    0xc0d4, rtw89_phy_read32_mask(rtwdev, 0xc0d4, GENMASK(14, 11)));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x%x[26:27] = 0x%x\n", path,
+		    0xc0d4, rtw89_phy_read32_mask(rtwdev, 0xc0d4, GENMASK(27, 26)));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x%x[05:08] = 0x%x\n", path,
+		    0xc0d8, rtw89_phy_read32_mask(rtwdev, 0xc0d8, GENMASK(8, 5)));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x%x[17:21] = 0x%x\n", path,
+		    0xc0c4, rtw89_phy_read32_mask(rtwdev, 0xc0c4, GENMASK(21, 17)));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x%x[16:31] = 0x%x\n", path,
+		    0xc0e8, rtw89_phy_read32_mask(rtwdev, 0xc0e8, GENMASK(31, 16)));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x%x[04:05] = 0x%x\n", path,
+		    0xc0e4, rtw89_phy_read32_mask(rtwdev, 0xc0e4, GENMASK(5, 4)));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x%x[23:31]  = 0x%x\n", path,
+		    0x12a0, rtw89_phy_read32_mask(rtwdev, 0x12a0, GENMASK(31, 23)));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x%x[13:14] = 0x%x\n", path,
+		    0xc0ec, rtw89_phy_read32_mask(rtwdev, 0xc0ec, GENMASK(14, 13)));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x%x[16:23] = 0x%x\n", path,
+		    0xc0ec, rtw89_phy_read32_mask(rtwdev, 0xc0ec, GENMASK(23, 16)));
 }
 
 static bool _txk_5g_group_sel(struct rtw89_dev *rtwdev,
@@ -1616,6 +1649,14 @@ static void _iqk_macbb_setting(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 
 	rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_macbb_defs_tbl);
+
+	_txck_force(rtwdev, path, true, DAC_960M);
+
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_DPD_GDIS, 0x1);
+
+	_rxck_force(rtwdev, path, true, ADC_1920M);
+
+	rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_macbb_bh_defs_tbl);
 }
 
 static void _iqk_init(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c
index 38ce03331069..c5f70c045692 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c
@@ -63,16 +63,7 @@ static const struct rtw89_reg5_def rtw8851b_dack_manual_off_defs[] = {
 RTW89_DECLARE_RFK_TBL(rtw8851b_dack_manual_off_defs);
 
 static const struct rtw89_reg5_def rtw8851b_iqk_rxclk_80_defs[] = {
-	RTW89_DECL_RFK_WM(0x20fc, 0xffff0000, 0x0101),
-	RTW89_DECL_RFK_WM(0x5670, 0x00002000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00080000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00070000, 0x2),
 	RTW89_DECL_RFK_WM(0x5670, 0x60000000, 0x1),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x00000780, 0x8),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x00007800, 0x2),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x0c000000, 0x2),
-	RTW89_DECL_RFK_WM(0xc0d8, 0x000001e0, 0x5),
-	RTW89_DECL_RFK_WM(0xc0c4, 0x003e0000, 0xf),
 	RTW89_DECL_RFK_WM(0xc0ec, 0x00006000, 0x0),
 	RTW89_DECL_RFK_WM(0x12b8, 0x40000000, 0x1),
 	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x0f),
@@ -85,16 +76,7 @@ static const struct rtw89_reg5_def rtw8851b_iqk_rxclk_80_defs[] = {
 RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_rxclk_80_defs);
 
 static const struct rtw89_reg5_def rtw8851b_iqk_rxclk_others_defs[] = {
-	RTW89_DECL_RFK_WM(0x20fc, 0xffff0000, 0x0101),
-	RTW89_DECL_RFK_WM(0x5670, 0x00002000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00080000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00070000, 0x2),
 	RTW89_DECL_RFK_WM(0x5670, 0x60000000, 0x0),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x00000780, 0x8),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x00007800, 0x2),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x0c000000, 0x2),
-	RTW89_DECL_RFK_WM(0xc0d8, 0x000001e0, 0x5),
-	RTW89_DECL_RFK_WM(0xc0c4, 0x003e0000, 0xf),
 	RTW89_DECL_RFK_WM(0xc0ec, 0x00006000, 0x2),
 	RTW89_DECL_RFK_WM(0x12b8, 0x40000000, 0x1),
 	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x0f),
@@ -157,30 +139,38 @@ static const struct rtw89_reg5_def rtw8851b_iqk_macbb_defs[] = {
 	RTW89_DECL_RFK_WM(0x20fc, 0x10000000, 0x0),
 	RTW89_DECL_RFK_WM(0x5670, MASKDWORD, 0xf801fffd),
 	RTW89_DECL_RFK_WM(0x5670, 0x00004000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00008000, 0x1),
 	RTW89_DECL_RFK_WM(0x5670, 0x80000000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00007000, 0x7),
-	RTW89_DECL_RFK_WM(0x5670, 0x00002000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00080000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00070000, 0x3),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_macbb_defs);
+
+static const struct rtw89_reg5_def rtw8851b_iqk_macbb_bh_defs[] = {
 	RTW89_DECL_RFK_WM(0x5670, 0x60000000, 0x2),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x00000780, 0x9),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x00007800, 0x1),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x0c000000, 0x0),
-	RTW89_DECL_RFK_WM(0xc0d8, 0x000001e0, 0x3),
-	RTW89_DECL_RFK_WM(0xc0c4, 0x003e0000, 0xa),
-	RTW89_DECL_RFK_WM(0xc0ec, 0x00006000, 0x0),
-	RTW89_DECL_RFK_WM(0xc0e8, 0x00000040, 0x1),
 	RTW89_DECL_RFK_WM(0x12b8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_DELAY(2),
 	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x1f),
+	RTW89_DECL_RFK_DELAY(10),
 	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x13),
+	RTW89_DECL_RFK_DELAY(2),
 	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0001),
+	RTW89_DECL_RFK_DELAY(2),
 	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0041),
+	RTW89_DECL_RFK_DELAY(10),
+	RTW89_DECL_RFK_WM(0x12b8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_DELAY(2),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x1f),
+	RTW89_DECL_RFK_DELAY(10),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x13),
+	RTW89_DECL_RFK_DELAY(2),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0001),
+	RTW89_DECL_RFK_DELAY(2),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0041),
+	RTW89_DECL_RFK_DELAY(10),
 	RTW89_DECL_RFK_WM(0x20fc, 0x00100000, 0x1),
 	RTW89_DECL_RFK_WM(0x20fc, 0x10000000, 0x1),
 };
 
-RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_macbb_defs);
+RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_macbb_bh_defs);
 
 static const struct rtw89_reg5_def rtw8851b_tssi_sys_defs[] = {
 	RTW89_DECL_RFK_WM(0x12bc, 0x000ffff0, 0xb5b5),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h
index 4fd81456109b..3f1547f57505 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h
@@ -18,6 +18,7 @@ extern const struct rtw89_rfk_tbl rtw8851b_iqk_txk_2ghz_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_iqk_txk_5ghz_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_iqk_afebb_restore_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_iqk_macbb_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_iqk_macbb_bh_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_tssi_sys_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_tssi_sys_a_defs_2g_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_tssi_sys_a_defs_5g_tbl;
-- 
2.25.1



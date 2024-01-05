Return-Path: <linux-wireless+bounces-1511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D26F824EB8
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 07:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911D11C22127
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 06:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209CF1EA7A;
	Fri,  5 Jan 2024 06:43:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C81DDE9
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4056ggtkF2200575, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4056ggtkF2200575
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 14:42:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 5 Jan 2024 14:42:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 14:42:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] wifi: rtw89: phy: move bb_gain_info used by WiFi 6 chips to union
Date: Fri, 5 Jan 2024 14:42:21 +0800
Message-ID: <20240105064228.36580-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105064228.36580-1-pkshih@realtek.com>
References: <20240105064228.36580-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

WiFi 7 chips use different bb_gain_info struct, so move existing struct to
a union in advance. This doesn't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 4 +++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 8 ++++----
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 2 +-
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ea6df859ba15..8c5b831c3a37 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4824,7 +4824,9 @@ struct rtw89_dev {
 	struct rtw89_env_monitor_info env_monitor;
 	struct rtw89_dig_info dig;
 	struct rtw89_phy_ch_info ch_info;
-	struct rtw89_phy_bb_gain_info bb_gain;
+	union {
+		struct rtw89_phy_bb_gain_info ax;
+	} bb_gain;
 	struct rtw89_phy_efuse_gain efuse_gain;
 	struct rtw89_phy_ul_tb_info ul_tb_info;
 	struct rtw89_antdiv_info antdiv;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index bafc7b1cc104..b2729c2550db 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -929,7 +929,7 @@ static void
 rtw89_phy_cfg_bb_gain_error(struct rtw89_dev *rtwdev,
 			    union rtw89_phy_bb_gain_arg arg, u32 data)
 {
-	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
 	u8 type = arg.type;
 	u8 path = arg.path;
 	u8 gband = arg.gain_band;
@@ -968,7 +968,7 @@ static void
 rtw89_phy_cfg_bb_rpl_ofst(struct rtw89_dev *rtwdev,
 			  union rtw89_phy_bb_gain_arg arg, u32 data)
 {
-	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
 	u8 rxsc_start = arg.rxsc_start;
 	u8 bw = arg.bw;
 	u8 path = arg.path;
@@ -1050,7 +1050,7 @@ static void
 rtw89_phy_cfg_bb_gain_bypass(struct rtw89_dev *rtwdev,
 			     union rtw89_phy_bb_gain_arg arg, u32 data)
 {
-	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
 	u8 type = arg.type;
 	u8 path = arg.path;
 	u8 gband = arg.gain_band;
@@ -1077,7 +1077,7 @@ static void
 rtw89_phy_cfg_bb_gain_op1db(struct rtw89_dev *rtwdev,
 			    union rtw89_phy_bb_gain_arg arg, u32 data)
 {
-	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
 	u8 type = arg.type;
 	u8 path = arg.path;
 	u8 gband = arg.gain_band;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 5c167a9278ce..b5cf093146cb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -901,7 +901,7 @@ static void rtw8851b_set_gain_error(struct rtw89_dev *rtwdev,
 				    enum rtw89_subband subband,
 				    enum rtw89_rf_path path)
 {
-	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
 	u8 gain_band = rtw89_subband_to_bb_gain_band(subband);
 	s32 val;
 	u32 reg;
@@ -987,7 +987,7 @@ static void rtw8851b_set_gain_offset(struct rtw89_dev *rtwdev,
 static
 void rtw8851b_set_rxsc_rpl_comp(struct rtw89_dev *rtwdev, enum rtw89_subband subband)
 {
-	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
 	u8 band = rtw89_subband_to_bb_gain_band(subband);
 	u32 val;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index de887a35f3fb..ab60cc11a385 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -988,7 +988,7 @@ static void rtw8852b_set_gain_error(struct rtw89_dev *rtwdev,
 				    enum rtw89_subband subband,
 				    enum rtw89_rf_path path)
 {
-	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
 	u8 gain_band = rtw89_subband_to_bb_gain_band(subband);
 	s32 val;
 	u32 reg;
@@ -1086,7 +1086,7 @@ static void rtw8852b_set_gain_offset(struct rtw89_dev *rtwdev,
 static
 void rtw8852b_set_rxsc_rpl_comp(struct rtw89_dev *rtwdev, enum rtw89_subband subband)
 {
-	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
 	u8 band = rtw89_subband_to_bb_gain_band(subband);
 	u32 val;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8618d0204f66..9a9b7103caeb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -842,7 +842,7 @@ static void rtw8852c_set_gain_error(struct rtw89_dev *rtwdev,
 				    enum rtw89_subband subband,
 				    enum rtw89_rf_path path)
 {
-	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
 	u8 gain_band = rtw89_subband_to_bb_gain_band(subband);
 	s32 val;
 	u32 reg;
-- 
2.25.1



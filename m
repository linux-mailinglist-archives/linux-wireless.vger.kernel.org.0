Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E254F399
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 10:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381220AbiFQIv6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381208AbiFQIv4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 04:51:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435569B4D
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 01:51:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25H8plluF020997, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25H8plluF020997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jun 2022 16:51:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 17 Jun 2022 16:51:47 +0800
Received: from localhost (172.16.16.131) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 17 Jun
 2022 16:51:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 05/13] rtw89: txpwr: concentrate channel related control to top
Date:   Fri, 17 Jun 2022 16:49:46 +0800
Message-ID: <20220617084954.61261-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617084954.61261-1-pkshih@realtek.com>
References: <20220617084954.61261-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.131]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/17/2022 08:32:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTcgpFekyCAwNjozNjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

For future support on multiple channels, it would be disturbing if we
still allow scattered leaf functions of TX power to query and manage
channel related control by themselves.

So, query rtw89_chan only on top functions. Then, pass it via functions
to make sure that the values coming from the same struct rtw89_chan.

Besides, fix rtw8852a_set_txpwr_offset() from rtw8852a_set_txpwr_ctrl()
to rtw8852a_set_txpwr(). TX power offset should consider current band,
so move it to chip_ops::set_txpwr() which will be called every time that
channel is set.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |   4 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   9 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 235 +++++++++++-------
 drivers/net/wireless/realtek/rtw89/phy.h      |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  35 +--
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |   9 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  39 +--
 7 files changed, 206 insertions(+), 131 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 033c53d99c122..58268b9654b9d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -287,14 +287,16 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_chan *chan;
 	bool entity_active;
 
 	entity_active = rtw89_get_entity_state(rtwdev);
 	if (!entity_active)
 		return;
 
+	chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	if (chip->ops->set_txpwr)
-		chip->ops->set_txpwr(rtwdev);
+		chip->ops->set_txpwr(rtwdev, chan, RTW89_PHY_0);
 }
 
 void rtw89_set_channel(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ed658a8773cba..49c8e08754037 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2124,8 +2124,11 @@ struct rtw89_chip_ops {
 	void (*rfk_scan)(struct rtw89_dev *rtwdev, bool start);
 	void (*rfk_track)(struct rtw89_dev *rtwdev);
 	void (*power_trim)(struct rtw89_dev *rtwdev);
-	void (*set_txpwr)(struct rtw89_dev *rtwdev);
-	void (*set_txpwr_ctrl)(struct rtw89_dev *rtwdev);
+	void (*set_txpwr)(struct rtw89_dev *rtwdev,
+			  const struct rtw89_chan *chan,
+			  enum rtw89_phy_idx phy_idx);
+	void (*set_txpwr_ctrl)(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx);
 	int (*init_txpwr_unit)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 	u8 (*get_thermal)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path);
 	void (*ctrl_btg)(struct rtw89_dev *rtwdev, bool btg);
@@ -3668,7 +3671,7 @@ static inline void rtw89_chip_set_txpwr_ctrl(struct rtw89_dev *rtwdev)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->set_txpwr_ctrl)
-		chip->ops->set_txpwr_ctrl(rtwdev);
+		chip->ops->set_txpwr_ctrl(rtwdev,  RTW89_PHY_0);
 }
 
 static inline void rtw89_chip_power_trim(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 04ed1a63ad0a2..94596981c29d9 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1470,11 +1470,9 @@ EXPORT_SYMBOL(rtw89_phy_load_txpwr_byrate);
 	(txpwr_rf) >> (__c->txpwr_factor_rf - __c->txpwr_factor_mac);	\
 })
 
-s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev,
+s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band,
 			       const struct rtw89_rate_desc *rate_desc)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	enum rtw89_band band = chan->band_type;
 	s8 *byr;
 	u8 idx;
 
@@ -1541,12 +1539,10 @@ static u8 rtw89_channel_to_idx(struct rtw89_dev *rtwdev, u8 band, u8 channel)
 	}
 }
 
-s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev,
+s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	u8 band = chan->band_type;
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	s8 lmt = 0, sar;
@@ -1582,11 +1578,12 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_read_txpwr_limit);
 
-#define __fill_txpwr_limit_nonbf_bf(ptr, bw, ntx, rs, ch)		\
+#define __fill_txpwr_limit_nonbf_bf(ptr, band, bw, ntx, rs, ch)		\
 	do {								\
 		u8 __i;							\
 		for (__i = 0; __i < RTW89_BF_NUM; __i++)		\
 			ptr[__i] = rtw89_phy_read_txpwr_limit(rtwdev,	\
+							      band,	\
 							      bw, ntx,	\
 							      rs, __i,	\
 							      (ch));	\
@@ -1594,64 +1591,75 @@ EXPORT_SYMBOL(rtw89_phy_read_txpwr_limit);
 
 static void rtw89_phy_fill_txpwr_limit_20m(struct rtw89_dev *rtwdev,
 					   struct rtw89_txpwr_limit *lmt,
-					   u8 ntx, u8 ch)
+					   u8 band, u8 ntx, u8 ch)
 {
-	__fill_txpwr_limit_nonbf_bf(lmt->cck_20m, RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->cck_20m, band, RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_CCK, ch);
-	__fill_txpwr_limit_nonbf_bf(lmt->cck_40m, RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(lmt->cck_40m, band, RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_CCK, ch);
-	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, band, RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_OFDM, ch);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch);
 }
 
 static void rtw89_phy_fill_txpwr_limit_40m(struct rtw89_dev *rtwdev,
 					   struct rtw89_txpwr_limit *lmt,
-					   u8 ntx, u8 ch, u8 pri_ch)
+					   u8 band, u8 ntx, u8 ch, u8 pri_ch)
 {
-	__fill_txpwr_limit_nonbf_bf(lmt->cck_20m, RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->cck_20m, band, RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_CCK, ch - 2);
-	__fill_txpwr_limit_nonbf_bf(lmt->cck_40m, RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(lmt->cck_40m, band, RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_CCK, ch);
-	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, band, RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_OFDM, pri_ch);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch - 2);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[1], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[1], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch + 2);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[0], RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[0], band,
+				    RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch);
 }
 
 static void rtw89_phy_fill_txpwr_limit_80m(struct rtw89_dev *rtwdev,
 					   struct rtw89_txpwr_limit *lmt,
-					   u8 ntx, u8 ch, u8 pri_ch)
+					   u8 band, u8 ntx, u8 ch, u8 pri_ch)
 {
 	s8 val_0p5_n[RTW89_BF_NUM];
 	s8 val_0p5_p[RTW89_BF_NUM];
 	u8 i;
 
-	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, band, RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_OFDM, pri_ch);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch - 6);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[1], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[1], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch - 2);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[2], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[2], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch + 2);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[3], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[3], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch + 6);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[0], RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[0], band,
+				    RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch - 4);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[1], RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[1], band,
+				    RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch + 4);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_80m[0], RTW89_CHANNEL_WIDTH_80,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_80m[0], band,
+				    RTW89_CHANNEL_WIDTH_80,
 				    ntx, RTW89_RS_MCS, ch);
 
-	__fill_txpwr_limit_nonbf_bf(val_0p5_n, RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(val_0p5_n, band, RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch - 4);
-	__fill_txpwr_limit_nonbf_bf(val_0p5_p, RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(val_0p5_p, band, RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch + 4);
 
 	for (i = 0; i < RTW89_BF_NUM; i++)
@@ -1660,7 +1668,7 @@ static void rtw89_phy_fill_txpwr_limit_80m(struct rtw89_dev *rtwdev,
 
 static void rtw89_phy_fill_txpwr_limit_160m(struct rtw89_dev *rtwdev,
 					    struct rtw89_txpwr_limit *lmt,
-					    u8 ntx, u8 ch, u8 pri_ch)
+					    u8 band, u8 ntx, u8 ch, u8 pri_ch)
 {
 	s8 val_0p5_n[RTW89_BF_NUM];
 	s8 val_0p5_p[RTW89_BF_NUM];
@@ -1669,60 +1677,75 @@ static void rtw89_phy_fill_txpwr_limit_160m(struct rtw89_dev *rtwdev,
 	u8 i;
 
 	/* fill ofdm section */
-	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, band, RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_OFDM, pri_ch);
 
 	/* fill mcs 20m section */
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch - 14);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[1], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[1], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch - 10);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[2], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[2], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch - 6);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[3], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[3], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch - 2);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[4], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[4], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch + 2);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[5], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[5], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch + 6);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[6], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[6], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch + 10);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[7], RTW89_CHANNEL_WIDTH_20,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[7], band,
+				    RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch + 14);
 
 	/* fill mcs 40m section */
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[0], RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[0], band,
+				    RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch - 12);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[1], RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[1], band,
+				    RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch - 4);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[2], RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[2], band,
+				    RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch + 4);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[3], RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[3], band,
+				    RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch + 12);
 
 	/* fill mcs 80m section */
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_80m[0], RTW89_CHANNEL_WIDTH_80,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_80m[0], band,
+				    RTW89_CHANNEL_WIDTH_80,
 				    ntx, RTW89_RS_MCS, ch - 8);
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_80m[1], RTW89_CHANNEL_WIDTH_80,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_80m[1], band,
+				    RTW89_CHANNEL_WIDTH_80,
 				    ntx, RTW89_RS_MCS, ch + 8);
 
 	/* fill mcs 160m section */
-	__fill_txpwr_limit_nonbf_bf(lmt->mcs_160m, RTW89_CHANNEL_WIDTH_160,
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_160m, band,
+				    RTW89_CHANNEL_WIDTH_160,
 				    ntx, RTW89_RS_MCS, ch);
 
 	/* fill mcs 40m 0p5 section */
-	__fill_txpwr_limit_nonbf_bf(val_0p5_n, RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(val_0p5_n, band, RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch - 4);
-	__fill_txpwr_limit_nonbf_bf(val_0p5_p, RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(val_0p5_p, band, RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch + 4);
 
 	for (i = 0; i < RTW89_BF_NUM; i++)
 		lmt->mcs_40m_0p5[i] = min_t(s8, val_0p5_n[i], val_0p5_p[i]);
 
 	/* fill mcs 40m 2p5 section */
-	__fill_txpwr_limit_nonbf_bf(val_2p5_n, RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(val_2p5_n, band, RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch - 8);
-	__fill_txpwr_limit_nonbf_bf(val_2p5_p, RTW89_CHANNEL_WIDTH_40,
+	__fill_txpwr_limit_nonbf_bf(val_2p5_p, band, RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_MCS, ch + 8);
 
 	for (i = 0; i < RTW89_BF_NUM; i++)
@@ -1730,10 +1753,11 @@ static void rtw89_phy_fill_txpwr_limit_160m(struct rtw89_dev *rtwdev,
 }
 
 void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan,
 				struct rtw89_txpwr_limit *lmt,
 				u8 ntx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 band = chan->band_type;
 	u8 pri_ch = chan->primary_channel;
 	u8 ch = chan->channel;
 	u8 bw = chan->band_width;
@@ -1742,27 +1766,28 @@ void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
 
 	switch (bw) {
 	case RTW89_CHANNEL_WIDTH_20:
-		rtw89_phy_fill_txpwr_limit_20m(rtwdev, lmt, ntx, ch);
+		rtw89_phy_fill_txpwr_limit_20m(rtwdev, lmt, band, ntx, ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_40:
-		rtw89_phy_fill_txpwr_limit_40m(rtwdev, lmt, ntx, ch, pri_ch);
+		rtw89_phy_fill_txpwr_limit_40m(rtwdev, lmt, band, ntx, ch,
+					       pri_ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_80:
-		rtw89_phy_fill_txpwr_limit_80m(rtwdev, lmt, ntx, ch, pri_ch);
+		rtw89_phy_fill_txpwr_limit_80m(rtwdev, lmt, band, ntx, ch,
+					       pri_ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_160:
-		rtw89_phy_fill_txpwr_limit_160m(rtwdev, lmt, ntx, ch, pri_ch);
+		rtw89_phy_fill_txpwr_limit_160m(rtwdev, lmt, band, ntx, ch,
+						pri_ch);
 		break;
 	}
 }
 EXPORT_SYMBOL(rtw89_phy_fill_txpwr_limit);
 
-static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev,
+static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 					u8 ru, u8 ntx, u8 ch)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	u8 band = chan->band_type;
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	s8 lmt_ru = 0, sar;
@@ -1800,85 +1825,106 @@ static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 static void
 rtw89_phy_fill_txpwr_limit_ru_20m(struct rtw89_dev *rtwdev,
 				  struct rtw89_txpwr_limit_ru *lmt_ru,
-				  u8 ntx, u8 ch)
+				  u8 band, u8 ntx, u8 ch)
 {
-	lmt_ru->ru26[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU26,
+	lmt_ru->ru26[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU26,
 							ntx, ch);
-	lmt_ru->ru52[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU52,
+	lmt_ru->ru52[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU52,
 							ntx, ch);
-	lmt_ru->ru106[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU106,
+	lmt_ru->ru106[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							 RTW89_RU106,
 							 ntx, ch);
 }
 
 static void
 rtw89_phy_fill_txpwr_limit_ru_40m(struct rtw89_dev *rtwdev,
 				  struct rtw89_txpwr_limit_ru *lmt_ru,
-				  u8 ntx, u8 ch)
+				  u8 band, u8 ntx, u8 ch)
 {
-	lmt_ru->ru26[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU26,
+	lmt_ru->ru26[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU26,
 							ntx, ch - 2);
-	lmt_ru->ru26[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU26,
+	lmt_ru->ru26[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU26,
 							ntx, ch + 2);
-	lmt_ru->ru52[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU52,
+	lmt_ru->ru52[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU52,
 							ntx, ch - 2);
-	lmt_ru->ru52[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU52,
+	lmt_ru->ru52[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU52,
 							ntx, ch + 2);
-	lmt_ru->ru106[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU106,
+	lmt_ru->ru106[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							 RTW89_RU106,
 							 ntx, ch - 2);
-	lmt_ru->ru106[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU106,
+	lmt_ru->ru106[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							 RTW89_RU106,
 							 ntx, ch + 2);
 }
 
 static void
 rtw89_phy_fill_txpwr_limit_ru_80m(struct rtw89_dev *rtwdev,
 				  struct rtw89_txpwr_limit_ru *lmt_ru,
-				  u8 ntx, u8 ch)
+				  u8 band, u8 ntx, u8 ch)
 {
-	lmt_ru->ru26[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU26,
+	lmt_ru->ru26[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU26,
 							ntx, ch - 6);
-	lmt_ru->ru26[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU26,
+	lmt_ru->ru26[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU26,
 							ntx, ch - 2);
-	lmt_ru->ru26[2] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU26,
+	lmt_ru->ru26[2] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU26,
 							ntx, ch + 2);
-	lmt_ru->ru26[3] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU26,
+	lmt_ru->ru26[3] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU26,
 							ntx, ch + 6);
-	lmt_ru->ru52[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU52,
+	lmt_ru->ru52[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU52,
 							ntx, ch - 6);
-	lmt_ru->ru52[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU52,
+	lmt_ru->ru52[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU52,
 							ntx, ch - 2);
-	lmt_ru->ru52[2] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU52,
+	lmt_ru->ru52[2] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU52,
 							ntx, ch + 2);
-	lmt_ru->ru52[3] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU52,
+	lmt_ru->ru52[3] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							RTW89_RU52,
 							ntx, ch + 6);
-	lmt_ru->ru106[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU106,
+	lmt_ru->ru106[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							 RTW89_RU106,
 							 ntx, ch - 6);
-	lmt_ru->ru106[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU106,
+	lmt_ru->ru106[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							 RTW89_RU106,
 							 ntx, ch - 2);
-	lmt_ru->ru106[2] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU106,
+	lmt_ru->ru106[2] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							 RTW89_RU106,
 							 ntx, ch + 2);
-	lmt_ru->ru106[3] = rtw89_phy_read_txpwr_limit_ru(rtwdev, RTW89_RU106,
+	lmt_ru->ru106[3] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							 RTW89_RU106,
 							 ntx, ch + 6);
 }
 
 static void
 rtw89_phy_fill_txpwr_limit_ru_160m(struct rtw89_dev *rtwdev,
 				   struct rtw89_txpwr_limit_ru *lmt_ru,
-				   u8 ntx, u8 ch)
+				   u8 band, u8 ntx, u8 ch)
 {
 	static const int ofst[] = { -14, -10, -6, -2, 2, 6, 10, 14 };
 	int i;
 
 	static_assert(ARRAY_SIZE(ofst) == RTW89_RU_SEC_NUM);
 	for (i = 0; i < RTW89_RU_SEC_NUM; i++) {
-		lmt_ru->ru26[i] = rtw89_phy_read_txpwr_limit_ru(rtwdev,
+		lmt_ru->ru26[i] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
 								RTW89_RU26,
 								ntx,
 								ch + ofst[i]);
-		lmt_ru->ru52[i] = rtw89_phy_read_txpwr_limit_ru(rtwdev,
+		lmt_ru->ru52[i] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
 								RTW89_RU52,
 								ntx,
 								ch + ofst[i]);
-		lmt_ru->ru106[i] = rtw89_phy_read_txpwr_limit_ru(rtwdev,
+		lmt_ru->ru106[i] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
 								 RTW89_RU106,
 								 ntx,
 								 ch + ofst[i]);
@@ -1886,10 +1932,11 @@ rtw89_phy_fill_txpwr_limit_ru_160m(struct rtw89_dev *rtwdev,
 }
 
 void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
+				   const struct rtw89_chan *chan,
 				   struct rtw89_txpwr_limit_ru *lmt_ru,
 				   u8 ntx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 band = chan->band_type;
 	u8 ch = chan->channel;
 	u8 bw = chan->band_width;
 
@@ -1897,16 +1944,20 @@ void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 
 	switch (bw) {
 	case RTW89_CHANNEL_WIDTH_20:
-		rtw89_phy_fill_txpwr_limit_ru_20m(rtwdev, lmt_ru, ntx, ch);
+		rtw89_phy_fill_txpwr_limit_ru_20m(rtwdev, lmt_ru, band, ntx,
+						  ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_40:
-		rtw89_phy_fill_txpwr_limit_ru_40m(rtwdev, lmt_ru, ntx, ch);
+		rtw89_phy_fill_txpwr_limit_ru_40m(rtwdev, lmt_ru, band, ntx,
+						  ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_80:
-		rtw89_phy_fill_txpwr_limit_ru_80m(rtwdev, lmt_ru, ntx, ch);
+		rtw89_phy_fill_txpwr_limit_ru_80m(rtwdev, lmt_ru, band, ntx,
+						  ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_160:
-		rtw89_phy_fill_txpwr_limit_ru_160m(rtwdev, lmt_ru, ntx, ch);
+		rtw89_phy_fill_txpwr_limit_ru_160m(rtwdev, lmt_ru, band, ntx,
+						   ch);
 		break;
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index d1f6e38a98ce3..e48d387d33afb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -460,15 +460,17 @@ void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			   u32 data, enum rtw89_phy_idx phy_idx);
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl);
-s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev,
+s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band,
 			       const struct rtw89_rate_desc *rate_desc);
 void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan,
 				struct rtw89_txpwr_limit *lmt,
 				u8 ntx);
 void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
+				   const struct rtw89_chan *chan,
 				   struct rtw89_txpwr_limit_ru *lmt_ru,
 				   u8 ntx);
-s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev,
+s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch);
 void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta);
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index ef200d32eab33..06e2c8205eeda 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1379,9 +1379,10 @@ static void rtw8852a_set_txpwr_ref(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852a_set_txpwr_byrate(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
 				      enum rtw89_phy_idx phy_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 band = chan->band_type;
 	u8 ch = chan->channel;
 	static const u8 rs[] = {
 		RTW89_RS_CCK,
@@ -1408,7 +1409,8 @@ static void rtw8852a_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 			for (j = 0; j < rtw89_rs_idx_max[rs[i]]; j++) {
 				cur.idx = j;
 				shf = (j % 4) * 8;
-				tmp = rtw89_phy_read_txpwr_byrate(rtwdev, &cur);
+				tmp = rtw89_phy_read_txpwr_byrate(rtwdev, band,
+								  &cur);
 				val |= (tmp << shf);
 
 				if ((j + 1) % 4)
@@ -1423,8 +1425,10 @@ static void rtw8852a_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852a_set_txpwr_offset(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
 				      enum rtw89_phy_idx phy_idx)
 {
+	u8 band = chan->band_type;
 	struct rtw89_rate_desc desc = {
 		.nss = RTW89_NSS_1,
 		.rs = RTW89_RS_OFFSET,
@@ -1435,7 +1439,7 @@ static void rtw8852a_set_txpwr_offset(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr offset\n");
 
 	for (desc.idx = 0; desc.idx < RTW89_RATE_OFFSET_MAX; desc.idx++) {
-		v = rtw89_phy_read_txpwr_byrate(rtwdev, &desc);
+		v = rtw89_phy_read_txpwr_byrate(rtwdev, band, &desc);
 		val |= ((v & 0xf) << (4 * desc.idx));
 	}
 
@@ -1444,10 +1448,10 @@ static void rtw8852a_set_txpwr_offset(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852a_set_txpwr_limit(struct rtw89_dev *rtwdev,
+				     const struct rtw89_chan *chan,
 				     enum rtw89_phy_idx phy_idx)
 {
 #define __MAC_TXPWR_LMT_PAGE_SIZE 40
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 ch = chan->channel;
 	u8 bw = chan->band_width;
 	struct rtw89_txpwr_limit lmt[NTX_NUM_8852A];
@@ -1459,7 +1463,7 @@ static void rtw8852a_set_txpwr_limit(struct rtw89_dev *rtwdev,
 		    "[TXPWR] set txpwr limit with ch=%d bw=%d\n", ch, bw);
 
 	for (i = 0; i < NTX_NUM_8852A; i++) {
-		rtw89_phy_fill_txpwr_limit(rtwdev, &lmt[i], i);
+		rtw89_phy_fill_txpwr_limit(rtwdev, chan, &lmt[i], i);
 
 		for (j = 0; j < __MAC_TXPWR_LMT_PAGE_SIZE; j += 4) {
 			addr = R_AX_PWR_LMT + j + __MAC_TXPWR_LMT_PAGE_SIZE * i;
@@ -1476,10 +1480,10 @@ static void rtw8852a_set_txpwr_limit(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852a_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan,
 					enum rtw89_phy_idx phy_idx)
 {
 #define __MAC_TXPWR_LMT_RU_PAGE_SIZE 24
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 ch = chan->channel;
 	u8 bw = chan->band_width;
 	struct rtw89_txpwr_limit_ru lmt_ru[NTX_NUM_8852A];
@@ -1491,7 +1495,7 @@ static void rtw8852a_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 		    "[TXPWR] set txpwr limit ru with ch=%d bw=%d\n", ch, bw);
 
 	for (i = 0; i < NTX_NUM_8852A; i++) {
-		rtw89_phy_fill_txpwr_limit_ru(rtwdev, &lmt_ru[i], i);
+		rtw89_phy_fill_txpwr_limit_ru(rtwdev, chan, &lmt_ru[i], i);
 
 		for (j = 0; j < __MAC_TXPWR_LMT_RU_PAGE_SIZE; j += 4) {
 			addr = R_AX_PWR_RU_LMT + j +
@@ -1509,17 +1513,20 @@ static void rtw8852a_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 #undef __MAC_TXPWR_LMT_RU_PAGE_SIZE
 }
 
-static void rtw8852a_set_txpwr(struct rtw89_dev *rtwdev)
+static void rtw8852a_set_txpwr(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan,
+			       enum rtw89_phy_idx phy_idx)
 {
-	rtw8852a_set_txpwr_byrate(rtwdev, RTW89_PHY_0);
-	rtw8852a_set_txpwr_limit(rtwdev, RTW89_PHY_0);
-	rtw8852a_set_txpwr_limit_ru(rtwdev, RTW89_PHY_0);
+	rtw8852a_set_txpwr_byrate(rtwdev, chan, phy_idx);
+	rtw8852a_set_txpwr_offset(rtwdev, chan, phy_idx);
+	rtw8852a_set_txpwr_limit(rtwdev, chan, phy_idx);
+	rtw8852a_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
 }
 
-static void rtw8852a_set_txpwr_ctrl(struct rtw89_dev *rtwdev)
+static void rtw8852a_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy_idx)
 {
-	rtw8852a_set_txpwr_ref(rtwdev, RTW89_PHY_0);
-	rtw8852a_set_txpwr_offset(rtwdev, RTW89_PHY_0);
+	rtw8852a_set_txpwr_ref(rtwdev, phy_idx);
 }
 
 static int
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 276afe968a291..d2c97318eb9d9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -3491,6 +3491,7 @@ static void _tssi_high_power(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 ch = chan->channel, ch_tmp;
 	u8 bw = chan->band_width;
+	u8 band = chan->band_type;
 	u8 subband = chan->subband_type;
 	s8 power;
 	s32 xdbm;
@@ -3502,7 +3503,7 @@ static void _tssi_high_power(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	else
 		ch_tmp = ch;
 
-	power = rtw89_phy_read_txpwr_limit(rtwdev, bw, RTW89_1TX,
+	power = rtw89_phy_read_txpwr_limit(rtwdev, band, bw, RTW89_1TX,
 					   RTW89_RS_MCS, RTW89_NONBF, ch_tmp);
 
 	xdbm = power * 100 / 4;
@@ -3538,6 +3539,7 @@ static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	const struct rtw89_chip_info *mac_reg = rtwdev->chip;
 	u8 ch = chan->channel, ch_tmp;
 	u8 bw = chan->band_width;
+	u8 band = chan->band_type;
 	u32 tx_en;
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, 0);
 	s8 power;
@@ -3551,8 +3553,9 @@ static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	else
 		ch_tmp = ch;
 
-	power = rtw89_phy_read_txpwr_limit(rtwdev, RTW89_CHANNEL_WIDTH_20, RTW89_1TX,
-					   RTW89_RS_OFDM, RTW89_NONBF, ch_tmp);
+	power = rtw89_phy_read_txpwr_limit(rtwdev, band, RTW89_CHANNEL_WIDTH_20,
+					   RTW89_1TX, RTW89_RS_OFDM,
+					   RTW89_NONBF, ch_tmp);
 
 	xdbm = (power * 100) >> mac_reg->txpwr_factor_mac;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index b81aec0630969..1625089d83408 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1962,9 +1962,10 @@ static void rtw8852c_set_txpwr_ref(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852c_set_txpwr_byrate(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
 				      enum rtw89_phy_idx phy_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 band = chan->band_type;
 	u8 ch = chan->channel;
 	static const u8 rs[] = {
 		RTW89_RS_CCK,
@@ -1991,7 +1992,8 @@ static void rtw8852c_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 			for (j = 0; j < rtw89_rs_idx_max[rs[i]]; j++) {
 				cur.idx = j;
 				shf = (j % 4) * 8;
-				tmp = rtw89_phy_read_txpwr_byrate(rtwdev, &cur);
+				tmp = rtw89_phy_read_txpwr_byrate(rtwdev, band,
+								  &cur);
 				val |= (tmp << shf);
 
 				if ((j + 1) % 4)
@@ -2006,8 +2008,10 @@ static void rtw8852c_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852c_set_txpwr_offset(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
 				      enum rtw89_phy_idx phy_idx)
 {
+	u8 band = chan->band_type;
 	struct rtw89_rate_desc desc = {
 		.nss = RTW89_NSS_1,
 		.rs = RTW89_RS_OFFSET,
@@ -2018,7 +2022,7 @@ static void rtw8852c_set_txpwr_offset(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr offset\n");
 
 	for (desc.idx = 0; desc.idx < RTW89_RATE_OFFSET_MAX; desc.idx++) {
-		v = rtw89_phy_read_txpwr_byrate(rtwdev, &desc);
+		v = rtw89_phy_read_txpwr_byrate(rtwdev, band, &desc);
 		val |= ((v & 0xf) << (4 * desc.idx));
 	}
 
@@ -2082,9 +2086,9 @@ static void rtw8852c_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852c_set_tx_shape(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
 				  enum rtw89_phy_idx phy_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 tx_shape_cck = rtw89_8852c_tx_shape[band][RTW89_RS_CCK][regd];
@@ -2099,10 +2103,10 @@ static void rtw8852c_set_tx_shape(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852c_set_txpwr_limit(struct rtw89_dev *rtwdev,
+				     const struct rtw89_chan *chan,
 				     enum rtw89_phy_idx phy_idx)
 {
 #define __MAC_TXPWR_LMT_PAGE_SIZE 40
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 ch = chan->channel;
 	u8 bw = chan->band_width;
 	struct rtw89_txpwr_limit lmt[NTX_NUM_8852C];
@@ -2114,7 +2118,7 @@ static void rtw8852c_set_txpwr_limit(struct rtw89_dev *rtwdev,
 		    "[TXPWR] set txpwr limit with ch=%d bw=%d\n", ch, bw);
 
 	for (i = 0; i < NTX_NUM_8852C; i++) {
-		rtw89_phy_fill_txpwr_limit(rtwdev, &lmt[i], i);
+		rtw89_phy_fill_txpwr_limit(rtwdev, chan, &lmt[i], i);
 
 		for (j = 0; j < __MAC_TXPWR_LMT_PAGE_SIZE; j += 4) {
 			addr = R_AX_PWR_LMT + j + __MAC_TXPWR_LMT_PAGE_SIZE * i;
@@ -2131,10 +2135,10 @@ static void rtw8852c_set_txpwr_limit(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852c_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan,
 					enum rtw89_phy_idx phy_idx)
 {
 #define __MAC_TXPWR_LMT_RU_PAGE_SIZE 24
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 ch = chan->channel;
 	u8 bw = chan->band_width;
 	struct rtw89_txpwr_limit_ru lmt_ru[NTX_NUM_8852C];
@@ -2146,7 +2150,7 @@ static void rtw8852c_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 		    "[TXPWR] set txpwr limit ru with ch=%d bw=%d\n", ch, bw);
 
 	for (i = 0; i < NTX_NUM_8852C; i++) {
-		rtw89_phy_fill_txpwr_limit_ru(rtwdev, &lmt_ru[i], i);
+		rtw89_phy_fill_txpwr_limit_ru(rtwdev, chan, &lmt_ru[i], i);
 
 		for (j = 0; j < __MAC_TXPWR_LMT_RU_PAGE_SIZE; j += 4) {
 			addr = R_AX_PWR_RU_LMT + j +
@@ -2164,18 +2168,21 @@ static void rtw8852c_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 #undef __MAC_TXPWR_LMT_RU_PAGE_SIZE
 }
 
-static void rtw8852c_set_txpwr(struct rtw89_dev *rtwdev)
+static void rtw8852c_set_txpwr(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan,
+			       enum rtw89_phy_idx phy_idx)
 {
-	rtw8852c_set_txpwr_byrate(rtwdev, RTW89_PHY_0);
-	rtw8852c_set_txpwr_offset(rtwdev, RTW89_PHY_0);
-	rtw8852c_set_tx_shape(rtwdev, RTW89_PHY_0);
-	rtw8852c_set_txpwr_limit(rtwdev, RTW89_PHY_0);
-	rtw8852c_set_txpwr_limit_ru(rtwdev, RTW89_PHY_0);
+	rtw8852c_set_txpwr_byrate(rtwdev, chan, phy_idx);
+	rtw8852c_set_txpwr_offset(rtwdev, chan, phy_idx);
+	rtw8852c_set_tx_shape(rtwdev, chan, phy_idx);
+	rtw8852c_set_txpwr_limit(rtwdev, chan, phy_idx);
+	rtw8852c_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
 }
 
-static void rtw8852c_set_txpwr_ctrl(struct rtw89_dev *rtwdev)
+static void rtw8852c_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy_idx)
 {
-	rtw8852c_set_txpwr_ref(rtwdev, RTW89_PHY_0);
+	rtw8852c_set_txpwr_ref(rtwdev, phy_idx);
 }
 
 static void
-- 
2.25.1


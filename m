Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3554F39E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 10:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381235AbiFQIwI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 04:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381208AbiFQIwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 04:52:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D8469B51
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 01:52:05 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25H8pxP13021038, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25H8pxP13021038
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jun 2022 16:51:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 17 Jun 2022 16:51:59 +0800
Received: from localhost (172.16.16.131) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 17 Jun
 2022 16:51:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 07/13] rtw89: concentrate parameter control for setting channel callback
Date:   Fri, 17 Jun 2022 16:49:48 +0800
Message-ID: <20220617084954.61261-8-pkshih@realtek.com>
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

For future support on multiple channels by multiple sub-entities,
we need to manage parameters of each channel instance like rtw89_chan,
rtw89_mac_idx, rtw89_phy_idx. So, we adjust related channel callback
functions and centrally conrtol these parameters in set_channel().

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  8 ++--
 drivers/net/wireless/realtek/rtw89/core.h     | 25 +++++++++---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 28 +++++++------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 40 ++++++++++---------
 4 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 071f623f97abb..78b074d3e213e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -318,13 +318,15 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 
 	rtw89_set_entity_state(rtwdev, true);
 
-	rtw89_chip_set_channel_prepare(rtwdev, &bak);
+	rtw89_chip_set_channel_prepare(rtwdev, &bak, &chan,
+				       RTW89_MAC_0, RTW89_PHY_0);
 
-	chip->ops->set_channel(rtwdev, &chan);
+	chip->ops->set_channel(rtwdev, &chan, RTW89_MAC_0, RTW89_PHY_0);
 
 	rtw89_core_set_chip_txpwr(rtwdev);
 
-	rtw89_chip_set_channel_done(rtwdev, &bak);
+	rtw89_chip_set_channel_done(rtwdev, &bak, &chan,
+				    RTW89_MAC_0, RTW89_PHY_0);
 
 	if (!entity_active || band_changed) {
 		rtw89_btc_ntfy_switch_band(rtwdev, RTW89_PHY_0, chan.band_type);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7b9f1cb78992a..b71bd0358b764 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2112,9 +2112,14 @@ struct rtw89_chip_ops {
 	bool (*write_rf)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			 u32 addr, u32 mask, u32 data);
 	void (*set_channel)(struct rtw89_dev *rtwdev,
-			    const struct rtw89_chan *chan);
+			    const struct rtw89_chan *chan,
+			    enum rtw89_mac_idx mac_idx,
+			    enum rtw89_phy_idx phy_idx);
 	void (*set_channel_help)(struct rtw89_dev *rtwdev, bool enter,
-				 struct rtw89_channel_help_params *p);
+				 struct rtw89_channel_help_params *p,
+				 const struct rtw89_chan *chan,
+				 enum rtw89_mac_idx mac_idx,
+				 enum rtw89_phy_idx phy_idx);
 	int (*read_efuse)(struct rtw89_dev *rtwdev, u8 *log_map);
 	int (*read_phycap)(struct rtw89_dev *rtwdev, u8 *phycap_map);
 	void (*fem_setup)(struct rtw89_dev *rtwdev);
@@ -3581,16 +3586,24 @@ struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif *rtwvif,
 
 static inline
 void rtw89_chip_set_channel_prepare(struct rtw89_dev *rtwdev,
-				    struct rtw89_channel_help_params *p)
+				    struct rtw89_channel_help_params *p,
+				    const struct rtw89_chan *chan,
+				    enum rtw89_mac_idx mac_idx,
+				    enum rtw89_phy_idx phy_idx)
 {
-	rtwdev->chip->ops->set_channel_help(rtwdev, true, p);
+	rtwdev->chip->ops->set_channel_help(rtwdev, true, p, chan,
+					    mac_idx, phy_idx);
 }
 
 static inline
 void rtw89_chip_set_channel_done(struct rtw89_dev *rtwdev,
-				 struct rtw89_channel_help_params *p)
+				 struct rtw89_channel_help_params *p,
+				 const struct rtw89_chan *chan,
+				 enum rtw89_mac_idx mac_idx,
+				 enum rtw89_phy_idx phy_idx)
 {
-	rtwdev->chip->ops->set_channel_help(rtwdev, false, p);
+	rtwdev->chip->ops->set_channel_help(rtwdev, false, p, chan,
+					    mac_idx, phy_idx);
 }
 
 static inline
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 3630c1801dcc4..2cf72dd322ba2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1156,10 +1156,12 @@ static void rtw8852a_set_channel_bb(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852a_set_channel(struct rtw89_dev *rtwdev,
-				 const struct rtw89_chan *chan)
+				 const struct rtw89_chan *chan,
+				 enum rtw89_mac_idx mac_idx,
+				 enum rtw89_phy_idx phy_idx)
 {
-	rtw8852a_set_channel_mac(rtwdev, chan, RTW89_MAC_0);
-	rtw8852a_set_channel_bb(rtwdev, chan, RTW89_PHY_0);
+	rtw8852a_set_channel_mac(rtwdev, chan, mac_idx);
+	rtw8852a_set_channel_bb(rtwdev, chan, phy_idx);
 }
 
 static void rtw8852a_dfs_en(struct rtw89_dev *rtwdev, bool en)
@@ -1210,25 +1212,27 @@ static void rtw8852a_adc_en(struct rtw89_dev *rtwdev, bool en)
 }
 
 static void rtw8852a_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
-				      struct rtw89_channel_help_params *p)
+				      struct rtw89_channel_help_params *p,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_mac_idx mac_idx,
+				      enum rtw89_phy_idx phy_idx)
 {
-	u8 phy_idx = RTW89_PHY_0;
-
 	if (enter) {
-		rtw89_chip_stop_sch_tx(rtwdev, RTW89_MAC_0, &p->tx_en, RTW89_SCH_TX_SEL_ALL);
-		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
+		rtw89_chip_stop_sch_tx(rtwdev, mac_idx, &p->tx_en,
+				       RTW89_SCH_TX_SEL_ALL);
+		rtw89_mac_cfg_ppdu_status(rtwdev, mac_idx, false);
 		rtw8852a_dfs_en(rtwdev, false);
-		rtw8852a_tssi_cont_en_phyidx(rtwdev, false, RTW89_PHY_0);
+		rtw8852a_tssi_cont_en_phyidx(rtwdev, false, phy_idx);
 		rtw8852a_adc_en(rtwdev, false);
 		fsleep(40);
 		rtw8852a_bb_reset_en(rtwdev, phy_idx, false);
 	} else {
-		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
+		rtw89_mac_cfg_ppdu_status(rtwdev, mac_idx, true);
 		rtw8852a_adc_en(rtwdev, true);
 		rtw8852a_dfs_en(rtwdev, true);
-		rtw8852a_tssi_cont_en_phyidx(rtwdev, true, RTW89_PHY_0);
+		rtw8852a_tssi_cont_en_phyidx(rtwdev, true, phy_idx);
 		rtw8852a_bb_reset_en(rtwdev, phy_idx, true);
-		rtw89_chip_resume_sch_tx(rtwdev, RTW89_MAC_0, p->tx_en);
+		rtw89_chip_resume_sch_tx(rtwdev, mac_idx, p->tx_en);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ab7eb6c0408e1..7a2822f3bdf04 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1529,11 +1529,9 @@ static void rtw8852c_bb_reset_all(struct rtw89_dev *rtwdev,
 			      phy_idx);
 }
 
-static void rtw8852c_bb_reset_en(struct rtw89_dev *rtwdev,
+static void rtw8852c_bb_reset_en(struct rtw89_dev *rtwdev, enum rtw89_band band,
 				 enum rtw89_phy_idx phy_idx, bool en)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-
 	if (en) {
 		rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS,
 				      B_S0_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
@@ -1541,7 +1539,7 @@ static void rtw8852c_bb_reset_en(struct rtw89_dev *rtwdev,
 				      B_S1_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1,
 				      phy_idx);
-		if (chan->band_type == RTW89_BAND_2G)
+		if (band == RTW89_BAND_2G)
 			rtw89_phy_write32_mask(rtwdev, R_RXCCA_V1, B_RXCCA_DIS_V1, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x0);
 	} else {
@@ -1777,11 +1775,13 @@ static void rtw8852c_set_channel_bb(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852c_set_channel(struct rtw89_dev *rtwdev,
-				 const struct rtw89_chan *chan)
+				 const struct rtw89_chan *chan,
+				 enum rtw89_mac_idx mac_idx,
+				 enum rtw89_phy_idx phy_idx)
 {
-	rtw8852c_set_channel_mac(rtwdev, chan, RTW89_MAC_0);
-	rtw8852c_set_channel_bb(rtwdev, chan, RTW89_PHY_0);
-	rtw8852c_set_channel_rf(rtwdev, chan, RTW89_PHY_0);
+	rtw8852c_set_channel_mac(rtwdev, chan, mac_idx);
+	rtw8852c_set_channel_bb(rtwdev, chan, phy_idx);
+	rtw8852c_set_channel_rf(rtwdev, chan, phy_idx);
 }
 
 static void rtw8852c_dfs_en(struct rtw89_dev *rtwdev, bool en)
@@ -1803,25 +1803,27 @@ static void rtw8852c_adc_en(struct rtw89_dev *rtwdev, bool en)
 }
 
 static void rtw8852c_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
-				      struct rtw89_channel_help_params *p)
+				      struct rtw89_channel_help_params *p,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_mac_idx mac_idx,
+				      enum rtw89_phy_idx phy_idx)
 {
-	u8 phy_idx = RTW89_PHY_0;
-
 	if (enter) {
-		rtw89_chip_stop_sch_tx(rtwdev, RTW89_MAC_0, &p->tx_en, RTW89_SCH_TX_SEL_ALL);
-		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
+		rtw89_chip_stop_sch_tx(rtwdev, mac_idx, &p->tx_en,
+				       RTW89_SCH_TX_SEL_ALL);
+		rtw89_mac_cfg_ppdu_status(rtwdev, mac_idx, false);
 		rtw8852c_dfs_en(rtwdev, false);
-		rtw8852c_tssi_cont_en_phyidx(rtwdev, false, RTW89_PHY_0);
+		rtw8852c_tssi_cont_en_phyidx(rtwdev, false, phy_idx);
 		rtw8852c_adc_en(rtwdev, false);
 		fsleep(40);
-		rtw8852c_bb_reset_en(rtwdev, phy_idx, false);
+		rtw8852c_bb_reset_en(rtwdev, chan->band_type, phy_idx, false);
 	} else {
-		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
+		rtw89_mac_cfg_ppdu_status(rtwdev, mac_idx, true);
 		rtw8852c_adc_en(rtwdev, true);
 		rtw8852c_dfs_en(rtwdev, true);
-		rtw8852c_tssi_cont_en_phyidx(rtwdev, true, RTW89_PHY_0);
-		rtw8852c_bb_reset_en(rtwdev, phy_idx, true);
-		rtw89_chip_resume_sch_tx(rtwdev, RTW89_MAC_0, p->tx_en);
+		rtw8852c_tssi_cont_en_phyidx(rtwdev, true, phy_idx);
+		rtw8852c_bb_reset_en(rtwdev, chan->band_type, phy_idx, true);
+		rtw89_chip_resume_sch_tx(rtwdev, mac_idx, p->tx_en);
 	}
 }
 
-- 
2.25.1


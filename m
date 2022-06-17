Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F854F39C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 10:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381343AbiFQIwQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381208AbiFQIwM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 04:52:12 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E769B44
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 01:52:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25H8q5Dd9021075, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25H8q5Dd9021075
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jun 2022 16:52:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 17 Jun 2022 16:52:05 +0800
Received: from localhost (172.16.16.131) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 17 Jun
 2022 16:52:04 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 10/13] rtw89: introduce entity mode and its recalculated prototype
Date:   Fri, 17 Jun 2022 16:49:51 +0800
Message-ID: <20220617084954.61261-11-pkshih@realtek.com>
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

After supporting more than one channel, we need entity mode to decide
how to set current channel(s) on the sub-entities. This decision may
happen on set_channel() and rtw89_core_set_chip_txpwr().

For now, we support single one channel and use only first HW entry,
i.e. RTW89_SUB_ENTITY_0, RTW89_MAC_0, RTW89_PHY_0. Without something
unexpected, the entity mode should always be RTW89_ENT_MODE_SCC after
recalcated, where SCC means single channel concurrency. So, an assert
is added in set_channel() and rtw89_core_set_chip_txpwr().

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 25 ++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h | 17 +++++++++
 drivers/net/wireless/realtek/rtw89/core.c | 46 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h |  5 +++
 4 files changed, 79 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index e0f1c89bbfa6b..02d31f751d3e7 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -3,6 +3,7 @@
  */
 
 #include "chan.h"
+#include "debug.h"
 
 static enum rtw89_subband rtw89_get_subband_type(enum rtw89_band band,
 						 u8 center_chan)
@@ -154,3 +155,27 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 	bitmap_zero(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
 	rtw89_config_default_chandef(rtwdev);
 }
+
+enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	enum rtw89_entity_mode mode;
+	u8 weight;
+
+	weight = bitmap_weight(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+	switch (weight) {
+	default:
+		rtw89_warn(rtwdev, "unknown ent chan weight: %d\n", weight);
+		bitmap_zero(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+		fallthrough;
+	case 0:
+		rtw89_config_default_chandef(rtwdev);
+		fallthrough;
+	case 1:
+		mode = RTW89_ENTITY_MODE_SCC;
+		break;
+	}
+
+	rtw89_set_entity_mode(rtwdev, mode);
+	return mode;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 9c714f00c3c13..6b2b5cc0d798b 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -21,6 +21,22 @@ static inline void rtw89_set_entity_state(struct rtw89_dev *rtwdev, bool active)
 	WRITE_ONCE(hal->entity_active, active);
 }
 
+static inline
+enum rtw89_entity_mode rtw89_get_entity_mode(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	return READ_ONCE(hal->entity_mode);
+}
+
+static inline void rtw89_set_entity_mode(struct rtw89_dev *rtwdev,
+					 enum rtw89_entity_mode mode)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	WRITE_ONCE(hal->entity_mode, mode);
+}
+
 void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
 		       enum rtw89_band band, enum rtw89_bandwidth bandwidth);
 bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
@@ -30,5 +46,6 @@ void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 				 enum rtw89_sub_entity_idx idx,
 				 const struct cfg80211_chan_def *chandef);
 void rtw89_entity_init(struct rtw89_dev *rtwdev);
+enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0c04d6ed3b851..23d90ea98e7f1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -294,51 +294,69 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_chan *chan;
+	enum rtw89_sub_entity_idx sub_entity_idx;
+	enum rtw89_phy_idx phy_idx;
+	enum rtw89_entity_mode mode;
 	bool entity_active;
 
 	entity_active = rtw89_get_entity_state(rtwdev);
 	if (!entity_active)
 		return;
 
-	chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	mode = rtw89_get_entity_mode(rtwdev);
+	if (WARN(mode != RTW89_ENTITY_MODE_SCC, "Invalid ent mode: %d\n", mode))
+		return;
+
+	sub_entity_idx = RTW89_SUB_ENTITY_0;
+	phy_idx = RTW89_PHY_0;
+	chan = rtw89_chan_get(rtwdev, sub_entity_idx);
 	if (chip->ops->set_txpwr)
-		chip->ops->set_txpwr(rtwdev, chan, RTW89_PHY_0);
+		chip->ops->set_txpwr(rtwdev, chan, phy_idx);
 }
 
 void rtw89_set_channel(struct rtw89_dev *rtwdev)
 {
-	const struct cfg80211_chan_def *chandef =
-		rtw89_chandef_get(rtwdev, RTW89_SUB_ENTITY_0);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct cfg80211_chan_def *chandef;
+	enum rtw89_sub_entity_idx sub_entity_idx;
+	enum rtw89_mac_idx mac_idx;
+	enum rtw89_phy_idx phy_idx;
 	struct rtw89_chan chan;
 	struct rtw89_channel_help_params bak;
+	enum rtw89_entity_mode mode;
 	bool band_changed;
 	bool entity_active;
 
 	entity_active = rtw89_get_entity_state(rtwdev);
 
+	mode = rtw89_entity_recalc(rtwdev);
+	if (WARN(mode != RTW89_ENTITY_MODE_SCC, "Invalid ent mode: %d\n", mode))
+		return;
+
+	sub_entity_idx = RTW89_SUB_ENTITY_0;
+	mac_idx = RTW89_MAC_0;
+	phy_idx = RTW89_PHY_0;
+	chandef = rtw89_chandef_get(rtwdev, sub_entity_idx);
 	rtw89_get_channel_params(chandef, &chan);
 	if (WARN(chan.channel == 0, "Invalid channel\n"))
 		return;
 
-	band_changed = rtw89_assign_entity_chan(rtwdev, RTW89_SUB_ENTITY_0, &chan);
-
-	rtw89_set_entity_state(rtwdev, true);
+	band_changed = rtw89_assign_entity_chan(rtwdev, sub_entity_idx, &chan);
 
-	rtw89_chip_set_channel_prepare(rtwdev, &bak, &chan,
-				       RTW89_MAC_0, RTW89_PHY_0);
+	rtw89_chip_set_channel_prepare(rtwdev, &bak, &chan, mac_idx, phy_idx);
 
-	chip->ops->set_channel(rtwdev, &chan, RTW89_MAC_0, RTW89_PHY_0);
+	chip->ops->set_channel(rtwdev, &chan, mac_idx, phy_idx);
 
 	rtw89_core_set_chip_txpwr(rtwdev);
 
-	rtw89_chip_set_channel_done(rtwdev, &bak, &chan,
-				    RTW89_MAC_0, RTW89_PHY_0);
+	rtw89_chip_set_channel_done(rtwdev, &bak, &chan, mac_idx, phy_idx);
 
 	if (!entity_active || band_changed) {
-		rtw89_btc_ntfy_switch_band(rtwdev, RTW89_PHY_0, chan.band_type);
-		rtw89_chip_rfk_band_changed(rtwdev, RTW89_PHY_0);
+		rtw89_btc_ntfy_switch_band(rtwdev, phy_idx, chan.band_type);
+		rtw89_chip_rfk_band_changed(rtwdev, phy_idx);
 	}
+
+	rtw89_set_entity_state(rtwdev, true);
 }
 
 static enum rtw89_core_tx_type
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cd775118e2254..d57bd29eedba0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2620,6 +2620,10 @@ struct rtw89_sar_info {
 	};
 };
 
+enum rtw89_entity_mode {
+	RTW89_ENTITY_MODE_SCC,
+};
+
 struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
@@ -2635,6 +2639,7 @@ struct rtw89_hal {
 	struct cfg80211_chan_def chandef[NUM_OF_RTW89_SUB_ENTITY];
 
 	bool entity_active;
+	enum rtw89_entity_mode entity_mode;
 
 	struct rtw89_chan chan[NUM_OF_RTW89_SUB_ENTITY];
 	struct rtw89_chan_rcd chan_rcd[NUM_OF_RTW89_SUB_ENTITY];
-- 
2.25.1


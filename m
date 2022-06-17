Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80E54F39A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 10:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381316AbiFQIwJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 04:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381208AbiFQIwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 04:52:09 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A3E69B79
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 01:52:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25H8q1Rq9021052, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25H8q1Rq9021052
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jun 2022 16:52:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 16:52:01 +0800
Received: from localhost (172.16.16.131) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 17 Jun
 2022 16:52:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 08/13] rtw89: concentrate chandef setting to stack callback
Date:   Fri, 17 Jun 2022 16:49:49 +0800
Message-ID: <20220617084954.61261-9-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

Originally, we didn't support mac80211 chanctx, so it's expected that
ieee80211_hw::conf::chandef would be filled by mac80211. And then, we
could just query it whenever we need the current chandef.

However, we are planing to support mac80211 chanctx. After that, the
above assumption would be broken. So, we adjust a bit ahead to reduce
future works about mac80211 chanctx.

After this, we don't query ieee80211_hw::conf::chandef directly, and
we add a map, entity_map, to HAL to indicate which chandef came from
stack. And it will later be used to recalcate entity mode.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 20 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |  3 +++
 drivers/net/wireless/realtek/rtw89/core.c     | 14 +++++++------
 drivers/net/wireless/realtek/rtw89/core.h     | 12 +++++++++++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  6 +++++-
 5 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 0bf27a344d2b4..a9f0133f8089d 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -118,3 +118,23 @@ bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 	*chan = *new;
 	return band_changed;
 }
+
+static void __rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
+					  enum rtw89_sub_entity_idx idx,
+					  const struct cfg80211_chan_def *chandef,
+					  bool from_stack)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	hal->chandef[idx] = *chandef;
+
+	if (from_stack)
+		set_bit(idx, hal->entity_map);
+}
+
+void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
+				 enum rtw89_sub_entity_idx idx,
+				 const struct cfg80211_chan_def *chandef)
+{
+	__rtw89_config_entity_chandef(rtwdev, idx, chandef, true);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index d39311a3d5baf..b2022bb0afc6a 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -26,5 +26,8 @@ void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
 bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 			      enum rtw89_sub_entity_idx idx,
 			      const struct rtw89_chan *new);
+void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
+				 enum rtw89_sub_entity_idx idx,
+				 const struct cfg80211_chan_def *chandef);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 78b074d3e213e..7d3194bfbcb96 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -224,7 +224,7 @@ static void rtw89_traffic_stats_accu(struct rtw89_dev *rtwdev,
 	}
 }
 
-static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
+static void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
 				     struct rtw89_chan *chan)
 {
 	struct ieee80211_channel *channel = chandef->chan;
@@ -301,7 +301,8 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 
 void rtw89_set_channel(struct rtw89_dev *rtwdev)
 {
-	struct ieee80211_hw *hw = rtwdev->hw;
+	const struct cfg80211_chan_def *chandef =
+		rtw89_chandef_get(rtwdev, RTW89_SUB_ENTITY_0);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_chan chan;
 	struct rtw89_channel_help_params bak;
@@ -310,7 +311,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 
 	entity_active = rtw89_get_entity_state(rtwdev);
 
-	rtw89_get_channel_params(&hw->conf.chandef, &chan);
+	rtw89_get_channel_params(chandef, &chan);
 	if (WARN(chan.channel == 0, "Invalid channel\n"))
 		return;
 
@@ -1589,14 +1590,15 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 					struct rtw89_rx_desc_info *desc_info,
 					struct ieee80211_rx_status *rx_status)
 {
-	struct ieee80211_hw *hw = rtwdev->hw;
+	const struct cfg80211_chan_def *chandef =
+		rtw89_chandef_get(rtwdev, RTW89_SUB_ENTITY_0);
 	const struct rtw89_chan *cur = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u16 data_rate;
 	u8 data_rate_mode;
 
 	/* currently using single PHY */
-	rx_status->freq = hw->conf.chandef.chan->center_freq;
-	rx_status->band = hw->conf.chandef.chan->band;
+	rx_status->freq = chandef->chan->center_freq;
+	rx_status->band = chandef->chan->band;
 
 	if (rtwdev->scanning &&
 	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b71bd0358b764..712635be1fa4e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2631,6 +2631,9 @@ struct rtw89_hal {
 	bool support_cckpd;
 	bool support_igi;
 
+	DECLARE_BITMAP(entity_map, NUM_OF_RTW89_SUB_ENTITY);
+	struct cfg80211_chan_def chandef[NUM_OF_RTW89_SUB_ENTITY];
+
 	bool entity_active;
 
 	struct rtw89_chan chan[NUM_OF_RTW89_SUB_ENTITY];
@@ -3606,6 +3609,15 @@ void rtw89_chip_set_channel_done(struct rtw89_dev *rtwdev,
 					    mac_idx, phy_idx);
 }
 
+static inline
+const struct cfg80211_chan_def *rtw89_chandef_get(struct rtw89_dev *rtwdev,
+						  enum rtw89_sub_entity_idx idx)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	return &hal->chandef[idx];
+}
+
 static inline
 const struct rtw89_chan *rtw89_chan_get(struct rtw89_dev *rtwdev,
 					enum rtw89_sub_entity_idx idx)
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 25ad7280d60e7..fcea77622ee0f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -3,6 +3,7 @@
  */
 
 #include "cam.h"
+#include "chan.h"
 #include "coex.h"
 #include "debug.h"
 #include "fw.h"
@@ -85,8 +86,11 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 		}
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
+		rtw89_config_entity_chandef(rtwdev, RTW89_SUB_ENTITY_0,
+					    &hw->conf.chandef);
 		rtw89_set_channel(rtwdev);
+	}
 
 	if ((changed & IEEE80211_CONF_CHANGE_IDLE) &&
 	    (hw->conf.flags & IEEE80211_CONF_IDLE))
-- 
2.25.1


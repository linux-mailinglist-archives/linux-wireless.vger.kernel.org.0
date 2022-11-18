Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B7862ED14
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 06:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiKRFLx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Nov 2022 00:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiKRFLq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Nov 2022 00:11:46 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6902F6D4A7
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 21:11:45 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AI5Aw1bA003118, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AI5Aw1bA003118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 18 Nov 2022 13:10:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 18 Nov 2022 13:11:39 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 18 Nov
 2022 13:11:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: link rtw89_vif and chanctx stuffs
Date:   Fri, 18 Nov 2022 13:10:42 +0800
Message-ID: <20221118051042.29968-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118051042.29968-1-pkshih@realtek.com>
References: <20221118051042.29968-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/18/2022 04:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzE3IKRVpMggMTA6MDA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

First, introduce struct rtw89_sub_entity for chanctx related stuffs.
Second, add enum rtw89_sub_entity_idx to rtw89_vif for vif operation
to access its/right chanctx stuffs after future multi-channel support.

Besides, RTW89_SUB_ENTITY_0 is the default chanctx entry throughout
driver, i.e. it's used for things which may not have a target chanctx
yet. So, we need to ensure that RTW89_SUB_ENTITY_0 is always working.
If there is at least one alive chanctx, then one of them must take
RTW89_SUB_ENTITY_0. If no alive chanctx, RTW89_SUB_ENTITY_0 will be
filled by rtw89_config_default_chandef().

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 40 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     | 20 ++++++----
 drivers/net/wireless/realtek/rtw89/mac80211.c |  1 +
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index a4f61c2f65123..90596806bc93f 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -4,6 +4,7 @@
 
 #include "chan.h"
 #include "debug.h"
+#include "util.h"
 
 static enum rtw89_subband rtw89_get_subband_type(enum rtw89_band band,
 						 u8 center_chan)
@@ -108,8 +109,8 @@ bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 			      const struct rtw89_chan *new)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	struct rtw89_chan *chan = &hal->chan[idx];
-	struct rtw89_chan_rcd *rcd = &hal->chan_rcd[idx];
+	struct rtw89_chan *chan = &hal->sub[idx].chan;
+	struct rtw89_chan_rcd *rcd = &hal->sub[idx].rcd;
 	bool band_changed;
 
 	rcd->prev_primary_channel = chan->primary_channel;
@@ -127,7 +128,7 @@ static void __rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	hal->chandef[idx] = *chandef;
+	hal->sub[idx].chandef = *chandef;
 
 	if (from_stack)
 		set_bit(idx, hal->entity_map);
@@ -195,6 +196,7 @@ int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 	rtw89_config_entity_chandef(rtwdev, idx, &ctx->def);
 	rtw89_set_channel(rtwdev);
 	cfg->idx = idx;
+	hal->sub[idx].cfg = cfg;
 	return 0;
 }
 
@@ -203,8 +205,34 @@ void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	struct rtw89_vif *rtwvif;
+	u8 drop, roll;
 
-	clear_bit(cfg->idx, hal->entity_map);
+	drop = cfg->idx;
+	if (drop != RTW89_SUB_ENTITY_0)
+		goto out;
+
+	roll = find_next_bit(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY, drop + 1);
+
+	/* Follow rtw89_config_default_chandef() when rtw89_entity_recalc(). */
+	if (roll == NUM_OF_RTW89_SUB_ENTITY)
+		goto out;
+
+	/* RTW89_SUB_ENTITY_0 is going to release, and another exists.
+	 * Make another roll down to RTW89_SUB_ENTITY_0 to replace.
+	 */
+	hal->sub[roll].cfg->idx = RTW89_SUB_ENTITY_0;
+	hal->sub[RTW89_SUB_ENTITY_0] = hal->sub[roll];
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		if (rtwvif->sub_entity_idx == roll)
+			rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
+	}
+
+	drop = roll;
+
+out:
+	clear_bit(drop, hal->entity_map);
 	rtw89_set_channel(rtwdev);
 }
 
@@ -225,6 +253,9 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif,
 				 struct ieee80211_chanctx_conf *ctx)
 {
+	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+
+	rtwvif->sub_entity_idx = cfg->idx;
 	return 0;
 }
 
@@ -232,4 +263,5 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif *rtwvif,
 				    struct ieee80211_chanctx_conf *ctx)
 {
+	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cbcbf09dbb273..fdf0a2d63d53c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2239,6 +2239,8 @@ struct rtw89_phy_rate_pattern {
 struct rtw89_vif {
 	struct list_head list;
 	struct rtw89_dev *rtwdev;
+	enum rtw89_sub_entity_idx sub_entity_idx;
+
 	u8 mac_id;
 	u8 port;
 	u8 mac_addr[ETH_ALEN];
@@ -2949,6 +2951,13 @@ enum rtw89_entity_mode {
 	RTW89_ENTITY_MODE_SCC,
 };
 
+struct rtw89_sub_entity {
+	struct cfg80211_chan_def chandef;
+	struct rtw89_chan chan;
+	struct rtw89_chan_rcd rcd;
+	struct rtw89_chanctx_cfg *cfg;
+};
+
 struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
@@ -2962,13 +2971,10 @@ struct rtw89_hal {
 	bool support_igi;
 
 	DECLARE_BITMAP(entity_map, NUM_OF_RTW89_SUB_ENTITY);
-	struct cfg80211_chan_def chandef[NUM_OF_RTW89_SUB_ENTITY];
+	struct rtw89_sub_entity sub[NUM_OF_RTW89_SUB_ENTITY];
 
 	bool entity_active;
 	enum rtw89_entity_mode entity_mode;
-
-	struct rtw89_chan chan[NUM_OF_RTW89_SUB_ENTITY];
-	struct rtw89_chan_rcd chan_rcd[NUM_OF_RTW89_SUB_ENTITY];
 };
 
 #define RTW89_MAX_MAC_ID_NUM 128
@@ -4132,7 +4138,7 @@ const struct cfg80211_chan_def *rtw89_chandef_get(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	return &hal->chandef[idx];
+	return &hal->sub[idx].chandef;
 }
 
 static inline
@@ -4141,7 +4147,7 @@ const struct rtw89_chan *rtw89_chan_get(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	return &hal->chan[idx];
+	return &hal->sub[idx].chan;
 }
 
 static inline
@@ -4150,7 +4156,7 @@ const struct rtw89_chan_rcd *rtw89_chan_rcd_get(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	return &hal->chan_rcd[idx];
+	return &hal->sub[idx].rcd;
 }
 
 static inline void rtw89_chip_fem_setup(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 6e79bf899901d..3c8c7c6adbf08 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -131,6 +131,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->bcn_hit_cond = 0;
 	rtwvif->mac_idx = RTW89_MAC_0;
 	rtwvif->phy_idx = RTW89_PHY_0;
+	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
 	rtwvif->hit_rule = 0;
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
 
-- 
2.25.1


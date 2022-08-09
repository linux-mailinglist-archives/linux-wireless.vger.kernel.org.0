Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C0D58D7A4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiHIKut (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 06:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242637AbiHIKuj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 06:50:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD7AF5F49
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 03:50:35 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 279AoJGy9018871, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 279AoJGy9018871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 9 Aug 2022 18:50:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 18:50:29 +0800
Received: from localhost (172.16.16.191) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Aug 2022
 18:50:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 11/13] wifi: rtw89: add skeleton of mac80211 chanctx ops support
Date:   Tue, 9 Aug 2022 18:49:50 +0800
Message-ID: <20220809104952.61355-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809104952.61355-1-pkshih@realtek.com>
References: <20220809104952.61355-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.191]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2022 10:19:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvOSCkV6TIIDA4OjU0OjAw?=
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

Support mac80211 chanctx series ops. Still, currently support
single channel. Based on this premise, things should be similar
to before. So, we haven't dealt with relationship between vif
and chanctx in depth. Instead, we leave both ::assign_vif()
and ::unassign_vif() as noops for now.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 53 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h     | 13 ++++
 drivers/net/wireless/realtek/rtw89/core.c     |  1 +
 drivers/net/wireless/realtek/rtw89/core.h     |  4 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 68 +++++++++++++++++++
 5 files changed, 139 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 02d31f751d3e7..cccbd9c8c59b8 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -179,3 +179,56 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 	rtw89_set_entity_mode(rtwdev, mode);
 	return mode;
 }
+
+int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
+			  struct ieee80211_chanctx_conf *ctx)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	u8 idx;
+
+	idx = find_first_zero_bit(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+	if (idx > RTW89_SUB_ENTITY_0)
+		return -ENOENT;
+
+	rtw89_config_entity_chandef(rtwdev, idx, &ctx->def);
+	rtw89_set_channel(rtwdev);
+	cfg->idx = idx;
+	return 0;
+}
+
+void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
+			      struct ieee80211_chanctx_conf *ctx)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+
+	clear_bit(cfg->idx, hal->entity_map);
+	rtw89_set_channel(rtwdev);
+}
+
+void rtw89_chanctx_ops_change(struct rtw89_dev *rtwdev,
+			      struct ieee80211_chanctx_conf *ctx,
+			      u32 changed)
+{
+	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	u8 idx = cfg->idx;
+
+	if (changed & IEEE80211_CHANCTX_CHANGE_WIDTH) {
+		rtw89_config_entity_chandef(rtwdev, idx, &ctx->def);
+		rtw89_set_channel(rtwdev);
+	}
+}
+
+int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif,
+				 struct ieee80211_chanctx_conf *ctx)
+{
+	return 0;
+}
+
+void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif,
+				    struct ieee80211_chanctx_conf *ctx)
+{
+}
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 6b2b5cc0d798b..ecbd4503bead9 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -47,5 +47,18 @@ void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 				 const struct cfg80211_chan_def *chandef);
 void rtw89_entity_init(struct rtw89_dev *rtwdev);
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev);
+int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
+			  struct ieee80211_chanctx_conf *ctx);
+void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
+			      struct ieee80211_chanctx_conf *ctx);
+void rtw89_chanctx_ops_change(struct rtw89_dev *rtwdev,
+			      struct ieee80211_chanctx_conf *ctx,
+			      u32 changed);
+int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif,
+				 struct ieee80211_chanctx_conf *ctx);
+void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif,
+				    struct ieee80211_chanctx_conf *ctx);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index dea4280039e6a..885ef1525868a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3114,6 +3114,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	hw->vif_data_size = sizeof(struct rtw89_vif);
 	hw->sta_data_size = sizeof(struct rtw89_sta);
 	hw->txq_data_size = sizeof(struct rtw89_txq);
+	hw->chanctx_data_size = sizeof(struct rtw89_chanctx_cfg);
 
 	SET_IEEE80211_PERM_ADDR(hw, efuse->addr);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 96af628d8d46e..26f1fc9561e04 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2623,6 +2623,10 @@ struct rtw89_sar_info {
 	};
 };
 
+struct rtw89_chanctx_cfg {
+	enum rtw89_sub_entity_idx idx;
+};
+
 enum rtw89_entity_mode {
 	RTW89_ENTITY_MODE_SCC,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 5da50b2c4abfc..668370cf8158a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -777,6 +777,69 @@ static void rtw89_ops_sta_rc_update(struct ieee80211_hw *hw,
 	rtw89_phy_ra_updata_sta(rtwdev, sta, changed);
 }
 
+static int rtw89_ops_add_chanctx(struct ieee80211_hw *hw,
+				 struct ieee80211_chanctx_conf *ctx)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	int ret;
+
+	mutex_lock(&rtwdev->mutex);
+	ret = rtw89_chanctx_ops_add(rtwdev, ctx);
+	mutex_unlock(&rtwdev->mutex);
+
+	return ret;
+}
+
+static void rtw89_ops_remove_chanctx(struct ieee80211_hw *hw,
+				     struct ieee80211_chanctx_conf *ctx)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw89_chanctx_ops_remove(rtwdev, ctx);
+	mutex_unlock(&rtwdev->mutex);
+}
+
+static void rtw89_ops_change_chanctx(struct ieee80211_hw *hw,
+				     struct ieee80211_chanctx_conf *ctx,
+				     u32 changed)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw89_chanctx_ops_change(rtwdev, ctx, changed);
+	mutex_unlock(&rtwdev->mutex);
+}
+
+static int rtw89_ops_assign_vif_chanctx(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link_conf,
+					struct ieee80211_chanctx_conf *ctx)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	int ret;
+
+	mutex_lock(&rtwdev->mutex);
+	ret = rtw89_chanctx_ops_assign_vif(rtwdev, rtwvif, ctx);
+	mutex_unlock(&rtwdev->mutex);
+
+	return ret;
+}
+
+static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_bss_conf *link_conf,
+					   struct ieee80211_chanctx_conf *ctx)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw89_chanctx_ops_unassign_vif(rtwdev, rtwvif, ctx);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 const struct ieee80211_ops rtw89_ops = {
 	.tx			= rtw89_ops_tx,
 	.wake_tx_queue		= rtw89_ops_wake_tx_queue,
@@ -805,6 +868,11 @@ const struct ieee80211_ops rtw89_ops = {
 	.reconfig_complete	= rtw89_ops_reconfig_complete,
 	.hw_scan		= rtw89_ops_hw_scan,
 	.cancel_hw_scan		= rtw89_ops_cancel_hw_scan,
+	.add_chanctx		= rtw89_ops_add_chanctx,
+	.remove_chanctx		= rtw89_ops_remove_chanctx,
+	.change_chanctx		= rtw89_ops_change_chanctx,
+	.assign_vif_chanctx	= rtw89_ops_assign_vif_chanctx,
+	.unassign_vif_chanctx	= rtw89_ops_unassign_vif_chanctx,
 	.set_sar_specs		= rtw89_ops_set_sar_specs,
 	.sta_rc_update		= rtw89_ops_sta_rc_update,
 };
-- 
2.25.1


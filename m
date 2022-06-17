Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC054F39B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 10:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381342AbiFQIwR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381339AbiFQIwN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 04:52:13 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911A969495
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 01:52:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25H8q7O31021090, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25H8q7O31021090
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jun 2022 16:52:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 16:52:07 +0800
Received: from localhost (172.16.16.131) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 17 Jun
 2022 16:52:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 11/13] rtw89: add skeleton of mac80211 chanctx ops support
Date:   Fri, 17 Jun 2022 16:49:52 +0800
Message-ID: <20220617084954.61261-12-pkshih@realtek.com>
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
 drivers/net/wireless/realtek/rtw89/mac80211.c | 66 +++++++++++++++++++
 5 files changed, 137 insertions(+)

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
index 23d90ea98e7f1..357970e46bba8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3012,6 +3012,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	hw->vif_data_size = sizeof(struct rtw89_vif);
 	hw->sta_data_size = sizeof(struct rtw89_sta);
 	hw->txq_data_size = sizeof(struct rtw89_txq);
+	hw->chanctx_data_size = sizeof(struct rtw89_chanctx_cfg);
 
 	SET_IEEE80211_PERM_ADDR(hw, efuse->addr);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d57bd29eedba0..bf1d7e547e13c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2620,6 +2620,10 @@ struct rtw89_sar_info {
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
index fcea77622ee0f..e08c9fa30c427 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -773,6 +773,67 @@ static void rtw89_ops_sta_rc_update(struct ieee80211_hw *hw,
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
@@ -801,6 +862,11 @@ const struct ieee80211_ops rtw89_ops = {
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


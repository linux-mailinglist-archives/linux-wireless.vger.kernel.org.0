Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AB47980E2
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 05:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbjIHDNS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 23:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbjIHDNQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 23:13:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E01BD9
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 20:13:11 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3883D34e81359579, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3883D34e81359579
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 11:13:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 8 Sep 2023 11:12:58 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 8 Sep 2023
 11:12:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: mcc: deal with beacon NoA if GO exists
Date:   Fri, 8 Sep 2023 11:11:45 +0800
Message-ID: <20230908031145.20931-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908031145.20931-1-pkshih@realtek.com>
References: <20230908031145.20931-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In MCC STA+GO mode, we calculate NoA information and fill it into the
beacon of P2P GO. Since NoA uses only 32 bits to describe time things,
we need to deal with renewal when TSF[63:32] is carried. We trigger FW
to notify that. Then, we can update NoA information for new time period
once we get notification from FW.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 93 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  1 +
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 2bc936761374..fb68d7f8ec3a 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1423,6 +1423,89 @@ static int __mcc_fw_set_duration_no_bt(struct rtw89_dev *rtwdev, bool sync_chang
 	return 0;
 }
 
+static void rtw89_mcc_handle_beacon_noa(struct rtw89_dev *rtwdev, bool enable)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_pattern *pattern = &config->pattern;
+	struct ieee80211_p2p_noa_desc noa_desc = {};
+	u64 start_time = config->start_tsf;
+	u32 interval = config->mcc_interval;
+	struct rtw89_vif *rtwvif_go;
+	u32 duration;
+
+	if (mcc->mode != RTW89_MCC_MODE_GO_STA)
+		return;
+
+	if (ref->is_go) {
+		rtwvif_go = ref->rtwvif;
+		start_time += ieee80211_tu_to_usec(ref->duration);
+		duration = config->mcc_interval - ref->duration;
+	} else if (aux->is_go) {
+		rtwvif_go = aux->rtwvif;
+		start_time += ieee80211_tu_to_usec(pattern->tob_ref) +
+			      ieee80211_tu_to_usec(config->beacon_offset) +
+			      ieee80211_tu_to_usec(pattern->toa_aux);
+		duration = config->mcc_interval - aux->duration;
+	} else {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC find no GO: skip updating beacon NoA\n");
+		return;
+	}
+
+	rtw89_p2p_noa_renew(rtwvif_go);
+
+	if (enable) {
+		noa_desc.start_time = cpu_to_le32(start_time);
+		noa_desc.interval = cpu_to_le32(ieee80211_tu_to_usec(interval));
+		noa_desc.duration = cpu_to_le32(ieee80211_tu_to_usec(duration));
+		noa_desc.count = 255;
+		rtw89_p2p_noa_append(rtwvif_go, &noa_desc);
+	}
+
+	/* without chanctx, we cannot get beacon from mac80211 stack */
+	if (!rtwvif_go->chanctx_assigned)
+		return;
+
+	rtw89_fw_h2c_update_beacon(rtwdev, rtwvif_go);
+}
+
+static void rtw89_mcc_start_beacon_noa(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+
+	if (mcc->mode != RTW89_MCC_MODE_GO_STA)
+		return;
+
+	if (ref->is_go)
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, ref->rtwvif, true);
+	else if (aux->is_go)
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, aux->rtwvif, true);
+
+	rtw89_mcc_handle_beacon_noa(rtwdev, true);
+}
+
+static void rtw89_mcc_stop_beacon_noa(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+
+	if (mcc->mode != RTW89_MCC_MODE_GO_STA)
+		return;
+
+	if (ref->is_go)
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, ref->rtwvif, false);
+	else if (aux->is_go)
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, aux->rtwvif, false);
+
+	rtw89_mcc_handle_beacon_noa(rtwdev, false);
+}
+
 static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1459,6 +1542,8 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 		return ret;
 
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_START);
+
+	rtw89_mcc_start_beacon_noa(rtwdev);
 	return 0;
 }
 
@@ -1482,6 +1567,8 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev)
 			    "MCC h2c failed to delete group: %d\n", ret);
 
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_STOP);
+
+	rtw89_mcc_stop_beacon_noa(rtwdev);
 }
 
 static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
@@ -1517,6 +1604,7 @@ static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
 			return ret;
 	}
 
+	rtw89_mcc_handle_beacon_noa(rtwdev, true);
 	return 0;
 }
 
@@ -1647,7 +1735,8 @@ void rtw89_chanctx_work(struct work_struct *work)
 	case RTW89_ENTITY_MODE_MCC:
 		if (changed & BIT(RTW89_CHANCTX_BCN_OFFSET_CHANGE) ||
 		    changed & BIT(RTW89_CHANCTX_P2P_PS_CHANGE) ||
-		    changed & BIT(RTW89_CHANCTX_BT_SLOT_CHANGE))
+		    changed & BIT(RTW89_CHANCTX_BT_SLOT_CHANGE) ||
+		    changed & BIT(RTW89_CHANCTX_TSF32_TOGGLE_CHANGE))
 			update_mcc_pattern = true;
 		if (changed & BIT(RTW89_CHANCTX_REMOTE_STA_CHANGE))
 			rtw89_mcc_update_macid_bitmap(rtwdev);
@@ -1809,6 +1898,7 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
 
 	rtwvif->sub_entity_idx = cfg->idx;
+	rtwvif->chanctx_assigned = true;
 	return 0;
 }
 
@@ -1817,4 +1907,5 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 				    struct ieee80211_chanctx_conf *ctx)
 {
 	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
+	rtwvif->chanctx_assigned = false;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 78ba5fd6923b..497b3de649ed 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2930,6 +2930,7 @@ struct rtw89_vif {
 	struct list_head list;
 	struct rtw89_dev *rtwdev;
 	struct rtw89_roc roc;
+	bool chanctx_assigned; /* only valid when running with chanctx_ops */
 	enum rtw89_sub_entity_idx sub_entity_idx;
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
 
@@ -3792,6 +3793,7 @@ enum rtw89_chanctx_changes {
 	RTW89_CHANCTX_BCN_OFFSET_CHANGE,
 	RTW89_CHANCTX_P2P_PS_CHANGE,
 	RTW89_CHANCTX_BT_SLOT_CHANGE,
+	RTW89_CHANCTX_TSF32_TOGGLE_CHANGE,
 
 	NUM_OF_RTW89_CHANCTX_CHANGES,
 	RTW89_CHANCTX_CHANGE_DFLT = NUM_OF_RTW89_CHANCTX_CHANGES,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 1b57c356a7a5..e99e2b4824e5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4488,6 +4488,7 @@ static void
 rtw89_mac_c2h_tsf32_toggle_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 			       u32 len)
 {
+	rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_TSF32_TOGGLE_CHANGE);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index b18ebd844141..16bbb7751197 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -145,6 +145,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->mac_idx = RTW89_MAC_0;
 	rtwvif->phy_idx = RTW89_PHY_0;
 	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
+	rtwvif->chanctx_assigned = false;
 	rtwvif->hit_rule = 0;
 	rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
-- 
2.25.1


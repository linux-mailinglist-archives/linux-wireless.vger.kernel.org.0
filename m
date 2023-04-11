Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAFD6DDB2D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjDKMtJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjDKMtD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 08:49:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B11749C6
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 05:48:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33BCmPwpD030615, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33BCmPwpD030615
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Apr 2023 20:48:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 11 Apr 2023 20:48:47 +0800
Received: from localhost (172.16.20.144) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 11 Apr
 2023 20:48:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v6 3/5] wifi: rtw89: add ieee80211::remain_on_channel ops
Date:   Tue, 11 Apr 2023 20:48:30 +0800
Message-ID: <20230411124832.14965-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411124832.14965-1-pkshih@realtek.com>
References: <20230411124832.14965-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.144]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Add support of remain on channel ops. Since channel context is
required to enable multi-channel concurrent(MCC) and the current
ROC in mac80211 don't support more than 1 channel context, add this
to let P2P and other protocols relying on this work as expected.
The off-channel duration and cancel timing is purely controlled by
upper layers.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v6: no change
v5: no change
---
 drivers/net/wireless/realtek/rtw89/chan.c     |  35 +++
 drivers/net/wireless/realtek/rtw89/chan.h     |   3 +
 drivers/net/wireless/realtek/rtw89/core.c     | 212 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  30 +++
 drivers/net/wireless/realtek/rtw89/mac.c      |   5 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  80 ++++++-
 drivers/net/wireless/realtek/rtw89/ps.h       |  16 ++
 7 files changed, 378 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 90596806bc93f..4663db4ce2f66 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -141,6 +141,38 @@ void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 	__rtw89_config_entity_chandef(rtwdev, idx, chandef, true);
 }
 
+void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
+			      enum rtw89_sub_entity_idx idx,
+			      const struct cfg80211_chan_def *chandef)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	enum rtw89_sub_entity_idx cur;
+
+	if (chandef) {
+		cur = atomic_cmpxchg(&hal->roc_entity_idx,
+				     RTW89_SUB_ENTITY_IDLE, idx);
+		if (cur != RTW89_SUB_ENTITY_IDLE) {
+			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+				    "ROC still processing on entity %d\n", idx);
+			return;
+		}
+
+		hal->roc_chandef = *chandef;
+	} else {
+		cur = atomic_cmpxchg(&hal->roc_entity_idx, idx,
+				     RTW89_SUB_ENTITY_IDLE);
+		if (cur == idx)
+			return;
+
+		if (cur == RTW89_SUB_ENTITY_IDLE)
+			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+				    "ROC already finished on entity %d\n", idx);
+		else
+			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+				    "ROC is processing on entity %d\n", cur);
+	}
+}
+
 static void rtw89_config_default_chandef(struct rtw89_dev *rtwdev)
 {
 	struct cfg80211_chan_def chandef = {0};
@@ -154,6 +186,7 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 	struct rtw89_hal *hal = &rtwdev->hal;
 
 	bitmap_zero(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+	atomic_set(&hal->roc_entity_idx, RTW89_SUB_ENTITY_IDLE);
 	rtw89_config_default_chandef(rtwdev);
 }
 
@@ -229,6 +262,8 @@ void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
 			rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
 	}
 
+	atomic_cmpxchg(&hal->roc_entity_idx, roll, RTW89_SUB_ENTITY_0);
+
 	drop = roll;
 
 out:
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index ecbd4503bead9..bdf369db50417 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -45,6 +45,9 @@ bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 				 enum rtw89_sub_entity_idx idx,
 				 const struct cfg80211_chan_def *chandef);
+void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
+			      enum rtw89_sub_entity_idx idx,
+			      const struct cfg80211_chan_def *chandef);
 void rtw89_entity_init(struct rtw89_dev *rtwdev);
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev);
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index aa28204cbcd8f..30a5ab5e48b1e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2014,6 +2014,18 @@ static void rtw89_core_free_sta_pending_forbid_ba(struct rtw89_dev *rtwdev,
 	spin_unlock_bh(&rtwdev->ba_lock);
 }
 
+static void rtw89_core_free_sta_pending_roc_tx(struct rtw89_dev *rtwdev,
+					       struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct sk_buff *skb, *tmp;
+
+	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
+		skb_unlink(skb, &rtwsta->roc_queue);
+		dev_kfree_skb_any(skb);
+	}
+}
+
 static void rtw89_core_stop_tx_ba_session(struct rtw89_dev *rtwdev,
 					  struct rtw89_txq *rtwtxq)
 {
@@ -2153,6 +2165,7 @@ static void rtw89_core_txq_schedule(struct rtw89_dev *rtwdev, u8 ac, bool *reinv
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_txq *txq;
+	struct rtw89_vif *rtwvif;
 	struct rtw89_txq *rtwtxq;
 	unsigned long frame_cnt;
 	unsigned long byte_cnt;
@@ -2162,6 +2175,12 @@ static void rtw89_core_txq_schedule(struct rtw89_dev *rtwdev, u8 ac, bool *reinv
 	ieee80211_txq_schedule_start(hw, ac);
 	while ((txq = ieee80211_next_txq(hw, ac))) {
 		rtwtxq = (struct rtw89_txq *)txq->drv_priv;
+		rtwvif = (struct rtw89_vif *)txq->vif->drv_priv;
+
+		if (rtwvif->offchan) {
+			ieee80211_return_txq(hw, txq, true);
+			continue;
+		}
 		tx_resource = rtw89_check_and_reclaim_tx_resource(rtwdev, txq->tid);
 		sched_txq = false;
 
@@ -2230,6 +2249,187 @@ static void rtw89_forbid_ba_work(struct work_struct *w)
 	spin_unlock_bh(&rtwdev->ba_lock);
 }
 
+static void rtw89_core_sta_pending_tx_iter(void *data,
+					   struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_vif *rtwvif_target = data, *rtwvif = rtwsta->rtwvif;
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct sk_buff *skb, *tmp;
+	int qsel, ret;
+
+	if (rtwvif->sub_entity_idx != rtwvif_target->sub_entity_idx)
+		return;
+
+	if (skb_queue_len(&rtwsta->roc_queue) == 0)
+		return;
+
+	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
+		skb_unlink(skb, &rtwsta->roc_queue);
+
+		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
+		if (ret) {
+			rtw89_warn(rtwdev, "pending tx failed with %d\n", ret);
+			dev_kfree_skb_any(skb);
+		} else {
+			rtw89_core_tx_kick_off(rtwdev, qsel);
+		}
+	}
+}
+
+static void rtw89_core_handle_sta_pending_tx(struct rtw89_dev *rtwdev,
+					     struct rtw89_vif *rtwvif)
+{
+	ieee80211_iterate_stations_atomic(rtwdev->hw,
+					  rtw89_core_sta_pending_tx_iter,
+					  rtwvif);
+}
+
+static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif, bool qos, bool ps)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_sta *sta;
+	struct ieee80211_hdr *hdr;
+	struct sk_buff *skb;
+	int ret, qsel;
+
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
+		return 0;
+
+	rcu_read_lock();
+	sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
+	if (!sta) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	skb = ieee80211_nullfunc_get(rtwdev->hw, vif, -1, qos);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	hdr = (struct ieee80211_hdr *)skb->data;
+	if (ps)
+		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
+
+	ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
+	if (ret) {
+		rtw89_warn(rtwdev, "nullfunc transmit failed: %d\n", ret);
+		dev_kfree_skb_any(skb);
+		goto out;
+	}
+
+	rcu_read_unlock();
+
+	return rtw89_core_tx_kick_off_and_wait(rtwdev, skb, qsel,
+					       RTW89_ROC_TX_TIMEOUT);
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+
+void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	struct rtw89_roc *roc = &rtwvif->roc;
+	struct cfg80211_chan_def roc_chan;
+	struct rtw89_vif *tmp;
+	int ret;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	ieee80211_queue_delayed_work(hw, &rtwvif->roc.roc_work,
+				     msecs_to_jiffies(rtwvif->roc.duration));
+
+	rtw89_leave_ips_by_hwflags(rtwdev);
+	rtw89_leave_lps(rtwdev);
+
+	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif, true, true);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+			    "roc send null-1 failed: %d\n", ret);
+
+	rtw89_for_each_rtwvif(rtwdev, tmp)
+		if (tmp->sub_entity_idx == rtwvif->sub_entity_idx)
+			tmp->offchan = true;
+
+	cfg80211_chandef_create(&roc_chan, &roc->chan, NL80211_CHAN_NO_HT);
+	rtw89_config_roc_chandef(rtwdev, rtwvif->sub_entity_idx, &roc_chan);
+	rtw89_set_channel(rtwdev);
+	rtw89_write32_clr(rtwdev,
+			  rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			  B_AX_A_UC_CAM_MATCH | B_AX_A_BC_CAM_MATCH);
+
+	ieee80211_ready_on_channel(hw);
+}
+
+void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	struct rtw89_roc *roc = &rtwvif->roc;
+	struct rtw89_vif *tmp;
+	int ret;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	ieee80211_remain_on_channel_expired(hw);
+
+	rtw89_leave_ips_by_hwflags(rtwdev);
+	rtw89_leave_lps(rtwdev);
+
+	rtw89_write32_mask(rtwdev,
+			   rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   B_AX_RX_FLTR_CFG_MASK,
+			   rtwdev->hal.rx_fltr);
+
+	roc->state = RTW89_ROC_IDLE;
+	rtw89_config_roc_chandef(rtwdev, rtwvif->sub_entity_idx, NULL);
+	rtw89_set_channel(rtwdev);
+	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif, true, false);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+			    "roc send null-0 failed: %d\n", ret);
+
+	rtw89_for_each_rtwvif(rtwdev, tmp)
+		if (tmp->sub_entity_idx == rtwvif->sub_entity_idx)
+			tmp->offchan = false;
+
+	rtw89_core_handle_sta_pending_tx(rtwdev, rtwvif);
+	queue_work(rtwdev->txq_wq, &rtwdev->txq_work);
+
+	if (hw->conf.flags & IEEE80211_CONF_IDLE)
+		ieee80211_queue_delayed_work(hw, &roc->roc_work,
+					     RTW89_ROC_IDLE_TIMEOUT);
+}
+
+void rtw89_roc_work(struct work_struct *work)
+{
+	struct rtw89_vif *rtwvif = container_of(work, struct rtw89_vif,
+						roc.roc_work.work);
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_roc *roc = &rtwvif->roc;
+
+	mutex_lock(&rtwdev->mutex);
+
+	switch (roc->state) {
+	case RTW89_ROC_IDLE:
+		rtw89_enter_ips_by_hwflags(rtwdev);
+		break;
+	case RTW89_ROC_MGMT:
+	case RTW89_ROC_NORMAL:
+		rtw89_roc_end(rtwdev, rtwvif);
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&rtwdev->mutex);
+}
+
 static enum rtw89_tfc_lv rtw89_get_traffic_level(struct rtw89_dev *rtwdev,
 						 u32 throughput, u64 cnt)
 {
@@ -2299,6 +2499,9 @@ static void rtw89_vif_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwv
 	    rtwvif->tdls_peer)
 		return;
 
+	if (rtwvif->offchan)
+		return;
+
 	if (rtwvif->stats.tx_tfc_lv == RTW89_TFC_IDLE &&
 	    rtwvif->stats.rx_tfc_lv == RTW89_TFC_IDLE)
 		rtw89_enter_lps(rtwdev, rtwvif);
@@ -2528,6 +2731,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 	rtwsta->rtwvif = rtwvif;
 	rtwsta->prev_rssi = 0;
 	INIT_LIST_HEAD(&rtwsta->ba_cam_list);
+	skb_queue_head_init(&rtwsta->roc_queue);
 
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw89_core_txq_init(rtwdev, sta->txq[i]);
@@ -2597,6 +2801,8 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	rtw89_mac_bf_disassoc(rtwdev, vif, sta);
 	rtw89_core_free_sta_pending_ba(rtwdev, sta);
 	rtw89_core_free_sta_pending_forbid_ba(rtwdev, sta);
+	rtw89_core_free_sta_pending_roc_tx(rtwdev, sta);
+
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
 		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
 	if (sta->tdls)
@@ -3480,6 +3686,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	hw->wiphy->tid_config_support.peer |= BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL);
 	hw->wiphy->tid_config_support.vif |= BIT(NL80211_TID_CONFIG_ATTR_AMSDU_CTRL);
 	hw->wiphy->tid_config_support.peer |= BIT(NL80211_TID_CONFIG_ATTR_AMSDU_CTRL);
+	hw->wiphy->max_remain_on_channel_duration = 1000;
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 
@@ -3563,7 +3770,8 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 		goto err;
 
 	no_chanctx = chip->support_chanctx_num == 0 ||
-		     !(early_feat_map & BIT(RTW89_FW_FEATURE_SCAN_OFFLOAD));
+		     !(early_feat_map & BIT(RTW89_FW_FEATURE_SCAN_OFFLOAD)) ||
+		     !(early_feat_map & BIT(RTW89_FW_FEATURE_BEACON_FILTER));
 
 	if (no_chanctx) {
 		ops->add_chanctx = NULL;
@@ -3571,6 +3779,8 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 		ops->change_chanctx = NULL;
 		ops->assign_vif_chanctx = NULL;
 		ops->unassign_vif_chanctx = NULL;
+		ops->remain_on_channel = NULL;
+		ops->cancel_remain_on_channel = NULL;
 	}
 
 	driver_data_size = sizeof(struct rtw89_dev) + bus_data_size;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d94d263977243..39083a0e6ce3a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -569,6 +569,7 @@ enum rtw89_sub_entity_idx {
 	RTW89_SUB_ENTITY_0 = 0,
 
 	NUM_OF_RTW89_SUB_ENTITY,
+	RTW89_SUB_ENTITY_IDLE = NUM_OF_RTW89_SUB_ENTITY,
 };
 
 enum rtw89_rf_path {
@@ -2597,6 +2598,7 @@ struct rtw89_sta {
 	struct rtw89_addr_cam_entry addr_cam; /* AP mode or TDLS peer only */
 	struct rtw89_bssid_cam_entry bssid_cam; /* TDLS peer only */
 	struct list_head ba_cam_list;
+	struct sk_buff_head roc_queue;
 
 	bool use_cfg_mask;
 	struct cfg80211_bitrate_mask mask;
@@ -2634,11 +2636,28 @@ struct rtw89_tx_skb_data {
 	u8 hci_priv[];
 };
 
+#define RTW89_ROC_IDLE_TIMEOUT 500
+#define RTW89_ROC_TX_TIMEOUT 30
+enum rtw89_roc_state {
+	RTW89_ROC_IDLE,
+	RTW89_ROC_NORMAL,
+	RTW89_ROC_MGMT,
+};
+
+struct rtw89_roc {
+	struct ieee80211_channel chan;
+	struct delayed_work roc_work;
+	enum ieee80211_roc_type type;
+	enum rtw89_roc_state state;
+	int duration;
+};
+
 #define RTW89_P2P_MAX_NOA_NUM 2
 
 struct rtw89_vif {
 	struct list_head list;
 	struct rtw89_dev *rtwdev;
+	struct rtw89_roc roc;
 	enum rtw89_sub_entity_idx sub_entity_idx;
 
 	u8 mac_id;
@@ -2654,6 +2673,7 @@ struct rtw89_vif {
 	u8 bcn_hit_cond;
 	u8 hit_rule;
 	u8 last_noa_nr;
+	bool offchan;
 	bool trigger;
 	bool lsig_txop;
 	u8 tgt_ind;
@@ -3370,9 +3390,11 @@ struct rtw89_hal {
 	bool tx_path_diversity;
 	bool support_cckpd;
 	bool support_igi;
+	atomic_t roc_entity_idx;
 
 	DECLARE_BITMAP(entity_map, NUM_OF_RTW89_SUB_ENTITY);
 	struct rtw89_sub_entity sub[NUM_OF_RTW89_SUB_ENTITY];
+	struct cfg80211_chan_def roc_chandef;
 
 	bool entity_active;
 	enum rtw89_entity_mode entity_mode;
@@ -4035,6 +4057,7 @@ struct rtw89_dev {
 	struct delayed_work coex_rfk_chk_work;
 	struct delayed_work cfo_track_work;
 	struct delayed_work forbid_ba_work;
+	struct delayed_work roc_work;
 	struct rtw89_ppdu_sts_info ppdu_sts;
 	u8 total_sta_assoc;
 	bool scanning;
@@ -4550,6 +4573,10 @@ const struct cfg80211_chan_def *rtw89_chandef_get(struct rtw89_dev *rtwdev,
 						  enum rtw89_sub_entity_idx idx)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
+	enum rtw89_sub_entity_idx roc_idx = atomic_read(&hal->roc_entity_idx);
+
+	if (roc_idx == idx)
+		return &hal->roc_chandef;
 
 	return &hal->sub[idx].chandef;
 }
@@ -4936,6 +4963,9 @@ void rtw89_complete_cond(struct rtw89_wait_info *wait, unsigned int cond,
 int rtw89_core_start(struct rtw89_dev *rtwdev);
 void rtw89_core_stop(struct rtw89_dev *rtwdev);
 void rtw89_core_update_beacon_work(struct work_struct *work);
+void rtw89_roc_work(struct work_struct *work);
+void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   const u8 *mac_addr, bool hw_scan);
 void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 367a7f95401c8..54887835ac153 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4193,6 +4193,9 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 	u16 chan;
 	int ret;
 
+	if (!rtwvif)
+		return;
+
 	tx_fail = RTW89_GET_MAC_C2H_SCANOFLD_TX_FAIL(c2h->data);
 	status = RTW89_GET_MAC_C2H_SCANOFLD_STATUS(c2h->data);
 	chan = RTW89_GET_MAC_C2H_SCANOFLD_PRI_CH(c2h->data);
@@ -4262,7 +4265,7 @@ rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 	switch (type) {
 	case RTW89_BCN_FLTR_BEACON_LOSS:
-		if (!rtwdev->scanning)
+		if (!rtwdev->scanning && !rtwvif->offchan)
 			ieee80211_connection_loss(vif);
 		else
 			rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 629b32dafecb8..b059aa8d88dbf 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -23,9 +23,19 @@ static void rtw89_ops_tx(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct ieee80211_sta *sta = control->sta;
+	u32 flags = IEEE80211_SKB_CB(skb)->flags;
 	int ret, qsel;
 
+	if (rtwvif->offchan && !(flags & IEEE80211_TX_CTL_TX_OFFCHAN) && sta) {
+		struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TXRX, "ops_tx during offchan\n");
+		skb_queue_tail(&rtwsta->roc_queue, skb);
+		return;
+	}
+
 	ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to transmit skb: %d\n", ret);
@@ -115,13 +125,18 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 
+	rtw89_leave_ips_by_hwflags(rtwdev);
+
 	if (RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
 		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER |
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 
 	rtwvif->rtwdev = rtwdev;
+	rtwvif->roc.state = RTW89_ROC_IDLE;
+	rtwvif->offchan = false;
 	list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
 	INIT_WORK(&rtwvif->update_beacon_work, rtw89_core_update_beacon_work);
+	INIT_DELAYED_WORK(&rtwvif->roc.roc_work, rtw89_roc_work);
 	rtw89_leave_ps_mode(rtwdev);
 
 	rtw89_traffic_stats_init(rtwdev, &rtwvif->stats);
@@ -168,6 +183,7 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 		    vif->addr, vif->type, vif->p2p);
 
 	cancel_work_sync(&rtwvif->update_beacon_work);
+	cancel_delayed_work_sync(&rtwvif->roc.roc_work);
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
@@ -175,6 +191,8 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 	rtw89_mac_remove_vif(rtwdev, rtwvif);
 	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif->port);
 	list_del_init(&rtwvif->list);
+	rtw89_enter_ips_by_hwflags(rtwdev);
+
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -803,12 +821,13 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			     struct ieee80211_scan_request *req)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 	int ret = 0;
 
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return 1;
 
-	if (rtwdev->scanning)
+	if (rtwdev->scanning || rtwvif->offchan)
 		return -EBUSY;
 
 	mutex_lock(&rtwdev->mutex);
@@ -911,6 +930,63 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
+static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_channel *chan,
+				       int duration,
+				       enum ieee80211_roc_type type)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+	struct rtw89_roc *roc = &rtwvif->roc;
+
+	if (!vif)
+		return -EINVAL;
+
+	mutex_lock(&rtwdev->mutex);
+
+	if (roc->state != RTW89_ROC_IDLE) {
+		mutex_unlock(&rtwdev->mutex);
+		return -EBUSY;
+	}
+
+	if (rtwdev->scanning)
+		rtw89_hw_scan_abort(rtwdev, vif);
+
+	if (type == IEEE80211_ROC_TYPE_MGMT_TX)
+		roc->state = RTW89_ROC_MGMT;
+	else
+		roc->state = RTW89_ROC_NORMAL;
+
+	roc->duration = duration;
+	roc->chan = *chan;
+	roc->type = type;
+
+	rtw89_roc_start(rtwdev, rtwvif);
+
+	mutex_unlock(&rtwdev->mutex);
+
+	return 0;
+}
+
+static int rtw89_ops_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					      struct ieee80211_vif *vif)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+
+	if (!rtwvif)
+		return -EINVAL;
+
+	cancel_delayed_work_sync(&rtwvif->roc.roc_work);
+
+	mutex_lock(&rtwdev->mutex);
+	rtw89_roc_end(rtwdev, rtwvif);
+	mutex_unlock(&rtwdev->mutex);
+
+	return 0;
+}
+
 static void rtw89_set_tid_config_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct cfg80211_tid_config *tid_config = data;
@@ -1022,6 +1098,8 @@ const struct ieee80211_ops rtw89_ops = {
 	.change_chanctx		= rtw89_ops_change_chanctx,
 	.assign_vif_chanctx	= rtw89_ops_assign_vif_chanctx,
 	.unassign_vif_chanctx	= rtw89_ops_unassign_vif_chanctx,
+	.remain_on_channel		= rtw89_ops_remain_on_channel,
+	.cancel_remain_on_channel	= rtw89_ops_cancel_remain_on_channel,
 	.set_sar_specs		= rtw89_ops_set_sar_specs,
 	.sta_rc_update		= rtw89_ops_sta_rc_update,
 	.set_tid_config		= rtw89_ops_set_tid_config,
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index 6ac1f7ea53394..c9e29d92fc1b9 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -15,4 +15,20 @@ void rtw89_leave_ips(struct rtw89_dev *rtwdev);
 void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl);
 void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 
+static inline void rtw89_leave_ips_by_hwflags(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+
+	if (hw->conf.flags & IEEE80211_CONF_IDLE)
+		rtw89_leave_ips(rtwdev);
+}
+
+static inline void rtw89_enter_ips_by_hwflags(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+
+	if (hw->conf.flags & IEEE80211_CONF_IDLE)
+		rtw89_enter_ips(rtwdev);
+}
+
 #endif
-- 
2.25.1


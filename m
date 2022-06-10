Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46BB545D51
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbiFJH1V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346821AbiFJH06 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:26:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6564D14D07
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:26:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25A7QpNW2010157, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25A7QpNW2010157
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jun 2022 15:26:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 15:26:51 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 10 Jun
 2022 15:26:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 06/11] rtw89: enable VO TX AMPDU
Date:   Fri, 10 Jun 2022 15:26:05 +0800
Message-ID: <20220610072610.27095-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610072610.27095-1-pkshih@realtek.com>
References: <20220610072610.27095-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/10/2022 07:06:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTAg5LiK5Y2IIDA2OjAwOjAw?=
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

To improve VO throughput, we enable VO TX AMPDU.

We measure the latency of enable or disable VO TX AMPDU. The experimental
results show that the difference between the two is insignificant only
300µs, so the little impact can be ignored for user experience.

Moreover, we found some APs will have a group key handshake timeout issue
when the EAPOL's TID is already setup BA session. Therefore, when
transmitting EAPOL, if EAPOL's TID BA session is already setup, we need
to delete it.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 92 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |  7 +-
 2 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index cea4de6bb939c..deb39b0d66c89 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -408,18 +408,30 @@ rtw89_core_get_tx_type(struct rtw89_dev *rtwdev,
 
 static void
 rtw89_core_tx_update_ampdu_info(struct rtw89_dev *rtwdev,
-				struct rtw89_core_tx_request *tx_req, u8 tid)
+				struct rtw89_core_tx_request *tx_req,
+				enum btc_pkt_type pkt_type)
 {
 	struct ieee80211_sta *sta = tx_req->sta;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_sta *rtwsta;
 	u8 ampdu_num;
+	u8 tid;
+
+	if (pkt_type == PACKET_EAPOL) {
+		desc_info->bk = true;
+		return;
+	}
+
+	if (!(IEEE80211_SKB_CB(skb)->flags & IEEE80211_TX_CTL_AMPDU))
+		return;
 
 	if (!sta) {
 		rtw89_warn(rtwdev, "cannot set ampdu info without sta\n");
 		return;
 	}
 
+	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
 	rtwsta = (struct rtw89_sta *)sta->drv_priv;
 
 	ampdu_num = (u8)((rtwsta->ampdu_params[tid].agg_num ?
@@ -720,8 +732,6 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	/* enable wd_info for AMPDU */
 	desc_info->en_wd_info = true;
 
-	if (IEEE80211_SKB_CB(skb)->flags & IEEE80211_TX_CTL_AMPDU)
-		rtw89_core_tx_update_ampdu_info(rtwdev, tx_req, tid);
 	if (IEEE80211_SKB_CB(skb)->control.hw_key)
 		rtw89_core_tx_update_sec_key(rtwdev, tx_req);
 
@@ -832,6 +842,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 		rtw89_core_tx_update_data_info(rtwdev, tx_req);
 		pkt_type = rtw89_core_tx_btc_spec_pkt_notify(rtwdev, tx_req);
 		rtw89_core_tx_update_he_qos_htc(rtwdev, tx_req, pkt_type);
+		rtw89_core_tx_update_ampdu_info(rtwdev, tx_req, pkt_type);
 		rtw89_core_tx_update_llc_hdr(rtwdev, desc_info, skb);
 		break;
 	case RTW89_CORE_TX_TYPE_FWCMD:
@@ -1811,6 +1822,55 @@ static void rtw89_core_free_sta_pending_ba(struct rtw89_dev *rtwdev,
 	spin_unlock_bh(&rtwdev->ba_lock);
 }
 
+static void rtw89_core_free_sta_pending_forbid_ba(struct rtw89_dev *rtwdev,
+						  struct ieee80211_sta *sta)
+{
+	struct rtw89_txq *rtwtxq, *tmp;
+
+	spin_lock_bh(&rtwdev->ba_lock);
+	list_for_each_entry_safe(rtwtxq, tmp, &rtwdev->forbid_ba_list, list) {
+		struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
+
+		if (sta == txq->sta) {
+			clear_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags);
+			list_del_init(&rtwtxq->list);
+		}
+	}
+	spin_unlock_bh(&rtwdev->ba_lock);
+}
+
+static void rtw89_core_stop_tx_ba_session(struct rtw89_dev *rtwdev,
+					  struct rtw89_txq *rtwtxq)
+{
+	struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
+	struct ieee80211_sta *sta = txq->sta;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+
+	if (unlikely(!rtwsta) || unlikely(rtwsta->disassoc))
+		return;
+
+	if (!test_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags) ||
+	    test_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags))
+		return;
+
+	spin_lock_bh(&rtwdev->ba_lock);
+	if (!list_empty(&rtwtxq->list)) {
+		list_del_init(&rtwtxq->list);
+		goto out;
+	}
+
+	set_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags);
+
+	list_add_tail(&rtwtxq->list, &rtwdev->forbid_ba_list);
+	ieee80211_stop_tx_ba_session(sta, txq->tid);
+	cancel_delayed_work(&rtwdev->forbid_ba_work);
+	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->forbid_ba_work,
+				     RTW89_FORBID_BA_TIMER);
+
+out:
+	spin_unlock_bh(&rtwdev->ba_lock);
+}
+
 static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
 				     struct rtw89_txq *rtwtxq,
 				     struct sk_buff *skb)
@@ -1820,13 +1880,15 @@ static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
 	struct ieee80211_sta *sta = txq->sta;
 	struct rtw89_sta *rtwsta = sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
 
-	if (unlikely(skb_get_queue_mapping(skb) == IEEE80211_AC_VO))
+	if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE))) {
+		rtw89_core_stop_tx_ba_session(rtwdev, rtwtxq);
 		return;
+	}
 
-	if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE)))
+	if (unlikely(!sta))
 		return;
 
-	if (unlikely(!sta))
+	if (test_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags))
 		return;
 
 	if (unlikely(test_bit(RTW89_TXQ_F_BLOCK_BA, &rtwtxq->flags)))
@@ -1986,6 +2048,20 @@ static void rtw89_core_txq_reinvoke_work(struct work_struct *w)
 	queue_work(rtwdev->txq_wq, &rtwdev->txq_work);
 }
 
+static void rtw89_forbid_ba_work(struct work_struct *w)
+{
+	struct rtw89_dev *rtwdev = container_of(w, struct rtw89_dev,
+						forbid_ba_work.work);
+	struct rtw89_txq *rtwtxq, *tmp;
+
+	spin_lock_bh(&rtwdev->ba_lock);
+	list_for_each_entry_safe(rtwtxq, tmp, &rtwdev->forbid_ba_list, list) {
+		clear_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags);
+		list_del_init(&rtwtxq->list);
+	}
+	spin_unlock_bh(&rtwdev->ba_lock);
+}
+
 static enum rtw89_tfc_lv rtw89_get_traffic_level(struct rtw89_dev *rtwdev,
 						 u32 throughput, u64 cnt)
 {
@@ -2279,6 +2355,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, true);
 	rtw89_mac_bf_disassoc(rtwdev, vif, sta);
 	rtw89_core_free_sta_pending_ba(rtwdev, sta);
+	rtw89_core_free_sta_pending_forbid_ba(rtwdev, sta);
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
 		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
 	if (sta->tdls)
@@ -2791,6 +2868,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	cancel_delayed_work_sync(&rtwdev->coex_bt_devinfo_work);
 	cancel_delayed_work_sync(&rtwdev->coex_rfk_chk_work);
 	cancel_delayed_work_sync(&rtwdev->cfo_track_work);
+	cancel_delayed_work_sync(&rtwdev->forbid_ba_work);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -2810,6 +2888,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	u8 band;
 
 	INIT_LIST_HEAD(&rtwdev->ba_list);
+	INIT_LIST_HEAD(&rtwdev->forbid_ba_list);
 	INIT_LIST_HEAD(&rtwdev->rtwvifs_list);
 	INIT_LIST_HEAD(&rtwdev->early_h2c_list);
 	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
@@ -2825,6 +2904,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	INIT_DELAYED_WORK(&rtwdev->coex_bt_devinfo_work, rtw89_coex_bt_devinfo_work);
 	INIT_DELAYED_WORK(&rtwdev->coex_rfk_chk_work, rtw89_coex_rfk_chk_work);
 	INIT_DELAYED_WORK(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
+	INIT_DELAYED_WORK(&rtwdev->forbid_ba_work, rtw89_forbid_ba_work);
 	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
 	spin_lock_init(&rtwdev->ba_lock);
 	spin_lock_init(&rtwdev->rpwm_lock);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c87c2173f05c4..e05f17c6545e9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -29,6 +29,7 @@ extern const struct ieee80211_ops rtw89_ops;
 #define INV_RF_DATA 0xffffffff
 
 #define RTW89_TRACK_WORK_PERIOD	round_jiffies_relative(HZ * 2)
+#define RTW89_FORBID_BA_TIMER round_jiffies_relative(HZ * 4)
 #define CFO_TRACK_MAX_USER 64
 #define MAX_RSSI 110
 #define RSSI_FACTOR 1
@@ -134,6 +135,7 @@ enum rtw89_core_rx_type {
 enum rtw89_txq_flags {
 	RTW89_TXQ_F_AMPDU		= 0,
 	RTW89_TXQ_F_BLOCK_BA		= 1,
+	RTW89_TXQ_F_FORBID_BA		= 2,
 };
 
 enum rtw89_net_type {
@@ -3116,10 +3118,12 @@ struct rtw89_dev {
 	struct workqueue_struct *txq_wq;
 	struct work_struct txq_work;
 	struct delayed_work txq_reinvoke_work;
-	/* used to protect ba_list */
+	/* used to protect ba_list and forbid_ba_list */
 	spinlock_t ba_lock;
 	/* txqs to setup ba session */
 	struct list_head ba_list;
+	/* txqs to forbid ba session */
+	struct list_head forbid_ba_list;
 	struct work_struct ba_work;
 	/* used to protect rpwm */
 	spinlock_t rpwm_lock;
@@ -3166,6 +3170,7 @@ struct rtw89_dev {
 	struct delayed_work coex_bt_devinfo_work;
 	struct delayed_work coex_rfk_chk_work;
 	struct delayed_work cfo_track_work;
+	struct delayed_work forbid_ba_work;
 	struct rtw89_ppdu_sts_info ppdu_sts;
 	u8 total_sta_assoc;
 	bool scanning;
-- 
2.25.1


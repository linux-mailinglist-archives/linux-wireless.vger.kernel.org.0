Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C27C47D0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfJBGfp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:45 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57695 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfJBGfo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:44 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZbXq013056, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926ZbXq013056
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:37 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:36 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 04/14] rtw88: take over rate control from mac80211
Date:   Wed, 2 Oct 2019 14:35:21 +0800
Message-ID: <20191002063531.18135-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

We can indicate IEEE80211_HW_HAS_RATE_CONTROL to mac80211 because
the hardware has its own rate control algorithm. And what driver needs
to do is to choose an RA mask according the peer's capabilities.

But the hardware is not able to setup BA session by itself. So driver
requires to initiate tx BA session for hardware, and tells it if it is
possible to transmit AMPDU. The hardware can then aggregate MPDUs.

And the size of AMPDU is controlled by the TX descriptor and the
register value. Since the TX descriptor will reference the max AMPDU
size from ieee80211_sta::ht_cap::ampdu_factor, just set the register
value to 0x3f, and let it be controlled by TX descriptor.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  5 +++
 drivers/net/wireless/realtek/rtw88/main.c     | 36 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     | 10 ++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  4 +--
 drivers/net/wireless/realtek/rtw88/tx.c       | 34 ++++++++++++++++++
 5 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 47ea69434b96..fe58a99ca48e 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -483,6 +483,8 @@ static int rtw_ops_ampdu_action(struct ieee80211_hw *hw,
 {
 	struct ieee80211_sta *sta = params->sta;
 	u16 tid = params->tid;
+	struct ieee80211_txq *txq = sta->txq[tid];
+	struct rtw_txq *rtwtxq = (struct rtw_txq *)txq->drv_priv;
 
 	switch (params->action) {
 	case IEEE80211_AMPDU_TX_START:
@@ -491,9 +493,12 @@ static int rtw_ops_ampdu_action(struct ieee80211_hw *hw,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+		clear_bit(RTW_TXQ_AMPDU, &rtwtxq->flags);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		set_bit(RTW_TXQ_AMPDU, &rtwtxq->flags);
+		break;
 	case IEEE80211_AMPDU_RX_START:
 	case IEEE80211_AMPDU_RX_STOP:
 		break;
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 3a09a5b123a7..0cee91869daa 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -213,6 +213,40 @@ static void rtw_c2h_work(struct work_struct *work)
 	}
 }
 
+struct rtw_txq_ba_iter_data {
+};
+
+static void rtw_txq_ba_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	int ret;
+	u8 tid;
+
+	tid = find_first_bit(si->tid_ba, IEEE80211_NUM_TIDS);
+	while (tid != IEEE80211_NUM_TIDS) {
+		clear_bit(tid, si->tid_ba);
+		ret = ieee80211_start_tx_ba_session(sta, tid, 0);
+		if (ret == -EINVAL) {
+			struct ieee80211_txq *txq;
+			struct rtw_txq *rtwtxq;
+
+			txq = sta->txq[tid];
+			rtwtxq = (struct rtw_txq *)txq->drv_priv;
+			set_bit(RTW_TXQ_BLOCK_BA, &rtwtxq->flags);
+		}
+
+		tid = find_first_bit(si->tid_ba, IEEE80211_NUM_TIDS);
+	}
+}
+
+static void rtw_txq_ba_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev, ba_work);
+	struct rtw_txq_ba_iter_data data;
+
+	rtw_iterate_stas_atomic(rtwdev, rtw_txq_ba_iter, &data);
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *chan_params)
 {
@@ -1171,6 +1205,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	INIT_DELAYED_WORK(&coex->bt_reenable_work, rtw_coex_bt_reenable_work);
 	INIT_DELAYED_WORK(&coex->defreeze_work, rtw_coex_defreeze_work);
 	INIT_WORK(&rtwdev->c2h_work, rtw_c2h_work);
+	INIT_WORK(&rtwdev->ba_work, rtw_txq_ba_work);
 	skb_queue_head_init(&rtwdev->c2h_queue);
 	skb_queue_head_init(&rtwdev->coex.queue);
 	skb_queue_head_init(&rtwdev->tx_report.queue);
@@ -1262,6 +1297,7 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				     BIT(NL80211_IFTYPE_AP) |
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index cfe94a685dde..dcf806ac8155 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -306,6 +306,11 @@ enum rtw_regulatory_domains {
 	RTW_REGD_MAX
 };
 
+enum rtw_txq_flags {
+	RTW_TXQ_AMPDU,
+	RTW_TXQ_BLOCK_BA,
+};
+
 enum rtw_flags {
 	RTW_FLAG_RUNNING,
 	RTW_FLAG_FW_RUNNING,
@@ -589,6 +594,8 @@ struct rtw_tx_report {
 
 struct rtw_txq {
 	struct list_head list;
+
+	unsigned long flags;
 	unsigned long last_push;
 };
 
@@ -614,6 +621,8 @@ struct rtw_sta_info {
 	bool updated;
 	u8 init_ra_lv;
 	u64 ra_mask;
+
+	DECLARE_BITMAP(tid_ba, IEEE80211_NUM_TIDS);
 };
 
 struct rtw_vif {
@@ -1370,6 +1379,7 @@ struct rtw_dev {
 	spinlock_t txq_lock;
 	struct list_head txqs;
 	struct tasklet_struct tx_tasklet;
+	struct work_struct ba_work;
 
 	struct rtw_tx_report tx_report;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 7f81da8a2771..4c983666e830 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1088,8 +1088,8 @@ static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 #define WLAN_AMPDU_MAX_TIME		0x70
 #define WLAN_RTS_LEN_TH			0xFF
 #define WLAN_RTS_TX_TIME_TH		0x08
-#define WLAN_MAX_AGG_PKT_LIMIT		0x20
-#define WLAN_RTS_MAX_AGG_PKT_LIMIT	0x20
+#define WLAN_MAX_AGG_PKT_LIMIT		0x3f
+#define WLAN_RTS_MAX_AGG_PKT_LIMIT	0x3f
 #define WLAN_PRE_TXCNT_TIME_TH		0x1E0
 #define FAST_EDCA_VO_TH		0x06
 #define FAST_EDCA_VI_TH		0x06
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 1e19bdac1d45..24c39c60c99a 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -384,6 +384,38 @@ void rtw_tx(struct rtw_dev *rtwdev,
 	ieee80211_free_txskb(rtwdev->hw, skb);
 }
 
+static void rtw_txq_check_agg(struct rtw_dev *rtwdev,
+			      struct rtw_txq *rtwtxq,
+			      struct sk_buff *skb)
+{
+	struct ieee80211_txq *txq = rtwtxq_to_txq(rtwtxq);
+	struct ieee80211_tx_info *info;
+	struct rtw_sta_info *si;
+
+	if (test_bit(RTW_TXQ_AMPDU, &rtwtxq->flags)) {
+		info = IEEE80211_SKB_CB(skb);
+		info->flags |= IEEE80211_TX_CTL_AMPDU;
+		return;
+	}
+
+	if (skb_get_queue_mapping(skb) == IEEE80211_AC_VO)
+		return;
+
+	if (test_bit(RTW_TXQ_BLOCK_BA, &rtwtxq->flags))
+		return;
+
+	if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE)))
+		return;
+
+	if (!txq->sta)
+		return;
+
+	si = (struct rtw_sta_info *)txq->sta->drv_priv;
+	set_bit(txq->tid, si->tid_ba);
+
+	ieee80211_queue_work(rtwdev->hw, &rtwdev->ba_work);
+}
+
 static bool rtw_txq_dequeue(struct rtw_dev *rtwdev,
 			    struct rtw_txq *rtwtxq)
 {
@@ -395,6 +427,8 @@ static bool rtw_txq_dequeue(struct rtw_dev *rtwdev,
 	if (!skb)
 		return false;
 
+	rtw_txq_check_agg(rtwdev, rtwtxq, skb);
+
 	control.sta = txq->sta;
 	rtw_tx(rtwdev, &control, skb);
 	rtwtxq->last_push = jiffies;
-- 
2.17.1


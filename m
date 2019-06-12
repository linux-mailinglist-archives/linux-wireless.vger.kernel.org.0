Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0130F42984
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405312AbfFLOih (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 10:38:37 -0400
Received: from nbd.name ([46.4.11.11]:57660 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392115AbfFLOih (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 10:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XGT1uehPDjJSq3GRYu7PiUIPej6KJcUHeteYUI2NHM0=; b=DyNuFLZctjdTiJMSF2rE8dnxrD
        upt6/7fwf/qyqY1rSuoTlf4wFAxv5rvzAf5WA1pj2NoA0djB7zrF+cV7JrX7JIa5zJBeXLmYtFmDW
        msP/+JKhNRPuskcMWZxOIKyKT+QDQZhNgEgyZAUiqSvHoGmT94egG+to1aICr3tYkJBE=;
Received: from p5b206263.dip0.t-ipconnect.de ([91.32.98.99] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hb4OZ-00068V-BE
        for linux-wireless@vger.kernel.org; Wed, 12 Jun 2019 16:38:35 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id C7D2F5CF1D3D; Wed, 12 Jun 2019 16:38:33 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/4] mt76: mt76x02: fix tx status reporting issues
Date:   Wed, 12 Jun 2019 16:38:33 +0200
Message-Id: <20190612143833.51959-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190607164355.51876-3-nbd@nbd.name>
References: <20190607164355.51876-3-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the hardware falls back to lower rates for a transmit attempt, only the
first status report will show the number of retries correctly. The frames
that follow will report the correct final rate, but number of retries set to 0.
This can cause the rate control module to vastly underestimate the number of
retransmissions per rate.

To fix this, we need to keep track of the initial requested tx rate per packet
and pass it to the status information.
For frames with tx status requested, this is simple: use the rate configured
in info->control.rates[0] as reference.
For no-skb tx status information, we have to encode the requested tx rate in
the packet id (and make it possible to distinguish it from real packet ids).

To do that, reduce the packet id field size by one bit, and use that bit to
indicate packet id vs rate.

This change also improves reporting by filling the status rate array with
rates from first rate to final rate, taking the same steps as the hardware
fallback table. This matters in corner cases like MCS8 on HT, where the
fallback target is MCS0, not MCS7.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: fix reporting of non-probing frames with tx status requested

 drivers/net/wireless/mediatek/mt76/mt76.h     |  11 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 102 +++++++++++++++---
 .../net/wireless/mediatek/mt76/mt76x02_txrx.c |   7 +-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |   7 +-
 4 files changed, 107 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index fc4169c83e76..907bec9d5e4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -258,10 +258,11 @@ struct mt76_rx_tid {
 #define MT_TX_CB_TXS_DONE		BIT(1)
 #define MT_TX_CB_TXS_FAILED		BIT(2)
 
-#define MT_PACKET_ID_MASK		GENMASK(7, 0)
+#define MT_PACKET_ID_MASK		GENMASK(6, 0)
 #define MT_PACKET_ID_NO_ACK		0
 #define MT_PACKET_ID_NO_SKB		1
 #define MT_PACKET_ID_FIRST		2
+#define MT_PACKET_ID_HAS_RATE		BIT(7)
 
 #define MT_TX_STATUS_SKB_TIMEOUT	HZ
 
@@ -689,6 +690,14 @@ static inline void mt76_insert_hdr_pad(struct sk_buff *skb)
 	skb->data[len + 1] = 0;
 }
 
+static inline bool mt76_is_skb_pktid(u8 pktid)
+{
+	if (pktid & MT_PACKET_ID_HAS_RATE)
+		return false;
+
+	return pktid >= MT_PACKET_ID_FIRST;
+}
+
 void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb);
 void mt76_tx(struct mt76_dev *dev, struct ieee80211_sta *sta,
 	     struct mt76_wcid *wcid, struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index ee4a86971be7..82bafb5ac326 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -420,30 +420,92 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 EXPORT_SYMBOL_GPL(mt76x02_mac_write_txwi);
 
 static void
-mt76x02_mac_fill_tx_status(struct mt76x02_dev *dev,
+mt76x02_tx_rate_fallback(struct ieee80211_tx_rate *rates, int idx, int phy)
+{
+	u8 mcs, nss;
+
+	if (!idx)
+		return;
+
+	rates += idx - 1;
+	rates[1] = rates[0];
+	switch (phy) {
+	case MT_PHY_TYPE_VHT:
+		mcs = ieee80211_rate_get_vht_mcs(rates);
+		nss = ieee80211_rate_get_vht_nss(rates);
+
+		if (mcs == 0)
+			nss = max_t(int, nss - 1, 1);
+		else
+			mcs--;
+
+		ieee80211_rate_set_vht(rates + 1, mcs, nss);
+		break;
+	case MT_PHY_TYPE_HT_GF:
+	case MT_PHY_TYPE_HT:
+		/* MCS 8 falls back to MCS 0 */
+		if (rates[0].idx == 8) {
+		    rates[1].idx = 0;
+		    break;
+		}
+		/* fall through */
+	default:
+		rates[1].idx = max_t(int, rates[0].idx - 1, 0);
+		break;
+	}
+}
+
+static void
+mt76x02_mac_fill_tx_status(struct mt76x02_dev *dev, struct mt76x02_sta *msta,
 			   struct ieee80211_tx_info *info,
 			   struct mt76x02_tx_status *st, int n_frames)
 {
 	struct ieee80211_tx_rate *rate = info->status.rates;
-	int cur_idx, last_rate;
+	struct ieee80211_tx_rate last_rate;
+	u16 first_rate;
+	int retry = st->retry;
+	int phy;
 	int i;
 
 	if (!n_frames)
 		return;
 
-	last_rate = min_t(int, st->retry, IEEE80211_TX_MAX_RATES - 1);
-	mt76x02_mac_process_tx_rate(&rate[last_rate], st->rate,
+	phy = FIELD_GET(MT_RXWI_RATE_PHY, st->rate);
+
+	if (st->pktid & MT_PACKET_ID_HAS_RATE) {
+		first_rate = st->rate & ~MT_RXWI_RATE_INDEX;
+		first_rate |= st->pktid & MT_RXWI_RATE_INDEX;
+
+		mt76x02_mac_process_tx_rate(&rate[0], first_rate,
+					    dev->mt76.chandef.chan->band);
+	} else if (rate[0].idx < 0) {
+		if (!msta)
+			return;
+
+		mt76x02_mac_process_tx_rate(&rate[0], msta->wcid.tx_info,
+					    dev->mt76.chandef.chan->band);
+	}
+
+	mt76x02_mac_process_tx_rate(&last_rate, st->rate,
 				    dev->mt76.chandef.chan->band);
-	if (last_rate < IEEE80211_TX_MAX_RATES - 1)
-		rate[last_rate + 1].idx = -1;
-
-	cur_idx = rate[last_rate].idx + last_rate;
-	for (i = 0; i <= last_rate; i++) {
-		rate[i].flags = rate[last_rate].flags;
-		rate[i].idx = max_t(int, 0, cur_idx - i);
-		rate[i].count = 1;
+
+	for (i = 0; i < ARRAY_SIZE(info->status.rates); i++) {
+		retry--;
+		if (i + 1 == ARRAY_SIZE(info->status.rates)) {
+			info->status.rates[i] = last_rate;
+			info->status.rates[i].count = max_t(int, retry, 1);
+			break;
+		}
+
+		mt76x02_tx_rate_fallback(info->status.rates, i, phy);
+		if (info->status.rates[i].idx == last_rate.idx)
+			break;
+	}
+
+	if (i + 1 < ARRAY_SIZE(info->status.rates)) {
+		info->status.rates[i + 1].idx = -1;
+		info->status.rates[i + 1].count = 0;
 	}
-	rate[last_rate].count = st->retry + 1 - last_rate;
 
 	info->status.ampdu_len = n_frames;
 	info->status.ampdu_ack_len = st->success ? n_frames : 0;
@@ -489,13 +551,19 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 	mt76_tx_status_lock(mdev, &list);
 
 	if (wcid) {
-		if (stat->pktid >= MT_PACKET_ID_FIRST)
+		if (mt76_is_skb_pktid(stat->pktid))
 			status.skb = mt76_tx_status_skb_get(mdev, wcid,
 							    stat->pktid, &list);
 		if (status.skb)
 			status.info = IEEE80211_SKB_CB(status.skb);
 	}
 
+	if (!status.skb && !(stat->pktid & MT_PACKET_ID_HAS_RATE)) {
+		mt76_tx_status_unlock(mdev, &list);
+		rcu_read_unlock();
+		return;
+	}
+
 	if (msta && stat->aggr && !status.skb) {
 		u32 stat_val, stat_cache;
 
@@ -512,14 +580,14 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 			return;
 		}
 
-		mt76x02_mac_fill_tx_status(dev, status.info, &msta->status,
-					   msta->n_frames);
+		mt76x02_mac_fill_tx_status(dev, msta, status.info,
+					   &msta->status, msta->n_frames);
 
 		msta->status = *stat;
 		msta->n_frames = 1;
 		*update = 0;
 	} else {
-		mt76x02_mac_fill_tx_status(dev, status.info, stat, 1);
+		mt76x02_mac_fill_tx_status(dev, msta, status.info, stat, 1);
 		*update = 1;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
index cf7abd9b7d2e..95c73049a68b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
@@ -164,9 +164,14 @@ int mt76x02_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	mt76x02_mac_write_txwi(dev, txwi, tx_info->skb, wcid, sta, len);
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+
+	/* encode packet rate for no-skb packet id to fix up status reporting */
+	if (pid == MT_PACKET_ID_NO_SKB)
+		pid = MT_PACKET_ID_HAS_RATE | (txwi->rate & MT_RXWI_RATE_INDEX);
+
 	txwi->pktid = pid;
 
-	if (pid >= MT_PACKET_ID_FIRST)
+	if (mt76_is_skb_pktid(pid))
 		qsel = MT_QSEL_MGMT;
 
 	tx_info->info = FIELD_PREP(MT_TXD_INFO_QSEL, qsel) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 6b89f7eab26c..2436f14ca24a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -89,9 +89,14 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 	skb_push(tx_info->skb, sizeof(*txwi));
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+
+	/* encode packet rate for no-skb packet id to fix up status reporting */
+	if (pid == MT_PACKET_ID_NO_SKB)
+		pid = MT_PACKET_ID_HAS_RATE | (txwi->rate & MT_RXWI_RATE_INDEX);
+
 	txwi->pktid = pid;
 
-	if (pid >= MT_PACKET_ID_FIRST || ep == MT_EP_OUT_HCCA)
+	if (mt76_is_skb_pktid(pid) || ep == MT_EP_OUT_HCCA)
 		qsel = MT_QSEL_MGMT;
 	else
 		qsel = MT_QSEL_EDCA;
-- 
2.17.0


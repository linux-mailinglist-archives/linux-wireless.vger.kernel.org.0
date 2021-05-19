Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2D838971C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 21:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhEST5x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 15:57:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38663 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232233AbhEST5x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 15:57:53 -0400
X-UUID: 81b72d392a7848359bdd79f4bd7a51e7-20210520
X-UUID: 81b72d392a7848359bdd79f4bd7a51e7-20210520
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 415877565; Thu, 20 May 2021 03:56:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 May 2021 03:56:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 May 2021 03:56:26 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [RFC PATCH 3/4] mac80211: add rate control support for encap offload
Date:   Thu, 20 May 2021 03:56:23 +0800
Message-ID: <7fd4b92a277d1dab7435d310c5b12f1393e1d710.1621453091.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <a959135d3fe21118f38c33fc9ffb18124c1ef7ce.1621453091.git.ryder.lee@mediatek.com>
References: <a959135d3fe21118f38c33fc9ffb18124c1ef7ce.1621453091.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The software rate control cannot deal with encap offload, so fix it.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/ieee80211_i.h |  9 +++++++++
 net/mac80211/rate.c        |  9 ++-------
 net/mac80211/tx.c          | 18 ++++++++++++++----
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8fcbaa1eedf3..ba780c749e36 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2030,6 +2030,15 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tx_skb_tid(sdata, skb, 7);
 }
 
+static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	return info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP ||
+	       ieee80211_is_data(hdr->frame_control);
+}
+
 u32 ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			       struct ieee802_11_elems *elems,
 			       u64 filter, u32 crc, u8 *transmitter_bssid,
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 63652c39c8e0..8c6416129d5b 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -297,15 +297,11 @@ void ieee80211_check_rate_mask(struct ieee80211_sub_if_data *sdata)
 static bool rc_no_data_or_no_ack_use_min(struct ieee80211_tx_rate_control *txrc)
 {
 	struct sk_buff *skb = txrc->skb;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	__le16 fc;
-
-	fc = hdr->frame_control;
 
 	return (info->flags & (IEEE80211_TX_CTL_NO_ACK |
 			       IEEE80211_TX_CTL_USE_MINRATE)) ||
-		!ieee80211_is_data(fc);
+		!ieee80211_is_tx_data(skb);
 }
 
 static void rc_send_low_basicrate(struct ieee80211_tx_rate *rate,
@@ -870,7 +866,6 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 			    int max_rates)
 {
 	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_supported_band *sband;
 
@@ -882,7 +877,7 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 	sdata = vif_to_sdata(vif);
 	sband = sdata->local->hw.wiphy->bands[info->band];
 
-	if (ieee80211_is_data(hdr->frame_control))
+	if (ieee80211_is_tx_data(skb))
 		rate_control_apply_mask(sdata, sta, sband, dest, max_rates);
 
 	if (dest[0].idx < 0)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b3ef6aaece31..a0143a8003d2 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -666,6 +666,7 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	u32 len;
 	struct ieee80211_tx_rate_control txrc;
 	struct ieee80211_sta_rates *ratetbl = NULL;
+	bool encap = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	bool assoc = false;
 
 	memset(&txrc, 0, sizeof(txrc));
@@ -707,7 +708,7 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	 * just wants a probe response.
 	 */
 	if (tx->sdata->vif.bss_conf.use_short_preamble &&
-	    (ieee80211_is_data(hdr->frame_control) ||
+	    (ieee80211_is_tx_data(tx->skb) ||
 	     (tx->sta && test_sta_flag(tx->sta, WLAN_STA_SHORT_PREAMBLE))))
 		txrc.short_preamble = true;
 
@@ -729,7 +730,8 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 		 "%s: Dropped data frame as no usable bitrate found while "
 		 "scanning and associated. Target station: "
 		 "%pM on %d GHz band\n",
-		 tx->sdata->name, hdr->addr1,
+		 tx->sdata->name,
+		 encap ? ((struct ethhdr *)hdr)->h_dest : hdr->addr1,
 		 info->band ? 5 : 2))
 		return TX_DROP;
 
@@ -763,7 +765,7 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 
 	if (txrc.reported_rate.idx < 0) {
 		txrc.reported_rate = tx->rate;
-		if (tx->sta && ieee80211_is_data(hdr->frame_control))
+		if (tx->sta && ieee80211_is_tx_data(tx->skb))
 			tx->sta->tx_stats.last_rate = txrc.reported_rate;
 	} else if (tx->sta)
 		tx->sta->tx_stats.last_rate = txrc.reported_rate;
@@ -3653,8 +3655,16 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	else
 		info->flags &= ~IEEE80211_TX_CTL_AMPDU;
 
-	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+		if (!ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL)) {
+			r = ieee80211_tx_h_rate_ctrl(&tx);
+			if (r != TX_CONTINUE) {
+				ieee80211_free_txskb(&local->hw, skb);
+				goto begin;
+			}
+		}
 		goto encap_out;
+	}
 
 	if (info->control.flags & IEEE80211_TX_CTRL_FAST_XMIT) {
 		struct sta_info *sta = container_of(txq->sta, struct sta_info,
-- 
2.18.0


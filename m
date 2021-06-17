Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722C03AB9BF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhFQQdf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhFQQda (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:33:30 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C235EC061574
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XvMr0H3RGB9vZJafLSvf5+l1RbfM+u+O9kNIzRiUUDU=; b=OIXy/5W1r/ERwkkSkMdCI2Y/il
        erbPL7ln/K8HFKVF6hu3isKnTgt4K+FLb7Kg7+K/ne76fLr/5OaJmnua97ut/RA4/m/FZ5ieEQwVj
        NJXRdUoi2Q8Q9iM1KFiCvGcpOlJAd6cVcAuhNZpAKEWZQfEjXrzZOPVdQg0KjWQPN1T4=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ltuvE-0001vC-5P; Thu, 17 Jun 2021 18:31:16 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>, johannes@sipsolutions.net
Subject: [PATCH v3 3/3] mac80211: add rate control support for encap offload
Date:   Thu, 17 Jun 2021 18:31:13 +0200
Message-Id: <20210617163113.75815-3-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210617163113.75815-1-nbd@nbd.name>
References: <20210617163113.75815-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

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
index 5cb4a5c9597e..b27fb9138c55 100644
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
2.30.1


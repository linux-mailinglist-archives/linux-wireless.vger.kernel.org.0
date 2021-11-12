Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5044E505
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 11:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhKLK7I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 05:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhKLK7H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 05:59:07 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC558C061766
        for <linux-wireless@vger.kernel.org>; Fri, 12 Nov 2021 02:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EXxwEFcuWOBDVGcO/1MpVReAvmiOHqRIvE6AIwTgGNM=; b=RKUwVXtuzQ9RREYFPlh8kv/QQH
        reKCQMuuFklVePtVp4b/eE8BQcQABtHfI5f+wW6aK0RcP2N/PauzeafNHGmyRBO0mkG3Oc0HJ0Gih
        y35D84eQ0m0jcoWPFQsfFzoJ71ZdddJXyvYTdpAKQzrk4tLjM56boV8FUD1KtecK2HW8=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mlUEA-0001iu-04; Fri, 12 Nov 2021 11:56:14 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: fix throughput LED trigger
Date:   Fri, 12 Nov 2021 11:56:11 +0100
Message-Id: <20211112105611.99991-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The codepaths for rx with decap offload and tx with itxq were not updating
the counters for the throughput led trigger.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/led.h |  8 ++++----
 net/mac80211/rx.c  |  7 ++++---
 net/mac80211/tx.c  | 32 +++++++++++++++-----------------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/net/mac80211/led.h b/net/mac80211/led.h
index fb3aaa3c5606..b71a1428d883 100644
--- a/net/mac80211/led.h
+++ b/net/mac80211/led.h
@@ -72,19 +72,19 @@ static inline void ieee80211_mod_tpt_led_trig(struct ieee80211_local *local,
 #endif
 
 static inline void
-ieee80211_tpt_led_trig_tx(struct ieee80211_local *local, __le16 fc, int bytes)
+ieee80211_tpt_led_trig_tx(struct ieee80211_local *local, int bytes)
 {
 #ifdef CONFIG_MAC80211_LEDS
-	if (ieee80211_is_data(fc) && atomic_read(&local->tpt_led_active))
+	if (atomic_read(&local->tpt_led_active))
 		local->tpt_led_trigger->tx_bytes += bytes;
 #endif
 }
 
 static inline void
-ieee80211_tpt_led_trig_rx(struct ieee80211_local *local, __le16 fc, int bytes)
+ieee80211_tpt_led_trig_rx(struct ieee80211_local *local, int bytes)
 {
 #ifdef CONFIG_MAC80211_LEDS
-	if (ieee80211_is_data(fc) && atomic_read(&local->tpt_led_active))
+	if (atomic_read(&local->tpt_led_active))
 		local->tpt_led_trigger->rx_bytes += bytes;
 #endif
 }
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index fc5c608d02e2..3079328a30e8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4863,6 +4863,7 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	struct ieee80211_rate *rate = NULL;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
@@ -4959,9 +4960,9 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	if (!(status->flag & RX_FLAG_8023))
 		skb = ieee80211_rx_monitor(local, skb, rate);
 	if (skb) {
-		ieee80211_tpt_led_trig_rx(local,
-					  ((struct ieee80211_hdr *)skb->data)->frame_control,
-					  skb->len);
+		if ((status->flag & RX_FLAG_8023) ||
+			ieee80211_is_data_present(hdr->frame_control))
+			ieee80211_tpt_led_trig_rx(local, skb->len);
 
 		if (status->flag & RX_FLAG_8023)
 			__ieee80211_rx_handle_8023(hw, pubsta, skb, list);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a756a197c770..5b968d0793a7 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1721,8 +1721,8 @@ static bool ieee80211_tx_frags(struct ieee80211_local *local,
  * Returns false if the frame couldn't be transmitted but was queued instead.
  */
 static bool __ieee80211_tx(struct ieee80211_local *local,
-			   struct sk_buff_head *skbs, int led_len,
-			   struct sta_info *sta, bool txpending)
+			   struct sk_buff_head *skbs, struct sta_info *sta,
+			   bool txpending)
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_sub_if_data *sdata;
@@ -1769,8 +1769,6 @@ static bool __ieee80211_tx(struct ieee80211_local *local,
 
 	result = ieee80211_tx_frags(local, vif, sta, skbs, txpending);
 
-	ieee80211_tpt_led_trig_tx(local, fc, led_len);
-
 	WARN_ON_ONCE(!skb_queue_empty(skbs));
 
 	return result;
@@ -1920,7 +1918,6 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tx_result res_prepare;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	bool result = true;
-	int led_len;
 
 	if (unlikely(skb->len < 10)) {
 		dev_kfree_skb(skb);
@@ -1928,7 +1925,6 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* initialises tx */
-	led_len = skb->len;
 	res_prepare = ieee80211_tx_prepare(sdata, &tx, sta, skb);
 
 	if (unlikely(res_prepare == TX_DROP)) {
@@ -1951,8 +1947,7 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 		return true;
 
 	if (!invoke_tx_handlers_late(&tx))
-		result = __ieee80211_tx(local, &tx.skbs, led_len,
-					tx.sta, txpending);
+		result = __ieee80211_tx(local, &tx.skbs, tx.sta, txpending);
 
 	return result;
 }
@@ -4175,6 +4170,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 	struct sk_buff *next;
+	int len = skb->len;
 
 	if (unlikely(skb->len < ETH_HLEN)) {
 		kfree_skb(skb);
@@ -4221,10 +4217,8 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 		}
 	} else {
 		/* we cannot process non-linear frames on this path */
-		if (skb_linearize(skb)) {
-			kfree_skb(skb);
-			goto out;
-		}
+		if (skb_linearize(skb))
+			goto out_free;
 
 		/* the frame could be fragmented, software-encrypted, and other
 		 * things so we cannot really handle checksum offload with it -
@@ -4258,7 +4252,10 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	goto out;
  out_free:
 	kfree_skb(skb);
+	len = 0;
  out:
+	if (len)
+		ieee80211_tpt_led_trig_tx(local, len);
 	rcu_read_unlock();
 }
 
@@ -4396,8 +4393,7 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 }
 
 static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
-			      struct sk_buff *skb, int led_len,
-			      struct sta_info *sta,
+			      struct sk_buff *skb, struct sta_info *sta,
 			      bool txpending)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -4410,6 +4406,8 @@ static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
 	if (sta)
 		sk_pacing_shift_update(skb->sk, local->hw.tx_sk_pacing_shift);
 
+	ieee80211_tpt_led_trig_tx(local, skb->len);
+
 	if (ieee80211_queue_skb(local, sdata, sta, skb))
 		return true;
 
@@ -4498,7 +4496,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	if (key)
 		info->control.hw_key = &key->conf;
 
-	ieee80211_tx_8023(sdata, skb, skb->len, sta, false);
+	ieee80211_tx_8023(sdata, skb, sta, false);
 
 	return;
 
@@ -4637,7 +4635,7 @@ static bool ieee80211_tx_pending_skb(struct ieee80211_local *local,
 		if (IS_ERR(sta) || (sta && !sta->uploaded))
 			sta = NULL;
 
-		result = ieee80211_tx_8023(sdata, skb, skb->len, sta, true);
+		result = ieee80211_tx_8023(sdata, skb, sta, true);
 	} else {
 		struct sk_buff_head skbs;
 
@@ -4647,7 +4645,7 @@ static bool ieee80211_tx_pending_skb(struct ieee80211_local *local,
 		hdr = (struct ieee80211_hdr *)skb->data;
 		sta = sta_info_get(sdata, hdr->addr1);
 
-		result = __ieee80211_tx(local, &skbs, skb->len, sta, true);
+		result = __ieee80211_tx(local, &skbs, sta, true);
 	}
 
 	return result;
-- 
2.30.1


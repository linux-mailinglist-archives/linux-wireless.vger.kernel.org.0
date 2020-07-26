Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2922DE20
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jul 2020 13:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGZLGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jul 2020 07:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGZLGO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jul 2020 07:06:14 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E020AC0619D2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jul 2020 04:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DICjghJ03z37mHI6aT0fknehTBkH7CpReHv6gO3t68Y=; b=k+cdm6zG3SE1Y69HTglm6fWTXi
        jc4mu2zRxKbpZ9D0Z9GwPA/QRwmJRLosYwyM6OR1U2+b9cW6LWEDT+jMkiVTbTTna4DkJ7t8ESTdK
        EiNOYKNmtdVSf4AUBTS63n3XDM50QlxwcX6iDZaff84AXXj2oVscQSygJf7ShJ23th0Q=;
Received: from p5b206d80.dip0.t-ipconnect.de ([91.32.109.128] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jzeTs-00019B-Ds; Sun, 26 Jul 2020 13:06:12 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2] mac80211: add a function for running rx without passing skbs to the stack
Date:   Sun, 26 Jul 2020 13:06:11 +0200
Message-Id: <20200726110611.46886-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This can be used to run mac80211 rx processing on a batch of frames in NAPI
poll before passing them to the network stack in a large batch.
This can improve icache footprint, or it can be used to pass frames via
netif_receive_skb_list.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2:
- call skb_list_del_init before napi_gro_receive

Changes since RFC:
- use struct list_head instead of sk_buff_head
- use netif_receive_skb_list

 include/net/mac80211.h     | 25 ++++++++++++++++
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/rx.c          | 60 ++++++++++++++++++++++++--------------
 3 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 11d5610d2ad5..e95d7613ebfd 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4357,6 +4357,31 @@ void ieee80211_free_hw(struct ieee80211_hw *hw);
  */
 void ieee80211_restart_hw(struct ieee80211_hw *hw);
 
+/**
+ * ieee80211_rx_list - receive frame and store processed skbs in a list
+ *
+ * Use this function to hand received frames to mac80211. The receive
+ * buffer in @skb must start with an IEEE 802.11 header. In case of a
+ * paged @skb is used, the driver is recommended to put the ieee80211
+ * header of the frame on the linear part of the @skb to avoid memory
+ * allocation and/or memcpy by the stack.
+ *
+ * This function may not be called in IRQ context. Calls to this function
+ * for a single hardware must be synchronized against each other. Calls to
+ * this function, ieee80211_rx_ni() and ieee80211_rx_irqsafe() may not be
+ * mixed for a single hardware. Must not run concurrently with
+ * ieee80211_tx_status() or ieee80211_tx_status_ni().
+ *
+ * This function must be called with BHs disabled and RCU read lock
+ *
+ * @hw: the hardware this frame came in on
+ * @sta: the station the frame was received from, or %NULL
+ * @skb: the buffer to receive, owned by mac80211 after this call
+ * @list: the destination list
+ */
+void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+		       struct sk_buff *skb, struct list_head *list);
+
 /**
  * ieee80211_rx_napi - receive frame from NAPI context
  *
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 28b154c6e72d..6ff97d6bd597 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -218,7 +218,7 @@ enum ieee80211_rx_flags {
 };
 
 struct ieee80211_rx_data {
-	struct napi_struct *napi;
+	struct list_head *list;
 	struct sk_buff *skb;
 	struct ieee80211_local *local;
 	struct ieee80211_sub_if_data *sdata;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 5c5af4b5fc08..0cc0d72d0651 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2578,8 +2578,8 @@ static void ieee80211_deliver_skb_to_local_stack(struct sk_buff *skb,
 		memset(skb->cb, 0, sizeof(skb->cb));
 
 		/* deliver to local stack */
-		if (rx->napi)
-			napi_gro_receive(rx->napi, skb);
+		if (rx->list)
+			list_add_tail(&skb->list, rx->list);
 		else
 			netif_receive_skb(skb);
 	}
@@ -3869,7 +3869,6 @@ void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid)
 		/* This is OK -- must be QoS data frame */
 		.security_idx = tid,
 		.seqno_idx = tid,
-		.napi = NULL, /* must be NULL to not have races */
 	};
 	struct tid_ampdu_rx *tid_agg_rx;
 
@@ -4479,8 +4478,8 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	/* deliver to local stack */
 	skb->protocol = eth_type_trans(skb, fast_rx->dev);
 	memset(skb->cb, 0, sizeof(skb->cb));
-	if (rx->napi)
-		napi_gro_receive(rx->napi, skb);
+	if (rx->list)
+		list_add_tail(&skb->list, rx->list);
 	else
 		netif_receive_skb(skb);
 
@@ -4547,7 +4546,7 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 					 struct ieee80211_sta *pubsta,
 					 struct sk_buff *skb,
-					 struct napi_struct *napi)
+					 struct list_head *list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata;
@@ -4562,7 +4561,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	memset(&rx, 0, sizeof(rx));
 	rx.skb = skb;
 	rx.local = local;
-	rx.napi = napi;
+	rx.list = list;
 
 	if (ieee80211_is_data(fc) || ieee80211_is_mgmt(fc))
 		I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
@@ -4670,8 +4669,8 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  * This is the receive path handler. It is called by a low level driver when an
  * 802.11 MPDU is received from the hardware.
  */
-void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
-		       struct sk_buff *skb, struct napi_struct *napi)
+void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
+		       struct sk_buff *skb, struct list_head *list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_rate *rate = NULL;
@@ -4762,13 +4761,6 @@ void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 
 	status->rx_flags = 0;
 
-	/*
-	 * key references and virtual interfaces are protected using RCU
-	 * and this requires that we are in a read-side RCU section during
-	 * receive processing
-	 */
-	rcu_read_lock();
-
 	/*
 	 * Frames with failed FCS/PLCP checksum are not returned,
 	 * all other frames are returned without radiotap header
@@ -4776,23 +4768,47 @@ void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	 * Also, frames with less than 16 bytes are dropped.
 	 */
 	skb = ieee80211_rx_monitor(local, skb, rate);
-	if (!skb) {
-		rcu_read_unlock();
+	if (!skb)
 		return;
-	}
 
 	ieee80211_tpt_led_trig_rx(local,
 			((struct ieee80211_hdr *)skb->data)->frame_control,
 			skb->len);
 
-	__ieee80211_rx_handle_packet(hw, pubsta, skb, napi);
-
-	rcu_read_unlock();
+	__ieee80211_rx_handle_packet(hw, pubsta, skb, list);
 
 	return;
  drop:
 	kfree_skb(skb);
 }
+EXPORT_SYMBOL(ieee80211_rx_list);
+
+void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
+		       struct sk_buff *skb, struct napi_struct *napi)
+{
+	struct sk_buff *tmp;
+	LIST_HEAD(list);
+
+
+	/*
+	 * key references and virtual interfaces are protected using RCU
+	 * and this requires that we are in a read-side RCU section during
+	 * receive processing
+	 */
+	rcu_read_lock();
+	ieee80211_rx_list(hw, pubsta, skb, &list);
+	rcu_read_unlock();
+
+	if (!napi) {
+		netif_receive_skb_list(&list);
+		return;
+	}
+
+	list_for_each_entry_safe(skb, tmp, &list, list) {
+		skb_list_del_init(skb);
+		napi_gro_receive(napi, skb);
+	}
+}
 EXPORT_SYMBOL(ieee80211_rx_napi);
 
 /* This is a version of the rx handler that can be called from hard irq
-- 
2.24.0


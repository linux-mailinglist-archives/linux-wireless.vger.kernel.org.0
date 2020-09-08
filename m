Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7790D261508
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 18:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbgIHQmr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 12:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbgIHQmO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 12:42:14 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EDC061363
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7KpAqV0PhS+PGqVj4s9yxlmN10PImPPxIqBOcykwSfY=; b=O+WEIU6N7001661/qiKbTERig6
        GmhrT96Lz+YzcQqrt9Uj34dOTtcP9u7TumQRCGedMy01rI5hQUfkVwAYW9tJwv9Zf/oLQ04GqStT3
        zion2PoSZtCI44uw1TFYOsERD1MErdOHNo9f8MzH/F/XFGIWFnzepYsl1lxOzS03Pyas=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFcrx-00050i-0K; Tue, 08 Sep 2020 14:37:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v4 03/14] mac80211: skip encap offload for tx multicast/control packets
Date:   Tue,  8 Sep 2020 14:36:51 +0200
Message-Id: <20200908123702.88454-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908123702.88454-1-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This simplifies the checks in the encap offload tx handler and allows using
it in cases where software crypto is used for multicast packets, e.g. when
using an AP_VLAN.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 74 ++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 55 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index cd54d197caab..ea750081f6c6 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4193,88 +4193,47 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ethhdr *ehdr = (struct ethhdr *)skb->data;
 	struct ieee80211_local *local = sdata->local;
-	bool authorized = false;
-	bool multicast;
-	unsigned char *ra = ehdr->h_dest;
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
 
-	if (IS_ERR(sta) || (sta && !sta->uploaded))
-		sta = NULL;
-
-	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
-	    (!sta || !test_sta_flag(sta, WLAN_STA_TDLS_PEER)))
-		ra = sdata->u.mgd.bssid;
-
-	if (is_zero_ether_addr(ra))
-		goto out_free;
-
 	if (local->ops->wake_tx_queue) {
 		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
 		skb_set_queue_mapping(skb, queue);
 		skb_get_hash(skb);
 	}
 
-	multicast = is_multicast_ether_addr(ra);
-
-	if (sta)
-		authorized = test_sta_flag(sta, WLAN_STA_AUTHORIZED);
-
-	if (!multicast && !authorized &&
-	    (ehdr->h_proto != sdata->control_port_protocol ||
-	     !ether_addr_equal(sdata->vif.addr, ehdr->h_source)))
-		goto out_free;
-
-	if (multicast && sdata->vif.type == NL80211_IFTYPE_AP &&
-	    !atomic_read(&sdata->u.ap.num_mcast_sta))
-		goto out_free;
-
 	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
 	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
 		goto out_free;
 
 	memset(info, 0, sizeof(*info));
 
-	if (sta) {
-		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
-		if (tid_tx) {
-			if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
-				/* fall back to non-offload slow path */
-				__ieee80211_subif_start_xmit(skb, dev, 0, 0, NULL);
-				return;
-			}
-
-			info->flags |= IEEE80211_TX_CTL_AMPDU;
-			if (tid_tx->timeout)
-				tid_tx->last_tx = jiffies;
+	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
+	if (tid_tx) {
+		if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
+			/* fall back to non-offload slow path */
+			__ieee80211_subif_start_xmit(skb, dev, 0, 0, NULL);
+			return;
 		}
+
+		info->flags |= IEEE80211_TX_CTL_AMPDU;
+		if (tid_tx->timeout)
+			tid_tx->last_tx = jiffies;
 	}
 
-	if (unlikely(!multicast && skb->sk &&
+	if (unlikely(skb->sk &&
 		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
 		info->ack_frame_id = ieee80211_store_ack_skb(local, skb,
 							     &info->flags, NULL);
 
-	if (unlikely(sdata->control_port_protocol == ehdr->h_proto)) {
-		if (sdata->control_port_no_encrypt)
-			info->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
-		info->control.flags |= IEEE80211_TX_CTRL_PORT_CTRL_PROTO;
-	}
-
-	if (multicast)
-		info->flags |= IEEE80211_TX_CTL_NO_ACK;
-
 	info->hw_queue = sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
 
 	ieee80211_tx_stats(dev, skb->len);
 
-	if (sta) {
-		sta->tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
-		sta->tx_stats.packets[skb_get_queue_mapping(skb)]++;
-	}
+	sta->tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
+	sta->tx_stats.packets[skb_get_queue_mapping(skb)]++;
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		sdata = container_of(sdata->bss,
@@ -4295,6 +4254,7 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 					    struct net_device *dev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ethhdr *ehdr = (struct ethhdr *)skb->data;
 	struct sta_info *sta;
 
 	if (WARN_ON(!sdata->hw_80211_encap)) {
@@ -4311,6 +4271,10 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 
 	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
 		kfree_skb(skb);
+	else if (unlikely(IS_ERR_OR_NULL(sta) || !sta->uploaded ||
+			  !test_sta_flag(sta, WLAN_STA_AUTHORIZED) ||
+			  sdata->control_port_protocol == ehdr->h_proto))
+		ieee80211_subif_start_xmit(skb, dev);
 	else
 		ieee80211_8023_xmit(sdata, dev, sta, skb);
 
-- 
2.28.0


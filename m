Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05832D4E58
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 23:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbgLIWxI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 17:53:08 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:60223 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgLIWxI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 17:53:08 -0500
Received: from legolas.fritz.box (unknown [93.209.11.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id DE94B58006C;
        Wed,  9 Dec 2020 23:52:24 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mac80211: enable QoS support for nl80211 ctrl port
Date:   Wed,  9 Dec 2020 23:52:14 +0100
Message-Id: <20201209225214.127548-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch unifies sending control port frames
over nl80211 and AF_PACKET sockets a little more.

Before this patch, EAPOL frames got QoS prioritization
only when using AF_PACKET sockets.

__ieee80211_select_queue only selects a QoS-enabled queue
for control port frames, when the control port protocol
is set correctly on the skb. For the AF_PACKET path this
works, but the nl80211 path used ETH_P_802_3.

Another check for injected frames in wme.c then prevented
the QoS TID to be copied in the frame.

In order to fix this, get rid of the frame injection marking
for nl80211 ctrl port and set the correct ethernet protocol.

Furthermore, this patch also checks and prevents frame
aggregation for control port frames in order to speed up
the initial connection setup a little.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/mac80211/status.c |  8 ++------
 net/mac80211/tx.c     | 15 +++++++--------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 6feb45135..265c1d13b 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -627,16 +627,12 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 		u64 cookie = IEEE80211_SKB_CB(skb)->ack.cookie;
 		struct ieee80211_sub_if_data *sdata;
 		struct ieee80211_hdr *hdr = (void *)skb->data;
-		__be16 ethertype = 0;
-
-		if (skb->len >= ETH_HLEN && skb->protocol == cpu_to_be16(ETH_P_802_3))
-			skb_copy_bits(skb, 2 * ETH_ALEN, &ethertype, ETH_TLEN);
 
 		rcu_read_lock();
 		sdata = ieee80211_sdata_from_skb(local, skb);
 		if (sdata) {
-			if (ethertype == sdata->control_port_protocol ||
-			    ethertype == cpu_to_be16(ETH_P_PREAUTH))
+			if (skb->protocol == sdata->control_port_protocol ||
+			    skb->protocol == cpu_to_be16(ETH_P_PREAUTH))
 				cfg80211_control_port_tx_status(&sdata->wdev,
 								cookie,
 								skb->data,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 01eb08527..4dae5aa7f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1192,9 +1192,7 @@ ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
 			tx->sta = rcu_dereference(sdata->u.vlan.sta);
 			if (!tx->sta && sdata->wdev.use_4addr)
 				return TX_DROP;
-		} else if (info->flags & (IEEE80211_TX_INTFL_NL80211_FRAME_TX |
-					  IEEE80211_TX_CTL_INJECTED) ||
-			   tx->sdata->control_port_protocol == tx->skb->protocol) {
+		} else if (tx->sdata->control_port_protocol == tx->skb->protocol) {
 			tx->sta = sta_info_get_bss(sdata, hdr->addr1);
 		}
 		if (!tx->sta && !is_multicast_ether_addr(hdr->addr1))
@@ -1204,7 +1202,8 @@ ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
 	if (tx->sta && ieee80211_is_data_qos(hdr->frame_control) &&
 	    !ieee80211_is_qos_nullfunc(hdr->frame_control) &&
 	    ieee80211_hw_check(&local->hw, AMPDU_AGGREGATION) &&
-	    !ieee80211_hw_check(&local->hw, TX_AMPDU_SETUP_IN_HW)) {
+	    !ieee80211_hw_check(&local->hw, TX_AMPDU_SETUP_IN_HW) &&
+	    !info->flags & IEEE80211_TX_CTRL_PORT_CTRL_PROTO) {
 		struct tid_ampdu_tx *tid_tx;
 
 		tid = ieee80211_get_tid(hdr);
@@ -3944,7 +3943,8 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	if (IS_ERR(sta))
 		sta = NULL;
 
-	if (local->ops->wake_tx_queue) {
+	if (local->ops->wake_tx_queue ||
+	    skb->protocol == sdata->control_port_protocol) {
 		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
 		skb_set_queue_mapping(skb, queue);
 		skb_get_hash(skb);
@@ -5440,8 +5440,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	if (cookie)
 		ctrl_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
 
-	flags |= IEEE80211_TX_INTFL_NL80211_FRAME_TX |
-		 IEEE80211_TX_CTL_INJECTED;
+	flags |= IEEE80211_TX_INTFL_NL80211_FRAME_TX;
 
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom +
 			    sizeof(struct ethhdr) + len);
@@ -5458,7 +5457,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	ehdr->h_proto = proto;
 
 	skb->dev = dev;
-	skb->protocol = htons(ETH_P_802_3);
+	skb->protocol = proto;
 	skb_reset_network_header(skb);
 	skb_reset_mac_header(skb);
 
-- 
2.29.2


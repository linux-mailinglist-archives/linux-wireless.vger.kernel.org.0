Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B9D311CFC
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Feb 2021 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBFLwH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Feb 2021 06:52:07 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:39653 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBFLwF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Feb 2021 06:52:05 -0500
Received: from legolas.fritz.box (unknown [87.147.51.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id C9C96580060;
        Sat,  6 Feb 2021 12:51:19 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] mac80211: enable QoS support for nl80211 ctrl port
Date:   Sat,  6 Feb 2021 12:51:12 +0100
Message-Id: <20210206115112.567881-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.30.0
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

Please note:
An erlier version of this path tried to prevent
frame aggregation for control port frames in order to speed up
the initial connection setup a little. This seemed to cause
issues on my older Intel dvm-based hardware, and was therefore
removed again. Future commits which try to reintroduce this
have to check carefully how hw behaves with aggregated and
non-aggregated traffic for the same TID.
My NIC: Intel(R) Centrino(R) Ultimate-N 6300 AGN, REV=0x74

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
v3: move queue selection to ieee80211_tx_control_port
v2: remove aggregation bypass for control port frames

 net/mac80211/status.c |  8 ++------
 net/mac80211/tx.c     | 25 +++++++++++++++++++------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 3485610755ef..9baf185ee4c7 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -628,16 +628,12 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
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
index d626e6808bef..6ec415f043e1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1182,9 +1182,7 @@ ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
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
@@ -5404,6 +5402,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
+	struct sta_info *sta;
 	struct sk_buff *skb;
 	struct ethhdr *ehdr;
 	u32 ctrl_flags = 0;
@@ -5426,8 +5425,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	if (cookie)
 		ctrl_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
 
-	flags |= IEEE80211_TX_INTFL_NL80211_FRAME_TX |
-		 IEEE80211_TX_CTL_INJECTED;
+	flags |= IEEE80211_TX_INTFL_NL80211_FRAME_TX;
 
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom +
 			    sizeof(struct ethhdr) + len);
@@ -5444,10 +5442,25 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	ehdr->h_proto = proto;
 
 	skb->dev = dev;
-	skb->protocol = htons(ETH_P_802_3);
+	skb->protocol = proto;
 	skb_reset_network_header(skb);
 	skb_reset_mac_header(skb);
 
+	/* update QoS header to prioritize control port frames if possible,
+	 * priorization also happens for control port frames send over
+	 * AF_PACKET
+	 */
+	rcu_read_lock();
+
+	if (ieee80211_lookup_ra_sta(sdata, skb, &sta) == 0 && !IS_ERR(sta)) {
+		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
+
+		skb_set_queue_mapping(skb, queue);
+		skb_get_hash(skb);
+	}
+
+	rcu_read_unlock();
+
 	/* mutex lock is only needed for incrementing the cookie counter */
 	mutex_lock(&local->mtx);
 
-- 
2.30.0


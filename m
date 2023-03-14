Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6C6B8F1C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 11:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCNKAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCNKAN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 06:00:13 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC327B9B1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=S9mXz92IwANo9W6BvEX/MTA4bi1YvEKDLzEk/JqHTe4=; b=YcZJfI9PrIdos9ryNJj2OYmoJg
        lpNjk3abXlE5cN56glk/HYYxsOr2BccBoMmZ17PlH1kImkC4jZ3GGOTGIpJkLc/yFa1hMXlhmm8/V
        guOKcwExRCZvIHxR2WXwsz4Jaao1+9VvpR8NCkLKTM+yFrJ6L5fqcqSbfzZ7x1KoZdJg=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pc1Ro-001pV5-3C; Tue, 14 Mar 2023 11:00:00 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 5/7] wifi: mac80211: use mesh header cache to speed up mesh forwarding
Date:   Tue, 14 Mar 2023 10:59:54 +0100
Message-Id: <20230314095956.62085-5-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230314095956.62085-1-nbd@nbd.name>
References: <20230314095956.62085-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Significantly reduces mesh forwarding path CPU usage and enables the
direct use of iTXQ.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/rx.c          | 65 +++++++++++++++++++++++++++++++++++++-
 net/mac80211/tx.c          |  6 ++--
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 54e69c6447c0..a897275f7a0d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2037,6 +2037,8 @@ void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 			   struct ieee80211_fast_tx *fast_tx,
 			   struct sk_buff *skb, bool ampdu,
 			   const u8 *da, const u8 *sa);
+void ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
+			  struct sta_info *sta, struct sk_buff *skb);
 
 /* HT */
 void ieee80211_apply_htcap_overrides(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0553ccf4831a..cdad8a081cf1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2701,6 +2701,65 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 	}
 }
 
+#ifdef CONFIG_MAC80211_MESH
+static bool
+ieee80211_rx_mesh_fast_forward(struct ieee80211_sub_if_data *sdata,
+			       struct sk_buff *skb, int hdrlen)
+{
+	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_mesh_fast_tx *entry = NULL;
+	struct ieee80211s_hdr *mesh_hdr;
+	struct tid_ampdu_tx *tid_tx;
+	struct sta_info *sta;
+	struct ethhdr eth;
+	u8 tid;
+
+	mesh_hdr = (struct ieee80211s_hdr *)(skb->data + sizeof(eth));
+	if ((mesh_hdr->flags & MESH_FLAGS_AE) == MESH_FLAGS_AE_A5_A6)
+		entry = mesh_fast_tx_get(sdata, mesh_hdr->eaddr1);
+	else if (!(mesh_hdr->flags & MESH_FLAGS_AE))
+		entry = mesh_fast_tx_get(sdata, skb->data);
+	if (!entry)
+		return false;
+
+	sta = rcu_dereference(entry->mpath->next_hop);
+	if (!sta)
+		return false;
+
+	if (skb_linearize(skb))
+		return false;
+
+	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
+	if (tid_tx) {
+		if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state))
+			return false;
+
+		if (tid_tx->timeout)
+			tid_tx->last_tx = jiffies;
+	}
+
+	ieee80211_aggr_check(sdata, sta, skb);
+
+	if (ieee80211_get_8023_tunnel_proto(skb->data + hdrlen,
+					    &skb->protocol))
+		hdrlen += ETH_ALEN;
+	else
+		skb->protocol = htons(skb->len - hdrlen);
+	skb_set_network_header(skb, hdrlen + 2);
+
+	skb->dev = sdata->dev;
+	memcpy(&eth, skb->data, ETH_HLEN - 2);
+	skb_pull(skb, 2);
+	__ieee80211_xmit_fast(sdata, sta, &entry->fast_tx, skb, tid_tx,
+			      eth.h_dest, eth.h_source);
+	IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_unicast);
+	IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_frames);
+
+	return true;
+}
+#endif
+
 static ieee80211_rx_result
 ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta,
 		       struct sk_buff *skb)
@@ -2805,6 +2864,10 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 
 	skb_set_queue_mapping(skb, ieee802_1d_to_ac[skb->priority]);
 
+	if (!multicast &&
+	    ieee80211_rx_mesh_fast_forward(sdata, skb, mesh_hdrlen))
+		return RX_QUEUED;
+
 	ieee80211_fill_mesh_addresses(&hdr, &hdr.frame_control,
 				      eth->h_dest, eth->h_source);
 	hdrlen = ieee80211_hdrlen(hdr.frame_control);
@@ -2843,6 +2906,7 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 	info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 	info->control.vif = &sdata->vif;
 	info->control.jiffies = jiffies;
+	fwd_skb->dev = sdata->dev;
 	if (multicast) {
 		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_mcast);
 		memcpy(fwd_hdr->addr2, sdata->vif.addr, ETH_ALEN);
@@ -2864,7 +2928,6 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 	}
 
 	IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_frames);
-	fwd_skb->dev = sdata->dev;
 	ieee80211_add_pending_skb(local, fwd_skb);
 
 rx_accept:
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ad6193693363..de17926484bd 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1189,10 +1189,8 @@ static bool ieee80211_tx_prep_agg(struct ieee80211_tx_data *tx,
 	return queued;
 }
 
-static void
-ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
-		     struct sta_info *sta,
-		     struct sk_buff *skb)
+void ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
+			  struct sta_info *sta, struct sk_buff *skb)
 {
 	struct rate_control_ref *ref = sdata->local->rate_ctrl;
 	u16 tid;
-- 
2.39.0


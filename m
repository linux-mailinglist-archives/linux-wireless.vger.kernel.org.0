Return-Path: <linux-wireless+bounces-30901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71922D2DEC2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 09:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB61F3015955
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC082D8773;
	Fri, 16 Jan 2026 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f413cH5C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB32236EB
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551632; cv=none; b=UcQR6xbLDZuAMkS8ESFAs6sXyrxoXIJWMdj6XRu7+7fKwWioRwRHyCmDOKwQYXNxg0y7c8jvtJwBgs5HMV/FV1rb3a3jBaluL25OJy94Wvk3duyp0atCCP08c6INWyzICFQVncY34uXj6JgcVyQqbN0P8UR/6KNbiYATS4Xa2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551632; c=relaxed/simple;
	bh=O3vPrJZ83xzhaEhkqJ09LdxBg8/d+TsHDTVuJ0lz88Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=istC8fl1E0ucyYQsRPAAx4H+RUdaTUSIPaTcgxPTc4OZhA9jsDjmObjQ0zKjxAp+1Lpamh3GE26FJGzm7wHvHBcari35J8MCYlilA0IH1xLFx1mDpJo9SopYepQr+Tcc96Hsk6oH6kBp/3NDFGQPhTGDzl/yonpzyJhDpJe4vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f413cH5C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=V5qqrZfc0lXX4ar81zhhws9RlE7pS25wz/Z/v7z2lQ0=; t=1768551630; x=1769761230; 
	b=f413cH5CrcKZTCxmYBFJTLB1trMVuQP0Hu2Lq2N1hGp0JJtygxSGrCbz+kylcMZSFH1nj73VJcB
	9GEBlLNesgdR6UO56n229BogQb8YWX0jAynG0l4n4C647+0N52ZWpER3WaknKTFu77tNk3ugDFUg0
	PHoVEWEutNO1LaqZrA3k7MBkDOL7v0a7a9SmVCYFvO51LUuztNdBMOz2/cWiZCs4eGjB+hYMrSU3s
	OtoKdzZaYmlPajajDOc+wGaLYas9ZAdwKq6BxeA0MszQzIIOGk1cwnhtWl9C7J2KRR7ElLFLXexou
	Fjp2Fhidqt7Eo6+LahLLyINPLSyiWhRefrgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vgf4F-0000000DKuU-2v8U;
	Fri, 16 Jan 2026 09:20:27 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: remove RX_DROP
Date: Fri, 16 Jan 2026 09:20:25 +0100
Message-ID: <20260116092025.79d995e87026.I7cde413988f7a382c551cd1c1e2b05a52ec71755@changeid>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since it's hard to figure out what RX_DROP means when looking
at traces that drop packets in mac80211, add more specific drop
reasons and remove RX_DROP entirely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/drop.h | 46 ++++++++++++++++++++-
 net/mac80211/rx.c   | 98 +++++++++++++++++++++++----------------------
 2 files changed, 94 insertions(+), 50 deletions(-)

diff --git a/net/mac80211/drop.h b/net/mac80211/drop.h
index eb9ab310f91c..f06a8aa905c5 100644
--- a/net/mac80211/drop.h
+++ b/net/mac80211/drop.h
@@ -2,7 +2,7 @@
 /*
  * mac80211 drop reason list
  *
- * Copyright (C) 2023-2024 Intel Corporation
+ * Copyright (C) 2023-2024, 2026 Intel Corporation
  */
 
 #ifndef MAC80211_DROP_H
@@ -65,6 +65,49 @@ typedef unsigned int __bitwise ieee80211_rx_result;
 	/* 0x30 */				\
 	R(RX_DROP_U_BAD_MGMT_KEYIDX)		\
 	R(RX_DROP_U_UNKNOWN_ACTION_REJECTED)	\
+	R(RX_DROP_U_MESH_DS_BITS)		\
+	R(RX_DROP_U_MESH_A3_MISMATCH)		\
+	R(RX_DROP_U_MESH_NO_A4)			\
+	R(RX_DROP_U_MESH_A4_MISMATCH)		\
+	R(RX_DROP_U_MESH_UNEXP_DATA)		\
+	R(RX_DROP_U_MESH_WRONG_ACTION)		\
+	R(RX_DROP_U_MESH_UNEXP_MGMT)		\
+	R(RX_DROP_U_SPURIOUS_NOTIF)		\
+	R(RX_DROP_U_RUNT_DATA)			\
+	R(RX_DROP_U_KEY_TAINTED)		\
+	R(RX_DROP_U_UNPROTECTED)		\
+	R(RX_DROP_U_MCAST_FRAGMENT)		\
+	R(RX_DROP_U_DEFRAG_MISMATCH)		\
+	R(RX_DROP_U_RUNT_MESH_DATA)		\
+	/* 0x40 */				\
+	R(RX_DROP_U_MESH_NO_TTL)		\
+	R(RX_DROP_U_MESH_RMC)			\
+	R(RX_DROP_U_MESH_BAD_AE)		\
+	R(RX_DROP_U_MESH_TTL_EXPIRED)		\
+	R(RX_DROP_U_MESH_NOT_FORWARDING)	\
+	R(RX_DROP_U_AMSDU_WITHOUT_DATA)		\
+	R(RX_DROP_U_NULL_DATA)			\
+	R(RX_DROP_U_UNEXPECTED_4ADDR)		\
+	R(RX_DROP_U_PORT_CONTROL)		\
+	R(RX_DROP_U_UNKNOWN_STA)		\
+	R(RX_DROP_U_RUNT_BAR)			\
+	R(RX_DROP_U_BAR_OUTSIDE_SESSION)	\
+	R(RX_DROP_U_CTRL_FRAME)			\
+	R(RX_DROP_U_RUNT_MGMT)			\
+	R(RX_DROP_U_EXPECTED_MGMT)		\
+	R(RX_DROP_U_NONBCAST_BEACON)		\
+	/* 0x50 */				\
+	R(RX_DROP_U_MALFORMED_ACTION)		\
+	R(RX_DROP_U_UNKNOWN_MCAST_ACTION)	\
+	R(RX_DROP_U_UNEXPECTED_EXT_FRAME)	\
+	R(RX_DROP_U_UNHANDLED_MGMT)		\
+	R(RX_DROP_U_MCAST_DEAUTH)		\
+	R(RX_DROP_U_UNHANDLED_DEAUTH)		\
+	R(RX_DROP_U_MCAST_DISASSOC)		\
+	R(RX_DROP_U_UNHANDLED_DISASSOC)		\
+	R(RX_DROP_U_UNHANDLED_PREQ)		\
+	R(RX_DROP_U_UNHANDLED_MGMT_STYPE)	\
+	R(RX_DROP_U_NO_LINK)			\
 /* this line for the trailing \ - add before this */
 
 /* having two enums allows for checking ieee80211_rx_result use with sparse */
@@ -85,7 +128,6 @@ enum ___mac80211_drop_reason {
 enum mac80211_drop_reason {
 	RX_CONTINUE	= (__force ieee80211_rx_result)___RX_CONTINUE,
 	RX_QUEUED	= (__force ieee80211_rx_result)___RX_QUEUED,
-	RX_DROP		= (__force ieee80211_rx_result)___RX_DROP_UNUSABLE,
 #define DEF(x) x = (__force ieee80211_rx_result)___ ## x,
 	MAC80211_DROP_REASONS_UNUSABLE(DEF)
 #undef DEF
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 9a2b0ef2f21a..ac437256f5d5 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #include <linux/jiffies.h>
@@ -1137,14 +1137,14 @@ static ieee80211_rx_result ieee80211_rx_mesh_check(struct ieee80211_rx_data *rx)
 		if (is_multicast_ether_addr(hdr->addr1)) {
 			if (ieee80211_has_tods(hdr->frame_control) ||
 			    !ieee80211_has_fromds(hdr->frame_control))
-				return RX_DROP;
+				return RX_DROP_U_MESH_DS_BITS;
 			if (ether_addr_equal(hdr->addr3, dev_addr))
-				return RX_DROP;
+				return RX_DROP_U_MESH_A3_MISMATCH;
 		} else {
 			if (!ieee80211_has_a4(hdr->frame_control))
-				return RX_DROP;
+				return RX_DROP_U_MESH_NO_A4;
 			if (ether_addr_equal(hdr->addr4, dev_addr))
-				return RX_DROP;
+				return RX_DROP_U_MESH_A4_MISMATCH;
 		}
 	}
 
@@ -1156,20 +1156,20 @@ static ieee80211_rx_result ieee80211_rx_mesh_check(struct ieee80211_rx_data *rx)
 		struct ieee80211_mgmt *mgmt;
 
 		if (!ieee80211_is_mgmt(hdr->frame_control))
-			return RX_DROP;
+			return RX_DROP_U_MESH_UNEXP_DATA;
 
 		if (ieee80211_is_action(hdr->frame_control)) {
 			u8 category;
 
 			/* make sure category field is present */
 			if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE)
-				return RX_DROP;
+				return RX_DROP_U_RUNT_ACTION;
 
 			mgmt = (struct ieee80211_mgmt *)hdr;
 			category = mgmt->u.action.category;
 			if (category != WLAN_CATEGORY_MESH_ACTION &&
 			    category != WLAN_CATEGORY_SELF_PROTECTED)
-				return RX_DROP;
+				return RX_DROP_U_MESH_WRONG_ACTION;
 			return RX_CONTINUE;
 		}
 
@@ -1179,7 +1179,7 @@ static ieee80211_rx_result ieee80211_rx_mesh_check(struct ieee80211_rx_data *rx)
 		    ieee80211_is_auth(hdr->frame_control))
 			return RX_CONTINUE;
 
-		return RX_DROP;
+		return RX_DROP_U_MESH_UNEXP_MGMT;
 	}
 
 	return RX_CONTINUE;
@@ -1605,7 +1605,7 @@ ieee80211_rx_h_check(struct ieee80211_rx_data *rx)
 			hdrlen = ieee80211_hdrlen(hdr->frame_control);
 
 			if (rx->skb->len < hdrlen + 8)
-				return RX_DROP;
+				return RX_DROP_U_RUNT_DATA;
 
 			skb_copy_bits(rx->skb, hdrlen + 6, &ethertype, 2);
 			if (ethertype == rx->sdata->control_port_protocol)
@@ -1615,9 +1615,9 @@ ieee80211_rx_h_check(struct ieee80211_rx_data *rx)
 		if (rx->sdata->vif.type == NL80211_IFTYPE_AP &&
 		    cfg80211_rx_spurious_frame(rx->sdata->dev, hdr->addr2,
 					       rx->link_id, GFP_ATOMIC))
-			return RX_DROP_U_SPURIOUS;
+			return RX_DROP_U_SPURIOUS_NOTIF;
 
-		return RX_DROP;
+		return RX_DROP_U_SPURIOUS;
 	}
 
 	return RX_CONTINUE;
@@ -2106,7 +2106,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 		if (rx->link_sta) {
 			if (ieee80211_is_group_privacy_action(skb) &&
 			    test_sta_flag(rx->sta, WLAN_STA_MFP))
-				return RX_DROP;
+				return RX_DROP_U_UNPROTECTED;
 
 			rx->key = rcu_dereference(rx->link_sta->gtk[mmie_keyidx]);
 		}
@@ -2191,11 +2191,11 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 
 	if (rx->key) {
 		if (unlikely(rx->key->flags & KEY_FLAG_TAINTED))
-			return RX_DROP;
+			return RX_DROP_U_KEY_TAINTED;
 
 		/* TODO: add threshold stuff again */
 	} else {
-		return RX_DROP;
+		return RX_DROP_U_UNPROTECTED;
 	}
 
 	switch (rx->key->conf.cipher) {
@@ -2371,7 +2371,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 		goto out;
 
 	if (is_multicast_ether_addr(hdr->addr1))
-		return RX_DROP;
+		return RX_DROP_U_MCAST_FRAGMENT;
 
 	I802_DEBUG_INC(rx->local->rx_handlers_fragments);
 
@@ -2426,7 +2426,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 					  rx->seqno_idx, hdr);
 	if (!entry) {
 		I802_DEBUG_INC(rx->local->rx_handlers_drop_defrag);
-		return RX_DROP;
+		return RX_DROP_U_DEFRAG_MISMATCH;
 	}
 
 	/* "The receiver shall discard MSDUs and MMPDUs whose constituent
@@ -2956,25 +2956,25 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 		return RX_CONTINUE;
 
 	if (!pskb_may_pull(skb, sizeof(*eth) + 6))
-		return RX_DROP;
+		return RX_DROP_U_RUNT_MESH_DATA;
 
 	mesh_hdr = (struct ieee80211s_hdr *)(skb->data + sizeof(*eth));
 	mesh_hdrlen = ieee80211_get_mesh_hdrlen(mesh_hdr);
 
 	if (!pskb_may_pull(skb, sizeof(*eth) + mesh_hdrlen))
-		return RX_DROP;
+		return RX_DROP_U_RUNT_MESH_DATA;
 
 	eth = (struct ethhdr *)skb->data;
 	multicast = is_multicast_ether_addr(eth->h_dest);
 
 	mesh_hdr = (struct ieee80211s_hdr *)(eth + 1);
 	if (!mesh_hdr->ttl)
-		return RX_DROP;
+		return RX_DROP_U_MESH_NO_TTL;
 
 	/* frame is in RMC, don't forward */
 	if (is_multicast_ether_addr(eth->h_dest) &&
 	    mesh_rmc_check(sdata, eth->h_source, mesh_hdr))
-		return RX_DROP;
+		return RX_DROP_U_MESH_RMC;
 
 	/* forward packet */
 	if (sdata->crypto_tx_tailroom_needed_cnt)
@@ -2991,7 +2991,7 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 			/* has_a4 already checked in ieee80211_rx_mesh_check */
 			proxied_addr = mesh_hdr->eaddr2;
 		else
-			return RX_DROP;
+			return RX_DROP_U_MESH_BAD_AE;
 
 		rcu_read_lock();
 		mppath = mpp_path_lookup(sdata, proxied_addr);
@@ -3023,14 +3023,14 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 			goto rx_accept;
 
 		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_ttl);
-		return RX_DROP;
+		return RX_DROP_U_MESH_TTL_EXPIRED;
 	}
 
 	if (!ifmsh->mshcfg.dot11MeshForwarding) {
 		if (is_multicast_ether_addr(eth->h_dest))
 			goto rx_accept;
 
-		return RX_DROP;
+		return RX_DROP_U_MESH_NOT_FORWARDING;
 	}
 
 	skb_set_queue_mapping(skb, ieee802_1d_to_ac[skb->priority]);
@@ -3216,7 +3216,7 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
 		return RX_CONTINUE;
 
 	if (unlikely(!ieee80211_is_data_present(fc)))
-		return RX_DROP;
+		return RX_DROP_U_AMSDU_WITHOUT_DATA;
 
 	if (unlikely(ieee80211_has_a4(hdr->frame_control))) {
 		switch (rx->sdata->vif.type) {
@@ -3273,7 +3273,7 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 		return RX_CONTINUE;
 
 	if (unlikely(!ieee80211_is_data_present(hdr->frame_control)))
-		return RX_DROP;
+		return RX_DROP_U_NULL_DATA;
 
 	/* Send unexpected-4addr-frame event to hostapd */
 	if (ieee80211_has_a4(hdr->frame_control) &&
@@ -3283,7 +3283,7 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 			cfg80211_rx_unexpected_4addr_frame(
 				rx->sdata->dev, rx->sta->sta.addr, rx->link_id,
 				GFP_ATOMIC);
-		return RX_DROP;
+		return RX_DROP_U_UNEXPECTED_4ADDR;
 	}
 
 	res = __ieee80211_data_to_8023(rx, &port_control);
@@ -3295,7 +3295,7 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 		return res;
 
 	if (!ieee80211_frame_allowed(rx, fc))
-		return RX_DROP;
+		return RX_DROP_U_PORT_CONTROL;
 
 	/* directly handle TDLS channel switch requests/responses */
 	if (unlikely(((struct ethhdr *)rx->skb->data)->h_proto ==
@@ -3360,11 +3360,11 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_data *rx, struct sk_buff_head *frames)
 		};
 
 		if (!rx->sta)
-			return RX_DROP;
+			return RX_DROP_U_UNKNOWN_STA;
 
 		if (skb_copy_bits(skb, offsetof(struct ieee80211_bar, control),
 				  &bar_data, sizeof(bar_data)))
-			return RX_DROP;
+			return RX_DROP_U_RUNT_BAR;
 
 		tid = le16_to_cpu(bar_data.control) >> 12;
 
@@ -3376,7 +3376,7 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_data *rx, struct sk_buff_head *frames)
 
 		tid_agg_rx = rcu_dereference(rx->sta->ampdu_mlme.tid_rx[tid]);
 		if (!tid_agg_rx)
-			return RX_DROP;
+			return RX_DROP_U_BAR_OUTSIDE_SESSION;
 
 		start_seq_num = le16_to_cpu(bar_data.start_seq_num) >> 4;
 		event.u.ba.tid = tid;
@@ -3400,7 +3400,7 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_data *rx, struct sk_buff_head *frames)
 		return RX_QUEUED;
 	}
 
-	return RX_DROP;
+	return RX_DROP_U_CTRL_FRAME;
 }
 
 static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
@@ -3509,10 +3509,10 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	 * and unknown (reserved) frames are useless.
 	 */
 	if (rx->skb->len < 24)
-		return RX_DROP;
+		return RX_DROP_U_RUNT_MGMT;
 
 	if (!ieee80211_is_mgmt(mgmt->frame_control))
-		return RX_DROP;
+		return RX_DROP_U_EXPECTED_MGMT;
 
 	/* drop too small action frames */
 	if (ieee80211_is_action(mgmt->frame_control) &&
@@ -3522,7 +3522,7 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	/* Drop non-broadcast Beacon frames */
 	if (ieee80211_is_beacon(mgmt->frame_control) &&
 	    !is_broadcast_ether_addr(mgmt->da))
-		return RX_DROP;
+		return RX_DROP_U_NONBCAST_BEACON;
 
 	if (rx->sdata->vif.type == NL80211_IFTYPE_AP &&
 	    ieee80211_is_beacon(mgmt->frame_control) &&
@@ -4054,10 +4054,10 @@ ieee80211_rx_h_action_return(struct ieee80211_rx_data *rx)
 	if (!(status->rx_flags & IEEE80211_RX_MALFORMED_ACTION_FRM) &&
 	    (sdata->vif.type == NL80211_IFTYPE_AP ||
 	     sdata->vif.type == NL80211_IFTYPE_AP_VLAN))
-		return RX_DROP;
+		return RX_DROP_U_MALFORMED_ACTION;
 
 	if (is_multicast_ether_addr(mgmt->da))
-		return RX_DROP;
+		return RX_DROP_U_UNKNOWN_MCAST_ACTION;
 
 	/* do not return rejected action frames */
 	if (mgmt->u.action.category & 0x80)
@@ -4102,7 +4102,7 @@ ieee80211_rx_h_ext(struct ieee80211_rx_data *rx)
 		return RX_CONTINUE;
 
 	if (sdata->vif.type != NL80211_IFTYPE_STATION)
-		return RX_DROP;
+		return RX_DROP_U_UNEXPECTED_EXT_FRAME;
 
 	/* for now only beacons are ext, so queue them */
 	ieee80211_queue_skb_to_iface(sdata, rx->link_id, rx->sta, rx->skb);
@@ -4123,7 +4123,7 @@ ieee80211_rx_h_mgmt(struct ieee80211_rx_data *rx)
 	    sdata->vif.type != NL80211_IFTYPE_ADHOC &&
 	    sdata->vif.type != NL80211_IFTYPE_OCB &&
 	    sdata->vif.type != NL80211_IFTYPE_STATION)
-		return RX_DROP;
+		return RX_DROP_U_UNHANDLED_MGMT;
 
 	switch (stype) {
 	case cpu_to_le16(IEEE80211_STYPE_AUTH):
@@ -4134,32 +4134,32 @@ ieee80211_rx_h_mgmt(struct ieee80211_rx_data *rx)
 	case cpu_to_le16(IEEE80211_STYPE_DEAUTH):
 		if (is_multicast_ether_addr(mgmt->da) &&
 		    !is_broadcast_ether_addr(mgmt->da))
-			return RX_DROP;
+			return RX_DROP_U_MCAST_DEAUTH;
 
 		/* process only for station/IBSS */
 		if (sdata->vif.type != NL80211_IFTYPE_STATION &&
 		    sdata->vif.type != NL80211_IFTYPE_ADHOC)
-			return RX_DROP;
+			return RX_DROP_U_UNHANDLED_DEAUTH;
 		break;
 	case cpu_to_le16(IEEE80211_STYPE_ASSOC_RESP):
 	case cpu_to_le16(IEEE80211_STYPE_REASSOC_RESP):
 	case cpu_to_le16(IEEE80211_STYPE_DISASSOC):
 		if (is_multicast_ether_addr(mgmt->da) &&
 		    !is_broadcast_ether_addr(mgmt->da))
-			return RX_DROP;
+			return RX_DROP_U_MCAST_DISASSOC;
 
 		/* process only for station */
 		if (sdata->vif.type != NL80211_IFTYPE_STATION)
-			return RX_DROP;
+			return RX_DROP_U_UNHANDLED_DISASSOC;
 		break;
 	case cpu_to_le16(IEEE80211_STYPE_PROBE_REQ):
 		/* process only for ibss and mesh */
 		if (sdata->vif.type != NL80211_IFTYPE_ADHOC &&
 		    sdata->vif.type != NL80211_IFTYPE_MESH_POINT)
-			return RX_DROP;
+			return RX_DROP_U_UNHANDLED_PREQ;
 		break;
 	default:
-		return RX_DROP;
+		return RX_DROP_U_UNHANDLED_MGMT_STYPE;
 	}
 
 	ieee80211_queue_skb_to_iface(sdata, rx->link_id, rx->sta, rx->skb);
@@ -4187,7 +4187,7 @@ static void ieee80211_rx_handlers_result(struct ieee80211_rx_data *rx,
 static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
 				  struct sk_buff_head *frames)
 {
-	ieee80211_rx_result res = RX_DROP;
+	ieee80211_rx_result res;
 	struct sk_buff *skb;
 
 #define CALL_RXH(rxh)			\
@@ -4213,8 +4213,10 @@ static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
 		 */
 		rx->skb = skb;
 
-		if (WARN_ON_ONCE(!rx->link))
+		if (WARN_ON_ONCE(!rx->link)) {
+			res = RX_DROP_U_NO_LINK;
 			goto rxh_next;
+		}
 
 		CALL_RXH(ieee80211_rx_h_check_more_data);
 		CALL_RXH(ieee80211_rx_h_uapsd_and_pspoll);
@@ -4251,7 +4253,7 @@ static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
 static void ieee80211_invoke_rx_handlers(struct ieee80211_rx_data *rx)
 {
 	struct sk_buff_head reorder_release;
-	ieee80211_rx_result res = RX_DROP;
+	ieee80211_rx_result res;
 
 	__skb_queue_head_init(&reorder_release);
 
-- 
2.52.0



Return-Path: <linux-wireless+bounces-6322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FFC8A4EC3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 14:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514451F23C1E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 12:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F27374D3;
	Mon, 15 Apr 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Hst/jxSt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB7634E2
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183509; cv=none; b=RphZkDenhu2B6C5EBPrt1H1fDeD3VB7SF/p3XpNSbsmNpNu95pnqesEAbPXup53Xc/H/BtghHMk9m+p4lVq5mbO/Pm7Ap8m/xj17a5onNj4zknf7oXFjMnTu4xcWo/EMduCQSwXGVobZ6sl/vADszH5WAamYpcc6SLgWfIaOPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183509; c=relaxed/simple;
	bh=Xv08o3uCVb3unqk84u7RMaywKGoxBHXlL6isRw7S54E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P47hy/MBbVR5qpdBzQQSBe16XV+9j/3lidFiRDDGPC3IQNR3UrjHxpspApr2F8UXcaCaQy46RkMAS6RyQWhczKs1AFHYouzZEDqp91b+N0h8XetGH6B1VL5Q119jrX1I7LD/x+/9c1XCzKqJysHKV7zln1NuDjyxIWNn2U4FmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Hst/jxSt; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CVlY6+VP/fbEv4dZFaUhumpr+RIOCK8QoJm7YNsUp+0=; b=Hst/jxSt0k1PHpWmUYYglBcsV2
	NlT3J9YR8J9nzBi+TvwjKYeDx5vickD6Hv0NZHDxfYMjWZb4vNWv0djmVKcFxYPcgFA9TNbvX/1CE
	a73GlZOHLOKGBghzAEambka3ipUOwKVNajheJXA0cEQku1nwSU4zTw1MDzmAz88vyMn8=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rwLHt-001L8B-1R;
	Mon, 15 Apr 2024 14:18:17 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v2] wifi: mac80211: split mesh fast tx cache into local/proxied/forwarded
Date: Mon, 15 Apr 2024 14:18:11 +0200
Message-ID: <20240415121811.13391-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on the origin of the packets (and their SA), 802.11 + mesh headers
could be filled in differently. In order to properly deal with that, add a
new field to the lookup key, indicating the type (local, proxied or
forwarded). This can fix spurious packet drop issues that depend on the order
in which nodes/hosts communicate with each other.

Fixes: d5edb9ae8d56 ("wifi: mac80211: mesh fast xmit support")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2:
 - fix flushing forwarding cache entries
 - make type field size explicit, make struct size a multiple of 4

 net/mac80211/mesh.c         |  8 +++++++-
 net/mac80211/mesh.h         | 36 +++++++++++++++++++++++++++++++++---
 net/mac80211/mesh_pathtbl.c | 31 ++++++++++++++++++++++---------
 net/mac80211/rx.c           | 13 ++++++++++---
 4 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 32475da98d73..cbc9b5e40cb3 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -747,6 +747,9 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
 			      struct sk_buff *skb, u32 ctrl_flags)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_mesh_fast_tx_key key = {
+		.type = MESH_FAST_TX_TYPE_LOCAL
+	};
 	struct ieee80211_mesh_fast_tx *entry;
 	struct ieee80211s_hdr *meshhdr;
 	u8 sa[ETH_ALEN] __aligned(2);
@@ -782,7 +785,10 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
 			return false;
 	}
 
-	entry = mesh_fast_tx_get(sdata, skb->data);
+	ether_addr_copy(key.addr, skb->data);
+	if (!ether_addr_equal(skb->data + ETH_ALEN, sdata->vif.addr))
+		key.type = MESH_FAST_TX_TYPE_PROXIED;
+	entry = mesh_fast_tx_get(sdata, &key);
 	if (!entry)
 		return false;
 
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index d913ce7ba72e..3f9664e4e00c 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -134,10 +134,39 @@ struct mesh_path {
 #define MESH_FAST_TX_CACHE_THRESHOLD_SIZE	384
 #define MESH_FAST_TX_CACHE_TIMEOUT		8000 /* msecs */
 
+/**
+ * enum ieee80211_mesh_fast_tx_type - cached mesh fast tx entry type
+ *
+ * @MESH_FAST_TX_TYPE_LOCAL: tx from the local vif address as SA
+ * @MESH_FAST_TX_TYPE_PROXIED: local tx with a different SA (e.g. bridged)
+ * @MESH_FAST_TX_TYPE_FORWARDED: forwarded from a different mesh point
+ * @NUM_MESH_FAST_TX_TYPE: number of entry types
+ */
+enum ieee80211_mesh_fast_tx_type {
+	MESH_FAST_TX_TYPE_LOCAL,
+	MESH_FAST_TX_TYPE_PROXIED,
+	MESH_FAST_TX_TYPE_FORWARDED,
+
+	/* must be last */
+	NUM_MESH_FAST_TX_TYPE
+};
+
+
+/**
+ * struct ieee80211_mesh_fast_tx_key - cached mesh fast tx entry key
+ *
+ * @addr: The Ethernet DA for this entry
+ * @type: cache entry type
+ */
+struct ieee80211_mesh_fast_tx_key {
+	u8 addr[ETH_ALEN] __aligned(2);
+	u16 type;
+};
+
 /**
  * struct ieee80211_mesh_fast_tx - cached mesh fast tx entry
  * @rhash: rhashtable pointer
- * @addr_key: The Ethernet DA which is the key for this entry
+ * @key: the lookup key for this cache entry
  * @fast_tx: base fast_tx data
  * @hdr: cached mesh and rfc1042 headers
  * @hdrlen: length of mesh + rfc1042
@@ -148,7 +177,7 @@ struct mesh_path {
  */
 struct ieee80211_mesh_fast_tx {
 	struct rhash_head rhash;
-	u8 addr_key[ETH_ALEN] __aligned(2);
+	struct ieee80211_mesh_fast_tx_key key;
 
 	struct ieee80211_fast_tx fast_tx;
 	u8 hdr[sizeof(struct ieee80211s_hdr) + sizeof(rfc1042_header)];
@@ -334,7 +363,8 @@ void mesh_path_tx_root_frame(struct ieee80211_sub_if_data *sdata);
 
 bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt);
 struct ieee80211_mesh_fast_tx *
-mesh_fast_tx_get(struct ieee80211_sub_if_data *sdata, const u8 *addr);
+mesh_fast_tx_get(struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_mesh_fast_tx_key *key);
 bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
 			      struct sk_buff *skb, u32 ctrl_flags);
 void mesh_fast_tx_cache(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 91b55d6a68b9..275f88074fac 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -37,8 +37,8 @@ static const struct rhashtable_params mesh_rht_params = {
 static const struct rhashtable_params fast_tx_rht_params = {
 	.nelem_hint = 10,
 	.automatic_shrinking = true,
-	.key_len = ETH_ALEN,
-	.key_offset = offsetof(struct ieee80211_mesh_fast_tx, addr_key),
+	.key_len = sizeof(struct ieee80211_mesh_fast_tx_key),
+	.key_offset = offsetof(struct ieee80211_mesh_fast_tx, key),
 	.head_offset = offsetof(struct ieee80211_mesh_fast_tx, rhash),
 	.hashfn = mesh_table_hash,
 };
@@ -431,20 +431,21 @@ static void mesh_fast_tx_entry_free(struct mesh_tx_cache *cache,
 }
 
 struct ieee80211_mesh_fast_tx *
-mesh_fast_tx_get(struct ieee80211_sub_if_data *sdata, const u8 *addr)
+mesh_fast_tx_get(struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_mesh_fast_tx_key *key)
 {
 	struct ieee80211_mesh_fast_tx *entry;
 	struct mesh_tx_cache *cache;
 
 	cache = &sdata->u.mesh.tx_cache;
-	entry = rhashtable_lookup(&cache->rht, addr, fast_tx_rht_params);
+	entry = rhashtable_lookup(&cache->rht, key, fast_tx_rht_params);
 	if (!entry)
 		return NULL;
 
 	if (!(entry->mpath->flags & MESH_PATH_ACTIVE) ||
 	    mpath_expired(entry->mpath)) {
 		spin_lock_bh(&cache->walk_lock);
-		entry = rhashtable_lookup(&cache->rht, addr, fast_tx_rht_params);
+		entry = rhashtable_lookup(&cache->rht, key, fast_tx_rht_params);
 		if (entry)
 		    mesh_fast_tx_entry_free(cache, entry);
 		spin_unlock_bh(&cache->walk_lock);
@@ -489,18 +490,24 @@ void mesh_fast_tx_cache(struct ieee80211_sub_if_data *sdata,
 	if (!sta)
 		return;
 
+	build.key.type = MESH_FAST_TX_TYPE_LOCAL;
 	if ((meshhdr->flags & MESH_FLAGS_AE) == MESH_FLAGS_AE_A5_A6) {
 		/* This is required to keep the mppath alive */
 		mppath = mpp_path_lookup(sdata, meshhdr->eaddr1);
 		if (!mppath)
 			return;
 		build.mppath = mppath;
+		if (!ether_addr_equal(meshhdr->eaddr2, sdata->vif.addr))
+			build.key.type = MESH_FAST_TX_TYPE_PROXIED;
 	} else if (ieee80211_has_a4(hdr->frame_control)) {
 		mppath = mpath;
 	} else {
 		return;
 	}
 
+	if (!ether_addr_equal(hdr->addr4, sdata->vif.addr))
+		build.key.type = MESH_FAST_TX_TYPE_FORWARDED;
+
 	/* rate limit, in case fast xmit can't be enabled */
 	if (mppath->fast_tx_check == jiffies)
 		return;
@@ -547,7 +554,7 @@ void mesh_fast_tx_cache(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	memcpy(build.addr_key, mppath->dst, ETH_ALEN);
+	memcpy(build.key.addr, mppath->dst, ETH_ALEN);
 	build.timestamp = jiffies;
 	build.fast_tx.band = info->band;
 	build.fast_tx.da_offs = offsetof(struct ieee80211_hdr, addr3);
@@ -646,12 +653,18 @@ void mesh_fast_tx_flush_addr(struct ieee80211_sub_if_data *sdata,
 			     const u8 *addr)
 {
 	struct mesh_tx_cache *cache = &sdata->u.mesh.tx_cache;
+	struct ieee80211_mesh_fast_tx_key key = {};
 	struct ieee80211_mesh_fast_tx *entry;
+	int i;
 
+	ether_addr_copy(key.addr, addr);
 	spin_lock_bh(&cache->walk_lock);
-	entry = rhashtable_lookup_fast(&cache->rht, addr, fast_tx_rht_params);
-	if (entry)
-		mesh_fast_tx_entry_free(cache, entry);
+	for (i = 0; i < NUM_MESH_FAST_TX_TYPE; i++) {
+		key.type = i;
+		entry = rhashtable_lookup_fast(&cache->rht, &key, fast_tx_rht_params);
+		if (entry)
+			mesh_fast_tx_entry_free(cache, entry);
+	}
 	spin_unlock_bh(&cache->walk_lock);
 }
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 685185dc04f9..6e24864f9a40 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2763,7 +2763,10 @@ ieee80211_rx_mesh_fast_forward(struct ieee80211_sub_if_data *sdata,
 			       struct sk_buff *skb, int hdrlen)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
-	struct ieee80211_mesh_fast_tx *entry = NULL;
+	struct ieee80211_mesh_fast_tx_key key = {
+		.type = MESH_FAST_TX_TYPE_FORWARDED
+	};
+	struct ieee80211_mesh_fast_tx *entry;
 	struct ieee80211s_hdr *mesh_hdr;
 	struct tid_ampdu_tx *tid_tx;
 	struct sta_info *sta;
@@ -2772,9 +2775,13 @@ ieee80211_rx_mesh_fast_forward(struct ieee80211_sub_if_data *sdata,
 
 	mesh_hdr = (struct ieee80211s_hdr *)(skb->data + sizeof(eth));
 	if ((mesh_hdr->flags & MESH_FLAGS_AE) == MESH_FLAGS_AE_A5_A6)
-		entry = mesh_fast_tx_get(sdata, mesh_hdr->eaddr1);
+		ether_addr_copy(key.addr, mesh_hdr->eaddr1);
 	else if (!(mesh_hdr->flags & MESH_FLAGS_AE))
-		entry = mesh_fast_tx_get(sdata, skb->data);
+		ether_addr_copy(key.addr, skb->data);
+	else
+		return false;
+
+	entry = mesh_fast_tx_get(sdata, &key);
 	if (!entry)
 		return false;
 
-- 
2.44.0



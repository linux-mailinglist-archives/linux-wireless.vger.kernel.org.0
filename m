Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9574681EA
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 03:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384050AbhLDCIm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 21:08:42 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:30038 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231452AbhLDCIm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 21:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638583517; x=1670119517;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=mi/1jWVJsVusRGlHV7SfgfYVf2Pm4eR5oWm/wBSESL8=;
  b=ZcAHAgQwcKp6syASA+rIlyn83gIKfk+HvSmi/uD7CVMKsjtzmdQRxvFw
   ajsvGTNKihYHWnZx+EYKC+R5ht1QVcQ/Ewc3UKyxM4lTzRCDgZSCr8VdW
   GnXmPlaKvuCa7j7+749Jfrfofwl8IS13AENTaK2R26wnASWeH31osLemR
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Dec 2021 18:05:17 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 18:05:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 3 Dec 2021 18:05:17 -0800
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 3 Dec 2021 18:05:14 -0800
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>, Sriram R <quic_srirrama@quicinc.com>
Subject: [RFC] mac80211: Mesh Fast xmit support
Date:   Sat, 4 Dec 2021 07:34:49 +0530
Message-ID: <1638583489-6518-1-git-send-email-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support Fast xmit for mesh device types by caching the
header corresponding to the ethernet DA and reusing
the cached header (mac, mesh, llc) everytime the packet
is intended for that DA.

This will avoid multiple path table lookups during header
generation for a mesh packet tx.

Freshness of the header is verified by identifying change
in mesh paths before using the header and corresponding
changes to the header and cache entry is done on the fly.

Mutable fields of the header such as eth SA, tid, mesh SN,
PN are updated for each xmit.

Each cache entry is about 100Bytes, least used/expired entries
are periodically removed when cache gets almost full.
Currently the size is set to 50 entries.

Driver needs to advertise NL80211_EXT_FEATURE_MESH_FAST_XMIT
to enable this support and setup this cache.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
RFC Note:
Below are some trivial pending changes,
a.Currently only 6addr header format is supported in this version,
other formats/mcast can be extended if really required.
b.Changes for PS cases needs to be added.
c.Few more cases for cache update/skipping fast path
 might be required

 include/net/mac80211.h       |   3 +
 include/uapi/linux/nl80211.h |   4 +
 net/mac80211/ieee80211_i.h   |   1 +
 net/mac80211/mesh.c          |   2 +
 net/mac80211/mesh.h          |  63 +++++++
 net/mac80211/mesh_hwmp.c     |   8 +-
 net/mac80211/mesh_pathtbl.c  | 380 +++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/rx.c            |   9 +-
 net/mac80211/tx.c            |  90 +++++++++-
 9 files changed, 554 insertions(+), 6 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 775dbb9..089fbb7 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -868,6 +868,8 @@ enum mac80211_tx_info_flags {
  * @IEEE80211_TX_CTRL_DONT_REORDER: This frame should not be reordered
  *	relative to other frames that have this flag set, independent
  *	of their QoS TID or other priority field values.
+ * @IEEE80211_TX_CTRL_CHECK_FAST_MESH: During Mesh xmit, the header of this
+ *	frame can be cached for faster lookup later.
  *
  * These flags are used in tx_info->control.flags.
  */
@@ -881,6 +883,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_INTCFL_NEED_TXPROCESSING	= BIT(6),
 	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
 	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
+	IEEE80211_TX_CTRL_CHECK_FAST_MESH	= BIT(9),
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3e73482..50b2af8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6063,6 +6063,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_RADAR_OFFCHAN: Device supports offchannel radar/CAC
  *	detection.
  *
+ * @NL80211_EXT_FEATURE_MESH_FAST_XMIT: Driver supports enabling of MESH FAST XMIT
+ *	in mac80211
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6130,6 +6133,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BSS_COLOR,
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
 	NL80211_EXT_FEATURE_RADAR_OFFCHAN,
+	NL80211_EXT_FEATURE_MESH_FAST_XMIT,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5666bbb..246a95b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -725,6 +725,7 @@ struct ieee80211_if_mesh {
 	struct mesh_table *mpp_paths; /* Store paths for MPP&MAP */
 	int mesh_paths_generation;
 	int mpp_paths_generation;
+	struct mesh_hdr_cache *hdr_cache;
 };
 
 #ifdef CONFIG_MAC80211_MESH
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 15ac08d..2fa1329 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -781,6 +781,8 @@ static void ieee80211_mesh_housekeeping(struct ieee80211_sub_if_data *sdata)
 	changed = mesh_accept_plinks_update(sdata);
 	ieee80211_mbss_info_change_notify(sdata, changed);
 
+	mesh_hdr_cache_manage(sdata);
+
 	mod_timer(&ifmsh->housekeeping_timer,
 		  round_jiffies(jiffies +
 				IEEE80211_MESH_HOUSEKEEPING_INTERVAL));
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 77080b4..b97eb9f 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -147,6 +147,61 @@ struct mesh_table {
 	atomic_t entries;		/* Up to MAX_MESH_NEIGHBOURS */
 };
 
+/**
+ * struct mesh_hdr_cache
+ * @rhead: the rhashtable containing header cache entries
+ * @walk_head: linked list containing all cached header entries
+ * @walk_lock: lock protecting walk_head
+ * @size: number of entries in the header cache
+ */
+struct mesh_hdr_cache {
+	struct rhashtable rhead;
+	struct hlist_head walk_head;
+	/* protects header hlist */
+	spinlock_t walk_lock;
+	atomic_t size;
+};
+
+#define MESH_HDR_CACHE_SIZE		50
+#define MESH_HDR_CACHE_HIGH_THRESHOLD	((MESH_HDR_CACHE_SIZE * 2) / 3)
+#define MESH_HDR_CACHE_TIMEOUT		8000 /* msecs */
+
+#define MESH_HDR_MAX_LEN	56	/* mac+mesh+rfc1042 hdr */
+
+/**
+ * struct mhdr_cache_entry - Cached Mesh header entry
+ * @addr_key: The Ethernet DA which is the key for this entry
+ * @hdr: The cached header
+ * @machdr_len: Total length of the mac header
+ * @hdrlen: Length of this header entry
+ * @key: Key corresponding to the nexthop stored in the header
+ * @pn_offs: Offset to PN which is updated for every xmit
+ * @band:  band used for tx
+ * @walk_list: list containing all the cached header entries
+ * @rhash: rhashtable pointer
+ * @mpath: The Mesh path corresponding to the Mesh DA
+ * @mppath: The MPP entry corresponding to this DA
+ * @timestamp: Last used time of this entry
+ * @rcu: rcu to free this entry
+ * @path_change_count: Stored path change value corresponding to the mpath
+ */
+struct mhdr_cache_entry {
+	u8 addr_key[ETH_ALEN];
+	u8 hdr[MESH_HDR_MAX_LEN];
+	u16 machdr_len;
+	u16 hdrlen;
+	struct ieee80211_key *key;
+	u8 pn_offs;
+	u8 band;
+	struct hlist_node walk_list;
+	struct rhash_head rhash;
+	struct mesh_path *mpath;
+	struct mesh_path *mppath;
+	unsigned long timestamp;
+	struct rcu_head rcu;
+	u32 path_change_count;
+};
+
 /* Recent multicast cache */
 /* RMC_BUCKETS must be a power of 2, maximum 256 */
 #define RMC_BUCKETS		256
@@ -319,6 +374,14 @@ void mesh_path_tx_root_frame(struct ieee80211_sub_if_data *sdata);
 
 bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt);
 
+struct mhdr_cache_entry *mesh_fill_cached_hdr(struct ieee80211_sub_if_data *sdata,
+					      struct sk_buff *skb);
+void mesh_cache_hdr(struct ieee80211_sub_if_data *sdata,
+		    struct sk_buff *skb, struct mesh_path *mpath);
+void mesh_hdr_cache_manage(struct ieee80211_sub_if_data *sdata);
+void mesh_hdr_cache_flush(struct mesh_path *mpath, bool is_mpp);
+void mesh_queue_preq(struct mesh_path *mpath, u8 flags);
+
 #ifdef CONFIG_MAC80211_MESH
 static inline
 u32 mesh_plink_inc_estab_count(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 44a6fdb..211515f 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -18,8 +18,6 @@
 
 #define MAX_PREQ_QUEUE_LEN	64
 
-static void mesh_queue_preq(struct mesh_path *, u8);
-
 static inline u32 u32_field_get(const u8 *preq_elem, int offset, bool ae)
 {
 	if (ae)
@@ -972,7 +970,7 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
  * Locking: the function must be called from within a rcu read lock block.
  *
  */
-static void mesh_queue_preq(struct mesh_path *mpath, u8 flags)
+void mesh_queue_preq(struct mesh_path *mpath, u8 flags)
 {
 	struct ieee80211_sub_if_data *sdata = mpath->sdata;
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
@@ -1250,6 +1248,10 @@ int mesh_nexthop_lookup(struct ieee80211_sub_if_data *sdata,
 		memcpy(hdr->addr1, next_hop->sta.addr, ETH_ALEN);
 		memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
 		ieee80211_mps_set_frame_flags(sdata, next_hop, hdr);
+		/* Cache the whole header so as to use next time rather than resolving
+		 * and building it every time
+		 */
+		mesh_cache_hdr(sdata, skb, mpath);
 		return 0;
 	}
 
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 7cab1cf..8275bf8 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -32,6 +32,61 @@ static const struct rhashtable_params mesh_rht_params = {
 	.hashfn = mesh_table_hash,
 };
 
+static const struct rhashtable_params mesh_hdr_rht_params = {
+	.nelem_hint = 10,
+	.automatic_shrinking = true,
+	.key_len =  ETH_ALEN,
+	.key_offset = offsetof(struct mhdr_cache_entry, addr_key),
+	.head_offset = offsetof(struct mhdr_cache_entry, rhash),
+	.hashfn = mesh_table_hash,
+};
+
+static void mesh_hdr_cache_entry_free(void *ptr, void *tblptr)
+{
+	struct mhdr_cache_entry *mhdr = ptr;
+
+	kfree_rcu(mhdr, rcu);
+}
+
+static void mesh_hdr_cache_deinit(struct ieee80211_sub_if_data *sdata)
+{
+	struct mesh_hdr_cache *cache;
+
+	cache = sdata->u.mesh.hdr_cache;
+
+	if (!cache)
+		return;
+
+	rhashtable_free_and_destroy(&cache->rhead,
+				    mesh_hdr_cache_entry_free, NULL);
+
+	kfree(sdata->u.mesh.hdr_cache);
+	sdata->u.mesh.hdr_cache = NULL;
+}
+
+static void mesh_hdr_cache_init(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct mesh_hdr_cache *cache;
+
+	sdata->u.mesh.hdr_cache = NULL;
+
+	if (!wiphy_ext_feature_isset(local->hw.wiphy,
+				     NL80211_EXT_FEATURE_MESH_FAST_XMIT))
+		return;
+
+	cache = kmalloc(sizeof(*cache), GFP_ATOMIC);
+
+	if (!cache)
+		return;
+
+	sdata->u.mesh.hdr_cache = cache;
+	rhashtable_init(&cache->rhead, &mesh_hdr_rht_params);
+	INIT_HLIST_HEAD(&cache->walk_head);
+	spin_lock_init(&cache->walk_lock);
+	atomic_set(&cache->size, 0);
+}
+
 static inline bool mpath_expired(struct mesh_path *mpath)
 {
 	return (mpath->flags & MESH_PATH_ACTIVE) &&
@@ -389,6 +444,324 @@ struct mesh_path *mesh_path_new(struct ieee80211_sub_if_data *sdata,
 	return new_mpath;
 }
 
+struct mhdr_cache_entry *mesh_fill_cached_hdr(struct ieee80211_sub_if_data *sdata,
+					      struct sk_buff *skb)
+{
+	struct mesh_hdr_cache *cache;
+	struct mhdr_cache_entry *entry;
+	struct mesh_path *mpath, *mppath;
+	struct ieee80211s_hdr *meshhdr;
+	struct ieee80211_hdr *hdr;
+	struct sta_info *new_nhop;
+	struct ieee80211_key *key;
+
+	u8 tid;
+
+	cache = sdata->u.mesh.hdr_cache;
+
+	if (!cache)
+		return NULL;
+
+	entry = rhashtable_lookup(&cache->rhead, skb->data,
+				  mesh_hdr_rht_params);
+	if (!entry)
+		return NULL;
+
+	/* Avoid extra work in this path */
+	if (skb_headroom(skb) < (entry->hdrlen - ETH_HLEN + 2))
+		return NULL;
+
+	mpath = rcu_dereference(entry->mpath);
+	if (!mpath)
+		return NULL;
+
+	/* This check is with assumption that only 6addr frames are
+	 * supported currently for caching
+	 */
+	mppath = rcu_dereference(entry->mppath);
+	if (!mppath)
+		return NULL;
+
+	if (!(mpath->flags & MESH_PATH_ACTIVE))
+		return NULL;
+
+	if (mpath_expired(mpath))
+		return NULL;
+
+	/*If the skb is shared we need to obtain our own copy.
+	 */
+	if (skb_shared(skb)) {
+		struct sk_buff *tmp_skb = skb;
+
+		skb = skb_clone(skb, GFP_ATOMIC);
+		kfree_skb(tmp_skb);
+
+		if (!skb)
+			return NULL;
+	}
+
+	/* In case there was a path refresh and update after we last used
+	 * update the next hop addr.
+	 */
+	spin_lock_bh(&mpath->state_lock);
+	if (entry->path_change_count != mpath->path_change_count) {
+		new_nhop = rcu_dereference(mpath->next_hop);
+		if (!new_nhop) {
+			spin_unlock_bh(&mpath->state_lock);
+			return NULL;
+		}
+		memcpy(&entry->hdr[4], new_nhop->sta.addr, ETH_ALEN);
+
+		/* update key. pn_offs will be same */
+		if (entry->key)	{
+			key = rcu_access_pointer(new_nhop->ptk[new_nhop->ptk_idx]);
+			if (!key)
+				key = rcu_access_pointer(sdata->default_unicast_key);
+			rcu_assign_pointer(entry->key, key);
+		}
+		entry->path_change_count = mpath->path_change_count;
+	}
+	spin_unlock_bh(&mpath->state_lock);
+
+	/* Pull DA:SA */
+	skb_pull(skb, ETH_HLEN - 2);
+
+	memcpy(skb_push(skb, entry->hdrlen), entry->hdr, entry->hdrlen);
+
+	meshhdr = (struct ieee80211s_hdr *)(skb->data + entry->machdr_len);
+	hdr = (struct ieee80211_hdr *)skb->data;
+
+	/* Update mutables */
+	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+	*ieee80211_get_qos_ctl(hdr) = tid;
+
+	put_unaligned(cpu_to_le32(sdata->u.mesh.mesh_seqnum), &meshhdr->seqnum);
+	sdata->u.mesh.mesh_seqnum++;
+
+	if (mpath->flags & (MESH_PATH_REQ_QUEUED | MESH_PATH_FIXED))
+		goto out;
+
+	/* Refresh the path, in case there is a change in nexthop after refresh
+	 * hdr will be updated on next lookup
+	 */
+	if (time_after(jiffies,
+		       mpath->exp_time -
+		       msecs_to_jiffies(sdata->u.mesh.mshcfg.path_refresh_time)) &&
+	    !(mpath->flags & MESH_PATH_RESOLVING) &&
+	    !(mpath->flags & MESH_PATH_FIXED)) {
+		mesh_queue_preq(mpath, PREQ_Q_F_START | PREQ_Q_F_REFRESH);
+	}
+
+out:
+	mppath->exp_time = jiffies;
+	entry->timestamp = jiffies;
+
+	return entry;
+}
+
+void mesh_cache_hdr(struct ieee80211_sub_if_data *sdata,
+		    struct sk_buff *skb, struct mesh_path *mpath)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct mesh_hdr_cache *cache;
+	struct mhdr_cache_entry *mhdr, *old_mhdr;
+	struct ieee80211s_hdr *meshhdr;
+	struct sta_info *next_hop;
+	struct ieee80211_key *key;
+	u8 band, pn_offs = 0, crypto_len = 0;
+	struct mesh_path *mppath;
+	u16 mshhdr_len;
+	int hdrlen;
+
+	cache = sdata->u.mesh.hdr_cache;
+
+	if (!cache)
+		return;
+
+	if (!(info->control.flags & IEEE80211_TX_CTRL_CHECK_FAST_MESH))
+		return;
+
+	band = info->band;
+
+	if (atomic_read(&cache->size) > MESH_HDR_CACHE_SIZE)
+		return;
+
+	hdrlen = ieee80211_hdrlen(hdr->frame_control);
+
+	meshhdr = (struct ieee80211s_hdr *)(skb->data + hdrlen);
+
+	/* TODO Currently supporting only 6addr hdr
+	 */
+	if (!(meshhdr->flags & MESH_FLAGS_AE_A5_A6))
+		return;
+
+	next_hop = rcu_dereference(mpath->next_hop);
+	if (!next_hop)
+		return;
+
+	/* This is required to keep the mppath alive */
+	mppath = mpp_path_lookup(sdata, meshhdr->eaddr1);
+
+	if (!mppath)
+		return;
+
+	/*TODO avoid if peers if they are PS peer and use regulat path */
+
+	pn_offs = 0;
+	key = rcu_access_pointer(next_hop->ptk[next_hop->ptk_idx]);
+	if (!key)
+		key = rcu_access_pointer(sdata->default_unicast_key);
+
+	if (key) {
+		bool gen_iv, iv_spc;
+
+		gen_iv = key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_IV;
+		iv_spc = key->conf.flags & IEEE80211_KEY_FLAG_PUT_IV_SPACE;
+
+		if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
+			return;
+
+		if (key->flags & KEY_FLAG_TAINTED)
+			return;
+
+		switch (key->conf.cipher) {
+		case WLAN_CIPHER_SUITE_CCMP:
+		case WLAN_CIPHER_SUITE_CCMP_256:
+			if (gen_iv)
+				pn_offs = hdrlen;
+			if (gen_iv || iv_spc)
+				crypto_len = IEEE80211_CCMP_HDR_LEN;
+			break;
+		default:
+			/* Limiting supported ciphers for testing */
+			return;
+		}
+		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+	}
+
+	mhdr = kzalloc(sizeof(*mhdr), GFP_KERNEL);
+	if (!mhdr)
+		return;
+
+	memcpy(mhdr->addr_key, meshhdr->eaddr1, ETH_ALEN);
+
+	mhdr->machdr_len = hdrlen + crypto_len;
+	mshhdr_len = ieee80211_get_mesh_hdrlen(meshhdr);
+	mhdr->hdrlen =  mhdr->machdr_len + mshhdr_len + sizeof(rfc1042_header);
+	rcu_assign_pointer(mhdr->mpath, mpath);
+	rcu_assign_pointer(mhdr->mppath, mppath);
+	rcu_assign_pointer(mhdr->key, key);
+	mhdr->timestamp = jiffies;
+	mhdr->band = band;
+	mhdr->pn_offs = pn_offs;
+
+	if (pn_offs) {
+		/* ignore the invalid data getting copied to pn location since it will
+		 * be overwritten dring tx
+		 */
+		memcpy(mhdr->hdr, skb->data, mhdr->machdr_len);
+
+		/* copy remaining hdr */
+		memcpy(mhdr->hdr + mhdr->machdr_len,
+		       skb->data + mhdr->machdr_len - crypto_len,
+		       mhdr->hdrlen - mhdr->machdr_len);
+	} else {
+		memcpy(mhdr->hdr, skb->data, mhdr->hdrlen);
+	}
+
+	if (key) {
+		hdr = (struct ieee80211_hdr *)mhdr->hdr;
+		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+	}
+
+	old_mhdr = rhashtable_lookup_get_insert_fast(&cache->rhead,
+						     &mhdr->rhash,
+						     mesh_hdr_rht_params);
+	if (old_mhdr) {
+		kfree(mhdr);
+		return;
+	}
+
+	spin_lock_bh(&cache->walk_lock);
+	hlist_add_head(&mhdr->walk_list, &cache->walk_head);
+	spin_unlock_bh(&cache->walk_lock);
+
+	atomic_inc(&cache->size);
+}
+
+void mesh_hdr_cache_manage(struct ieee80211_sub_if_data *sdata)
+{
+	struct mesh_hdr_cache *cache;
+	struct mhdr_cache_entry *entry;
+	struct hlist_node *n;
+
+	cache = sdata->u.mesh.hdr_cache;
+
+	if (!cache)
+		return;
+
+	if (atomic_read(&cache->size) < MESH_HDR_CACHE_HIGH_THRESHOLD)
+		return;
+
+	spin_lock_bh(&cache->walk_lock);
+	hlist_for_each_entry_safe(entry, n, &cache->walk_head, walk_list) {
+		if (time_before(jiffies,
+				entry->timestamp +
+				msecs_to_jiffies(MESH_HDR_CACHE_TIMEOUT)))
+			continue;
+
+		hlist_del_rcu(&entry->walk_list);
+		rhashtable_remove_fast(&cache->rhead, &entry->rhash, mesh_hdr_rht_params);
+		kfree_rcu(entry, rcu);
+		atomic_dec(&cache->size);
+	}
+	spin_unlock_bh(&cache->walk_lock);
+}
+
+void mesh_hdr_cache_flush(struct mesh_path *mpath, bool is_mpp)
+{
+	struct ieee80211_sub_if_data *sdata = mpath->sdata;
+	struct mesh_hdr_cache *cache;
+	struct mhdr_cache_entry *entry;
+	struct hlist_node *n;
+	struct mesh_path *entry_mpath;
+
+	cache = sdata->u.mesh.hdr_cache;
+
+	if (!cache)
+		return;
+
+	spin_lock_bh(&cache->walk_lock);
+	/* Only one header per mpp address is expected in the header cache */
+	if (is_mpp) {
+		entry = rhashtable_lookup(&cache->rhead, mpath->dst, mesh_hdr_rht_params);
+		if (entry) {
+			hlist_del_rcu(&entry->walk_list);
+			rhashtable_remove_fast(&cache->rhead, &entry->rhash, mesh_hdr_rht_params);
+			kfree_rcu(entry, rcu);
+			atomic_dec(&cache->size);
+		}
+		spin_unlock_bh(&cache->walk_lock);
+		return;
+	}
+
+	hlist_for_each_entry_safe(entry, n, &cache->walk_head, walk_list) {
+		entry_mpath = rcu_dereference(entry->mpath);
+
+		if (!entry_mpath)
+			continue;
+
+		if (ether_addr_equal(entry_mpath->dst, mpath->dst)) {
+			hlist_del_rcu(&entry->walk_list);
+			rhashtable_remove_fast(&cache->rhead, &entry->rhash, mesh_hdr_rht_params);
+			kfree_rcu(entry, rcu);
+			atomic_dec(&cache->size);
+		}
+	}
+	spin_unlock_bh(&cache->walk_lock);
+}
+
 /**
  * mesh_path_add - allocate and add a new path to the mesh path table
  * @dst: destination address of the path (ETH_ALEN length)
@@ -425,6 +798,7 @@ struct mesh_path *mesh_path_add(struct ieee80211_sub_if_data *sdata,
 						  mesh_rht_params);
 	if (!mpath)
 		hlist_add_head(&new_mpath->walk_list, &tbl->walk_head);
+
 	spin_unlock_bh(&tbl->walk_lock);
 
 	if (mpath) {
@@ -529,6 +903,7 @@ static void mesh_path_free_rcu(struct mesh_table *tbl,
 
 static void __mesh_path_del(struct mesh_table *tbl, struct mesh_path *mpath)
 {
+	mesh_hdr_cache_flush(mpath, tbl == mpath->sdata->u.mesh.mpp_paths);
 	hlist_del_rcu(&mpath->walk_list);
 	rhashtable_remove_fast(&tbl->rhead, &mpath->rhash, mesh_rht_params);
 	mesh_path_free_rcu(tbl, mpath);
@@ -755,6 +1130,8 @@ void mesh_path_fix_nexthop(struct mesh_path *mpath, struct sta_info *next_hop)
 	mpath->exp_time = 0;
 	mpath->flags = MESH_PATH_FIXED | MESH_PATH_SN_VALID;
 	mesh_path_activate(mpath);
+	if (!old_next_hop || !ether_addr_equal(old_next_hop->addr, next_hop->addr))
+		mpath->path_change_count++;
 	spin_unlock_bh(&mpath->state_lock);
 	ewma_mesh_fail_avg_init(&next_hop->mesh->fail_avg);
 	/* init it at a low value - 0 start is tricky */
@@ -777,6 +1154,8 @@ int mesh_pathtbl_init(struct ieee80211_sub_if_data *sdata)
 		goto free_path;
 	}
 
+	mesh_hdr_cache_init(sdata);
+
 	sdata->u.mesh.mesh_paths = tbl_path;
 	sdata->u.mesh.mpp_paths = tbl_mpp;
 
@@ -814,4 +1193,5 @@ void mesh_pathtbl_unregister(struct ieee80211_sub_if_data *sdata)
 {
 	mesh_table_free(sdata->u.mesh.mesh_paths);
 	mesh_table_free(sdata->u.mesh.mpp_paths);
+	mesh_hdr_cache_deinit(sdata);
 }
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 9541a4c..0b09cb1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2885,6 +2885,7 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 		struct mesh_path *mppath;
 		char *proxied_addr;
 		char *mpp_addr;
+		bool update = false;
 
 		if (is_multicast_ether_addr(hdr->addr1)) {
 			mpp_addr = hdr->addr3;
@@ -2904,12 +2905,18 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 			mpp_path_add(sdata, proxied_addr, mpp_addr);
 		} else {
 			spin_lock_bh(&mppath->state_lock);
-			if (!ether_addr_equal(mppath->mpp, mpp_addr))
+			if (!ether_addr_equal(mppath->mpp, mpp_addr)) {
 				memcpy(mppath->mpp, mpp_addr, ETH_ALEN);
+				update = true;
+			}
 			mppath->exp_time = jiffies;
 			spin_unlock_bh(&mppath->state_lock);
 		}
 		rcu_read_unlock();
+
+		/* Flush any hdr, if external device moved to a new gate */
+		if (update)
+			mesh_hdr_cache_flush(mppath, true);
 	}
 
 	/* Frame has reached destination.  Don't forward */
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 278945e..6191c77 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2679,18 +2679,24 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 
 			hdrlen = ieee80211_fill_mesh_addresses(&hdr, &fc,
 					mesh_da, sdata->vif.addr);
-			if (is_multicast_ether_addr(mesh_da))
+			if (is_multicast_ether_addr(mesh_da)) {
 				/* DA TA mSA AE:SA */
 				meshhdrlen = ieee80211_new_mesh_header(
 						sdata, &mesh_hdr,
 						skb->data + ETH_ALEN, NULL);
-			else
+			} else {
 				/* RA TA mDA mSA AE:DA SA */
 				meshhdrlen = ieee80211_new_mesh_header(
 						sdata, &mesh_hdr, skb->data,
 						skb->data + ETH_ALEN);
 
+				/* cache unicast proxy headers */
+				if (ethertype >= ETH_P_802_3_MIN)
+					ctrl_flags |= IEEE80211_TX_CTRL_CHECK_FAST_MESH;
+			}
+
 		}
+
 		chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
 		if (!chanctx_conf) {
 			ret = -ENOTCONN;
@@ -3621,6 +3627,82 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	return true;
 }
 
+static bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
+				     struct sk_buff *skb, u32 ctrl_flags)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_tx_data tx;
+	struct ieee80211_tx_info *info;
+	struct mhdr_cache_entry *entry;
+	u16 ethertype = (skb->data[12] << 8) | skb->data[13];
+	struct ieee80211_key *key;
+	struct sta_info *sta;
+
+	if (ctrl_flags & IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP)
+		return false;
+
+	if (ifmsh->mshcfg.dot11MeshNolearn)
+		return false;
+
+	if (!wiphy_ext_feature_isset(local->hw.wiphy,
+				     NL80211_EXT_FEATURE_MESH_FAST_XMIT))
+		return false;
+
+	if (sdata->noack_map)
+		return false;
+
+	if (is_multicast_ether_addr(skb->data))
+		return false;
+
+	if (cpu_to_be16(ethertype) == sdata->control_port_protocol)
+		return false;
+
+	if (ethertype < ETH_P_802_3_MIN)
+		return false;
+
+	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
+		return false;
+
+	/* Fill cached header for this eth data */
+	entry = mesh_fill_cached_hdr(sdata, skb);
+
+	if (!entry)
+		return false;
+
+	info = IEEE80211_SKB_CB(skb);
+	memset(info, 0, sizeof(*info));
+	info->band = entry->band;
+	info->control.vif = &sdata->vif;
+	info->flags = IEEE80211_TX_CTL_FIRST_FRAGMENT |
+		      IEEE80211_TX_CTL_DONTFRAG;
+
+	info->control.flags = IEEE80211_TX_CTRL_FAST_XMIT;
+
+#ifdef CONFIG_MAC80211_DEBUGFS
+	if (local->force_tx_status)
+		info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+#endif
+
+	sta = entry->mpath->next_hop;
+	key = entry->key;
+
+	__skb_queue_head_init(&tx.skbs);
+
+	tx.flags = IEEE80211_TX_UNICAST;
+	tx.local = local;
+	tx.sdata = sdata;
+	tx.sta = sta;
+	tx.key = key;
+
+	ieee80211_xmit_fast_finish(sdata, sta, entry->pn_offs,
+				   key, &tx);
+
+	__skb_queue_tail(&tx.skbs, skb);
+	ieee80211_tx_frags(local, &sdata->vif, sta, &tx.skbs, false);
+	return true;
+}
+
 struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 				     struct ieee80211_txq *txq)
 {
@@ -4177,6 +4259,10 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 
 	rcu_read_lock();
 
+	if (ieee80211_vif_is_mesh(&sdata->vif) &&
+	    ieee80211_mesh_xmit_fast(sdata, skb, ctrl_flags))
+		goto out;
+
 	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
 		goto out_free;
 
-- 
2.7.4


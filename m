Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E7358B750
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Aug 2022 19:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiHFRif (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Aug 2022 13:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiHFRie (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Aug 2022 13:38:34 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66B01A8
        for <linux-wireless@vger.kernel.org>; Sat,  6 Aug 2022 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659807512; x=1691343512;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=398E9w6x/DoruHLNLZC6XgqbBeFyzahGeI47xZi4nmw=;
  b=hEvgw8CzTQB4w+K4QDZuDboTEBAwlPPMn0nTv/Tkvl9g2DpyFj5B7LnP
   HgKHKJqgogFB5tOrvnIcozcsu9OR/PW32rdHRrcpk1Eo7CGkOmz011EWT
   nHPh/XVDqaQQMgFzkG8ZmS0qrlUFzznHLlkkqUhLHsT1LbOv9Gd5fddMe
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Aug 2022 10:38:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 10:38:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 6 Aug 2022 10:38:32 -0700
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 6 Aug 2022 10:38:29 -0700
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>, <nbd@nbd.name>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v3] wifi: mac80211: Mesh Fast xmit support
Date:   Sat, 6 Aug 2022 23:08:05 +0530
Message-ID: <20220806173805.32743-1-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently Fast xmit is supported in AP, STA and other device types where
the destination doesn't change for the lifetime of its association by
caching the static parts of the header that can be reused directly for
every Tx such as addresses and updates only mutable header fields such as
PN. This technique is not directly applicable for a Mesh device type
due to the dynamic nature of the topology and protocol. The header is
built based on the destination mesh device which is proxying a certain
external device and based on the Mesh destination the next hop changes.
And the RA/A1 which is the next hop for reaching the destination can
vary during runtime as per the best route based on airtime.  To
accommodate these changes and to come up with a solution to avoid
overhead during header generation, the headers comprising the MAC, Mesh
and LLC part are cached whenever data for a certain external destination
is sent. This cached header is reused every time a data is sent to that
external destination.

To ensure the changes in network are reflected in these cached headers,
the Mesh Proxy path table and Mesh path table changes are monitored
and corresponding headers are updated or flushed as applicable so that
the header used for a frame towards a certain destination is valid.

Old headers are flushed by the mesh housekeeping timers and based on the
cache size.

Only 6addr frame headers are cached currently.

Tested with ath11k driver.

Fixed Sparse warnings "incompatible types in comparison expression"
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
v3: Added wifi tag in commit. Fixed sparse warnings
v2: Moved to static header cache size of 512 entries
    Rearranged entry struct to avoid padding
    Used GFP_ATOMIC while entry allocation in tx path
    Compile tested from previous version - only above trivial changes
 net/mac80211/ieee80211_i.h  |  20 ++
 net/mac80211/mesh.c         |   2 +
 net/mac80211/mesh.h         |  46 +++++
 net/mac80211/mesh_hwmp.c    |   8 +-
 net/mac80211/mesh_pathtbl.c | 396 ++++++++++++++++++++++++++++++++++++
 net/mac80211/rx.c           |   9 +-
 net/mac80211/tx.c           |  89 ++++++++
 7 files changed, 566 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e192e1ec0261..8c3d09886342 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -653,6 +653,25 @@ struct mesh_table {
 	atomic_t entries;		/* Up to MAX_MESH_NEIGHBOURS */
 };
 
+/**
+ * struct mesh_hdr_cache
+ *
+ * @enabled: Flag to denote if Header caching is enabled.
+ * @rhead: the rhashtable containing struct mesh_cache_entry, keyed by addr_key which
+ *	For a 6addr format which is currently supported in the cache, the key
+ *	is the external destination address or a5
+ * @walk_head: linked list containing all mesh_cache_entry objects
+ * @walk_lock: lock protecting walk_head
+ * @size: number of entries in the cache
+ */
+struct mesh_hdr_cache {
+	bool enabled;
+	struct rhashtable rhead;
+	struct hlist_head walk_head;
+	spinlock_t walk_lock; /* protects cache entries */
+	u16 size;
+};
+
 struct ieee80211_if_mesh {
 	struct timer_list housekeeping_timer;
 	struct timer_list mesh_path_timer;
@@ -731,6 +750,7 @@ struct ieee80211_if_mesh {
 	struct mesh_table mpp_paths; /* Store paths for MPP&MAP */
 	int mesh_paths_generation;
 	int mpp_paths_generation;
+	struct mesh_hdr_cache hdr_cache;
 };
 
 #ifdef CONFIG_MAC80211_MESH
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 6991c4c479da..559aa67a5ccb 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -782,6 +782,8 @@ static void ieee80211_mesh_housekeeping(struct ieee80211_sub_if_data *sdata)
 	changed = mesh_accept_plinks_update(sdata);
 	ieee80211_mbss_info_change_notify(sdata, changed);
 
+	mesh_hdr_cache_manage(sdata);
+
 	mod_timer(&ifmsh->housekeeping_timer,
 		  round_jiffies(jiffies +
 				IEEE80211_MESH_HOUSEKEEPING_INTERVAL));
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index b2b717a78114..6c29740c2256 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -127,6 +127,45 @@ struct mesh_path {
 	u32 path_change_count;
 };
 
+#define MESH_HEADER_CACHE_MAX_SIZE		512
+#define MESH_HEADER_CACHE_THRESHOLD_SIZE	384
+#define MESH_HEADER_CACHE_TIMEOUT		8000 /* msecs */
+#define MESH_HEADER_MAX_LEN			68   /* mac+mesh+rfc1042 hdr */
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
+	u8 hdr[MESH_HEADER_MAX_LEN];
+	u16 machdr_len;
+	u16 hdrlen;
+	u8 pn_offs;
+	u8 band;
+	struct ieee80211_key __rcu *key;
+	struct hlist_node walk_list;
+	struct rhash_head rhash;
+	struct mesh_path __rcu *mpath;
+	struct mesh_path __rcu *mppath;
+	unsigned long timestamp;
+	struct rcu_head rcu;
+	u32 path_change_count;
+};
+
 /* Recent multicast cache */
 /* RMC_BUCKETS must be a power of 2, maximum 256 */
 #define RMC_BUCKETS		256
@@ -299,6 +338,13 @@ void mesh_path_tx_root_frame(struct ieee80211_sub_if_data *sdata);
 
 bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt);
 
+struct mhdr_cache_entry *mesh_fill_cached_hdr(struct ieee80211_sub_if_data *sdata,
+					      struct sk_buff *skb);
+void mesh_cache_hdr(struct ieee80211_sub_if_data *sdata,
+		    struct sk_buff *skb, struct mesh_path *mpath);
+void mesh_hdr_cache_manage(struct ieee80211_sub_if_data *sdata);
+void mesh_hdr_cache_flush(struct mesh_path *mpath, bool is_mpp);
+void mesh_queue_preq(struct mesh_path *mpath, u8 flags);
 #ifdef CONFIG_MAC80211_MESH
 static inline
 u32 mesh_plink_inc_estab_count(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9b1ce7c3925a..f6183145ff37 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -18,8 +18,6 @@
 
 #define MAX_PREQ_QUEUE_LEN	64
 
-static void mesh_queue_preq(struct mesh_path *, u8);
-
 static inline u32 u32_field_get(const u8 *preq_elem, int offset, bool ae)
 {
 	if (ae)
@@ -977,7 +975,7 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
  * Locking: the function must be called from within a rcu read lock block.
  *
  */
-static void mesh_queue_preq(struct mesh_path *mpath, u8 flags)
+void mesh_queue_preq(struct mesh_path *mpath, u8 flags)
 {
 	struct ieee80211_sub_if_data *sdata = mpath->sdata;
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
@@ -1255,6 +1253,10 @@ int mesh_nexthop_lookup(struct ieee80211_sub_if_data *sdata,
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
index acc1c299f1ae..b5be9fe08490 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -14,6 +14,7 @@
 #include "wme.h"
 #include "ieee80211_i.h"
 #include "mesh.h"
+#include <linux/rhashtable.h>
 
 static void mesh_path_free_rcu(struct mesh_table *tbl, struct mesh_path *mpath);
 
@@ -32,6 +33,56 @@ static const struct rhashtable_params mesh_rht_params = {
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
+	cache = &sdata->u.mesh.hdr_cache;
+
+	if (!cache->enabled)
+		return;
+
+	rhashtable_free_and_destroy(&cache->rhead,
+				    mesh_hdr_cache_entry_free, NULL);
+
+	cache->enabled = false;
+}
+
+static void mesh_hdr_cache_init(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct mesh_hdr_cache *cache;
+
+	cache = &sdata->u.mesh.hdr_cache;
+
+	cache->enabled = false;
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORT_FAST_XMIT))
+		return;
+
+	rhashtable_init(&cache->rhead, &mesh_hdr_rht_params);
+	INIT_HLIST_HEAD(&cache->walk_head);
+	spin_lock_init(&cache->walk_lock);
+	cache->size = 0;
+	cache->enabled = true;
+}
+
 static inline bool mpath_expired(struct mesh_path *mpath)
 {
 	return (mpath->flags & MESH_PATH_ACTIVE) &&
@@ -381,6 +432,343 @@ struct mesh_path *mesh_path_new(struct ieee80211_sub_if_data *sdata,
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
+	struct ethhdr *eth;
+	u8 sa[ETH_ALEN];
+
+	u8 tid;
+
+	cache = &sdata->u.mesh.hdr_cache;
+
+	if (!cache->enabled)
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
+	/* If the skb is shared we need to obtain our own copy */
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
+	/* backup eth SA to copy as eaddr2/SA in the mesh header */
+	eth = (struct ethhdr *)skb->data;
+	ether_addr_copy(sa, eth->h_source);
+
+	/* Pull DA:SA */
+	skb_pull(skb, ETH_ALEN * 2);
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
+	memcpy(meshhdr->eaddr2, sa, ETH_ALEN);
+	meshhdr->ttl = sdata->u.mesh.mshcfg.dot11MeshTTL;
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
+	if (sdata->noack_map)
+		return;
+
+	cache = &sdata->u.mesh.hdr_cache;
+
+	if (!cache->enabled)
+		return;
+
+	hdrlen = ieee80211_hdrlen(hdr->frame_control);
+
+	meshhdr = (struct ieee80211s_hdr *)(skb->data + hdrlen);
+
+	/* Currently supporting only 6addr hdr */
+	if (!(meshhdr->flags & MESH_FLAGS_AE_A5_A6))
+		return;
+
+	mshhdr_len = ieee80211_get_mesh_hdrlen(meshhdr);
+
+	spin_lock_bh(&cache->walk_lock);
+	if (cache->size > MESH_HEADER_CACHE_MAX_SIZE) {
+		spin_unlock_bh(&cache->walk_lock);
+		return;
+	}
+	spin_unlock_bh(&cache->walk_lock);
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
+	band = info->band;
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
+	if ((hdrlen + crypto_len + mshhdr_len + sizeof(rfc1042_header)) >
+		MESH_HEADER_MAX_LEN) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	mhdr = kzalloc(sizeof(*mhdr), GFP_ATOMIC);
+	if (!mhdr)
+		return;
+
+	memcpy(mhdr->addr_key, meshhdr->eaddr1, ETH_ALEN);
+
+	mhdr->machdr_len = hdrlen + crypto_len;
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
+		 * be overwritten during tx
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
+	spin_lock_bh(&cache->walk_lock);
+	old_mhdr = rhashtable_lookup_get_insert_fast(&cache->rhead,
+						     &mhdr->rhash,
+						     mesh_hdr_rht_params);
+	if (old_mhdr) {
+		spin_unlock_bh(&cache->walk_lock);
+		kfree(mhdr);
+		return;
+	}
+
+	hlist_add_head(&mhdr->walk_list, &cache->walk_head);
+
+	cache->size++;
+	spin_unlock_bh(&cache->walk_lock);
+}
+
+void mesh_hdr_cache_manage(struct ieee80211_sub_if_data *sdata)
+{
+	struct mesh_hdr_cache *cache;
+	struct mhdr_cache_entry *entry;
+	struct hlist_node *n;
+
+	cache = &sdata->u.mesh.hdr_cache;
+
+	if (!cache->enabled)
+		return;
+
+	spin_lock_bh(&cache->walk_lock);
+	if (cache->size < MESH_HEADER_CACHE_THRESHOLD_SIZE) {
+		spin_unlock_bh(&cache->walk_lock);
+		return;
+	}
+
+	hlist_for_each_entry_safe(entry, n, &cache->walk_head, walk_list) {
+		if (time_before(jiffies,
+				entry->timestamp +
+				msecs_to_jiffies(MESH_HEADER_CACHE_TIMEOUT)))
+			continue;
+
+		hlist_del_rcu(&entry->walk_list);
+		rhashtable_remove_fast(&cache->rhead, &entry->rhash, mesh_hdr_rht_params);
+		kfree_rcu(entry, rcu);
+		cache->size--;
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
+	cache = &sdata->u.mesh.hdr_cache;
+
+	if (!cache->enabled)
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
+			cache->size--;
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
+			cache->size--;
+		}
+	}
+	spin_unlock_bh(&cache->walk_lock);
+}
+
 /**
  * mesh_path_add - allocate and add a new path to the mesh path table
  * @dst: destination address of the path (ETH_ALEN length)
@@ -521,6 +909,7 @@ static void mesh_path_free_rcu(struct mesh_table *tbl,
 
 static void __mesh_path_del(struct mesh_table *tbl, struct mesh_path *mpath)
 {
+	mesh_hdr_cache_flush(mpath, tbl == &mpath->sdata->u.mesh.mpp_paths);
 	hlist_del_rcu(&mpath->walk_list);
 	rhashtable_remove_fast(&tbl->rhead, &mpath->rhash, mesh_rht_params);
 	mesh_path_free_rcu(tbl, mpath);
@@ -739,7 +1128,10 @@ void mesh_path_flush_pending(struct mesh_path *mpath)
  */
 void mesh_path_fix_nexthop(struct mesh_path *mpath, struct sta_info *next_hop)
 {
+	struct sta_info *old_next_hop;
+
 	spin_lock_bh(&mpath->state_lock);
+	old_next_hop = rcu_dereference(mpath->next_hop);
 	mesh_path_assign_nexthop(mpath, next_hop);
 	mpath->sn = 0xffff;
 	mpath->metric = 0;
@@ -747,6 +1139,8 @@ void mesh_path_fix_nexthop(struct mesh_path *mpath, struct sta_info *next_hop)
 	mpath->exp_time = 0;
 	mpath->flags = MESH_PATH_FIXED | MESH_PATH_SN_VALID;
 	mesh_path_activate(mpath);
+	if (!old_next_hop || !ether_addr_equal(old_next_hop->addr, next_hop->addr))
+		mpath->path_change_count++;
 	spin_unlock_bh(&mpath->state_lock);
 	ewma_mesh_fail_avg_init(&next_hop->mesh->fail_avg);
 	/* init it at a low value - 0 start is tricky */
@@ -758,6 +1152,7 @@ void mesh_pathtbl_init(struct ieee80211_sub_if_data *sdata)
 {
 	mesh_table_init(&sdata->u.mesh.mesh_paths);
 	mesh_table_init(&sdata->u.mesh.mpp_paths);
+	mesh_hdr_cache_init(sdata);
 }
 
 static
@@ -785,6 +1180,7 @@ void mesh_path_expire(struct ieee80211_sub_if_data *sdata)
 
 void mesh_pathtbl_unregister(struct ieee80211_sub_if_data *sdata)
 {
+	mesh_hdr_cache_deinit(sdata);
 	mesh_table_free(&sdata->u.mesh.mesh_paths);
 	mesh_table_free(&sdata->u.mesh.mpp_paths);
 }
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 57df21e2170a..6a103b6d7817 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2902,6 +2902,7 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 		struct mesh_path *mppath;
 		char *proxied_addr;
 		char *mpp_addr;
+		bool update = false;
 
 		if (is_multicast_ether_addr(hdr->addr1)) {
 			mpp_addr = hdr->addr3;
@@ -2921,12 +2922,18 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 			mpp_path_add(sdata, proxied_addr, mpp_addr);
 		} else {
 			spin_lock_bh(&mppath->state_lock);
-			if (!ether_addr_equal(mppath->mpp, mpp_addr))
+			if (!ether_addr_equal(mppath->mpp, mpp_addr)) {
+				update = true;
 				memcpy(mppath->mpp, mpp_addr, ETH_ALEN);
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
index 45df9932d0ba..d23b633294c2 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3546,6 +3546,91 @@ ieee80211_xmit_fast_finish(struct ieee80211_sub_if_data *sdata,
 	return TX_CONTINUE;
 }
 
+static bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
+				     struct sk_buff *skb, u32 ctrl_flags)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_tx_data tx;
+	struct ieee80211_tx_info *info;
+	struct mhdr_cache_entry *entry;
+	u16 ethertype;
+	struct ieee80211_key *key;
+	struct sta_info *sta;
+
+	if (ctrl_flags & IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP)
+		return false;
+
+	if (ifmsh->mshcfg.dot11MeshNolearn)
+		return false;
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORT_FAST_XMIT))
+		return false;
+
+	/* Add support for these cases later */
+	if (ifmsh->ps_peers_light_sleep || ifmsh->ps_peers_deep_sleep)
+		return false;
+
+	if (is_multicast_ether_addr(skb->data))
+		return false;
+
+	ethertype = (skb->data[12] << 8) | skb->data[13];
+
+	if (ethertype < ETH_P_802_3_MIN)
+		return false;
+
+	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
+		return false;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		skb_set_transport_header(skb,
+					 skb_checksum_start_offset(skb));
+		if (skb_checksum_help(skb))
+			return false;
+	}
+
+	/* Fill cached header for this eth data */
+	entry = mesh_fill_cached_hdr(sdata, skb);
+
+	if (!entry)
+		return false;
+
+	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
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
+	tx.skb = skb;
+
+	ieee80211_xmit_fast_finish(sdata, sta, entry->pn_offs,
+				   key, &tx);
+
+	__skb_queue_tail(&tx.skbs, skb);
+	ieee80211_tx_frags(local, &sdata->vif, sta, &tx.skbs, false);
+	return true;
+}
+
 static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 				struct sta_info *sta,
 				struct ieee80211_fast_tx *fast_tx,
@@ -4139,6 +4224,10 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 
 	rcu_read_lock();
 
+	if (ieee80211_vif_is_mesh(&sdata->vif) &&
+	    ieee80211_mesh_xmit_fast(sdata, skb, ctrl_flags))
+		goto out;
+
 	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
 		goto out_free;
 
-- 
2.17.1


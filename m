Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449DE6B8F1E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 11:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCNKAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCNKAO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 06:00:14 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEDD20078
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VByilFGbyu6+ZtATYIJm3pjH/kjQwLNvj1HxukSUI1E=; b=E6cB+/6JcA8PWbwhbc7vmMGGjN
        BvxW3f8gFcDHevudlqlMRVS2MjrgLlRhhPy787o1dSKMl8knrOwxPL72NqPDLhLGRrzNqQRT/tm0l
        G3v4kuJkLrVVVLfigh7FjNlHjUHBA128LI5NWWCa3u3a1a7rPfDU4xb7Ajt27VniUSr4=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pc1Rn-001pV5-RC; Tue, 14 Mar 2023 10:59:59 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ryder Lee <ryder.lee@mediatek.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 4/7] wifi: mac80211: mesh fast xmit support
Date:   Tue, 14 Mar 2023 10:59:53 +0100
Message-Id: <20230314095956.62085-4-nbd@nbd.name>
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

Previously, fast xmit only worked on interface types where initially a
sta lookup is performed, and a cached header can be attached to the sta,
requiring only some fields to be updated at runtime.

This technique is not directly applicable for a mesh device type due
to the dynamic nature of the topology and protocol. There are more
addresses that need to be filled, and there is an extra header with a
dynamic length based on the addressing mode.

Change the code to cache entries contain a copy of the mesh subframe header +
bridge tunnel header, as well as an embedded struct ieee80211_fast_tx, which
contains the information for building the 802.11 header.

Add a mesh specific early fast xmit call, which looks up a cached entry and
adds only the mesh subframe header, before passing it over to the generic
fast xmit code.

To ensure the changes in network are reflected in these cached headers,
flush affected cached entries on path changes, as well as other conditions
that currently trigger a fast xmit check in other modes (key changes etc.)

This code is loosely based on a previous implementation by:
Sriram R <quic_srirrama@quicinc.com>

Cc: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/ieee80211_i.h  |  20 +++
 net/mac80211/mesh.c         |  92 ++++++++++++
 net/mac80211/mesh.h         |  44 ++++++
 net/mac80211/mesh_hwmp.c    |  37 +++--
 net/mac80211/mesh_pathtbl.c | 282 ++++++++++++++++++++++++++++++++++++
 net/mac80211/rx.c           |  10 +-
 net/mac80211/tx.c           |  47 ++++--
 7 files changed, 507 insertions(+), 25 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a4e1fdab1d3d..54e69c6447c0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -37,6 +37,7 @@
 extern const struct cfg80211_ops mac80211_config_ops;
 
 struct ieee80211_local;
+struct ieee80211_mesh_fast_tx;
 
 /* Maximum number of broadcast/multicast frames to buffer when some of the
  * associated stations are using power saving. */
@@ -656,6 +657,19 @@ struct mesh_table {
 	atomic_t entries;		/* Up to MAX_MESH_NEIGHBOURS */
 };
 
+/**
+ * struct mesh_tx_cache - mesh fast xmit header cache
+ *
+ * @rht: hash table containing struct ieee80211_mesh_fast_tx, using skb DA as key
+ * @walk_head: linked list containing all ieee80211_mesh_fast_tx objects
+ * @walk_lock: lock protecting walk_head and rht
+ */
+struct mesh_tx_cache {
+	struct rhashtable rht;
+	struct hlist_head walk_head;
+	spinlock_t walk_lock;
+};
+
 struct ieee80211_if_mesh {
 	struct timer_list housekeeping_timer;
 	struct timer_list mesh_path_timer;
@@ -734,6 +748,7 @@ struct ieee80211_if_mesh {
 	struct mesh_table mpp_paths; /* Store paths for MPP&MAP */
 	int mesh_paths_generation;
 	int mpp_paths_generation;
+	struct mesh_tx_cache tx_cache;
 };
 
 #ifdef CONFIG_MAC80211_MESH
@@ -2017,6 +2032,11 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      int link_id, u64 *cookie);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
+void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
+			   struct sta_info *sta,
+			   struct ieee80211_fast_tx *fast_tx,
+			   struct sk_buff *skb, bool ampdu,
+			   const u8 *da, const u8 *sa);
 
 /* HT */
 void ieee80211_apply_htcap_overrides(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 0608ed415831..6b94cf2a4046 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -10,6 +10,7 @@
 #include <asm/unaligned.h>
 #include "ieee80211_i.h"
 #include "mesh.h"
+#include "wme.h"
 #include "driver-ops.h"
 
 static int mesh_allocated;
@@ -698,6 +699,95 @@ ieee80211_mesh_update_bss_params(struct ieee80211_sub_if_data *sdata,
 			__le32_to_cpu(he_oper->he_oper_params);
 }
 
+bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
+			      struct sk_buff *skb, u32 ctrl_flags)
+{
+	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_mesh_fast_tx *entry;
+	struct ieee80211s_hdr *meshhdr;
+	u8 sa[ETH_ALEN] __aligned(2);
+	struct tid_ampdu_tx *tid_tx;
+	struct sta_info *sta;
+	bool copy_sa = false;
+	u16 ethertype;
+	u8 tid;
+
+	if (ctrl_flags & IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP)
+		return false;
+
+	if (ifmsh->mshcfg.dot11MeshNolearn)
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
+	if (ethertype < ETH_P_802_3_MIN)
+		return false;
+
+	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
+		return false;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		skb_set_transport_header(skb, skb_checksum_start_offset(skb));
+		if (skb_checksum_help(skb))
+			return false;
+	}
+
+	entry = mesh_fast_tx_get(sdata, skb->data);
+	if (!entry)
+		return false;
+
+	if (skb_headroom(skb) < entry->hdrlen + entry->fast_tx.hdr_len)
+		return false;
+
+	sta = rcu_dereference(entry->mpath->next_hop);
+	if (!sta)
+		return false;
+
+	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
+	if (tid_tx) {
+		if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state))
+			return false;
+		if (tid_tx->timeout)
+			tid_tx->last_tx = jiffies;
+	}
+
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return true;
+
+	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));
+
+	meshhdr = (struct ieee80211s_hdr *)entry->hdr;
+	if ((meshhdr->flags & MESH_FLAGS_AE) == MESH_FLAGS_AE_A5_A6) {
+		/* preserve SA from eth header for 6-addr frames */
+		ether_addr_copy(sa, skb->data + ETH_ALEN);
+		copy_sa = true;
+	}
+
+	memcpy(skb_push(skb, entry->hdrlen - 2 * ETH_ALEN), entry->hdr,
+	       entry->hdrlen);
+
+	meshhdr = (struct ieee80211s_hdr *)skb->data;
+	put_unaligned_le32(atomic_inc_return(&sdata->u.mesh.mesh_seqnum),
+			   &meshhdr->seqnum);
+	meshhdr->ttl = sdata->u.mesh.mshcfg.dot11MeshTTL;
+	if (copy_sa)
+	    ether_addr_copy(meshhdr->eaddr2, sa);
+
+	skb_push(skb, 2 * ETH_ALEN);
+	__ieee80211_xmit_fast(sdata, sta, &entry->fast_tx, skb, tid_tx,
+			      entry->mpath->dst, sdata->vif.addr);
+
+	return true;
+}
+
 /**
  * ieee80211_fill_mesh_addresses - fill addresses of a locally originated mesh frame
  * @hdr:	802.11 frame header
@@ -780,6 +870,8 @@ static void ieee80211_mesh_housekeeping(struct ieee80211_sub_if_data *sdata)
 	changed = mesh_accept_plinks_update(sdata);
 	ieee80211_mbss_info_change_notify(sdata, changed);
 
+	mesh_fast_tx_gc(sdata);
+
 	mod_timer(&ifmsh->housekeeping_timer,
 		  round_jiffies(jiffies +
 				IEEE80211_MESH_HOUSEKEEPING_INTERVAL));
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index b2b717a78114..13f394e677ae 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -122,11 +122,41 @@ struct mesh_path {
 	u8 rann_snd_addr[ETH_ALEN];
 	u32 rann_metric;
 	unsigned long last_preq_to_root;
+	unsigned long fast_tx_check;
 	bool is_root;
 	bool is_gate;
 	u32 path_change_count;
 };
 
+#define MESH_FAST_TX_CACHE_MAX_SIZE		512
+#define MESH_FAST_TX_CACHE_THRESHOLD_SIZE	384
+#define MESH_FAST_TX_CACHE_TIMEOUT		8000 /* msecs */
+
+/**
+ * struct ieee80211_mesh_fast_tx - cached mesh fast tx entry
+ * @rhash: rhashtable pointer
+ * @addr_key: The Ethernet DA which is the key for this entry
+ * @fast_tx: base fast_tx data
+ * @hdr: cached mesh and rfc1042 headers
+ * @hdrlen: length of mesh + rfc1042
+ * @walk_list: list containing all the fast tx entries
+ * @mpath: mesh path corresponding to the Mesh DA
+ * @mppath: MPP entry corresponding to this DA
+ * @timestamp: Last used time of this entry
+ */
+struct ieee80211_mesh_fast_tx {
+	struct rhash_head rhash;
+	u8 addr_key[ETH_ALEN] __aligned(2);
+
+	struct ieee80211_fast_tx fast_tx;
+	u8 hdr[sizeof(struct ieee80211s_hdr) + sizeof(rfc1042_header)];
+	u16 hdrlen;
+
+	struct mesh_path *mpath, *mppath;
+	struct hlist_node walk_list;
+	unsigned long timestamp;
+};
+
 /* Recent multicast cache */
 /* RMC_BUCKETS must be a power of 2, maximum 256 */
 #define RMC_BUCKETS		256
@@ -298,6 +328,20 @@ void mesh_path_discard_frame(struct ieee80211_sub_if_data *sdata,
 void mesh_path_tx_root_frame(struct ieee80211_sub_if_data *sdata);
 
 bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt);
+struct ieee80211_mesh_fast_tx *
+mesh_fast_tx_get(struct ieee80211_sub_if_data *sdata, const u8 *addr);
+bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
+			      struct sk_buff *skb, u32 ctrl_flags);
+void mesh_fast_tx_cache(struct ieee80211_sub_if_data *sdata,
+			struct sk_buff *skb, struct mesh_path *mpath);
+void mesh_fast_tx_gc(struct ieee80211_sub_if_data *sdata);
+void mesh_fast_tx_flush_addr(struct ieee80211_sub_if_data *sdata,
+			     const u8 *addr);
+void mesh_fast_tx_flush_mpath(struct mesh_path *mpath);
+void mesh_fast_tx_flush_sta(struct ieee80211_sub_if_data *sdata,
+			    struct sta_info *sta);
+void mesh_path_refresh(struct ieee80211_sub_if_data *sdata,
+		       struct mesh_path *mpath, const u8 *addr);
 
 #ifdef CONFIG_MAC80211_MESH
 static inline
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9b1ce7c3925a..5217e1d97dd6 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -394,6 +394,7 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 	u32 orig_sn, orig_metric;
 	unsigned long orig_lifetime, exp_time;
 	u32 last_hop_metric, new_metric;
+	bool flush_mpath = false;
 	bool process = true;
 	u8 hopcount;
 
@@ -491,8 +492,10 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (fresh_info) {
-			if (rcu_access_pointer(mpath->next_hop) != sta)
+			if (rcu_access_pointer(mpath->next_hop) != sta) {
 				mpath->path_change_count++;
+				flush_mpath = true;
+			}
 			mesh_path_assign_nexthop(mpath, sta);
 			mpath->flags |= MESH_PATH_SN_VALID;
 			mpath->metric = new_metric;
@@ -502,6 +505,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 			mpath->hop_count = hopcount;
 			mesh_path_activate(mpath);
 			spin_unlock_bh(&mpath->state_lock);
+			if (flush_mpath)
+				mesh_fast_tx_flush_mpath(mpath);
 			ewma_mesh_fail_avg_init(&sta->mesh->fail_avg);
 			/* init it at a low value - 0 start is tricky */
 			ewma_mesh_fail_avg_add(&sta->mesh->fail_avg, 1);
@@ -539,8 +544,10 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (fresh_info) {
-			if (rcu_access_pointer(mpath->next_hop) != sta)
+			if (rcu_access_pointer(mpath->next_hop) != sta) {
 				mpath->path_change_count++;
+				flush_mpath = true;
+			}
 			mesh_path_assign_nexthop(mpath, sta);
 			mpath->metric = last_hop_metric;
 			mpath->exp_time = time_after(mpath->exp_time, exp_time)
@@ -548,6 +555,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 			mpath->hop_count = 1;
 			mesh_path_activate(mpath);
 			spin_unlock_bh(&mpath->state_lock);
+			if (flush_mpath)
+				mesh_fast_tx_flush_mpath(mpath);
 			ewma_mesh_fail_avg_init(&sta->mesh->fail_avg);
 			/* init it at a low value - 0 start is tricky */
 			ewma_mesh_fail_avg_add(&sta->mesh->fail_avg, 1);
@@ -1215,6 +1224,20 @@ static int mesh_nexthop_lookup_nolearn(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+void mesh_path_refresh(struct ieee80211_sub_if_data *sdata,
+		       struct mesh_path *mpath, const u8 *addr)
+{
+	if (mpath->flags & (MESH_PATH_REQ_QUEUED | MESH_PATH_FIXED |
+			    MESH_PATH_RESOLVING))
+		return;
+
+	if (time_after(jiffies,
+		       mpath->exp_time -
+		       msecs_to_jiffies(sdata->u.mesh.mshcfg.path_refresh_time)) &&
+	    (!addr || ether_addr_equal(sdata->vif.addr, addr)))
+		mesh_queue_preq(mpath, PREQ_Q_F_START | PREQ_Q_F_REFRESH);
+}
+
 /**
  * mesh_nexthop_lookup - put the appropriate next hop on a mesh frame. Calling
  * this function is considered "using" the associated mpath, so preempt a path
@@ -1242,19 +1265,15 @@ int mesh_nexthop_lookup(struct ieee80211_sub_if_data *sdata,
 	if (!mpath || !(mpath->flags & MESH_PATH_ACTIVE))
 		return -ENOENT;
 
-	if (time_after(jiffies,
-		       mpath->exp_time -
-		       msecs_to_jiffies(sdata->u.mesh.mshcfg.path_refresh_time)) &&
-	    ether_addr_equal(sdata->vif.addr, hdr->addr4) &&
-	    !(mpath->flags & MESH_PATH_RESOLVING) &&
-	    !(mpath->flags & MESH_PATH_FIXED))
-		mesh_queue_preq(mpath, PREQ_Q_F_START | PREQ_Q_F_REFRESH);
+	mesh_path_refresh(sdata, mpath, hdr->addr4);
 
 	next_hop = rcu_dereference(mpath->next_hop);
 	if (next_hop) {
 		memcpy(hdr->addr1, next_hop->sta.addr, ETH_ALEN);
 		memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
 		ieee80211_mps_set_frame_flags(sdata, next_hop, hdr);
+		if (ieee80211_hw_check(&sdata->local->hw, SUPPORT_FAST_XMIT))
+			mesh_fast_tx_cache(sdata, skb, mpath);
 		return 0;
 	}
 
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 3b81e6df3f34..d32e304eeb4b 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -14,6 +14,7 @@
 #include "wme.h"
 #include "ieee80211_i.h"
 #include "mesh.h"
+#include <linux/rhashtable.h>
 
 static void mesh_path_free_rcu(struct mesh_table *tbl, struct mesh_path *mpath);
 
@@ -32,6 +33,41 @@ static const struct rhashtable_params mesh_rht_params = {
 	.hashfn = mesh_table_hash,
 };
 
+static const struct rhashtable_params fast_tx_rht_params = {
+	.nelem_hint = 10,
+	.automatic_shrinking = true,
+	.key_len = ETH_ALEN,
+	.key_offset = offsetof(struct ieee80211_mesh_fast_tx, addr_key),
+	.head_offset = offsetof(struct ieee80211_mesh_fast_tx, rhash),
+	.hashfn = mesh_table_hash,
+};
+
+static void __mesh_fast_tx_entry_free(void *ptr, void *tblptr)
+{
+	struct ieee80211_mesh_fast_tx *entry = ptr;
+
+	kfree_rcu(entry, fast_tx.rcu_head);
+}
+
+static void mesh_fast_tx_deinit(struct ieee80211_sub_if_data *sdata)
+{
+	struct mesh_tx_cache *cache;
+
+	cache = &sdata->u.mesh.tx_cache;
+	rhashtable_free_and_destroy(&cache->rht,
+				    __mesh_fast_tx_entry_free, NULL);
+}
+
+static void mesh_fast_tx_init(struct ieee80211_sub_if_data *sdata)
+{
+	struct mesh_tx_cache *cache;
+
+	cache = &sdata->u.mesh.tx_cache;
+	rhashtable_init(&cache->rht, &fast_tx_rht_params);
+	INIT_HLIST_HEAD(&cache->walk_head);
+	spin_lock_init(&cache->walk_lock);
+}
+
 static inline bool mpath_expired(struct mesh_path *mpath)
 {
 	return (mpath->flags & MESH_PATH_ACTIVE) &&
@@ -381,6 +417,243 @@ struct mesh_path *mesh_path_new(struct ieee80211_sub_if_data *sdata,
 	return new_mpath;
 }
 
+static void mesh_fast_tx_entry_free(struct mesh_tx_cache *cache,
+				    struct ieee80211_mesh_fast_tx *entry)
+{
+	hlist_del_rcu(&entry->walk_list);
+	rhashtable_remove_fast(&cache->rht, &entry->rhash, fast_tx_rht_params);
+	kfree_rcu(entry, fast_tx.rcu_head);
+}
+
+struct ieee80211_mesh_fast_tx *
+mesh_fast_tx_get(struct ieee80211_sub_if_data *sdata, const u8 *addr)
+{
+	struct ieee80211_mesh_fast_tx *entry;
+	struct mesh_tx_cache *cache;
+
+	cache = &sdata->u.mesh.tx_cache;
+	entry = rhashtable_lookup(&cache->rht, addr, fast_tx_rht_params);
+	if (!entry)
+		return NULL;
+
+	if (!(entry->mpath->flags & MESH_PATH_ACTIVE) ||
+	    mpath_expired(entry->mpath)) {
+		spin_lock_bh(&cache->walk_lock);
+		entry = rhashtable_lookup(&cache->rht, addr, fast_tx_rht_params);
+		if (entry)
+		    mesh_fast_tx_entry_free(cache, entry);
+		spin_unlock_bh(&cache->walk_lock);
+		return NULL;
+	}
+
+	mesh_path_refresh(sdata, entry->mpath, NULL);
+	if (entry->mppath)
+		entry->mppath->exp_time = jiffies;
+	entry->timestamp = jiffies;
+
+	return entry;
+}
+
+void mesh_fast_tx_cache(struct ieee80211_sub_if_data *sdata,
+			struct sk_buff *skb, struct mesh_path *mpath)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_mesh_fast_tx *entry, *prev;
+	struct ieee80211_mesh_fast_tx build = {};
+	struct ieee80211s_hdr *meshhdr;
+	struct mesh_tx_cache *cache;
+	struct ieee80211_key *key;
+	struct mesh_path *mppath;
+	struct sta_info *sta;
+	u8 *qc;
+
+	if (sdata->noack_map ||
+	    !ieee80211_is_data_qos(hdr->frame_control))
+		return;
+
+	build.fast_tx.hdr_len = ieee80211_hdrlen(hdr->frame_control);
+	meshhdr = (struct ieee80211s_hdr *)(skb->data + build.fast_tx.hdr_len);
+	build.hdrlen = ieee80211_get_mesh_hdrlen(meshhdr);
+
+	cache = &sdata->u.mesh.tx_cache;
+	if (atomic_read(&cache->rht.nelems) >= MESH_FAST_TX_CACHE_MAX_SIZE)
+		return;
+
+	sta = rcu_dereference(mpath->next_hop);
+	if (!sta)
+		return;
+
+	if ((meshhdr->flags & MESH_FLAGS_AE) == MESH_FLAGS_AE_A5_A6) {
+		/* This is required to keep the mppath alive */
+		mppath = mpp_path_lookup(sdata, meshhdr->eaddr1);
+		if (!mppath)
+			return;
+		build.mppath = mppath;
+	} else if (ieee80211_has_a4(hdr->frame_control)) {
+		mppath = mpath;
+	} else {
+		return;
+	}
+
+	/* rate limit, in case fast xmit can't be enabled */
+	if (mppath->fast_tx_check == jiffies)
+		return;
+
+	mppath->fast_tx_check = jiffies;
+
+	/*
+	 * Same use of the sta lock as in ieee80211_check_fast_xmit, in order
+	 * to protect against concurrent sta key updates.
+	 */
+	spin_lock_bh(&sta->lock);
+	key = rcu_access_pointer(sta->ptk[sta->ptk_idx]);
+	if (!key)
+		key = rcu_access_pointer(sdata->default_unicast_key);
+	build.fast_tx.key = key;
+
+	if (key) {
+		bool gen_iv, iv_spc;
+
+		gen_iv = key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_IV;
+		iv_spc = key->conf.flags & IEEE80211_KEY_FLAG_PUT_IV_SPACE;
+
+		if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) ||
+		    (key->flags & KEY_FLAG_TAINTED))
+			goto unlock_sta;
+
+		switch (key->conf.cipher) {
+		case WLAN_CIPHER_SUITE_CCMP:
+		case WLAN_CIPHER_SUITE_CCMP_256:
+			if (gen_iv)
+				build.fast_tx.pn_offs = build.fast_tx.hdr_len;
+			if (gen_iv || iv_spc)
+				build.fast_tx.hdr_len += IEEE80211_CCMP_HDR_LEN;
+			break;
+		case WLAN_CIPHER_SUITE_GCMP:
+		case WLAN_CIPHER_SUITE_GCMP_256:
+			if (gen_iv)
+				build.fast_tx.pn_offs = build.fast_tx.hdr_len;
+			if (gen_iv || iv_spc)
+				build.fast_tx.hdr_len += IEEE80211_GCMP_HDR_LEN;
+			break;
+		default:
+			goto unlock_sta;
+		}
+	}
+
+	memcpy(build.addr_key, mppath->dst, ETH_ALEN);
+	build.timestamp = jiffies;
+	build.fast_tx.band = info->band;
+	build.fast_tx.da_offs = offsetof(struct ieee80211_hdr, addr3);
+	build.fast_tx.sa_offs = offsetof(struct ieee80211_hdr, addr4);
+	build.mpath = mpath;
+	memcpy(build.hdr, meshhdr, build.hdrlen);
+	memcpy(build.hdr + build.hdrlen, rfc1042_header, sizeof(rfc1042_header));
+	build.hdrlen += sizeof(rfc1042_header);
+	memcpy(build.fast_tx.hdr, hdr, build.fast_tx.hdr_len);
+
+	hdr = (struct ieee80211_hdr *)build.fast_tx.hdr;
+	if (build.fast_tx.key)
+		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+
+	qc = ieee80211_get_qos_ctl(hdr);
+	qc[1] |= IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT >> 8;
+
+	entry = kmemdup(&build, sizeof(build), GFP_ATOMIC);
+	if (!entry)
+		goto unlock_sta;
+
+	spin_lock(&cache->walk_lock);
+	prev = rhashtable_lookup_get_insert_fast(&cache->rht,
+						 &entry->rhash,
+						 fast_tx_rht_params);
+	if (unlikely(IS_ERR(prev))) {
+		kfree(entry);
+		goto unlock_cache;
+	}
+
+	/*
+	 * replace any previous entry in the hash table, in case we're
+	 * replacing it with a different type (e.g. mpath -> mpp)
+	 */
+	if (unlikely(prev)) {
+		rhashtable_replace_fast(&cache->rht, &prev->rhash,
+					&entry->rhash, fast_tx_rht_params);
+		hlist_del_rcu(&prev->walk_list);
+		kfree_rcu(prev, fast_tx.rcu_head);
+	}
+
+	hlist_add_head(&entry->walk_list, &cache->walk_head);
+
+unlock_cache:
+	spin_unlock(&cache->walk_lock);
+unlock_sta:
+	spin_unlock_bh(&sta->lock);
+}
+
+void mesh_fast_tx_gc(struct ieee80211_sub_if_data *sdata)
+{
+	unsigned long timeout = msecs_to_jiffies(MESH_FAST_TX_CACHE_TIMEOUT);
+	struct mesh_tx_cache *cache;
+	struct ieee80211_mesh_fast_tx *entry;
+	struct hlist_node *n;
+
+	cache = &sdata->u.mesh.tx_cache;
+	if (atomic_read(&cache->rht.nelems) < MESH_FAST_TX_CACHE_THRESHOLD_SIZE)
+		return;
+
+	spin_lock_bh(&cache->walk_lock);
+	hlist_for_each_entry_safe(entry, n, &cache->walk_head, walk_list)
+		if (!time_is_after_jiffies(entry->timestamp + timeout))
+			mesh_fast_tx_entry_free(cache, entry);
+	spin_unlock_bh(&cache->walk_lock);
+}
+
+void mesh_fast_tx_flush_mpath(struct mesh_path *mpath)
+{
+	struct ieee80211_sub_if_data *sdata = mpath->sdata;
+	struct mesh_tx_cache *cache = &sdata->u.mesh.tx_cache;
+	struct ieee80211_mesh_fast_tx *entry;
+	struct hlist_node *n;
+
+	cache = &sdata->u.mesh.tx_cache;
+	spin_lock_bh(&cache->walk_lock);
+	hlist_for_each_entry_safe(entry, n, &cache->walk_head, walk_list)
+		if (entry->mpath == mpath)
+			mesh_fast_tx_entry_free(cache, entry);
+	spin_unlock_bh(&cache->walk_lock);
+}
+
+void mesh_fast_tx_flush_sta(struct ieee80211_sub_if_data *sdata,
+			    struct sta_info *sta)
+{
+	struct mesh_tx_cache *cache = &sdata->u.mesh.tx_cache;
+	struct ieee80211_mesh_fast_tx *entry;
+	struct hlist_node *n;
+
+	cache = &sdata->u.mesh.tx_cache;
+	spin_lock_bh(&cache->walk_lock);
+	hlist_for_each_entry_safe(entry, n, &cache->walk_head, walk_list)
+		if (rcu_access_pointer(entry->mpath->next_hop) == sta)
+			mesh_fast_tx_entry_free(cache, entry);
+	spin_unlock_bh(&cache->walk_lock);
+}
+
+void mesh_fast_tx_flush_addr(struct ieee80211_sub_if_data *sdata,
+			     const u8 *addr)
+{
+	struct mesh_tx_cache *cache = &sdata->u.mesh.tx_cache;
+	struct ieee80211_mesh_fast_tx *entry;
+
+	cache = &sdata->u.mesh.tx_cache;
+	spin_lock_bh(&cache->walk_lock);
+	entry = rhashtable_lookup(&cache->rht, addr, fast_tx_rht_params);
+	if (entry)
+		mesh_fast_tx_entry_free(cache, entry);
+	spin_unlock_bh(&cache->walk_lock);
+}
+
 /**
  * mesh_path_add - allocate and add a new path to the mesh path table
  * @dst: destination address of the path (ETH_ALEN length)
@@ -464,6 +737,8 @@ int mpp_path_add(struct ieee80211_sub_if_data *sdata,
 
 	if (ret)
 		kfree(new_mpath);
+	else
+		mesh_fast_tx_flush_addr(sdata, dst);
 
 	sdata->u.mesh.mpp_paths_generation++;
 	return ret;
@@ -523,6 +798,10 @@ static void __mesh_path_del(struct mesh_table *tbl, struct mesh_path *mpath)
 {
 	hlist_del_rcu(&mpath->walk_list);
 	rhashtable_remove_fast(&tbl->rhead, &mpath->rhash, mesh_rht_params);
+	if (tbl == &mpath->sdata->u.mesh.mpp_paths)
+		mesh_fast_tx_flush_addr(mpath->sdata, mpath->dst);
+	else
+		mesh_fast_tx_flush_mpath(mpath);
 	mesh_path_free_rcu(tbl, mpath);
 }
 
@@ -747,6 +1026,7 @@ void mesh_path_fix_nexthop(struct mesh_path *mpath, struct sta_info *next_hop)
 	mpath->exp_time = 0;
 	mpath->flags = MESH_PATH_FIXED | MESH_PATH_SN_VALID;
 	mesh_path_activate(mpath);
+	mesh_fast_tx_flush_mpath(mpath);
 	spin_unlock_bh(&mpath->state_lock);
 	ewma_mesh_fail_avg_init(&next_hop->mesh->fail_avg);
 	/* init it at a low value - 0 start is tricky */
@@ -758,6 +1038,7 @@ void mesh_pathtbl_init(struct ieee80211_sub_if_data *sdata)
 {
 	mesh_table_init(&sdata->u.mesh.mesh_paths);
 	mesh_table_init(&sdata->u.mesh.mpp_paths);
+	mesh_fast_tx_init(sdata);
 }
 
 static
@@ -785,6 +1066,7 @@ void mesh_path_expire(struct ieee80211_sub_if_data *sdata)
 
 void mesh_pathtbl_unregister(struct ieee80211_sub_if_data *sdata)
 {
+	mesh_fast_tx_deinit(sdata);
 	mesh_table_free(&sdata->u.mesh.mesh_paths);
 	mesh_table_free(&sdata->u.mesh.mpp_paths);
 }
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 7a37ada70684..0553ccf4831a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2761,6 +2761,7 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 	if (mesh_hdr->flags & MESH_FLAGS_AE) {
 		struct mesh_path *mppath;
 		char *proxied_addr;
+		bool update = false;
 
 		if (multicast)
 			proxied_addr = mesh_hdr->eaddr1;
@@ -2776,11 +2777,18 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 			mpp_path_add(sdata, proxied_addr, eth->h_source);
 		} else {
 			spin_lock_bh(&mppath->state_lock);
-			if (!ether_addr_equal(mppath->mpp, eth->h_source))
+			if (!ether_addr_equal(mppath->mpp, eth->h_source)) {
 				memcpy(mppath->mpp, eth->h_source, ETH_ALEN);
+				update = true;
+			}
 			mppath->exp_time = jiffies;
 			spin_unlock_bh(&mppath->state_lock);
 		}
+
+		/* flush fast xmit cache if the address path changed */
+		if (update)
+			mesh_fast_tx_flush_addr(sdata, proxied_addr);
+
 		rcu_read_unlock();
 	}
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 628d60f3db2a..ad6193693363 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3019,6 +3019,9 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	if (!ieee80211_hw_check(&local->hw, SUPPORT_FAST_XMIT))
 		return;
 
+	if (ieee80211_vif_is_mesh(&sdata->vif))
+		mesh_fast_tx_flush_sta(sdata, sta);
+
 	/* Locking here protects both the pointer itself, and against concurrent
 	 * invocations winning data access races to, e.g., the key pointer that
 	 * is used.
@@ -3371,7 +3374,8 @@ static bool ieee80211_amsdu_prepare_head(struct ieee80211_sub_if_data *sdata,
 static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 				      struct sta_info *sta,
 				      struct ieee80211_fast_tx *fast_tx,
-				      struct sk_buff *skb)
+				      struct sk_buff *skb,
+				      const u8 *da, const u8 *sa)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct fq *fq = &local->fq;
@@ -3400,6 +3404,9 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 	if (sdata->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
 		return false;
 
+	if (ieee80211_vif_is_mesh(&sdata->vif))
+		return false;
+
 	if (skb_is_gso(skb))
 		return false;
 
@@ -3484,7 +3491,8 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 
 	ret = true;
 	data = skb_push(skb, ETH_ALEN + 2);
-	memmove(data, data + ETH_ALEN + 2, 2 * ETH_ALEN);
+	ether_addr_copy(data, da);
+	ether_addr_copy(data + ETH_ALEN, sa);
 
 	data += 2 * ETH_ALEN;
 	len = cpu_to_be16(subframe_len);
@@ -3632,10 +3640,11 @@ ieee80211_tx_skb_fixup(struct sk_buff *skb, netdev_features_t features)
 	return NULL;
 }
 
-static void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
-				  struct sta_info *sta,
-				  struct ieee80211_fast_tx *fast_tx,
-				  struct sk_buff *skb, u8 tid, bool ampdu)
+void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
+			   struct sta_info *sta,
+			   struct ieee80211_fast_tx *fast_tx,
+			   struct sk_buff *skb, bool ampdu,
+			   const u8 *da, const u8 *sa)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_hdr *hdr = (void *)fast_tx->hdr;
@@ -3644,14 +3653,13 @@ static void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tx_result r;
 	int hw_headroom = sdata->local->hw.extra_tx_headroom;
 	int extra_head = fast_tx->hdr_len - (ETH_HLEN - 2);
-	struct ethhdr eth;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return;
 
 	if ((hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) &&
-	    ieee80211_amsdu_aggregate(sdata, sta, fast_tx, skb))
+	    ieee80211_amsdu_aggregate(sdata, sta, fast_tx, skb, da, sa))
 		return;
 
 	/* will not be crypto-handled beyond what we do here, so use false
@@ -3664,11 +3672,10 @@ static void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 					  ENCRYPT_NO)))
 		goto free;
 
-	memcpy(&eth, skb->data, ETH_HLEN - 2);
 	hdr = skb_push(skb, extra_head);
 	memcpy(skb->data, fast_tx->hdr, fast_tx->hdr_len);
-	memcpy(skb->data + fast_tx->da_offs, eth.h_dest, ETH_ALEN);
-	memcpy(skb->data + fast_tx->sa_offs, eth.h_source, ETH_ALEN);
+	memcpy(skb->data + fast_tx->da_offs, da, ETH_ALEN);
+	memcpy(skb->data + fast_tx->sa_offs, sa, ETH_ALEN);
 
 	info = IEEE80211_SKB_CB(skb);
 	memset(info, 0, sizeof(*info));
@@ -3686,7 +3693,8 @@ static void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 #endif
 
 	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
-		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+		u8 tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+
 		*ieee80211_get_qos_ctl(hdr) = tid;
 	}
 
@@ -3729,6 +3737,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_hdr *hdr = (void *)fast_tx->hdr;
 	struct tid_ampdu_tx *tid_tx = NULL;
 	struct sk_buff *next;
+	struct ethhdr eth;
 	u8 tid = IEEE80211_NUM_TIDS;
 
 	/* control port protocol needs a lot of special handling */
@@ -3754,6 +3763,8 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
+	memcpy(&eth, skb->data, ETH_HLEN - 2);
+
 	/* after this point (skb is modified) we cannot return false */
 	skb = ieee80211_tx_skb_fixup(skb, ieee80211_sdata_netdev_features(sdata));
 	if (!skb)
@@ -3761,7 +3772,8 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 
 	skb_list_walk_safe(skb, skb, next) {
 		skb_mark_not_on_list(skb);
-		__ieee80211_xmit_fast(sdata, sta, fast_tx, skb, tid, tid_tx);
+		__ieee80211_xmit_fast(sdata, sta, fast_tx, skb, tid_tx,
+				      eth.h_dest, eth.h_source);
 	}
 
 	return true;
@@ -4245,8 +4257,15 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 		return;
 	}
 
+	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
+
 	rcu_read_lock();
 
+	if (ieee80211_vif_is_mesh(&sdata->vif) &&
+	    ieee80211_hw_check(&local->hw, SUPPORT_FAST_XMIT) &&
+	    ieee80211_mesh_xmit_fast(sdata, skb, ctrl_flags))
+		goto out;
+
 	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
 		goto out_free;
 
@@ -4256,8 +4275,6 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));
 	ieee80211_aggr_check(sdata, sta, skb);
 
-	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
-
 	if (sta) {
 		struct ieee80211_fast_tx *fast_tx;
 
-- 
2.39.0


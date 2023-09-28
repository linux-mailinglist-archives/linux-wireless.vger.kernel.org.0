Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6237B1FBF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjI1OgQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjI1OgO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753521AA
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911771; x=1727447771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTafyIa/UKcwKrpCtVtIRyV271QXQwit/xtVQecaELM=;
  b=Xm7y6GTSA1en5qRuEix74gWetjNBSVPFS1netWX/6FeW/e63Y7KxJnGs
   92cMnyo/iInWIsToK7A30awtAOsJ2By5v8EDJIf/zW6q7AmhXqwxPeL4D
   oX5n/4ZXeT0sMOpF3zJ5434GyCHOm8SC6zK1iT9PexNi3MIeoVfFmTTut
   lSwjB+Os5i3PJPClBQlP/WRwbgm7UB1jdiOqQBz5fdiQhhLhEOIZuamQ8
   PGqWfP9EdarpDuQ271kVH33N13fgBGqNZ8MPP3554ELPO/L0xRhfyR+6e
   31sdQixoFCK/wu6IUytOXTxWFxTkc+TkP3DjmUSTw+EjEerfwFSrpd09j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688446"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688446"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590435"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590435"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/18] wifi: mac80211: mesh: fix some kdoc warnings
Date:   Thu, 28 Sep 2023 17:35:29 +0300
Message-Id: <20230928172905.33fea2968c62.I41d197b570370ab7cad1405518512fdd36e08717@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

These were mostly missing or incorrectly tagged return values.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mesh.c         |  8 ++++++--
 net/mac80211/mesh_hwmp.c    |  2 ++
 net/mac80211/mesh_pathtbl.c | 20 +++++++++++++-------
 net/mac80211/mesh_plink.c   |  6 +++++-
 net/mac80211/mesh_ps.c      |  6 +++++-
 net/mac80211/mesh_sync.c    |  4 +++-
 6 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 0d0fbae51b61..9b1fd43df6ef 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -56,6 +56,8 @@ static void ieee80211_mesh_housekeeping_timer(struct timer_list *t)
  *
  * This function checks if the mesh configuration of a mesh point matches the
  * local mesh configuration, i.e. if both nodes belong to the same mesh network.
+ *
+ * Returns: %true if both nodes belong to the same mesh
  */
 bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 			struct ieee802_11_elems *ie)
@@ -119,6 +121,8 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
  * mesh_peer_accepts_plinks - check if an mp is willing to establish peer links
  *
  * @ie: information elements of a management frame from the mesh peer
+ *
+ * Returns: %true if the mesh peer is willing to establish peer links
  */
 bool mesh_peer_accepts_plinks(struct ieee802_11_elems *ie)
 {
@@ -858,7 +862,7 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
  * @meshsa:	source address in the mesh.  Same as TA, as frame is
  *              locally originated.
  *
- * Return the length of the 802.11 (does not include a mesh control header)
+ * Returns: the length of the 802.11 frame header (excludes mesh control header)
  */
 int ieee80211_fill_mesh_addresses(struct ieee80211_hdr *hdr, __le16 *fc,
 				  const u8 *meshda, const u8 *meshsa)
@@ -891,7 +895,7 @@ int ieee80211_fill_mesh_addresses(struct ieee80211_hdr *hdr, __le16 *fc,
  * @addr6:	2nd address in the ae header, which corresponds to addr6 of the
  *              mesh frame
  *
- * Return the header length.
+ * Returns: the header length
  */
 unsigned int ieee80211_new_mesh_header(struct ieee80211_sub_if_data *sdata,
 				       struct ieee80211s_hdr *meshhdr,
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 51369072984e..775d52561c54 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -230,6 +230,8 @@ static void prepare_frame_for_deferred_tx(struct ieee80211_sub_if_data *sdata,
  * Note: This function may be called with driver locks taken that the driver
  * also acquires in the TX path.  To avoid a deadlock we don't transmit the
  * frame directly but add it to the pending queue instead.
+ *
+ * Returns: 0 on success
  */
 int mesh_path_error_tx(struct ieee80211_sub_if_data *sdata,
 		       u8 ttl, const u8 *target, u32 target_sn,
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 3e52aaa57b1f..8a3f44ce3e04 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
+ * Copyright (C) 2023 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 
@@ -173,6 +174,11 @@ static void prepare_for_gate(struct sk_buff *skb, char *dst_addr,
 /**
  * mesh_path_move_to_queue - Move or copy frames from one mpath queue to another
  *
+ * @gate_mpath: An active mpath the frames will be sent to (i.e. the gate)
+ * @from_mpath: The failed mpath
+ * @copy: When true, copy all the frames to the new mpath queue.  When false,
+ * move them.
+ *
  * This function is used to transfer or copy frames from an unresolved mpath to
  * a gate mpath.  The function also adds the Address Extension field and
  * updates the next hop.
@@ -181,11 +187,6 @@ static void prepare_for_gate(struct sk_buff *skb, char *dst_addr,
  * destination addresses are updated.
  *
  * The gate mpath must be an active mpath with a valid mpath->next_hop.
- *
- * @gate_mpath: An active mpath the frames will be sent to (i.e. the gate)
- * @from_mpath: The failed mpath
- * @copy: When true, copy all the frames to the new mpath queue.  When false,
- * move them.
  */
 static void mesh_path_move_to_queue(struct mesh_path *gate_mpath,
 				    struct mesh_path *from_mpath,
@@ -330,6 +331,8 @@ mpp_path_lookup_by_idx(struct ieee80211_sub_if_data *sdata, int idx)
 /**
  * mesh_path_add_gate - add the given mpath to a mesh gate to our path table
  * @mpath: gate path to add to table
+ *
+ * Returns: 0 on success, -EEXIST
  */
 int mesh_path_add_gate(struct mesh_path *mpath)
 {
@@ -388,6 +391,8 @@ static void mesh_gate_del(struct mesh_table *tbl, struct mesh_path *mpath)
 /**
  * mesh_gate_num - number of gates known to this interface
  * @sdata: subif data
+ *
+ * Returns: The number of gates
  */
 int mesh_gate_num(struct ieee80211_sub_if_data *sdata)
 {
@@ -861,10 +866,9 @@ static void table_flush_by_iface(struct mesh_table *tbl)
 /**
  * mesh_path_flush_by_iface - Deletes all mesh paths associated with a given iface
  *
- * This function deletes both mesh paths as well as mesh portal paths.
- *
  * @sdata: interface data to match
  *
+ * This function deletes both mesh paths as well as mesh portal paths.
  */
 void mesh_path_flush_by_iface(struct ieee80211_sub_if_data *sdata)
 {
@@ -944,6 +948,8 @@ void mesh_path_tx_pending(struct mesh_path *mpath)
  * queue to that gate's queue.  If there are more than one gates, the frames
  * are copied from each gate to the next.  After frames are copied, the
  * mpath queues are emptied onto the transmission queue.
+ *
+ * Returns: 0 on success, -EHOSTUNREACH
  */
 int mesh_path_send_to_gates(struct mesh_path *mpath)
 {
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index a1e526419e9d..dbabeefe4515 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -153,6 +153,8 @@ static u64 mesh_set_short_slot_time(struct ieee80211_sub_if_data *sdata)
  * selected if any non-HT peers are present in our MBSS.  20MHz-protection mode
  * is selected if all peers in our 20/40MHz MBSS support HT and at least one
  * HT20 peer is present. Otherwise no-protection mode is selected.
+ *
+ * Returns: BSS_CHANGED_HT or 0 for no change
  */
 static u64 mesh_set_ht_prot_mode(struct ieee80211_sub_if_data *sdata)
 {
@@ -362,7 +364,7 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
  * Mesh paths with this peer as next hop should be flushed
  * by the caller outside of plink_lock.
  *
- * Returns beacon changed flag if the beacon content changed.
+ * Returns: beacon changed flag if the beacon content changed.
  *
  * Locking: the caller must hold sta->mesh->plink_lock
  */
@@ -390,6 +392,8 @@ static u64 __mesh_plink_deactivate(struct sta_info *sta)
  * @sta: mesh peer link to deactivate
  *
  * All mesh paths with this peer as next hop will be flushed
+ *
+ * Returns: beacon changed flag if the beacon content changed.
  */
 u64 mesh_plink_deactivate(struct sta_info *sta)
 {
diff --git a/net/mac80211/mesh_ps.c b/net/mac80211/mesh_ps.c
index 35eacca43e49..20e022a03933 100644
--- a/net/mac80211/mesh_ps.c
+++ b/net/mac80211/mesh_ps.c
@@ -15,6 +15,8 @@
 /**
  * mps_qos_null_get - create pre-addressed QoS Null frame for mesh powersave
  * @sta: the station to get the frame for
+ *
+ * Returns: A newly allocated SKB
  */
 static struct sk_buff *mps_qos_null_get(struct sta_info *sta)
 {
@@ -77,6 +79,8 @@ static void mps_qos_null_tx(struct sta_info *sta)
  *
  * sets the non-peer power mode and triggers the driver PS (re-)configuration
  * Return BSS_CHANGED_BEACON if a beacon update is necessary.
+ *
+ * Returns: BSS_CHANGED_BEACON if a beacon update is in order.
  */
 u64 ieee80211_mps_local_status_update(struct ieee80211_sub_if_data *sdata)
 {
@@ -147,7 +151,7 @@ u64 ieee80211_mps_local_status_update(struct ieee80211_sub_if_data *sdata)
  *
  * @sta: mesh STA
  * @pm: the power mode to set
- * Return BSS_CHANGED_BEACON if a beacon update is in order.
+ * Returns: BSS_CHANGED_BEACON if a beacon update is in order.
  */
 u64 ieee80211_mps_set_sta_local_pm(struct sta_info *sta,
 				   enum nl80211_mesh_power_mode pm)
diff --git a/net/mac80211/mesh_sync.c b/net/mac80211/mesh_sync.c
index 9e342cc2504c..8cf3f395f52f 100644
--- a/net/mac80211/mesh_sync.c
+++ b/net/mac80211/mesh_sync.c
@@ -3,7 +3,7 @@
  * Copyright 2011-2012, Pavel Zubarev <pavel.zubarev@gmail.com>
  * Copyright 2011-2012, Marco Porsch <marco.porsch@s2005.tu-chemnitz.de>
  * Copyright 2011-2012, cozybit Inc.
- * Copyright (C) 2021 Intel Corporation
+ * Copyright (C) 2021,2023 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -37,6 +37,8 @@ struct sync_method {
  * mesh_peer_tbtt_adjusting - check if an mp is currently adjusting its TBTT
  *
  * @cfg: mesh config element from the mesh peer (or %NULL)
+ *
+ * Returns: If the mesh peer is currently adjusting its TBTT
  */
 static bool mesh_peer_tbtt_adjusting(const struct ieee80211_meshconf_ie *cfg)
 {
-- 
2.38.1


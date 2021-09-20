Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD904115F4
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbhITNlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbhITNln (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 09:41:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9BC061767
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LVAqN2lv7SFizBRooD8GRAr2WsIakEro5rdAGjJosho=;
        t=1632145216; x=1633354816; b=Cszdyq28kXrzTRW7CLPatkTKX6hV5SzQ/LmnJ030jdE+UC/
        Vu0odaFHLYVA1HyuiPyqosRWclwronH110+9jnM4ynaVmUCqhoq2tSsKCu2bWDJzrCMBz/8a308H3
        Ps+lKwxSZH3WEbXGUK/fUrn5+ZZSAyasg5xo3iuaRdAFtfiPjI2cvlJ6RqZJFHLwf1jruJZPvvzja
        KqoF+ukQgDZJCWIKK+YyuNOZQ2SnrcQAgnhkZw4IgfLfDlCBg8lK9jGHS1JOG+S15Zwy39QYAq9sF
        BMW74ID7kU75qdVGenfaq7CA3N4dcZtGWL56+4EaVBQ8O00M9Y7/3kuR3WWFi/4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mSJWo-009SO7-CD;
        Mon, 20 Sep 2021 15:40:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 6/6] mac80211: always allocate struct ieee802_11_elems
Date:   Mon, 20 Sep 2021 15:40:10 +0200
Message-Id: <20210920154009.26caff6b5998.I05ae58768e990e611aee8eca8abefd9d7bc15e05@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920154009.3110ff75be0c.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
References: <20210920154009.3110ff75be0c.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

As the 802.11 spec evolves, we need to parse more and more
elements. This is causing the struct to grow, and we can no
longer get away with putting it on the stack.

Change the API to always dynamically allocate and return an
allocated pointer that must be kfree()d later.

As an alternative, I contemplated a scheme whereby we'd say
in the code which elements we needed, e.g.

    DECLARE_ELEMENT_PARSER(elems,
                           SUPPORTED_CHANNELS,
                           CHANNEL_SWITCH,
                           EXT(KEY_DELIVERY));

    ieee802_11_parse_elems(..., &elems, ...);

and while I think this is possible and will save us a lot
since most individual places only care about a small subset
of the elements, it ended up being a bit more work since a
lot of places do the parsing and then pass the struct to
other functions, sometimes with multiple levels.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c      |  11 +--
 net/mac80211/ibss.c        |  25 +++---
 net/mac80211/ieee80211_i.h |  22 ++---
 net/mac80211/mesh.c        |  85 ++++++++++--------
 net/mac80211/mesh_hwmp.c   |  44 +++++-----
 net/mac80211/mesh_plink.c  |  11 +--
 net/mac80211/mlme.c        | 176 +++++++++++++++++++++----------------
 net/mac80211/scan.c        |  16 ++--
 net/mac80211/tdls.c        |  63 +++++++------
 net/mac80211/util.c        |  20 +++--
 10 files changed, 272 insertions(+), 201 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index cce28e3b2232..94c65def102c 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -477,7 +477,7 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 				     size_t len)
 {
 	u16 capab, tid, timeout, ba_policy, buf_size, start_seq_num;
-	struct ieee802_11_elems elems = { };
+	struct ieee802_11_elems *elems = NULL;
 	u8 dialog_token;
 	int ies_len;
 
@@ -495,16 +495,17 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 	ies_len = len - offsetof(struct ieee80211_mgmt,
 				 u.action.u.addba_req.variable);
 	if (ies_len) {
-		ieee802_11_parse_elems(mgmt->u.action.u.addba_req.variable,
-                                ies_len, true, &elems, mgmt->bssid, NULL);
-		if (elems.parse_error)
+		elems = ieee802_11_parse_elems(mgmt->u.action.u.addba_req.variable,
+					       ies_len, true, mgmt->bssid, NULL);
+		if (!elems || elems->parse_error)
 			return;
 	}
 
 	__ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
 					start_seq_num, ba_policy, tid,
 					buf_size, true, false,
-					elems.addba_ext_ie);
+					elems ? elems->addba_ext_ie : NULL);
+	kfree(elems);
 }
 
 void ieee80211_manage_rx_ba_offl(struct ieee80211_vif *vif,
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 5d6ca4c3e698..66b00046f0c2 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -9,7 +9,7 @@
  * Copyright 2009, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2016 Intel Deutschland GmbH
- * Copyright(c) 2018-2020 Intel Corporation
+ * Copyright(c) 2018-2021 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -1589,7 +1589,7 @@ void ieee80211_rx_mgmt_probe_beacon(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_rx_status *rx_status)
 {
 	size_t baselen;
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 
 	BUILD_BUG_ON(offsetof(typeof(mgmt->u.probe_resp), variable) !=
 		     offsetof(typeof(mgmt->u.beacon), variable));
@@ -1602,10 +1602,14 @@ void ieee80211_rx_mgmt_probe_beacon(struct ieee80211_sub_if_data *sdata,
 	if (baselen > len)
 		return;
 
-	ieee802_11_parse_elems(mgmt->u.probe_resp.variable, len - baselen,
-			       false, &elems, mgmt->bssid, NULL);
+	elems = ieee802_11_parse_elems(mgmt->u.probe_resp.variable,
+				       len - baselen, false,
+				       mgmt->bssid, NULL);
 
-	ieee80211_rx_bss_info(sdata, mgmt, len, rx_status, &elems);
+	if (elems) {
+		ieee80211_rx_bss_info(sdata, mgmt, len, rx_status, elems);
+		kfree(elems);
+	}
 }
 
 void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
@@ -1614,7 +1618,7 @@ void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_mgmt *mgmt;
 	u16 fc;
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 	int ies_len;
 
 	rx_status = IEEE80211_SKB_RXCB(skb);
@@ -1651,15 +1655,16 @@ void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 			if (ies_len < 0)
 				break;
 
-			ieee802_11_parse_elems(
+			elems = ieee802_11_parse_elems(
 				mgmt->u.action.u.chan_switch.variable,
-				ies_len, true, &elems, mgmt->bssid, NULL);
+				ies_len, true, mgmt->bssid, NULL);
 
-			if (elems.parse_error)
+			if (!elems || elems->parse_error)
 				break;
 
 			ieee80211_rx_mgmt_spectrum_mgmt(sdata, mgmt, skb->len,
-							rx_status, &elems);
+							rx_status, elems);
+			kfree(elems);
 			break;
 		}
 	}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7a9e529f8366..c3b8590a7e90 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2192,18 +2192,18 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tx_skb_tid(sdata, skb, 7);
 }
 
-void ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
-				struct ieee802_11_elems *elems,
-				u64 filter, u32 crc, u8 *transmitter_bssid,
-				u8 *bss_bssid);
-static inline void ieee802_11_parse_elems(const u8 *start, size_t len,
-					  bool action,
-					  struct ieee802_11_elems *elems,
-					  u8 *transmitter_bssid,
-					  u8 *bss_bssid)
+struct ieee802_11_elems *ieee802_11_parse_elems_crc(const u8 *start, size_t len,
+						    bool action,
+						    u64 filter, u32 crc,
+						    const u8 *transmitter_bssid,
+						    const u8 *bss_bssid);
+static inline struct ieee802_11_elems *
+ieee802_11_parse_elems(const u8 *start, size_t len, bool action,
+		       const u8 *transmitter_bssid,
+		       const u8 *bss_bssid)
 {
-	ieee802_11_parse_elems_crc(start, len, action, elems, 0, 0,
-				   transmitter_bssid, bss_bssid);
+	return ieee802_11_parse_elems_crc(start, len, action, 0, 0,
+					  transmitter_bssid, bss_bssid);
 }
 
 
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 65e9335b3614..a4212a333d61 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1246,7 +1246,7 @@ ieee80211_mesh_rx_probe_req(struct ieee80211_sub_if_data *sdata,
 	struct sk_buff *presp;
 	struct beacon_data *bcn;
 	struct ieee80211_mgmt *hdr;
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 	size_t baselen;
 	u8 *pos;
 
@@ -1255,22 +1255,24 @@ ieee80211_mesh_rx_probe_req(struct ieee80211_sub_if_data *sdata,
 	if (baselen > len)
 		return;
 
-	ieee802_11_parse_elems(pos, len - baselen, false, &elems, mgmt->bssid,
-			       NULL);
-
-	if (!elems.mesh_id)
+	elems = ieee802_11_parse_elems(pos, len - baselen, false, mgmt->bssid,
+				       NULL);
+	if (!elems)
 		return;
 
+	if (!elems->mesh_id)
+		goto free;
+
 	/* 802.11-2012 10.1.4.3.2 */
 	if ((!ether_addr_equal(mgmt->da, sdata->vif.addr) &&
 	     !is_broadcast_ether_addr(mgmt->da)) ||
-	    elems.ssid_len != 0)
-		return;
+	    elems->ssid_len != 0)
+		goto free;
 
-	if (elems.mesh_id_len != 0 &&
-	    (elems.mesh_id_len != ifmsh->mesh_id_len ||
-	     memcmp(elems.mesh_id, ifmsh->mesh_id, ifmsh->mesh_id_len)))
-		return;
+	if (elems->mesh_id_len != 0 &&
+	    (elems->mesh_id_len != ifmsh->mesh_id_len ||
+	     memcmp(elems->mesh_id, ifmsh->mesh_id, ifmsh->mesh_id_len)))
+		goto free;
 
 	rcu_read_lock();
 	bcn = rcu_dereference(ifmsh->beacon);
@@ -1294,6 +1296,8 @@ ieee80211_mesh_rx_probe_req(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tx_skb(sdata, presp);
 out:
 	rcu_read_unlock();
+free:
+	kfree(elems);
 }
 
 static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
@@ -1304,7 +1308,7 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 	struct ieee80211_channel *channel;
 	size_t baselen;
 	int freq;
@@ -1319,42 +1323,47 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 	if (baselen > len)
 		return;
 
-	ieee802_11_parse_elems(mgmt->u.probe_resp.variable, len - baselen,
-			       false, &elems, mgmt->bssid, NULL);
+	elems = ieee802_11_parse_elems(mgmt->u.probe_resp.variable,
+				       len - baselen,
+				       false, mgmt->bssid, NULL);
+	if (!elems)
+		return;
 
 	/* ignore non-mesh or secure / unsecure mismatch */
-	if ((!elems.mesh_id || !elems.mesh_config) ||
-	    (elems.rsn && sdata->u.mesh.security == IEEE80211_MESH_SEC_NONE) ||
-	    (!elems.rsn && sdata->u.mesh.security != IEEE80211_MESH_SEC_NONE))
-		return;
+	if ((!elems->mesh_id || !elems->mesh_config) ||
+	    (elems->rsn && sdata->u.mesh.security == IEEE80211_MESH_SEC_NONE) ||
+	    (!elems->rsn && sdata->u.mesh.security != IEEE80211_MESH_SEC_NONE))
+		goto free;
 
-	if (elems.ds_params)
-		freq = ieee80211_channel_to_frequency(elems.ds_params[0], band);
+	if (elems->ds_params)
+		freq = ieee80211_channel_to_frequency(elems->ds_params[0], band);
 	else
 		freq = rx_status->freq;
 
 	channel = ieee80211_get_channel(local->hw.wiphy, freq);
 
 	if (!channel || channel->flags & IEEE80211_CHAN_DISABLED)
-		return;
+		goto free;
 
-	if (mesh_matches_local(sdata, &elems)) {
+	if (mesh_matches_local(sdata, elems)) {
 		mpl_dbg(sdata, "rssi_threshold=%d,rx_status->signal=%d\n",
 			sdata->u.mesh.mshcfg.rssi_threshold, rx_status->signal);
 		if (!sdata->u.mesh.user_mpm ||
 		    sdata->u.mesh.mshcfg.rssi_threshold == 0 ||
 		    sdata->u.mesh.mshcfg.rssi_threshold < rx_status->signal)
-			mesh_neighbour_update(sdata, mgmt->sa, &elems,
+			mesh_neighbour_update(sdata, mgmt->sa, elems,
 					      rx_status);
 
 		if (ifmsh->csa_role != IEEE80211_MESH_CSA_ROLE_INIT &&
 		    !sdata->vif.csa_active)
-			ieee80211_mesh_process_chnswitch(sdata, &elems, true);
+			ieee80211_mesh_process_chnswitch(sdata, elems, true);
 	}
 
 	if (ifmsh->sync_ops)
 		ifmsh->sync_ops->rx_bcn_presp(sdata, stype, mgmt, len,
-					      elems.mesh_config, rx_status);
+					      elems->mesh_config, rx_status);
+free:
+	kfree(elems);
 }
 
 int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
@@ -1446,7 +1455,7 @@ static void mesh_rx_csa_frame(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_mgmt *mgmt, size_t len)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 	u16 pre_value;
 	bool fwd_csa = true;
 	size_t baselen;
@@ -1459,33 +1468,37 @@ static void mesh_rx_csa_frame(struct ieee80211_sub_if_data *sdata,
 	pos = mgmt->u.action.u.chan_switch.variable;
 	baselen = offsetof(struct ieee80211_mgmt,
 			   u.action.u.chan_switch.variable);
-	ieee802_11_parse_elems(pos, len - baselen, true, &elems,
-			       mgmt->bssid, NULL);
-
-	if (!mesh_matches_local(sdata, &elems))
+	elems = ieee802_11_parse_elems(pos, len - baselen, true,
+				       mgmt->bssid, NULL);
+	if (!elems)
 		return;
 
-	ifmsh->chsw_ttl = elems.mesh_chansw_params_ie->mesh_ttl;
+	if (!mesh_matches_local(sdata, elems))
+		goto free;
+
+	ifmsh->chsw_ttl = elems->mesh_chansw_params_ie->mesh_ttl;
 	if (!--ifmsh->chsw_ttl)
 		fwd_csa = false;
 
-	pre_value = le16_to_cpu(elems.mesh_chansw_params_ie->mesh_pre_value);
+	pre_value = le16_to_cpu(elems->mesh_chansw_params_ie->mesh_pre_value);
 	if (ifmsh->pre_value >= pre_value)
-		return;
+		goto free;
 
 	ifmsh->pre_value = pre_value;
 
 	if (!sdata->vif.csa_active &&
-	    !ieee80211_mesh_process_chnswitch(sdata, &elems, false)) {
+	    !ieee80211_mesh_process_chnswitch(sdata, elems, false)) {
 		mcsa_dbg(sdata, "Failed to process CSA action frame");
-		return;
+		goto free;
 	}
 
 	/* forward or re-broadcast the CSA frame */
 	if (fwd_csa) {
-		if (mesh_fwd_csa_frame(sdata, mgmt, len, &elems) < 0)
+		if (mesh_fwd_csa_frame(sdata, mgmt, len, elems) < 0)
 			mcsa_dbg(sdata, "Failed to forward the CSA frame");
 	}
+free:
+	kfree(elems);
 }
 
 static void ieee80211_mesh_rx_mgmt_action(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index a05b615deb51..44a6fdb6efbd 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019, 2021 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 
@@ -908,7 +908,7 @@ static void hwmp_rann_frame_process(struct ieee80211_sub_if_data *sdata,
 void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 			    struct ieee80211_mgmt *mgmt, size_t len)
 {
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 	size_t baselen;
 	u32 path_metric;
 	struct sta_info *sta;
@@ -926,37 +926,41 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 	rcu_read_unlock();
 
 	baselen = (u8 *) mgmt->u.action.u.mesh_action.variable - (u8 *) mgmt;
-	ieee802_11_parse_elems(mgmt->u.action.u.mesh_action.variable,
-			       len - baselen, false, &elems, mgmt->bssid, NULL);
+	elems = ieee802_11_parse_elems(mgmt->u.action.u.mesh_action.variable,
+				       len - baselen, false, mgmt->bssid, NULL);
+	if (!elems)
+		return;
 
-	if (elems.preq) {
-		if (elems.preq_len != 37)
+	if (elems->preq) {
+		if (elems->preq_len != 37)
 			/* Right now we support just 1 destination and no AE */
-			return;
-		path_metric = hwmp_route_info_get(sdata, mgmt, elems.preq,
+			goto free;
+		path_metric = hwmp_route_info_get(sdata, mgmt, elems->preq,
 						  MPATH_PREQ);
 		if (path_metric)
-			hwmp_preq_frame_process(sdata, mgmt, elems.preq,
+			hwmp_preq_frame_process(sdata, mgmt, elems->preq,
 						path_metric);
 	}
-	if (elems.prep) {
-		if (elems.prep_len != 31)
+	if (elems->prep) {
+		if (elems->prep_len != 31)
 			/* Right now we support no AE */
-			return;
-		path_metric = hwmp_route_info_get(sdata, mgmt, elems.prep,
+			goto free;
+		path_metric = hwmp_route_info_get(sdata, mgmt, elems->prep,
 						  MPATH_PREP);
 		if (path_metric)
-			hwmp_prep_frame_process(sdata, mgmt, elems.prep,
+			hwmp_prep_frame_process(sdata, mgmt, elems->prep,
 						path_metric);
 	}
-	if (elems.perr) {
-		if (elems.perr_len != 15)
+	if (elems->perr) {
+		if (elems->perr_len != 15)
 			/* Right now we support only one destination per PERR */
-			return;
-		hwmp_perr_frame_process(sdata, mgmt, elems.perr);
+			goto free;
+		hwmp_perr_frame_process(sdata, mgmt, elems->perr);
 	}
-	if (elems.rann)
-		hwmp_rann_frame_process(sdata, mgmt, elems.rann);
+	if (elems->rann)
+		hwmp_rann_frame_process(sdata, mgmt, elems->rann);
+free:
+	kfree(elems);
 }
 
 /**
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index a6915847d78a..a829470dd59e 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019, 2021 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 #include <linux/gfp.h>
@@ -1200,7 +1200,7 @@ void mesh_rx_plink_frame(struct ieee80211_sub_if_data *sdata,
 			 struct ieee80211_mgmt *mgmt, size_t len,
 			 struct ieee80211_rx_status *rx_status)
 {
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 	size_t baselen;
 	u8 *baseaddr;
 
@@ -1228,7 +1228,8 @@ void mesh_rx_plink_frame(struct ieee80211_sub_if_data *sdata,
 		if (baselen > len)
 			return;
 	}
-	ieee802_11_parse_elems(baseaddr, len - baselen, true, &elems,
-			       mgmt->bssid, NULL);
-	mesh_process_plink_frame(sdata, mgmt, &elems, rx_status);
+	elems = ieee802_11_parse_elems(baseaddr, len - baselen, true,
+				       mgmt->bssid, NULL);
+	mesh_process_plink_frame(sdata, mgmt, elems, rx_status);
+	kfree(elems);
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e18bd07f6822..e80f3388b0c5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3291,8 +3291,11 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		aid = 0; /* TODO */
 	}
 	capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
-	ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false, elems,
-			       mgmt->bssid, assoc_data->bss->bssid);
+	elems = ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false,
+				       mgmt->bssid, assoc_data->bss->bssid);
+
+	if (!elems)
+		return false;
 
 	if (elems->aid_resp)
 		aid = le16_to_cpu(elems->aid_resp->aid);
@@ -3314,7 +3317,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 	if (!is_s1g && !elems->supp_rates) {
 		sdata_info(sdata, "no SuppRates element in AssocResp\n");
-		return false;
+		ret = false;
+		goto out;
 	}
 
 	sdata->vif.bss_conf.aid = aid;
@@ -3336,7 +3340,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	     (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
-		struct ieee802_11_elems bss_elems;
+		struct ieee802_11_elems *bss_elems;
 
 		rcu_read_lock();
 		ies = rcu_dereference(cbss->ies);
@@ -3347,13 +3351,17 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		if (!bss_ies)
 			return false;
 
-		ieee802_11_parse_elems(bss_ies->data, bss_ies->len,
-				       false, &bss_elems,
-				       mgmt->bssid,
-				       assoc_data->bss->bssid);
+		bss_elems = ieee802_11_parse_elems(bss_ies->data, bss_ies->len,
+						   false, mgmt->bssid,
+						   assoc_data->bss->bssid);
+		if (!bss_elems) {
+			ret = false;
+			goto out;
+		}
+
 		if (assoc_data->wmm &&
-		    !elems->wmm_param && bss_elems.wmm_param) {
-			elems->wmm_param = bss_elems.wmm_param;
+		    !elems->wmm_param && bss_elems->wmm_param) {
+			elems->wmm_param = bss_elems->wmm_param;
 			sdata_info(sdata,
 				   "AP bug: WMM param missing from AssocResp\n");
 		}
@@ -3362,30 +3370,32 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		 * Also check if we requested HT/VHT, otherwise the AP doesn't
 		 * have to include the IEs in the (re)association response.
 		 */
-		if (!elems->ht_cap_elem && bss_elems.ht_cap_elem &&
+		if (!elems->ht_cap_elem && bss_elems->ht_cap_elem &&
 		    !(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
-			elems->ht_cap_elem = bss_elems.ht_cap_elem;
+			elems->ht_cap_elem = bss_elems->ht_cap_elem;
 			sdata_info(sdata,
 				   "AP bug: HT capability missing from AssocResp\n");
 		}
-		if (!elems->ht_operation && bss_elems.ht_operation &&
+		if (!elems->ht_operation && bss_elems->ht_operation &&
 		    !(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
-			elems->ht_operation = bss_elems.ht_operation;
+			elems->ht_operation = bss_elems->ht_operation;
 			sdata_info(sdata,
 				   "AP bug: HT operation missing from AssocResp\n");
 		}
-		if (!elems->vht_cap_elem && bss_elems.vht_cap_elem &&
+		if (!elems->vht_cap_elem && bss_elems->vht_cap_elem &&
 		    !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT)) {
-			elems->vht_cap_elem = bss_elems.vht_cap_elem;
+			elems->vht_cap_elem = bss_elems->vht_cap_elem;
 			sdata_info(sdata,
 				   "AP bug: VHT capa missing from AssocResp\n");
 		}
-		if (!elems->vht_operation && bss_elems.vht_operation &&
+		if (!elems->vht_operation && bss_elems->vht_operation &&
 		    !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT)) {
-			elems->vht_operation = bss_elems.vht_operation;
+			elems->vht_operation = bss_elems->vht_operation;
 			sdata_info(sdata,
 				   "AP bug: VHT operation missing from AssocResp\n");
 		}
+
+		kfree(bss_elems);
 	}
 
 	/*
@@ -3630,6 +3640,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 	ret = true;
  out:
+	kfree(elems);
 	kfree(bss_ies);
 	return ret;
 }
@@ -3641,7 +3652,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
 	u16 capab_info, status_code, aid;
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 	int ac, uapsd_queues = -1;
 	u8 *pos;
 	bool reassoc;
@@ -3698,14 +3709,16 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	    fils_decrypt_assoc_resp(sdata, (u8 *)mgmt, &len, assoc_data) < 0)
 		return;
 
-	ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false, &elems,
-			       mgmt->bssid, assoc_data->bss->bssid);
+	elems = ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false,
+				       mgmt->bssid, assoc_data->bss->bssid);
+	if (!elems)
+		goto notify_driver;
 
 	if (status_code == WLAN_STATUS_ASSOC_REJECTED_TEMPORARILY &&
-	    elems.timeout_int &&
-	    elems.timeout_int->type == WLAN_TIMEOUT_ASSOC_COMEBACK) {
+	    elems->timeout_int &&
+	    elems->timeout_int->type == WLAN_TIMEOUT_ASSOC_COMEBACK) {
 		u32 tu, ms;
-		tu = le32_to_cpu(elems.timeout_int->value);
+		tu = le32_to_cpu(elems->timeout_int->value);
 		ms = tu * 1024 / 1000;
 		sdata_info(sdata,
 			   "%pM rejected association temporarily; comeback duration %u TU (%u ms)\n",
@@ -3725,7 +3738,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		event.u.mlme.reason = status_code;
 		drv_event_callback(sdata->local, sdata, &event);
 	} else {
-		if (!ieee80211_assoc_success(sdata, cbss, mgmt, len, &elems)) {
+		if (!ieee80211_assoc_success(sdata, cbss, mgmt, len, elems)) {
 			/* oops -- internal error -- send timeout for now */
 			ieee80211_destroy_assoc_data(sdata, false, false);
 			cfg80211_assoc_timeout(sdata->dev, cbss);
@@ -3755,6 +3768,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 			       ifmgd->assoc_req_ies, ifmgd->assoc_req_ies_len);
 notify_driver:
 	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	kfree(elems);
 }
 
 static void ieee80211_rx_bss_info(struct ieee80211_sub_if_data *sdata,
@@ -3959,7 +3973,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	struct ieee80211_mgmt *mgmt = (void *) hdr;
 	size_t baselen;
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *chan;
@@ -4005,15 +4019,16 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 
 	if (ifmgd->assoc_data && ifmgd->assoc_data->need_beacon &&
 	    ieee80211_rx_our_beacon(bssid, ifmgd->assoc_data->bss)) {
-		ieee802_11_parse_elems(variable,
-				       len - baselen, false, &elems,
-				       bssid,
-				       ifmgd->assoc_data->bss->bssid);
+		elems = ieee802_11_parse_elems(variable, len - baselen, false,
+					       bssid,
+					       ifmgd->assoc_data->bss->bssid);
+		if (!elems)
+			return;
 
 		ieee80211_rx_bss_info(sdata, mgmt, len, rx_status);
 
-		if (elems.dtim_period)
-			ifmgd->dtim_period = elems.dtim_period;
+		if (elems->dtim_period)
+			ifmgd->dtim_period = elems->dtim_period;
 		ifmgd->have_beacon = true;
 		ifmgd->assoc_data->need_beacon = false;
 		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
@@ -4021,17 +4036,17 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 				le64_to_cpu(mgmt->u.beacon.timestamp);
 			sdata->vif.bss_conf.sync_device_ts =
 				rx_status->device_timestamp;
-			sdata->vif.bss_conf.sync_dtim_count = elems.dtim_count;
+			sdata->vif.bss_conf.sync_dtim_count = elems->dtim_count;
 		}
 
-		if (elems.mbssid_config_ie)
+		if (elems->mbssid_config_ie)
 			bss_conf->profile_periodicity =
-				elems.mbssid_config_ie->profile_periodicity;
+				elems->mbssid_config_ie->profile_periodicity;
 		else
 			bss_conf->profile_periodicity = 0;
 
-		if (elems.ext_capab_len >= 11 &&
-		    (elems.ext_capab[10] & WLAN_EXT_CAPA11_EMA_SUPPORT))
+		if (elems->ext_capab_len >= 11 &&
+		    (elems->ext_capab[10] & WLAN_EXT_CAPA11_EMA_SUPPORT))
 			bss_conf->ema_ap = true;
 		else
 			bss_conf->ema_ap = false;
@@ -4040,6 +4055,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		ifmgd->assoc_data->timeout = jiffies;
 		ifmgd->assoc_data->timeout_started = true;
 		run_again(sdata, ifmgd->assoc_data->timeout);
+		kfree(elems);
 		return;
 	}
 
@@ -4071,14 +4087,15 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (!ieee80211_is_s1g_beacon(hdr->frame_control))
 		ncrc = crc32_be(0, (void *)&mgmt->u.beacon.beacon_int, 4);
-	ieee802_11_parse_elems_crc(variable,
-				   len - baselen, false, &elems,
-				   care_about_ies, ncrc,
-				   mgmt->bssid, bssid);
-	ncrc = elems.crc;
+	elems = ieee802_11_parse_elems_crc(variable, len - baselen,
+					   false, care_about_ies, ncrc,
+					   mgmt->bssid, bssid);
+	if (!elems)
+		return;
+	ncrc = elems->crc;
 
 	if (ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK) &&
-	    ieee80211_check_tim(elems.tim, elems.tim_len, bss_conf->aid)) {
+	    ieee80211_check_tim(elems->tim, elems->tim_len, bss_conf->aid)) {
 		if (local->hw.conf.dynamic_ps_timeout > 0) {
 			if (local->hw.conf.flags & IEEE80211_CONF_PS) {
 				local->hw.conf.flags &= ~IEEE80211_CONF_PS;
@@ -4148,12 +4165,12 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 			le64_to_cpu(mgmt->u.beacon.timestamp);
 		sdata->vif.bss_conf.sync_device_ts =
 			rx_status->device_timestamp;
-		sdata->vif.bss_conf.sync_dtim_count = elems.dtim_count;
+		sdata->vif.bss_conf.sync_dtim_count = elems->dtim_count;
 	}
 
 	if ((ncrc == ifmgd->beacon_crc && ifmgd->beacon_crc_valid) ||
 	    ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-		return;
+		goto free;
 	ifmgd->beacon_crc = ncrc;
 	ifmgd->beacon_crc_valid = true;
 
@@ -4161,12 +4178,12 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_sta_process_chanswitch(sdata, rx_status->mactime,
 					 rx_status->device_timestamp,
-					 &elems, true);
+					 elems, true);
 
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_WMM) &&
-	    ieee80211_sta_wmm_params(local, sdata, elems.wmm_param,
-				     elems.wmm_param_len,
-				     elems.mu_edca_param_set))
+	    ieee80211_sta_wmm_params(local, sdata, elems->wmm_param,
+				     elems->wmm_param_len,
+				     elems->mu_edca_param_set))
 		changed |= BSS_CHANGED_QOS;
 
 	/*
@@ -4175,7 +4192,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (!ifmgd->have_beacon) {
 		/* a few bogus AP send dtim_period = 0 or no TIM IE */
-		bss_conf->dtim_period = elems.dtim_period ?: 1;
+		bss_conf->dtim_period = elems->dtim_period ?: 1;
 
 		changed |= BSS_CHANGED_BEACON_INFO;
 		ifmgd->have_beacon = true;
@@ -4187,9 +4204,9 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		ieee80211_recalc_ps_vif(sdata);
 	}
 
-	if (elems.erp_info) {
+	if (elems->erp_info) {
 		erp_valid = true;
-		erp_value = elems.erp_info[0];
+		erp_value = elems->erp_info[0];
 	} else {
 		erp_valid = false;
 	}
@@ -4202,12 +4219,12 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	mutex_lock(&local->sta_mtx);
 	sta = sta_info_get(sdata, bssid);
 
-	changed |= ieee80211_recalc_twt_req(sdata, sta, &elems);
+	changed |= ieee80211_recalc_twt_req(sdata, sta, elems);
 
-	if (ieee80211_config_bw(sdata, sta, elems.ht_cap_elem,
-				elems.vht_cap_elem, elems.ht_operation,
-				elems.vht_operation, elems.he_operation,
-				elems.s1g_oper, bssid, &changed)) {
+	if (ieee80211_config_bw(sdata, sta, elems->ht_cap_elem,
+				elems->vht_cap_elem, elems->ht_operation,
+				elems->vht_operation, elems->he_operation,
+				elems->s1g_oper, bssid, &changed)) {
 		mutex_unlock(&local->sta_mtx);
 		sdata_info(sdata,
 			   "failed to follow AP %pM bandwidth change, disconnect\n",
@@ -4219,21 +4236,23 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 					    sizeof(deauth_buf), true,
 					    WLAN_REASON_DEAUTH_LEAVING,
 					    false);
-		return;
+		goto free;
 	}
 
-	if (sta && elems.opmode_notif)
-		ieee80211_vht_handle_opmode(sdata, sta, *elems.opmode_notif,
+	if (sta && elems->opmode_notif)
+		ieee80211_vht_handle_opmode(sdata, sta, *elems->opmode_notif,
 					    rx_status->band);
 	mutex_unlock(&local->sta_mtx);
 
 	changed |= ieee80211_handle_pwr_constr(sdata, chan, mgmt,
-					       elems.country_elem,
-					       elems.country_elem_len,
-					       elems.pwr_constr_elem,
-					       elems.cisco_dtpc_elem);
+					       elems->country_elem,
+					       elems->country_elem_len,
+					       elems->pwr_constr_elem,
+					       elems->cisco_dtpc_elem);
 
 	ieee80211_bss_info_change_notify(sdata, changed);
+free:
+	kfree(elems);
 }
 
 void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
@@ -4262,7 +4281,6 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_mgmt *mgmt;
 	u16 fc;
-	struct ieee802_11_elems elems;
 	int ies_len;
 
 	rx_status = (struct ieee80211_rx_status *) skb->cb;
@@ -4294,6 +4312,8 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 		break;
 	case IEEE80211_STYPE_ACTION:
 		if (mgmt->u.action.category == WLAN_CATEGORY_SPECTRUM_MGMT) {
+			struct ieee802_11_elems *elems;
+
 			ies_len = skb->len -
 				  offsetof(struct ieee80211_mgmt,
 					   u.action.u.chan_switch.variable);
@@ -4302,18 +4322,21 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				break;
 
 			/* CSA IE cannot be overridden, no need for BSSID */
-			ieee802_11_parse_elems(
-				mgmt->u.action.u.chan_switch.variable,
-				ies_len, true, &elems, mgmt->bssid, NULL);
+			elems = ieee802_11_parse_elems(
+					mgmt->u.action.u.chan_switch.variable,
+					ies_len, true, mgmt->bssid, NULL);
 
-			if (elems.parse_error)
+			if (!elems || elems->parse_error)
 				break;
 
 			ieee80211_sta_process_chanswitch(sdata,
 						 rx_status->mactime,
 						 rx_status->device_timestamp,
-						 &elems, false);
+						 elems, false);
+			kfree(elems);
 		} else if (mgmt->u.action.category == WLAN_CATEGORY_PUBLIC) {
+			struct ieee802_11_elems *elems;
+
 			ies_len = skb->len -
 				  offsetof(struct ieee80211_mgmt,
 					   u.action.u.ext_chan_switch.variable);
@@ -4325,21 +4348,22 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 			 * extended CSA IE can't be overridden, no need for
 			 * BSSID
 			 */
-			ieee802_11_parse_elems(
-				mgmt->u.action.u.ext_chan_switch.variable,
-				ies_len, true, &elems, mgmt->bssid, NULL);
+			elems = ieee802_11_parse_elems(
+					mgmt->u.action.u.ext_chan_switch.variable,
+					ies_len, true, mgmt->bssid, NULL);
 
-			if (elems.parse_error)
+			if (!elems || elems->parse_error)
 				break;
 
 			/* for the handling code pretend this was also an IE */
-			elems.ext_chansw_ie =
+			elems->ext_chansw_ie =
 				&mgmt->u.action.u.ext_chan_switch.data;
 
 			ieee80211_sta_process_chanswitch(sdata,
 						 rx_status->mactime,
 						 rx_status->device_timestamp,
-						 &elems, false);
+						 elems, false);
+			kfree(elems);
 		}
 		break;
 	}
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 6b50cb5e0e3c..5e6b275afc9e 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright 2016-2017  Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 
 #include <linux/if_arp.h>
@@ -155,7 +155,7 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 	};
 	bool signal_valid;
 	struct ieee80211_sub_if_data *scan_sdata;
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 	size_t baselen;
 	u8 *elements;
 
@@ -209,8 +209,10 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 	if (baselen > len)
 		return NULL;
 
-	ieee802_11_parse_elems(elements, len - baselen, false, &elems,
-			       mgmt->bssid, cbss->bssid);
+	elems = ieee802_11_parse_elems(elements, len - baselen, false,
+				       mgmt->bssid, cbss->bssid);
+	if (!elems)
+		return NULL;
 
 	/* In case the signal is invalid update the status */
 	signal_valid = channel == cbss->channel;
@@ -218,15 +220,17 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 		rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
 	bss = (void *)cbss->priv;
-	ieee80211_update_bss_from_elems(local, bss, &elems, rx_status, beacon);
+	ieee80211_update_bss_from_elems(local, bss, elems, rx_status, beacon);
 
 	list_for_each_entry(non_tx_cbss, &cbss->nontrans_list, nontrans_list) {
 		non_tx_bss = (void *)non_tx_cbss->priv;
 
-		ieee80211_update_bss_from_elems(local, non_tx_bss, &elems,
+		ieee80211_update_bss_from_elems(local, non_tx_bss, elems,
 						rx_status, beacon);
 	}
 
+	kfree(elems);
+
 	return bss;
 }
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 45e532ad1215..137be9ec94af 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -6,7 +6,7 @@
  * Copyright 2014, Intel Corporation
  * Copyright 2014  Intel Mobile Communications GmbH
  * Copyright 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019, 2021 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -1684,7 +1684,7 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 					   struct sk_buff *skb)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems = NULL;
 	struct sta_info *sta;
 	struct ieee80211_tdls_data *tf = (void *)skb->data;
 	bool local_initiator;
@@ -1718,16 +1718,20 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 		goto call_drv;
 	}
 
-	ieee802_11_parse_elems(tf->u.chan_switch_resp.variable,
-			       skb->len - baselen, false, &elems,
-			       NULL, NULL);
-	if (elems.parse_error) {
+	elems = ieee802_11_parse_elems(tf->u.chan_switch_resp.variable,
+				       skb->len - baselen, false, NULL, NULL);
+	if (!elems) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (elems->parse_error) {
 		tdls_dbg(sdata, "Invalid IEs in TDLS channel switch resp\n");
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (!elems.ch_sw_timing || !elems.lnk_id) {
+	if (!elems->ch_sw_timing || !elems->lnk_id) {
 		tdls_dbg(sdata, "TDLS channel switch resp - missing IEs\n");
 		ret = -EINVAL;
 		goto out;
@@ -1735,15 +1739,15 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 
 	/* validate the initiator is set correctly */
 	local_initiator =
-		!memcmp(elems.lnk_id->init_sta, sdata->vif.addr, ETH_ALEN);
+		!memcmp(elems->lnk_id->init_sta, sdata->vif.addr, ETH_ALEN);
 	if (local_initiator == sta->sta.tdls_initiator) {
 		tdls_dbg(sdata, "TDLS chan switch invalid lnk-id initiator\n");
 		ret = -EINVAL;
 		goto out;
 	}
 
-	params.switch_time = le16_to_cpu(elems.ch_sw_timing->switch_time);
-	params.switch_timeout = le16_to_cpu(elems.ch_sw_timing->switch_timeout);
+	params.switch_time = le16_to_cpu(elems->ch_sw_timing->switch_time);
+	params.switch_timeout = le16_to_cpu(elems->ch_sw_timing->switch_timeout);
 
 	params.tmpl_skb =
 		ieee80211_tdls_ch_sw_resp_tmpl_get(sta, &params.ch_sw_tm_ie);
@@ -1763,6 +1767,7 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 out:
 	mutex_unlock(&local->sta_mtx);
 	dev_kfree_skb_any(params.tmpl_skb);
+	kfree(elems);
 	return ret;
 }
 
@@ -1771,7 +1776,7 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 					  struct sk_buff *skb)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct ieee802_11_elems elems;
+	struct ieee802_11_elems *elems;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_channel *chan;
 	enum nl80211_channel_type chan_type;
@@ -1831,22 +1836,27 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 	}
 
-	ieee802_11_parse_elems(tf->u.chan_switch_req.variable,
-			       skb->len - baselen, false, &elems, NULL, NULL);
-	if (elems.parse_error) {
+	elems = ieee802_11_parse_elems(tf->u.chan_switch_req.variable,
+				       skb->len - baselen, false, NULL, NULL);
+	if (!elems)
+		return -ENOMEM;
+
+	if (elems->parse_error) {
 		tdls_dbg(sdata, "Invalid IEs in TDLS channel switch req\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free;
 	}
 
-	if (!elems.ch_sw_timing || !elems.lnk_id) {
+	if (!elems->ch_sw_timing || !elems->lnk_id) {
 		tdls_dbg(sdata, "TDLS channel switch req - missing IEs\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free;
 	}
 
-	if (!elems.sec_chan_offs) {
+	if (!elems->sec_chan_offs) {
 		chan_type = NL80211_CHAN_HT20;
 	} else {
-		switch (elems.sec_chan_offs->sec_chan_offs) {
+		switch (elems->sec_chan_offs->sec_chan_offs) {
 		case IEEE80211_HT_PARAM_CHA_SEC_ABOVE:
 			chan_type = NL80211_CHAN_HT40PLUS;
 			break;
@@ -1865,7 +1875,8 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 	if (!cfg80211_reg_can_beacon_relax(sdata->local->hw.wiphy, &chandef,
 					   sdata->wdev.iftype)) {
 		tdls_dbg(sdata, "TDLS chan switch to forbidden channel\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free;
 	}
 
 	mutex_lock(&local->sta_mtx);
@@ -1881,7 +1892,7 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 
 	/* validate the initiator is set correctly */
 	local_initiator =
-		!memcmp(elems.lnk_id->init_sta, sdata->vif.addr, ETH_ALEN);
+		!memcmp(elems->lnk_id->init_sta, sdata->vif.addr, ETH_ALEN);
 	if (local_initiator == sta->sta.tdls_initiator) {
 		tdls_dbg(sdata, "TDLS chan switch invalid lnk-id initiator\n");
 		ret = -EINVAL;
@@ -1889,16 +1900,16 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* peer should have known better */
-	if (!sta->sta.ht_cap.ht_supported && elems.sec_chan_offs &&
-	    elems.sec_chan_offs->sec_chan_offs) {
+	if (!sta->sta.ht_cap.ht_supported && elems->sec_chan_offs &&
+	    elems->sec_chan_offs->sec_chan_offs) {
 		tdls_dbg(sdata, "TDLS chan switch - wide chan unsupported\n");
 		ret = -ENOTSUPP;
 		goto out;
 	}
 
 	params.chandef = &chandef;
-	params.switch_time = le16_to_cpu(elems.ch_sw_timing->switch_time);
-	params.switch_timeout = le16_to_cpu(elems.ch_sw_timing->switch_timeout);
+	params.switch_time = le16_to_cpu(elems->ch_sw_timing->switch_time);
+	params.switch_timeout = le16_to_cpu(elems->ch_sw_timing->switch_timeout);
 
 	params.tmpl_skb =
 		ieee80211_tdls_ch_sw_resp_tmpl_get(sta,
@@ -1917,6 +1928,8 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 out:
 	mutex_unlock(&local->sta_mtx);
 	dev_kfree_skb_any(params.tmpl_skb);
+free:
+	kfree(elems);
 	return ret;
 }
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index dce841228297..ca8008ba9b1f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1391,8 +1391,8 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 
 static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 					    struct ieee802_11_elems *elems,
-					    u8 *transmitter_bssid,
-					    u8 *bss_bssid,
+					    const u8 *transmitter_bssid,
+					    const u8 *bss_bssid,
 					    u8 *nontransmitted_profile)
 {
 	const struct element *elem, *sub;
@@ -1457,16 +1457,20 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 	return found ? profile_len : 0;
 }
 
-void ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
-				struct ieee802_11_elems *elems,
-				u64 filter, u32 crc, u8 *transmitter_bssid,
-				u8 *bss_bssid)
+struct ieee802_11_elems *ieee802_11_parse_elems_crc(const u8 *start, size_t len,
+						    bool action, u64 filter,
+						    u32 crc,
+						    const u8 *transmitter_bssid,
+						    const u8 *bss_bssid)
 {
+	struct ieee802_11_elems *elems;
 	const struct element *non_inherit = NULL;
 	u8 *nontransmitted_profile;
 	int nontransmitted_profile_len = 0;
 
-	memset(elems, 0, sizeof(*elems));
+	elems = kzalloc(sizeof(*elems), GFP_ATOMIC);
+	if (!elems)
+		return NULL;
 	elems->ie_start = start;
 	elems->total_len = len;
 
@@ -1513,6 +1517,8 @@ void ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 	kfree(nontransmitted_profile);
 
 	elems->crc = crc;
+
+	return elems;
 }
 
 void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
-- 
2.31.1


Return-Path: <linux-wireless+bounces-602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48B80BAD1
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B561C20981
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38811CB3;
	Sun, 10 Dec 2023 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8HfEtRK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F6EA6
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213527; x=1733749527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/Ucdr3iaRNKvw1Sjqhnc1frKacNr5ZCJtO/G17+aXk=;
  b=j8HfEtRKQD168TSXTNRnTXaDMRmM+XEOsnWSryBM2kI3QdkZ1ZEaQzon
   q/gYFWWfhSXmDEzjzLp8+Wv391XI7hr1SLz4KvzQGCg9X/hXEB6+iZ4nU
   YHujCV/ov9iPC9GZuKY06jhuZFqnvaqbTDkz4Qhso5KLlCwGrwWYxFbzs
   NsSqPAZEtY0csv3wFUdsXKUhsL0a5K8vIVU8wkgpugKn5hufQsfBUP5bD
   Ab3vTEfE6fQKPDV7TCOCrAepPlGFNqh3xJNfx9h0it1hGetkscns0QBOT
   k+e1duLNaDu0YrEgoUd3cR2U030xMbQFhFWV4deAtgQxOI3w2J9y9bgYE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480745769"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480745769"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748925651"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748925651"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Berg@web.codeaurora.org, Johannes <johannes.berg@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 07/14] wifi: mac80211: Replace ENOTSUPP with EOPNOTSUPP
Date: Mon, 11 Dec 2023 09:05:25 +0200
Message-Id: <20231211085121.3841b71c867d.Idf2ad01d9dfe8d6d6c352bf02deb06e49701ad1d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

ENOTSUP isn't a standard error code. EOPNOTSUPP should be used instead.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c          |  4 ++--
 net/mac80211/chan.c         |  4 ++--
 net/mac80211/driver-ops.h   |  2 +-
 net/mac80211/mesh_hwmp.c    |  2 +-
 net/mac80211/mesh_pathtbl.c |  8 ++++----
 net/mac80211/scan.c         |  4 ++--
 net/mac80211/tdls.c         | 18 +++++++++---------
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 606b1b2e4123..e0a4f9eecb2c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1270,7 +1270,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		return -EALREADY;
 
 	if (params->smps_mode != NL80211_SMPS_OFF)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	link->smps_mode = IEEE80211_SMPS_OFF;
 
@@ -2556,7 +2556,7 @@ static int ieee80211_update_mesh_config(struct wiphy *wiphy,
 		 * devices that report signal in dBm.
 		 */
 		if (!ieee80211_hw_check(&sdata->local->hw, SIGNAL_DBM))
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		conf->rssi_threshold = nconf->rssi_threshold;
 	}
 	if (_chg_mesh_attr(NL80211_MESHCONF_HT_OPMODE, mask)) {
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 1d928f29ad6f..d26726b2629d 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -858,7 +858,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	int ret = 0;
 
 	if (WARN_ON(sdata->vif.type == NL80211_IFTYPE_NAN))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	conf = rcu_dereference_protected(link->conf->chanctx_conf,
 					 lockdep_is_held(&local->hw.wiphy->mtx));
@@ -1106,7 +1106,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 
 	curr_ctx = ieee80211_link_get_chanctx(link);
 	if (curr_ctx && local->use_chanctx && !local->ops->switch_vif_chanctx)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	new_ctx = ieee80211_find_reservation_chanctx(local, chandef, mode);
 	if (!new_ctx) {
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 568633b38c47..fecf92f06da7 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -800,7 +800,7 @@ drv_cancel_remain_on_channel(struct ieee80211_local *local,
 static inline int drv_set_ringparam(struct ieee80211_local *local,
 				    u32 tx, u32 rx)
 {
-	int ret = -ENOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 775d52561c54..024f48db6b05 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -151,7 +151,7 @@ static int mesh_path_sel_frame_tx(enum mpath_frame_type action, u8 flags,
 		break;
 	default:
 		kfree_skb(skb);
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 	*pos++ = ie_len;
 	*pos++ = flags;
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 8a3f44ce3e04..735edde1bd81 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -676,10 +676,10 @@ struct mesh_path *mesh_path_add(struct ieee80211_sub_if_data *sdata,
 
 	if (ether_addr_equal(dst, sdata->vif.addr))
 		/* never add ourselves as neighbours */
-		return ERR_PTR(-ENOTSUPP);
+		return ERR_PTR(-EOPNOTSUPP);
 
 	if (is_multicast_ether_addr(dst))
-		return ERR_PTR(-ENOTSUPP);
+		return ERR_PTR(-EOPNOTSUPP);
 
 	if (atomic_add_unless(&sdata->u.mesh.mpaths, 1, MESH_MAX_MPATHS) == 0)
 		return ERR_PTR(-ENOSPC);
@@ -719,10 +719,10 @@ int mpp_path_add(struct ieee80211_sub_if_data *sdata,
 
 	if (ether_addr_equal(dst, sdata->vif.addr))
 		/* never add ourselves as neighbours */
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (is_multicast_ether_addr(dst))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	new_mpath = mesh_path_new(sdata, dst, GFP_ATOMIC);
 
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 1d98877647d8..645355e5f1bc 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -1289,7 +1289,7 @@ int __ieee80211_request_sched_scan_start(struct ieee80211_sub_if_data *sdata,
 	iebufsz = local->scan_ies_len + req->ie_len;
 
 	if (!local->ops->sched_scan_start)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < NUM_NL80211_BANDS; i++) {
 		if (local->hw.wiphy->bands[i]) {
@@ -1354,7 +1354,7 @@ int ieee80211_request_sched_scan_stop(struct ieee80211_local *local)
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!local->ops->sched_scan_stop)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* We don't want to restart sched scan anymore. */
 	RCU_INIT_POINTER(local->sched_scan_req, NULL);
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 05a7dff69fe9..49730b424141 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1001,7 +1001,7 @@ ieee80211_tdls_build_mgmt_packet_data(struct ieee80211_sub_if_data *sdata,
 						 skb);
 		break;
 	default:
-		ret = -ENOTSUPP;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
@@ -1071,7 +1071,7 @@ ieee80211_tdls_prep_mgmt_packet(struct wiphy *wiphy, struct net_device *dev,
 		/* any value is ok */
 		break;
 	default:
-		ret = -ENOTSUPP;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
@@ -1177,7 +1177,7 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
 	    smps_mode != IEEE80211_SMPS_OFF) {
 		tdls_dbg(sdata, "Aborting TDLS setup due to SMPS mode %d\n",
 			 smps_mode);
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -1289,7 +1289,7 @@ int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 	int ret;
 
 	if (!(wiphy->flags & WIPHY_FLAG_SUPPORTS_TDLS))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* make sure we are in managed mode, and associated */
 	if (sdata->vif.type != NL80211_IFTYPE_STATION ||
@@ -1446,7 +1446,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!(wiphy->flags & WIPHY_FLAG_SUPPORTS_TDLS))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (sdata->vif.type != NL80211_IFTYPE_STATION)
 		return -EINVAL;
@@ -1459,7 +1459,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	case NL80211_TDLS_SETUP:
 	case NL80211_TDLS_DISCOVERY_REQ:
 		/* We don't support in-driver setup/teardown/discovery */
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	/* protect possible bss_conf changes and avoid concurrency in
@@ -1510,7 +1510,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 			return ret;
 		break;
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (ether_addr_equal(sdata->u.mgd.tdls_peer, peer)) {
@@ -1673,7 +1673,7 @@ ieee80211_tdls_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (!test_sta_flag(sta, WLAN_STA_TDLS_CHAN_SWITCH)) {
 		tdls_dbg(sdata, "TDLS channel switch unsupported by %pM\n",
 			 addr);
-		ret = -ENOTSUPP;
+		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
@@ -1993,7 +1993,7 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 	if (!sta->sta.deflink.ht_cap.ht_supported && elems->sec_chan_offs &&
 	    elems->sec_chan_offs->sec_chan_offs) {
 		tdls_dbg(sdata, "TDLS chan switch - wide chan unsupported\n");
-		ret = -ENOTSUPP;
+		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
-- 
2.34.1



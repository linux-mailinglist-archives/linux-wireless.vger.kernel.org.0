Return-Path: <linux-wireless+bounces-33957-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP2hMmsHxWnn5gQAu9opvQ
	(envelope-from <linux-wireless+bounces-33957-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:16:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B428D3331F0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9CC3301E989
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C33C3BED;
	Thu, 26 Mar 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjEtjjtP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823B3C198E
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520116; cv=none; b=mfeOYYOVBkQLJbbanbGIMkq/BhCTPWTMq3DB6wAyLFEeSqRWGk60QOjEGUwm389phuyTfKOSrYwh9RBGjSuT8H5cMiadd/brD/tMLmJJ//D/UksbqH3LkaHkZauy4siYya+x991lWgmbg6N4iSzihVuTQSom1XTWWCC/urQlj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520116; c=relaxed/simple;
	bh=N697z7iAFq45/bNVWVW3s6VFVh2eXUPOFgIEHc9Tfio=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jF9o9+OQ32ZHjpOX406KHyWu1YL5qFosEg0cUs+MMRy6niGKmyDnFE0W7InHSGhK0dOfInPc5J5i0j/5aDTsR4ocw028Lj+NV3Ksq91Hal6im26jI1HIco9nQ1sQ17GzChMZHgx6x27GPyXB7m5H3aH4jCeRl1pKBjmVnNsNn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjEtjjtP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520115; x=1806056115;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=N697z7iAFq45/bNVWVW3s6VFVh2eXUPOFgIEHc9Tfio=;
  b=MjEtjjtPXMj04ZDi6wMnegYLzp6Fpl3XdnJ+DKd1pKryLS6dHWrHS/ym
   Wq7W75wqWK22+zcSbaK8Bc/pY1gQJUaeamlcFbil3hqXHT+V1YJGygZPO
   fmVYHNiseJTmxJL2/ypBxlkT3orhvTzGIHuvp0KFFzCGI8BWuNsHgFRi/
   tIB9dqHHm62zlLZFmKEXIFYB9Ji5e4Hlg/2cVKjLZgHZ/uSHxUMtcSYQS
   n4oZseg6hnfZQyyoS+zy17byvvAHFf4PbdbWYDZa54k1aquYGX2DUFXSq
   hdMuNZ50TqQGIAVu/MmI62LlW/Hwo/JEIixrNY2Tp0H429m+RbLoEqV24
   A==;
X-CSE-ConnectionGUID: moKxgMjoRpyGGVcIzB5onA==
X-CSE-MsgGUID: MJESCvDOS1yz6FuJwSdPKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048567"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048567"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:12 -0700
X-CSE-ConnectionGUID: ruVPY3j8RCC608RWQMhMEQ==
X-CSE-MsgGUID: kLDpdNAYSIWLD8K/fVuyfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653212"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 10/15] wifi: mac80211: update NAN data path state on schedule changes
Date: Thu, 26 Mar 2026 12:14:40 +0200
Message-Id: <20260326121156.98ff4115406f.Ie796487ab9eb23cda819b0afac57e7267b134911@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
References: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33957-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B428D3331F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A carrier of an NDI interface is turned on when there is at least one NDI
station that: (1) correlates to this interface (2) is authorized (3) the
NAN peer to which this station belongs has at least one common slot with
the local schedule. Otherwise, it is turned off.
(common slots are slots where both schedules are active on compatible
 channels.)

Implement the calculation of the carrier state and trigger it when
needed.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c         |  10 +++-
 net/mac80211/ieee80211_i.h |   1 +
 net/mac80211/nan.c         | 108 +++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.c    |   4 ++
 4 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 493f7b5cfd6f..8cdbefac1bee 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2502,7 +2502,15 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 	    test_sta_flag(sta, WLAN_STA_ASSOC))
 		rate_control_rate_init_all_links(sta);
 
-	return sta_info_insert(sta);
+	err = sta_info_insert(sta);
+
+	/*
+	 * ieee80211_nan_update_ndi_carrier was called from sta_apply_parameters,
+	 * but then we did not have the STA in the list.
+	 */
+	if (!err && sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+		ieee80211_nan_update_ndi_carrier(sta->sdata);
+	return err;
 }
 
 static int ieee80211_del_station(struct wiphy *wiphy, struct wireless_dev *wdev,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 23bf00472915..2a693406294b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2045,6 +2045,7 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
 				 struct cfg80211_nan_peer_sched *sched);
 void ieee80211_nan_free_peer_sched(struct ieee80211_nan_peer_sched *sched);
+void ieee80211_nan_update_ndi_carrier(struct ieee80211_sub_if_data *ndi_sdata);
 
 /* scan/BSS handling */
 void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work);
diff --git a/net/mac80211/nan.c b/net/mac80211/nan.c
index 5e1f9bb7c49d..4e262b624521 100644
--- a/net/mac80211/nan.c
+++ b/net/mac80211/nan.c
@@ -220,6 +220,23 @@ ieee80211_nan_remove_channel(struct ieee80211_sub_if_data *sdata,
 		ieee80211_free_chanctx(sdata->local, ctx, false);
 }
 
+static void
+ieee80211_nan_update_all_ndi_carriers(struct ieee80211_local *local)
+{
+	struct ieee80211_sub_if_data *sdata;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	/* Iterate all interfaces and update carrier for NDI interfaces */
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (!ieee80211_sdata_running(sdata) ||
+		    sdata->vif.type != NL80211_IFTYPE_NAN_DATA)
+			continue;
+
+		ieee80211_nan_update_ndi_carrier(sdata);
+	}
+}
+
 static struct ieee80211_nan_channel *
 ieee80211_nan_find_free_channel(struct ieee80211_nan_sched_cfg *sched_cfg)
 {
@@ -347,6 +364,7 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 	if (sched_cfg->deferred)
 		return 0;
 
+	ieee80211_nan_update_all_ndi_carriers(sdata->local);
 	bitmap_zero(sdata->u.nan.removed_channels, IEEE80211_NAN_MAX_CHANNELS);
 
 	return 0;
@@ -409,6 +427,7 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 	bitmap_zero(sdata->u.nan.removed_channels, IEEE80211_NAN_MAX_CHANNELS);
 
 	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
+	ieee80211_nan_update_all_ndi_carriers(sdata->local);
 	return ret;
 }
 
@@ -423,6 +442,8 @@ void ieee80211_nan_sched_update_done(struct ieee80211_vif *vif)
 	if (WARN_ON(!sched_cfg->deferred))
 		return;
 
+	ieee80211_nan_update_all_ndi_carriers(sdata->local);
+
 	/*
 	 * Clear the deferred flag before removing channels. Removing channels
 	 * will trigger another schedule update to the driver, and there is no
@@ -531,6 +552,91 @@ ieee80211_nan_init_peer_map(struct ieee80211_nan_peer_sched *peer_sched,
 	}
 }
 
+/*
+ * Check if the local schedule and a peer schedule have at least one common
+ * slot - a slot where both schedules are active on compatible channels.
+ */
+static bool
+ieee80211_nan_has_common_slots(struct ieee80211_sub_if_data *sdata,
+			       struct ieee80211_nan_peer_sched *peer_sched)
+{
+	for (int slot = 0; slot < CFG80211_NAN_SCHED_NUM_TIME_SLOTS; slot++) {
+		struct ieee80211_nan_channel *local_chan =
+			sdata->vif.cfg.nan_sched.schedule[slot];
+
+		if (!local_chan || !local_chan->chanctx_conf)
+			continue;
+
+		/* Check all peer maps for this slot */
+		for (int m = 0; m < CFG80211_NAN_MAX_PEER_MAPS; m++) {
+			struct ieee80211_nan_peer_map *map = &peer_sched->maps[m];
+			struct ieee80211_nan_channel *peer_chan;
+
+			if (map->map_id == CFG80211_NAN_INVALID_MAP_ID)
+				continue;
+
+			peer_chan = map->slots[slot];
+			if (!peer_chan)
+				continue;
+
+			if (local_chan->chanctx_conf == peer_chan->chanctx_conf)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+void ieee80211_nan_update_ndi_carrier(struct ieee80211_sub_if_data *ndi_sdata)
+{
+	struct ieee80211_local *local = ndi_sdata->local;
+	struct ieee80211_sub_if_data *nmi_sdata;
+	struct sta_info *sta;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (WARN_ON(ndi_sdata->vif.type != NL80211_IFTYPE_NAN_DATA ||
+		    !ndi_sdata->dev) || !ieee80211_sdata_running(ndi_sdata))
+		return;
+
+	nmi_sdata = wiphy_dereference(local->hw.wiphy, ndi_sdata->u.nan_data.nmi);
+	if (WARN_ON(!nmi_sdata))
+		return;
+
+	list_for_each_entry(sta, &local->sta_list, list) {
+		struct ieee80211_sta *nmi_sta;
+
+		if (sta->sdata != ndi_sdata ||
+		    !test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+			continue;
+
+		nmi_sta = wiphy_dereference(local->hw.wiphy, sta->sta.nmi);
+		if (WARN_ON(!nmi_sta) || !nmi_sta->nan_sched)
+			continue;
+
+		if (ieee80211_nan_has_common_slots(nmi_sdata, nmi_sta->nan_sched)) {
+			netif_carrier_on(ndi_sdata->dev);
+			return;
+		}
+	}
+
+	netif_carrier_off(ndi_sdata->dev);
+}
+
+static void
+ieee80211_nan_update_peer_ndis_carrier(struct ieee80211_local *local,
+				       struct sta_info *nmi_sta)
+{
+	struct sta_info *sta;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	list_for_each_entry(sta, &local->sta_list, list) {
+		if (rcu_access_pointer(sta->sta.nmi) == &nmi_sta->sta)
+			ieee80211_nan_update_ndi_carrier(sta->sdata);
+	}
+}
+
 int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
 				 struct cfg80211_nan_peer_sched *sched)
 {
@@ -592,6 +698,8 @@ int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
+	ieee80211_nan_update_peer_ndis_carrier(sdata->local, sta);
+
 	/* Success - free old schedule */
 	to_free = old_sched;
 	ret = 0;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index dd0d92abf60d..de85a7c68bec 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1454,6 +1454,8 @@ static int _sta_info_move_state(struct sta_info *sta,
 		} else if (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
 			ieee80211_vif_dec_num_mcast(sta->sdata);
 			clear_bit(WLAN_STA_AUTHORIZED, &sta->_flags);
+			if (sta->sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+				ieee80211_nan_update_ndi_carrier(sta->sdata);
 
 			/*
 			 * If we have encryption offload, flush (station) queues
@@ -1482,6 +1484,8 @@ static int _sta_info_move_state(struct sta_info *sta,
 			set_bit(WLAN_STA_AUTHORIZED, &sta->_flags);
 			ieee80211_check_fast_xmit(sta);
 			ieee80211_check_fast_rx(sta);
+			if (sta->sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+				ieee80211_nan_update_ndi_carrier(sta->sdata);
 		}
 		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
 		    sta->sdata->vif.type == NL80211_IFTYPE_AP)
-- 
2.34.1



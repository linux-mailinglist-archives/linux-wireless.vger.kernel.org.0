Return-Path: <linux-wireless+bounces-33880-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JGSGeRQxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33880-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 371EE32C541
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99FBE3056247
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14A73659E7;
	Wed, 25 Mar 2026 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HT1R3+x2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F75378D79
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473364; cv=none; b=cI7ygnbf5Q2Hl2UJ48OSwzutvezzcNknDvh9wd1NeDbASBcfICeZ4M6QfmlbvJJeM/fjdTnsiXClbJX+ds4S0IGkJadXtWaRmZgl62de6m1QriquE3D5OAU0+DghRmhG+mTRjr5Jm830esCCBzSEeTc8odxCSJDN/YN2N54yQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473364; c=relaxed/simple;
	bh=IDgUSMcMHpj1qEl4f2rVX3jL+u7bZcKBl6aggEKOKFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chu1/l11GYJq3TLGQulkSfv1ig3RyR8ztsk9tcPJjyYZ3NLIJ96nBCx5hSz3JKMhfsIiazLzbE5GLr2hzqA6ASLie0siuZegH1N++Aq0Rf3ii+Ezy2bpBB6+hEeWU+0NqLPKET3QSFeQXcF5BtzNdbFdA3dOuDlWC0pJLdhrUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HT1R3+x2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473363; x=1806009363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IDgUSMcMHpj1qEl4f2rVX3jL+u7bZcKBl6aggEKOKFo=;
  b=HT1R3+x2t3N3GtDLVsAYEqYaJ2tw9jPiLGkoDfvSToKs6CF6REHswkjF
   8gDlIohYOju2nTqrY8OVhhvZCC86Ot7kN4gJTFodvZZwx4CLqa2sdEo3D
   iA/R2eYvpQLqdwkGd30OHVoQKK+K3O7gL6Z9li4EVRpjc/PYtS7+b3kVm
   kQWSqI10IISJ1DP3nNDpgqG48Cs34J7dk73tbGUnEPqnyfr4cC2wQpHTB
   EozDSGYt44jto7hVquWfMorWlOsjjcl8YoJLebYYEIjoPiUAk//X6iML1
   jdBvAqeQew3r+bH1+iXWeCMuIRc6F87cxQq8M1ZLPIu41HnOuXdSW45kn
   w==;
X-CSE-ConnectionGUID: BBDG2xtrQr2B1Fh0leFsTQ==
X-CSE-MsgGUID: 7IQrweh6SpqPCm4N/EpH7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485371"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485371"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:03 -0700
X-CSE-ConnectionGUID: EeCVMd+rQd2g3+FTzYBZRw==
X-CSE-MsgGUID: 8x0JpcTWT4Or/95S8CCTnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747519"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 09/15] wifi: mac80211: add NAN peer schedule support
Date: Wed, 25 Mar 2026 23:15:30 +0200
Message-Id: <20260325230443.b10fc7b44c1c.I0345eb665be8ccf4a77eb1aca9a421eb8d2432e2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
References: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33880-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 371EE32C541
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Peer schedules specify which channels the peer is available on and when.
Add support for configuring peer NAN schedules:
- build and store the schedule and maps
- for each channel, make sure that it fits into the capabilities, and
  take the minimum between it and the local compatible nan channel.
- configure the driver

Note that the removal of a peer schedule should be done by the driver
upon NMI station removal.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  62 +++++++++-
 net/mac80211/cfg.c         |  13 +++
 net/mac80211/driver-ops.h  |  21 ++++
 net/mac80211/ieee80211_i.h |   3 +
 net/mac80211/nan.c         | 226 ++++++++++++++++++++++++++++++++++++-
 net/mac80211/sta_info.c    |   4 +
 net/mac80211/trace.h       |  31 +++++
 net/mac80211/util.c        |   8 ++
 8 files changed, 365 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 8656e2cc2b75..783757f14b61 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -877,8 +877,11 @@ struct ieee80211_bss_conf {
  *	is irrelevant for NAN, still store it for convenience - some functions
  *	require it as an argument.
  * @needed_rx_chains: number of RX chains needed for this NAN channel
- * @chanctx_conf: chanctx_conf assigned to this NAN channel. Will be %NULL
- *	if the channel is ULWed.
+ * @chanctx_conf: chanctx_conf assigned to this NAN channel.
+ *	If a local channel is being ULWed (because we needed this chanctx for
+ *	something else), the local NAN channel that used this chanctx,
+ *	will have this pointer set to %NULL.
+ *	A peer NAN channel should never have this pointer set to %NULL.
  * @channel_entry: the Channel Entry blob as defined in Wi-Fi Aware
  *	(TM) 4.0 specification Table 100 (Channel Entry format for the NAN
  *	Availability attribute).
@@ -890,6 +893,49 @@ struct ieee80211_nan_channel {
 	u8 channel_entry[6];
 };
 
+/**
+ * struct ieee80211_nan_peer_map - NAN peer schedule map
+ *
+ * This stores a single map from a peer's schedule. Each peer can have
+ * multiple maps.
+ *
+ * @map_id: the map ID from the peer schedule, %CFG80211_NAN_INVALID_MAP_ID
+ *	if unused
+ * @slots: mapping of time slots to channel configurations in the schedule's
+ *	channels array
+ */
+struct ieee80211_nan_peer_map {
+	u8 map_id;
+	struct ieee80211_nan_channel *slots[CFG80211_NAN_SCHED_NUM_TIME_SLOTS];
+};
+
+/**
+ * struct ieee80211_nan_peer_sched - NAN peer schedule
+ *
+ * This stores the complete schedule from a peer. Contains peer-level
+ * parameters and an array of schedule maps.
+ *
+ * @seq_id: the sequence ID from the peer schedule
+ * @committed_dw: committed DW as published by the peer
+ * @max_chan_switch: maximum channel switch time in microseconds
+ * @init_ulw: initial ULWs as published by the peer (copied)
+ * @ulw_size: number of bytes in @init_ulw
+ * @maps: array of peer schedule maps. Invalid slots have map_id set to
+ *	%CFG80211_NAN_INVALID_MAP_ID.
+ * @n_channels: number of valid channel entries in @channels
+ * @channels: flexible array of negotiated peer channels for this schedule
+ */
+struct ieee80211_nan_peer_sched {
+	u8 seq_id;
+	u16 committed_dw;
+	u16 max_chan_switch;
+	const u8 *init_ulw;
+	u16 ulw_size;
+	struct ieee80211_nan_peer_map maps[CFG80211_NAN_MAX_PEER_MAPS];
+	u8 n_channels;
+	struct ieee80211_nan_channel channels[] __counted_by(n_channels);
+};
+
 /**
  * enum mac80211_tx_info_flags - flags to describe transmission information/status
  *
@@ -2625,6 +2671,7 @@ struct ieee80211_link_sta {
  * @spp_amsdu: indicates whether the STA uses SPP A-MSDU or not.
  * @epp_peer: indicates that the peer is an EPP peer.
  * @nmi: For NDI stations, pointer to the NMI station of the peer.
+ * @nan_sched: NAN peer schedule for this station. Valid only for NMI stations.
  */
 struct ieee80211_sta {
 	u8 addr[ETH_ALEN] __aligned(2);
@@ -2655,6 +2702,9 @@ struct ieee80211_sta {
 
 	struct ieee80211_sta __rcu *nmi;
 
+	/* should only be accessed with the wiphy mutex held */
+	struct ieee80211_nan_peer_sched *nan_sched;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -4556,6 +4606,12 @@ struct ieee80211_prep_tx_info {
  * @del_nan_func: Remove a NAN function. The driver must call
  *	ieee80211_nan_func_terminated() with
  *	NL80211_NAN_FUNC_TERM_REASON_USER_REQUEST reason code upon removal.
+ * @nan_peer_sched_changed: Notifies the driver that the peer NAN schedule
+ *	has changed. The new schedule is available via sta->nan_sched.
+ *	Note that the channel_entry blob might not match the actual chandef
+ *	since the bandwidth of the chandef is the minimum of the local and peer
+ *	bandwidth. It is the driver responsibility to remove the peer schedule
+ *	when the NMI station is removed.
  * @can_aggregate_in_amsdu: Called in order to determine if HW supports
  *	aggregating two specific frames in the same A-MSDU. The relation
  *	between the skbs should be symmetric and transitive. Note that while
@@ -4961,6 +5017,8 @@ struct ieee80211_ops {
 	void (*del_nan_func)(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
 			    u8 instance_id);
+	int (*nan_peer_sched_changed)(struct ieee80211_hw *hw,
+				      struct ieee80211_sta *sta);
 	bool (*can_aggregate_in_amsdu)(struct ieee80211_hw *hw,
 				       struct sk_buff *head,
 				       struct sk_buff *skb);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a1089e3964bd..493f7b5cfd6f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5689,6 +5689,18 @@ ieee80211_set_local_nan_sched(struct wiphy *wiphy,
 	return ieee80211_nan_set_local_sched(sdata, sched);
 }
 
+static int
+ieee80211_set_peer_nan_sched(struct wiphy *wiphy,
+			     struct wireless_dev *wdev,
+			     struct cfg80211_nan_peer_sched *sched)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	return ieee80211_nan_set_peer_sched(sdata, sched);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -5806,4 +5818,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.assoc_ml_reconf = ieee80211_assoc_ml_reconf,
 	.set_epcs = ieee80211_set_epcs,
 	.nan_set_local_sched = ieee80211_set_local_nan_sched,
+	.nan_set_peer_sched = ieee80211_set_peer_nan_sched,
 };
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 51bf3c7822a7..f1c0b87fddd5 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1793,4 +1793,25 @@ static inline int drv_set_eml_op_mode(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
+static inline int
+drv_nan_peer_sched_changed(struct ieee80211_local *local,
+			   struct ieee80211_sub_if_data *sdata,
+			   struct sta_info *sta)
+{
+	int ret;
+
+	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
+	check_sdata_in_driver(sdata);
+
+	if (!local->ops->nan_peer_sched_changed)
+		return -EOPNOTSUPP;
+
+	trace_drv_nan_peer_sched_changed(local, sdata, &sta->sta);
+	ret = local->ops->nan_peer_sched_changed(&local->hw, &sta->sta);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e3a051beba6a..23bf00472915 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2042,6 +2042,9 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata,
 /* NAN code */
 int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 				  struct cfg80211_nan_local_sched *sched);
+int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
+				 struct cfg80211_nan_peer_sched *sched);
+void ieee80211_nan_free_peer_sched(struct ieee80211_nan_peer_sched *sched);
 
 /* scan/BSS handling */
 void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work);
diff --git a/net/mac80211/nan.c b/net/mac80211/nan.c
index 2fa55e9a9dab..5e1f9bb7c49d 100644
--- a/net/mac80211/nan.c
+++ b/net/mac80211/nan.c
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * NAN mode implementation
- * Copyright(c) 2025 Intel Corporation
+ * Copyright(c) 2025-2026 Intel Corporation
  */
 #include <net/mac80211.h>
 
 #include "ieee80211_i.h"
 #include "driver-ops.h"
+#include "sta_info.h"
 
 static void
 ieee80211_nan_init_channel(struct ieee80211_nan_channel *nan_channel,
@@ -96,6 +97,82 @@ ieee80211_nan_use_chanctx(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static void
+ieee80211_nan_update_peer_channels(struct ieee80211_sub_if_data *sdata,
+				   struct ieee80211_chanctx_conf *removed_conf)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct sta_info *sta;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	list_for_each_entry(sta, &local->sta_list, list) {
+		struct ieee80211_nan_peer_sched *peer_sched;
+		int write_idx = 0;
+		bool updated = false;
+
+		if (sta->sdata != sdata)
+			continue;
+
+		peer_sched = sta->sta.nan_sched;
+		if (!peer_sched)
+			continue;
+
+		/* NULL out map slots for channels being removed */
+		for (int i = 0; i < peer_sched->n_channels; i++) {
+			if (peer_sched->channels[i].chanctx_conf != removed_conf)
+				continue;
+
+			for (int m = 0; m < CFG80211_NAN_MAX_PEER_MAPS; m++) {
+				struct ieee80211_nan_peer_map *map =
+					&peer_sched->maps[m];
+
+				if (map->map_id == CFG80211_NAN_INVALID_MAP_ID)
+					continue;
+
+				for (int s = 0; s < ARRAY_SIZE(map->slots); s++)
+					if (map->slots[s] == &peer_sched->channels[i])
+						map->slots[s] = NULL;
+			}
+		}
+
+		/* Compact channels array, removing those with removed_conf */
+		for (int i = 0; i < peer_sched->n_channels; i++) {
+			if (peer_sched->channels[i].chanctx_conf == removed_conf) {
+				updated = true;
+				continue;
+			}
+
+			if (write_idx != i) {
+				/* Update map pointers before moving */
+				for (int m = 0; m < CFG80211_NAN_MAX_PEER_MAPS; m++) {
+					struct ieee80211_nan_peer_map *map =
+						&peer_sched->maps[m];
+
+					if (map->map_id == CFG80211_NAN_INVALID_MAP_ID)
+						continue;
+
+					for (int s = 0; s < ARRAY_SIZE(map->slots); s++)
+						if (map->slots[s] == &peer_sched->channels[i])
+							map->slots[s] = &peer_sched->channels[write_idx];
+				}
+
+				peer_sched->channels[write_idx] = peer_sched->channels[i];
+			}
+			write_idx++;
+		}
+
+		/* Clear any remaining entries at the end */
+		for (int i = write_idx; i < peer_sched->n_channels; i++)
+			memset(&peer_sched->channels[i], 0, sizeof(peer_sched->channels[i]));
+
+		peer_sched->n_channels = write_idx;
+
+		if (updated)
+			drv_nan_peer_sched_changed(local, sdata, sta);
+	}
+}
+
 static void
 ieee80211_nan_remove_channel(struct ieee80211_sub_if_data *sdata,
 			     struct ieee80211_nan_channel *nan_channel)
@@ -118,6 +195,10 @@ ieee80211_nan_remove_channel(struct ieee80211_sub_if_data *sdata,
 
 	conf = nan_channel->chanctx_conf;
 
+	/* If any peer nan schedule uses this chanctx, update them */
+	if (conf)
+		ieee80211_nan_update_peer_channels(sdata, conf);
+
 	memset(nan_channel, 0, sizeof(*nan_channel));
 
 	/* Update the driver before (possibly) releasing the channel context */
@@ -376,3 +457,146 @@ void ieee80211_nan_sched_update_done(struct ieee80211_vif *vif)
 				       GFP_KERNEL);
 }
 EXPORT_SYMBOL(ieee80211_nan_sched_update_done);
+
+void ieee80211_nan_free_peer_sched(struct ieee80211_nan_peer_sched *sched)
+{
+	if (!sched)
+		return;
+
+	kfree(sched->init_ulw);
+	kfree(sched);
+}
+
+static int
+ieee80211_nan_init_peer_channel(struct ieee80211_sub_if_data *sdata,
+				const struct sta_info *sta,
+				const struct cfg80211_nan_channel *cfg_chan,
+				struct ieee80211_nan_channel *new_chan)
+{
+	struct ieee80211_nan_sched_cfg *sched_cfg = &sdata->vif.cfg.nan_sched;
+
+	/* Find compatible local channel */
+	for (int j = 0; j < ARRAY_SIZE(sched_cfg->channels); j++) {
+		struct ieee80211_nan_channel *local_chan =
+			&sched_cfg->channels[j];
+		const struct cfg80211_chan_def *compat;
+
+		if (!local_chan->chanreq.oper.chan)
+			continue;
+
+		compat = cfg80211_chandef_compatible(&local_chan->chanreq.oper,
+						     &cfg_chan->chandef);
+		if (!compat)
+			continue;
+
+		/* compat is the wider chandef, and we want the narrower one */
+		new_chan->chanreq.oper = compat == &local_chan->chanreq.oper ?
+					 cfg_chan->chandef : local_chan->chanreq.oper;
+		new_chan->needed_rx_chains = min(local_chan->needed_rx_chains,
+						 cfg_chan->rx_nss);
+		new_chan->chanctx_conf = local_chan->chanctx_conf;
+
+		break;
+	}
+
+	/*
+	 * nl80211 already validated that each peer channel is compatible
+	 * with at least one local channel, so this should never happen.
+	 */
+	if (WARN_ON(!new_chan->chanreq.oper.chan))
+		return -EINVAL;
+
+	memcpy(new_chan->channel_entry, cfg_chan->channel_entry,
+	       sizeof(new_chan->channel_entry));
+
+	return 0;
+}
+
+static void
+ieee80211_nan_init_peer_map(struct ieee80211_nan_peer_sched *peer_sched,
+			    const struct cfg80211_nan_peer_map *cfg_map,
+			    struct ieee80211_nan_peer_map *new_map)
+{
+	new_map->map_id = cfg_map->map_id;
+
+	if (new_map->map_id == CFG80211_NAN_INVALID_MAP_ID)
+		return;
+
+	/* Set up the slots array */
+	for (int slot = 0; slot < ARRAY_SIZE(new_map->slots); slot++) {
+		u8 chan_idx = cfg_map->schedule[slot];
+
+		if (chan_idx < peer_sched->n_channels)
+			new_map->slots[slot] = &peer_sched->channels[chan_idx];
+	}
+}
+
+int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
+				 struct cfg80211_nan_peer_sched *sched)
+{
+	struct ieee80211_nan_peer_sched *new_sched, *old_sched, *to_free;
+	struct sta_info *sta;
+	int ret;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	if (!sdata->u.nan.started)
+		return -EINVAL;
+
+	sta = sta_info_get(sdata, sched->peer_addr);
+	if (!sta)
+		return -ENOENT;
+
+	new_sched = kzalloc(struct_size(new_sched, channels, sched->n_channels),
+			    GFP_KERNEL);
+	if (!new_sched)
+		return -ENOMEM;
+
+	to_free = new_sched;
+
+	new_sched->seq_id = sched->seq_id;
+	new_sched->committed_dw = sched->committed_dw;
+	new_sched->max_chan_switch = sched->max_chan_switch;
+	new_sched->n_channels = sched->n_channels;
+
+	if (sched->ulw_size && sched->init_ulw) {
+		new_sched->init_ulw = kmemdup(sched->init_ulw, sched->ulw_size,
+					      GFP_KERNEL);
+		if (!new_sched->init_ulw) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		new_sched->ulw_size = sched->ulw_size;
+	}
+
+	for (int i = 0; i < sched->n_channels; i++) {
+		ret = ieee80211_nan_init_peer_channel(sdata, sta,
+						      &sched->nan_channels[i],
+						      &new_sched->channels[i]);
+		if (ret)
+			goto out;
+	}
+
+	for (int m = 0; m < ARRAY_SIZE(sched->maps); m++)
+		ieee80211_nan_init_peer_map(new_sched, &sched->maps[m],
+					    &new_sched->maps[m]);
+
+	/* Install the new schedule before calling the driver */
+	old_sched = sta->sta.nan_sched;
+	sta->sta.nan_sched = new_sched;
+
+	ret = drv_nan_peer_sched_changed(sdata->local, sdata, sta);
+	if (ret) {
+		/* Revert to old schedule */
+		sta->sta.nan_sched = old_sched;
+		goto out;
+	}
+
+	/* Success - free old schedule */
+	to_free = old_sched;
+	ret = 0;
+
+out:
+	ieee80211_nan_free_peer_sched(to_free);
+	return ret;
+}
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 017d91365920..dd0d92abf60d 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1309,6 +1309,10 @@ static int __must_check __sta_info_destroy_part1(struct sta_info *sta)
 				continue;
 			sta_info_destroy_addr(sta_iter->sdata, sta_iter->addr);
 		}
+
+		/* Free and clear the local peer schedule */
+		ieee80211_nan_free_peer_sched(sta->sta.nan_sched);
+		sta->sta.nan_sched = NULL;
 	}
 
 	/*
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index e5968d754f8b..71cf88039bd4 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3366,6 +3366,37 @@ TRACE_EVENT(drv_set_eml_op_mode,
 	)
 );
 
+TRACE_EVENT(drv_nan_peer_sched_changed,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_sta *sta),
+
+	TP_ARGS(local, sdata, sta),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		STA_ENTRY
+		__array(u8, map_ids, CFG80211_NAN_MAX_PEER_MAPS)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		STA_ASSIGN;
+		for (int i = 0; i < CFG80211_NAN_MAX_PEER_MAPS; i++)
+			__entry->map_ids[i] = sta->nan_sched ?
+					      sta->nan_sched->maps[i].map_id :
+					      0xff;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT
+		" map_ids=[%u, %u]",
+		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG,
+		__entry->map_ids[0], __entry->map_ids[1]
+	)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a352f73a7ec4..b093bc203c81 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1817,6 +1817,14 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 			if (WARN_ON(res))
 				return res;
 		}
+
+		/* Add peer schedules for NMI stations that have them */
+		if (!sta->sta.nan_sched)
+			continue;
+
+		res = drv_nan_peer_sched_changed(local, sdata, sta);
+		if (WARN_ON(res))
+			return res;
 	}
 
 	/* Add NDI stations (stations on NAN_DATA interfaces) */
-- 
2.34.1



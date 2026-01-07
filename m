Return-Path: <linux-wireless+bounces-30494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2566BCFE53B
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2505300A6ED
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD29343D84;
	Wed,  7 Jan 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="X7tu/yQo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1A341072
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795846; cv=none; b=FQpNTb38RvJxIQb7d6XzlVUdQIm5LLFtiksYwvx2PNZSI9sLLImW/Zx8m79iYlCOe2ZQDnzVAkXYIMc9vww9FRhwQEQQWwI++xuItHQ2ozSio4eNY2iJ3mXaEOP56zzKoffrjJx17cp8q32fTfa87IXggy0OQPzriIMIVHSK6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795846; c=relaxed/simple;
	bh=LPRG+b10z3D3n7z741Tj/+UqePSQnXtQmOggnHuPqU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHMo94gBaDv4f8eKCs8BTjO+1yGoVjj8tMqThrBKmgobTItGGhcyPphHFoYvwJlDVlMvME6Nmx0+FGI2BWikB9a7F9Ieb6KaN+uU61/frH30i053tHNnnt63tOop1t+O5UVF8p7Zq9VFk38F5fawSvvo/EgJgRAmzgGtl66P/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=X7tu/yQo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w5ZBn6N6MinqRRMeEjOKkRDRqzgvOdU4+jXheZcRHmM=;
	t=1767795844; x=1769005444; b=X7tu/yQoSRMEZh70DkJlclwUthCUshWJa+ndevmWJUrQ2i0
	p6P5RZ9oN0o+0aUdGKxNeEJaE5UufdOoiHZafEh/IqJNqeX6FBUq7RGx3uj6N/9ZNcKwaWhL+mqbf
	aGUEp5iUwqfFGcHz5CB3zcAhErydErVVuAmGkIdbTjxzciFwnAjGnVxKE7kyukyFznAi/stLfDtU3
	Wh703Cb4V6AnERa2FzISpEQ4ukWM6hN+C7Xs3RBO6QmSTOFhNuDsvsPfqd1jEwaAemgIBXKoJZ7sW
	wlMfCVJjSSQ8l9D7Na46VJOYZ9C2n/INIJgk/wnwvDxOBaJwt+MCJiNJtfKp696Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS8-00000005agF-40gz;
	Wed, 07 Jan 2026 15:24:01 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 32/46] wifi: mac80211: add NAN peer schedule support
Date: Wed,  7 Jan 2026 15:22:31 +0100
Message-ID: <20260107152325.97731859b4a8.I0345eb665be8ccf4a77eb1aca9a421eb8d2432e2@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

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
 include/net/mac80211.h     |  55 +++++++++++++++
 net/mac80211/cfg.c         |  13 ++++
 net/mac80211/driver-ops.h  |  21 ++++++
 net/mac80211/ieee80211_i.h |   3 +
 net/mac80211/nan.c         | 141 +++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.c    |   4 ++
 net/mac80211/trace.h       |  31 ++++++++
 net/mac80211/util.c        |   8 +++
 8 files changed, 276 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5f2c9e646942..530cd13b8c88 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -887,6 +887,49 @@ struct ieee80211_nan_channel {
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
@@ -2558,6 +2601,7 @@ struct ieee80211_link_sta {
  * @valid_links: bitmap of valid links, or 0 for non-MLO
  * @spp_amsdu: indicates whether the STA uses SPP A-MSDU or not.
  * @nmi: For NDI stations, pointer to the NMI station of the peer.
+ * @nan_sched: NAN peer schedule for this station. Valid only for NMI stations.
  */
 struct ieee80211_sta {
 	u8 addr[ETH_ALEN] __aligned(2);
@@ -2587,6 +2631,9 @@ struct ieee80211_sta {
 
 	struct ieee80211_sta __rcu *nmi;
 
+	/* should only be accessed with the wiphy mutex held */
+	struct ieee80211_nan_peer_sched *nan_sched;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -4484,6 +4531,12 @@ struct ieee80211_prep_tx_info {
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
@@ -4886,6 +4939,8 @@ struct ieee80211_ops {
 	void (*del_nan_func)(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
 			    u8 instance_id);
+	int (*nan_peer_sched_changed)(struct ieee80211_hw *hw,
+				      struct ieee80211_sta *sta);
 	bool (*can_aggregate_in_amsdu)(struct ieee80211_hw *hw,
 				       struct sk_buff *head,
 				       struct sk_buff *skb);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a735212e322a..e87f58a148bc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5625,6 +5625,18 @@ ieee80211_set_local_nan_sched(struct wiphy *wiphy,
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
@@ -5742,4 +5754,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.assoc_ml_reconf = ieee80211_assoc_ml_reconf,
 	.set_epcs = ieee80211_set_epcs,
 	.nan_set_local_sched = ieee80211_set_local_nan_sched,
+	.nan_set_peer_sched = ieee80211_set_peer_nan_sched,
 };
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 55105d238d6b..8d354054fe55 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1772,4 +1772,25 @@ drv_prep_add_interface(struct ieee80211_local *local,
 	trace_drv_return_void(local);
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
index 1786554f79cb..fc17c2e6a009 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2033,6 +2033,9 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata,
 /* NAN code */
 int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 				  struct cfg80211_nan_local_sched *sched);
+int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
+				 struct cfg80211_nan_peer_sched *sched);
+void ieee80211_nan_free_peer_sched(struct ieee80211_nan_peer_sched *sched);
 
 /* scan/BSS handling */
 void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work);
diff --git a/net/mac80211/nan.c b/net/mac80211/nan.c
index fa988c7a1b0e..be0c6c41da95 100644
--- a/net/mac80211/nan.c
+++ b/net/mac80211/nan.c
@@ -7,6 +7,7 @@
 
 #include "ieee80211_i.h"
 #include "driver-ops.h"
+#include "sta_info.h"
 
 static void
 ieee80211_nan_init_channel(struct ieee80211_nan_channel *nan_channel,
@@ -303,3 +304,143 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
 	return ret;
 }
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
+	/* Find compatible local channel */
+	for (int j = 0; j < ARRAY_SIZE(sdata->vif.cfg.nan_channels); j++) {
+		struct ieee80211_nan_channel *local_chan = &sdata->vif.cfg.nan_channels[j];
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
index 28577d03e3fb..8fdcc6fadc94 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1297,6 +1297,10 @@ static int __must_check __sta_info_destroy_part1(struct sta_info *sta)
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
index 0bfbce157486..8d5186c97a0f 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3353,6 +3353,37 @@ TRACE_EVENT(drv_prep_add_interface,
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
index 6185b5346066..d97afc50d306 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1807,6 +1807,14 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
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
2.52.0



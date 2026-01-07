Return-Path: <linux-wireless+bounces-30491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8B7CFE595
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46653021065
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12E8342CB8;
	Wed,  7 Jan 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oZ2lXxpu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4CD341072
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795842; cv=none; b=EmJNPZ75DQDEiTN7+TMZg1JbmkQUaqUiA3LKfKdaVdhLRLPkhm48uhgf7SoKsIoB7a7ojyAm6ioV7lOLaDnZdGjxqQo+KFpITj/SWbmg6uNzs5vlYzJNR5DO8vEdo2fGtxmgxnYUAXeZJpjQ1IMudpGAsJwp5RWhFVcK1RhQDSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795842; c=relaxed/simple;
	bh=OSsfPETZmxsc7j9BYqgf/9j1wKY9nVitkz/RxgAW7jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQmC6T5BXCb0Izp3oUYao/h602iPGPE+0b/KRlP7sh0NBOg9F8PDvjeQ1VM/7QF6nunqt2Jb/0yutvjOUMz04KmbMjf0/zTMUetVy/cibTwN8XTCRRz7YYDzHtitR+B7HhgZgVyUezAmEpNeKKyimMfWj7Y8e+v/bqTXRn3bUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oZ2lXxpu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bnwVavMy1zTqJUnwlGxhFIaYPW6L47Ur4T63S+60Xug=;
	t=1767795840; x=1769005440; b=oZ2lXxpu7Z0h/9IvWU6+XfhTH6U9qm+oL00aX6TeQoFe6ZR
	uBTcNlAvESkKgQM8VHl1gch5m/iJ9wb9qCrPwRitcE3tehk/7FVH9LDOyE8uI4xO7W91XTf5uXhWV
	TkzvWaWUqHMinAHJJuXYH5eJqfo/YMPHqn30tyZzWg2IyxBacjf5wNPPmc0Oav/cWoCb08UJwpbSF
	0uR6A8+TC3V5pb+e1VWQougOlCupbH+2lxKm69rUWFcpXRKn1uMEkzaJ/wmVq/6JK5A9axY4jTPpM
	Ptexxo5Gxjolf+q+ZyJwr5HmVyhh8+lsJwjF1EzliyOpojJRr4LX4RMrtXowW9XQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS5-00000005agF-3rEA;
	Wed, 07 Jan 2026 15:23:58 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 28/46] wifi: mac80211: add NAN local schedule support
Date: Wed,  7 Jan 2026 15:22:27 +0100
Message-ID: <20260107152325.95a7064dfbe3.Id158f815cfc9b5ab1ebdb8ee608bda426e4d7474@changeid>
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

A NAN local schedule consist of a list of NAN channels, and an array
that maps time slots to the channel it is scheduled to (or NULL to indicate
unscheduled).

A NAN channel is the configuration of a channel which is used for NAN
operations. It is a new type of chanctx user (before, the only user is a
link). A NAN channel may not have a chanctx assigned if it is ULWed out.

A NAN channel may or may not be scheduled (for example, user space
may want to prepare the resources before the actual schedule is
configured).

Add management of the NAN local schedule.

Since we introduce a new chanctx user, also adjust the different
for_each_chanctx_user_* macros to visit also the NAN channels and take
those into account.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  31 ++++
 net/mac80211/Makefile      |   2 +-
 net/mac80211/cfg.c         |  13 ++
 net/mac80211/chan.c        | 133 ++++++++++++----
 net/mac80211/ieee80211_i.h |  16 +-
 net/mac80211/iface.c       |   4 +
 net/mac80211/nan.c         | 305 +++++++++++++++++++++++++++++++++++++
 net/mac80211/util.c        |  28 ++--
 8 files changed, 493 insertions(+), 39 deletions(-)
 create mode 100644 net/mac80211/nan.c

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f5abc0297e7f..13eefe64b76e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -365,6 +365,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_MLD_VALID_LINKS: MLD valid links status changed.
  * @BSS_CHANGED_MLD_TTLM: negotiated TID to link mapping was changed
  * @BSS_CHANGED_TPE: transmit power envelope changed
+ * @BSS_CHANGED_NAN_LOCAL_SCHED: NAN local schedule changed (NAN mode only)
  */
 enum ieee80211_bss_change {
 	BSS_CHANGED_ASSOC		= 1<<0,
@@ -402,6 +403,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_MLD_VALID_LINKS	= BIT_ULL(33),
 	BSS_CHANGED_MLD_TTLM		= BIT_ULL(34),
 	BSS_CHANGED_TPE			= BIT_ULL(35),
+	BSS_CHANGED_NAN_LOCAL_SCHED	= BIT_ULL(36),
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -863,6 +865,28 @@ struct ieee80211_bss_conf {
 	u8 s1g_long_beacon_period;
 };
 
+#define IEEE80211_NAN_MAX_CHANNELS 3
+
+/**
+ * struct ieee80211_nan_channel - NAN channel information
+ *
+ * @chanreq: channel request for this NAN channel. Even though this chanreq::ap
+ *	is irrelevant for NAN, still store it for convenience - some functions
+ *	require it as an argument.
+ * @needed_rx_chains: number of RX chains needed for this NAN channel
+ * @chanctx_conf: chanctx_conf assigned to this NAN channel. Will be %NULL
+ *	if the channel is ULWed.
+ * @channel_entry: the Channel Entry blob as defined in Wi-Fi Aware
+ *	(TM) 4.0 specification Table 100 (Channel Entry format for the NAN
+ *	Availability attribute).
+ */
+struct ieee80211_nan_channel {
+	struct ieee80211_chan_req chanreq;
+	u8 needed_rx_chains;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+	u8 channel_entry[6];
+};
+
 /**
  * enum mac80211_tx_info_flags - flags to describe transmission information/status
  *
@@ -1930,6 +1954,10 @@ enum ieee80211_offload_flags {
  *	your driver/device needs to do.
  * @ap_addr: AP MLD address, or BSSID for non-MLO connections
  *	(station mode only)
+ * @nan_channels: array of NAN channels. A channel slot is in use if
+ *	nan_channels[i].chanreq.oper.chan is not NULL.
+ * @nan_schedule: NAN local schedule - mapping of each 16TU time slot to
+ *	the NAN channel on which the radio will operate. NULL if unscheduled.
  */
 struct ieee80211_vif_cfg {
 	/* association related data */
@@ -1948,6 +1976,9 @@ struct ieee80211_vif_cfg {
 	bool s1g;
 	bool idle;
 	u8 ap_addr[ETH_ALEN] __aligned(2);
+	/* These are protected by the wiphy mutex */
+	struct ieee80211_nan_channel nan_channels[IEEE80211_NAN_MAX_CHANNELS];
+	struct ieee80211_nan_channel *nan_schedule[CFG80211_NAN_SCHED_NUM_TIME_SLOTS];
 };
 
 #define IEEE80211_TTLM_NUM_TIDS 8
diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index a33884967f21..228390901dba 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -36,7 +36,7 @@ mac80211-y := \
 	tdls.o \
 	ocb.o \
 	airtime.o \
-	eht.o
+	eht.o nan.o
 
 mac80211-$(CONFIG_MAC80211_LEDS) += led.o
 mac80211-$(CONFIG_MAC80211_DEBUGFS) += \
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d23a9ffa2b2c..7eb9f651c03b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5538,6 +5538,18 @@ ieee80211_set_epcs(struct wiphy *wiphy, struct net_device *dev, bool enable)
 	return ieee80211_mgd_set_epcs(sdata, enable);
 }
 
+static int
+ieee80211_set_local_nan_sched(struct wiphy *wiphy,
+			      struct wireless_dev *wdev,
+			      struct cfg80211_nan_local_sched *sched)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+
+	lockdep_assert_wiphy(wiphy);
+
+	return ieee80211_nan_set_local_sched(sdata, sched);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -5654,4 +5666,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.get_radio_mask = ieee80211_get_radio_mask,
 	.assoc_ml_reconf = ieee80211_assoc_ml_reconf,
 	.set_epcs = ieee80211_set_epcs,
+	.nan_set_local_sched = ieee80211_set_local_nan_sched,
 };
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 758d0dc1a94c..09cf205e08eb 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -16,6 +16,8 @@ struct ieee80211_chanctx_user_iter {
 	struct ieee80211_chan_req *chanreq;
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_link_data *link;
+	struct ieee80211_nan_channel *nan_channel;
+	int nan_channel_next_idx;
 	enum nl80211_iftype iftype;
 	bool reserved, radar_required, done;
 	enum {
@@ -31,20 +33,38 @@ enum ieee80211_chanctx_iter_type {
 	CHANCTX_ITER_ASSIGNED,
 };
 
-static void ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
-					     struct ieee80211_chanctx *ctx,
-					     struct ieee80211_chanctx_user_iter *iter,
-					     enum ieee80211_chanctx_iter_type type,
-					     bool start)
+static bool
+ieee80211_chanctx_user_iter_next_nan_channel(struct ieee80211_chanctx *ctx,
+					     struct ieee80211_chanctx_user_iter *iter)
 {
-	lockdep_assert_wiphy(local->hw.wiphy);
+	/* Start from the next index after current position */
+	for (int i = iter->nan_channel_next_idx;
+	     i < ARRAY_SIZE(iter->sdata->vif.cfg.nan_channels); i++) {
+		struct ieee80211_nan_channel *nan_channel =
+			&iter->sdata->vif.cfg.nan_channels[i];
 
-	if (start) {
-		memset(iter, 0, sizeof(*iter));
-		goto next_interface;
+		if (!nan_channel->chanreq.oper.chan)
+			continue;
+
+		if (nan_channel->chanctx_conf != &ctx->conf)
+			continue;
+
+		iter->nan_channel = nan_channel;
+		iter->nan_channel_next_idx = i + 1;
+		iter->chanreq = &nan_channel->chanreq;
+		iter->link = NULL;
+		iter->reserved = false;
+		iter->radar_required = false;
+		return true;
 	}
+	return false;
+}
 
-next_link:
+static bool
+ieee80211_chanctx_user_iter_next_link(struct ieee80211_chanctx *ctx,
+				      struct ieee80211_chanctx_user_iter *iter,
+				      enum ieee80211_chanctx_iter_type type)
+{
 	for (int link_id = iter->link ? iter->link->link_id : 0;
 	     link_id < ARRAY_SIZE(iter->sdata->link);
 	     link_id++) {
@@ -64,7 +84,7 @@ static void ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
 				iter->reserved = false;
 				iter->radar_required = link->radar_required;
 				iter->chanreq = &link->conf->chanreq;
-				return;
+				return true;
 			}
 			fallthrough;
 		case CHANCTX_ITER_POS_RESERVED:
@@ -77,7 +97,7 @@ static void ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
 					link->reserved_radar_required;
 
 				iter->chanreq = &link->reserved;
-				return;
+				return true;
 			}
 			fallthrough;
 		case CHANCTX_ITER_POS_DONE:
@@ -85,6 +105,33 @@ static void ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
 			continue;
 		}
 	}
+	return false;
+}
+
+static void
+ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
+				 struct ieee80211_chanctx *ctx,
+				 struct ieee80211_chanctx_user_iter *iter,
+				 enum ieee80211_chanctx_iter_type type,
+				 bool start)
+{
+	bool found;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (start) {
+		memset(iter, 0, sizeof(*iter));
+		goto next_interface;
+	}
+
+next_user:
+	if (iter->iftype == NL80211_IFTYPE_NAN)
+		found = ieee80211_chanctx_user_iter_next_nan_channel(ctx, iter);
+	else
+		found = ieee80211_chanctx_user_iter_next_link(ctx, iter, type);
+
+	if (found)
+		return;
 
 next_interface:
 	/* next (or first) interface */
@@ -94,10 +141,18 @@ static void ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
 		if (iter->sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 			continue;
 
+		/* NAN channels don't reserve channel context */
+		if (iter->sdata->vif.type == NL80211_IFTYPE_NAN &&
+		    type == CHANCTX_ITER_RESERVED)
+			continue;
+
+		iter->nan_channel = NULL;
 		iter->link = NULL;
-		iter->per_link = CHANCTX_ITER_POS_ASSIGNED;
 		iter->iftype = iter->sdata->vif.type;
-		goto next_link;
+		iter->chanreq = NULL;
+		iter->per_link = CHANCTX_ITER_POS_ASSIGNED;
+		iter->nan_channel_next_idx = 0;
+		goto next_user;
 	}
 
 	iter->done = true;
@@ -130,8 +185,8 @@ static void ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
 					      CHANCTX_ITER_ALL,		\
 					      false))
 
-static int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
-					  struct ieee80211_chanctx *ctx)
+int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
+				   struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_chanctx_user_iter iter;
 	int num = 0;
@@ -297,7 +352,7 @@ ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	for_each_chanctx_user_assigned(local, ctx, &iter) {
-		if (iter.link->reserved_chanctx)
+		if (iter.link && iter.link->reserved_chanctx)
 			continue;
 
 		comp_def = ieee80211_chanreq_compatible(iter.chanreq,
@@ -456,7 +511,6 @@ ieee80211_get_width_of_link(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_AP_VLAN:
 		return ieee80211_get_max_required_bw(link);
 	case NL80211_IFTYPE_P2P_DEVICE:
-	case NL80211_IFTYPE_NAN:
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		WARN_ON_ONCE(!ieee80211_hw_check(&local->hw,
@@ -471,6 +525,7 @@ ieee80211_get_width_of_link(struct ieee80211_link_data *link)
 	case NUM_NL80211_IFTYPES:
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_NAN_DATA:
 		WARN_ON_ONCE(1);
 		break;
@@ -480,6 +535,18 @@ ieee80211_get_width_of_link(struct ieee80211_link_data *link)
 	return NL80211_CHAN_WIDTH_20_NOHT;
 }
 
+static enum nl80211_chan_width
+ieee80211_get_width_of_chanctx_user(struct ieee80211_chanctx_user_iter *iter)
+{
+	if (iter->link)
+		return ieee80211_get_width_of_link(iter->link);
+
+	if (WARN_ON_ONCE(!iter->nan_channel || iter->reserved))
+		return NL80211_CHAN_WIDTH_20_NOHT;
+
+	return iter->nan_channel->chanreq.oper.width;
+}
+
 static enum nl80211_chan_width
 ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
@@ -497,7 +564,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 	/* When this is true we only care about the reserving links */
 	if (check_reserved) {
 		for_each_chanctx_user_reserved(local, ctx, &iter) {
-			width = ieee80211_get_width_of_link(iter.link);
+			width = ieee80211_get_width_of_chanctx_user(&iter);
 			max_bw = max(max_bw, width);
 		}
 		goto check_monitor;
@@ -505,7 +572,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 
 	/* Consider all assigned links */
 	for_each_chanctx_user_assigned(local, ctx, &iter) {
-		width = ieee80211_get_width_of_link(iter.link);
+		width = ieee80211_get_width_of_chanctx_user(&iter);
 		max_bw = max(max_bw, width);
 	}
 
@@ -916,7 +983,10 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
 		kfree(ctx);
 		return ERR_PTR(err);
 	}
-	/* We ignored a driver error, see _ieee80211_set_active_links */
+	/*
+	 * We ignored a driver error, see _ieee80211_set_active_links and/or
+	 * ieee80211_nan_set_local_sched
+	 */
 	WARN_ON_ONCE(err && !local->in_reconfig);
 
 	list_add_rcu(&ctx->list, &local->chanctx_list);
@@ -937,9 +1007,9 @@ static void ieee80211_del_chanctx(struct ieee80211_local *local,
 	ieee80211_remove_wbrf(local, &ctx->conf.def);
 }
 
-static void ieee80211_free_chanctx(struct ieee80211_local *local,
-				   struct ieee80211_chanctx *ctx,
-				   bool skip_idle_recalc)
+void ieee80211_free_chanctx(struct ieee80211_local *local,
+			    struct ieee80211_chanctx *ctx,
+			    bool skip_idle_recalc)
 {
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1144,6 +1214,15 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 			break;
 		}
 
+		if (iter.nan_channel) {
+			rx_chains_dynamic = rx_chains_static =
+				iter.nan_channel->needed_rx_chains;
+			break;
+		}
+
+		if (!iter.link)
+			continue;
+
 		switch (iter.link->smps_mode) {
 		default:
 			WARN_ONCE(1, "Invalid SMPS mode %d\n",
@@ -1752,7 +1831,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 		for_each_chanctx_user_assigned(local, ctx->replace_ctx, &iter) {
 			n_assigned++;
-			if (iter.link->reserved_chanctx) {
+			if (iter.link && iter.link->reserved_chanctx) {
 				n_reserved++;
 				if (iter.link->reserved_ready)
 					n_ready++;
@@ -2008,7 +2087,7 @@ void __ieee80211_link_release_channel(struct ieee80211_link_data *link,
 		ieee80211_vif_use_reserved_switch(local);
 }
 
-static struct ieee80211_chanctx *
+struct ieee80211_chanctx *
 ieee80211_find_or_create_chanctx(struct ieee80211_sub_if_data *sdata,
 				 const struct ieee80211_chan_req *chanreq,
 				 enum ieee80211_chanctx_mode mode,
@@ -2194,7 +2273,7 @@ ieee80211_chanctx_recheck(struct ieee80211_local *local,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	for_each_chanctx_user_all(local, ctx, &iter) {
-		if (iter.link == skip_link)
+		if (iter.link && iter.link == skip_link)
 			continue;
 
 		ret = ieee80211_chanreq_compatible(ret, iter.chanreq, tmp);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 71fc775483e2..9815b56771c1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2019,6 +2019,10 @@ int ieee80211_mesh_csa_beacon(struct ieee80211_sub_if_data *sdata,
 int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata,
 			      u64 *changed);
 
+/* NAN code */
+int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
+				  struct cfg80211_nan_local_sched *sched);
+
 /* scan/BSS handling */
 void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work);
 int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
@@ -2792,7 +2796,17 @@ int ieee80211_max_num_channels(struct ieee80211_local *local, int radio_idx);
 u32 ieee80211_get_radio_mask(struct wiphy *wiphy, struct net_device *dev);
 void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 				       struct ieee80211_chanctx *ctx);
-
+struct ieee80211_chanctx *
+ieee80211_find_or_create_chanctx(struct ieee80211_sub_if_data *sdata,
+				 const struct ieee80211_chan_req *chanreq,
+				 enum ieee80211_chanctx_mode mode,
+				 bool assign_on_failure,
+				 bool *reused_ctx);
+void ieee80211_free_chanctx(struct ieee80211_local *local,
+			    struct ieee80211_chanctx *ctx,
+			    bool skip_idle_recalc);
+int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
+				   struct ieee80211_chanctx *ctx);
 /* TDLS */
 int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 			const u8 *peer, int link_id,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 65466daebdba..3fb09ca49276 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -882,6 +882,10 @@ static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
 
 	ieee80211_vif_clear_links(sdata);
 	ieee80211_link_stop(&sdata->deflink);
+
+	if (sdata->vif.type == NL80211_IFTYPE_NAN)
+		for (int i = 0; i < ARRAY_SIZE(sdata->vif.cfg.nan_channels); i++)
+			WARN_ON(sdata->vif.cfg.nan_channels[i].chanreq.oper.chan);
 }
 
 static void ieee80211_uninit(struct net_device *dev)
diff --git a/net/mac80211/nan.c b/net/mac80211/nan.c
new file mode 100644
index 000000000000..fa988c7a1b0e
--- /dev/null
+++ b/net/mac80211/nan.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NAN mode implementation
+ * Copyright(c) 2025 Intel Corporation
+ */
+#include <net/mac80211.h>
+
+#include "ieee80211_i.h"
+#include "driver-ops.h"
+
+static void
+ieee80211_nan_init_channel(struct ieee80211_nan_channel *nan_channel,
+			   struct cfg80211_nan_channel *cfg_nan_channel)
+{
+	memset(nan_channel, 0, sizeof(*nan_channel));
+
+	nan_channel->chanreq.oper = cfg_nan_channel->chandef;
+	memcpy(nan_channel->channel_entry, cfg_nan_channel->channel_entry,
+	       sizeof(nan_channel->channel_entry));
+	nan_channel->needed_rx_chains = cfg_nan_channel->rx_nss;
+}
+
+static void
+ieee80211_nan_update_channel(struct ieee80211_local *local,
+			     struct ieee80211_nan_channel *nan_channel,
+			     struct cfg80211_nan_channel *cfg_nan_channel)
+{
+	struct ieee80211_chanctx_conf *conf;
+
+	if (WARN_ON(!cfg80211_chandef_identical(&nan_channel->chanreq.oper,
+						&cfg_nan_channel->chandef)))
+		return;
+
+	if (WARN_ON(memcmp(nan_channel->channel_entry,
+			   cfg_nan_channel->channel_entry,
+			   sizeof(nan_channel->channel_entry))))
+		return;
+
+	if (nan_channel->needed_rx_chains == cfg_nan_channel->rx_nss)
+		return;
+
+	nan_channel->needed_rx_chains = cfg_nan_channel->rx_nss;
+
+	conf = nan_channel->chanctx_conf;
+	if (!conf)
+		return;
+
+	ieee80211_recalc_smps_chanctx(local, container_of(conf,
+							  struct ieee80211_chanctx,
+							  conf));
+}
+
+static int
+ieee80211_nan_use_chanctx(struct ieee80211_sub_if_data *sdata,
+			  struct ieee80211_nan_channel *nan_channel,
+			  bool assign_on_failure)
+{
+	struct ieee80211_chanctx *ctx;
+	bool reused_ctx;
+
+	if (!nan_channel->chanreq.oper.chan)
+		return -EINVAL;
+
+	if (ieee80211_check_combinations(sdata, &nan_channel->chanreq.oper,
+					 IEEE80211_CHANCTX_SHARED, 0, -1))
+		return -EBUSY;
+
+	ctx = ieee80211_find_or_create_chanctx(sdata, &nan_channel->chanreq,
+					       IEEE80211_CHANCTX_SHARED,
+					       assign_on_failure,
+					       &reused_ctx);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	nan_channel->chanctx_conf = &ctx->conf;
+
+	/*
+	 * In case an existing channel context is being used, we marked it as
+	 * will_be_used, now that it is assigned - clear this indication
+	 */
+	if (reused_ctx) {
+		WARN_ON(!ctx->will_be_used);
+		ctx->will_be_used = false;
+	}
+	ieee80211_recalc_chanctx_min_def(sdata->local, ctx);
+	ieee80211_recalc_smps_chanctx(sdata->local, ctx);
+
+	return 0;
+}
+
+static void
+ieee80211_nan_remove_channel(struct ieee80211_sub_if_data *sdata,
+			     struct ieee80211_nan_channel *nan_channel)
+{
+	struct ieee80211_chanctx_conf *conf;
+	struct ieee80211_chanctx *ctx;
+
+	if (WARN_ON(!nan_channel))
+		return;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	if (!nan_channel->chanreq.oper.chan)
+		return;
+
+	for (int slot = 0; slot < ARRAY_SIZE(sdata->vif.cfg.nan_schedule); slot++)
+		if (sdata->vif.cfg.nan_schedule[slot] == nan_channel)
+			sdata->vif.cfg.nan_schedule[slot] = NULL;
+
+	conf = nan_channel->chanctx_conf;
+
+	memset(nan_channel, 0, sizeof(*nan_channel));
+
+	/* Update the driver before (possibly) releasing the channel context */
+	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
+
+	/* Channel might not have a chanctx if it was ULWed */
+	if (!conf)
+		return;
+
+	ctx = container_of(conf, struct ieee80211_chanctx, conf);
+
+	if (ieee80211_chanctx_num_assigned(sdata->local, ctx) > 0) {
+		ieee80211_recalc_chanctx_chantype(sdata->local, ctx);
+		ieee80211_recalc_smps_chanctx(sdata->local, ctx);
+		ieee80211_recalc_chanctx_min_def(sdata->local, ctx);
+	}
+
+	if (ieee80211_chanctx_refcount(sdata->local, ctx) == 0)
+		ieee80211_free_chanctx(sdata->local, ctx, false);
+}
+
+struct ieee80211_nan_slots_bitmap {
+	DECLARE_BITMAP(map, CFG80211_NAN_SCHED_NUM_TIME_SLOTS);
+};
+
+static struct ieee80211_nan_slots_bitmap
+ieee80211_get_channel_schedule(struct ieee80211_sub_if_data *sdata,
+			       struct ieee80211_nan_channel *chan)
+{
+	struct ieee80211_nan_slots_bitmap schedule = {};
+
+	for (int slot = 0; slot < ARRAY_SIZE(sdata->vif.cfg.nan_schedule); slot++) {
+		if (sdata->vif.cfg.nan_schedule[slot] == chan)
+			__set_bit(slot, schedule.map);
+	}
+
+	return schedule;
+}
+
+static int
+ieee80211_nan_find_existing_channel(struct ieee80211_nan_channel *channels,
+				    const struct cfg80211_chan_def *chandef)
+{
+	for (int i = 0; i < IEEE80211_NAN_MAX_CHANNELS; i++) {
+		if (!channels[i].chanreq.oper.chan)
+			break;
+
+		if (cfg80211_chandef_identical(&channels[i].chanreq.oper,
+					       chandef))
+			return i;
+	}
+
+	return -ENOENT;
+}
+
+int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
+				  struct cfg80211_nan_local_sched *sched)
+{
+	struct ieee80211_nan_slots_bitmap backup_schedules[IEEE80211_NAN_MAX_CHANNELS] = {};
+	struct ieee80211_nan_channel backup_channels[IEEE80211_NAN_MAX_CHANNELS] = {};
+	DECLARE_BITMAP(removed_channels, IEEE80211_NAN_MAX_CHANNELS) = {};
+	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
+	int ret;
+
+	if (sched->n_channels > IEEE80211_NAN_MAX_CHANNELS)
+		return -EOPNOTSUPP;
+
+	/* Backup all existing channels and their schedules */
+	for (int i = 0; i < ARRAY_SIZE(vif_cfg->nan_channels); i++) {
+		if (!vif_cfg->nan_channels[i].chanreq.oper.chan)
+			break;
+
+		backup_channels[i] = vif_cfg->nan_channels[i];
+		backup_schedules[i] =
+			ieee80211_get_channel_schedule(sdata,
+						       &vif_cfg->nan_channels[i]);
+	}
+
+	/*
+	 * Remove channels that are no longer in the new schedule to free up
+	 * resources before adding new channels.
+	 */
+	for (int i = 0; i < ARRAY_SIZE(vif_cfg->nan_channels); i++) {
+		bool still_needed = false;
+
+		if (!vif_cfg->nan_channels[i].chanreq.oper.chan)
+			break;
+
+		for (int j = 0; j < sched->n_channels; j++) {
+			if (cfg80211_chandef_identical(&vif_cfg->nan_channels[i].chanreq.oper,
+						       &sched->nan_channels[j].chandef)) {
+				still_needed = true;
+				break;
+			}
+		}
+
+		if (!still_needed) {
+			__set_bit(i, removed_channels);
+			ieee80211_nan_remove_channel(sdata, &vif_cfg->nan_channels[i]);
+		}
+	}
+
+	/* Clear the channel array and schedule, we'll rebuild them */
+	memset(&vif_cfg->nan_schedule, 0, sizeof(vif_cfg->nan_schedule));
+	memset(&vif_cfg->nan_channels, 0, sizeof(vif_cfg->nan_channels));
+
+	for (int i = 0; i < sched->n_channels; i++) {
+		struct ieee80211_nan_channel *chan = &vif_cfg->nan_channels[i];
+		int existing_idx =
+			ieee80211_nan_find_existing_channel(backup_channels,
+							    &sched->nan_channels[i].chandef);
+
+		if (existing_idx >= 0) {
+			*chan = backup_channels[existing_idx];
+			ieee80211_nan_update_channel(sdata->local, chan,
+						     &sched->nan_channels[i]);
+		} else {
+			ieee80211_nan_init_channel(chan,
+						   &sched->nan_channels[i]);
+
+			ret = ieee80211_nan_use_chanctx(sdata, chan, false);
+			if (ret) {
+				memset(chan, 0, sizeof(*chan));
+				goto err;
+			}
+		}
+
+		for (int s = 0; s < ARRAY_SIZE(sched->schedule); s++)
+			if (sched->schedule[s] == i)
+				vif_cfg->nan_schedule[s] = chan;
+	}
+
+	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
+
+	return 0;
+err:
+	/* Remove newly added channels */
+	for (int i = 0; i < ARRAY_SIZE(vif_cfg->nan_channels); i++) {
+		struct cfg80211_chan_def *chan_def = &vif_cfg->nan_channels[i].chanreq.oper;
+
+		if (!chan_def->chan)
+			break;
+
+		if (ieee80211_nan_find_existing_channel(backup_channels,
+							chan_def) < 0)
+			ieee80211_nan_remove_channel(sdata,
+						     &vif_cfg->nan_channels[i]);
+	}
+
+	memset(&vif_cfg->nan_schedule, 0, sizeof(vif_cfg->nan_schedule));
+	memset(&vif_cfg->nan_channels, 0, sizeof(vif_cfg->nan_channels));
+
+	/* Re-add all backed up channels */
+	for (int i = 0; i < ARRAY_SIZE(backup_channels); i++) {
+		struct ieee80211_nan_channel *chan = &vif_cfg->nan_channels[i];
+		int slot;
+
+		if (!backup_channels[i].chanreq.oper.chan)
+			break;
+
+		*chan = backup_channels[i];
+
+		if (!chan->chanctx_conf)
+			continue;
+
+		if (test_bit(i, removed_channels)) {
+			/* Clear the stale chanctx pointer */
+			chan->chanctx_conf = NULL;
+			/*
+			 * We removed the newly added channels so we don't lack
+			 * resources. So the only reason that this would fail
+			 * is a FW error which we ignore. Therefore, this
+			 * should never fail.
+			 */
+			WARN_ON(ieee80211_nan_use_chanctx(sdata, chan, true));
+		} else {
+			struct ieee80211_chanctx_conf *conf = chan->chanctx_conf;
+
+			/* FIXME: detect no-op? */
+			/* Channel was not removed but may have been updated */
+			ieee80211_recalc_smps_chanctx(sdata->local,
+						     container_of(conf,
+								  struct ieee80211_chanctx,
+								  conf));
+		}
+
+		for_each_set_bit(slot, backup_schedules[i].map,
+				 CFG80211_NAN_SCHED_NUM_TIME_SLOTS)
+			vif_cfg->nan_schedule[slot] = chan;
+	}
+
+	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
+	return ret;
+}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 3b609fb36907..d31d393784b6 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1732,20 +1732,12 @@ static void ieee80211_reconfig_stations(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
-static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
+static int
+ieee80211_reconfig_nan_offload_de(struct ieee80211_sub_if_data *sdata)
 {
 	struct cfg80211_nan_func *func, **funcs;
 	int res, id, i = 0;
 
-	res = drv_start_nan(sdata->local, sdata,
-			    &sdata->u.nan.conf);
-	if (WARN_ON(res))
-		return res;
-
-	if (sdata->local->hw.wiphy->nan_capa.flags &
-	    WIPHY_NAN_FLAGS_USERSPACE_DE)
-		return 0;
-
 	funcs = kcalloc(sdata->local->hw.max_nan_de_entries + 1,
 			sizeof(*funcs),
 			GFP_KERNEL);
@@ -1773,6 +1765,22 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 	}
 
 	kfree(funcs);
+	return res;
+}
+
+static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
+{
+	int res;
+
+	res = drv_start_nan(sdata->local, sdata,
+			    &sdata->u.nan.conf);
+	if (WARN_ON(res))
+		return res;
+
+	if (!(sdata->local->hw.wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return ieee80211_reconfig_nan_offload_de(sdata);
+
+	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
 
 	return 0;
 }
-- 
2.52.0



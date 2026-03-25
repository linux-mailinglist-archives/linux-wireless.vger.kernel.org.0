Return-Path: <linux-wireless+bounces-33877-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCJjL9dQxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33877-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F50532C52B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B1E330786E0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458737B02B;
	Wed, 25 Mar 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dg7fnOHn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6BC356A3C
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473360; cv=none; b=ESE+qq4pB+mwet9b4hpX5Bv8RqrQHPrcgGuHoszYDRTb8N8pOLOQWZWXrcSj3WhR7TxKvUxloLGoATSta26EWOYZH6dF90b1cwhgUclPfJbjgo3ScCMoiVR/3LeQ0Z7CjBk36T8mcTkGwUiCBG7r7WbpL/Zg/NzZOeqgLKlK2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473360; c=relaxed/simple;
	bh=cI4+37q1OMJJPyjFJaQZadwpIR1hSOr/KnVvLRNm6kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZ7oFoMpoRxdug3QdV5LqO/gKUTCiXvMFj5YPDcFUJHXATV7a0QMSDLd061HPp4/BEXCX/hPKwGR1dn6xAfHscuqRGU9fxLSu4nPzphMhotQwdrJPmQ+Fpo4N49GSk6Yzl48HTffCCKj/nmpA7KvRtzwxdrMYsZcDZny+jj9s2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dg7fnOHn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473358; x=1806009358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cI4+37q1OMJJPyjFJaQZadwpIR1hSOr/KnVvLRNm6kw=;
  b=dg7fnOHn4BnJduEAvqH2tE2iqXfCVp3nATr2ZY4riR11yoSokyXwoorm
   SbsxkopC4uLz9D8AWq/dAJIfhr783wx6j811vB2u7tbdKi7OwieIj8lB8
   hpz9vQZ0OUw0lalJWB6MVtU1f21aCHTBw0/1L8lOxBGkEDKpZKF52kY9V
   NQBF0rTlVhGPB+M3lSXtgEjmq6zuc0+3WHcsat+gHliJqPIcyX5q9FqDc
   EBsvXrw9+sSw0DmEqjHCogvCHV7sAC+Crwik90k9bC+Tq2u9wmgOYd5Si
   rz1taam464UvT/nYpUW9Q3OtiAyukQLehYofdOWI683HemPEQSXBBXxeT
   w==;
X-CSE-ConnectionGUID: 5AyaTBfxTeCz86iUpN+LMQ==
X-CSE-MsgGUID: 7V4ErVT9TwOJfkg9/44zOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485363"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485363"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:58 -0700
X-CSE-ConnectionGUID: iGs65be6QfODx9BfGgExZQ==
X-CSE-MsgGUID: vFfNt0OZSlKso7ZMJLwsYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747490"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 05/15] wifi: mac80211: add NAN local schedule support
Date: Wed, 25 Mar 2026 23:15:26 +0200
Message-Id: <20260325230443.06d35b3f5e09.Id158f815cfc9b5ab1ebdb8ee608bda426e4d7474@changeid>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33877-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iter.link:url]
X-Rspamd-Queue-Id: 6F50532C52B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Co-developed-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  66 +++++++
 net/mac80211/Makefile      |   2 +-
 net/mac80211/cfg.c         |  13 ++
 net/mac80211/chan.c        | 132 ++++++++++---
 net/mac80211/ieee80211_i.h |  20 +-
 net/mac80211/iface.c       |   8 +
 net/mac80211/nan.c         | 378 +++++++++++++++++++++++++++++++++++++
 net/mac80211/util.c        |  28 ++-
 8 files changed, 609 insertions(+), 38 deletions(-)
 create mode 100644 net/mac80211/nan.c

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ff862d54eb77..24685f106757 100644
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
@@ -866,6 +868,28 @@ struct ieee80211_bss_conf {
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
@@ -1917,6 +1941,8 @@ enum ieee80211_offload_flags {
 	IEEE80211_OFFLOAD_DECAP_ENABLED		= BIT(2),
 };
 
+#define IEEE80211_NAN_AVAIL_BLOB_MAX_LEN	54
+
 /**
  * struct ieee80211_eml_params - EHT Operating mode notification parameters
  *
@@ -1942,6 +1968,32 @@ struct ieee80211_eml_params {
 	u8 emlmr_mcs_map_bw[9];
 };
 
+/**
+ * struct ieee80211_nan_sched_cfg - NAN schedule configuration
+ * @channels: array of NAN channels. A channel entry is in use if
+ *	channels[i].chanreq.oper.chan is not NULL.
+ * @schedule: NAN local schedule - mapping of each 16TU time slot to
+ *	the NAN channel on which the radio will operate. NULL if unscheduled.
+ * @avail_blob: NAN Availability attribute blob.
+ * @avail_blob_len: length of the @avail_blob in bytes.
+ * @deferred: indicates that the driver should notify peers before applying the
+ *	new NAN schedule, and apply the new schedule the second NAN Slot
+ *	boundary after it notified the peers, as defined in Wi-Fi Aware (TM) 4.0
+ *	specification, section 5.2.2.
+ *	The driver must call ieee80211_nan_sched_update_done() after the
+ *	schedule has been applied.
+ *	If a HW restart happened while a deferred schedule update was pending,
+ *	mac80211 will reconfigure the deferred schedule (and wait for the driver
+ *	to notify that the schedule has been applied).
+ */
+struct ieee80211_nan_sched_cfg {
+	struct ieee80211_nan_channel channels[IEEE80211_NAN_MAX_CHANNELS];
+	struct ieee80211_nan_channel *schedule[CFG80211_NAN_SCHED_NUM_TIME_SLOTS];
+	u8 avail_blob[IEEE80211_NAN_AVAIL_BLOB_MAX_LEN];
+	u16 avail_blob_len;
+	bool deferred;
+};
+
 /**
  * struct ieee80211_vif_cfg - interface configuration
  * @assoc: association status
@@ -1970,6 +2022,7 @@ struct ieee80211_eml_params {
  *	your driver/device needs to do.
  * @ap_addr: AP MLD address, or BSSID for non-MLO connections
  *	(station mode only)
+ * @nan_sched: NAN schedule parameters. &struct ieee80211_nan_sched_cfg
  */
 struct ieee80211_vif_cfg {
 	/* association related data */
@@ -1988,6 +2041,8 @@ struct ieee80211_vif_cfg {
 	bool s1g;
 	bool idle;
 	u8 ap_addr[ETH_ALEN] __aligned(2);
+	/* Protected by the wiphy mutex */
+	struct ieee80211_nan_sched_cfg nan_sched;
 };
 
 #define IEEE80211_TTLM_NUM_TIDS 8
@@ -7754,6 +7809,17 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
 			      struct cfg80211_nan_match_params *match,
 			      gfp_t gfp);
 
+/**
+ * ieee80211_nan_sched_update_done - notify that NAN schedule update is done
+ *
+ * This function is called by the driver to notify mac80211 that the NAN
+ * schedule update has been applied.
+ * Must be called with wiphy mutex held. May sleep.
+ *
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ */
+void ieee80211_nan_sched_update_done(struct ieee80211_vif *vif);
+
 /**
  * ieee80211_calc_rx_airtime - calculate estimated transmission airtime for RX.
  *
diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index b0e392eb7753..abf46c951299 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -36,7 +36,7 @@ mac80211-y := \
 	tdls.o \
 	ocb.o \
 	airtime.o \
-	eht.o uhr.o
+	eht.o uhr.o nan.o
 
 mac80211-$(CONFIG_MAC80211_LEDS) += led.o
 mac80211-$(CONFIG_MAC80211_DEBUGFS) += \
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e851668f4ef3..701b111db7df 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5594,6 +5594,18 @@ ieee80211_set_epcs(struct wiphy *wiphy, struct net_device *dev, bool enable)
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
@@ -5710,4 +5722,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.get_radio_mask = ieee80211_get_radio_mask,
 	.assoc_ml_reconf = ieee80211_assoc_ml_reconf,
 	.set_epcs = ieee80211_set_epcs,
+	.nan_set_local_sched = ieee80211_set_local_nan_sched,
 };
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 1e4bfcd25697..eca3fed1edbe 100644
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
+	     i < ARRAY_SIZE(iter->sdata->vif.cfg.nan_sched.channels); i++) {
+		struct ieee80211_nan_channel *nan_channel =
+			&iter->sdata->vif.cfg.nan_sched.channels[i];
 
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
@@ -97,10 +144,18 @@ static void ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
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
@@ -133,8 +188,8 @@ static void ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
 					      CHANCTX_ITER_ALL,		\
 					      false))
 
-static int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
-					  struct ieee80211_chanctx *ctx)
+int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
+				   struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_chanctx_user_iter iter;
 	int num = 0;
@@ -321,7 +376,7 @@ ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	for_each_chanctx_user_assigned(local, ctx, &iter) {
-		if (iter.link->reserved_chanctx)
+		if (iter.link && iter.link->reserved_chanctx)
 			continue;
 
 		comp_def = ieee80211_chanreq_compatible(iter.chanreq,
@@ -480,7 +535,6 @@ ieee80211_get_width_of_link(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_AP_VLAN:
 		return ieee80211_get_max_required_bw(link);
 	case NL80211_IFTYPE_P2P_DEVICE:
-	case NL80211_IFTYPE_NAN:
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		WARN_ON_ONCE(!ieee80211_hw_check(&local->hw,
@@ -495,6 +549,7 @@ ieee80211_get_width_of_link(struct ieee80211_link_data *link)
 	case NUM_NL80211_IFTYPES:
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_NAN_DATA:
 		WARN_ON_ONCE(1);
 		break;
@@ -504,6 +559,18 @@ ieee80211_get_width_of_link(struct ieee80211_link_data *link)
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
@@ -521,7 +588,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 	/* When this is true we only care about the reserving links */
 	if (check_reserved) {
 		for_each_chanctx_user_reserved(local, ctx, &iter) {
-			width = ieee80211_get_width_of_link(iter.link);
+			width = ieee80211_get_width_of_chanctx_user(&iter);
 			max_bw = max(max_bw, width);
 		}
 		goto check_monitor;
@@ -529,7 +596,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 
 	/* Consider all assigned links */
 	for_each_chanctx_user_assigned(local, ctx, &iter) {
-		width = ieee80211_get_width_of_link(iter.link);
+		width = ieee80211_get_width_of_chanctx_user(&iter);
 		max_bw = max(max_bw, width);
 	}
 
@@ -941,7 +1008,10 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
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
@@ -962,9 +1032,9 @@ static void ieee80211_del_chanctx(struct ieee80211_local *local,
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
 
@@ -1159,6 +1229,7 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
+		case NL80211_IFTYPE_NAN:
 			break;
 		default:
 			continue;
@@ -1169,6 +1240,15 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
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
@@ -1777,7 +1857,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 		for_each_chanctx_user_assigned(local, ctx->replace_ctx, &iter) {
 			n_assigned++;
-			if (iter.link->reserved_chanctx) {
+			if (iter.link && iter.link->reserved_chanctx) {
 				n_reserved++;
 				if (iter.link->reserved_ready)
 					n_ready++;
@@ -2033,7 +2113,7 @@ void __ieee80211_link_release_channel(struct ieee80211_link_data *link,
 		ieee80211_vif_use_reserved_switch(local);
 }
 
-static struct ieee80211_chanctx *
+struct ieee80211_chanctx *
 ieee80211_find_or_create_chanctx(struct ieee80211_sub_if_data *sdata,
 				 const struct ieee80211_chan_req *chanreq,
 				 enum ieee80211_chanctx_mode mode,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8d5f9a725fdf..92ea8de8a6db 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -990,6 +990,8 @@ struct ieee80211_if_mntr {
  * @de: Discovery Engine state (only valid if !WIPHY_NAN_FLAGS_USERSPACE_DE)
  * @de.func_lock: lock for @de.function_inst_ids
  * @de.function_inst_ids: a bitmap of available instance_id's
+ * @removed_channels: bitmap of channels that should be removed from the NAN
+ *	schedule once the deferred schedule update is completed.
  */
 struct ieee80211_if_nan {
 	struct cfg80211_nan_conf conf;
@@ -1000,6 +1002,8 @@ struct ieee80211_if_nan {
 		spinlock_t func_lock;
 		struct idr function_inst_ids;
 	} de;
+
+	DECLARE_BITMAP(removed_channels, IEEE80211_NAN_MAX_CHANNELS);
 };
 
 struct ieee80211_link_data_managed {
@@ -2024,6 +2028,10 @@ int ieee80211_mesh_csa_beacon(struct ieee80211_sub_if_data *sdata,
 int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata,
 			      u64 *changed);
 
+/* NAN code */
+int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
+				  struct cfg80211_nan_local_sched *sched);
+
 /* scan/BSS handling */
 void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work);
 int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
@@ -2812,7 +2820,17 @@ int ieee80211_max_num_channels(struct ieee80211_local *local, int radio_idx);
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
index f0a5a675c5a5..0f3e49cdbb39 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -886,6 +886,14 @@ static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
 
 	ieee80211_vif_clear_links(sdata);
 	ieee80211_link_stop(&sdata->deflink);
+
+	if (sdata->vif.type == NL80211_IFTYPE_NAN) {
+		struct ieee80211_nan_sched_cfg *nan_sched =
+			&sdata->vif.cfg.nan_sched;
+
+		for (int i = 0; i < ARRAY_SIZE(nan_sched->channels); i++)
+			WARN_ON(nan_sched->channels[i].chanreq.oper.chan);
+	}
 }
 
 static void ieee80211_uninit(struct net_device *dev)
diff --git a/net/mac80211/nan.c b/net/mac80211/nan.c
new file mode 100644
index 000000000000..2fa55e9a9dab
--- /dev/null
+++ b/net/mac80211/nan.c
@@ -0,0 +1,378 @@
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
+			     struct cfg80211_nan_channel *cfg_nan_channel,
+			     bool deferred)
+{
+	struct ieee80211_chanctx_conf *conf;
+	bool reducing_nss;
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
+	reducing_nss = nan_channel->needed_rx_chains > cfg_nan_channel->rx_nss;
+	nan_channel->needed_rx_chains = cfg_nan_channel->rx_nss;
+
+	conf = nan_channel->chanctx_conf;
+
+	/*
+	 * If we are adding NSSs, we need to be ready before notifying the peer,
+	 * if we are reducing NSSs, we need to wait until the peer is notified.
+	 */
+	if (!conf || (deferred && reducing_nss))
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
+	struct ieee80211_nan_sched_cfg *sched_cfg = &sdata->vif.cfg.nan_sched;
+
+	if (WARN_ON(!nan_channel))
+		return;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	if (!nan_channel->chanreq.oper.chan)
+		return;
+
+	for (int slot = 0; slot < ARRAY_SIZE(sched_cfg->schedule); slot++)
+		if (sched_cfg->schedule[slot] == nan_channel)
+			sched_cfg->schedule[slot] = NULL;
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
+static struct ieee80211_nan_channel *
+ieee80211_nan_find_free_channel(struct ieee80211_nan_sched_cfg *sched_cfg)
+{
+	for (int i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+		if (!sched_cfg->channels[i].chanreq.oper.chan)
+			return &sched_cfg->channels[i];
+	}
+
+	return NULL;
+}
+
+int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
+				  struct cfg80211_nan_local_sched *sched)
+{
+	struct ieee80211_nan_channel *sched_idx_to_chan[IEEE80211_NAN_MAX_CHANNELS] = {};
+	struct ieee80211_nan_sched_cfg *sched_cfg = &sdata->vif.cfg.nan_sched;
+	struct ieee80211_nan_sched_cfg backup_sched;
+	int ret;
+
+	if (sched->n_channels > IEEE80211_NAN_MAX_CHANNELS)
+		return -EOPNOTSUPP;
+
+	if (sched->nan_avail_blob_len > IEEE80211_NAN_AVAIL_BLOB_MAX_LEN)
+		return -EINVAL;
+
+	/*
+	 * If a deferred schedule update is pending completion, new updates are
+	 * not allowed. Only allow to configure an empty schedule so NAN can be
+	 * stopped in the middle of a deferred update. This is fine because
+	 * empty schedule means the local NAN device will not be available for
+	 * peers anymore so there is no need to update peers about a new
+	 * schedule.
+	 */
+	if (WARN_ON(sched_cfg->deferred && sched->n_channels))
+		return -EBUSY;
+
+	bitmap_zero(sdata->u.nan.removed_channels, IEEE80211_NAN_MAX_CHANNELS);
+
+	memcpy(backup_sched.schedule, sched_cfg->schedule,
+	       sizeof(backup_sched.schedule));
+	memcpy(backup_sched.channels, sched_cfg->channels,
+	       sizeof(backup_sched.channels));
+	memcpy(backup_sched.avail_blob, sched_cfg->avail_blob,
+	       sizeof(backup_sched.avail_blob));
+	backup_sched.avail_blob_len = sched_cfg->avail_blob_len;
+
+	memcpy(sched_cfg->avail_blob, sched->nan_avail_blob,
+	       sched->nan_avail_blob_len);
+	sched_cfg->avail_blob_len = sched->nan_avail_blob_len;
+
+	/*
+	 * Remove channels that are no longer in the new schedule to free up
+	 * resources before adding new channels. For deferred schedule, channels
+	 * will be removed when the schedule is applied.
+	 * Create a mapping from sched index to sched_cfg channel
+	 */
+	for (int i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+		bool still_needed = false;
+
+		if (!sched_cfg->channels[i].chanreq.oper.chan)
+			continue;
+
+		for (int j = 0; j < sched->n_channels; j++) {
+			if (cfg80211_chandef_identical(&sched_cfg->channels[i].chanreq.oper,
+						       &sched->nan_channels[j].chandef)) {
+				sched_idx_to_chan[j] =
+					&sched_cfg->channels[i];
+				still_needed = true;
+				break;
+			}
+		}
+
+		if (!still_needed) {
+			__set_bit(i, sdata->u.nan.removed_channels);
+			if (!sched->deferred)
+				ieee80211_nan_remove_channel(sdata,
+							     &sched_cfg->channels[i]);
+		}
+	}
+
+	for (int i = 0; i < sched->n_channels; i++) {
+		struct ieee80211_nan_channel *chan = sched_idx_to_chan[i];
+
+		if (chan) {
+			ieee80211_nan_update_channel(sdata->local, chan,
+						     &sched->nan_channels[i],
+						     sched->deferred);
+		} else {
+			chan = ieee80211_nan_find_free_channel(sched_cfg);
+			if (WARN_ON(!chan)) {
+				ret = -EINVAL;
+				goto err;
+			}
+
+			sched_idx_to_chan[i] = chan;
+			ieee80211_nan_init_channel(chan,
+						   &sched->nan_channels[i]);
+
+			ret = ieee80211_nan_use_chanctx(sdata, chan, false);
+			if (ret) {
+				memset(chan, 0, sizeof(*chan));
+				goto err;
+			}
+		}
+	}
+
+	for (int s = 0; s < ARRAY_SIZE(sched_cfg->schedule); s++) {
+		if (sched->schedule[s] < ARRAY_SIZE(sched_idx_to_chan))
+			sched_cfg->schedule[s] =
+				sched_idx_to_chan[sched->schedule[s]];
+		else
+			sched_cfg->schedule[s] = NULL;
+	}
+
+	sched_cfg->deferred = sched->deferred;
+
+	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
+
+	/*
+	 * For deferred update, don't update NDI carriers yet as the new
+	 * schedule is not yet applied so common slots don't change. The NDI
+	 * carrier will be updated once the driver notifies the new schedule is
+	 * applied.
+	 */
+	if (sched_cfg->deferred)
+		return 0;
+
+	bitmap_zero(sdata->u.nan.removed_channels, IEEE80211_NAN_MAX_CHANNELS);
+
+	return 0;
+err:
+	/* Remove newly added channels */
+	for (int i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+		struct cfg80211_chan_def *chan_def =
+			&sched_cfg->channels[i].chanreq.oper;
+
+		if (!chan_def->chan)
+			continue;
+
+		if (!cfg80211_chandef_identical(&backup_sched.channels[i].chanreq.oper,
+						chan_def))
+			ieee80211_nan_remove_channel(sdata,
+						     &sched_cfg->channels[i]);
+	}
+
+	/* Re-add all backed up channels */
+	for (int i = 0; i < ARRAY_SIZE(backup_sched.channels); i++) {
+		struct ieee80211_nan_channel *chan = &sched_cfg->channels[i];
+
+		*chan = backup_sched.channels[i];
+
+		/*
+		 * For deferred update, no channels were removed and the channel
+		 * context didn't change, so nothing else to do.
+		 */
+		if (!chan->chanctx_conf || sched->deferred)
+			continue;
+
+		if (test_bit(i, sdata->u.nan.removed_channels)) {
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
+	}
+
+	memcpy(sched_cfg->schedule, backup_sched.schedule,
+	       sizeof(backup_sched.schedule));
+	memcpy(sched_cfg->avail_blob, backup_sched.avail_blob,
+	       sizeof(backup_sched.avail_blob));
+	sched_cfg->avail_blob_len = backup_sched.avail_blob_len;
+	sched_cfg->deferred = false;
+	bitmap_zero(sdata->u.nan.removed_channels, IEEE80211_NAN_MAX_CHANNELS);
+
+	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
+	return ret;
+}
+
+void ieee80211_nan_sched_update_done(struct ieee80211_vif *vif)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_nan_sched_cfg *sched_cfg = &vif->cfg.nan_sched;
+	unsigned int i;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	if (WARN_ON(!sched_cfg->deferred))
+		return;
+
+	/*
+	 * Clear the deferred flag before removing channels. Removing channels
+	 * will trigger another schedule update to the driver, and there is no
+	 * need for this update to be deferred since removed channels are not
+	 * part of the schedule anymore, so no need to notify peers about
+	 * removing them.
+	 */
+	sched_cfg->deferred = false;
+
+	for (i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+		struct ieee80211_nan_channel *chan = &sched_cfg->channels[i];
+		struct ieee80211_chanctx_conf *conf = chan->chanctx_conf;
+
+		if (!chan->chanreq.oper.chan)
+			continue;
+
+		if (test_bit(i, sdata->u.nan.removed_channels))
+			ieee80211_nan_remove_channel(sdata, chan);
+		else if (conf)
+			/*
+			 * We might have called this already for some channels,
+			 * but this knows to handle a no-op.
+			 */
+			ieee80211_recalc_smps_chanctx(sdata->local,
+						      container_of(conf,
+								   struct ieee80211_chanctx,
+								   conf));
+	}
+
+	bitmap_zero(sdata->u.nan.removed_channels, IEEE80211_NAN_MAX_CHANNELS);
+	cfg80211_nan_sched_update_done(ieee80211_vif_to_wdev(vif), true,
+				       GFP_KERNEL);
+}
+EXPORT_SYMBOL(ieee80211_nan_sched_update_done);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 36795529ff82..19ac778b704d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1744,20 +1744,12 @@ static void ieee80211_reconfig_stations(struct ieee80211_sub_if_data *sdata)
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
 	funcs = kzalloc_objs(*funcs, sdata->local->hw.max_nan_de_entries + 1);
 	if (!funcs)
 		return -ENOMEM;
@@ -1783,6 +1775,22 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
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
2.34.1



Return-Path: <linux-wireless+bounces-34661-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKL6IhyM22nuDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34661-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA1D3E3BE7
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1026301C6C2
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE713537D4;
	Sun, 12 Apr 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9sPLPKY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59F37BE6A
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995908; cv=none; b=curI7cm+4DvJDbSAI/2rLbUKKg39GThCwz3Ja6RRyI10Xq/DA762nIQjCRWVXZul8Y8U5jFA7vzbFO4yEyE1BShJeJsriuG5xC+po2xY0YNv2JV3AS8779WgrLYLQLhte6sjAW7CwkARk8OH/M9nUB9+Ecr8vOoxo6cgrQFhAOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995908; c=relaxed/simple;
	bh=rYC+oJChxVTb2Lh/48ACbbYvXOPcJ/cjVjSgxBG78HI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3XfjBsJqlvwqQ1QQ/9WCSafu31mdcGL1y+1uwKKsUZyONTIRa1sB62dh7rM7nlZZlH4KUZa3opWfLzcRS/ZTOwHM6NlZ7PoMx2OMXujUOlMzbD6KyXuTtQ2Opo5vPvikhBuf5h9nTQgCi0RyfDB9elPeCWJdo3GC1cESQo2wbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9sPLPKY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775995906; x=1807531906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYC+oJChxVTb2Lh/48ACbbYvXOPcJ/cjVjSgxBG78HI=;
  b=D9sPLPKYr0YXPla7DkDZkRbSnhInVt40lmRRGYJTtPycqKAvrcWxm9xU
   IsxQXKXrudOqSZlfb01DMdnDF6ZRwild+Am+p7JkCY+iDOs1HAWICfsnD
   ryXbXpNZ5QDsM00Jf/fv3XI/7hdOytsypZJLvORUgxmfKBbUT27hrKNRU
   rNmETrA8s3Rgb8gCd65L5H410hVtjoJUISQJSEjY1gh4p0mjpuzYuYWtP
   XMsKs7y1EptYKCidH9ExtegCAcubssoK+b/RVMcpwRns6MSAX/f6x2L1k
   3x+AEP5D1auIMpWDJs+4FCXstaJULXVYoHuitgZT55cbU7BcLdIyCNY8E
   A==;
X-CSE-ConnectionGUID: UwNDrnywQ3+ZNzESZhgjVg==
X-CSE-MsgGUID: RZeenySvQT6Imp22Aou4kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88028466"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88028466"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:46 -0700
X-CSE-ConnectionGUID: qWMxsD5hS4+RQKFNHt5j+w==
X-CSE-MsgGUID: Dz7QhPIMTaCpYBmg8C/3sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="229411909"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 07/15] wifi: mac80211: add NAN channel evacuation support
Date: Sun, 12 Apr 2026 15:11:16 +0300
Message-Id: <20260412150826.e01c1ee4a442.I003fe84dc6373bb9ad55abd7824b9fc21c51203f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
References: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34661-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iter.link:url]
X-Rspamd-Queue-Id: 0CA1D3E3BE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A NAN channel can be evacuated, i.e. detached from its chanctx, if all
chanctxs are used by NAN and a chanctx is needed for something else.
For example if the STA interface needs to perform a channel switch.

Implement the evacuation: detach the NAN channel from its chanctx, remove
all the peer NAN channels that were using this chanctx, and update the
driver.

Internally, the NAN channel evacuation will be triggered in the scenario
described above, and API is provided for the driver to also trigger it.

The driver/device is assumed to publish a ULW to notify the peers about
the fact that we won't be present on this NAN channel anymore.

Also export this as an API for the drivers: if a driver has other
resources per channel, it might want to trigger channel evacuation in
order to free up such internal resources for other usages.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h |  15 +++++
 net/mac80211/chan.c    |  28 ++++++---
 net/mac80211/nan.c     | 126 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 7 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 091c1922b3e5..da931a08a6a5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7903,6 +7903,21 @@ void ieee80211_nan_cluster_joined(struct ieee80211_vif *vif,
 				  const u8 *cluster_id, bool new_cluster,
 				  gfp_t gfp);
 
+/**
+ * ieee80211_nan_try_evacuate - try to evacuate a NAN channel
+ *
+ * This function tries to evacuate a NAN channel that is using the given
+ * channel context, to free up channel context resources.
+ *
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @conf: the channel context configuration to try to evacuate. If %NULL,
+ *	the NAN channel that has the fewest slots scheduled will be evacuated.
+ *
+ * Return: %true if a channel was evacuated, %false otherwise
+ */
+bool ieee80211_nan_try_evacuate(struct ieee80211_hw *hw,
+				struct ieee80211_chanctx_conf *conf);
+
 /**
  * ieee80211_calc_rx_airtime - calculate estimated transmission airtime for RX.
  *
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index fda692316f08..e4e2e735123f 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1875,16 +1875,21 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		}
 
 		if (n_assigned != n_reserved) {
-			if (n_ready == n_reserved) {
-				wiphy_info(local->hw.wiphy,
-					   "channel context reservation cannot be finalized because some interfaces aren't switching\n");
-				err = -EBUSY;
-				goto err;
-			}
+			if (n_ready != n_reserved)
+				return -EAGAIN;
 
-			return -EAGAIN;
+			if (n_assigned == n_reserved + 1 &&
+			    ieee80211_nan_try_evacuate(&local->hw,
+						       &ctx->replace_ctx->conf))
+				goto use_reserved;
+
+			wiphy_info(local->hw.wiphy,
+				   "channel context reservation cannot be finalized because some interfaces aren't switching\n");
+			err = -EBUSY;
+			goto err;
 		}
 
+use_reserved:
 		ctx->conf.radar_enabled = false;
 		for_each_chanctx_user_reserved(local, ctx, &iter) {
 			if (ieee80211_link_has_in_place_reservation(iter.link) &&
@@ -2192,6 +2197,15 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	ctx = ieee80211_find_or_create_chanctx(sdata, chanreq, mode,
 					       assign_on_failure, &reused_ctx);
+	if (IS_ERR(ctx)) {
+		/* Try to evacuate a NAN channel to free up a chanctx */
+		if (ieee80211_nan_try_evacuate(&local->hw, NULL))
+			ctx = ieee80211_find_or_create_chanctx(sdata, chanreq,
+							       mode,
+							       assign_on_failure,
+							       &reused_ctx);
+	}
+
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
 		goto out;
diff --git a/net/mac80211/nan.c b/net/mac80211/nan.c
index 4e262b624521..cea620aaee6a 100644
--- a/net/mac80211/nan.c
+++ b/net/mac80211/nan.c
@@ -334,7 +334,10 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 			sched_idx_to_chan[i] = chan;
 			ieee80211_nan_init_channel(chan,
 						   &sched->nan_channels[i]);
+		}
 
+		/* Also a pre-existing channel might have been ULWed, so no chanctx */
+		if (!chan->chanctx_conf) {
 			ret = ieee80211_nan_use_chanctx(sdata, chan, false);
 			if (ret) {
 				memset(chan, 0, sizeof(*chan));
@@ -708,3 +711,126 @@ int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
 	ieee80211_nan_free_peer_sched(to_free);
 	return ret;
 }
+
+static void
+ieee80211_nan_evacuate_channel(struct ieee80211_sub_if_data *sdata,
+			       struct ieee80211_nan_channel *nan_channel)
+{
+	struct ieee80211_chanctx_conf *conf;
+	struct ieee80211_chanctx *ctx;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	if (WARN_ON(!nan_channel || !nan_channel->chanreq.oper.chan))
+		return;
+
+	conf = nan_channel->chanctx_conf;
+	if (WARN_ON(!conf))
+		return;
+
+	nan_channel->chanctx_conf = NULL;
+
+	/* Update all peer channels that reference this chanctx */
+	ieee80211_nan_update_peer_channels(sdata, conf);
+
+	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
+
+	cfg80211_nan_channel_evac(&sdata->wdev, &nan_channel->chanreq.oper,
+				  GFP_KERNEL);
+
+	/* Update NDI carrier states */
+	ieee80211_nan_update_all_ndi_carriers(sdata->local);
+
+	/* Clean up the channel context if no longer used */
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
+bool ieee80211_nan_try_evacuate(struct ieee80211_hw *hw,
+				struct ieee80211_chanctx_conf *conf)
+{
+	struct ieee80211_sub_if_data *sdata = NULL, *tmp;
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_nan_channel *evac_chan = NULL;
+	struct ieee80211_nan_sched_cfg *sched_cfg;
+	struct ieee80211_chanctx *ctx = NULL;
+	int min_slot_count = INT_MAX;
+	int usable_channels = 0;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (conf)
+		ctx = container_of(conf, struct ieee80211_chanctx, conf);
+
+	/* Find the NAN interface - there can only be one */
+	list_for_each_entry(tmp, &local->interfaces, list) {
+		if (ieee80211_sdata_running(tmp) &&
+		    tmp->vif.type == NL80211_IFTYPE_NAN) {
+			sdata = tmp;
+			break;
+		}
+	}
+
+	if (!sdata)
+		return false;
+
+	sched_cfg = &sdata->vif.cfg.nan_sched;
+
+	/* Find the channel to evacuate and count usable channels */
+	for (int i = 0; i < IEEE80211_NAN_MAX_CHANNELS; i++) {
+		struct ieee80211_nan_channel *chan =
+			&sched_cfg->channels[i];
+		struct ieee80211_chanctx *chan_ctx;
+		int slot_count = 0;
+
+		if (!chan->chanreq.oper.chan || !chan->chanctx_conf)
+			continue;
+
+		usable_channels++;
+
+		chan_ctx = container_of(chan->chanctx_conf,
+					struct ieee80211_chanctx, conf);
+
+		/* If ctx specified, only consider that specific chanctx */
+		if (ctx) {
+			if (chan_ctx == ctx)
+				evac_chan = chan;
+			continue;
+		}
+
+		/* Can only evacuate channels whose chanctx is NAN-only */
+		if (ieee80211_chanctx_refcount(local, chan_ctx) > 1)
+			continue;
+
+		/* Count how many time slots use this channel */
+		for (int s = 0; s < CFG80211_NAN_SCHED_NUM_TIME_SLOTS; s++)
+			if (sched_cfg->schedule[s] == chan)
+				slot_count++;
+
+		if (slot_count < min_slot_count) {
+			min_slot_count = slot_count;
+			evac_chan = chan;
+		}
+	}
+
+	/* No suitable NAN channel found */
+	if (!evac_chan)
+		return false;
+
+	/* NAN needs at least one remaining usable channel after evacuation */
+	if (usable_channels < 2)
+		return false;
+
+	ieee80211_nan_evacuate_channel(sdata, evac_chan);
+
+	return true;
+}
+EXPORT_SYMBOL(ieee80211_nan_try_evacuate);
-- 
2.34.1



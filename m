Return-Path: <linux-wireless+bounces-35605-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNNEAo/u8WmulgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35605-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:42:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A691493AA4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50DFD30512B0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D54D37F746;
	Wed, 29 Apr 2026 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjmRUNHz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B53F1665
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462874; cv=none; b=sLdpEzfWTJMPWh2Y0jDhNx4onhiSZtILracVXUtXYAYiMVqPQ3BRymXkkHtv8xd4ylKGjrOO6bCIFvkYVRGjA3fDLihsMvoNjTeV16wsFPz/PC4U92njIVTuivINZ9htWNvInHZck4/XRdGkKi2CHU5dUp756K4DfBzntlikaHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462874; c=relaxed/simple;
	bh=v3GwRDdjAIblzHLNMXjr1Irdpln6naNEy9t+aVeQIaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtXcofibKe8n1xT1Ng+CV8rioo68L229ErBu2lpHQwcXOm+5U6+duQAOFHLCpSHuuKXNVn1vZ2qx2BiYtKmeHcdn9IgCUGZHqV3cm3QMNxUnEjGdSb1OS7C1obUR8YlZVkUzowNe0N+RXx2BgA3AlQ5kwtgbhhVl7oVEXb7AWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjmRUNHz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777462872; x=1808998872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v3GwRDdjAIblzHLNMXjr1Irdpln6naNEy9t+aVeQIaQ=;
  b=cjmRUNHzuHAIQb+JCqmRMbMe8stWIg5OQetTjPE5FcqAcYLILcNt8oFV
   jWDAP9C1WQZyBsRf2JlAKWGYdJzQa+XOXjNZu2ctbeJuaBFWKIm5NxYC9
   juwjmryQmW0qJkAYmCDRfMwX6LcHBl05t+lDRNpYmjcNi8j84cvpKISOy
   nHbi0EYvu+Zus3d+SvPlpXMMN8zcQ+1t1jhAAneDenunI4NNSFmN0w742
   CcOB/9Wqlyurtnf58x/z5DnWjMydE/u/maGyjyz5eESe3bIfIZ67tIkoM
   kxxhXjaTOFKaDabdj74T38b9OdL8LTfkLO52UobO33Rr1No9XHnk2oS15
   w==;
X-CSE-ConnectionGUID: PDo+Qp3YSECs4c/FTMAwWQ==
X-CSE-MsgGUID: KBwwkQApRfuIJUMO3zTsgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88986120"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="88986120"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:12 -0700
X-CSE-ConnectionGUID: Jp9UTKngQF2updKO9qWFzg==
X-CSE-MsgGUID: p60UcOOJQ66Gy3c08UOK4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234505134"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless-next 07/15] wifi: mac80211: add NAN channel evacuation support
Date: Wed, 29 Apr 2026 14:40:41 +0300
Message-Id: <20260429143813.1e1dc40d2f3e.I003fe84dc6373bb9ad55abd7824b9fc21c51203f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429114049.4167111-1-miriam.rachel.korenblit@intel.com>
References: <20260429114049.4167111-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A691493AA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35605-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,iter.link:url]

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
index 0d1b1d726b9c..d909bc1b29ff 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7905,6 +7905,21 @@ void ieee80211_nan_cluster_joined(struct ieee80211_vif *vif,
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
index 248531051a4e..9683d3e6e1d2 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1861,16 +1861,21 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
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
@@ -2178,6 +2183,15 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
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



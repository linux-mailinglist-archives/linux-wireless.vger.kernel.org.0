Return-Path: <linux-wireless+bounces-6303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BFB8A4A4C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8ACB254C3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4208374DD;
	Mon, 15 Apr 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8Si9q7t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132D383B2
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169650; cv=none; b=ndDTophB1lvYc0Zu7ANBsHNNo3ls8+mO3IJ0heKRgXzyE05iProEStrexM9nO53OYiGVIp3/BhUsEmJaCOcPslV7Iop6vEPu9K7s6YW3T15CwAqSc04ghv9V+eP5Bdd411NDVtXjhPIkgKvkvTrAkfNA0Uzw1I5UP0lA6En37Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169650; c=relaxed/simple;
	bh=Zjg1QaN79Ug1jW4GBZzhDG5DWmaKiLyW0nn6uU74yP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxsWJOTJFA7wbSt/3rRvsg7j4JkCYXFwMp0Yu9IxrQtQkubsY7tZTpMdfOlKct/6g8wetUTOQcqgZgfFED0yIz3ffY8lr43q8m4W72WOHmnszwAyK3wb2skR+OWkge051BLOUJJhpdRMJ6fuNXqOHHeAJpkHCNTESRsWZewfzAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8Si9q7t; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713169648; x=1744705648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zjg1QaN79Ug1jW4GBZzhDG5DWmaKiLyW0nn6uU74yP0=;
  b=g8Si9q7t9G+JVSNMZVZxv19/9D2NKtf0pKp+lTscngziprp8uPRL4g+v
   ImT+qd1XDI3hWXNvmfBfgx3asK1abRmgA44UoVzvcE6BIeoUEXl5oBan2
   3Dxb4SSOMSuUklNooErdWGlbXNQmi3X0J64czBGwIcAeoH8iZHF9fTqlk
   gZRHF/buc9bOoqjhufVLD7uf6kjAhsz+ofSr78jQYO6hvfDTmjDdJLnY6
   zJOQLtvMYXf0wRkXcTH2REoNg5e4WOZlMFOTle7MDMpsFZaCgptyyRd8A
   6uU9bE/2c+V4Q7+2ARN5R7Cvz/5AEQpKzqqgiKfZBb4QfsyW6ZPIfrlyX
   A==;
X-CSE-ConnectionGUID: xD5lO3oCQiOyu3loDkePXA==
X-CSE-MsgGUID: ACzHCF4NQVePEdl3fivq2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9097272"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9097272"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:27:28 -0700
X-CSE-ConnectionGUID: M32J7HhQStCy0A0lNQxqQQ==
X-CSE-MsgGUID: LHfF/Q86Twu1B5qOay9ERw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26403244"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:27:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] wifi: mac80211: mlme: handle cross-link CSA
Date: Mon, 15 Apr 2024 11:27:11 +0300
Message-Id: <20240415112355.4d34b6a31be7.Ie8453979f5805873a8411c99346bcc3810cd6476@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415082713.3822598-1-miriam.rachel.korenblit@intel.com>
References: <20240415082713.3822598-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If we see a channel switch announcement on one link for
another, handle that case and start the CSA. The driver
can react to this in whatever way it needs. The stack
will have the ability to track it via the RNR/MLE in the
reporting link's beacon if it sees it for inactive links
and adjust everything accordingly.

Note that currently the timings for the CSA aren't set,
the values are only used by the Intel drivers, and they
don't need this for newer devices that support MLO, so
I've left it out for now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/driver-ops.h  |  12 +
 net/mac80211/ieee80211_i.h |   1 +
 net/mac80211/link.c        |  12 +
 net/mac80211/mlme.c        | 470 +++++++++++++++++++++++++++++--------
 4 files changed, 403 insertions(+), 92 deletions(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 5d078c0a2323..d4e73d3630e0 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1150,6 +1150,9 @@ drv_pre_channel_switch(struct ieee80211_sub_if_data *sdata,
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
+	if (!ieee80211_vif_link_active(&sdata->vif, ch_switch->link_id))
+		return 0;
+
 	trace_drv_pre_channel_switch(local, sdata, ch_switch);
 	if (local->ops->pre_channel_switch)
 		ret = local->ops->pre_channel_switch(&local->hw, &sdata->vif,
@@ -1171,6 +1174,9 @@ drv_post_channel_switch(struct ieee80211_link_data *link)
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
+	if (!ieee80211_vif_link_active(&sdata->vif, link->link_id))
+		return 0;
+
 	trace_drv_post_channel_switch(local, sdata);
 	if (local->ops->post_channel_switch)
 		ret = local->ops->post_channel_switch(&local->hw, &sdata->vif,
@@ -1191,6 +1197,9 @@ drv_abort_channel_switch(struct ieee80211_link_data *link)
 	if (!check_sdata_in_driver(sdata))
 		return;
 
+	if (!ieee80211_vif_link_active(&sdata->vif, link->link_id))
+		return;
+
 	trace_drv_abort_channel_switch(local, sdata);
 
 	if (local->ops->abort_channel_switch)
@@ -1210,6 +1219,9 @@ drv_channel_switch_rx_beacon(struct ieee80211_sub_if_data *sdata,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
+	if (!ieee80211_vif_link_active(&sdata->vif, ch_switch->link_id))
+		return;
+
 	trace_drv_channel_switch_rx_beacon(local, sdata, ch_switch);
 	if (local->ops->channel_switch_rx_beacon)
 		local->ops->channel_switch_rx_beacon(&local->hw, &sdata->vif,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 81a9c5b7642d..588f0d21c89e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -976,6 +976,7 @@ struct ieee80211_link_data_managed {
 
 	bool csa_waiting_bcn;
 	bool csa_ignored_same_chan;
+	unsigned long csa_time;
 	struct wiphy_delayed_work chswitch_work;
 
 	struct wiphy_work request_smps_work;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 43f9672fc7f1..b05c29ac2b2e 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -359,6 +359,18 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		ieee80211_teardown_tdls_peers(link);
 
 		__ieee80211_link_release_channel(link, true);
+
+		/*
+		 * If CSA is (still) active while the link is deactivated,
+		 * just schedule the channel switch work for the time we
+		 * had previously calculated, and we'll take the process
+		 * from there.
+		 */
+		if (link->conf->csa_active)
+			wiphy_delayed_work_queue(local->hw.wiphy,
+						 &link->u.mgd.chswitch_work,
+						 link->u.mgd.csa_time -
+						 jiffies);
 	}
 
 	list_for_each_entry(sta, &local->sta_list, list) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cd4b54e02653..5b919d7eedf2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1877,6 +1877,18 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 	if (!link->conf->csa_active)
 		return;
 
+	/*
+	 * If the link isn't active (now), we cannot wait for beacons, won't
+	 * have a reserved chanctx, etc. Just switch over the chandef and
+	 * update cfg80211 directly.
+	 */
+	if (!ieee80211_vif_link_active(&sdata->vif, link->link_id)) {
+		link->conf->chanreq = link->csa_chanreq;
+		cfg80211_ch_switch_notify(sdata->dev, &link->csa_chanreq.oper,
+					  link->link_id);
+		return;
+	}
+
 	/*
 	 * using reservation isn't immediate as it may be deferred until later
 	 * with multi-vif. once reservation is complete it will re-schedule the
@@ -1895,9 +1907,9 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 
 		ret = ieee80211_link_use_reserved_context(link);
 		if (ret) {
-			sdata_info(sdata,
-				   "failed to use reserved channel context, disconnecting (err=%d)\n",
-				   ret);
+			link_info(link,
+				  "failed to use reserved channel context, disconnecting (err=%d)\n",
+				  ret);
 			wiphy_work_queue(sdata->local->hw.wiphy,
 					 &ifmgd->csa_connection_drop_work);
 		}
@@ -1906,8 +1918,8 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 
 	if (!ieee80211_chanreq_identical(&link->conf->chanreq,
 					 &link->csa_chanreq)) {
-		sdata_info(sdata,
-			   "failed to finalize channel switch, disconnecting\n");
+		link_info(link,
+			  "failed to finalize channel switch, disconnecting\n");
 		wiphy_work_queue(sdata->local->hw.wiphy,
 				 &ifmgd->csa_connection_drop_work);
 		return;
@@ -1941,14 +1953,14 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 
 	ret = drv_post_channel_switch(link);
 	if (ret) {
-		sdata_info(sdata,
-			   "driver post channel switch failed, disconnecting\n");
+		link_info(link,
+			  "driver post channel switch failed, disconnecting\n");
 		wiphy_work_queue(sdata->local->hw.wiphy,
 				 &ifmgd->csa_connection_drop_work);
 		return;
 	}
 
-	cfg80211_ch_switch_notify(sdata->dev, &link->reserved.oper,
+	cfg80211_ch_switch_notify(sdata->dev, &link->conf->chanreq.oper,
 				  link->link_id);
 }
 
@@ -1963,7 +1975,8 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
 
 	if (!success) {
 		sdata_info(sdata,
-			   "driver channel switch failed, disconnecting\n");
+			   "driver channel switch failed (link %d), disconnecting\n",
+			   link_id);
 		wiphy_work_queue(sdata->local->hw.wiphy,
 				 &sdata->u.mgd.csa_connection_drop_work);
 	} else {
@@ -2007,69 +2020,221 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 	drv_abort_channel_switch(link);
 }
 
+struct sta_csa_rnr_iter_data {
+	struct ieee80211_link_data *link;
+	struct ieee80211_channel *chan;
+	u8 mld_id;
+};
+
+static enum cfg80211_rnr_iter_ret
+ieee80211_sta_csa_rnr_iter(void *_data, u8 type,
+			   const struct ieee80211_neighbor_ap_info *info,
+			   const u8 *tbtt_info, u8 tbtt_info_len)
+{
+	struct sta_csa_rnr_iter_data *data = _data;
+	struct ieee80211_link_data *link = data->link;
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	const struct ieee80211_tbtt_info_ge_11 *ti;
+	enum nl80211_band band;
+	unsigned int center_freq;
+	int link_id;
+
+	if (type != IEEE80211_TBTT_INFO_TYPE_TBTT)
+		return RNR_ITER_CONTINUE;
+
+	if (tbtt_info_len < sizeof(*ti))
+		return RNR_ITER_CONTINUE;
+
+	ti = (const void *)tbtt_info;
+
+	if (ti->mld_params.mld_id != data->mld_id)
+		return RNR_ITER_CONTINUE;
+
+	link_id = le16_get_bits(ti->mld_params.params,
+				IEEE80211_RNR_MLD_PARAMS_LINK_ID);
+	if (link_id != data->link->link_id)
+		return RNR_ITER_CONTINUE;
+
+	/* we found the entry for our link! */
+
+	/* this AP is confused, it had this right before ... just disconnect */
+	if (!ieee80211_operating_class_to_band(info->op_class, &band)) {
+		link_info(link,
+			  "AP now has invalid operating class in RNR, disconnect\n");
+		wiphy_work_queue(sdata->local->hw.wiphy,
+				 &ifmgd->csa_connection_drop_work);
+		return RNR_ITER_BREAK;
+	}
+
+	center_freq = ieee80211_channel_to_frequency(info->channel, band);
+	data->chan = ieee80211_get_channel(sdata->local->hw.wiphy, center_freq);
+
+	return RNR_ITER_BREAK;
+}
+
+static void
+ieee80211_sta_other_link_csa_disappeared(struct ieee80211_link_data *link,
+					 struct ieee802_11_elems *elems)
+{
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	struct sta_csa_rnr_iter_data data = {
+		.link = link,
+	};
+
+	/*
+	 * If we get here, we see a beacon from another link without
+	 * CSA still being reported for it, so now we have to check
+	 * if the CSA was aborted or completed. This may not even be
+	 * perfectly possible if the CSA was only done for changing
+	 * the puncturing, but in that case if the link in inactive
+	 * we don't really care, and if it's an active link (or when
+	 * it's activated later) we'll get a beacon and adjust.
+	 */
+
+	if (WARN_ON(!elems->ml_basic))
+		return;
+
+	data.mld_id = ieee80211_mle_get_mld_id((const void *)elems->ml_basic);
+
+	/*
+	 * So in order to do this, iterate the RNR element(s) and see
+	 * what channel is reported now.
+	 */
+	cfg80211_iter_rnr(elems->ie_start, elems->total_len,
+			  ieee80211_sta_csa_rnr_iter, &data);
+
+	if (!data.chan) {
+		link_info(link,
+			  "couldn't find (valid) channel in RNR for CSA, disconnect\n");
+		wiphy_work_queue(sdata->local->hw.wiphy,
+				 &ifmgd->csa_connection_drop_work);
+		return;
+	}
+
+	/*
+	 * If it doesn't match the CSA, then assume it aborted. This
+	 * may erroneously detect that it was _not_ aborted when it
+	 * was in fact aborted, but only changed the bandwidth or the
+	 * puncturing configuration, but we don't have enough data to
+	 * detect that.
+	 */
+	if (data.chan != link->csa_chanreq.oper.chan)
+		ieee80211_sta_abort_chanswitch(link);
+}
+
+enum ieee80211_csa_source {
+	IEEE80211_CSA_SOURCE_BEACON,
+	IEEE80211_CSA_SOURCE_OTHER_LINK,
+	IEEE80211_CSA_SOURCE_ACTION,
+};
+
 static void
 ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 				 u64 timestamp, u32 device_timestamp,
-				 struct ieee802_11_elems *elems,
-				 bool beacon)
+				 struct ieee802_11_elems *full_elems,
+				 struct ieee802_11_elems *csa_elems,
+				 enum ieee80211_csa_source source)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	struct cfg80211_bss *cbss = link->conf->bss;
+	struct ieee80211_chanctx *chanctx = NULL;
 	struct ieee80211_chanctx_conf *conf;
-	struct ieee80211_chanctx *chanctx;
-	enum nl80211_band current_band;
-	struct ieee80211_csa_ie csa_ie;
+	struct ieee80211_csa_ie csa_ie = {};
 	struct ieee80211_channel_switch ch_switch = {
 		.link_id = link->link_id,
+		.timestamp = timestamp,
+		.device_timestamp = device_timestamp,
 	};
-	struct ieee80211_bss *bss;
-	unsigned long timeout;
+	unsigned long now;
 	int res;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!cbss)
-		return;
+	if (csa_elems) {
+		struct cfg80211_bss *cbss = link->conf->bss;
+		enum nl80211_band current_band;
+		struct ieee80211_bss *bss;
 
-	current_band = cbss->channel->band;
-	bss = (void *)cbss->priv;
-	res = ieee80211_parse_ch_switch_ie(sdata, elems, current_band,
-					   bss->vht_cap_info,
-					   &link->u.mgd.conn,
-					   link->u.mgd.bssid, &csa_ie);
+		if (WARN_ON(!cbss))
+			return;
 
-	if (!res) {
-		ch_switch.timestamp = timestamp;
-		ch_switch.device_timestamp = device_timestamp;
-		ch_switch.block_tx = csa_ie.mode;
-		ch_switch.chandef = csa_ie.chanreq.oper;
-		ch_switch.count = csa_ie.count;
-		ch_switch.delay = csa_ie.max_switch_time;
+		current_band = cbss->channel->band;
+		bss = (void *)cbss->priv;
+
+		res = ieee80211_parse_ch_switch_ie(sdata, csa_elems,
+						   current_band,
+						   bss->vht_cap_info,
+						   &link->u.mgd.conn,
+						   link->u.mgd.bssid, &csa_ie);
+		if (res == 0) {
+			ch_switch.block_tx = csa_ie.mode;
+			ch_switch.chandef = csa_ie.chanreq.oper;
+			ch_switch.count = csa_ie.count;
+			ch_switch.delay = csa_ie.max_switch_time;
+		}
+	} else {
+		/*
+		 * If there was no per-STA profile for this link, we
+		 * get called with csa_elems == NULL. This of course means
+		 * there are no CSA elements, so set res=1 indicating
+		 * no more CSA.
+		 */
+		res = 1;
 	}
 
 	if (res < 0)
 		goto drop_connection;
 
 	if (link->conf->csa_active) {
-		/* already processing - disregard action frames */
-		if (!beacon)
+		switch (source) {
+		case IEEE80211_CSA_SOURCE_ACTION:
+			/* already processing - disregard action frames */
 			return;
+		case IEEE80211_CSA_SOURCE_BEACON:
+			if (link->u.mgd.csa_waiting_bcn) {
+				ieee80211_chswitch_post_beacon(link);
+				/*
+				 * If the CSA is still present after the switch
+				 * we need to consider it as a new CSA (possibly
+				 * to self). This happens by not returning here
+				 * so we'll get to the check below.
+				 */
+			} else if (res) {
+				ieee80211_sta_abort_chanswitch(link);
+				return;
+			} else {
+				drv_channel_switch_rx_beacon(sdata, &ch_switch);
+				return;
+			}
+			break;
+		case IEEE80211_CSA_SOURCE_OTHER_LINK:
+			/* active link: we want to see the beacon to continue */
+			if (ieee80211_vif_link_active(&sdata->vif,
+						      link->link_id))
+				return;
 
-		if (link->u.mgd.csa_waiting_bcn) {
-			ieee80211_chswitch_post_beacon(link);
-			/*
-			 * If the CSA IE is still present in the beacon after
-			 * the switch, we need to consider it as a new CSA
-			 * (possibly to self) - this happens by not returning
-			 * here so we'll get to the check below.
-			 */
-		} else if (res) {
-			ieee80211_sta_abort_chanswitch(link);
-			return;
-		} else {
-			drv_channel_switch_rx_beacon(sdata, &ch_switch);
+			/* switch work ran, so just complete the process */
+			if (link->u.mgd.csa_waiting_bcn) {
+				ieee80211_chswitch_post_beacon(link);
+				/*
+				 * If the CSA is still present after the switch
+				 * we need to consider it as a new CSA (possibly
+				 * to self). This happens by not returning here
+				 * so we'll get to the check below.
+				 */
+				break;
+			}
+
+			/* link still has CSA but we already know, do nothing */
+			if (!res)
+				return;
+
+			/* check in the RNR if the CSA aborted */
+			ieee80211_sta_other_link_csa_disappeared(link,
+								 full_elems);
 			return;
 		}
 	}
@@ -2080,40 +2245,38 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	if (link->conf->chanreq.oper.chan->band !=
 	    csa_ie.chanreq.oper.chan->band) {
-		sdata_info(sdata,
-			   "AP %pM switches to different band (%d MHz, width:%d, CF1/2: %d/%d MHz), disconnecting\n",
-			   link->u.mgd.bssid,
-			   csa_ie.chanreq.oper.chan->center_freq,
-			   csa_ie.chanreq.oper.width,
-			   csa_ie.chanreq.oper.center_freq1,
-			   csa_ie.chanreq.oper.center_freq2);
+		link_info(link,
+			  "AP %pM switches to different band (%d MHz, width:%d, CF1/2: %d/%d MHz), disconnecting\n",
+			  link->u.mgd.bssid,
+			  csa_ie.chanreq.oper.chan->center_freq,
+			  csa_ie.chanreq.oper.width,
+			  csa_ie.chanreq.oper.center_freq1,
+			  csa_ie.chanreq.oper.center_freq2);
 		goto drop_connection;
 	}
 
 	if (!cfg80211_chandef_usable(local->hw.wiphy, &csa_ie.chanreq.oper,
 				     IEEE80211_CHAN_DISABLED)) {
-		sdata_info(sdata,
-			   "AP %pM switches to unsupported channel "
-			   "(%d.%03d MHz, width:%d, CF1/2: %d.%03d/%d MHz), "
-			   "disconnecting\n",
-			   link->u.mgd.bssid,
-			   csa_ie.chanreq.oper.chan->center_freq,
-			   csa_ie.chanreq.oper.chan->freq_offset,
-			   csa_ie.chanreq.oper.width,
-			   csa_ie.chanreq.oper.center_freq1,
-			   csa_ie.chanreq.oper.freq1_offset,
-			   csa_ie.chanreq.oper.center_freq2);
+		link_info(link,
+			  "AP %pM switches to unsupported channel (%d.%03d MHz, width:%d, CF1/2: %d.%03d/%d MHz), disconnecting\n",
+			  link->u.mgd.bssid,
+			  csa_ie.chanreq.oper.chan->center_freq,
+			  csa_ie.chanreq.oper.chan->freq_offset,
+			  csa_ie.chanreq.oper.width,
+			  csa_ie.chanreq.oper.center_freq1,
+			  csa_ie.chanreq.oper.freq1_offset,
+			  csa_ie.chanreq.oper.center_freq2);
 		goto drop_connection;
 	}
 
 	if (cfg80211_chandef_identical(&csa_ie.chanreq.oper,
 				       &link->conf->chanreq.oper) &&
-	    (!csa_ie.mode || !beacon)) {
+	    (!csa_ie.mode || source != IEEE80211_CSA_SOURCE_BEACON)) {
 		if (link->u.mgd.csa_ignored_same_chan)
 			return;
-		sdata_info(sdata,
-			   "AP %pM tries to chanswitch to same channel, ignore\n",
-			   link->u.mgd.bssid);
+		link_info(link,
+			  "AP %pM tries to chanswitch to same channel, ignore\n",
+			  link->u.mgd.bssid);
 		link->u.mgd.csa_ignored_same_chan = true;
 		return;
 	}
@@ -2129,33 +2292,36 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	conf = rcu_dereference_protected(link->conf->chanctx_conf,
 					 lockdep_is_held(&local->hw.wiphy->mtx));
-	if (!conf) {
-		sdata_info(sdata,
-			   "no channel context assigned to vif?, disconnecting\n");
+	if (ieee80211_vif_link_active(&sdata->vif, link->link_id) && !conf) {
+		link_info(link,
+			  "no channel context assigned to vif?, disconnecting\n");
 		goto drop_connection;
 	}
 
-	chanctx = container_of(conf, struct ieee80211_chanctx, conf);
+	if (conf)
+		chanctx = container_of(conf, struct ieee80211_chanctx, conf);
 
 	if (!ieee80211_hw_check(&local->hw, CHANCTX_STA_CSA)) {
-		sdata_info(sdata,
-			   "driver doesn't support chan-switch with channel contexts\n");
+		link_info(link,
+			  "driver doesn't support chan-switch with channel contexts\n");
 		goto drop_connection;
 	}
 
 	if (drv_pre_channel_switch(sdata, &ch_switch)) {
-		sdata_info(sdata,
-			   "preparing for channel switch failed, disconnecting\n");
+		link_info(link,
+			  "preparing for channel switch failed, disconnecting\n");
 		goto drop_connection;
 	}
 
-	res = ieee80211_link_reserve_chanctx(link, &csa_ie.chanreq,
-					     chanctx->mode, false);
-	if (res) {
-		sdata_info(sdata,
-			   "failed to reserve channel context for channel switch, disconnecting (err=%d)\n",
-			   res);
-		goto drop_connection;
+	if (chanctx) {
+		res = ieee80211_link_reserve_chanctx(link, &csa_ie.chanreq,
+						     chanctx->mode, false);
+		if (res) {
+			link_info(link,
+				  "failed to reserve channel context for channel switch, disconnecting (err=%d)\n",
+				  res);
+			goto drop_connection;
+		}
 	}
 
 	link->conf->csa_active = true;
@@ -2174,18 +2340,28 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 					  link->link_id, csa_ie.count,
 					  csa_ie.mode);
 
-	if (local->ops->channel_switch) {
-		/* use driver's channel switch callback */
+	/* we may have to handle timeout for deactivated link in software */
+	now = jiffies;
+	link->u.mgd.csa_time = now +
+			       TU_TO_JIFFIES((max_t(int, csa_ie.count, 1) - 1) *
+					     link->conf->beacon_int);
+
+	if (ieee80211_vif_link_active(&sdata->vif, link->link_id) &&
+	    local->ops->channel_switch) {
+		/*
+		 * Use driver's channel switch callback, the driver will
+		 * later call ieee80211_chswitch_done(). It may deactivate
+		 * the link as well, we handle that elsewhere and queue
+		 * the chswitch_work for the calculated time then.
+		 */
 		drv_channel_switch(local, sdata, &ch_switch);
 		return;
 	}
 
 	/* channel switch handled in software */
-	timeout = TU_TO_JIFFIES((max_t(int, csa_ie.count, 1) - 1) *
-				cbss->beacon_interval);
 	wiphy_delayed_work_queue(local->hw.wiphy,
 				 &link->u.mgd.chswitch_work,
-				 timeout);
+				 link->u.mgd.csa_time - now);
 	return;
  drop_connection:
 	/*
@@ -6121,6 +6297,110 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
+static void
+ieee80211_mgd_check_cross_link_csa(struct ieee80211_sub_if_data *sdata,
+				   int reporting_link_id,
+				   struct ieee802_11_elems *elems)
+{
+	const struct element *sta_profiles[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	ssize_t sta_profiles_len[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	const struct element *sub;
+	const u8 *subelems;
+	size_t subelems_len;
+	u8 common_size;
+	int link_id;
+
+	if (!ieee80211_mle_size_ok((u8 *)elems->ml_basic, elems->ml_basic_len))
+		return;
+
+	common_size = ieee80211_mle_common_size((u8 *)elems->ml_basic);
+	subelems = (u8 *)elems->ml_basic + common_size;
+	subelems_len = elems->ml_basic_len - common_size;
+
+	for_each_element_id(sub, IEEE80211_MLE_SUBELEM_PER_STA_PROFILE,
+			    subelems, subelems_len) {
+		struct ieee80211_mle_per_sta_profile *prof = (void *)sub->data;
+		struct ieee80211_link_data *link;
+		ssize_t len;
+
+		if (!ieee80211_mle_basic_sta_prof_size_ok(sub->data,
+							  sub->datalen))
+			continue;
+
+		link_id = le16_get_bits(prof->control,
+					IEEE80211_MLE_STA_CONTROL_LINK_ID);
+		/* need a valid link ID, but also not our own, both AP bugs */
+		if (link_id == reporting_link_id ||
+		    link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+			continue;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link)
+			continue;
+
+		len = cfg80211_defragment_element(sub, subelems, subelems_len,
+						  NULL, 0,
+						  IEEE80211_MLE_SUBELEM_FRAGMENT);
+		if (WARN_ON(len < 0))
+			continue;
+
+		sta_profiles[link_id] = sub;
+		sta_profiles_len[link_id] = len;
+	}
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		struct ieee80211_mle_per_sta_profile *prof;
+		struct ieee802_11_elems *prof_elems;
+		struct ieee80211_link_data *link;
+		ssize_t len;
+
+		if (link_id == reporting_link_id)
+			continue;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link)
+			continue;
+
+		if (!sta_profiles[link_id]) {
+			prof_elems = NULL;
+			goto handle;
+		}
+
+		/* we can defragment in-place, won't use the buffer again */
+		len = cfg80211_defragment_element(sta_profiles[link_id],
+						  subelems, subelems_len,
+						  (void *)sta_profiles[link_id],
+						  sta_profiles_len[link_id],
+						  IEEE80211_MLE_SUBELEM_FRAGMENT);
+		if (WARN_ON(len != sta_profiles_len[link_id]))
+			continue;
+
+		prof = (void *)sta_profiles[link_id];
+		prof_elems = ieee802_11_parse_elems(prof->variable +
+						    (prof->sta_info_len - 1),
+						    len -
+						    (prof->sta_info_len - 1),
+						    false, NULL);
+
+		/* memory allocation failed - let's hope that's transient */
+		if (!prof_elems)
+			continue;
+
+handle:
+		/*
+		 * FIXME: the timings here are obviously incorrect,
+		 * but only older Intel drivers seem to care, and
+		 * those don't have MLO. If you really need this,
+		 * the problem is having to calculate it with the
+		 * TSF offset etc. The device_timestamp is still
+		 * correct, of course.
+		 */
+		ieee80211_sta_process_chanswitch(link, 0, 0, elems, prof_elems,
+						 IEEE80211_CSA_SOURCE_OTHER_LINK);
+		kfree(prof_elems);
+	}
+}
+
 static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 				     struct ieee80211_hdr *hdr, size_t len,
 				     struct ieee80211_rx_status *rx_status)
@@ -6344,7 +6624,11 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	ieee80211_sta_process_chanswitch(link, rx_status->mactime,
 					 rx_status->device_timestamp,
-					 elems, true);
+					 elems, elems,
+					 IEEE80211_CSA_SOURCE_BEACON);
+
+	/* note that after this elems->ml_basic can no longer be used fully */
+	ieee80211_mgd_check_cross_link_csa(sdata, rx_status->link_id, elems);
 
 	if (!link->u.mgd.disable_wmm_tracking &&
 	    ieee80211_sta_wmm_params(local, link, elems->wmm_param,
@@ -6940,7 +7224,8 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				ieee80211_sta_process_chanswitch(link,
 								 rx_status->mactime,
 								 rx_status->device_timestamp,
-								 elems, false);
+								 elems, elems,
+								 IEEE80211_CSA_SOURCE_ACTION);
 			kfree(elems);
 		} else if (mgmt->u.action.category == WLAN_CATEGORY_PUBLIC) {
 			struct ieee802_11_elems *elems;
@@ -6968,7 +7253,8 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				ieee80211_sta_process_chanswitch(link,
 								 rx_status->mactime,
 								 rx_status->device_timestamp,
-								 elems, false);
+								 elems, elems,
+								 IEEE80211_CSA_SOURCE_ACTION);
 			}
 
 			kfree(elems);
-- 
2.34.1



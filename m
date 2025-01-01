Return-Path: <linux-wireless+bounces-16951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F29FF2D2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83D118828C2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560814C92;
	Wed,  1 Jan 2025 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2loUYfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B40DF78
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707957; cv=none; b=CBn27v1VtaGthqkxszhtxmqYO/7KljPiHQbGGSFPC7Kpa/JYnhCHNqWGjY+jXsJC+hV0YvCG3MUDV7I7o0yFdSET/oOx2/2Tp90dLNHmrMAVIxNWvY+0bwWi4t+0HUTeZCi7bBNmP4vhWeIOV//z0T9i+IHMEtz7xIEC1z7I1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707957; c=relaxed/simple;
	bh=sgs3zY/HS2klJHHbCcT7HeU7tH5cswtFcM0TuyZCPsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ilgK5XzzDIgNMUXFEIGCGFncPzkIua1XXLC3RfPmuPoLqzynUgEtJCmUuibNwNVpS7nSp5FegPbhcwYZZWP+xNNfyUsgV/424HxnCp6+mywrmL7jvyGD8x/BqKgLz6OtcO142NuH6OB4pAJRJ22IVZhKBMyIjiWzFmcVE8FjZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2loUYfm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707955; x=1767243955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sgs3zY/HS2klJHHbCcT7HeU7tH5cswtFcM0TuyZCPsc=;
  b=c2loUYfmYzPfxETSAOa2wfi3aKXRNiLKMhbk1wH3Z+/d3y0lX9RKHi9r
   oBRs9MQtzmPE43QzbIb43inPdd1fhbjCrFKnppgpKLhIUSIbyDoCRyJlN
   zzcAMHC3QwsBlXlfTkHXeNA/mTGo2KZ6EIKWsZDHPhfboosa2L0INOFDX
   P+ai4+JTDC/OO4kfsMgKk5SEKTuQ5gDtv9jwVSZrExeKbAFgdCwnJLTGc
   rjkZMFTs6ddQsrhuI2uIq71rcBGMS3pQwc29tszMxqL3X+yoQ51qVTTdm
   P5XP9kKNOFaUWviNByWP3mcFVqZoUiNCxD7fb3SlyzPXf6sGTzLu1iMrf
   w==;
X-CSE-ConnectionGUID: S694B3jDQEGJaOwbdYp4Xg==
X-CSE-MsgGUID: 0RNIZBzoQJ6XSKDJjww8Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194397"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194397"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:55 -0800
X-CSE-ConnectionGUID: KhDmPInSQUSGezSukW8JnA==
X-CSE-MsgGUID: eEqcF4M+SQqI2m0Gagbs5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618867"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/19] wifi: mac80211: add some support for RX OMI power saving
Date: Wed,  1 Jan 2025 07:05:21 +0200
Message-Id: <20250101070249.2c1a1934bd73.I4e90fd503504e37f9eac5bdae62e3f07e7071275@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In order to save power, it can be desirable to change the
RX operating mode using OMI to reduce the bandwidth. As the
handshake must be done in the HTC+ field, it cannot be done
by mac80211 directly, so expose functions to the driver to
request and finalize the necessary updates.

Note that RX OMI really only changes what the peer (AP) will
transmit to us, but in order to use it to actually save some
power (by reducing the listen bandwidth) we also update rate
scaling and then the channel context's mindef accordingly.

The updates are split into two in order to sequence them
correctly, when reducing bandwidth first reduce the rate
scaling and thus TX, then send OMI, then reduce the listen
bandwidth (chandef); when increasing bandwidth this is the
other way around. This also requires tracking in different
variables which part is applicable already.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h  |  46 ++++++++++++++++
 net/mac80211/chan.c     |   7 +++
 net/mac80211/he.c       | 119 +++++++++++++++++++++++++++++++++++++++-
 net/mac80211/sta_info.c |  18 ++++++
 net/mac80211/sta_info.h |   7 +++
 net/mac80211/trace.h    |  98 +++++++++++++++++++++++++++++++++
 net/mac80211/vht.c      |  33 +++++++++--
 7 files changed, 323 insertions(+), 5 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9320d4bc22ee..9cb88ef4b7c9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2336,6 +2336,8 @@ enum ieee80211_sta_rx_bandwidth {
 	IEEE80211_STA_RX_BW_320,
 };
 
+#define IEEE80211_STA_RX_BW_MAX	IEEE80211_STA_RX_BW_320
+
 /**
  * struct ieee80211_sta_rates - station rate selection table
  *
@@ -7734,6 +7736,50 @@ ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width)
 	}
 }
 
+/**
+ * ieee80211_prepare_rx_omi_bw - prepare for sending BW RX OMI
+ * @link_sta: the link STA the OMI is going to be sent to
+ * @bw: the bandwidth requested
+ *
+ * When the driver decides to do RX OMI to change bandwidth with a STA
+ * it calls this function to prepare, then sends the OMI, and finally
+ * calls ieee80211_finalize_rx_omi_bw().
+ *
+ * Note that the (link) STA rate control is updated accordingly as well,
+ * but the chanctx might not be updated if there are other users.
+ * If the intention is to reduce the listen bandwidth, the driver must
+ * ensure there are no TDLS stations nor other uses of the chanctx.
+ *
+ * Also note that in order to sequence correctly, narrowing bandwidth
+ * will only happen in ieee80211_finalize_rx_omi_bw(), whereas widening
+ * again (e.g. going back to normal) will happen here.
+ *
+ * Note that we treat this symmetrically, so if the driver calls this
+ * and tells the peer to only send with a lower bandwidth, we assume
+ * that the driver also wants to only send at that lower bandwidth, to
+ * allow narrowing of the chanctx request for this station/interface.
+ *
+ * Finally, the driver must ensure that if the function returned %true,
+ * ieee80211_finalize_rx_omi_bw() is also called, even for example in
+ * case of HW restart.
+ *
+ * Context: Must be called with wiphy mutex held, and will call back
+ *	    into the driver, so ensure no driver locks are held.
+ *
+ * Return: %true if changes are going to be made, %false otherwise
+ */
+bool ieee80211_prepare_rx_omi_bw(struct ieee80211_link_sta *link_sta,
+				 enum ieee80211_sta_rx_bandwidth bw);
+
+/**
+ * ieee80211_finalize_rx_omi_bw - finalize BW RX OMI update
+ * @link_sta: the link STA the OMI was sent to
+ *
+ * See ieee80211_client_prepare_rx_omi_bw(). Context is the same here
+ * as well.
+ */
+void ieee80211_finalize_rx_omi_bw(struct ieee80211_link_sta *link_sta);
+
 /* for older drivers - let's not document these ... */
 int ieee80211_emulate_add_chanctx(struct ieee80211_hw *hw,
 				  struct ieee80211_chanctx_conf *ctx);
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index a442cb667520..dc28f2b0957a 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -247,6 +247,13 @@ static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta,
 	if (!link_sta)
 		return NL80211_CHAN_WIDTH_20_NOHT;
 
+	/*
+	 * We assume that TX/RX might be asymmetric (so e.g. VHT operating
+	 * mode notification changes what a STA wants to receive, but not
+	 * necessarily what it will transmit to us), and therefore use the
+	 * capabilities here. Calling it RX bandwidth capability is a bit
+	 * wrong though, since capabilities are in fact symmetric.
+	 */
 	width = ieee80211_sta_cap_rx_bw(link_sta);
 
 	switch (width) {
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index ecbb042dd043..5792ef77e986 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -3,10 +3,11 @@
  * HE handling
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 - 2023 Intel Corporation
+ * Copyright(c) 2019 - 2024 Intel Corporation
  */
 
 #include "ieee80211_i.h"
+#include "rate.h"
 
 static void
 ieee80211_update_from_he_6ghz_capa(const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
@@ -248,3 +249,119 @@ ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
 		he_obss_pd->enable = true;
 	}
 }
+
+static void ieee80211_link_sta_rc_update_omi(struct ieee80211_link_data *link,
+					     struct link_sta_info *link_sta)
+{
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_supported_band *sband;
+	enum ieee80211_sta_rx_bandwidth new_bw;
+	enum nl80211_band band;
+
+	band = link->conf->chanreq.oper.chan->band;
+	sband = sdata->local->hw.wiphy->bands[band];
+
+	new_bw = ieee80211_sta_cur_vht_bw(link_sta);
+	if (link_sta->pub->bandwidth == new_bw)
+		return;
+
+	link_sta->pub->bandwidth = new_bw;
+	rate_control_rate_update(sdata->local, sband, link_sta,
+				 IEEE80211_RC_BW_CHANGED);
+}
+
+bool ieee80211_prepare_rx_omi_bw(struct ieee80211_link_sta *pub_link_sta,
+				 enum ieee80211_sta_rx_bandwidth bw)
+{
+	struct sta_info *sta = container_of(pub_link_sta->sta,
+					    struct sta_info, sta);
+	struct ieee80211_local *local = sta->sdata->local;
+	struct link_sta_info *link_sta =
+		sdata_dereference(sta->link[pub_link_sta->link_id], sta->sdata);
+	struct ieee80211_link_data *link =
+		sdata_dereference(sta->sdata->link[pub_link_sta->link_id],
+				  sta->sdata);
+	struct ieee80211_chanctx_conf *conf;
+	struct ieee80211_chanctx *chanctx;
+	bool ret;
+
+	if (WARN_ON(!link || !link_sta || link_sta->pub != pub_link_sta))
+		return false;
+
+	conf = sdata_dereference(link->conf->chanctx_conf, sta->sdata);
+	if (WARN_ON(!conf))
+		return false;
+
+	trace_api_prepare_rx_omi_bw(local, sta->sdata, link_sta, bw);
+
+	chanctx = container_of(conf, typeof(*chanctx), conf);
+
+	if (link_sta->rx_omi_bw_staging == bw) {
+		ret = false;
+		goto trace;
+	}
+
+	/* must call this API in pairs */
+	if (WARN_ON(link_sta->rx_omi_bw_tx != link_sta->rx_omi_bw_staging ||
+		    link_sta->rx_omi_bw_rx != link_sta->rx_omi_bw_staging)) {
+		ret = false;
+		goto trace;
+	}
+
+	if (bw < link_sta->rx_omi_bw_staging) {
+		link_sta->rx_omi_bw_tx = bw;
+		ieee80211_link_sta_rc_update_omi(link, link_sta);
+	} else {
+		link_sta->rx_omi_bw_rx = bw;
+		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL, false);
+	}
+
+	link_sta->rx_omi_bw_staging = bw;
+	ret = true;
+trace:
+	trace_api_return_bool(local, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ieee80211_prepare_rx_omi_bw);
+
+void ieee80211_finalize_rx_omi_bw(struct ieee80211_link_sta *pub_link_sta)
+{
+	struct sta_info *sta = container_of(pub_link_sta->sta,
+					    struct sta_info, sta);
+	struct ieee80211_local *local = sta->sdata->local;
+	struct link_sta_info *link_sta =
+		sdata_dereference(sta->link[pub_link_sta->link_id], sta->sdata);
+	struct ieee80211_link_data *link =
+		sdata_dereference(sta->sdata->link[pub_link_sta->link_id],
+				  sta->sdata);
+	struct ieee80211_chanctx_conf *conf;
+	struct ieee80211_chanctx *chanctx;
+
+	if (WARN_ON(!link || !link_sta || link_sta->pub != pub_link_sta))
+		return;
+
+	conf = sdata_dereference(link->conf->chanctx_conf, sta->sdata);
+	if (WARN_ON(!conf))
+		return;
+
+	trace_api_finalize_rx_omi_bw(local, sta->sdata, link_sta);
+
+	chanctx = container_of(conf, typeof(*chanctx), conf);
+
+	if (link_sta->rx_omi_bw_tx != link_sta->rx_omi_bw_staging) {
+		/* rate control in finalize only when widening bandwidth */
+		WARN_ON(link_sta->rx_omi_bw_tx > link_sta->rx_omi_bw_staging);
+		link_sta->rx_omi_bw_tx = link_sta->rx_omi_bw_staging;
+		ieee80211_link_sta_rc_update_omi(link, link_sta);
+	}
+
+	if (link_sta->rx_omi_bw_rx != link_sta->rx_omi_bw_staging) {
+		/* channel context in finalize only when narrowing bandwidth */
+		WARN_ON(link_sta->rx_omi_bw_rx < link_sta->rx_omi_bw_staging);
+		link_sta->rx_omi_bw_rx = link_sta->rx_omi_bw_staging;
+		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL, false);
+	}
+
+	trace_api_return_void(local);
+}
+EXPORT_SYMBOL_GPL(ieee80211_finalize_rx_omi_bw);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa22f09e6d14..19bc9cbd34f0 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -509,6 +509,24 @@ static int sta_info_alloc_link(struct ieee80211_local *local,
 	for (i = 0; i < ARRAY_SIZE(link_info->rx_stats_avg.chain_signal); i++)
 		ewma_signal_init(&link_info->rx_stats_avg.chain_signal[i]);
 
+	link_info->rx_omi_bw_rx = IEEE80211_STA_RX_BW_MAX;
+	link_info->rx_omi_bw_tx = IEEE80211_STA_RX_BW_MAX;
+	link_info->rx_omi_bw_staging = IEEE80211_STA_RX_BW_MAX;
+
+	/*
+	 * Cause (a) warning(s) if IEEE80211_STA_RX_BW_MAX != 320
+	 * or if new values are added to the enum.
+	 */
+	switch (link_info->cur_max_bandwidth) {
+	case IEEE80211_STA_RX_BW_20:
+	case IEEE80211_STA_RX_BW_40:
+	case IEEE80211_STA_RX_BW_80:
+	case IEEE80211_STA_RX_BW_160:
+	case IEEE80211_STA_RX_BW_MAX:
+		/* intentionally nothing */
+		break;
+	}
+
 	return 0;
 }
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9f89fb5bee37..cc5f9e4e2083 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -512,6 +512,10 @@ struct ieee80211_fragment_cache {
  * @status_stats.avg_ack_signal: average ACK signal
  * @cur_max_bandwidth: maximum bandwidth to use for TX to the station,
  *	taken from HT/VHT capabilities or VHT operating mode notification
+ * @rx_omi_bw_rx: RX OMI bandwidth restriction to apply for RX
+ * @rx_omi_bw_tx: RX OMI bandwidth restriction to apply for TX
+ * @rx_omi_bw_staging: RX OMI bandwidth restriction to apply later
+ *	during finalize
  * @debugfs_dir: debug filesystem directory dentry
  * @pub: public (driver visible) link STA data
  * TODO Move other link params from sta_info as required for MLD operation
@@ -561,6 +565,9 @@ struct link_sta_info {
 	} tx_stats;
 
 	enum ieee80211_sta_rx_bandwidth cur_max_bandwidth;
+	enum ieee80211_sta_rx_bandwidth rx_omi_bw_rx,
+					rx_omi_bw_tx,
+					rx_omi_bw_staging;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct dentry *debugfs_dir;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index dc35fed7e9b0..fe26fb46758d 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2590,6 +2590,45 @@ TRACE_EVENT(drv_change_sta_links,
  * Tracing for API calls that drivers call.
  */
 
+TRACE_EVENT(api_return_bool,
+	TP_PROTO(struct ieee80211_local *local, bool result),
+
+	TP_ARGS(local, result),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(bool, result)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->result = result;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " result=%d",
+		LOCAL_PR_ARG, __entry->result
+	)
+);
+
+TRACE_EVENT(api_return_void,
+	TP_PROTO(struct ieee80211_local *local),
+
+	TP_ARGS(local),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT, LOCAL_PR_ARG
+	)
+);
+
 TRACE_EVENT(api_start_tx_ba_session,
 	TP_PROTO(struct ieee80211_sta *sta, u16 tid),
 
@@ -3054,6 +3093,65 @@ TRACE_EVENT(api_request_smps,
 	)
 );
 
+TRACE_EVENT(api_prepare_rx_omi_bw,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct link_sta_info *link_sta,
+		 enum ieee80211_sta_rx_bandwidth bw),
+
+	TP_ARGS(local, sdata, link_sta, bw),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		STA_ENTRY
+		__field(int, link_id)
+		__field(u32, bw)
+		__field(bool, result)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		STA_NAMED_ASSIGN(link_sta->sta);
+		__entry->link_id = link_sta->link_id;
+		__entry->bw = bw;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " " VIF_PR_FMT " " STA_PR_FMT " link:%d, bw:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG,
+		__entry->link_id, __entry->bw
+	)
+);
+
+TRACE_EVENT(api_finalize_rx_omi_bw,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct link_sta_info *link_sta),
+
+	TP_ARGS(local, sdata, link_sta),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		STA_ENTRY
+		__field(int, link_id)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		STA_NAMED_ASSIGN(link_sta->sta);
+		__entry->link_id = link_sta->link_id;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " " VIF_PR_FMT " " STA_PR_FMT " link:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->link_id
+	)
+);
+
 /*
  * Tracing for internal functions
  * (which may also be called in response to driver calls)
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 6a20fa099190..c5c5d16ed6c8 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -350,9 +350,9 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 }
 
 /* FIXME: move this to some better location - parses HE/EHT now */
-enum ieee80211_sta_rx_bandwidth
-_ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
-			 struct cfg80211_chan_def *chandef)
+static enum ieee80211_sta_rx_bandwidth
+__ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
+			  struct cfg80211_chan_def *chandef)
 {
 	unsigned int link_id = link_sta->link_id;
 	struct ieee80211_sub_if_data *sdata = link_sta->sta->sdata;
@@ -423,6 +423,28 @@ _ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
 	return IEEE80211_STA_RX_BW_80;
 }
 
+enum ieee80211_sta_rx_bandwidth
+_ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
+			 struct cfg80211_chan_def *chandef)
+{
+	/*
+	 * With RX OMI, also pretend that the STA's capability changed.
+	 * Of course this isn't really true, it didn't change, only our
+	 * RX capability was changed by notifying RX OMI to the STA.
+	 * The purpose, however, is to save power, and that requires
+	 * changing also transmissions to the AP and the chanctx. The
+	 * transmissions depend on link_sta->bandwidth which is set in
+	 * _ieee80211_sta_cur_vht_bw() below, but the chanctx depends
+	 * on the result of this function which is also called by
+	 * _ieee80211_sta_cur_vht_bw(), so we need to do that here as
+	 * well. This is sufficient for the steady state, but during
+	 * the transition we already need to change TX/RX separately,
+	 * so _ieee80211_sta_cur_vht_bw() below applies the _tx one.
+	 */
+	return min(__ieee80211_sta_cap_rx_bw(link_sta, chandef),
+		   link_sta->rx_omi_bw_rx);
+}
+
 enum nl80211_chan_width
 ieee80211_sta_cap_chan_bw(struct link_sta_info *link_sta)
 {
@@ -503,8 +525,11 @@ _ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
 		rcu_read_unlock();
 	}
 
-	bw = _ieee80211_sta_cap_rx_bw(link_sta, chandef);
+	/* intentionally do not take rx_bw_omi_rx into account */
+	bw = __ieee80211_sta_cap_rx_bw(link_sta, chandef);
 	bw = min(bw, link_sta->cur_max_bandwidth);
+	/* but do apply rx_omi_bw_tx */
+	bw = min(bw, link_sta->rx_omi_bw_tx);
 
 	/* Don't consider AP's bandwidth for TDLS peers, section 11.23.1 of
 	 * IEEE80211-2016 specification makes higher bandwidth operation
-- 
2.34.1



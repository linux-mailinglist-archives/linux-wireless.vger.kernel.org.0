Return-Path: <linux-wireless+bounces-27090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FAFB48BD6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69591B26F09
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED92301011;
	Mon,  8 Sep 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZNw5/T3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928530146C
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330030; cv=none; b=pa8MrvcYp35Dau0/SCGNnW6El83B09VI9vSeBBOYxdzwcD86hU4zuhh/1063BlIiTtGL7bIUO/1kMBJSVAkeFnd/OQ1DH3Qq3UZiSs6qDinO6u8DleGeQUMn6jHJC7WXryCMIs0w5ehhCvZbl9Os9gdycsd/JhrT2fWAEFOajsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330030; c=relaxed/simple;
	bh=mhGjRD1yfUfpdsL3OlH2kxtEg4ktOrhuBvixlpDaNI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h25iISVYrVToOWLHe6czmLROscaqm5SOX86Wfs3ghPTtbyr3856DYXGhe56zQas+7ZY7qVrVhxnGWmZo2pdkBFx/gXzPwCUBvui32fNR5epsiGGsoM54J4+0OpwJTYQqDVkQe4oYJ8On7sB3Q4nNAaBCwjNVkEg3UaEOJfPCwhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZNw5/T3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330028; x=1788866028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mhGjRD1yfUfpdsL3OlH2kxtEg4ktOrhuBvixlpDaNI0=;
  b=JZNw5/T3Y2QFf4+JMScaw54A+Sr6tcRztcZHExCKEfPoqGM9Tp+uO43A
   gPZLGOb+m8pt5rflFhNJziDshJmcCt/gCNHRFeLsD6bJT3FLaOAp2kKX3
   rJ8tYPg32Op6SyBso5lp5WNDsURPP6A5z+yxB72JrLP/JcJUAsGhx3xAw
   tIxqoZE1bRLuBoi4sg/VXjCSwuVvE7KZwu79TrcM7OSgx86QOe4+hJP1l
   yhi4QQh2qQzffi3myZHqXc6PxN+qRub/xlRaJlY5OfLP9lTf/gQGxtlFC
   60mZCWVtQ4T7hvULYl/HXMW9f9b7gwTsoM/qW6rR4A2KKgrEmmFrh0YHb
   A==;
X-CSE-ConnectionGUID: U0DWXTcFQ0y9Ou0h3MAmUA==
X-CSE-MsgGUID: 0sMP6kkKQtKG592K7GERBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037905"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037905"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:47 -0700
X-CSE-ConnectionGUID: t70xYDhLRIKkgkkNM6uNPQ==
X-CSE-MsgGUID: Ag5UA6GnTJehh0Iuv6dHZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126591"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 08/14] wifi: mac80211: Support Tx of action frame for NAN
Date: Mon,  8 Sep 2025 14:13:02 +0300
Message-Id: <20250908140015.23b160089228.I65a58af753bcbcfb5c4ad8ef372d546f889725ba@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
References: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for sending management frame over a NAN Device
interface:

- Declare support for the supported management frames types.
- Since action frame transmissions over a NAN Device interface
  do not necessarily require a channel configuration, e.g., they
  can be transmitted during DW, modify the Tx path to avoid
  accessing channel information for NAN Device interface.
- In addition modify the points in the Tx path logic to account
  for cases that a band is not specified in the Tx information.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h    |  4 ++++
 net/mac80211/main.c       |  5 +++++
 net/mac80211/offchannel.c |  5 ++++-
 net/mac80211/rate.c       | 11 ++++++++++-
 net/mac80211/tx.c         | 12 ++++++++++--
 5 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a45e4bee65d4..a5140ecf334b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3192,6 +3192,10 @@ ieee80211_get_tx_rate(const struct ieee80211_hw *hw,
 {
 	if (WARN_ON_ONCE(c->control.rates[0].idx < 0))
 		return NULL;
+
+	if (c->band >= NUM_NL80211_BANDS)
+		return NULL;
+
 	return &hw->wiphy->bands[c->band]->bitrates[c->control.rates[0].idx];
 }
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index e8c85aa77c56..cfc2c64d6230 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -746,6 +746,11 @@ ieee80211_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
 			BIT(IEEE80211_STYPE_AUTH >> 4),
 	},
+	[NL80211_IFTYPE_NAN] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4),
+	},
 };
 
 static const struct ieee80211_ht_cap mac80211_ht_capa_mod_mask = {
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 13df6321634d..ae82533e3c02 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -8,7 +8,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2019, 2022-2024 Intel Corporation
+ * Copyright (C) 2019, 2022-2025 Intel Corporation
  */
 #include <linux/export.h>
 #include <net/mac80211.h>
@@ -897,6 +897,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		need_offchan = true;
 		break;
 	case NL80211_IFTYPE_NAN:
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -910,6 +911,8 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	/* Check if the operating channel is the requested channel */
 	if (!params->chan && mlo_sta) {
 		need_offchan = false;
+	} else if (sdata->vif.type == NL80211_IFTYPE_NAN) {
+		/* Frames can be sent during NAN schedule */
 	} else if (!need_offchan) {
 		struct ieee80211_chanctx_conf *chanctx_conf = NULL;
 		int i;
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 3cb2ad6d0b28..e441f8541603 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -4,7 +4,7 @@
  * Copyright 2005-2006, Devicescape Software, Inc.
  * Copyright (c) 2006 Jiri Benc <jbenc@suse.cz>
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2019, 2022-2024 Intel Corporation
+ * Copyright (C) 2019, 2022-2025 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -98,6 +98,9 @@ void rate_control_tx_status(struct ieee80211_local *local,
 	if (!ref || !test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
 		return;
 
+	if (st->info->band >= NUM_NL80211_BANDS)
+		return;
+
 	sband = local->hw.wiphy->bands[st->info->band];
 
 	spin_lock_bh(&sta->rate_ctrl_lock);
@@ -419,6 +422,9 @@ static bool rate_control_send_low(struct ieee80211_sta *pubsta,
 	int mcast_rate;
 	bool use_basicrate = false;
 
+	if (!sband)
+		return false;
+
 	if (!pubsta || rc_no_data_or_no_ack_use_min(txrc)) {
 		__rate_control_send_low(txrc->hw, sband, pubsta, info,
 					txrc->rate_idx_mask);
@@ -898,6 +904,9 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 		return;
 
 	sdata = vif_to_sdata(vif);
+	if (info->band >= NUM_NL80211_BANDS)
+		return;
+
 	sband = sdata->local->hw.wiphy->bands[info->band];
 
 	if (ieee80211_is_tx_data(skb))
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0ece8d89e094..ae59ba53e5e0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -59,6 +59,9 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 	if (WARN_ON_ONCE(tx->rate.idx < 0))
 		return 0;
 
+	if (info->band >= NUM_NL80211_BANDS)
+		return 0;
+
 	sband = local->hw.wiphy->bands[info->band];
 	txrate = &sband->bitrates[tx->rate.idx];
 
@@ -683,7 +686,10 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 
 	memset(&txrc, 0, sizeof(txrc));
 
-	sband = tx->local->hw.wiphy->bands[info->band];
+	if (info->band < NUM_NL80211_BANDS)
+		sband = tx->local->hw.wiphy->bands[info->band];
+	else
+		return TX_CONTINUE;
 
 	len = min_t(u32, tx->skb->len + FCS_LEN,
 			 tx->local->hw.wiphy->frag_threshold);
@@ -6283,7 +6289,9 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_band band;
 
 	rcu_read_lock();
-	if (!ieee80211_vif_is_mld(&sdata->vif)) {
+	if (sdata->vif.type == NL80211_IFTYPE_NAN) {
+		band = NUM_NL80211_BANDS;
+	} else if (!ieee80211_vif_is_mld(&sdata->vif)) {
 		WARN_ON(link_id >= 0);
 		chanctx_conf =
 			rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-- 
2.34.1



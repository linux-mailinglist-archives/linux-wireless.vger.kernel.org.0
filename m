Return-Path: <linux-wireless+bounces-4160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EBB86AA93
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB80D2879E0
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938A3307B;
	Wed, 28 Feb 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UgypEfyY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25132E64F
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110648; cv=none; b=nv4Ukxsq9OsRb7w7rEUhklird8qu14V6dz4AydMzh8TvgJIHjnKAh8cgzNmgISfWlilmEBYPT0kvWfekIvTZXzhU1XSBaWbrVz5A3tMca7n735muAWvbF8dWQdJcxYz5guNZuw76e4EPkkMf3SU7I4Q2B7FvPCSYND03r8kJb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110648; c=relaxed/simple;
	bh=+59Yy+1t5D4IzXorES1uS5jSTcjXcN+anvAzz3wECYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTEyuDxWJNcVN3g56XtFL99S6RLXTkqVYTFTHcPaKOyOtaEzGIONrob85FzWmOcv3SGshQewkoUQSAqaMZuvyHsMQ2ogNWAdy7nN/PuzvDz+seQg9ksXzeJgrLYCsC0jzVG4nH5B2/gRMKS6Ma/HuqwFxAXtgFY1D7GORG8y1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UgypEfyY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dQm4HOGD7DYtnsJA2BA+Age/RuRbu+/e3cvk5UpzaSQ=;
	t=1709110646; x=1710320246; b=UgypEfyYGEpOLgFCD192HEuVMDabQNTNkEbZ7N+6GQFtrHB
	yDSyoVo8PJ5vxjuq6LEbTeUWDncZza/ERVQKdKuB2rDY6klrTuFtp9tSp9KlfC9+Z9Hn3Y127VaHS
	l/f7sLEPV/xb15rcjyg2DqLl9JGaD/MwORoLuEGdkmpF4rs5RejzXaJk8LmgLHw2xPLfMPHmtpSij
	zg8pzVJ/y5jfdpmJ2fZdQ3lj8dFRJ7z1oRtzQvYpBDov+OoeVYT9Is9bWvVqfF3SkmyDOtsGW5JjT
	QdSJtIcDIVPq6lY74Ho5zWU2BSMTqcVtla4R4xN72JxbDy46TuSq+GCrxElbap/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFki-0000000C0hJ-2TyG;
	Wed, 28 Feb 2024 09:57:24 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 5/8] wifi: mac80211: introduce a feature flag for quiet in CSA
Date: Wed, 28 Feb 2024 09:55:45 +0100
Message-ID: <20240228095719.258439191541.I2469d206e2bf5cb244cfde2b4bbc2ae6d1cd3dd9@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228085718.21171-10-johannes@sipsolutions.net>
References: <20240228085718.21171-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When doing CSA in multi-link, there really isn't a need to
stop transmissions entirely. Add a feature flag for drivers
to indicate they can handle quiet in CSA (be it by parsing
themselves, or by implementing drv_pre_channel_switch()),
to make that possible.

Also clean up the csa_block_tx handling: it clearly cannot
handle multi-link due to the way queues are stopped, move
it to the sdata. Drivers should be doing it themselves for
working properly during CSA in MLO anyway. Also rename it
to indicate that it reflects TX was blocked at mac80211.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  6 ++++++
 net/mac80211/cfg.c         | 16 +++++++++-------
 net/mac80211/debugfs.c     |  3 ++-
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/iface.c       |  6 +++---
 net/mac80211/mlme.c        | 35 +++++++++++++++++++++--------------
 6 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c622450ac012..353488ab94a2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2778,6 +2778,11 @@ struct ieee80211_txq {
  * @IEEE80211_HW_DISALLOW_PUNCTURING: HW requires disabling puncturing in EHT
  *	and connecting with a lower bandwidth instead
  *
+ * @IEEE80211_HW_HANDLES_QUIET_CSA: HW/driver handles quieting for CSA, so
+ *	no need to stop queues. This really should be set by a driver that
+ *	implements MLO, so operation can continue on other links when one
+ *	link is switching.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2836,6 +2841,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_DETECTS_COLOR_COLLISION,
 	IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX,
 	IEEE80211_HW_DISALLOW_PUNCTURING,
+	IEEE80211_HW_HANDLES_QUIET_CSA,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ed8d7919ef2a..692f5c9f9678 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1580,10 +1580,10 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	/* abort any running channel switch or color change */
 	link_conf->csa_active = false;
 	link_conf->color_change_active = false;
-	if (link->csa_block_tx) {
+	if (sdata->csa_blocked_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		link->csa_block_tx = false;
+		sdata->csa_blocked_tx = false;
 	}
 
 	ieee80211_free_next_beacon(link);
@@ -3615,7 +3615,7 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 
-	sdata->deflink.csa_block_tx = block_tx;
+	sdata->csa_blocked_tx = block_tx;
 	sdata_info(sdata, "channel switch failed, disconnecting\n");
 	wiphy_work_queue(local->hw.wiphy, &ifmgd->csa_connection_drop_work);
 }
@@ -3701,10 +3701,10 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 
 	ieee80211_link_info_change_notify(sdata, link_data, changed);
 
-	if (link_data->csa_block_tx) {
+	if (sdata->csa_blocked_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		link_data->csa_block_tx = false;
+		sdata->csa_blocked_tx = false;
 	}
 
 	err = drv_post_channel_switch(link_data);
@@ -3980,12 +3980,14 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	link_data->csa_chanreq = chanreq; 
-	link_data->csa_block_tx = params->block_tx;
 	link_conf->csa_active = true;
 
-	if (link_data->csa_block_tx)
+	if (params->block_tx &&
+	    !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA)) {
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
+		sdata->csa_blocked_tx = true;
+	}
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
 					  &link_data->csa_chanreq.oper, 0,
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 74be49191e70..2f68e92a7404 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -4,7 +4,7 @@
  *
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018 - 2019, 2021-2023 Intel Corporation
+ * Copyright (C) 2018 - 2019, 2021-2024 Intel Corporation
  */
 
 #include <linux/debugfs.h>
@@ -498,6 +498,7 @@ static const char *hw_flag_names[] = {
 	FLAG(DETECTS_COLOR_COLLISION),
 	FLAG(MLO_MCAST_MULTI_LINK_TX),
 	FLAG(DISALLOW_PUNCTURING),
+	FLAG(HANDLES_QUIET_CSA),
 #undef FLAG
 };
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a8ac238bd197..2f1e24a5d030 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1034,7 +1034,6 @@ struct ieee80211_link_data {
 	struct ieee80211_key __rcu *default_beacon_key;
 
 	struct wiphy_work csa_finalize_work;
-	bool csa_block_tx;
 
 	bool operating_11g_mode;
 
@@ -1093,6 +1092,8 @@ struct ieee80211_sub_if_data {
 
 	unsigned long state;
 
+	bool csa_blocked_tx;
+
 	char name[IFNAMSIZ];
 
 	struct ieee80211_fragment_cache frags;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b75b83a5142b..395de62d9cb2 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -8,7 +8,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -544,10 +544,10 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	sdata->vif.bss_conf.csa_active = false;
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sdata->deflink.u.mgd.csa_waiting_bcn = false;
-	if (sdata->deflink.csa_block_tx) {
+	if (sdata->csa_blocked_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->deflink.csa_block_tx = false;
+		sdata->csa_blocked_tx = false;
 	}
 
 	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e359c196de77..ce61e84d8130 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1926,10 +1926,10 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 
 	WARN_ON(!link->conf->csa_active);
 
-	if (link->csa_block_tx) {
+	if (sdata->csa_blocked_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		link->csa_block_tx = false;
+		sdata->csa_blocked_tx = false;
 	}
 
 	link->conf->csa_active = false;
@@ -1997,11 +1997,12 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 
 	ieee80211_link_unreserve_chanctx(link);
 
-	if (link->csa_block_tx)
+	if (sdata->csa_blocked_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
+		sdata->csa_blocked_tx = false;
+	}
 
-	link->csa_block_tx = false;
 	link->conf->csa_active = false;
 
 	drv_abort_channel_switch(link);
@@ -2145,13 +2146,15 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	link->conf->csa_active = true;
 	link->csa_chanreq = csa_ie.chanreq;
-	link->csa_block_tx = csa_ie.mode;
 	link->u.mgd.csa_ignored_same_chan = false;
 	link->u.mgd.beacon_crc_valid = false;
 
-	if (link->csa_block_tx)
+	if (csa_ie.mode &&
+	    !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA)) {
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
+		sdata->csa_blocked_tx = true;
+	}
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chanreq.oper,
 					  link->link_id, csa_ie.count,
@@ -2179,7 +2182,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	 * reset when the disconnection worker runs.
 	 */
 	link->conf->csa_active = true;
-	link->csa_block_tx = csa_ie.mode;
+	sdata->csa_blocked_tx =
+		csa_ie.mode && !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA);
 
 	wiphy_work_queue(sdata->local->hw.wiphy,
 			 &ifmgd->csa_connection_drop_work);
@@ -3233,10 +3237,10 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.bss_conf.csa_active = false;
 	sdata->deflink.u.mgd.csa_waiting_bcn = false;
 	sdata->deflink.u.mgd.csa_ignored_same_chan = false;
-	if (sdata->deflink.csa_block_tx) {
+	if (sdata->csa_blocked_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->deflink.csa_block_tx = false;
+		sdata->csa_blocked_tx = false;
 	}
 
 	/* existing TX TSPEC sessions no longer exist */
@@ -3549,9 +3553,12 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	if (!ifmgd->associated)
 		return;
 
-	/* in MLO assume we have a link where we can TX the frame */
-	tx = ieee80211_vif_is_mld(&sdata->vif) ||
-		!sdata->deflink.csa_block_tx;
+	/*
+	 * MLO drivers should have HANDLES_QUIET_CSA, so that csa_blocked_tx
+	 * is always false; if they don't then this may try to transmit the
+	 * frame but queues will be stopped.
+	 */
+	tx = !sdata->csa_blocked_tx;
 
 	if (!ifmgd->driver_disconnect) {
 		unsigned int link_id;
@@ -3584,10 +3591,10 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	/* the other links will be destroyed */
 	sdata->vif.bss_conf.csa_active = false;
 	sdata->deflink.u.mgd.csa_waiting_bcn = false;
-	if (sdata->deflink.csa_block_tx) {
+	if (sdata->csa_blocked_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->deflink.csa_block_tx = false;
+		sdata->csa_blocked_tx = false;
 	}
 
 	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), tx,
-- 
2.43.2



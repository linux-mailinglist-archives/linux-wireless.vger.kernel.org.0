Return-Path: <linux-wireless+bounces-7251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D58BD5E9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AA41F22D1F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422015B0ED;
	Mon,  6 May 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Mmp2dGju"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C31158216
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025350; cv=none; b=A+zCuBFOEEXeu+5h1idjNZiQoAOwXkzN6xCXer365UgwnYDpm68Z/42sh+MM1xiAA9O4JIaIA9RRmJLaVD/Fsj6AzUldhp0L9lJ8UhLiZDm63LBlN7DWcd1O9dvaO/aJJEYXN2O2pTUH5KjZLsnghXry6Uyo7DC+oN7zw4B4uVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025350; c=relaxed/simple;
	bh=Y/PgmJNAEQ+nTYnanmuiQcwI2XojoBjuhjxOHmmeUjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT/slRYYCFFtvD5BRFmBNo1m4IS7qG+2btnDeKs+bnpTu7ta1aJeEEIGfgKny7XH4uTJHKj7Qd29OjaXlhw+ML5jAJReVDqGRwpLIwPkwwdExnXMSmTt+g0bygSs6BL+hQKa7r+dIVjIiC0m0uZT5HM7wu+iwV54f8CRPdHJnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Mmp2dGju; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+J3YZtCVXDmiisVPZjSbnsklWbzU2Rpn5FYrOLajOpk=;
	t=1715025348; x=1716234948; b=Mmp2dGjuWi7U4kq8zrnlCGHP3bLG2ZYtnbp08KCtLMLLgTI
	XEypQTKHXf0GL0bdlrAunCxSE9Fvr0xKbIYqUpIiYik3lb4V7NTc6udesI0GPxidz7Usd21UHZCpE
	6dnrtQpnWFiTJLRSpXU5b/h7FALGmbLYAzPn2LcAnML0OMTqNLVp36WtxAWrXBRWoCenZo8YtTfCm
	ruoK65D8xs91ids+yNSE/pfynnVCp8i3F4ilE2WubbY60qfMBoKL88V+XNNtqmXBDift5Hc+sc0oe
	nBWR8KOFmUks6BVHf4KwTICIvaUoNBAv9HLEU0rXlxpLAD7Cxfs7Zc+OYnswxA5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s44R7-00000008Cj6-2iVx;
	Mon, 06 May 2024 21:55:45 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/4] wifi: mac80211: collect some CSA data into sub-structs
Date: Mon,  6 May 2024 21:54:49 +0200
Message-ID: <20240506215543.29f954b1f576.I9a683a9647c33d4dd3011aade6677982428c1082@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506195543.104411-6-johannes@sipsolutions.net>
References: <20240506195543.104411-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Collect the CSA data in ieee80211_link_data_managed and
ieee80211_link_data into a csa sub-struct to clean up a
bit and make adding new things more obvious.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 16 ++++-----
 net/mac80211/chan.c        |  4 +--
 net/mac80211/ibss.c        |  6 ++--
 net/mac80211/ieee80211_i.h | 18 ++++++----
 net/mac80211/iface.c       |  4 +--
 net/mac80211/link.c        |  8 ++---
 net/mac80211/mlme.c        | 70 +++++++++++++++++++-------------------
 7 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0ed7e8bbf5c0..3319c9360507 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3633,10 +3633,10 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 				continue;
 
 			wiphy_work_queue(iter->local->hw.wiphy,
-					 &iter->deflink.csa_finalize_work);
+					 &iter->deflink.csa.finalize_work);
 		}
 	}
-	wiphy_work_queue(local->hw.wiphy, &link_data->csa_finalize_work);
+	wiphy_work_queue(local->hw.wiphy, &link_data->csa.finalize_work);
 
 	rcu_read_unlock();
 }
@@ -3723,7 +3723,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 	}
 
 	if (!cfg80211_chandef_identical(&link_conf->chanreq.oper,
-					&link_data->csa_chanreq.oper))
+					&link_data->csa.chanreq.oper))
 		return -EINVAL;
 
 	link_conf->csa_active = false;
@@ -3744,7 +3744,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 	if (err)
 		return err;
 
-	cfg80211_ch_switch_notify(sdata->dev, &link_data->csa_chanreq.oper,
+	cfg80211_ch_switch_notify(sdata->dev, &link_data->csa.chanreq.oper,
 				  link_data->link_id);
 
 	return 0;
@@ -3765,7 +3765,7 @@ static void ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ieee80211_link_data *link =
-		container_of(work, struct ieee80211_link_data, csa_finalize_work);
+		container_of(work, struct ieee80211_link_data, csa.finalize_work);
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 
@@ -4012,7 +4012,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
-	link_data->csa_chanreq = chanreq; 
+	link_data->csa.chanreq = chanreq;
 	link_conf->csa_active = true;
 
 	if (params->block_tx &&
@@ -4023,12 +4023,12 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
-					  &link_data->csa_chanreq.oper, 0,
+					  &link_data->csa.chanreq.oper, 0,
 					  params->count, params->block_tx);
 
 	if (changed) {
 		ieee80211_link_info_change_notify(sdata, link_data, changed);
-		drv_channel_switch_beacon(sdata, &link_data->csa_chanreq.oper);
+		drv_channel_switch_beacon(sdata, &link_data->csa.chanreq.oper);
 	} else {
 		/* if the beacon didn't change, we can finalize immediately */
 		ieee80211_csa_finalize(link_data);
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 380695fdc32f..ec16d7676088 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1162,11 +1162,11 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_OCB:
 		wiphy_work_queue(sdata->local->hw.wiphy,
-				 &link->csa_finalize_work);
+				 &link->csa.finalize_work);
 		break;
 	case NL80211_IFTYPE_STATION:
 		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
-					 &link->u.mgd.chswitch_work, 0);
+					 &link->u.mgd.csa.switch_work, 0);
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_AP_VLAN:
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 7ace5cdc6c26..bf338f3d4dd3 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -9,7 +9,7 @@
  * Copyright 2009, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2016 Intel Deutschland GmbH
- * Copyright(c) 2018-2023 Intel Corporation
+ * Copyright(c) 2018-2024 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -533,12 +533,12 @@ int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata, u64 *changed)
 					IEEE80211_PRIVACY(ifibss->privacy));
 		/* XXX: should not really modify cfg80211 data */
 		if (cbss) {
-			cbss->channel = sdata->deflink.csa_chanreq.oper.chan;
+			cbss->channel = sdata->deflink.csa.chanreq.oper.chan;
 			cfg80211_put_bss(sdata->local->hw.wiphy, cbss);
 		}
 	}
 
-	ifibss->chandef = sdata->deflink.csa_chanreq.oper;
+	ifibss->chandef = sdata->deflink.csa.chanreq.oper;
 
 	/* generate the beacon */
 	return ieee80211_ibss_csa_beacon(sdata, NULL, changed);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4ce34e95902e..cba1c2c3d9f1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -975,11 +975,13 @@ struct ieee80211_link_data_managed {
 	bool disable_wmm_tracking;
 	bool operating_11g_mode;
 
-	bool csa_waiting_bcn;
-	bool csa_ignored_same_chan;
-	bool csa_blocked_tx;
-	unsigned long csa_time;
-	struct wiphy_delayed_work chswitch_work;
+	struct {
+		struct wiphy_delayed_work switch_work;
+		unsigned long time;
+		bool waiting_bcn;
+		bool ignored_same_chan;
+		bool blocked_tx;
+	} csa;
 
 	struct wiphy_work request_smps_work;
 	/* used to reconfigure hardware SM PS */
@@ -1038,11 +1040,13 @@ struct ieee80211_link_data {
 	struct ieee80211_key __rcu *default_mgmt_key;
 	struct ieee80211_key __rcu *default_beacon_key;
 
-	struct wiphy_work csa_finalize_work;
 
 	bool operating_11g_mode;
 
-	struct ieee80211_chan_req csa_chanreq;
+	struct {
+		struct wiphy_work finalize_work;
+		struct ieee80211_chan_req chanreq;
+	} csa;
 
 	struct wiphy_work color_change_finalize_work;
 	struct delayed_work color_collision_detect_work;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1ef4b6dc3730..d1a49ee4a194 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -543,14 +543,14 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 
 	sdata->vif.bss_conf.csa_active = false;
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		sdata->deflink.u.mgd.csa_waiting_bcn = false;
+		sdata->deflink.u.mgd.csa.waiting_bcn = false;
 	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 		sdata->csa_blocked_queues = false;
 	}
 
-	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
+	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa.finalize_work);
 	wiphy_work_cancel(local->hw.wiphy,
 			  &sdata->deflink.color_change_finalize_work);
 	wiphy_delayed_work_cancel(local->hw.wiphy,
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 508759cc9979..2e6e92defbca 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -37,7 +37,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	link_conf->link_id = link_id;
 	link_conf->vif = &sdata->vif;
 
-	wiphy_work_init(&link->csa_finalize_work,
+	wiphy_work_init(&link->csa.finalize_work,
 			ieee80211_csa_finalize_work);
 	wiphy_work_init(&link->color_change_finalize_work,
 			ieee80211_color_change_finalize_work);
@@ -72,7 +72,7 @@ void ieee80211_link_stop(struct ieee80211_link_data *link)
 
 	cancel_delayed_work_sync(&link->color_collision_detect_work);
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
-			  &link->csa_finalize_work);
+			  &link->csa.finalize_work);
 	ieee80211_link_release_channel(link);
 }
 
@@ -366,8 +366,8 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		 */
 		if (link->conf->csa_active)
 			wiphy_delayed_work_queue(local->hw.wiphy,
-						 &link->u.mgd.chswitch_work,
-						 link->u.mgd.csa_time -
+						 &link->u.mgd.csa.switch_work,
+						 link->u.mgd.csa.time -
 						 jiffies);
 	}
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c1d405726dfc..702a8399969a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2057,12 +2057,12 @@ void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
 }
 
 /* spectrum management related things */
-static void ieee80211_chswitch_work(struct wiphy *wiphy,
-				    struct wiphy_work *work)
+static void ieee80211_csa_switch_work(struct wiphy *wiphy,
+				      struct wiphy_work *work)
 {
 	struct ieee80211_link_data *link =
 		container_of(work, struct ieee80211_link_data,
-			     u.mgd.chswitch_work.work);
+			     u.mgd.csa.switch_work.work);
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
@@ -2085,8 +2085,8 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 	 * update cfg80211 directly.
 	 */
 	if (!ieee80211_vif_link_active(&sdata->vif, link->link_id)) {
-		link->conf->chanreq = link->csa_chanreq;
-		cfg80211_ch_switch_notify(sdata->dev, &link->csa_chanreq.oper,
+		link->conf->chanreq = link->csa.chanreq;
+		cfg80211_ch_switch_notify(sdata->dev, &link->csa.chanreq.oper,
 					  link->link_id);
 		return;
 	}
@@ -2119,7 +2119,7 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 	}
 
 	if (!ieee80211_chanreq_identical(&link->conf->chanreq,
-					 &link->csa_chanreq)) {
+					 &link->csa.chanreq)) {
 		link_info(link,
 			  "failed to finalize channel switch, disconnecting\n");
 		wiphy_work_queue(sdata->local->hw.wiphy,
@@ -2127,7 +2127,7 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 		return;
 	}
 
-	link->u.mgd.csa_waiting_bcn = true;
+	link->u.mgd.csa.waiting_bcn = true;
 
 	ieee80211_sta_reset_beacon_monitor(sdata);
 	ieee80211_sta_reset_conn_monitor(sdata);
@@ -2151,8 +2151,8 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 	}
 
 	link->conf->csa_active = false;
-	link->u.mgd.csa_blocked_tx = false;
-	link->u.mgd.csa_waiting_bcn = false;
+	link->u.mgd.csa.blocked_tx = false;
+	link->u.mgd.csa.waiting_bcn = false;
 
 	ret = drv_post_channel_switch(link);
 	if (ret) {
@@ -2192,7 +2192,7 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
 		}
 
 		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
-					 &link->u.mgd.chswitch_work, 0);
+					 &link->u.mgd.csa.switch_work, 0);
 	}
 
 	rcu_read_unlock();
@@ -2219,7 +2219,7 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 	}
 
 	link->conf->csa_active = false;
-	link->u.mgd.csa_blocked_tx = false;
+	link->u.mgd.csa.blocked_tx = false;
 
 	drv_abort_channel_switch(link);
 }
@@ -2324,7 +2324,7 @@ ieee80211_sta_other_link_csa_disappeared(struct ieee80211_link_data *link,
 	 * puncturing configuration, but we don't have enough data to
 	 * detect that.
 	 */
-	if (data.chan != link->csa_chanreq.oper.chan)
+	if (data.chan != link->csa.chanreq.oper.chan)
 		ieee80211_sta_abort_chanswitch(link);
 }
 
@@ -2398,7 +2398,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 			/* already processing - disregard action frames */
 			return;
 		case IEEE80211_CSA_SOURCE_BEACON:
-			if (link->u.mgd.csa_waiting_bcn) {
+			if (link->u.mgd.csa.waiting_bcn) {
 				ieee80211_chswitch_post_beacon(link);
 				/*
 				 * If the CSA is still present after the switch
@@ -2421,7 +2421,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 				return;
 
 			/* switch work ran, so just complete the process */
-			if (link->u.mgd.csa_waiting_bcn) {
+			if (link->u.mgd.csa.waiting_bcn) {
 				ieee80211_chswitch_post_beacon(link);
 				/*
 				 * If the CSA is still present after the switch
@@ -2476,12 +2476,12 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	if (cfg80211_chandef_identical(&csa_ie.chanreq.oper,
 				       &link->conf->chanreq.oper) &&
 	    (!csa_ie.mode || source != IEEE80211_CSA_SOURCE_BEACON)) {
-		if (link->u.mgd.csa_ignored_same_chan)
+		if (link->u.mgd.csa.ignored_same_chan)
 			return;
 		link_info(link,
 			  "AP %pM tries to chanswitch to same channel, ignore\n",
 			  link->u.mgd.bssid);
-		link->u.mgd.csa_ignored_same_chan = true;
+		link->u.mgd.csa.ignored_same_chan = true;
 		return;
 	}
 
@@ -2529,10 +2529,10 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	}
 
 	link->conf->csa_active = true;
-	link->csa_chanreq = csa_ie.chanreq;
-	link->u.mgd.csa_ignored_same_chan = false;
+	link->csa.chanreq = csa_ie.chanreq;
+	link->u.mgd.csa.ignored_same_chan = false;
 	link->u.mgd.beacon_crc_valid = false;
-	link->u.mgd.csa_blocked_tx = csa_ie.mode;
+	link->u.mgd.csa.blocked_tx = csa_ie.mode;
 
 	if (csa_ie.mode &&
 	    !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA)) {
@@ -2547,7 +2547,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	/* we may have to handle timeout for deactivated link in software */
 	now = jiffies;
-	link->u.mgd.csa_time = now +
+	link->u.mgd.csa.time = now +
 			       TU_TO_JIFFIES((max_t(int, csa_ie.count, 1) - 1) *
 					     link->conf->beacon_int);
 
@@ -2557,7 +2557,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		 * Use driver's channel switch callback, the driver will
 		 * later call ieee80211_chswitch_done(). It may deactivate
 		 * the link as well, we handle that elsewhere and queue
-		 * the chswitch_work for the calculated time then.
+		 * the csa.switch_work for the calculated time then.
 		 */
 		drv_channel_switch(local, sdata, &ch_switch);
 		return;
@@ -2565,8 +2565,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	/* channel switch handled in software */
 	wiphy_delayed_work_queue(local->hw.wiphy,
-				 &link->u.mgd.chswitch_work,
-				 link->u.mgd.csa_time - now);
+				 &link->u.mgd.csa.switch_work,
+				 link->u.mgd.csa.time - now);
 	return;
  drop_connection:
 	/*
@@ -2577,7 +2577,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	 * reset when the disconnection worker runs.
 	 */
 	link->conf->csa_active = true;
-	link->u.mgd.csa_blocked_tx = csa_ie.mode;
+	link->u.mgd.csa.blocked_tx = csa_ie.mode;
 	sdata->csa_blocked_queues =
 		csa_ie.mode && !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA);
 
@@ -3630,9 +3630,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	}
 
 	sdata->vif.bss_conf.csa_active = false;
-	sdata->deflink.u.mgd.csa_blocked_tx = false;
-	sdata->deflink.u.mgd.csa_waiting_bcn = false;
-	sdata->deflink.u.mgd.csa_ignored_same_chan = false;
+	sdata->deflink.u.mgd.csa.blocked_tx = false;
+	sdata->deflink.u.mgd.csa.waiting_bcn = false;
+	sdata->deflink.u.mgd.csa.ignored_same_chan = false;
 	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
@@ -3969,7 +3969,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 		if (WARN_ON_ONCE(!link))
 			continue;
 
-		if (link->u.mgd.csa_blocked_tx)
+		if (link->u.mgd.csa.blocked_tx)
 			continue;
 
 		tx = true;
@@ -4006,8 +4006,8 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 			       tx, frame_buf);
 	/* the other links will be destroyed */
 	sdata->vif.bss_conf.csa_active = false;
-	sdata->deflink.u.mgd.csa_waiting_bcn = false;
-	sdata->deflink.u.mgd.csa_blocked_tx = false;
+	sdata->deflink.u.mgd.csa.waiting_bcn = false;
+	sdata->deflink.u.mgd.csa.blocked_tx = false;
 	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
@@ -7794,7 +7794,7 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 		return;
 
 	if (sdata->vif.bss_conf.csa_active &&
-	    !sdata->deflink.u.mgd.csa_waiting_bcn)
+	    !sdata->deflink.u.mgd.csa.waiting_bcn)
 		return;
 
 	if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)
@@ -7818,7 +7818,7 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 		return;
 
 	if (sdata->vif.bss_conf.csa_active &&
-	    !sdata->deflink.u.mgd.csa_waiting_bcn)
+	    !sdata->deflink.u.mgd.csa.waiting_bcn)
 		return;
 
 	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
@@ -8029,8 +8029,8 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	else
 		link->u.mgd.req_smps = IEEE80211_SMPS_OFF;
 
-	wiphy_delayed_work_init(&link->u.mgd.chswitch_work,
-				ieee80211_chswitch_work);
+	wiphy_delayed_work_init(&link->u.mgd.csa.switch_work,
+				ieee80211_csa_switch_work);
 
 	ieee80211_clear_tpe(&link->conf->tpe);
 
@@ -9161,7 +9161,7 @@ void ieee80211_mgd_stop_link(struct ieee80211_link_data *link)
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
 			  &link->u.mgd.recalc_smps);
 	wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
-				  &link->u.mgd.chswitch_work);
+				  &link->u.mgd.csa.switch_work);
 }
 
 void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
-- 
2.44.0



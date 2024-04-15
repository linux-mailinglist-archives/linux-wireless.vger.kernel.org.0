Return-Path: <linux-wireless+bounces-6304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A528A4A4D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98F4B255A0
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBF3376F4;
	Mon, 15 Apr 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BD1nFw0M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04BE374CB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169652; cv=none; b=EURb+RtbR+xqBwXK/Y/pWXv1pN9Z06hI0fJRXy0M3vsawG/6qhflz2VdI6tPxcpUp7rFlMPYt8358mVKJMdeTsS7i7+Y17BdZxaIsAa1TBoW3Icw7zTfW/XQD6WVWGbNO7ndgTLHnqZn1SS7udEvZNnxGQRV6yUHTGt7kXOF0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169652; c=relaxed/simple;
	bh=gZ7qs88l7Cmix+6BzH78paq4JHdPkeZVbYfeY3t2ySQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BiNBVrWWdbKGBZhxTNYbWXF7/jVdQFt7oSNequncEfHaTZM2Gk0LvNwwYrF8FfULV5LaezUmdqGjZsjXL7+npLmIwjk7rTZl/NsIdOZjAX5Z+MRIVNnVN4optp66LYYT32CqgwQYfRBbRIpgNyu5kRqYd9U55SJ1ousHx2aDF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BD1nFw0M; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713169651; x=1744705651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gZ7qs88l7Cmix+6BzH78paq4JHdPkeZVbYfeY3t2ySQ=;
  b=BD1nFw0MCMlvcQJvGcac48T8dN7r9YePrXriKuzh2UJhibyJJs6DsqDa
   vkJkAMfb/Z8eEUjdpdDxS6EksRVt+hkE45Ku735s9i4tBBU9bexfy1OdW
   Q4uBDNN0Op+HUxd/kxW9+7/FBvAM1Dteoa8ul3vKcTtvW7t6hXKEwN9K+
   3ngKtBPbTiORF2M+VTBxQNw4Lx8f6H0bbqDyGAbTSQRxj9IpqZdnXdx1e
   vJZBkiZsX78PVXp6Llsl9YRGno3dphY7Utm2+ag+zp2LVPYUfCjQYVJec
   Omiv1QbjAQvpgIsCQpBqTiksezCN45rP2wPN/ujmyMZj9uy1Fj/WC0NhS
   w==;
X-CSE-ConnectionGUID: VUqLkr50S/yIgoaF9PFJEw==
X-CSE-MsgGUID: OdnHYsLTQ/u32nNuW1/hxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9097274"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9097274"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:27:30 -0700
X-CSE-ConnectionGUID: 0X9LX/F1RKyUDBOOR4bjrA==
X-CSE-MsgGUID: gQsXuU5xRaSosZ3eqGnssA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26403249"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:27:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] wifi: mac80211: transmit deauth only if link is available
Date: Mon, 15 Apr 2024 11:27:12 +0300
Message-Id: <20240415112355.1d91db5e95aa.Iad3a5df3367f305dff48cd61776abfd6cf0fd4ab@changeid>
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

There's an issue in that when we disconnect from an AP
due to the AP switching to an unsupported channel, we
might not tell the driver about this before we try to
send the deauth. If the underlying implementation has
detected the quiet CSA, this may cause issues if this
is the only active link. Avoid this by transmitting
(and flushing) the deauth only when there's an active
link available that's not affected by quiet CSA.

Since this introduces link->u.mgd.csa_blocked_tx and we
no longer check sdata->csa_blocked_tx for the TX itself
also rename the latter to csa_blocked_queues.

Fixes: 6f0107d195a8 ("wifi: mac80211: introduce a feature flag for quiet in CSA")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c         | 12 ++++-----
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/iface.c       |  4 +--
 net/mac80211/mlme.c        | 53 ++++++++++++++++++++++++++------------
 4 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f67c1d021812..07abaf7820c5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1607,10 +1607,10 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	/* abort any running channel switch or color change */
 	link_conf->csa_active = false;
 	link_conf->color_change_active = false;
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	ieee80211_free_next_beacon(link);
@@ -3648,7 +3648,7 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 
-	sdata->csa_blocked_tx = block_tx;
+	sdata->csa_blocked_queues = block_tx;
 	sdata_info(sdata, "channel switch failed, disconnecting\n");
 	wiphy_work_queue(local->hw.wiphy, &ifmgd->csa_connection_drop_work);
 }
@@ -3734,10 +3734,10 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 
 	ieee80211_link_info_change_notify(sdata, link_data, changed);
 
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	err = drv_post_channel_switch(link_data);
@@ -4019,7 +4019,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	    !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA)) {
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = true;
+		sdata->csa_blocked_queues = true;
 	}
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 588f0d21c89e..15d2d04b41d2 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -976,6 +976,7 @@ struct ieee80211_link_data_managed {
 
 	bool csa_waiting_bcn;
 	bool csa_ignored_same_chan;
+	bool csa_blocked_tx;
 	unsigned long csa_time;
 	struct wiphy_delayed_work chswitch_work;
 
@@ -1095,7 +1096,7 @@ struct ieee80211_sub_if_data {
 
 	unsigned long state;
 
-	bool csa_blocked_tx;
+	bool csa_blocked_queues;
 
 	char name[IFNAMSIZ];
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 395de62d9cb2..ef6b0fc82d02 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -544,10 +544,10 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	sdata->vif.bss_conf.csa_active = false;
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sdata->deflink.u.mgd.csa_waiting_bcn = false;
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5b919d7eedf2..d6106b1a8de0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1942,13 +1942,14 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 
 	WARN_ON(!link->conf->csa_active);
 
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	link->conf->csa_active = false;
+	link->u.mgd.csa_blocked_tx = false;
 	link->u.mgd.csa_waiting_bcn = false;
 
 	ret = drv_post_channel_switch(link);
@@ -2009,13 +2010,14 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 
 	ieee80211_link_unreserve_chanctx(link);
 
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	link->conf->csa_active = false;
+	link->u.mgd.csa_blocked_tx = false;
 
 	drv_abort_channel_switch(link);
 }
@@ -2328,12 +2330,13 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	link->csa_chanreq = csa_ie.chanreq;
 	link->u.mgd.csa_ignored_same_chan = false;
 	link->u.mgd.beacon_crc_valid = false;
+	link->u.mgd.csa_blocked_tx = csa_ie.mode;
 
 	if (csa_ie.mode &&
 	    !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA)) {
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = true;
+		sdata->csa_blocked_queues = true;
 	}
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chanreq.oper,
@@ -2372,7 +2375,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	 * reset when the disconnection worker runs.
 	 */
 	link->conf->csa_active = true;
-	sdata->csa_blocked_tx =
+	link->u.mgd.csa_blocked_tx = csa_ie.mode;
+	sdata->csa_blocked_queues =
 		csa_ie.mode && !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA);
 
 	wiphy_work_queue(sdata->local->hw.wiphy,
@@ -3425,12 +3429,13 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	}
 
 	sdata->vif.bss_conf.csa_active = false;
+	sdata->deflink.u.mgd.csa_blocked_tx = false;
 	sdata->deflink.u.mgd.csa_waiting_bcn = false;
 	sdata->deflink.u.mgd.csa_ignored_same_chan = false;
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	/* existing TX TSPEC sessions no longer exist */
@@ -3736,19 +3741,32 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
-	bool tx;
+	bool tx = false;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!ifmgd->associated)
 		return;
 
-	/*
-	 * MLO drivers should have HANDLES_QUIET_CSA, so that csa_blocked_tx
-	 * is always false; if they don't then this may try to transmit the
-	 * frame but queues will be stopped.
-	 */
-	tx = !sdata->csa_blocked_tx;
+	/* only transmit if we have a link that makes that worthwhile */
+	for (unsigned int link_id = 0;
+	     link_id < ARRAY_SIZE(sdata->link);
+	     link_id++) {
+		struct ieee80211_link_data *link;
+
+		if (!ieee80211_vif_link_active(&sdata->vif, link_id))
+			continue;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (WARN_ON_ONCE(!link))
+			continue;
+
+		if (link->u.mgd.csa_blocked_tx)
+			continue;
+
+		tx = true;
+		break;
+	}
 
 	if (!ifmgd->driver_disconnect) {
 		unsigned int link_id;
@@ -3781,10 +3799,11 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	/* the other links will be destroyed */
 	sdata->vif.bss_conf.csa_active = false;
 	sdata->deflink.u.mgd.csa_waiting_bcn = false;
-	if (sdata->csa_blocked_tx) {
+	sdata->deflink.u.mgd.csa_blocked_tx = false;
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), tx,
-- 
2.34.1



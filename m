Return-Path: <linux-wireless+bounces-8865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C390527A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B79E281A0F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C97F16F848;
	Wed, 12 Jun 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bd55W97S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0DC14E2ED
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195449; cv=none; b=Lc2XAiQRKomsBbSMEFhAQA2yiUtAWmvI5TCH3YvWkggNT9kx2yUIziA7rTBDOVC4uyK0Nrmlarbc1OvbaO47hNfd0lGTxbkgpAjbIBQfjCTYFYHFgdE9epKFLtzxXkUdITUmtdK/vHsGtsrnijgwraMRNAZIgfJ/61TXXYzGyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195449; c=relaxed/simple;
	bh=WCogMhUgOX1OREF4rhsOes1Vkd+EtoLDjwiOmGHncwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwgHZd7rtM5J1sfZkUivX/QmmxQKcHNVPWWH9HLs/9IlItBNixmQ+UG4NSPS17wDCfZ9+z9ULGL4KXnFG3RjdzVDbwB7blDAtGSyUsbUe0UAgJAYma3/ULA85LZrWeFwDVM4R145u1tDn/oI4YIDifTPqTTbpND/kE6BjV7H5i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bd55W97S; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QKXjViKQthO3mP8DrmMgh5GD1NR0gqfmc1M9peKCgr8=;
	t=1718195448; x=1719405048; b=bd55W97SLeHVtp39dOy0dN6fKiTmMTesJizuzs/X9mWYeal
	lSWrsXEyWq6AeF4I0ojYIfEZ3qZwhuAbqDNdycyOfe8W+7Y68ItlRfb9ontEDiZZ0o+44lDU2KJVk
	Z/wvtVjnwDFWRIJILPWv33092pY+v6g50GTn7hg23Ppn7bB3MYKzZtTyZ0jVnKuQ1uQ03nsccMlQu
	tw/ukijeLWl4UokUjFRMvjGjB+hMElYLPmZhelE8VLf5a1g/aKGQgY35Ijso1b0i32hWbVFcADmB3
	kx1UXq150dPV7UwjyYiSliMOS4YaU3CoDIMl7hiAgStvZhMeaAOQIYbbveLViv9g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHN7l-0000000AGRh-11mF;
	Wed, 12 Jun 2024 14:30:45 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/3] wifi: mac80211: refactor CSA queue block/unblock
Date: Wed, 12 Jun 2024 14:28:35 +0200
Message-ID: <20240612143037.1ad22f10392d.If21490c2c67aae28f3c54038363181ee920ce3d1@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612123037.36687-5-johannes@sipsolutions.net>
References: <20240612123037.36687-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This code is duplicated many times, refactor it into
new separate functions.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 20 ++++----------------
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/iface.c       | 29 ++++++++++++++++++++++++-----
 net/mac80211/mlme.c        | 33 ++++++---------------------------
 4 files changed, 37 insertions(+), 48 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 3236477424b8..7eb2e5bedb6f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1615,11 +1615,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	/* abort any running channel switch or color change */
 	link_conf->csa_active = false;
 	link_conf->color_change_active = false;
-	if (sdata->csa_blocked_queues) {
-		ieee80211_wake_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = false;
-	}
+	ieee80211_vif_unblock_queues_csa(sdata);
 
 	ieee80211_free_next_beacon(link);
 
@@ -3757,11 +3753,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 
 	ieee80211_link_info_change_notify(sdata, link_data, changed);
 
-	if (sdata->csa_blocked_queues) {
-		ieee80211_wake_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = false;
-	}
+	ieee80211_vif_unblock_queues_csa(sdata);
 
 	err = drv_post_channel_switch(link_data);
 	if (err)
@@ -4038,12 +4030,8 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	link_data->csa.chanreq = chanreq;
 	link_conf->csa_active = true;
 
-	if (params->block_tx &&
-	    !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA)) {
-		ieee80211_stop_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = true;
-	}
+	if (params->block_tx)
+		ieee80211_vif_block_queues_csa(sdata);
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
 					  &link_data->csa.chanreq.oper, link_id,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3e735c9436d3..b482763e9f99 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1823,6 +1823,9 @@ ieee80211_have_rx_timestamp(struct ieee80211_rx_status *status)
 void ieee80211_vif_inc_num_mcast(struct ieee80211_sub_if_data *sdata);
 void ieee80211_vif_dec_num_mcast(struct ieee80211_sub_if_data *sdata);
 
+void ieee80211_vif_block_queues_csa(struct ieee80211_sub_if_data *sdata);
+void ieee80211_vif_unblock_queues_csa(struct ieee80211_sub_if_data *sdata);
+
 /* This function returns the number of multicast stations connected to this
  * interface. It returns -1 if that number is not tracked, that is for netdevs
  * not in AP or AP_VLAN mode or when using 4addr.
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6b7580c61e0c..f06e165d6c7a 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -544,11 +544,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	sdata->vif.bss_conf.csa_active = false;
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sdata->deflink.u.mgd.csa.waiting_bcn = false;
-	if (sdata->csa_blocked_queues) {
-		ieee80211_wake_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = false;
-	}
+	ieee80211_vif_unblock_queues_csa(sdata);
 
 	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa.finalize_work);
 	wiphy_work_cancel(local->hw.wiphy,
@@ -2345,3 +2341,26 @@ void ieee80211_vif_dec_num_mcast(struct ieee80211_sub_if_data *sdata)
 	else if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		atomic_dec(&sdata->u.vlan.num_mcast_sta);
 }
+
+void ieee80211_vif_block_queues_csa(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+
+	if (ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA))
+		return;
+
+	ieee80211_stop_vif_queues(local, sdata,
+				  IEEE80211_QUEUE_STOP_REASON_CSA);
+	sdata->csa_blocked_queues = true;
+}
+
+void ieee80211_vif_unblock_queues_csa(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+
+	if (sdata->csa_blocked_queues) {
+		ieee80211_wake_vif_queues(local, sdata,
+					  IEEE80211_QUEUE_STOP_REASON_CSA);
+		sdata->csa_blocked_queues = false;
+	}
+}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ef3280fafbe9..ac376ec47a59 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2166,7 +2166,6 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	int ret;
 
@@ -2174,11 +2173,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 
 	WARN_ON(!link->conf->csa_active);
 
-	if (sdata->csa_blocked_queues) {
-		ieee80211_wake_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = false;
-	}
+	ieee80211_vif_unblock_queues_csa(sdata);
 
 	link->conf->csa_active = false;
 	link->u.mgd.csa.blocked_tx = false;
@@ -2242,11 +2237,7 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 
 	ieee80211_link_unreserve_chanctx(link);
 
-	if (sdata->csa_blocked_queues) {
-		ieee80211_wake_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = false;
-	}
+	ieee80211_vif_unblock_queues_csa(sdata);
 
 	link->conf->csa_active = false;
 	link->u.mgd.csa.blocked_tx = false;
@@ -2571,12 +2562,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	link->u.mgd.beacon_crc_valid = false;
 	link->u.mgd.csa.blocked_tx = csa_ie.mode;
 
-	if (csa_ie.mode &&
-	    !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA)) {
-		ieee80211_stop_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = true;
-	}
+	if (csa_ie.mode)
+		ieee80211_vif_block_queues_csa(sdata);
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chanreq.oper,
 					  link->link_id, csa_ie.count,
@@ -3670,11 +3657,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.u.mgd.csa.blocked_tx = false;
 	sdata->deflink.u.mgd.csa.waiting_bcn = false;
 	sdata->deflink.u.mgd.csa.ignored_same_chan = false;
-	if (sdata->csa_blocked_queues) {
-		ieee80211_wake_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = false;
-	}
+	ieee80211_vif_unblock_queues_csa(sdata);
 
 	/* existing TX TSPEC sessions no longer exist */
 	memset(ifmgd->tx_tspec, 0, sizeof(ifmgd->tx_tspec));
@@ -4045,11 +4028,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	sdata->vif.bss_conf.csa_active = false;
 	sdata->deflink.u.mgd.csa.waiting_bcn = false;
 	sdata->deflink.u.mgd.csa.blocked_tx = false;
-	if (sdata->csa_blocked_queues) {
-		ieee80211_wake_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = false;
-	}
+	ieee80211_vif_unblock_queues_csa(sdata);
 
 	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), tx,
 				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
-- 
2.45.2



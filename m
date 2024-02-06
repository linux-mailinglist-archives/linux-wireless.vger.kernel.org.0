Return-Path: <linux-wireless+bounces-3225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FD84B88E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1D9287719
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3849113343E;
	Tue,  6 Feb 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkAxDUEr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0813398A
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231273; cv=none; b=JvGewjuuKn1FMnPW9AS6NtcfdAHeFnEWh+yA3FiiIl2twiwGmyanfgCf0ZlagwjOMqR8Z0t1LQTctz6snC1uuBdFGyAGMoMbVUGWggtsu+n+Uh/SeFLczw/Ma9smkQN0OWnt9dzIvYNA6jugHSWQkuwmnrHc1DpB0v/VuAu0KKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231273; c=relaxed/simple;
	bh=4zBNbH9i4EHXb1cicpYj7BDPwRPkMoTNhD6B4zrRAe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y27rJWO1kSZ4I2wBsbdBlq1vDxdzKlj03y2Bf+vsT787ID5dxuFFCUyjSCAQ0uUOnU9/lns8txR+rxLOkdsoRfHvtmEvWfkDIcb1oOHn5WhvsC/vQrk0eOIGyQgFr9Zp1pTdeEXSDsd6L6Jhtijm5EbpJjFCE/3mph2tzRQLTwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkAxDUEr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707231272; x=1738767272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4zBNbH9i4EHXb1cicpYj7BDPwRPkMoTNhD6B4zrRAe4=;
  b=VkAxDUErUkDW3N8Im0fgXOHKPbctafze8La3i10UvH9gipiN6UJNqVMK
   4f/Lt8/pqhYIHVQjEKw3vbt1so6Hjeq+jUHvSeGcXMfP1eazwf3QOl94k
   RzenAWhVy4mVoxR8Gk8cjiHiHw3N93hiMB+ytyuVAqhHRXoz8Us4HPeFd
   ZXh6vkiQDsdMmrrXl6HkRAK8dPNdYAMV2whOeiJvI+/mlyFBj0Xu899LQ
   nevNaqofC9pv1eRc88Ca+nnwoAkGmzH+ZoKu/Mfbbod/K6Je91h7NpvIY
   oEkVWjLkLNjKvaYx0ULjEsqobr8b4658csvqJOa0T1aDoQ/B6QShnhhjl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="917795"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="917795"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824197922"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824197922"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/8] wifi: mac80211:  make associated BSS pointer visible to the driver
Date: Tue,  6 Feb 2024 16:54:06 +0200
Message-Id: <20240206164849.6fe9782b87b4.Ifbffef638f07ca7f5c2b27f40d2cf2942d21de0b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Some drivers need the data in it, so move it to the link conf,
which is exposed to the driver.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h |  3 +++
 net/mac80211/mlme.c    | 18 +++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 8d6ae22c09bf..9c6ffdc248f0 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -539,6 +539,8 @@ struct ieee80211_fils_discovery {
  * to that BSS) that can change during the lifetime of the BSS.
  *
  * @vif: reference to owning VIF
+ * @bss: the cfg80211 bss descriptor. Valid only for a station, and only
+ *	when associated.
  * @addr: (link) address used locally
  * @link_id: link ID, or 0 for non-MLO
  * @htc_trig_based_pkt_ext: default PE in 4us units, if BSS supports HE
@@ -684,6 +686,7 @@ struct ieee80211_fils_discovery {
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
+	struct cfg80211_bss *bss;
 
 	const u8 *bssid;
 	unsigned int link_id;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cc9a8eaffa6b..0a03b5bb2c5a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1857,7 +1857,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	struct cfg80211_bss *cbss = link->u.mgd.bss;
+	struct cfg80211_bss *cbss = link->conf->bss;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *chanctx;
 	enum nl80211_band current_band;
@@ -2769,7 +2769,7 @@ static u64 ieee80211_link_set_associated(struct ieee80211_link_data *link,
 
 	ieee80211_check_rate_mask(link);
 
-	link->u.mgd.bss = cbss;
+	link->conf->bss = cbss;
 	memcpy(link->u.mgd.bssid, cbss->bssid, ETH_ALEN);
 
 	if (sdata->vif.p2p ||
@@ -2917,7 +2917,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	ifmgd->associated = false;
 
 	/* other links will be destroyed */
-	sdata->deflink.u.mgd.bss = NULL;
+	sdata->deflink.conf->bss = NULL;
 
 	netif_carrier_off(sdata->dev);
 
@@ -3245,7 +3245,7 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 		ieee80211_mlme_send_probe_req(sdata, sdata->vif.addr, dst,
 					      sdata->vif.cfg.ssid,
 					      sdata->vif.cfg.ssid_len,
-					      sdata->deflink.u.mgd.bss->channel);
+					      sdata->deflink.conf->bss->channel);
 	}
 
 	ifmgd->probe_timeout = jiffies + msecs_to_jiffies(probe_wait_ms);
@@ -3328,7 +3328,7 @@ struct sk_buff *ieee80211_ap_probereq_get(struct ieee80211_hw *hw,
 		return NULL;
 
 	if (ifmgd->associated)
-		cbss = sdata->deflink.u.mgd.bss;
+		cbss = sdata->deflink.conf->bss;
 	else if (ifmgd->auth_data)
 		cbss = ifmgd->auth_data->bss;
 	else if (ifmgd->assoc_data && ifmgd->assoc_data->link[0].bss)
@@ -3407,8 +3407,8 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 			link = sdata_dereference(sdata->link[link_id], sdata);
 			if (!link)
 				continue;
-			cfg80211_unlink_bss(local->hw.wiphy, link->u.mgd.bss);
-			link->u.mgd.bss = NULL;
+			cfg80211_unlink_bss(local->hw.wiphy, link->conf->bss);
+			link->conf->bss = NULL;
 		}
 	}
 
@@ -6246,7 +6246,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	}
 
 	if (!ifmgd->associated ||
-	    !ieee80211_rx_our_beacon(bssid, link->u.mgd.bss))
+	    !ieee80211_rx_our_beacon(bssid, link->conf->bss))
 		return;
 	bssid = link->u.mgd.bssid;
 
@@ -6273,7 +6273,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	 */
 	if (!ieee80211_is_s1g_beacon(hdr->frame_control))
 		ncrc = crc32_be(0, (void *)&mgmt->u.beacon.beacon_int, 4);
-	parse_params.bss = link->u.mgd.bss;
+	parse_params.bss = link->conf->bss;
 	parse_params.filter = care_about_ies;
 	parse_params.crc = ncrc;
 	elems = ieee802_11_parse_elems_full(&parse_params);
-- 
2.34.1



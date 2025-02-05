Return-Path: <linux-wireless+bounces-18511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE05DA286D6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B7D188557E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFE222B585;
	Wed,  5 Feb 2025 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN/qe8M+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDF22ACC5
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748418; cv=none; b=Etp2frUJnXGX025SphwBjV15gAg/iA6ARlaxbbh3E9iVY938UKsM8t66C37ryEUl0Yg/Nt0et0NtV4W3XuS6Ze3r1upPbUcfMhVIdWBZ9WSmq+W7FTKhyF6WtIhTq+TzT1IWnIYr3xe3vSaJXNwn2ARfjUOTUnjsSh40spDXXtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748418; c=relaxed/simple;
	bh=W3Mkf6Jsjurfmjd7PuqEa2TFSJHnW/WyLCAH5F7mBaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXhuU41w/dNHmPGzgFt8C2Xip9L9J9gCjnxHtzMm7dcHhWTnlm2b5X8DYl1lAFu/YdB0n4eOPAJbIu1Ho3jOVf7V0BaKnGE572c442BW8VgdrfXptl6aXPuLL9JmhJqK9eKgy51/meDthHhgVifKdjkLI09zo9KkMKwOQeYblOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bN/qe8M+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748416; x=1770284416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W3Mkf6Jsjurfmjd7PuqEa2TFSJHnW/WyLCAH5F7mBaw=;
  b=bN/qe8M+UDGQ3RPEsKEXIE4qFu0e73zfUxYM9DMXgcOaeoDyyOlIH6h1
   MxXkfW6z2pkgG9je0NYt6oYo+t6VTTLC8wJTo5S+Wd06SZ3DNQDElYvfl
   dmu0cPJPzY4QTA8Iu2zFxW+ajIQ46KmfLUU+2nQ91Phrz93pJS3DitRFg
   PWyzgQNl7zhSgRHKFuA9pnh95+IHwQDIfQqIrvbytnxknHAFWotHAr7NL
   oJYXwJhBEDYWqeJY0I1/l1jvgnknEfwTGV3ricaxE+FseRpEClu8tWQq0
   mAPCCH46M/DQNGxGXKTn/VDDYRWDxyXyt5fwfIN78xZg0QvhqR2KrQq7s
   g==;
X-CSE-ConnectionGUID: VayOSpu0S52795rZEqEGBw==
X-CSE-MsgGUID: swrN466HS9SRfsUA5S3HmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225273"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225273"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:13 -0800
X-CSE-ConnectionGUID: O5G5FgWcR9qJ20dWlWptbA==
X-CSE-MsgGUID: OLJ/gMIGSySKAh4fnkGqwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845356"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 17/17] wifi: mac80211: rework the Tx of the deauth in ieee80211_set_disassoc()
Date: Wed,  5 Feb 2025 11:39:27 +0200
Message-Id: <20250205110958.480bfea605e0.I91131eed942e49b9885d73f4180a3c9c26691c62@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we disassociate we may need to send a deauth frame.
Regardless of this decision, we need to flush the queues to drop all the
packets on the Tx queues.

The flow looks like this:

1) Flush packets waiting on the queues (drop=true)
2) Prepare Tx to send the deauth
3) Build the deauth header
4) send the deauth
5) Flush the deauth packet (drop=false)
6) Complete_tx

Step 3 and 4 are done in ieee80211_send_deauth_disassoc() and that
function  must be called even if we decide not to send the deauth
frame because we need step 3 for cfg80211.

This means that if we want to send the deauth frame, we need all the
steps, but if we don't want to send the deauth frame we still want step
1 and 3.

Change the code to do that.

Also, prevent sending the deauth frame if we are in the middle of a CSA
with mode=1 in which case we won't be able to send the frame anyway.
This caused issues in iwlwifi at step 5 since the firmware wouldn't
send the frame and we'd be stuck flushing with drop=false.
Implement this in ieee80211_set_disassoc() which has many callers.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 68 ++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3fb7e624834f..4e8f0a5f6251 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3930,6 +3930,31 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	ifmgd->associated = false;
 
+	if (tx) {
+		bool tx_link_found = false;
+
+		for (link_id = 0;
+		     link_id < ARRAY_SIZE(sdata->link);
+		     link_id++) {
+			struct ieee80211_link_data *link;
+
+			if (!ieee80211_vif_link_active(&sdata->vif, link_id))
+				continue;
+
+			link = sdata_dereference(sdata->link[link_id], sdata);
+			if (WARN_ON_ONCE(!link))
+				continue;
+
+			if (link->u.mgd.csa.blocked_tx)
+				continue;
+
+			tx_link_found = true;
+			break;
+		}
+
+		tx = tx_link_found;
+	}
+
 	/* other links will be destroyed */
 	sdata->deflink.conf->bss = NULL;
 	sdata->deflink.conf->epcs_support = false;
@@ -3960,24 +3985,24 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	 * insist sending these frames which can take time and delay
 	 * the disconnection and possible the roaming.
 	 */
-	if (tx)
-		ieee80211_flush_queues(local, sdata, true);
+	ieee80211_flush_queues(local, sdata, true);
 
-	/* deauthenticate/disassociate now */
-	if (tx || frame_buf) {
+	if (tx) {
 		drv_mgd_prepare_tx(sdata->local, sdata, &info);
 
 		ieee80211_send_deauth_disassoc(sdata, sdata->vif.cfg.ap_addr,
 					       sdata->vif.cfg.ap_addr, stype,
-					       reason, tx, frame_buf);
-	}
+					       reason, true, frame_buf);
 
-	/* flush out frame - make sure the deauth was actually sent */
-	if (tx)
+		/* flush out frame - make sure the deauth was actually sent */
 		ieee80211_flush_queues(local, sdata, false);
 
-	if (tx || frame_buf)
 		drv_mgd_complete_tx(sdata->local, sdata, &info);
+	} else if (frame_buf) {
+		ieee80211_send_deauth_disassoc(sdata, sdata->vif.cfg.ap_addr,
+					       sdata->vif.cfg.ap_addr, stype,
+					       reason, false, frame_buf);
+	}
 
 	/* clear AP addr only after building the needed mgmt frames */
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
@@ -4403,33 +4428,12 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
-	bool tx = false;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!ifmgd->associated)
 		return;
 
-	/* only transmit if we have a link that makes that worthwhile */
-	for (unsigned int link_id = 0;
-	     link_id < ARRAY_SIZE(sdata->link);
-	     link_id++) {
-		struct ieee80211_link_data *link;
-
-		if (!ieee80211_vif_link_active(&sdata->vif, link_id))
-			continue;
-
-		link = sdata_dereference(sdata->link[link_id], sdata);
-		if (WARN_ON_ONCE(!link))
-			continue;
-
-		if (link->u.mgd.csa.blocked_tx)
-			continue;
-
-		tx = true;
-		break;
-	}
-
 	if (!ifmgd->driver_disconnect) {
 		unsigned int link_id;
 
@@ -4457,14 +4461,14 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 			       ifmgd->driver_disconnect ?
 					WLAN_REASON_DEAUTH_LEAVING :
 					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
-			       tx, frame_buf);
+			       true, frame_buf);
 	/* the other links will be destroyed */
 	sdata->vif.bss_conf.csa_active = false;
 	sdata->deflink.u.mgd.csa.waiting_bcn = false;
 	sdata->deflink.u.mgd.csa.blocked_tx = false;
 	ieee80211_vif_unblock_queues_csa(sdata);
 
-	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), tx,
+	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
 				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
 				    ifmgd->reconnect);
 	ifmgd->reconnect = false;
-- 
2.34.1



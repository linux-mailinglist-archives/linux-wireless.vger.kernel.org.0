Return-Path: <linux-wireless+bounces-18458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F8A278E7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5721881C8C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ECB217730;
	Tue,  4 Feb 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVtR8neA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A8A217711
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691034; cv=none; b=GrXwK4/JM+X+udhum5c2qkRjImBpkUUzC6igOdEu9RGBCvk8sJWGm/GCd32CO0ICwmbTtnNcNLkGFNHUY9Txnka5IXX9b4ZjXAg4N1Poa6Np2jPLqbZRDDp6u8eb6fmOzPaCRvHlaETIE0qGjMF1fy0u5Q7WREII4cj+LRI+dhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691034; c=relaxed/simple;
	bh=U+1Bip+0EuCbz6JByXw1CkOZ1rBdv3yEzhoYXyUkSJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3mifRMwhVX4XEQUVomzjwHHd/lJFdfprG0TI0cVZnojMkBTII5VLRajAmF3e5DAORb97W4KIlDHW9KYuQmqM59p8YS3urwy4tdMEYCqMiM8z0bpNb9kLYDLiPLUQzM+c94UiLRhyZvbnyccDcOprKvJBKoJl+gJID+Gspij5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVtR8neA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691032; x=1770227032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+1Bip+0EuCbz6JByXw1CkOZ1rBdv3yEzhoYXyUkSJs=;
  b=kVtR8neAfUU15Q/v56qvNK0VZRq2k7dokn9qxMWZEiZdywgpjB79PTBT
   HbuAUww9pRk0QCU01jkwnR/Pd0AElmiE6q/wG5ilOaKjw0bljC/1AnTSr
   mtnsl84088w5AarA2+pTdBkUw00hSUcL1h9jo33W4OublPMjQTpAR8DNk
   umTIx0c0J/xXTfzJZ/3aMUqZS4kHRbu1szueJXgvkzleGNLX+gM8MOVmy
   pHfPtYu13W96DZ1xryK74Q/n7aZ6gsVfcDQUK4jR3FFuZujxPDShZgwNQ
   wQPklkLQnDDyNRKC9U+v0Lg9yXluNAM3MdLkXzDqexchokijNePjvoHqZ
   w==;
X-CSE-ConnectionGUID: Y0BJGB21Q0C2fZD5JRypOw==
X-CSE-MsgGUID: NG0/IEGNSRG2Z7ydUWE/qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585494"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585494"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:43:06 -0800
X-CSE-ConnectionGUID: /Jh+HiZnQtWzRaj9ZPXwDg==
X-CSE-MsgGUID: NEgqaoLjSGqPgWwN4ypdxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696861"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:43:04 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 20/20] wifi: mac80211: rework the Tx of the deauth in ieee80211_set_disassoc()
Date: Tue,  4 Feb 2025 19:42:17 +0200
Message-Id: <20250204193721.cdd99c927399.I91131eed942e49b9885d73f4180a3c9c26691c62@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
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
index 3c0d11290b7f..8b83f1664aca 100644
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



Return-Path: <linux-wireless+bounces-20089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C312EA580AD
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606643AA0ED
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513C17A30C;
	Sun,  9 Mar 2025 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcNW9Ppo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DD17A2E7
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498648; cv=none; b=PG3m/yKNifRnBeDs0SIZMzq1U+PrTL6nfjAmcxEcxTtgUL+UlAvqhUjln0lyFd8Hcf8Ers+9d49/cSWIwf/e/DDrFcje0kT7kqLNHTExHmrPmxIVb0uX8XaQClaZSK+Na811d4wSzq0vULTZ2C6uj1tA6jIx7tdRhqiKcKoJwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498648; c=relaxed/simple;
	bh=1Uq3jySGv9ULb9S2cyNHo9pQNUEfv4Td+lyJ/y//gUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOJlWmy3SaSfzguPiI312k90cCN6A2THFBL6ixlH9iKoGAdsY+IXzRfc2q1pKJmzgrlB3QIkS0sNs+aI0J40Cif9BhwSjR5Pq1cZ3gWG7vGoWrGiWQdOUtqN8j1BFHZ8r+CdbpaR76fkdjaqOoUYR/wcdBFT9jDmJ/u902rjx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcNW9Ppo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498646; x=1773034646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Uq3jySGv9ULb9S2cyNHo9pQNUEfv4Td+lyJ/y//gUk=;
  b=bcNW9PpoXZbf/6bmI1bNj4lwSu0zd4Oy/WCtdLZ7tIft+Hf/e0mD8//U
   M6IG1UD3dU6Ul5KmGLTYf5/Bz1q91JPkGskdXCveM62KcMSEao6l9v0qo
   9ASmxdSabMTr78qHZiXQLLuf+wf6dtwNA08oY/8QOLcbZlP6vwMrmj2a3
   PGjQKDTustA68LcxoSaGoP+8ZQ8NLb+oFZE4NeW+p6Nzt7TdpJkR9FkNd
   3aJM6qd0X53Qc4WZR0mPp6KILlnSGbwlDWhIZp14MEZw0cAGHtZlj6RaL
   r32R1dIXJqwBJUZ9nn9XpsZLHwfFkv+JzcnkpQoksyi6C+p1k6QGMaV2O
   w==;
X-CSE-ConnectionGUID: t5XbYC1FSoKNw9AHwFm3XA==
X-CSE-MsgGUID: Rez/X56eTOG+9mXDLv9UGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671711"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671711"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:26 -0800
X-CSE-ConnectionGUID: HYGShvhMRV6asGjBF5cdkw==
X-CSE-MsgGUID: bjwiEqGAR6mZ1o+9BWuWvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470660"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 wireless-next 13/15] wifi: iwlwifi: mld: always do MLO scan before link selection
Date: Sun,  9 Mar 2025 07:36:51 +0200
Message-Id: <20250309073442.a4c96e5c49d4.Ie55697af49435c2c45dccf7c607de5857b370f7a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

According to the requirements, if the last scan isn't older than 20
seconds, we can use its results and do the link selection without
scanning before.
But this applies only when trying to get back to EMLSR, not if the link
has bad RSSI/missed beacons.
Since an MLO scan is cheap anyway, and results from 20 seconds before
are really old, always scan before links switching.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 20 ++-----------------
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |  3 ---
 .../net/wireless/intel/iwlwifi/mld/stats.c    |  2 +-
 4 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 1db69aee4e9f..6db8b5305349 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -913,7 +913,7 @@ void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
 		ieee80211_cqm_beacon_loss_notify(vif, GFP_ATOMIC);
 
 		/* try to switch links, no-op if we don't have MLO */
-		iwl_mld_trigger_link_selection(mld, vif);
+		iwl_mld_int_mlo_scan(mld, vif);
 	}
 
 	/* no more logic if we're not in EMLSR */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index bbaf9ad0e9eb..99ba4018fb24 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -289,22 +289,6 @@ int iwl_mld_block_emlsr_sync(struct iwl_mld *mld, struct ieee80211_vif *vif,
 static void _iwl_mld_select_links(struct iwl_mld *mld,
 				  struct ieee80211_vif *vif);
 
-void iwl_mld_trigger_link_selection(struct iwl_mld *mld,
-				    struct ieee80211_vif *vif)
-{
-	bool last_scan_was_recent =
-		time_before(jiffies, mld->scan.last_mlo_scan_jiffies +
-				     IWL_MLD_SCAN_EXPIRE_TIME);
-
-	if (last_scan_was_recent) {
-		IWL_DEBUG_EHT(mld, "MLO scan was recent, skip.\n");
-		_iwl_mld_select_links(mld, vif);
-	} else {
-		IWL_DEBUG_EHT(mld, "Doing link selection after MLO scan\n");
-		iwl_mld_int_mlo_scan(mld, vif);
-	}
-}
-
 void iwl_mld_unblock_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			   enum iwl_mld_emlsr_blocked reason)
 {
@@ -334,7 +318,7 @@ void iwl_mld_unblock_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
 		return;
 
 	IWL_DEBUG_INFO(mld, "EMLSR is unblocked\n");
-	iwl_mld_trigger_link_selection(mld, vif);
+	iwl_mld_int_mlo_scan(mld, vif);
 }
 
 static void
@@ -1011,5 +995,5 @@ void iwl_mld_retry_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif)
 	    mld_vif->emlsr.blocked_reasons)
 		return;
 
-	iwl_mld_trigger_link_selection(mld, vif);
+	iwl_mld_int_mlo_scan(mld, vif);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index fd1abe8e6084..0f1b18f61c75 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -141,9 +141,6 @@ void iwl_mld_emlsr_check_bt(struct iwl_mld *mld);
 
 void iwl_mld_emlsr_check_chan_load(struct iwl_mld *mld);
 
-void iwl_mld_trigger_link_selection(struct iwl_mld *mld,
-				    struct ieee80211_vif *vif);
-
 /**
  * iwl_mld_retry_emlsr - Retry entering EMLSR
  * @mld: MLD context
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 5633885c49ff..a9d3860d8f9c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -384,7 +384,7 @@ static void iwl_mld_update_link_sig(struct ieee80211_vif *vif, int sig,
 	/* Handle inactive EMLSR, check whether to switch links */
 	if (!iwl_mld_emlsr_active(vif)) {
 		if (sig < IWL_MLD_LOW_RSSI_MLO_SCAN_THRESH)
-			iwl_mld_trigger_link_selection(mld, vif);
+			iwl_mld_int_mlo_scan(mld, vif);
 		return;
 	}
 
-- 
2.34.1



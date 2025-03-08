Return-Path: <linux-wireless+bounces-20073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A988DA57F3B
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195FB188E70A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435B720FA9C;
	Sat,  8 Mar 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFTYrVkV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC42135CA
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471318; cv=none; b=if9nSWLuPbGCrJ86ikwDbkwsdiM5oe36vdWRO2lkNoVsVv6mPEdjM9eIxHfe5SftHwjIgNhbz0zSD7HWRlG5m32zqmRMLPSpKN18d25m3fSt4Z/SmcDfQCzLst10mzSt+AsyTB4FX5VYq8H8idW+SzjtYATAvRUcevO/QM42918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471318; c=relaxed/simple;
	bh=1Uq3jySGv9ULb9S2cyNHo9pQNUEfv4Td+lyJ/y//gUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8zPJBTxmt9PIH64K+nAHogOmMjzzeuQNZEIocfx/gXxq32ZnYWGZUAUaOu2NDZ+fwAEBbAKcBr3qbq4nHNKRpAQit465jOq/KeWcmit0Lb0FVhRB0dITwO5ouVdklrQLhnO+j4N5f68vepyfipBeXpz3OeKD7pUMMBcRQ9MKms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFTYrVkV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471316; x=1773007316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Uq3jySGv9ULb9S2cyNHo9pQNUEfv4Td+lyJ/y//gUk=;
  b=FFTYrVkVvQpY5lwpVuAYL8T+gl3YowQmucNqNQc+AXHPWP94tETRUVqw
   AU/sdRuLJ+8ZJPKtPrIi3OC6IlpsyJvtGCBhusgr9i4Jz3ty2lruS/97R
   MetVBfuHHMo930qwkoiGK8Hnj0UstAF5NtYDj5LA0GG2ICeyrIBlFgBPn
   3aeH71WrUCiva5FibMJTFvBTqvTKAleZxIAeVnwLE1kBWBiZBI5nP3cc9
   jJR0ITZgHehiSKCinbNO5+hUEglMil625TBEQlJA/1n4I0+ukp+0Qx0dJ
   A67Pc0EyFehBBsHvkb80btZ6nmhqUOaIXW5XS6Y1afV0KOCJNsbDSU6go
   A==;
X-CSE-ConnectionGUID: YfTxIc/LSe2EYBtFl9wPAg==
X-CSE-MsgGUID: UT76qsJrQoW8trtbjg9GrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540674"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540674"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:56 -0800
X-CSE-ConnectionGUID: 8UuTAu/4StCzKrOnl0mj4Q==
X-CSE-MsgGUID: O8KuXCtBSX6zPhQe3DEcQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352168"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 13/15] wifi: iwlwifi: mld: always do MLO scan before link selection
Date: Sun,  9 Mar 2025 00:01:23 +0200
Message-Id: <20250308235203.a4c96e5c49d4.Ie55697af49435c2c45dccf7c607de5857b370f7a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
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



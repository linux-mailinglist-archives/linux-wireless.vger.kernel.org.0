Return-Path: <linux-wireless+bounces-16807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8321C9FCBA1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E498418832A8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B3A136E3F;
	Thu, 26 Dec 2024 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjy6EoBE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E425760
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227920; cv=none; b=o/LMMs464OFrIT0hyZj3V7/531GX33OjGTCxwvp8124iO+R9fDzipF4D8yCrQwwFbn7+d+Rz3W9azhlwqd1304cLPWKJ4b8s8AVA/Pp2+bLVH4gftI/xJJKu58JZ1KkmXY4E6sU7I9NBhpRDnDdd/rDQew/mnZI6BT4rZQZlaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227920; c=relaxed/simple;
	bh=BK5ubLpyyBys6V6kJxqdZOGjV/+8nA00B/08+3U/+Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I4mEDL3i4X6cc+1EWNo/MFzg+Gtz2bZgU6sXl2fmTMB09WWgboIURWLylzUPjaNV1IEy1/FeX8gplfMnVQmlAP7EUC3hkvrmGggkMcr9XBiMpKrpO4aQFtobwdrS0Wi+zbL9swBL+3keQCPgJseHgoiacS/SaabP7xymBeG0LD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjy6EoBE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227918; x=1766763918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BK5ubLpyyBys6V6kJxqdZOGjV/+8nA00B/08+3U/+Bc=;
  b=hjy6EoBElpQLNWRDn9f5yL9q5BezMzWMwk+mXIlbv9r9SAgQXTfvgIsj
   90L2RTujbZjak6RFF5DICmgxn8k+TL7cdYPAdWmx2bAT3ChNmWpHxM22P
   KK00YRWjCLnVwQjmFI9Vjyhrsf5eqNspYkHG7hJXvDgT9NajEpyT+Ng6P
   zzzsIHG72/bvIT5H7W1NH17KQcOOMy76ifALbkOBE5QmTxD7N3vGkIEo0
   zdg59yGzuhbX+m996tsjVrAVbEiZK26d9bsWi9NSd+ICVfHjUEkJcREl1
   +5HavsAAAfQYVuwCNowWZuXadFKz0Q/g19RERWt25PavkBd4ZjPSljMzO
   g==;
X-CSE-ConnectionGUID: J4/cv3xMSJyLRSZPvqBtBA==
X-CSE-MsgGUID: RIBvPYWSTcqNJ7/mtQGteg==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878128"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878128"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:15 -0800
X-CSE-ConnectionGUID: Kc2c1/9ZRw68uBF+RMpQCQ==
X-CSE-MsgGUID: v8NqzyVURl2Xg/evTizr6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99777978"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	"Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH 02/15] wifi: mvm: Request periodic system statistics earlier
Date: Thu, 26 Dec 2024 17:44:43 +0200
Message-Id: <20241226174257.4ca59fe0e060.Ic46280aad4dc7087a7d6d0773b86c255133cb7d6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>

Currently driver requests periodic statistics after entering EMLSR.
This means that when not in EMLSR, link selection decisions will be
done based on old statistics, from the association time.

Request periodic statistics already at association instead,

Signed-off-by: Somashekhar(Som) <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 15 ++++++++-------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 07778d55878b..cd93fbf40eb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4113,10 +4113,6 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 		wiphy_work_cancel(mvm->hw->wiphy, &mvmvif->unblock_esr_tpt_wk);
 		wiphy_delayed_work_cancel(mvm->hw->wiphy,
 					  &mvmvif->unblock_esr_tmp_non_bss_wk);
-
-		/* No need for the periodic statistics anymore */
-		if (ieee80211_vif_is_mld(vif) && mvmvif->esr_active)
-			iwl_mvm_request_periodic_system_statistics(mvm, false);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index b807046144c0..cc54c33dcb02 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -267,9 +267,6 @@ static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
 	else
 		mvmvif->primary_link = __ffs(vif->active_links);
 
-	/* Needed for tracking RSSI */
-	iwl_mvm_request_periodic_system_statistics(mvm, true);
-
 	/*
 	 * Restart the MPDU counters and the counting window, so when the
 	 * statistics arrive (which is where we look at the counters) we
@@ -323,7 +320,6 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 		ret = iwl_mvm_esr_mode_active(mvm, vif);
 		if (ret) {
 			IWL_ERR(mvm, "failed to activate ESR mode (%d)\n", ret);
-			iwl_mvm_request_periodic_system_statistics(mvm, false);
 			goto out;
 		}
 	}
@@ -449,8 +445,6 @@ static int iwl_mvm_esr_mode_inactive(struct iwl_mvm *mvm,
 			break;
 	}
 
-	iwl_mvm_request_periodic_system_statistics(mvm, false);
-
 	/* Start a new counting window */
 	iwl_mvm_restart_mpdu_count(mvm, mvmvif);
 
@@ -881,8 +875,13 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 		if (vif->cfg.assoc) {
 			mvmvif->session_prot_connection_loss = false;
 
-			/* clear statistics to get clean beacon counter */
+			/*
+			 * Clear statistics to get clean beacon counter, and ask for
+			 * periodic statistics, as they are needed for link
+			 * selection and RX OMI decisions.
+			 */
 			iwl_mvm_request_statistics(mvm, true);
+			iwl_mvm_request_periodic_system_statistics(mvm, true);
 			iwl_mvm_sf_update(mvm, vif, false);
 			iwl_mvm_power_vif_assoc(mvm, vif);
 
@@ -930,6 +929,8 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 		} else if (iwl_mvm_mld_vif_have_valid_ap_sta(mvmvif)) {
 			iwl_mvm_mei_host_disassociated(mvm);
 
+			iwl_mvm_request_periodic_system_statistics(mvm, false);
+
 			/* If update fails - SF might be running in associated
 			 * mode while disassociated - which is forbidden.
 			 */
-- 
2.34.1



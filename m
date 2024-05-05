Return-Path: <linux-wireless+bounces-7182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942A08BBF70
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C583C1C20D34
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3E71869;
	Sun,  5 May 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIOI31mc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1FAB645
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890025; cv=none; b=WZQ0B6z9uTST6qoY/kWMb1fjz8+vygoQCngWZOLjFBExOMX4jMCvHhAQ5NbHiGZxa0r8h0CLgG7H2A532Yp59+x6qhr4rNcliw+VxRg4yR28yj2no1dtkhNY4lrlsKsmnnYjcEit8oKA4SacehnL4Ip5yKuVI7+Cf26Z64KF19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890025; c=relaxed/simple;
	bh=4m4esqr8KbaJk6zrTax8tHg5bMnEgpFXd/cwDk5w+Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OInlHh+e0/1e/thpXTAECfe8DgaXR3513P8HB/lyt/mUzXmv+eOs4dPfr+hCi/9cFOFdOxi8AUhel1WgsBOl5ybfWqFelHafYja9BeFI9VO6sACNF4qYsBchYQxWnc9matSgSrI2dZuACTfWn41dYxG/bT6RREUQiFJA/pazUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIOI31mc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890024; x=1746426024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4m4esqr8KbaJk6zrTax8tHg5bMnEgpFXd/cwDk5w+Jk=;
  b=PIOI31mcsMSApdhDtk2o42sPjpHw9vIfObjpuNEt325WdyXVLZMF/rp4
   qh5mIqNkg67R1DvRzDIVV6UzQbXnjUAD+YKqQutcG0K4CvXuBB1rUWc8W
   UW537mik7Rz2roWNiao5iULWHcONcBYsFIvpAG8IWfKbSgu/thIGLPAav
   tYNKdXzqArXHj8KUhEbKHe50qYDkSBWPweNayiC2Ur9vdY7G5KbcFTFTj
   HwYXtrdAYRafkL4igVzvKwXYwwSM6tAN8oK5mq6EnsbhZDoHKnU1Jss/O
   O7RmAf9RhVpmY+XXHB4iXAirscwVvoiza2pxhvMP7SkmJswqKA1XZN2/w
   Q==;
X-CSE-ConnectionGUID: LwJqA3Z4SrizuLx7+VSw6g==
X-CSE-MsgGUID: dqXQZ5NwQ52zcwJZ6GeW6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461807"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461807"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:18 -0700
X-CSE-ConnectionGUID: 6mlY7qMsSiSbyYg0cIJGkQ==
X-CSE-MsgGUID: fVDXXyf2TE65j5I6iHfYCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903587"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: mvm: Always allow entering EMLSR from debugfs
Date: Sun,  5 May 2024 09:19:48 +0300
Message-Id: <20240505091420.bc3c24d9e0e6.Iad60e22a0d7e2b2b989051e1140b6dc98bef7bcc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

EMLSR can't be activated from mac80211. Except for the debugfs, which is
intended for testing purposes. Currently we don't allow entering EMLSR
from debugfs if EMLSR is blocked, i.e. if mvmvif::esr_disable_reason is
not 0. But we need a way to activate EMLSR regardless of the vif being
blocked, for testing. Remove the check of esr_disable_reason

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c       |  6 +++---
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c   | 13 ++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |  3 +--
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 32ae606a0aa7..1ce52adf3173 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -703,9 +703,9 @@ void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	primary_link = best_link->link_id;
 	new_active_links = BIT(best_link->link_id);
 
-	/* eSR is not supported/allowed, or only one usable link */
-	if (max_active_links == 1 || !iwl_mvm_esr_allowed_on_vif(mvm, vif) ||
-	    n_data == 1)
+	/* eSR is not supported/blocked, or only one usable link */
+	if (max_active_links == 1 || !iwl_mvm_vif_has_esr_cap(mvm, vif) ||
+	    mvmvif->esr_disable_reason || n_data == 1)
 		goto set_active;
 
 	for (u8 a = 0; a < n_data; a++)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index e16f1eee8473..5609b0321647 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1159,10 +1159,8 @@ iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
 	return ret;
 }
 
-bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
-				struct ieee80211_vif *vif)
+bool iwl_mvm_vif_has_esr_cap(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	const struct wiphy_iftype_ext_capab *ext_capa;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -1176,11 +1174,8 @@ bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
 
 	ext_capa = cfg80211_get_iftype_ext_capa(mvm->hw->wiphy,
 						ieee80211_vif_type_p2p(vif));
-	if (!ext_capa ||
-	    !(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP))
-		return false;
-
-	return !mvmvif->esr_disable_reason;
+	return (ext_capa &&
+		(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP));
 }
 
 static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
@@ -1204,7 +1199,7 @@ static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
 
 	/* If it is an eSR device, check that we can enter eSR */
 	ret = iwl_mvm_is_esr_supported(mvm->fwrt.trans) &&
-	      iwl_mvm_esr_allowed_on_vif(mvm, vif);
+	      iwl_mvm_vif_has_esr_cap(mvm, vif);
 
 unlock:
 	mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index fc167ed4578c..c0e0600c4d99 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2873,8 +2873,7 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 			int duration, u32 activity);
 
 /* EMLSR */
-bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
-				struct ieee80211_vif *vif);
+bool iwl_mvm_vif_has_esr_cap(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       enum iwl_mvm_esr_state reason,
 		       u8 link_to_keep);
-- 
2.34.1



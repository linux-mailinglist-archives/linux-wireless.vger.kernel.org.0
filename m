Return-Path: <linux-wireless+bounces-22781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8CAB110E
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5AE3A7B33
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5C57E1;
	Fri,  9 May 2025 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0b7hEGp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9628F531
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787526; cv=none; b=klolpZQ2Y7+L+oyz3O3ggggE4yvtGNyRAshorJCKgA5nrq0DjlRG0WuzW7GnBiyAdZi28WSICgWivunsUKcCC2MOFpBpnmcQb1M7uji5BrQN6AbhZWRni6cSkzuN7ps3ptJy8JtTj5opw3uyRxn9hFuHjqd0JpeLCesXqh9yIVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787526; c=relaxed/simple;
	bh=UgQjxSH07jenVSkyjRx92Ned9o4lLLIYH92oSPE/CJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ge4p6i+iTtT7V07xjEq/fAbeUeqxfX8mYXCucZ1gIa7q12kHkSIkHMgzbSxF5lKw5ELyN0Ccy/597hcbr5iPg/LF0cI03CGZV29ZYtcKI+rjZ64JFBQoMBC4F9gO7cYftzT85C9hBawPRf06TRudCB/4XMUmVujhnX21lAtrJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0b7hEGp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787525; x=1778323525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UgQjxSH07jenVSkyjRx92Ned9o4lLLIYH92oSPE/CJU=;
  b=h0b7hEGpjQ2O7sIFHHrAtp/ASIJJH72LMrTZuPa+9SzKZdzOOsRN+FsX
   fNVn7RqTi3E+SWzMF4XIcwaf7M7AiPm7bk7LDCQZ0viMxYILNdVbX0KKf
   bXTuuLhnd32caEpFEoh5dfTTBuT6mrJ6ouYc9rSrKNefYXk7GnPd7+eiT
   PV8AZWBPGmRhQw5Z2Sk1vxVWgooFdSkUgUPaEFdLO/rJCQrTIKszfQqus
   ojlJknIxsDgNgo5VNiUbhkxUrCU60vDBItgPklX1DsEjUXWQWbyyHqcnY
   /sQCdCdvjQ7i5xIjHZbhJGksmGqdxWCeeywIZHSxB5d/SrwitXeUrCDJO
   g==;
X-CSE-ConnectionGUID: 2EhByloMQv+yDQF9402f1w==
X-CSE-MsgGUID: v3rsrIE7QpWGv0Up2EJdpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239906"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239906"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:24 -0700
X-CSE-ConnectionGUID: +WpQTQ2FRvK5lYivi3Z3CQ==
X-CSE-MsgGUID: ryN/vxLtSOunw6ojmV9nLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537051"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: Block EMLSR only when ready to enter ROC
Date: Fri,  9 May 2025 13:44:51 +0300
Message-Id: <20250509104454.2582160-13-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
References: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

If one of the stages in starting a ROC failed,
the ROC will not start nor end so EMLSR will stay blocked forever.

Block EMLSR once all ROC conditions are validated and
clear EMLSR blocked reasons in mld_vif cleanup.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Message-Id: <20250509134302.ab16882dc986.Ibbff57d2e2638a1742b64b1afd1a2a5483753525@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c |  2 ++
 drivers/net/wireless/intel/iwlwifi/mld/roc.c   | 14 +++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 3aacca5ed6a3..235b55e0fe59 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -22,6 +22,8 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 	struct iwl_mld *mld = mld_vif->mld;
 	struct iwl_mld_link *link;
 
+	mld_vif->emlsr.blocked_reasons &= ~IWL_MLD_EMLSR_BLOCKED_ROC;
+
 	if (mld_vif->aux_sta.sta_id != IWL_INVALID_STA)
 		iwl_mld_free_internal_sta(mld, &mld_vif->aux_sta);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/roc.c b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
index ac52cc06e4d6..cfd010c1ca80 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/roc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
@@ -49,13 +49,6 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	ieee80211_iterate_active_interfaces_mtx(mld->hw,
-						IEEE80211_IFACE_ITER_NORMAL,
-						iwl_mld_vif_iter_emlsr_block_roc,
-						&ret);
-	if (ret)
-		return ret;
-
 	/* TODO: task=Hotspot 2.0 */
 	if (vif->type != NL80211_IFTYPE_P2P_DEVICE) {
 		IWL_ERR(mld, "NOT SUPPORTED: ROC on vif->type %d\n",
@@ -79,6 +72,13 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (WARN_ON(mld_vif->roc_activity != ROC_NUM_ACTIVITIES))
 		return -EBUSY;
 
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_vif_iter_emlsr_block_roc,
+						&ret);
+	if (ret)
+		return ret;
+
 	ret = iwl_mld_add_aux_sta(mld, aux_sta);
 	if (ret)
 		return ret;
-- 
2.34.1



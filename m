Return-Path: <linux-wireless+bounces-14593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD139B2F60
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDBECB21C78
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE3A1D8E10;
	Mon, 28 Oct 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hENwQebe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E98B1D6DC5
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116526; cv=none; b=sCnzC5JTjIz4ggsYc0XIntjl47qgqsn3ZEh2jQTpRwIdZkAZttS3/c5JU2Gc+pI0Ta/j0FDmNV8f4Y5RaDH/7yOP/lNpDUuEAHH7JgGk3qt6J6Yo+QOYgbc3ZPyoP1pkbft4BINv2Fx7Ba7g6YF/4gIpgN/GrvYabf82mPQ0S7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116526; c=relaxed/simple;
	bh=pFx8m+Fpo7ze7VpJazsJ52EHFo0smeAg9h6H6h1R3gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCyK//mBEt0HNFpUqAYEBvPnPe1bXVaE4PH5qmuAhvyBvVjs7PDcWHa67FkidL6bVlQmoneNPBf1BZX8UzAVFPIlgM5eouAv1I87inC03Ep2YUPy2PIS3dMnk0g3NCSXyhhWRrLMG++xB8d+tzGmCCmF/DTHPa48FlCrYhA5sLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hENwQebe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116525; x=1761652525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pFx8m+Fpo7ze7VpJazsJ52EHFo0smeAg9h6H6h1R3gw=;
  b=hENwQebeHjEZ2wLtdHNgqZlNNdZbdZGkVQE73DCISXWZhatxDV//+Jae
   g+UJKqlyWlVUlwcSqDH3y0uau1X06Tp4wdDi1ByQFRhCVx4CjgCrhJdjV
   9yQ6cdAKDEfnGEEmBwixauSEyBl+ApIVbquDvrX1ym7AePeOCgXEAJUyE
   crFCfJKMhZdsZBwzCPti4fTWEJygxBb0LMuimHoMT4Vd2rD6xa5xW7CdU
   yJhVDbt52ZGSyU++xgPiojq/Xbj4/2gaW744OHZxVUbcGxqBBW3AogaxB
   dnUcfOAPbDQwveTIKufqyy7urP6inPfZA9B6mYGfCKmC3V4Wizlh9b4PF
   Q==;
X-CSE-ConnectionGUID: TMnjMKRST4qXy7vUhz2b4g==
X-CSE-MsgGUID: SVt1fFKhQXGKEo9lwwafsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813890"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813890"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:24 -0700
X-CSE-ConnectionGUID: dkaWzZ4rQEqdOWv2yqWHJQ==
X-CSE-MsgGUID: V2RQ3ZBvTgmFw5J3yAvuww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432584"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: MLO scan upon channel condition degradation
Date: Mon, 28 Oct 2024 13:54:50 +0200
Message-Id: <20241028135215.6402718fbc94.Ia6ce651cc7c96f7aaeee449737dd28ed291788a6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will allow to prevent disconnections.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        | 10 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  3 ++-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 795a166ed63a..776600ddaea6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -19,6 +19,7 @@
 #define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS	5
 #define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH	15
 #define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED	11
+#define IWL_MVM_LOW_RSSI_MLO_SCAN_THRESH	-72
 
 #define IWL_MVM_DEFAULT_PS_TX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
 #define IWL_MVM_DEFAULT_PS_RX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index c8bc26380b4a..2a13d70da46c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1691,6 +1691,9 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 			ieee80211_beacon_loss(vif);
 		else
 			ieee80211_cqm_beacon_loss_notify(vif, GFP_ATOMIC);
+
+		/* try to switch links, no-op if we don't have MLO */
+		iwl_mvm_int_mlo_scan(mvm, vif);
 	}
 
 	iwl_dbg_tlv_time_point(&mvm->fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 1a0b5f8d4339..9e72db9bab40 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -560,7 +560,8 @@ static void iwl_mvm_update_link_sig(struct ieee80211_vif *vif, int sig,
 				    struct iwl_mvm_vif_link_info *link_info,
 				    struct ieee80211_bss_conf *bss_conf)
 {
-	struct iwl_mvm *mvm = iwl_mvm_vif_from_mac80211(vif)->mvm;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
 	int thold = bss_conf->cqm_rssi_thold;
 	int hyst = bss_conf->cqm_rssi_hyst;
 	int last_event;
@@ -625,6 +626,13 @@ static void iwl_mvm_update_link_sig(struct ieee80211_vif *vif, int sig,
 	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
 		return;
 
+	/* We're not in EMLSR and our signal is bad, try to switch link maybe */
+	if (sig < IWL_MVM_LOW_RSSI_MLO_SCAN_THRESH && !mvmvif->esr_active) {
+		iwl_mvm_int_mlo_scan(mvm, vif);
+		return;
+	}
+
+	/* We are in EMLSR, check if we need to exit */
 	exit_esr_thresh =
 		iwl_mvm_get_esr_rssi_thresh(mvm,
 					    &bss_conf->chanreq.oper,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 3ce9150213a7..6fb241d0c5f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3597,7 +3597,8 @@ static int iwl_mvm_int_mlo_scan_start(struct iwl_mvm *mvm,
 	IWL_DEBUG_SCAN(mvm, "Starting Internal MLO scan: n_channels=%zu\n",
 		       n_channels);
 
-	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
+	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif) ||
+	    hweight16(vif->valid_links) == 1)
 		return -EINVAL;
 
 	size = struct_size(req, channels, n_channels);
-- 
2.34.1



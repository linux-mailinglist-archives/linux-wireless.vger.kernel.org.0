Return-Path: <linux-wireless+bounces-21896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEADBA97F0E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51381897F00
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4D1266EE0;
	Wed, 23 Apr 2025 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIpL3tzv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C21F4CAB
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389037; cv=none; b=LFiwNnmgxqLBcWOxPVEKchNJaJ6QPk14ofTE6bztKajIl9BRkom3KffHAQFBq2uWP1UvRx7YW7IbFr51U6aE7qdS3LKqJIGSS+Hn86haHRxoB7EwAbMXDrbB0B1j6iN7jMF8ivu2zyi4tVpQNxvw5WSEtw+cUkB94V0BCSlTrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389037; c=relaxed/simple;
	bh=0UaAhWKXTpLAI0s1PCxxttiASBp3yhdtleOrcP3Sizc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZg4YQi+AblO6fS5b/NZCXs+OTBAi+DFF60L7MfDAorZV8if2u2dm3LiSPnEk5NDcJxdb9pz/hs/kVTJTxWpeMfPzDoLULzKwl3KADMO6bsjWy1MiLBG4A283MdvK/7JH8BOMNnIB8v0zGWnzypkFRSXoFGSITJkUezeq5Aq10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIpL3tzv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389035; x=1776925035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0UaAhWKXTpLAI0s1PCxxttiASBp3yhdtleOrcP3Sizc=;
  b=HIpL3tzvAPsReT6Qh0f86i7XOda+8eAryMSq+vInnOvBWNMdCI6NI3Il
   DxemIIjL478MNGFwHQKAd2FuLP6iloYM0b6Da+MReibdv7+WizFvjEljT
   txqcHY1y0XccyPH+YY5NzD1sH17yc4OoGEzUpZTePIuCpxGN2vw25Wkli
   2lREHgYBHB4urkIaJnzD63/pFI5iAoZf0RCSDnY3m0KpvZlSzgTqD8Olf
   Lm2OO1vT+jf7KWXWjyM+UEZlcFLA2fcMmZgEQnN/HiS46PrUsTJtxWTNi
   miffp/QWyxJ7dd5f4DodiJgdb6yxSFjQr6OHSJAx6MV7Kxctdn2Tx1UGV
   w==;
X-CSE-ConnectionGUID: 9GCnx9xPRGuNPIMti1QDOQ==
X-CSE-MsgGUID: BxS6E3e2QYOECHoz9C4sfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843669"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843669"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:15 -0700
X-CSE-ConnectionGUID: mvtkPlozRnmyEVzdYsoeRA==
X-CSE-MsgGUID: h30LkdqLQZ6XyMIreuN8BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269101"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 15/15] wifi: iwlwifi: set step_urm in transport and not in the opmodes
Date: Wed, 23 Apr 2025 09:16:41 +0300
Message-Id: <20250423091408.4e288f7897be.I0c8f792ea2ed6967f8c6d8181f9c5f74bbec7d18@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This has nothing to do with the opmode. Set it in the transport layer
instead.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Tested-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c          | 4 ----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c          | 5 -----
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 5 +++++
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 14aacfbab5c8..6e9af37fb86d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -266,10 +266,6 @@ static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
 	if (ret)
 		return ret;
 
-	mld->trans->step_urm =
-		!!(iwl_read_umac_prph(mld->trans, CNVI_PMU_STEP_FLOW) &
-		   CNVI_PMU_STEP_FLOW_FORCE_URM);
-
 	ret = iwl_pnvm_load(mld->trans, &mld->notif_wait,
 			    &mld->fw->ucode_capa);
 	if (ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 2b5a62604fc4..f67348acd5f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -651,11 +651,6 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
 			       NULL);
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
-		mvm->trans->step_urm = !!(iwl_read_umac_prph(mvm->trans,
-							     CNVI_PMU_STEP_FLOW) &
-						CNVI_PMU_STEP_FLOW_FORCE_URM);
-
 	/* Send init config command to mark that we are sending NVM access
 	 * commands
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 3ece34e30d58..bfa050d987db 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -373,6 +373,11 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans)
 
 	iwl_pcie_get_rf_name(trans);
 	mutex_unlock(&trans_pcie->mutex);
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		trans->step_urm = !!(iwl_read_umac_prph(trans,
+							CNVI_PMU_STEP_FLOW) &
+					CNVI_PMU_STEP_FLOW_FORCE_URM);
 }
 
 static bool iwl_pcie_set_ltr(struct iwl_trans *trans)
-- 
2.34.1



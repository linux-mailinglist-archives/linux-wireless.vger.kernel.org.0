Return-Path: <linux-wireless+bounces-3352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAFB84E5C2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920B328B11E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DDA7D3F0;
	Thu,  8 Feb 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+JfDqDF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C28823C7
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411552; cv=none; b=NOy7vkFIakuvv/0uhtECbTdc3jH8d96okF0dmoUMV4SXengmy7u+FCPraD82jM0c1tP0X3RK+qYQRHPO4SptMQS1u++wKIyiHUp58zXfdVwr1tr95wvFnouaEkscTcCv3NHydIG3ITCWPy46z785/GQYqgI+Gt141kSYZfLmoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411552; c=relaxed/simple;
	bh=2iSmWEvfk0E4gHhFGkBZWUsisKWxjC4N6ViWGasxCU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZmhYr/Pci3u+bAhPpBHbpWVL9OSDwIZarBbCgB+ghZ7QZ2bL4IyhAeFA69CwEkXsEsGq+0pyJzKsSzCy9mPRi2q3VlIIffDw1QzJhQuujfXcNLfzvgfxUTm/YC8Jb0MW+LHkpcVzhsJh6OJOUiueSPiEc2bK42AjbP+D1mXoNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+JfDqDF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411551; x=1738947551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2iSmWEvfk0E4gHhFGkBZWUsisKWxjC4N6ViWGasxCU4=;
  b=m+JfDqDF5U8m+zdsrhczg/fTlH7Bfp++uPqf7ptSwnubQACEkZ3GlEN6
   lvHWiJ6CupBTCPjDl8MgpMDGSPT9wWG0h4rJ1l7SnKwjGyr5mSqi7JcdJ
   TcMiGDfZMp2Yerzu8Up2/4Pol7DtBvD27pNqBYQ9vxmXruEbM6dzHdq2t
   6TiTrJ5TP/Rd2z/Jl/Wnf8fUczYEdhIK7zqURXGcyUaJWroXklBiBtwlf
   JAxtxALstCGDqLabNOlZTatKe8YurJ2ztupq3O/T8poiBDXt4oTMVf6ui
   YAsYzbmSvn8iEd0I/qBzw9UyQBwzMsUm5b0rVLdJOp1ZJxytuwGD8FWAP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1403988"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1403988"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318850"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/13] wifi: iwlwifi: don't use TRUE/FALSE with bool
Date: Thu,  8 Feb 2024 18:58:40 +0200
Message-Id: <20240208185302.5732dd306ee9.Ifc07c026ac3779429e3dc949e96c9437e89f7bf9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
References: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With C99 bool we really also should use true/false, not the
upper-case variants, wherever they may actually be coming
from. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c      |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c      |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c     |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 6cfcf1c14eaf..561d0c261123 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1245,7 +1245,7 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 			}
 		}
 
-		fwrt->trans->dbg.restart_required = FALSE;
+		fwrt->trans->dbg.restart_required = false;
 		IWL_DEBUG_FW(fwrt, "WRT: tp %d, reset_fw %d\n",
 			     tp, dump_data.trig->reset_fw);
 		IWL_DEBUG_FW(fwrt,
@@ -1255,22 +1255,22 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 
 		if (fwrt->trans->trans_cfg->device_family ==
 		    IWL_DEVICE_FAMILY_9000) {
-			fwrt->trans->dbg.restart_required = TRUE;
+			fwrt->trans->dbg.restart_required = true;
 		} else if (tp == IWL_FW_INI_TIME_POINT_FW_ASSERT &&
 			   fwrt->trans->dbg.last_tp_resetfw ==
 			   IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY) {
-			fwrt->trans->dbg.restart_required = FALSE;
+			fwrt->trans->dbg.restart_required = false;
 			fwrt->trans->dbg.last_tp_resetfw = 0xFF;
 			IWL_DEBUG_FW(fwrt, "WRT: FW_ASSERT due to reset_fw_mode-no restart\n");
 		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
 			   IWL_FW_INI_RESET_FW_MODE_STOP_AND_RELOAD_FW) {
 			IWL_DEBUG_FW(fwrt, "WRT: stop and reload firmware\n");
-			fwrt->trans->dbg.restart_required = TRUE;
+			fwrt->trans->dbg.restart_required = true;
 		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
 			   IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY) {
 			IWL_DEBUG_FW(fwrt,
 				     "WRT: stop only and no reload firmware\n");
-			fwrt->trans->dbg.restart_required = FALSE;
+			fwrt->trans->dbg.restart_required = false;
 			fwrt->trans->dbg.last_tp_resetfw =
 				le32_to_cpu(dump_data.trig->reset_fw);
 		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 26c01d740d0d..b6a9896bce25 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2997,7 +2997,7 @@ static void iwl_mvm_nd_match_info_handler(struct iwl_mvm *mvm,
 
 	if (results->matched_profiles) {
 		memcpy(results->matches, notif->matches, matches_len);
-		d3_data->nd_results_valid = TRUE;
+		d3_data->nd_results_valid = true;
 	}
 
 	/* no scan should be active at this point */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5381afdd4021..e1c2b7fc92ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1323,7 +1323,7 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 
 	if (le32_to_cpu(cmd.oem_uhb_allow_bitmap) & IWL_UATS_VLP_AP_SUPPORTED ||
 	    le32_to_cpu(cmd.oem_uhb_allow_bitmap) & IWL_UATS_AFC_AP_SUPPORTED)
-		mvm->fwrt.uats_enabled = TRUE;
+		mvm->fwrt.uats_enabled = true;
 }
 
 void iwl_mvm_get_bios_tables(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index ac46be4d5971..a84a65e22782 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1993,7 +1993,7 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 			ieee80211_restart_hw(mvm->hw);
 		} else if (mvm->fwrt.trans->dbg.restart_required) {
 			IWL_DEBUG_INFO(mvm, "FW restart requested after debug collection\n");
-			mvm->fwrt.trans->dbg.restart_required = FALSE;
+			mvm->fwrt.trans->dbg.restart_required = false;
 			ieee80211_restart_hw(mvm->hw);
 		} else if (mvm->trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_8000) {
 			ieee80211_restart_hw(mvm->hw);
-- 
2.34.1



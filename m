Return-Path: <linux-wireless+bounces-21875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D888EA97E58
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9715E3B9F37
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3421626738C;
	Wed, 23 Apr 2025 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7s69+pq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F626462C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387473; cv=none; b=KAUNQTQla+7RxwEOFm9J2vYaLR1/5EsTW+/PR3JsWsFGxHEnMILiTse8X8kMBUrDk9oE43mVigU5JQ6Oi9Rh8tZ7Mj+4OboK2zdglTsJb0BUgUWDbAhxuMn0puYFfg3fJYi5DUnrdmoEh1olj25RjCaFaUa8B0EhSh9aWy0JWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387473; c=relaxed/simple;
	bh=0UaAhWKXTpLAI0s1PCxxttiASBp3yhdtleOrcP3Sizc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=grlk0jV08DlebyftDR8ZPvy++f4Z5TlMxGLzk9K8nC5No1ag2me6u7w7cD2+RgOvtbYcTRCOVC1TWX9g6Ct2DXCKpuBFIWQ30mkIGp8Rtfdjkne161w9dmxImRVRlT07EWISMFOFRyKnDpr8wqsrjlsV+78QVPsBVHXD0FUiEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7s69+pq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387471; x=1776923471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0UaAhWKXTpLAI0s1PCxxttiASBp3yhdtleOrcP3Sizc=;
  b=m7s69+pq9BkcgqeKvDElLHHShExcd/PMzRfyoBa5b+KcMeq6WVplwggm
   Z7H7u2PKv+nfyKI6gxmHYF3b+eNP6NFPx0GjzMYerHIb3RR6zwU6QkY9j
   k3ZiwQNjdXGuz76Fs24+xr/f0n0Vd6PV6Plts55OAPdAZXrZW9c0GCQoC
   WRwCfRAs3ntkKdocrtpcI/sYIvalOsI0mXKlnOALvE4f6PpPEUNX4KKbl
   KQtide9tkxnYElRIlPtumBRNHGDVUThBG/fXxsNvm3rBVHlrOaeWL+f5p
   sC5kVBYjVJqkonxRKdh/Kytl3L882rZKUw7pCorwpnNREZqAzzXtxzAfJ
   g==;
X-CSE-ConnectionGUID: X2ls3P8BQwaISijEJATe6Q==
X-CSE-MsgGUID: roD14d6kRq+Z7FKShyOrTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844653"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844653"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:11 -0700
X-CSE-ConnectionGUID: KU94mDYYRQ+77xqnNlg0Cw==
X-CSE-MsgGUID: yAmjKLk6Rke+206QTFsL7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164370"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless 15/17] wifi: iwlwifi: set step_urm in transport and not in the opmodes
Date: Wed, 23 Apr 2025 08:50:34 +0300
Message-Id: <20250423084826.4e288f7897be.I0c8f792ea2ed6967f8c6d8181f9c5f74bbec7d18@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
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



Return-Path: <linux-wireless+bounces-25022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58396AFDE7D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CEC1172819
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9422154B;
	Wed,  9 Jul 2025 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2TiCWHr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902421B9D2
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032643; cv=none; b=HqqZzBO7ahpc4bIqPdz0S7eK5PpPocCjPBD250OHXwqAQD0NlHuyACJNKj08QJRF5cYUfYw9/x510Kc8dwozBzP5mfkZzF8ao8NolxvWw3yLZkFUzd929KBvARYJFiGVLfvmc+atxY01jS4l32PBJ5FpT4BnKwwRkmntKzlwaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032643; c=relaxed/simple;
	bh=ruYsP+B0mMat/lJaXXLUtil+Wg04PgrMgYxAWBuyIP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvyQ78nWwt+lmcgpcZ5Te6ZAlqpu8irAQ8YHpcEhuWdE5tlnPrUjj2KPTznabsFJbHX0ILJvo2MR+FgHCQCH2Kz+86IlWLNHMQFctRDgMKmIO8cx6kWXg9cGb5S23RXq59vFe86iY7rsS2ntjtHXyHGUyjIxvo5GMKnVOR3Yn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2TiCWHr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032641; x=1783568641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ruYsP+B0mMat/lJaXXLUtil+Wg04PgrMgYxAWBuyIP0=;
  b=Q2TiCWHrsT/L3Dd5QrqjtEwkaaXpAYMNq6Iy/AWrjaEKIN4k4e0avRth
   W5d+6wnbffndiOLqjrUJmhGD70IBLWqozomUWpNhtR3CIJ67t3vJ2qNG5
   Pl+ngF6O9ahqjvdvOjZEYnQWnrBPVNkYFK/MKlPkyL6QjRW8adt7zl5lN
   +atBJaCoPbu+LcogLaOyccwhxkUxpOpuEbuKtqWI0KZEojoz7SGTIS3CD
   QkC9nRZ86m3G039ibGTxUsaknELaF+CXXwiqLeEGtwutlDna4FQF2FPk+
   6O8qB2AZWVM33WHLl2cs1H1Fl6pD3Dt9Hm7tQLNhCfKMahAW7ntgfgJR0
   Q==;
X-CSE-ConnectionGUID: +X0P/JZhSOecaqYU1aM62Q==
X-CSE-MsgGUID: MZG7BqhORuK4xqYwpf/u8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720620"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720620"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:01 -0700
X-CSE-ConnectionGUID: /eTnFGPbQTen5RZbuRhllg==
X-CSE-MsgGUID: w6A8NvcHQH2uvF245GA1yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390539"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next v2 02/15] wifi: iwlwifi: use PNVM data embedded in .ucode files
Date: Wed,  9 Jul 2025 06:43:26 +0300
Message-Id: <20250709063858.c843f77aa2d3.I7200f8dd40ef82aff1f5574fdd3966913cda592c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
References: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Given compatibility issues with external PNVM data that doesn't match
the firmware it was designed with/for, future firmware releases will
include the PNVM data in the firmware files directly, avoiding those
mismatch issues. Make the driver load and use that embedded PNVM data
in preference of external files, falling back to the external file if
it isn't present.

Co-developed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h |  3 ++
 drivers/net/wireless/intel/iwlwifi/fw/img.h  |  5 +++
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 32 ++++++++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h |  4 +--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 12 ++++++++
 drivers/net/wireless/intel/iwlwifi/mld/fw.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |  2 +-
 7 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 5a1ec880ed72..dc1db563c5eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -104,6 +104,9 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_CURRENT_PC		= 68,
 	IWL_UCODE_TLV_FSEQ_BIN_VERSION		= 72,
 
+	/* contains sub-sections like PNVM file does (did) */
+	IWL_UCODE_TLV_PNVM_DATA			= 74,
+
 	IWL_UCODE_TLV_FW_NUM_STATIONS		= IWL_UCODE_TLV_CONST_BASE + 0,
 	IWL_UCODE_TLV_FW_NUM_LINKS		= IWL_UCODE_TLV_CONST_BASE + 1,
 	IWL_UCODE_TLV_FW_NUM_BEACONS		= IWL_UCODE_TLV_CONST_BASE + 2,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index e055f798a398..5256f20623e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -195,6 +195,8 @@ struct iwl_dump_exclude {
  * @phy_integration_ver_len: length of @phy_integration_ver
  * @dump_excl: image dump exclusion areas for RT image
  * @dump_excl_wowlan: image dump exclusion areas for WoWLAN image
+ * @pnvm_data: PNVM data embedded in the .ucode file, if any
+ * @pnvm_size: size of the embedded PNVM data
  */
 struct iwl_fw {
 	u32 ucode_ver;
@@ -227,6 +229,9 @@ struct iwl_fw {
 	u32 phy_integration_ver_len;
 
 	struct iwl_dump_exclude dump_excl[2], dump_excl_wowlan[2];
+
+	const void *pnvm_data;
+	u32 pnvm_size;
 };
 
 static inline const char *get_fw_dbg_mode_string(int mode)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 3bcd375995cc..4d91ae065c8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -11,6 +11,7 @@
 #include "fw/api/nvm-reg.h"
 #include "fw/api/alive.h"
 #include "fw/uefi.h"
+#include "fw/img.h"
 
 #define IWL_PNVM_REDUCED_CAP_BIT BIT(25)
 
@@ -264,8 +265,8 @@ static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
 	return 0;
 }
 
-static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len,
-			      __le32 sku_id[3])
+static const u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len,
+				    __le32 sku_id[3], const struct iwl_fw *fw)
 {
 	struct pnvm_sku_package *package;
 	u8 *image = NULL;
@@ -290,6 +291,12 @@ static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len,
 		}
 	}
 
+	if (fw->pnvm_data) {
+		*len = fw->pnvm_size;
+
+		return fw->pnvm_data;
+	}
+
 	/* If it's not available, or for Intel SKU, try from the filesystem */
 	if (iwl_pnvm_get_from_fs(trans_p, &image, len))
 		return NULL;
@@ -298,11 +305,11 @@ static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len,
 
 static void
 iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
-			    const struct iwl_ucode_capabilities *capa,
+			    const struct iwl_fw *fw,
 			    __le32 sku_id[3])
 {
 	struct iwl_pnvm_image *pnvm_data = NULL;
-	u8 *data = NULL;
+	const u8 *data = NULL;
 	size_t length;
 	int ret;
 
@@ -313,7 +320,7 @@ iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
 	if (trans->pnvm_loaded)
 		goto set;
 
-	data = iwl_get_pnvm_image(trans, &length, sku_id);
+	data = iwl_get_pnvm_image(trans, &length, sku_id, fw);
 	if (!data) {
 		trans->fail_to_parse_pnvm_image = true;
 		return;
@@ -329,15 +336,17 @@ iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
 		goto free;
 	}
 
-	ret = iwl_trans_load_pnvm(trans, pnvm_data, capa);
+	ret = iwl_trans_load_pnvm(trans, pnvm_data, &fw->ucode_capa);
 	if (ret)
 		goto free;
 	IWL_DEBUG_INFO(trans, "loaded PNVM version %08x\n", pnvm_data->version);
 
 set:
-	iwl_trans_set_pnvm(trans, capa);
+	iwl_trans_set_pnvm(trans, &fw->ucode_capa);
 free:
-	kvfree(data);
+	/* free only if it was allocated, i.e. not just embedded PNVM data */
+	if (data != fw->pnvm_data)
+		kvfree(data);
 	kfree(pnvm_data);
 }
 
@@ -392,8 +401,7 @@ iwl_pnvm_load_reduce_power_to_trans(struct iwl_trans *trans,
 
 int iwl_pnvm_load(struct iwl_trans *trans,
 		  struct iwl_notif_wait_data *notif_wait,
-		  const struct iwl_ucode_capabilities *capa,
-		  __le32 sku_id[3])
+		  const struct iwl_fw *fw, __le32 sku_id[3])
 {
 	struct iwl_notification_wait pnvm_wait;
 	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
@@ -403,8 +411,8 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	if (!sku_id[0] && !sku_id[1] && !sku_id[2])
 		return 0;
 
-	iwl_pnvm_load_pnvm_to_trans(trans, capa, sku_id);
-	iwl_pnvm_load_reduce_power_to_trans(trans, capa, sku_id);
+	iwl_pnvm_load_pnvm_to_trans(trans, fw, sku_id);
+	iwl_pnvm_load_reduce_power_to_trans(trans, &fw->ucode_capa, sku_id);
 
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
 				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
index 9540926e8a0f..ad3b7e2423ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
@@ -7,6 +7,7 @@
 
 #include "iwl-drv.h"
 #include "fw/notif-wait.h"
+#include "fw/img.h"
 
 #define MVM_UCODE_PNVM_TIMEOUT	(HZ / 4)
 
@@ -14,8 +15,7 @@
 
 int iwl_pnvm_load(struct iwl_trans *trans,
 		  struct iwl_notif_wait_data *notif_wait,
-		  const struct iwl_ucode_capabilities *capa,
-		  __le32 sku_id[3]);
+		  const struct iwl_fw *fw, __le32 sku_id[3]);
 
 static inline
 void iwl_pnvm_get_fs_name(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 6492bc7d1680..064ff2135411 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -136,6 +136,9 @@ static void iwl_dealloc_ucode(struct iwl_drv *drv)
 	kfree(drv->fw.phy_integration_ver);
 	kfree(drv->trans->dbg.pc_data);
 	drv->trans->dbg.pc_data = NULL;
+	kvfree(drv->fw.pnvm_data);
+	drv->fw.pnvm_data = NULL;
+	drv->fw.pnvm_size = 0;
 
 	for (i = 0; i < IWL_UCODE_TYPE_MAX; i++)
 		iwl_free_fw_img(drv, drv->fw.img + i);
@@ -1400,6 +1403,15 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			drv->trans->dbg.num_pc =
 				tlv_len / sizeof(struct iwl_pc_data);
 			break;
+		case IWL_UCODE_TLV_PNVM_DATA:
+			if (drv->fw.pnvm_data)
+				break;
+			drv->fw.pnvm_data =
+				kvmemdup(tlv_data, tlv_len, GFP_KERNEL);
+			if (!drv->fw.pnvm_data)
+				return -ENOMEM;
+			drv->fw.pnvm_size = tlv_len;
+			break;
 		default:
 			IWL_DEBUG_INFO(drv, "unknown TLV: %d\n", tlv_type);
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 9d2c087360e7..b372173c4a79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -294,7 +294,7 @@ static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
 		return ret;
 
 	ret = iwl_pnvm_load(mld->trans, &mld->notif_wait,
-			    &mld->fw->ucode_capa, alive_data.sku_id);
+			    mld->fw, alive_data.sku_id);
 	if (ret) {
 		IWL_ERR(mld, "Timeout waiting for PNVM load %d\n", ret);
 		return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 819e3228462a..ab3d78c1e20c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -432,7 +432,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	iwl_trans_fw_alive(mvm->trans);
 
 	ret = iwl_pnvm_load(mvm->trans, &mvm->notif_wait,
-			    &mvm->fw->ucode_capa, alive_data.sku_id);
+			    mvm->fw, alive_data.sku_id);
 	if (ret) {
 		IWL_ERR(mvm, "Timeout waiting for PNVM load!\n");
 		iwl_fw_set_current_image(&mvm->fwrt, old_type);
-- 
2.34.1



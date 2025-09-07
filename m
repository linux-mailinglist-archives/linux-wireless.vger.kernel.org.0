Return-Path: <linux-wireless+bounces-27050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDE7B4799E
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F2617B7D9
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BC121CC58;
	Sun,  7 Sep 2025 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCY17dM2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9521B19D
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233857; cv=none; b=b250MrZd5ctvmijWJm8AnLJm3xf2jpas4pZzN3rYNHb4mBBtnyW4utGVQxtuzCS5ot/DZ6gtdJID7FmjEUMHToVC0gNHaBGMgBcfLyHrZaKZ2zuaj/98O3cd2Gezgb9hfgSa8xhWElyfEMJ+PezOmDbH8v5iDvwHwT3D+VRPicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233857; c=relaxed/simple;
	bh=8rXW4t9BQGhqcnPdpwoD05X8ItVcOm9AQwXYfCcanQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZYbOAbV9as78BqxlEjzz/d1zLFSwcEiYQX4WIuS7q52nxkxgm13ftTIaDi52OjrCNDsTcubvnWf1wTWgRrkuwwGOzBZh4u87tBHTeevSPR/nqkzb9Z0xiAtoXtfCNQ53aiw6HQSwofheKy5e6qGxVac1M/MZSz39WJkd34+lf38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCY17dM2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233856; x=1788769856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rXW4t9BQGhqcnPdpwoD05X8ItVcOm9AQwXYfCcanQo=;
  b=VCY17dM2G+zZy4FC7rR3wUt7BIJvaiJFGe2fIXtLCdruwH4h3tdbtQaE
   PoGmGgNw8CHPvhKu86ozVJHgpFOYPJoSDcUsJgQNsB8EGkYt9oRshDFlW
   E0OeKXCqdq05sayBgU7xi4Q5QzuMvJv9hwJ459rEHxp6SgLF8rVDfm7fU
   eq7iEE+ME2Np4eSOiMxSqe0F8BD8OEiWQflZG9zH/VqL1CzkDJvreYwJQ
   bEIT70aYDSfsY09p2II0vzEZrswM/A93O+AXwe3/0k8SGf9okzGmo6es+
   aLHVgll5BYYeV4J85rWgeDnBDOHoEU1xew9Ks6/DwiFj/ULxDzLUiEmpt
   Q==;
X-CSE-ConnectionGUID: ktth1cKZRESn5tQVijjwIw==
X-CSE-MsgGUID: Xd57Y3rmT5CCIqLVIFmAXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973607"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973607"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:56 -0700
X-CSE-ConnectionGUID: MCfQ4AdsSHuv6dbisGyMsw==
X-CSE-MsgGUID: lLFJ63doSxyGECYVlsJBwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790026"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: rename iwl_finish_nic_init
Date: Sun,  7 Sep 2025 11:30:02 +0300
Message-Id: <20250907112757.a1de688e574b.Ibd41b0c8f7fbae77026e76dbbc085df3eecec538@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The function is called so because for older devices it sets a bit called
"init_done". But for the latest devices it sets a different bit,
"mac_init". Since this name is not clear anyway, rename it such that it
indicates the logic of the newer devices.
Also add the 'trans' prefix so iw will be clear from the name that this
is a transport API.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c      |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c          |  6 +++---
 drivers/net/wireless/intel/iwlwifi/iwl-io.h          |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c        |  2 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h    |  2 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c  |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c   | 12 ++++++------
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 9f8cdb027839..d337ab543eb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -766,7 +766,7 @@ static int iwl_init_otp_access(struct iwl_trans *trans)
 {
 	int ret;
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_trans_activate_nic(trans);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index a39c038db08e..ddd714cff2f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -178,7 +178,7 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 		if (err)
 			return;
 
-		err = iwl_finish_nic_init(trans);
+		err = iwl_trans_activate_nic(trans);
 		if (err)
 			return;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index fb645dafea38..b1944584c693 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -396,11 +396,11 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 	return 0;
 }
 
-int iwl_finish_nic_init(struct iwl_trans *trans)
+int iwl_trans_activate_nic(struct iwl_trans *trans)
 {
-	return iwl_pcie_gen1_2_finish_nic_init(trans);
+	return iwl_pcie_gen1_2_activate_nic(trans);
 }
-IWL_EXPORT_SYMBOL(iwl_finish_nic_init);
+IWL_EXPORT_SYMBOL(iwl_trans_activate_nic);
 
 void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
 				  u32 sw_err_bit)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.h b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
index 731cda1a4e66..5bcec239ffc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
@@ -57,7 +57,7 @@ void iwl_set_bits_mask_prph(struct iwl_trans *trans, u32 ofs,
 void iwl_clear_bits_prph(struct iwl_trans *trans, u32 ofs, u32 mask);
 void iwl_force_nmi(struct iwl_trans *trans);
 
-int iwl_finish_nic_init(struct iwl_trans *trans);
+int iwl_trans_activate_nic(struct iwl_trans *trans);
 
 /* Error handling */
 int iwl_dump_fh(struct iwl_trans *trans, char **buf);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 5cb0b519e762..e68dce21df64 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1243,7 +1243,7 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 		 * won't really know how to recover.
 		 */
 		iwl_pcie_prepare_card_hw(trans);
-		iwl_finish_nic_init(trans);
+		iwl_trans_activate_nic(trans);
 		iwl_op_mode_device_powered_off(trans->op_mode);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 79893e2d2701..36fe5863f735 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1131,7 +1131,7 @@ int iwl_pcie_alloc_dma_ptr(struct iwl_trans *trans,
 			   struct iwl_dma_ptr *ptr, size_t size);
 void iwl_pcie_free_dma_ptr(struct iwl_trans *trans, struct iwl_dma_ptr *ptr);
 void iwl_pcie_apply_destination(struct iwl_trans *trans);
-int iwl_pcie_gen1_2_finish_nic_init(struct iwl_trans *trans);
+int iwl_pcie_gen1_2_activate_nic(struct iwl_trans *trans);
 
 /* transport gen 2 exported functions */
 int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index 1951be3a30b7..b15c5d486527 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -47,7 +47,7 @@ int iwl_pcie_gen2_apm_init(struct iwl_trans *trans)
 
 	iwl_pcie_apm_config(trans);
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_trans_activate_nic(trans);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index f281d91475b4..922397408138 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -267,7 +267,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	if (trans->mac_cfg->base->pll_cfg)
 		iwl_set_bit(trans, CSR_ANA_PLL_CFG, CSR50_ANA_PLL_CFG_VAL);
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_trans_activate_nic(trans);
 	if (ret)
 		return ret;
 
@@ -340,7 +340,7 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 	ret = iwl_trans_pcie_sw_reset(trans, true);
 
 	if (!ret)
-		ret = iwl_finish_nic_init(trans);
+		ret = iwl_trans_activate_nic(trans);
 
 	if (WARN_ON(ret)) {
 		/* Release XTAL ON request */
@@ -1542,7 +1542,7 @@ int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_trans_activate_nic(trans);
 	if (ret) {
 		IWL_ERR(trans, "Failed to init nic upon resume. err = %d\n",
 			ret);
@@ -1766,7 +1766,7 @@ static int iwl_pcie_gen2_force_power_gating(struct iwl_trans *trans)
 {
 	int ret;
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_trans_activate_nic(trans);
 	if (ret < 0)
 		return ret;
 
@@ -4188,7 +4188,7 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 	 */
 	ret = iwl_pcie_prepare_card_hw(iwl_trans);
 	if (!ret) {
-		ret = iwl_finish_nic_init(iwl_trans);
+		ret = iwl_trans_activate_nic(iwl_trans);
 		if (ret)
 			goto out_free_trans;
 		if (iwl_trans_grab_nic_access(iwl_trans)) {
@@ -4308,7 +4308,7 @@ void iwl_pcie_gen1_2_remove(struct iwl_trans *trans)
 	iwl_trans_pcie_free(trans);
 }
 
-int iwl_pcie_gen1_2_finish_nic_init(struct iwl_trans *trans)
+int iwl_pcie_gen1_2_activate_nic(struct iwl_trans *trans)
 {
 	const struct iwl_mac_cfg *mac_cfg = trans->mac_cfg;
 	u32 poll_ready;
-- 
2.34.1



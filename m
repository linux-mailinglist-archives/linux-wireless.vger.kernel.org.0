Return-Path: <linux-wireless+bounces-24981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80FAFD798
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846593A1CC4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD0A23D28E;
	Tue,  8 Jul 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXjOn8ou"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988E239E9B
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004283; cv=none; b=qZLXN3p9LI0AdC0VHrFU3+42qr31cE4+vKCfhQc/XbZxKbYz0vg1DLw0A1HuDnNKc/G0TN0SwR2ibMOp4SaIKyiL0m6sDKNCnuDlyYqyPUeQtPyhWmSXvWbDaLXL5jZ3WFaK9xacUV9cGJpzmX5wsBWeHGTr957LUzf/nBQ93FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004283; c=relaxed/simple;
	bh=oo4YrUZ583VCMySEZKFFMfq5tordFBLvr4x35w/5hfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMPVFyRcL0yXGSrewDr0pYhiWhTkoqIfynGSIlhunte0EFNIIq1Pe/J7yIemEZS6cXXdA4MqMavmudKG1N7zkzGP24PPwGgfAyJVTqfDULvqaP4ozkRmxfMasQ+oL806asmF46q6U9md3XZO62AEiOMxNs6XKjLq0y35Q2occrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXjOn8ou; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004281; x=1783540281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oo4YrUZ583VCMySEZKFFMfq5tordFBLvr4x35w/5hfg=;
  b=fXjOn8ouspGPc3ufPIu1V6a5Z+WafgNr56Io9zlCg41VOB8kfuZtkcsy
   NvBn+g4rUzFhhW3I8lLurU+9SMJANLNd4nVPuQt72LWkEZs2A+TWHkInN
   wkkzPrVRHrr2xfJYwV5gyHHpx8WES/tOgAdq6ry2/YU6230XnBT7Q3afx
   PAZZ+3QPTUpt3JfXKrKSgNlPDYoT4OUP1r+xsMgNcJxyq/pJw5Z19WObA
   /DZCjoF3pHaswtN/OyrGDFWv+UdtdVOpPIIYViRQtsdGQ0fL2P2eQRQOM
   S2GP+xM7Elr2n/cnF7D/NheydDr5YdpEML5gPCSBxPafCQTfZmlDA/fvb
   A==;
X-CSE-ConnectionGUID: psFmgDV/T1qbXp0Y/OMu+g==
X-CSE-MsgGUID: UmglKXCvQuGnVAqms7GgyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54229709"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54229709"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:19 -0700
X-CSE-ConnectionGUID: Z+mji9roSiConz2KEgPx2A==
X-CSE-MsgGUID: IAfGXE09THO1WEOK7qKwDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155668923"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: pcie move gen1_2 probe to gen1_2/trans.c
Date: Tue,  8 Jul 2025 22:50:41 +0300
Message-Id: <20250708224652.d5ab06c09b69.Idaa77eddd6650cf6f113833d2fbc8d3ef08cfd8f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
References: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

In the process of splitting the transport's different generations,
move gen1_2's probe flow and relevant helper functions to the gen1_2
subfolder

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 325 +----------------
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |   7 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 330 +++++++++++++++++-
 4 files changed, 338 insertions(+), 329 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 91f22ce36d74..08c4f79f8335 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -499,11 +499,12 @@ struct iwl_dev_info {
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
 extern const struct iwl_dev_info iwl_dev_info_table[];
 extern const unsigned int iwl_dev_info_table_size;
+extern const struct pci_device_id iwl_hw_card_ids[];
+#endif
+
 const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
 		      u8 rf_id, u8 bw_limit, u8 rf_step);
-extern const struct pci_device_id iwl_hw_card_ids[];
-#endif
 
 /*
  * This list declares the config structures for all devices.
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 52a48e82f3bf..2729e0890fc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1074,147 +1074,10 @@ const unsigned int iwl_dev_info_table_size = ARRAY_SIZE(iwl_dev_info_table);
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table_size);
 #endif
 
-/*
- * Read rf id and cdb info from prph register and store it
- */
-static void get_crf_id(struct iwl_trans *iwl_trans,
-		       struct iwl_trans_info *info)
-{
-	u32 sd_reg_ver_addr;
-	u32 hw_wfpm_id;
-	u32 val = 0;
-	u8 step;
-
-	if (iwl_trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		sd_reg_ver_addr = SD_REG_VER_GEN2;
-	else
-		sd_reg_ver_addr = SD_REG_VER;
-
-	/* Enable access to peripheral registers */
-	val = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
-	val |= WFPM_AUX_CTL_AUX_IF_MAC_OWNER_MSK;
-	iwl_write_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG, val);
-
-	/* Read crf info */
-	info->hw_crf_id = iwl_read_prph_no_grab(iwl_trans, sd_reg_ver_addr);
-
-	/* Read cnv info */
-	info->hw_cnv_id = iwl_read_prph_no_grab(iwl_trans, CNVI_AUX_MISC_CHIP);
-
-	/* For BZ-W, take B step also when A step is indicated */
-	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W)
-		step = SILICON_B_STEP;
-
-	/* In BZ, the MAC step must be read from the CNVI aux register */
-	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ) {
-		step = CNVI_AUX_MISC_CHIP_MAC_STEP(info->hw_cnv_id);
-
-		/* For BZ-U, take B step also when A step is indicated */
-		if ((CNVI_AUX_MISC_CHIP_PROD_TYPE(info->hw_cnv_id) ==
-		    CNVI_AUX_MISC_CHIP_PROD_TYPE_BZ_U) &&
-		    step == SILICON_A_STEP)
-			step = SILICON_B_STEP;
-	}
-
-	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ ||
-	    CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W) {
-		info->hw_rev_step = step;
-		info->hw_rev |= step;
-	}
-
-	/* Read cdb info (also contains the jacket info if needed in the future */
-	hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
-	IWL_INFO(iwl_trans, "Detected crf-id 0x%x, cnv-id 0x%x wfpm id 0x%x\n",
-		 info->hw_crf_id, info->hw_cnv_id, hw_wfpm_id);
-}
-
-/*
- * In case that there is no OTP on the NIC, map the rf id and cdb info
- * from the prph registers.
- */
-static int map_crf_id(struct iwl_trans *iwl_trans,
-		      struct iwl_trans_info *info)
-{
-	int ret = 0;
-	u32 val = info->hw_crf_id;
-	u32 step_id = REG_CRF_ID_STEP(val);
-	u32 slave_id = REG_CRF_ID_SLAVE(val);
-	u32 jacket_id_cnv = REG_CRF_ID_SLAVE(info->hw_cnv_id);
-	u32 hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans,
-						    WFPM_OTP_CFG1_ADDR);
-	u32 jacket_id_wfpm = WFPM_OTP_CFG1_IS_JACKET(hw_wfpm_id);
-	u32 cdb_id_wfpm = WFPM_OTP_CFG1_IS_CDB(hw_wfpm_id);
-
-	/* Map between crf id to rf id */
-	switch (REG_CRF_ID_TYPE(val)) {
-	case REG_CRF_ID_TYPE_JF_1:
-		info->hw_rf_id = (IWL_CFG_RF_TYPE_JF1 << 12);
-		break;
-	case REG_CRF_ID_TYPE_JF_2:
-		info->hw_rf_id = (IWL_CFG_RF_TYPE_JF2 << 12);
-		break;
-	case REG_CRF_ID_TYPE_HR_NONE_CDB_1X1:
-		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR1 << 12);
-		break;
-	case REG_CRF_ID_TYPE_HR_NONE_CDB:
-		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
-		break;
-	case REG_CRF_ID_TYPE_HR_CDB:
-		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
-		break;
-	case REG_CRF_ID_TYPE_GF:
-		info->hw_rf_id = (IWL_CFG_RF_TYPE_GF << 12);
-		break;
-	case REG_CRF_ID_TYPE_FM:
-		info->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
-		break;
-	case REG_CRF_ID_TYPE_WHP:
-		info->hw_rf_id = (IWL_CFG_RF_TYPE_WH << 12);
-		break;
-	case REG_CRF_ID_TYPE_PE:
-		info->hw_rf_id = (IWL_CFG_RF_TYPE_PE << 12);
-		break;
-	default:
-		ret = -EIO;
-		IWL_ERR(iwl_trans,
-			"Can't find a correct rfid for crf id 0x%x\n",
-			REG_CRF_ID_TYPE(val));
-		goto out;
-
-	}
-
-	/* Set Step-id */
-	info->hw_rf_id |= (step_id << 8);
-
-	/* Set CDB capabilities */
-	if (cdb_id_wfpm || slave_id) {
-		info->hw_rf_id += BIT(28);
-		IWL_INFO(iwl_trans, "Adding cdb to rf id\n");
-	}
-
-	/* Set Jacket capabilities */
-	if (jacket_id_wfpm || jacket_id_cnv) {
-		info->hw_rf_id += BIT(29);
-		IWL_INFO(iwl_trans, "Adding jacket to rf id\n");
-	}
-
-	IWL_INFO(iwl_trans,
-		 "Detected rf-type 0x%x step-id 0x%x slave-id 0x%x from crf id 0x%x\n",
-		 REG_CRF_ID_TYPE(val), step_id, slave_id, info->hw_rf_id);
-	IWL_INFO(iwl_trans,
-		 "Detected cdb-id 0x%x jacket-id 0x%x from wfpm id 0x%x\n",
-		 cdb_id_wfpm, jacket_id_wfpm, hw_wfpm_id);
-	IWL_INFO(iwl_trans, "Detected jacket-id 0x%x from cnvi id 0x%x\n",
-		 jacket_id_cnv, info->hw_cnv_id);
-
-out:
-	return ret;
-}
-
 /* PCI registers */
 #define PCI_CFG_RETRY_TIMEOUT	0x041
 
-VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info *
+const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
 		      u8 rf_id, u8 bw_limit, u8 rf_step)
 {
@@ -1261,193 +1124,11 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_pci_find_dev_info);
 
-static void iwl_pcie_recheck_me_status(struct work_struct *wk)
-{
-	struct iwl_trans_pcie *trans_pcie = container_of(wk,
-							 typeof(*trans_pcie),
-							 me_recheck_wk.work);
-	u32 val;
-
-	val = iwl_read32(trans_pcie->trans, CSR_HW_IF_CONFIG_REG);
-	trans_pcie->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
-}
-
-static void iwl_pcie_check_me_status(struct iwl_trans *trans)
-{
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	u32 val;
-
-	trans_pcie->me_present = -1;
-
-	INIT_DELAYED_WORK(&trans_pcie->me_recheck_wk,
-			  iwl_pcie_recheck_me_status);
-
-	/* we don't have a good way of determining this until BZ */
-	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
-		return;
-
-	val = iwl_read_prph(trans, CNVI_SCU_REG_FOR_ECO_1);
-	if (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN) {
-		trans_pcie->me_present =
-			!!(val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT);
-		return;
-	}
-
-	val = iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
-	if (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
-		   CSR_HW_IF_CONFIG_REG_IAMT_UP)) {
-		trans_pcie->me_present = 1;
-		return;
-	}
-
-	/* recheck again later, ME might still be initializing */
-	schedule_delayed_work(&trans_pcie->me_recheck_wk, HZ);
-}
-
 static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	const struct iwl_mac_cfg *trans;
-	const struct iwl_dev_info *dev_info;
-	struct iwl_trans_info info = {
-		.hw_id = (pdev->device << 16) + pdev->subsystem_device,
-	};
-	struct iwl_trans *iwl_trans;
-	struct iwl_trans_pcie *trans_pcie;
-	int ret;
-
-	trans = (void *)ent->driver_data;
+	const struct iwl_mac_cfg *mac_cfg = (void *)ent->driver_data;
 
-	iwl_trans = iwl_trans_pcie_alloc(pdev, trans, &info);
-	if (IS_ERR(iwl_trans))
-		return PTR_ERR(iwl_trans);
-
-	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(iwl_trans);
-
-	iwl_trans_pcie_check_product_reset_status(pdev);
-	iwl_trans_pcie_check_product_reset_mode(pdev);
-
-	/* set the things we know so far for the grab NIC access */
-	iwl_trans_set_info(iwl_trans, &info);
-
-	/*
-	 * Let's try to grab NIC access early here. Sometimes, NICs may
-	 * fail to initialize, and if that happens it's better if we see
-	 * issues early on (and can reprobe, per the logic inside), than
-	 * first trying to load the firmware etc. and potentially only
-	 * detecting any problems when the first interface is brought up.
-	 */
-	ret = iwl_pcie_prepare_card_hw(iwl_trans);
-	if (!ret) {
-		ret = iwl_finish_nic_init(iwl_trans);
-		if (ret)
-			goto out_free_trans;
-		if (iwl_trans_grab_nic_access(iwl_trans)) {
-			get_crf_id(iwl_trans, &info);
-			/* all good */
-			iwl_trans_release_nic_access(iwl_trans);
-		} else {
-			ret = -EIO;
-			goto out_free_trans;
-		}
-	}
-
-	info.hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
-
-	/*
-	 * The RF_ID is set to zero in blank OTP so read version to
-	 * extract the RF_ID.
-	 * This is relevant only for family 9000 and up.
-	 */
-	if (iwl_trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
-	    !CSR_HW_RFID_TYPE(info.hw_rf_id) && map_crf_id(iwl_trans, &info)) {
-		ret = -EINVAL;
-		goto out_free_trans;
-	}
-
-	IWL_INFO(iwl_trans, "PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
-		 pdev->device, pdev->subsystem_device,
-		 info.hw_rev, info.hw_rf_id);
-
-	dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
-					 CSR_HW_RFID_TYPE(info.hw_rf_id),
-					 CSR_HW_RFID_IS_CDB(info.hw_rf_id),
-					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
-					 IWL_SUBDEVICE_BW_LIM(pdev->subsystem_device),
-					 CSR_HW_RFID_STEP(info.hw_rf_id));
-	if (dev_info) {
-		iwl_trans->cfg = dev_info->cfg;
-		info.name = dev_info->name;
-	}
-
-#if IS_ENABLED(CONFIG_IWLMVM)
-	/*
-	 * special-case 7265D, it has the same PCI IDs.
-	 *
-	 * Note that because we already pass the cfg to the transport above,
-	 * all the parameters that the transport uses must, until that is
-	 * changed, be identical to the ones in the 7265D configuration.
-	 */
-	if (iwl_trans->cfg == &iwl7265_cfg &&
-	    (info.hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
-		iwl_trans->cfg = &iwl7265d_cfg;
-#endif
-	if (!iwl_trans->cfg) {
-		pr_err("No config found for PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
-		       pdev->device, pdev->subsystem_device,
-		       info.hw_rev, info.hw_rf_id);
-		ret = -EINVAL;
-		goto out_free_trans;
-	}
-
-	IWL_INFO(iwl_trans, "Detected %s\n", info.name);
-
-	if (iwl_trans->mac_cfg->mq_rx_supported) {
-		if (WARN_ON(!iwl_trans->cfg->num_rbds)) {
-			ret = -EINVAL;
-			goto out_free_trans;
-		}
-		trans_pcie->num_rx_bufs = iwl_trans_get_num_rbds(iwl_trans);
-	} else {
-		trans_pcie->num_rx_bufs = RX_QUEUE_SIZE;
-	}
-
-	if (!iwl_trans->mac_cfg->integrated) {
-		u16 link_status;
-
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status);
-
-		info.pcie_link_speed =
-			u16_get_bits(link_status, PCI_EXP_LNKSTA_CLS);
-	}
-
-	iwl_trans_set_info(iwl_trans, &info);
-
-	ret = iwl_trans_init(iwl_trans);
-	if (ret)
-		goto out_free_trans;
-
-	pci_set_drvdata(pdev, iwl_trans);
-
-	iwl_pcie_check_me_status(iwl_trans);
-
-	/* try to get ownership so that we'll know if we don't own it */
-	iwl_pcie_prepare_card_hw(iwl_trans);
-
-	iwl_trans->drv = iwl_drv_start(iwl_trans);
-
-	if (IS_ERR(iwl_trans->drv)) {
-		ret = PTR_ERR(iwl_trans->drv);
-		goto out_free_trans;
-	}
-
-	/* register transport layer debugfs here */
-	iwl_trans_pcie_dbgfs_register(iwl_trans);
-
-	return 0;
-
-out_free_trans:
-	iwl_trans_pcie_free(iwl_trans);
-	return ret;
+	return iwl_pci_gen1_2_probe(pdev, ent, mac_cfg);
 }
 
 static void iwl_pci_remove(struct pci_dev *pdev)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 23c0771a4231..5530f35042ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -538,10 +538,6 @@ iwl_trans_pcie_get_trans(struct iwl_trans_pcie *trans_pcie)
  * Convention: trans API functions: iwl_trans_pcie_XXX
  *	Other functions: iwl_pcie_XXX
  */
-struct iwl_trans
-*iwl_trans_pcie_alloc(struct pci_dev *pdev,
-		      const struct iwl_mac_cfg *mac_cfg,
-		      struct iwl_trans_info *info);
 void iwl_trans_pcie_free(struct iwl_trans *trans);
 void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
 					   struct device *dev);
@@ -1081,6 +1077,9 @@ bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
 void __releases(nic_access_nobh)
 iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
 void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power);
+int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
+			 const struct pci_device_id *ent,
+			 const struct iwl_mac_cfg *trans);
 
 /* transport gen 1 exported functions */
 void iwl_trans_pcie_fw_alive(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 4b063c2e7356..49baa4b57b42 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -3683,7 +3683,7 @@ void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 	iwl_trans_sync_nmi_with_addr(trans, inta_addr, sw_err_bit);
 }
 
-struct iwl_trans *
+static struct iwl_trans *
 iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		     const struct iwl_mac_cfg *mac_cfg,
 		     struct iwl_trans_info *info)
@@ -3949,3 +3949,331 @@ int iwl_trans_pcie_copy_imr(struct iwl_trans *trans,
 	trans_pcie->imr_status = IMR_D2S_IDLE;
 	return 0;
 }
+
+/*
+ * Read rf id and cdb info from prph register and store it
+ */
+static void get_crf_id(struct iwl_trans *iwl_trans,
+		       struct iwl_trans_info *info)
+{
+	u32 sd_reg_ver_addr;
+	u32 hw_wfpm_id;
+	u32 val = 0;
+	u8 step;
+
+	if (iwl_trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		sd_reg_ver_addr = SD_REG_VER_GEN2;
+	else
+		sd_reg_ver_addr = SD_REG_VER;
+
+	/* Enable access to peripheral registers */
+	val = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
+	val |= WFPM_AUX_CTL_AUX_IF_MAC_OWNER_MSK;
+	iwl_write_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG, val);
+
+	/* Read crf info */
+	info->hw_crf_id = iwl_read_prph_no_grab(iwl_trans, sd_reg_ver_addr);
+
+	/* Read cnv info */
+	info->hw_cnv_id = iwl_read_prph_no_grab(iwl_trans, CNVI_AUX_MISC_CHIP);
+
+	/* For BZ-W, take B step also when A step is indicated */
+	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W)
+		step = SILICON_B_STEP;
+
+	/* In BZ, the MAC step must be read from the CNVI aux register */
+	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ) {
+		step = CNVI_AUX_MISC_CHIP_MAC_STEP(info->hw_cnv_id);
+
+		/* For BZ-U, take B step also when A step is indicated */
+		if ((CNVI_AUX_MISC_CHIP_PROD_TYPE(info->hw_cnv_id) ==
+		    CNVI_AUX_MISC_CHIP_PROD_TYPE_BZ_U) &&
+		    step == SILICON_A_STEP)
+			step = SILICON_B_STEP;
+	}
+
+	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ ||
+	    CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W) {
+		info->hw_rev_step = step;
+		info->hw_rev |= step;
+	}
+
+	/* Read cdb info (also contains the jacket info if needed in the future */
+	hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
+	IWL_INFO(iwl_trans, "Detected crf-id 0x%x, cnv-id 0x%x wfpm id 0x%x\n",
+		 info->hw_crf_id, info->hw_cnv_id, hw_wfpm_id);
+}
+
+/*
+ * In case that there is no OTP on the NIC, map the rf id and cdb info
+ * from the prph registers.
+ */
+static int map_crf_id(struct iwl_trans *iwl_trans,
+		      struct iwl_trans_info *info)
+{
+	int ret = 0;
+	u32 val = info->hw_crf_id;
+	u32 step_id = REG_CRF_ID_STEP(val);
+	u32 slave_id = REG_CRF_ID_SLAVE(val);
+	u32 jacket_id_cnv = REG_CRF_ID_SLAVE(info->hw_cnv_id);
+	u32 hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans,
+						    WFPM_OTP_CFG1_ADDR);
+	u32 jacket_id_wfpm = WFPM_OTP_CFG1_IS_JACKET(hw_wfpm_id);
+	u32 cdb_id_wfpm = WFPM_OTP_CFG1_IS_CDB(hw_wfpm_id);
+
+	/* Map between crf id to rf id */
+	switch (REG_CRF_ID_TYPE(val)) {
+	case REG_CRF_ID_TYPE_JF_1:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_JF1 << 12);
+		break;
+	case REG_CRF_ID_TYPE_JF_2:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_JF2 << 12);
+		break;
+	case REG_CRF_ID_TYPE_HR_NONE_CDB_1X1:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR1 << 12);
+		break;
+	case REG_CRF_ID_TYPE_HR_NONE_CDB:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
+		break;
+	case REG_CRF_ID_TYPE_HR_CDB:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
+		break;
+	case REG_CRF_ID_TYPE_GF:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_GF << 12);
+		break;
+	case REG_CRF_ID_TYPE_FM:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
+		break;
+	case REG_CRF_ID_TYPE_WHP:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_WH << 12);
+		break;
+	case REG_CRF_ID_TYPE_PE:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_PE << 12);
+		break;
+	default:
+		ret = -EIO;
+		IWL_ERR(iwl_trans,
+			"Can't find a correct rfid for crf id 0x%x\n",
+			REG_CRF_ID_TYPE(val));
+		goto out;
+	}
+
+	/* Set Step-id */
+	info->hw_rf_id |= (step_id << 8);
+
+	/* Set CDB capabilities */
+	if (cdb_id_wfpm || slave_id) {
+		info->hw_rf_id += BIT(28);
+		IWL_INFO(iwl_trans, "Adding cdb to rf id\n");
+	}
+
+	/* Set Jacket capabilities */
+	if (jacket_id_wfpm || jacket_id_cnv) {
+		info->hw_rf_id += BIT(29);
+		IWL_INFO(iwl_trans, "Adding jacket to rf id\n");
+	}
+
+	IWL_INFO(iwl_trans,
+		 "Detected rf-type 0x%x step-id 0x%x slave-id 0x%x from crf id 0x%x\n",
+		 REG_CRF_ID_TYPE(val), step_id, slave_id, info->hw_rf_id);
+	IWL_INFO(iwl_trans,
+		 "Detected cdb-id 0x%x jacket-id 0x%x from wfpm id 0x%x\n",
+		 cdb_id_wfpm, jacket_id_wfpm, hw_wfpm_id);
+	IWL_INFO(iwl_trans, "Detected jacket-id 0x%x from cnvi id 0x%x\n",
+		 jacket_id_cnv, info->hw_cnv_id);
+
+out:
+	return ret;
+}
+
+static void iwl_pcie_recheck_me_status(struct work_struct *wk)
+{
+	struct iwl_trans_pcie *trans_pcie = container_of(wk,
+							 typeof(*trans_pcie),
+							 me_recheck_wk.work);
+	u32 val;
+
+	val = iwl_read32(trans_pcie->trans, CSR_HW_IF_CONFIG_REG);
+	trans_pcie->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
+}
+
+/* TODO: relevant for blazar and later, remove when gen3 is active
+ * (task=clean_up_old)
+ */
+static void iwl_pcie_check_me_status(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u32 val;
+
+	trans_pcie->me_present = -1;
+
+	INIT_DELAYED_WORK(&trans_pcie->me_recheck_wk,
+			  iwl_pcie_recheck_me_status);
+
+	/* we don't have a good way of determining this until BZ */
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+		return;
+
+	val = iwl_read_prph(trans, CNVI_SCU_REG_FOR_ECO_1);
+	if (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN) {
+		trans_pcie->me_present =
+			!!(val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT);
+		return;
+	}
+
+	val = iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
+	if (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
+		   CSR_HW_IF_CONFIG_REG_IAMT_UP)) {
+		trans_pcie->me_present = 1;
+		return;
+	}
+
+	/* recheck again later, ME might still be initializing */
+	schedule_delayed_work(&trans_pcie->me_recheck_wk, HZ);
+}
+
+int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
+			 const struct pci_device_id *ent,
+			 const struct iwl_mac_cfg *trans)
+{
+	const struct iwl_dev_info *dev_info;
+	struct iwl_trans_info info = {
+		.hw_id = (pdev->device << 16) + pdev->subsystem_device,
+	};
+	struct iwl_trans *iwl_trans;
+	struct iwl_trans_pcie *trans_pcie;
+	int ret;
+
+	iwl_trans = iwl_trans_pcie_alloc(pdev, trans, &info);
+	if (IS_ERR(iwl_trans))
+		return PTR_ERR(iwl_trans);
+
+	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(iwl_trans);
+
+	iwl_trans_pcie_check_product_reset_status(pdev);
+	iwl_trans_pcie_check_product_reset_mode(pdev);
+
+	/* set the things we know so far for the grab NIC access */
+	iwl_trans_set_info(iwl_trans, &info);
+
+	/*
+	 * Let's try to grab NIC access early here. Sometimes, NICs may
+	 * fail to initialize, and if that happens it's better if we see
+	 * issues early on (and can reprobe, per the logic inside), than
+	 * first trying to load the firmware etc. and potentially only
+	 * detecting any problems when the first interface is brought up.
+	 */
+	ret = iwl_pcie_prepare_card_hw(iwl_trans);
+	if (!ret) {
+		ret = iwl_finish_nic_init(iwl_trans);
+		if (ret)
+			goto out_free_trans;
+		if (iwl_trans_grab_nic_access(iwl_trans)) {
+			get_crf_id(iwl_trans, &info);
+			/* all good */
+			iwl_trans_release_nic_access(iwl_trans);
+		} else {
+			ret = -EIO;
+			goto out_free_trans;
+		}
+	}
+
+	info.hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
+
+	/*
+	 * The RF_ID is set to zero in blank OTP so read version to
+	 * extract the RF_ID.
+	 * This is relevant only for family 9000 and up.
+	 */
+	if (iwl_trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
+	    !CSR_HW_RFID_TYPE(info.hw_rf_id) && map_crf_id(iwl_trans, &info)) {
+		ret = -EINVAL;
+		goto out_free_trans;
+	}
+
+	IWL_INFO(iwl_trans, "PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
+		 pdev->device, pdev->subsystem_device,
+		 info.hw_rev, info.hw_rf_id);
+
+	dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
+					 CSR_HW_RFID_TYPE(info.hw_rf_id),
+					 CSR_HW_RFID_IS_CDB(info.hw_rf_id),
+					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
+					 IWL_SUBDEVICE_BW_LIM(pdev->subsystem_device),
+					 CSR_HW_RFID_STEP(info.hw_rf_id));
+	if (dev_info) {
+		iwl_trans->cfg = dev_info->cfg;
+		info.name = dev_info->name;
+	}
+
+#if IS_ENABLED(CONFIG_IWLMVM)
+
+	/*
+	 * special-case 7265D, it has the same PCI IDs.
+	 *
+	 * Note that because we already pass the cfg to the transport above,
+	 * all the parameters that the transport uses must, until that is
+	 * changed, be identical to the ones in the 7265D configuration.
+	 */
+	if (iwl_trans->cfg == &iwl7265_cfg &&
+	    (info.hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
+		iwl_trans->cfg = &iwl7265d_cfg;
+#endif
+	if (!iwl_trans->cfg) {
+		pr_err("No config found for PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
+		       pdev->device, pdev->subsystem_device,
+		       info.hw_rev, info.hw_rf_id);
+		ret = -EINVAL;
+		goto out_free_trans;
+	}
+
+	IWL_INFO(iwl_trans, "Detected %s\n", info.name);
+
+	if (iwl_trans->mac_cfg->mq_rx_supported) {
+		if (WARN_ON(!iwl_trans->cfg->num_rbds)) {
+			ret = -EINVAL;
+			goto out_free_trans;
+		}
+		trans_pcie->num_rx_bufs = iwl_trans_get_num_rbds(iwl_trans);
+	} else {
+		trans_pcie->num_rx_bufs = RX_QUEUE_SIZE;
+	}
+
+	if (!iwl_trans->mac_cfg->integrated) {
+		u16 link_status;
+
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status);
+
+		info.pcie_link_speed =
+			u16_get_bits(link_status, PCI_EXP_LNKSTA_CLS);
+	}
+
+	iwl_trans_set_info(iwl_trans, &info);
+
+	ret = iwl_trans_init(iwl_trans);
+	if (ret)
+		goto out_free_trans;
+
+	pci_set_drvdata(pdev, iwl_trans);
+
+	iwl_pcie_check_me_status(iwl_trans);
+
+	/* try to get ownership so that we'll know if we don't own it */
+	iwl_pcie_prepare_card_hw(iwl_trans);
+
+	iwl_trans->drv = iwl_drv_start(iwl_trans);
+
+	if (IS_ERR(iwl_trans->drv)) {
+		ret = PTR_ERR(iwl_trans->drv);
+		goto out_free_trans;
+	}
+
+	/* register transport layer debugfs here */
+	iwl_trans_pcie_dbgfs_register(iwl_trans);
+
+	return 0;
+
+out_free_trans:
+	iwl_trans_pcie_free(iwl_trans);
+	return ret;
+}
-- 
2.34.1



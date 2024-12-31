Return-Path: <linux-wireless+bounces-16933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D21F9FEF38
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E491882C12
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5DC17ADE8;
	Tue, 31 Dec 2024 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWgmN3i2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F80192590
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646373; cv=none; b=J7ZPuH1Ao5vIUP7uNunK/7MquikDz5mdWH7hG5D7BH1iG7vYBw3zQKDKJvF1jPDNWW2jlKHKyTTp7bg3lP4zcFJuMQg7jaKy8PcXXg9l+WFcNmZeHSaFfffBWi/a69OX1fQ+nRhBCxtMhdOzuCs4P1l/l8C74Z5vsWfyKUaQ64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646373; c=relaxed/simple;
	bh=8A271pA+qV1P5ZHeq3SymQjNMp9rtPbGmEuFQrz9D+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ajQ5tYpN+VcpULRpTolAO4FUlchtzYisHjSSsAs9nVgliAWEfLLKBAjW6+OvfBQAUud6ivFDPtxnmth+tOTGS69vVl1tCsdyhXHPc3h5D6rRHndUl4x+k7BAgSMpqxtVDe4SME33cGKEPgHvC+/zgeEiJmthJYD2O/psl1nPMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWgmN3i2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646371; x=1767182371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8A271pA+qV1P5ZHeq3SymQjNMp9rtPbGmEuFQrz9D+4=;
  b=WWgmN3i2MLbDZAhrHGNNWYC0+g9tLH7ptA9wjICJfOXo8TfnB/6p44B4
   OBKTWwbzH8oJLqiqHKS7Fvm01OS4ZL5ezsj5srKJOGauKV7uX6x3o10Oj
   l4sbxiXbDI4Nts+s5IY93ArfgUiAnIE0UO4Vtz+alXlhTgLv/D07hAcau
   dymliq14NxrvBVc8ndqEM4XHD8GcuAzBB/QKU37bRuBLsISUyD9GvesSa
   T/ftQKzVnAljIgW2DphLUQJZ5zPceV/E6yx+qdmkQBjSz5A+4Wr1Am5Z+
   P0/Gry5TzM6LtyBqNihHYgaCT6pyj5M+l0XtMW5xE8cGR3byYn0QUoc13
   Q==;
X-CSE-ConnectionGUID: EtjH95SHTjq8fM3vXAAHog==
X-CSE-MsgGUID: 8uNbypA9RjGI469lUYg87Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330155"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330155"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:31 -0800
X-CSE-ConnectionGUID: 763IevVRSdqUnx2/LqIZMQ==
X-CSE-MsgGUID: fD2d6iueS3ysyhuvL7xfTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380255"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:30 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: pcie: check for WiAMT/CSME presence
Date: Tue, 31 Dec 2024 13:59:01 +0200
Message-Id: <20241231135726.0ac9173f1f37.Id83b80b61548b8f4f01e96a356dafe063543c4ac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In order to know whether or not a product reset can safely
be done (without risking locking up the system completely),
check for ME presence with the known methods.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  4 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  6 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 45 +++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index c2cd5c24646b..b4462bc1cf22 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -171,6 +171,7 @@
 /* NOTE: EEPROM_OWN_SEM is no longer defined for new HW */
 #define CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM		0x00200000
 #define CSR_HW_IF_CONFIG_REG_PCI_OWN_SET		0x00400000
+#define CSR_HW_IF_CONFIG_REG_IAMT_UP			0x01000000
 #define CSR_HW_IF_CONFIG_REG_ME_OWN			0x02000000
 #define CSR_HW_IF_CONFIG_REG_WAKE_ME			0x08000000
 #define CSR_HW_IF_CONFIG_REG_WAKE_ME_PCIE_OWNER_EN	0x10000000
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 8d4ff42da35a..23b2009fbb28 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -381,6 +381,10 @@ enum {
 #define CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR	0xA29938
 #define CNVI_SCU_SEQ_DATA_DW9				0xA27488
 
+#define CNVI_SCU_REG_FOR_ECO_1				0xA26EF8
+#define   CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN		BIT(4)
+#define   CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT		BIT(5)
+
 #define CNVI_PMU_STEP_FLOW				0xA2D588
 #define CNVI_PMU_STEP_FLOW_FORCE_URM			BIT(2)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 45c5245136a7..c342a4d6ca6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -882,6 +882,9 @@ struct iwl_txq {
  * @restart.wk: restart worker
  * @restart.mode: reset/restart error mode information
  * @restart.during_reset: error occurred during previous software reset
+ * @me_recheck_wk: worker to recheck WiAMT/CSME presence
+ * @me_present: WiAMT/CSME is detected as present (1), not present (0)
+ *	or unknown (-1, so can still use it as a boolean safely)
  * @trans_specific: data for the specific transport this is allocated for/with
  * @dsbr_urm_fw_dependent: switch to URM based on fw settings
  * @dsbr_urm_permanent: switch to URM permanently
@@ -960,6 +963,9 @@ struct iwl_trans {
 		bool during_reset;
 	} restart;
 
+	struct delayed_work me_recheck_wk;
+	s8 me_present;
+
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
 	char trans_specific[] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e73a9a47bf1d..892444844a9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1375,6 +1375,47 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_pci_find_dev_info);
 
+static void iwl_pcie_recheck_me_status(struct work_struct *wk)
+{
+	struct iwl_trans *trans = container_of(wk, typeof(*trans),
+					       me_recheck_wk.work);
+	u32 val;
+
+	val = iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
+	trans->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
+}
+
+static void iwl_pcie_check_me_status(struct iwl_trans *trans)
+{
+	u32 val;
+
+	trans->me_present = -1;
+
+	INIT_DELAYED_WORK(&trans->me_recheck_wk,
+			  iwl_pcie_recheck_me_status);
+
+	/* we don't have a good way of determining this until BZ */
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+		return;
+
+	val = iwl_read_prph(trans, CNVI_SCU_REG_FOR_ECO_1);
+	if (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN) {
+		trans->me_present =
+			!!(val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT);
+		return;
+	}
+
+	val = iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
+	if (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
+		   CSR_HW_IF_CONFIG_REG_IAMT_UP)) {
+		trans->me_present = 1;
+		return;
+	}
+
+	/* recheck again later, ME might still be initializing */
+	schedule_delayed_work(&trans->me_recheck_wk, HZ);
+}
+
 static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct iwl_cfg_trans_params *trans;
@@ -1550,6 +1591,8 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, iwl_trans);
 
+	iwl_pcie_check_me_status(iwl_trans);
+
 	/* try to get ownership so that we'll know if we don't own it */
 	iwl_pcie_prepare_card_hw(iwl_trans);
 
@@ -1577,6 +1620,8 @@ static void iwl_pci_remove(struct pci_dev *pdev)
 	if (!trans)
 		return;
 
+	cancel_delayed_work_sync(&trans->me_recheck_wk);
+
 	iwl_drv_stop(trans->drv);
 
 	iwl_trans_pcie_free(trans);
-- 
2.34.1



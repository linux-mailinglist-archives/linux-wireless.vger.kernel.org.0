Return-Path: <linux-wireless+bounces-22828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD8AB2512
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D89189D6DB
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87921283C89;
	Sat, 10 May 2025 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7bMD0VT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4322D4EB
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902943; cv=none; b=SsX7u0QYnATenNhcez0KhOePUQGbdUCkS5fEgkuvdNI6C64740//vtLV+H8KZNX0h14R7xgBN7vjRs7RqsKV+TCO0uKjUUwx4mSa5CIiWV9Bb9yMW/5MVcmofvNIUD8rSa4ropHAeVDl7a0cCXaZ8FehUN6ECKVxg0xeXzQrMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902943; c=relaxed/simple;
	bh=S0RdKbN6CjNQnQBLr6HQRJcTShNRZiput8yVQou40fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQCFXRicUjQjPZPcJ9UWK7efjxfmitS8PD8SP6bZLrWl63H7Kxbgdz5vAQn4icCmFMxu6K2VmpucxG8cP3mWaWaxBMJKLNmesSZwJpRAGbmsp5nBbHmUVWYksBgujIt05CiQ7cuCBRHm8sjoQVTMrn36cNUbx2KYz5Xlq04xRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7bMD0VT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902942; x=1778438942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0RdKbN6CjNQnQBLr6HQRJcTShNRZiput8yVQou40fk=;
  b=k7bMD0VTPKUFko1a7VEiDwiZyvY0Q1NA0lRtE+ZtWlrGelbH1RqhpnN2
   PYYdGuowSiPJ9koUP2WWpXYe2S75K3kWOdLZ+coWViEcjGyw+9+GkmiwR
   yfpqjCgw7tSujmTdk2EjD+OQnsS9jxRj5wKONq89IGlK5dgGVHmxG/Wch
   D7FzpGVFrpCLOj9WSTCedf5yO18jAjVfWq5vzKqG9kVScQHAsXfu/Cm8k
   v8nTh3gIxNoTcjVb9yRkNdATpEQ0eon+n94rf1nLrK6gkUvcY2TnXz8uL
   eF0DUc+GSKHidAhV/eid/S50DW5DNuk+/eR1320q1Pict5Fqke+IvbI1p
   w==;
X-CSE-ConnectionGUID: CaaJxt9KSWeYzCrM0TUXWw==
X-CSE-MsgGUID: hY5RGFv5SXeMD+28HyqoRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880895"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880895"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:49:02 -0700
X-CSE-ConnectionGUID: QfhDMZgWRx2QfvvFpWQJkQ==
X-CSE-MsgGUID: XGXPfwGfRGCT75JqISLllA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033463"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:49:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: cfg: remove MAC type/step matching
Date: Sat, 10 May 2025 21:48:27 +0300
Message-Id: <20250510214621.fca99a5ab315.Iae27b781221fd29845493adf2c29d9e4f7a9c33b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
References: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Now that it's all split into MAC and RF configs, remove
the matching on MAC type and step. If we ever need to do
something based on the MAC step, we'll have to find some
new mechanism (since the MAC type is known already from
the PCI IDs table, but not the step), or just handle the
(likely small) differences in code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  5 +----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 17 +----------------
 .../net/wireless/intel/iwlwifi/tests/devinfo.c  |  5 ++---
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index b1caa7205850..0b18f44af774 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -482,9 +482,7 @@ struct iwl_dev_info {
 	u16 subdevice;
 	u16 subdevice_mask;
 	u16 rf_type;
-	u8 mac_type;
 	u8 bw_limit;
-	u8 mac_step;
 	u8 rf_step;
 	u8 rf_id;
 	u8 cores;
@@ -498,8 +496,7 @@ struct iwl_dev_info {
 extern const struct iwl_dev_info iwl_dev_info_table[];
 extern const unsigned int iwl_dev_info_table_size;
 const struct iwl_dev_info *
-iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
-		      u8 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
+iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
 		      u8 jacket, u8 rf_id, u8 bw_limit, u8 cores, u8 rf_step);
 extern const struct pci_device_id iwl_hw_card_ids[];
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 39d46b83b5da..1d149843f335 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -561,8 +561,6 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 	.device = IWL_CFG_ANY,			\
 	.subdevice = IWL_CFG_ANY,		\
 	.subdevice_mask = ~0,			\
-	.mac_type = IWL_CFG_ANY,		\
-	.mac_step = IWL_CFG_ANY,		\
 	.rf_type = IWL_CFG_ANY,			\
 	.rf_step = IWL_CFG_ANY,			\
 	.bw_limit = IWL_CFG_ANY,		\
@@ -580,8 +578,6 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 #define SUBDEV_MASKED(v, m)			\
 			.subdevice = (v),	\
 			.subdevice_mask = (m)
-#define MAC_TYPE(n)	.mac_type = IWL_CFG_MAC_TYPE_##n
-#define MAC_STEP(n)	.mac_step = SILICON_##n##_STEP
 #define RF_TYPE(n)	.rf_type = IWL_CFG_RF_TYPE_##n
 #define RF_STEP(n)	.rf_step = SILICON_##n##_STEP
 #define CORES(n)	.cores = IWL_CFG_CORES_##n
@@ -1220,8 +1216,7 @@ static int map_crf_id(struct iwl_trans *iwl_trans,
 #define PCI_CFG_RETRY_TIMEOUT	0x041
 
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info *
-iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
-		      u8 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
+iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
 		      u8 jacket, u8 rf_id, u8 bw_limit, u8 cores, u8 rf_step)
 {
 	int num_devices = ARRAY_SIZE(iwl_dev_info_table);
@@ -1241,14 +1236,6 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		    dev_info->subdevice != (subsystem_device & dev_info->subdevice_mask))
 			continue;
 
-		if (dev_info->mac_type != (u8)IWL_CFG_ANY &&
-		    dev_info->mac_type != mac_type)
-			continue;
-
-		if (dev_info->mac_step != (u8)IWL_CFG_ANY &&
-		    dev_info->mac_step != mac_step)
-			continue;
-
 		if (dev_info->rf_type != (u16)IWL_CFG_ANY &&
 		    dev_info->rf_type != rf_type)
 			continue;
@@ -1392,8 +1379,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 info.hw_rev, info.hw_rf_id);
 
 	dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
-					 CSR_HW_REV_TYPE(info.hw_rev),
-					 info.hw_rev_step,
 					 CSR_HW_RFID_TYPE(info.hw_rf_id),
 					 CSR_HW_RFID_IS_CDB(info.hw_rf_id),
 					 CSR_HW_RFID_IS_JACKET(info.hw_rf_id),
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index bd0102ef7384..69b26de4aff8 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -13,8 +13,8 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
 static void iwl_pci_print_dev_info(const char *pfx, const struct iwl_dev_info *di)
 {
-	printk(KERN_DEBUG "%sdev=%.4x,subdev=%.4x,mac_type=%.4x,mac_step=%.4x,rf_type=%.4x,cdb=%d,jacket=%d,rf_id=%.2x,bw_limit=%d,cores=%.2x\n",
-	       pfx, di->device, di->subdevice, di->mac_type, di->mac_step,
+	printk(KERN_DEBUG "%sdev=%.4x subdev=%.4x rf_type=%.4x cdb=%d jacket=%d rf_id=%.2x bw_limit=%d cores=%.2x\n",
+	       pfx, di->device, di->subdevice,
 	       di->rf_type, di->cdb, di->jacket, di->rf_id, di->bw_limit,
 	       di->cores);
 }
@@ -28,7 +28,6 @@ static void devinfo_table_order(struct kunit *test)
 		const struct iwl_dev_info *ret;
 
 		ret = iwl_pci_find_dev_info(di->device, di->subdevice,
-					    di->mac_type, di->mac_step,
 					    di->rf_type, di->cdb,
 					    di->jacket, di->rf_id,
 					    di->bw_limit,
-- 
2.34.1



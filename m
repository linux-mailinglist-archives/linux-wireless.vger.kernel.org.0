Return-Path: <linux-wireless+bounces-22843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55EBAB29C6
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C19175DB1
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2450B25D55A;
	Sun, 11 May 2025 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6bmZVXk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9CE256C7C
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982423; cv=none; b=Pu7wx/qf8heCJ8Xrrb7IpI/30d0IVg8pywAsM632ZVQr7xz6iQh+3iAbhM0up5QVMZlIXbNijKVDsGJf47H+lb52QFtYheMnddjmpGdLJJyWLtyoonSUxQaZWeVvEtx3hDvjhx6vNrPrtQegfOW7iykPKIM1jWVmwf4GeSbL3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982423; c=relaxed/simple;
	bh=QGMFmPGgAdyhNAgIJyshaCqVCWrkbFy3h8EHdpqvEi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otaNo3/AB0mTcImQuIPtaZLdM7ghtLph+57JUFOWjmUrbg51ZrB4bGHMROSGPp6XBHq59zY7BQIRMKq1N9wL38hOZ9K3ZAxAd2otnPuOZdmSYsrwpGqycxVSrnMEtQ/EspdBiUMlPYHAoImpm5uobmyUmXIap2W/K+ztZHAI9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6bmZVXk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982421; x=1778518421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QGMFmPGgAdyhNAgIJyshaCqVCWrkbFy3h8EHdpqvEi4=;
  b=Q6bmZVXkk2c82YrmqO+7ZteM6QK0B4hcEpl1GFuMpHJB3lF8leC8hCld
   jjvNSQyATDVZinbPMSYTXyKFOy+8F7QO5qo6JOVy0VfpN153s3kP5frYW
   j0IQyuDCS/99MHlt+uGcya1wo/wVPzq3cB1nx+GwPt7dgbelpYI7Ht0HL
   IHdDJg1Pt2Sqj2b7LCEptDGE1PuK1YrvsizO1TNPwVKt/fGJP2HnoW4J1
   OY+o/XhfooIoBfGFVmdpUdAdxzvfvT1Qjvsb/czy/sFcneAIsp2WieAhL
   TNVZUn3/VmPyNcpMWfKdTiHOtsYLP4xDW1kuoqZRRGYX3l//XeP1slmuN
   Q==;
X-CSE-ConnectionGUID: QNpdWL4JQgOOCF0A8UHkGw==
X-CSE-MsgGUID: 6UOPBZbUR2WgLL+QjfbfKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582683"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582683"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:41 -0700
X-CSE-ConnectionGUID: ACJ937quR2+lxBCh0l5KjQ==
X-CSE-MsgGUID: n+M0VdQ/T5SG6U8klrjaUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655035"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: cfg: reduce configuration struct size
Date: Sun, 11 May 2025 19:53:10 +0300
Message-Id: <20250511195137.38a805a7c96f.Ieece00476cea6054b0827cd075eb8ba5943373df@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We don't need the CORES() match nor jacket (which really doesn't
even make sense to match to the RF anyway), and since the subdevice
masks we care about are contiguous, we can encode them as highest
and lowest bit set (automatically.) By encoding whether to match or
not as separate flags and taking advantage of the limited range of
the RF type, step and ID we can reduce the amount of memory needed
for the table, while also making the logic (apart perhaps from the
subdevice mask) easier to understand.

This reduces the size of the module by about 1.5KiB on x86-64.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 26 ++++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 69 ++++++++-----------
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 69 +++++++++++++++----
 3 files changed, 97 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 84befef470cb..91f22ce36d74 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -478,18 +478,22 @@ struct iwl_rf_cfg {
 #define IWL_SUBDEVICE_CORES(subdevice)	((u16)((subdevice) & 0x1C00) >> 10)
 
 struct iwl_dev_info {
-	u16 device;
-	u16 subdevice;
-	u16 subdevice_mask;
-	u16 rf_type;
-	u8 bw_limit;
-	u8 rf_step;
-	u8 rf_id;
-	u8 cores;
-	u8 cdb;
-	u8 jacket;
 	const struct iwl_rf_cfg *cfg;
 	const char *name;
+	u16 device;
+	u16 subdevice;
+	u32 subdevice_m_l:4,
+	    subdevice_m_h:4,
+	    match_rf_type:1,
+	    rf_type:9,
+	    match_bw_limit:1,
+	    bw_limit:1,
+	    match_rf_step:1,
+	    rf_step:4,
+	    match_rf_id:1,
+	    rf_id:4,
+	    match_cdb:1,
+	    cdb:1;
 };
 
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
@@ -497,7 +501,7 @@ extern const struct iwl_dev_info iwl_dev_info_table[];
 extern const unsigned int iwl_dev_info_table_size;
 const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
-		      u8 jacket, u8 rf_id, u8 bw_limit, u8 cores, u8 rf_step);
+		      u8 rf_id, u8 bw_limit, u8 rf_step);
 extern const struct pci_device_id iwl_hw_card_ids[];
 #endif
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 8ffc3a0e7862..52f98aa9a260 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -557,14 +557,7 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 	.name = _name,				\
 	.device = IWL_CFG_ANY,			\
 	.subdevice = IWL_CFG_ANY,		\
-	.subdevice_mask = ~0,			\
-	.rf_type = IWL_CFG_ANY,			\
-	.rf_step = IWL_CFG_ANY,			\
-	.bw_limit = IWL_CFG_ANY,		\
-	.jacket = IWL_CFG_ANY,			\
-	.cores = IWL_CFG_ANY,			\
-	.rf_id = IWL_CFG_ANY,			\
-	.cdb = IWL_CFG_ANY,			\
+	.subdevice_m_h = 15,			\
 	__VA_ARGS__				\
 }
 #define IWL_DEV_INFO(_cfg, _name, ...)		\
@@ -572,17 +565,22 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 
 #define DEVICE(n)	.device = (n)
 #define SUBDEV(n)	.subdevice = (n)
-#define SUBDEV_MASKED(v, m)			\
-			.subdevice = (v),	\
-			.subdevice_mask = (m)
-#define RF_TYPE(n)	.rf_type = IWL_CFG_RF_TYPE_##n
-#define RF_STEP(n)	.rf_step = SILICON_##n##_STEP
-#define CORES(n)	.cores = IWL_CFG_CORES_##n
-#define RF_ID(n)	.rf_id = IWL_CFG_RF_ID_##n
-#define NO_CDB		.cdb = IWL_CFG_NO_CDB
-#define CDB		.cdb = IWL_CFG_CDB
-#define BW_NOT_LIMITED	.bw_limit = 0
-#define BW_LIMITED	.bw_limit = 1
+#define _LOWEST_BIT(n)	(__builtin_ffs(n) - 1)
+#define _HIGHEST_BIT(n)	(__builtin_ffs((n) + 1) - 2)
+#define _IS_POW2(n)	(((n) & ((n) - 1)) == 0)
+#define _IS_CONTIG(n)	_IS_POW2((n) + (1 << _LOWEST_BIT(n)))
+#define _CHECK_MASK(m)	BUILD_BUG_ON_ZERO(!_IS_CONTIG(m))
+#define SUBDEV_MASKED(v, m) \
+			.subdevice = (v) + _CHECK_MASK(m),	\
+			.subdevice_m_l = _LOWEST_BIT(m),	\
+			.subdevice_m_h = _HIGHEST_BIT(m)
+#define RF_TYPE(n)	.match_rf_type = 1, .rf_type = IWL_CFG_RF_TYPE_##n
+#define RF_STEP(n)	.match_rf_step = 1, .rf_step = SILICON_##n##_STEP
+#define RF_ID(n)	.match_rf_id = 1, .rf_id = IWL_CFG_RF_ID_##n
+#define NO_CDB		.match_cdb = 1, .cdb = 0
+#define CDB		.match_cdb = 1, .cdb = 1
+#define BW_NOT_LIMITED	.match_bw_limit = 1, .bw_limit = 0
+#define BW_LIMITED	.match_bw_limit = 1, .bw_limit = 1
 
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLDVM)
@@ -1214,7 +1212,7 @@ static int map_crf_id(struct iwl_trans *iwl_trans,
 
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
-		      u8 jacket, u8 rf_id, u8 bw_limit, u8 cores, u8 rf_step)
+		      u8 rf_id, u8 bw_limit, u8 rf_step)
 {
 	int num_devices = ARRAY_SIZE(iwl_dev_info_table);
 	int i;
@@ -1224,41 +1222,32 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
 
 	for (i = num_devices - 1; i >= 0; i--) {
 		const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
+		u16 subdevice_mask;
 
 		if (dev_info->device != (u16)IWL_CFG_ANY &&
 		    dev_info->device != device)
 			continue;
 
-		if (dev_info->subdevice != (u16)IWL_CFG_ANY &&
-		    dev_info->subdevice != (subsystem_device & dev_info->subdevice_mask))
-			continue;
+		subdevice_mask = GENMASK(dev_info->subdevice_m_h,
+					 dev_info->subdevice_m_l);
 
-		if (dev_info->rf_type != (u16)IWL_CFG_ANY &&
-		    dev_info->rf_type != rf_type)
-			continue;
-
-		if (dev_info->cdb != (u8)IWL_CFG_ANY &&
-		    dev_info->cdb != cdb)
+		if (dev_info->subdevice != (u16)IWL_CFG_ANY &&
+		    dev_info->subdevice != (subsystem_device & subdevice_mask))
 			continue;
 
-		if (dev_info->jacket != (u8)IWL_CFG_ANY &&
-		    dev_info->jacket != jacket)
+		if (dev_info->match_rf_type && dev_info->rf_type != rf_type)
 			continue;
 
-		if (dev_info->rf_id != (u8)IWL_CFG_ANY &&
-		    dev_info->rf_id != rf_id)
+		if (dev_info->match_cdb && dev_info->cdb != cdb)
 			continue;
 
-		if (dev_info->bw_limit != (u8)IWL_CFG_ANY &&
-		    dev_info->bw_limit != bw_limit)
+		if (dev_info->match_rf_id && dev_info->rf_id != rf_id)
 			continue;
 
-		if (dev_info->cores != (u8)IWL_CFG_ANY &&
-		    dev_info->cores != cores)
+		if (dev_info->match_bw_limit && dev_info->bw_limit != bw_limit)
 			continue;
 
-		if (dev_info->rf_step != (u8)IWL_CFG_ANY &&
-		    dev_info->rf_step != rf_step)
+		if (dev_info->match_rf_step && dev_info->rf_step != rf_step)
 			continue;
 
 		return dev_info;
@@ -1378,10 +1367,8 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
 					 CSR_HW_RFID_TYPE(info.hw_rf_id),
 					 CSR_HW_RFID_IS_CDB(info.hw_rf_id),
-					 CSR_HW_RFID_IS_JACKET(info.hw_rf_id),
 					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
 					 IWL_SUBDEVICE_BW_LIM(pdev->subsystem_device),
-					 IWL_SUBDEVICE_CORES(pdev->subsystem_device),
 					 CSR_HW_RFID_STEP(info.hw_rf_id));
 	if (dev_info) {
 		iwl_trans->cfg = dev_info->cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 69b26de4aff8..784433bb246a 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -13,10 +13,50 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
 static void iwl_pci_print_dev_info(const char *pfx, const struct iwl_dev_info *di)
 {
-	printk(KERN_DEBUG "%sdev=%.4x subdev=%.4x rf_type=%.4x cdb=%d jacket=%d rf_id=%.2x bw_limit=%d cores=%.2x\n",
-	       pfx, di->device, di->subdevice,
-	       di->rf_type, di->cdb, di->jacket, di->rf_id, di->bw_limit,
-	       di->cores);
+	u16 subdevice_mask = GENMASK(di->subdevice_m_h, di->subdevice_m_l);
+	char buf[100] = {};
+	int pos = 0;
+
+	if (di->match_rf_type)
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " rf_type=%03x", di->rf_type);
+	else
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " rf_type=*");
+
+	if (di->match_bw_limit)
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " bw_limit=%d", di->bw_limit);
+	else
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " bw_limit=*");
+
+	if (di->match_rf_step)
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " rf_step=%c",
+				 di->rf_step == SILICON_Z_STEP ? 'Z' :
+				 	'A' + di->rf_step);
+	else
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " rf_step=*");
+
+	if (di->match_rf_id)
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " rf_id=0x%x", di->rf_id);
+	else
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " rf_id=*");
+
+	if (di->match_cdb)
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " cdb=%d", di->cdb);
+	else
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " cdb=*");
+
+
+	printk(KERN_DEBUG "%sdev=%04x subdev=%04x/%04x%s\n",
+	       pfx, di->device, di->subdevice, subdevice_mask, buf);
 }
 
 static void devinfo_table_order(struct kunit *test)
@@ -29,9 +69,8 @@ static void devinfo_table_order(struct kunit *test)
 
 		ret = iwl_pci_find_dev_info(di->device, di->subdevice,
 					    di->rf_type, di->cdb,
-					    di->jacket, di->rf_id,
-					    di->bw_limit,
-					    di->cores, di->rf_step);
+					    di->rf_id, di->bw_limit,
+					    di->rf_step);
 		if (!ret) {
 			iwl_pci_print_dev_info("No entry found for: ", di);
 			KUNIT_FAIL(test,
@@ -98,25 +137,25 @@ static void devinfo_check_subdev_match(struct kunit *test)
 {
 	for (int i = 0; i < iwl_dev_info_table_size; i++) {
 		const struct iwl_dev_info *di = &iwl_dev_info_table[i];
+		u16 subdevice_mask = GENMASK(di->subdevice_m_h,
+					     di->subdevice_m_l);
 
 		/* if BW limit bit is matched then must have a limit */
-		if (di->bw_limit == 1)
+		if (di->match_bw_limit == 1 && di->bw_limit == 1)
 			KUNIT_EXPECT_NE(test, di->cfg->bw_limit, 0);
 
-		/* if subdevice is ANY we can have RF ID/BW limit/cores */
+		/* if subdevice is ANY we can have RF ID/BW limit */
 		if (di->subdevice == (u16)IWL_CFG_ANY)
 			continue;
 
 		/* same if the subdevice mask doesn't overlap them */
-		if (IWL_SUBDEVICE_RF_ID(di->subdevice_mask) == 0 &&
-		    IWL_SUBDEVICE_BW_LIM(di->subdevice_mask) == 0 &&
-		    IWL_SUBDEVICE_CORES(di->subdevice_mask) == 0)
+		if (IWL_SUBDEVICE_RF_ID(subdevice_mask) == 0 &&
+		    IWL_SUBDEVICE_BW_LIM(subdevice_mask) == 0)
 			continue;
 
 		/* but otherwise they shouldn't be used */
-		KUNIT_EXPECT_EQ(test, di->rf_id, (u8)IWL_CFG_ANY);
-		KUNIT_EXPECT_EQ(test, di->bw_limit, (u8)IWL_CFG_ANY);
-		KUNIT_EXPECT_EQ(test, di->cores, (u8)IWL_CFG_ANY);
+		KUNIT_EXPECT_EQ(test, (int)di->match_rf_id, 0);
+		KUNIT_EXPECT_EQ(test, (int)di->match_bw_limit, 0);
 	}
 }
 
-- 
2.34.1



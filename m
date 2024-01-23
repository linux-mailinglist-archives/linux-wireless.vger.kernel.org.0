Return-Path: <linux-wireless+bounces-2396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D783839747
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A171C24427
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D837FBB5;
	Tue, 23 Jan 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEkJYqPZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2981215
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033322; cv=none; b=g89tU7fE1gnBJrrGc+SNMURTsTSBfneyb4FBqVrc1YdWO6zAhoCESZjKTGI73iFLPGecW0JsMuogariol0Wi7zTE13CIlrgF+/txNFZEBfXZGDp/a0xfLWAuL+pNDvLL8apP+4ux05hjIAkznEqv23NW/JzE2SuftPL8/ppnYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033322; c=relaxed/simple;
	bh=BqrYUaa1QO9ojoGY2579I7UTBxGRt9Vgt4xV3xv7uE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfX5Rhfd6LbsEF94rmy6/q1t56kEAF1ckHP6fL09huYlUU6ojZb1hIeu4X3EVinmAMjOnOGRZjIpFLxtHOSWCkf6MSKxRShPM5CBRtY4Q/TCaPyBQaXc0L9k9Aj0vjUhpnCc9h/irijbAM8Xopaux3VWLKwLsCtL1AkFZzYIH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEkJYqPZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033320; x=1737569320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BqrYUaa1QO9ojoGY2579I7UTBxGRt9Vgt4xV3xv7uE0=;
  b=nEkJYqPZr+KrB42QPncoacATn0bCLRSVSDTO1XH15Qc8CXwOyOTpoQoK
   eZC5+W5JA56UcF39aobHbEuP1HrbzNvEpd62RG92PX+oDJkP4qPepTOhq
   JHvhLsfVsy7FHEUfqMzRhhedegnj++I7mMQEx0bxywkNfx2Yq6k0vDbHo
   XVXVPT9zWvvGozn0YCV6M//48mNGNc/O/dO8tyfn9CF7ay5/1AiKEOFrd
   hYWuJwJMnwaH5YN7PjvdIO+JzPHIfrTWtu4bs48pUkcjOKaPnB7xHILTj
   Oijv4noS5+48sdDAM8cnxQUfqNuzft6wogIns4GTmdu3PdcOBFjRW+uM/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501653"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501653"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666437"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: add kunit test for devinfo ordering
Date: Tue, 23 Jan 2024 20:08:09 +0200
Message-Id: <20240123200528.a4a8af7c091f.I0fb09083317b331168b99b8db39656a126a5cc4d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We used to have a test built into the code for this internally,
but now we can put that into kunit and let everyone run it, to
verify the devinfo table ordering if it's changed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig    | 10 ++++
 drivers/net/wireless/intel/iwlwifi/Makefile   |  2 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 10 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  9 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 11 +++-
 .../net/wireless/intel/iwlwifi/tests/Makefile |  7 +++
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 54 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/tests/module.c | 10 ++++
 8 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/module.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 20971304fdef..9d6d05ec539d 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -46,6 +46,16 @@ config IWLWIFI
 
 if IWLWIFI
 
+config IWLWIFI_KUNIT_TESTS
+	tristate
+	depends on KUNIT
+	default KUNIT_ALL_TESTS || IWLWIFI_SIMULATION
+	depends on !KERNEL_6_3
+	help
+	  Enable this option for iwlwifi kunit tests.
+
+	  If unsure, say N.
+
 config IWLWIFI_LEDS
 	bool
 	depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index b983982aee45..3a2a25333d36 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -33,4 +33,6 @@ obj-$(CONFIG_IWLDVM)	+= dvm/
 obj-$(CONFIG_IWLMVM)	+= mvm/
 obj-$(CONFIG_IWLMEI)	+= mei/
 
+obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += tests/
+
 CFLAGS_iwl-devtrace.o := -I$(src)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index ae6f1cd4d660..b3c6847cccf1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -12,6 +12,7 @@
 #include <linux/ieee80211.h>
 #include <linux/nl80211.h>
 #include "iwl-csr.h"
+#include "iwl-drv.h"
 
 enum iwl_device_family {
 	IWL_DEVICE_FAMILY_UNDEFINED,
@@ -471,6 +472,15 @@ struct iwl_dev_info {
 	const char *name;
 };
 
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+extern const struct iwl_dev_info iwl_dev_info_table[];
+extern const unsigned int iwl_dev_info_table_size;
+const struct iwl_dev_info *
+iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
+		      u16 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
+		      u8 jacket, u8 rf_id, u8 no_160, u8 cores, u8 rf_step);
+#endif
+
 /*
  * This list declares the config structures for all devices.
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 3d1a27ba35c6..6a1d31892417 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -6,6 +6,7 @@
 #ifndef __iwl_drv_h__
 #define __iwl_drv_h__
 #include <linux/export.h>
+#include <kunit/visibility.h>
 
 /* for all modules */
 #define DRV_NAME        "iwlwifi"
@@ -89,6 +90,14 @@ void iwl_drv_stop(struct iwl_drv *drv);
 #define IWL_EXPORT_SYMBOL(sym)
 #endif
 
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+#define EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(sym)	EXPORT_SYMBOL_IF_KUNIT(sym)
+#define VISIBLE_IF_IWLWIFI_KUNIT
+#else
+#define EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(sym)
+#define VISIBLE_IF_IWLWIFI_KUNIT static
+#endif
+
 /* max retry for init flow */
 #define IWL_MAX_INIT_RETRY 2
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 2c9b98c8184b..cbae9503f4ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -526,7 +526,7 @@ MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,  \
 		      IWL_CFG_ANY, _cfg, _name)
 
-static const struct iwl_dev_info iwl_dev_info_table[] = {
+VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
 /* 9000 */
 	IWL_DEV_INFO(0x2526, 0x1550, iwl9260_2ac_cfg, iwl9260_killer_1550_name),
@@ -1117,6 +1117,12 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      iwl_cfg_sc, iwl_sc_name),
 #endif /* CONFIG_IWLMVM */
 };
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table);
+
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+const unsigned int iwl_dev_info_table_size = ARRAY_SIZE(iwl_dev_info_table);
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table_size);
+#endif
 
 /*
  * Read rf id and cdb info from prph register and store it
@@ -1236,7 +1242,7 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 /* PCI registers */
 #define PCI_CFG_RETRY_TIMEOUT	0x041
 
-static const struct iwl_dev_info *
+VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		      u16 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
 		      u8 jacket, u8 rf_id, u8 no_160, u8 cores, u8 rf_step)
@@ -1299,6 +1305,7 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 
 	return NULL;
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_pci_find_dev_info);
 
 static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/tests/Makefile
new file mode 100644
index 000000000000..5658471bdf0a
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/tests/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+iwlwifi-tests-y += module.o devinfo.o
+
+ccflags-y += -I$(srctree)/$(src)/../
+
+obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlwifi-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
new file mode 100644
index 000000000000..7aa47fce6e2d
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for the iwlwifi device info table
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include <kunit/test.h>
+#include "iwl-drv.h"
+#include "iwl-config.h"
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
+static void iwl_pci_print_dev_info(const char *pfx, const struct iwl_dev_info *di)
+{
+	printk(KERN_DEBUG "%sdev=%.4x,subdev=%.4x,mac_type=%.4x,mac_step=%.4x,rf_type=%.4x,cdb=%d,jacket=%d,rf_id=%.2x,no_160=%d,cores=%.2x\n",
+	       pfx, di->device, di->subdevice, di->mac_type, di->mac_step,
+	       di->rf_type, di->cdb, di->jacket, di->rf_id, di->no_160,
+	       di->cores);
+}
+
+static void devinfo_table_order(struct kunit *test)
+{
+	int idx;
+
+	for (idx = 0; idx < iwl_dev_info_table_size; idx++) {
+		const struct iwl_dev_info *di = &iwl_dev_info_table[idx];
+		const struct iwl_dev_info *ret;
+
+		ret = iwl_pci_find_dev_info(di->device, di->subdevice,
+					    di->mac_type, di->mac_step,
+					    di->rf_type, di->cdb,
+					    di->jacket, di->rf_id,
+					    di->no_160, di->cores, di->rf_step);
+		if (ret != di) {
+			iwl_pci_print_dev_info("searched: ", di);
+			iwl_pci_print_dev_info("found:    ", ret);
+			KUNIT_FAIL(test,
+				   "unusable entry at index %d (found index %d instead)\n",
+				   idx, (int)(ret - iwl_dev_info_table));
+		}
+	}
+}
+
+static struct kunit_case devinfo_test_cases[] = {
+	KUNIT_CASE(devinfo_table_order),
+	{}
+};
+
+static struct kunit_suite iwlwifi_devinfo = {
+	.name = "iwlwifi-devinfo",
+	.test_cases = devinfo_test_cases,
+};
+
+kunit_test_suite(iwlwifi_devinfo);
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/module.c b/drivers/net/wireless/intel/iwlwifi/tests/module.c
new file mode 100644
index 000000000000..0c54f818e5a7
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/tests/module.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Module boilerplate for the iwlwifi kunit module.
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include <linux/module.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("kunit tests for iwlwifi");
-- 
2.34.1



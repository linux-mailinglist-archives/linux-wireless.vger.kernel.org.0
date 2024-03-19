Return-Path: <linux-wireless+bounces-4884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811AD87F911
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F5282EB9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F507BAEC;
	Tue, 19 Mar 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0L2tUTH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FC65195
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835851; cv=none; b=uhvBisZIU0+CC6U6/iri9EclNpemqRQiNstUIwSlgf3ICfYH0l5ulhJVToEZSlEVmu5D57ZGkWdhaYgBMgac0rEDqXFs8VcCxTL+VmnTRpC2xhjM5IhvLmreMo9HlUcPMNddloPF0+kmT2d3oIrwO6I4XqBcQQCueWPUNOl0wRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835851; c=relaxed/simple;
	bh=KslKTG/WplijRbeUGf95VZRhYfbVmHi8g8kTc03aHR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYfNKgdYIgznKZ2SgboaZ4iYccVaB48eYPMBercoYQOCKPtIX7L8U9ijdjtZFhAmNi8MEfK9sI8pByyyv5RiscRIlV1zStJ8eWX7qfZH20a7EeAmJpHvObUbU06ZqNOjWV5reRMWUKwHHWwGcSeMclR8bsvkZMIoP/q3mFC9bto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0L2tUTH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835850; x=1742371850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KslKTG/WplijRbeUGf95VZRhYfbVmHi8g8kTc03aHR0=;
  b=D0L2tUTH2RbGIc3YbWL30uOS3k52R7X+W25qO0AQf58KtWDfqamyiV03
   0Je6oluPYLGvd0Fddb4HbrZmJzjD5Fl4UZLtt7IQ6+OYdA9mPA1MIYQz4
   UpwKoQqHlM+vwFIwn4HG58USG/EtQogsz1nR0Lrg1iwois2Bbx9r18wbD
   Ba9dUb9N9PVMJ+zKDc5VkyqUgiGBDc1Q0/IR9KsPhuMn6X+sRxGieEgDC
   /KEalnhMp98H8s9iYqT2xhd11NczfWHdx118Ekqcj+IOCdpvg2Em40wJy
   i90e5lqubkvHAnOaiogOVUUuueu5qgIUE7s4Cv0OnxoBhYtyZgnhI5OCp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810534"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810534"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447590"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: add a kunit test for PCI table duplicates
Date: Tue, 19 Mar 2024 10:10:16 +0200
Message-Id: <20240319100755.826b859abd62.I8140d7e9ae52ac50c6830818f8f95ccd0d94b3d3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We shouldn't have entries in the table that match the same
device; it's possible to have a specific entry followed by
a less specific entry (i.e. NNNN followed by ANY), but not
entries that are dead, where an earlier entry matches the
same as a later one.

Add a test similar to the existing devinfo test to catch
this situation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  3 ++-
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 26 ++++++++++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 6aa4f7f9c708..f1e7b15458c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/ieee80211.h>
 #include <linux/nl80211.h>
+#include <linux/mod_devicetable.h>
 #include "iwl-csr.h"
 #include "iwl-drv.h"
 
@@ -484,6 +485,7 @@ const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		      u16 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
 		      u8 jacket, u8 rf_id, u8 no_160, u8 cores, u8 rf_step);
+extern const struct pci_device_id iwl_hw_card_ids[];
 #endif
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 916d417886e8..4cf811afdfa5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -33,7 +33,7 @@ extern int _invalid_type;
 	.driver_data = _ASSIGN_CFG(cfg)
 
 /* Hardware specific file defines the PCI IDs table for that hardware module */
-static const struct pci_device_id iwl_hw_card_ids[] = {
+VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 #if IS_ENABLED(CONFIG_IWLDVM)
 	{IWL_PCI_DEVICE(0x4232, 0x1201, iwl5100_agn_cfg)}, /* Mini Card */
 	{IWL_PCI_DEVICE(0x4232, 0x1301, iwl5100_agn_cfg)}, /* Half Mini Card */
@@ -516,6 +516,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 
 #define _IWL_DEV_INFO(_device, _subdevice, _mac_type, _mac_step, _rf_type, \
 		      _rf_id, _rf_step, _no_160, _cores, _cdb, _cfg, _name) \
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 7aa47fce6e2d..7361b6d0cdb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -2,9 +2,10 @@
 /*
  * KUnit tests for the iwlwifi device info table
  *
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023-2024 Intel Corporation
  */
 #include <kunit/test.h>
+#include <linux/pci.h>
 #include "iwl-drv.h"
 #include "iwl-config.h"
 
@@ -41,8 +42,31 @@ static void devinfo_table_order(struct kunit *test)
 	}
 }
 
+static void devinfo_pci_ids(struct kunit *test)
+{
+	struct pci_dev *dev;
+
+	dev = kunit_kmalloc(test, sizeof(*dev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dev);
+
+	for (int i = 0; iwl_hw_card_ids[i].vendor; i++) {
+		const struct pci_device_id *s, *t;
+
+		s = &iwl_hw_card_ids[i];
+		dev->vendor = s->vendor;
+		dev->device = s->device;
+		dev->subsystem_vendor = s->subvendor;
+		dev->subsystem_device = s->subdevice;
+		dev->class = s->class;
+
+		t = pci_match_id(iwl_hw_card_ids, dev);
+		KUNIT_EXPECT_PTR_EQ(test, t, s);
+	}
+}
+
 static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
+	KUNIT_CASE(devinfo_pci_ids),
 	{}
 };
 
-- 
2.34.1



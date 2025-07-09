Return-Path: <linux-wireless+bounces-25064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9EDAFDF24
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3001C24F3D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D7A26B2C8;
	Wed,  9 Jul 2025 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hO/OXY+I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939C26AABE
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038231; cv=none; b=mL9KNGf9T0EcbRt3+KRgBlCeOSvULg9Q48NrRPUiqVgyehb5JV8uAxH18RTBDvSv2O+1NCyFWAlevwTZkmBnQCMe0Fo7eect2npAsW845lHO7qMHAZZFeyOGYCqB9LHjeSAAfjQHwInprER4KZNbM7OghQyWJD7smgwANFISX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038231; c=relaxed/simple;
	bh=+Q76opMAVW6h6mB1mrmNFf0nhxJJs6fO4BLjkXXXfpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fKl1FVp12ZrkTw3TUfWgU1rbjkCcXR63ouD5gwYnZ9Em912lWr2zkZ81TXORas4sc9MkUySxEvQdaXoVqndCsJLXVu2g/qGhSCUnWvAqcQGIPQD6cS5lYpxGm4cDAm/J30MPfTKjdy56aaa3tvRhNJp71YpsFvPwUjXG9mNHaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hO/OXY+I; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038230; x=1783574230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Q76opMAVW6h6mB1mrmNFf0nhxJJs6fO4BLjkXXXfpM=;
  b=hO/OXY+IY9ZqmzPU5iGhxc1aLyRdwWG+3TAv30jQEAoy0tUYs8UpGOH/
   wpSQVW8YkbjNA5fkuDZsHT/P7QbNVs+m1p/kvLqW0NnrysE3BSKTGcyar
   ylazmZ4MjUrXAqyU8eDekg/FlbEN/+RnOKaJR14P21qwKclh3rxAYnPGN
   QvVo1IGksUxj6W3pl4hWWn4Vg0U9Hhhtxzmf+TeUtMW1OiSBJDIeDSjUu
   djJdwU5xh0lJeM+UZtLFjcRd2PvvZ/v3fHNLrP6xrzn2gsRxEfD7ClNY/
   fbqrWprDHZ9iUUgvImG0QyNtAGQwdOC/9ebAcE7bjccQGf6QEh2SArGOo
   A==;
X-CSE-ConnectionGUID: +2y9HsxUR2yLIAPW56Le6A==
X-CSE-MsgGUID: ECafmbHVQm+idMAGGxrYhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091176"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091176"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:10 -0700
X-CSE-ConnectionGUID: JzsSYFTWRYK/NC2uTzzZXA==
X-CSE-MsgGUID: YXmVTKAQRty33ZPNVpqvxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327884"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v3 10/15] wifi: iwlwifi: match discrete/integrated to fix some names
Date: Wed,  9 Jul 2025 08:16:29 +0300
Message-Id: <20250709081300.e048a94659f1.Ie5919c70e9d8e3a28152aaf3cdffd19ed3d4f5c7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
References: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some device names were wrong because our internal data suggested
that discrete Ga devices have B-step RF, when they actually have
C-step. However, matching the step for them is bad anyway.

Change the code to be able to find the devinfo depending on the
device being integrated or discrete. This is only for the names,
since the RF config cannot be different for the same RF because
it's discrete or integrated, so add a kunit test that ensures
both (a) the RF config is the same and (b) the name is different
(the latter really only because that's the whole point of having
a match on the discrete/integrated bit.)

Remove the RF step matching since it's no longer needed now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  6 +--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 13 +++---
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |  2 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 45 ++++++++++++++-----
 4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 08c4f79f8335..30e5f5a5cd89 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -488,8 +488,8 @@ struct iwl_dev_info {
 	    rf_type:9,
 	    match_bw_limit:1,
 	    bw_limit:1,
-	    match_rf_step:1,
-	    rf_step:4,
+	    match_discrete:1,
+	    discrete:1,
 	    match_rf_id:1,
 	    rf_id:4,
 	    match_cdb:1,
@@ -504,7 +504,7 @@ extern const struct pci_device_id iwl_hw_card_ids[];
 
 const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
-		      u8 rf_id, u8 bw_limit, u8 rf_step);
+		      u8 rf_id, u8 bw_limit, bool discrete);
 
 /*
  * This list declares the config structures for all devices.
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 02a031433b23..0bd9b44d295b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -577,8 +577,10 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 				.subdevice_m_h = _HIGHEST_BIT(m)
 #define RF_TYPE(n)		.match_rf_type = 1,			\
 				.rf_type = IWL_CFG_RF_TYPE_##n
-#define RF_STEP(n)		.match_rf_step = 1,			\
-				.rf_step = SILICON_##n##_STEP
+#define DISCRETE		.match_discrete = 1,			\
+				.discrete = 1
+#define INTEGRATED		.match_discrete = 1,			\
+				.discrete = 0
 #define RF_ID(n)		.match_rf_id = 1,			\
 				.rf_id = IWL_CFG_RF_ID_##n
 #define NO_CDB			.match_cdb = 1, .cdb = 0
@@ -1032,9 +1034,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 /* FM RF */
 	IWL_DEV_INFO(iwl_rf_fm, iwl_be201_name, RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_rf_fm, iwl_be401_name, RF_TYPE(FM), CDB),
-	/* the discrete NICs got the RF B0, it's only for the name anyway */
 	IWL_DEV_INFO(iwl_rf_fm, iwl_be200_name, RF_TYPE(FM),
-		     DEVICE(0x272B), RF_STEP(B)),
+		     DEVICE(0x272B), DISCRETE),
 	IWL_DEV_INFO(iwl_rf_fm_160mhz, iwl_be202_name,
 		     RF_TYPE(FM), BW_LIMITED),
 
@@ -1079,7 +1080,7 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table_size);
 
 const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
-		      u8 rf_id, u8 bw_limit, u8 rf_step)
+		      u8 rf_id, u8 bw_limit, bool discrete)
 {
 	int num_devices = ARRAY_SIZE(iwl_dev_info_table);
 	int i;
@@ -1114,7 +1115,7 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device, u16 rf_type, u8 cdb,
 		if (dev_info->match_bw_limit && dev_info->bw_limit != bw_limit)
 			continue;
 
-		if (dev_info->match_rf_step && dev_info->rf_step != rf_step)
+		if (dev_info->match_discrete && dev_info->discrete != discrete)
 			continue;
 
 		return dev_info;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index ea482796c61b..5f65ab7a3fa6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4198,7 +4198,7 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 					 CSR_HW_RFID_IS_CDB(info.hw_rf_id),
 					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
 					 IWL_SUBDEVICE_BW_LIM(pdev->subsystem_device),
-					 CSR_HW_RFID_STEP(info.hw_rf_id));
+					 !iwl_trans->mac_cfg->integrated);
 	if (dev_info) {
 		iwl_trans->cfg = dev_info->cfg;
 		info.name = dev_info->name;
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 784433bb246a..4d660cef3de9 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -31,15 +31,6 @@ static void iwl_pci_print_dev_info(const char *pfx, const struct iwl_dev_info *d
 		pos += scnprintf(buf + pos, sizeof(buf) - pos,
 				 " bw_limit=*");
 
-	if (di->match_rf_step)
-		pos += scnprintf(buf + pos, sizeof(buf) - pos,
-				 " rf_step=%c",
-				 di->rf_step == SILICON_Z_STEP ? 'Z' :
-				 	'A' + di->rf_step);
-	else
-		pos += scnprintf(buf + pos, sizeof(buf) - pos,
-				 " rf_step=*");
-
 	if (di->match_rf_id)
 		pos += scnprintf(buf + pos, sizeof(buf) - pos,
 				 " rf_id=0x%x", di->rf_id);
@@ -54,6 +45,13 @@ static void iwl_pci_print_dev_info(const char *pfx, const struct iwl_dev_info *d
 		pos += scnprintf(buf + pos, sizeof(buf) - pos,
 				 " cdb=*");
 
+	if (di->match_discrete)
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " discrete=%d",
+				 di->discrete);
+	else
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				 " discrete=*");
 
 	printk(KERN_DEBUG "%sdev=%04x subdev=%04x/%04x%s\n",
 	       pfx, di->device, di->subdevice, subdevice_mask, buf);
@@ -70,7 +68,7 @@ static void devinfo_table_order(struct kunit *test)
 		ret = iwl_pci_find_dev_info(di->device, di->subdevice,
 					    di->rf_type, di->cdb,
 					    di->rf_id, di->bw_limit,
-					    di->rf_step);
+					    di->discrete);
 		if (!ret) {
 			iwl_pci_print_dev_info("No entry found for: ", di);
 			KUNIT_FAIL(test,
@@ -85,6 +83,32 @@ static void devinfo_table_order(struct kunit *test)
 	}
 }
 
+static void devinfo_discrete_match(struct kunit *test)
+{
+	/*
+	 * Validate that any entries with discrete/integrated match have
+	 * the same config with the value inverted (if they match at all.)
+	 */
+
+	for (int idx = 0; idx < iwl_dev_info_table_size; idx++) {
+		const struct iwl_dev_info *di = &iwl_dev_info_table[idx];
+		const struct iwl_dev_info *ret;
+
+		if (!di->match_discrete)
+			continue;
+
+		ret = iwl_pci_find_dev_info(di->device, di->subdevice,
+					    di->rf_type, di->cdb,
+					    di->rf_id, di->bw_limit,
+					    !di->discrete);
+		if (!ret)
+			continue;
+		KUNIT_EXPECT_PTR_EQ(test, di->cfg, ret->cfg);
+		/* and check the name is different, that'd be the point of it */
+		KUNIT_EXPECT_NE(test, strcmp(di->name, ret->name), 0);
+	}
+}
+
 static void devinfo_names(struct kunit *test)
 {
 	int idx;
@@ -216,6 +240,7 @@ static void devinfo_no_mac_cfg_dups(struct kunit *test)
 
 static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
+	KUNIT_CASE(devinfo_discrete_match),
 	KUNIT_CASE(devinfo_names),
 	KUNIT_CASE(devinfo_no_cfg_dups),
 	KUNIT_CASE(devinfo_no_name_dups),
-- 
2.34.1



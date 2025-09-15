Return-Path: <linux-wireless+bounces-27319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713A1B5730D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA04B7A957C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD552EB5D4;
	Mon, 15 Sep 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJ29uNhG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C32EFDBD
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925311; cv=none; b=SG8ZVUuB/q8KT8e4z9ozUsw8GR/OWbfIMJHtELD6r8OADqjn2PsbI55qvNOPXOZy6SeVhyZL84WGFHs3dIZq46vPcAZ3ZFmwBYtcqxaMtgHwZOEHPACfobbMdaNbSffS2+jVk9muK5zcFwQbArvPaXDBY4XNDy6t5lok2wPoaIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925311; c=relaxed/simple;
	bh=OQusjSIFIOor7VClaz14W2eq5iM6ELZSFYPAjsxsGzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jLFvGb3tHk9fewbaxYzAulsOkp3ahW4x/DDNl7zV4aXGOmjG7bGCpqAD4K1AN/w1kB96ah3r5Gx/SEkKOZP0x1s46++MQ4DdAm06A3bN4q3m0Pzu7JSL/aZPRsvwJpjWhNL04RjF4HjxYIQqvFXtGljya+3Kx7NzlWRJQxwQ5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJ29uNhG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925310; x=1789461310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OQusjSIFIOor7VClaz14W2eq5iM6ELZSFYPAjsxsGzI=;
  b=MJ29uNhGwLXXV9XAIHaNoXYY1QJlAve55G7okZSdz8iKqyWnCD6xt0X+
   rZN2lzNuUHRwjgyQ9ZYIhti0XBkf9esfI4/E4Pm8ZOG8ZUNnIV/k3r+i9
   uzfMc1ApE4vzVACU5CJM39xYFWJSfrlfKcW+0NCtUyLFaXmofYVyBbFLC
   CFVFJdvaSb7XU8E//RpejI9CP55/yXegCgFlTWEm+ml51suETq/m1fQL4
   Ve6q6hw9ZSOH7MKTdhdmOnSLXkm0wXG3IBKMARCut2umnBMmaxLdTx5PM
   ARFvGQdOoaebVBz7ZI/+1rlwan6+7T2nSQ6G1FNt6n3KFpkdS8+xltxEM
   g==;
X-CSE-ConnectionGUID: rofyLxykTHSXZx8H0kCZLw==
X-CSE-MsgGUID: pj6Lx5+3QOaKuvEyTlG8SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213079"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213079"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:10 -0700
X-CSE-ConnectionGUID: G+11PgXlQXWSlc3RfgcHSA==
X-CSE-MsgGUID: a1tIl2OHRhK/t+E3sbW9lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569894"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/11] wifi: iwlwifi: tests: check listed PCI IDs have configs
Date: Mon, 15 Sep 2025 11:34:28 +0300
Message-Id: <20250915113137.eb728b270d46.Ie5754f4201b807eb0d55feb339a728fc0b42e8bf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a test that checks, for the old pre-CNVI devices, that
PCI IDs listed in the PCI IDs table will also match in the
config table. Newer ones we test against our database of
devices, but the current database doesn't go back that far,
so at least this checks against the PCI IDs the driver has.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  1 +
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 3e6206e739f6..18c9244ee8ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -90,6 +90,7 @@ const struct iwl_mac_cfg iwl_bz_mac_cfg = {
 	.low_latency_xtal = true,
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_bz_mac_cfg);
 
 const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_BZ,
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index c31bbd4e7a4a..3054bc0a9c67 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -265,6 +265,32 @@ static void devinfo_api_range(struct kunit *test)
 	}
 }
 
+static void devinfo_pci_ids_config(struct kunit *test)
+{
+	for (int i = 0; iwl_hw_card_ids[i].vendor; i++) {
+		const struct pci_device_id *s = &iwl_hw_card_ids[i];
+		const struct iwl_dev_info *di;
+
+		if (s->device == PCI_ANY_ID || s->subdevice == PCI_ANY_ID)
+			continue;
+
+		/*
+		 * The check below only works for old (pre-CNVI) devices. Most
+		 * new have subdevice==ANY, so are already skipped, but for some
+		 * Bz platform(s) we list all the RF PCI IDs. Skip those too.
+		 */
+		if (s->driver_data == (kernel_ulong_t)&iwl_bz_mac_cfg)
+			continue;
+
+		di = iwl_pci_find_dev_info(s->device, s->subdevice,
+					   0, 0, 0, 0, true);
+
+		KUNIT_EXPECT_PTR_NE_MSG(test, di, NULL,
+					"PCI ID %04x:%04x not found\n",
+					s->device, s->subdevice);
+	}
+}
+
 static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
 	KUNIT_CASE(devinfo_discrete_match),
@@ -276,6 +302,7 @@ static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_pci_ids),
 	KUNIT_CASE(devinfo_no_mac_cfg_dups),
 	KUNIT_CASE(devinfo_api_range),
+	KUNIT_CASE(devinfo_pci_ids_config),
 	{}
 };
 
-- 
2.34.1



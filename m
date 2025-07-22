Return-Path: <linux-wireless+bounces-25830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139FBB0D4AA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315683A9B26
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7E2D8DC0;
	Tue, 22 Jul 2025 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOJTIbo6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E212DCBF7
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172992; cv=none; b=qx12ohQRU01cSeHM0VtSzDF4gOR+RXsyhMOSNDMLEUN5RFC31fQPAv6IbO9D03/BIvjtPO4k5upcQK3wLbPU1wCaXMyhzpDq60VoLFDsTtXGMozVx30bcR9d4AKewtDMuL3sXJnOrw3VdQl7jo+73vzQ2dSUcHrAkEEPBzxWUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172992; c=relaxed/simple;
	bh=JgxjcevpNvUIv/5VxzmGMBbHHgQrXOaCeCTMtvaTI90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ClnfS7EJu8hj4eYIRUffJScv6CbMfSookyQbwmxTAn04XzlS8LXPayXZQNtso5hVSXd2R8dpFPV3OWtvZImlzSJwi8auIqnEXDXmtWQA3TlwlTYHrP2DiEhdwviAjFc6eUZkjpMzI3nTBa9/NKfYTMDKgZZJfOOczyYsCmgePkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOJTIbo6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172992; x=1784708992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JgxjcevpNvUIv/5VxzmGMBbHHgQrXOaCeCTMtvaTI90=;
  b=EOJTIbo6N7cnTjuefue85ZFdGv5xSt0S8/aH4o84CFrbHvn+/sASMhAZ
   KBVKoxNFkF9JYNlm+JEGeyoWVBa3gkRzz/DXsRHjd2P4bGbVfXvLdqe7S
   vZxLyzb0vnxl0//m8yx7GAX66qnLSqBjjfX/L8a+vMYcYSQQPEbJI3WO1
   rfOb45pNt0IM37a8yhb0g0sxS2wlmKy+RQGRMeeW8sWz/6C/ZUJvr90of
   tDsNM5rws+/KhUQTtDIlAaxH0C3CafNhn0zrBJZaRKB/WK0FT01KeIsUe
   6EtWBACTkh44hzsrkaG5eAiIY5k7/C53u08iTGLScnnNLiaBIGlpRgH6Q
   w==;
X-CSE-ConnectionGUID: zQw+Nep3TMyuxyR+kvikfw==
X-CSE-MsgGUID: A1XxiGr7SvadG7nXr7MKeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569980"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569980"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:51 -0700
X-CSE-ConnectionGUID: nwXYnncLQWCFflGx18qOlw==
X-CSE-MsgGUID: ZrhTYmr1T2eagBcrtLoPTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124318"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: check validity of the FW API range
Date: Tue, 22 Jul 2025 11:29:10 +0300
Message-Id: <20250722112718.f838312a46d9.I661f347d3bb29994d8b2ec1d3f31f3383422d68a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
References: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We assume that iwl_mac_cfg and iwl_rf_cfg instances has either
both ucode_api_min and ucode_api_max set, or neither.
Validate this assumption with a Kunit test.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 4d660cef3de9..c31bbd4e7a4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -238,6 +238,33 @@ static void devinfo_no_mac_cfg_dups(struct kunit *test)
 	}
 }
 
+static void devinfo_api_range(struct kunit *test)
+{
+	/* Check that all iwl_mac_cfg's have either both min and max set, or neither */
+	for (int i = 0; iwl_hw_card_ids[i].vendor; i++) {
+		const struct iwl_mac_cfg *mac_cfg =
+			(void *)iwl_hw_card_ids[i].driver_data;
+		const struct iwl_family_base_params *base = mac_cfg->base;
+
+		KUNIT_EXPECT_EQ_MSG(test, !!base->ucode_api_min,
+				    !!base->ucode_api_max,
+				    "%ps: ucode_api_min (%u) and ucode_api_min (%u) should be both set or neither.\n",
+				    base, base->ucode_api_min,
+				    base->ucode_api_max);
+	}
+
+	/* Check the same for the iwl_rf_cfg's */
+	for (int i = 0; i < iwl_dev_info_table_size; i++) {
+		const struct iwl_rf_cfg *rf_cfg = iwl_dev_info_table[i].cfg;
+
+		KUNIT_EXPECT_EQ_MSG(test, !!rf_cfg->ucode_api_min,
+				    !!rf_cfg->ucode_api_max,
+				    "%ps: ucode_api_min (%u) and ucode_api_min (%u) should be both set or neither.\n",
+				    rf_cfg, rf_cfg->ucode_api_min,
+				    rf_cfg->ucode_api_max);
+	}
+}
+
 static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
 	KUNIT_CASE(devinfo_discrete_match),
@@ -248,6 +275,7 @@ static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_check_killer_subdev),
 	KUNIT_CASE(devinfo_pci_ids),
 	KUNIT_CASE(devinfo_no_mac_cfg_dups),
+	KUNIT_CASE(devinfo_api_range),
 	{}
 };
 
-- 
2.34.1



Return-Path: <linux-wireless+bounces-22345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64751AA72AC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0A71BC2F02
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C20254876;
	Fri,  2 May 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blRMuna5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699B254AF7
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190612; cv=none; b=PDXT/w9NQeeclRJ2WMgX4YozApcGhi1roTKSioRYcv2IdpheG87HrYjK7Cl18/Bg0au8DYHV1AGRhH65dDhr/fp8Sb8zlW7MfLuMH6oHoKS2N2qyGZstneGcvp4b+CdW8xmCW+E4aDeS4S1GV6WpcbIF7ZX53Gg/fdBef3iPgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190612; c=relaxed/simple;
	bh=eH1HAqL6c34Mfy5lvKdqkn9mtPkhVpgvGk25gj3hPJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWK50gNJb9JnwrIH3YTW5jP+Um9NpY9UV5vp6cypRXVHtuVK9BA2heIbh2QvG8qqismtLO5Rj3jBWrfw7yftWjJ3Eli9KXjeUhwpIvj/N8xxSIsnfx3QSruvCpzlh60SMjY7RPyi9OOPb7p9FXx+yUQBzCrPTwyUYuMTcJv6yQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blRMuna5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190611; x=1777726611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eH1HAqL6c34Mfy5lvKdqkn9mtPkhVpgvGk25gj3hPJc=;
  b=blRMuna5ySgOWBrwhLDquvk7a/J0rqARlf4lwbHyzC6vfUFdo0rE2TUr
   orwnC0R54A2I/tgS+8t/Z0R7gTkkjF6E6/cQhdxzw3Taluu5IwuzjrI6E
   Gl+Mp+nMixxbIPQDcFELaMiAjsheUXZSdGcPGq3J0EUPTlEm8RxwxSduB
   5gniQ77TIZqrfgskJ3ctKedaq2Gl4UZuTdZv+uG58fYgfKzQJbJ2Y8H+o
   /MCoF4QVcOXwSSxheNraKVMwNYNvslqJIYc/mus9vY1Fvh5VFgrZ9pJF/
   jnDnA4EbNldL6QC1oZxoEQ3rmbI0hqp1VkZUMXuWEvFlus7utDI7nUskg
   w==;
X-CSE-ConnectionGUID: VMVxcj4uTHa/uDz6YBzpjA==
X-CSE-MsgGUID: Tj3tTrpFS76t9alcHhZyXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255537"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255537"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:50 -0700
X-CSE-ConnectionGUID: kk7ygMV+Qq2OvzRYlyGn2A==
X-CSE-MsgGUID: i6RvAYjTQhK8NjrPiiMdwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554704"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: tests: check transport configs are not duplicated
Date: Fri,  2 May 2025 15:56:19 +0300
Message-Id: <20250502155404.a151af19aaba.Id57f099a899e09318c6218ed1859151f00232b41@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a kunit test to check that all (used) transport config structs
are not duplicated, since there's no value in having the same info
in two places in memory.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  1 -
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 48 +++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 1ecd873911bc..a9d70b58e134 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -305,6 +305,8 @@ struct iwl_fw_mon_regs {
 	struct iwl_fw_mon_reg cur_frag;
 };
 
+#define TRANS_CFG_MARKER BIT(0)
+
 /**
  * struct iwl_cfg
  * @trans: the trans-specific configuration part
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b96b85e7d5d8..83d368ef623a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -17,7 +17,6 @@
 #include "iwl-prph.h"
 #include "internal.h"
 
-#define TRANS_CFG_MARKER BIT(0)
 #define _IS_A(cfg, _struct) __builtin_types_compatible_p(typeof(cfg),	\
 							 struct _struct)
 extern int _invalid_type;
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 0de3a01001d7..de6e3eaca8cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -126,11 +126,59 @@ static void devinfo_pci_ids(struct kunit *test)
 	}
 }
 
+static void devinfo_no_trans_cfg_dups(struct kunit *test)
+{
+	/* allocate iwl_dev_info_table_size as upper bound */
+	const struct iwl_cfg_trans_params **cfgs;
+	int count = 0;
+	int p = 0;
+
+	for (int i = 0; iwl_hw_card_ids[i].vendor; i++)
+		count++;
+
+	cfgs = kunit_kcalloc(test, count, sizeof(*cfgs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cfgs);
+
+	/* build a list of unique (by pointer) configs first */
+	for (int i = 0; iwl_hw_card_ids[i].vendor; i++) {
+		struct iwl_cfg_trans_params *cfg;
+		bool found = false;
+
+		if (!(iwl_hw_card_ids[i].driver_data & TRANS_CFG_MARKER))
+			continue;
+
+		cfg = (void *)(iwl_hw_card_ids[i].driver_data &
+			       ~TRANS_CFG_MARKER);
+
+		for (int j = 0; j < p; j++) {
+			if (cfgs[j] == cfg) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			cfgs[p] = cfg;
+			p++;
+		}
+	}
+
+	/* check that they're really all different */
+	for (int i = 0; i < p; i++) {
+		for (int j = 0; j < i; j++) {
+			KUNIT_EXPECT_NE_MSG(test, memcmp(cfgs[i], cfgs[j],
+							 sizeof(*cfgs[i])), 0,
+					    "identical configs: %ps and %ps\n",
+					    cfgs[i], cfgs[j]);
+		}
+	}
+}
+
 static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
 	KUNIT_CASE(devinfo_names),
 	KUNIT_CASE(devinfo_no_cfg_dups),
 	KUNIT_CASE(devinfo_pci_ids),
+	KUNIT_CASE(devinfo_no_trans_cfg_dups),
 	{}
 };
 
-- 
2.34.1



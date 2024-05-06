Return-Path: <linux-wireless+bounces-7207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E18BC807
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7BDB2134C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965912C478;
	Mon,  6 May 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOLq6Zgu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996F6D1A3
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979104; cv=none; b=r5gTuDT5SwzOOIWqFm65iLAh8qnMgLY/9jwtPCxY6Ub1mS6SILqAnoKPYjoJvPcBkwfwkuSEu9qO03wHNwYSwyWaXSO9Xwx4LEGrqQfT41PYAM4/dQUFCmIm+SkWiFUg0Wt739xrcq7HWqM/S3INYxeEQc5ElNyVzGTMu8Zm164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979104; c=relaxed/simple;
	bh=vW38m0CmhK5Ur94Y5pn5dk44eDscKzA8VDcCYQCYfJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bs/rCw4iXfkw8KeehO/8kssh2Cgp7PvDyJhQOSVa4kyQtJPUlqF7I8qPOvQej1Pc/N3QMm9Gta8m5bv9WDTfIq/MiCRt5eLHTKp4lEw6GtfHgXcGgDt3ZyWG4X0EnZxkQrA0Qb7Pgrfi/X597BA10IrooY/6jsZ3mKQT5dVc+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOLq6Zgu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979103; x=1746515103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vW38m0CmhK5Ur94Y5pn5dk44eDscKzA8VDcCYQCYfJQ=;
  b=GOLq6ZgufLVJFxal+RUP0dqPPUNW8GYGCmq7dRZB2386/jlnU7GAkkkQ
   potHWxYzkANRvVcSuvXv1xgGZhu+QwwxE6R+P0P02dzLc79fMGclL6vdE
   lEMPTQU2J5P1UwdLNhBMB1Dogapx4DVXHmOb+H66ZPeQUS0cE1AC6OI5E
   zYQvKKb9iHqNWMfnDFJKClm2bvhwxmpQHOnXYlBcrVeXv/9tcGE+4kJaO
   rfBvA//cdVX+T5W/mopbDKsVLf9F12dcMCmYIi3kz34vk0O9j1+ShPyid
   OsAP+xKH0oPz7rD5ABX56KgT0S2eyP/9YZ+WSUfL0EYnTo5PoPN2GbCuQ
   Q==;
X-CSE-ConnectionGUID: iPcC79E/SmiNVw4x8Z35nQ==
X-CSE-MsgGUID: 5MjeDORXTtqlSBY5pBg9ZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638234"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638234"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:47 -0700
X-CSE-ConnectionGUID: lm+8EON1SPWzgJBgwrr3Kw==
X-CSE-MsgGUID: RSwR3WdATvKK+xc8dmuzjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264943"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Ofer Kimelman <ofer.kimelman@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: Force SCU_ACTIVE for specific platforms
Date: Mon,  6 May 2024 10:04:14 +0300
Message-Id: <20240506095953.3d0c56c2bb1a.I97d9da402890d2085b5698666cceffc417b6b6df@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Firmware 0x2F7 assert observed in Dell platforms when using GL HW.
This issue is mitigated by setting SCU_FORCE_ACTIVE during platform
low power states.

Driver shall indicate firmware to force SCU active by setting bit 29
in context info prph scratch control flags.
This mitigation is limited to Dell platforms with GL HW only.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ofer Kimelman <ofer.kimelman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  5 ++-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 31 ++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 1379dc2d231b..5b62933134cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018, 2020-2023 Intel Corporation
+ * Copyright (C) 2018, 2020-2024 Intel Corporation
  */
 #ifndef __iwl_context_info_file_gen3_h__
 #define __iwl_context_info_file_gen3_h__
@@ -56,6 +56,8 @@ enum iwl_prph_scratch_mtr_format {
  * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_8K: 8kB RB size
  * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_12K: 12kB RB size
  * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_16K: 16kB RB size
+ * @IWL_PRPH_SCRATCH_SCU_FORCE_ACTIVE: Indicate fw to set SCU_FORCE_ACTIVE
+ *	upon reset.
  */
 enum iwl_prph_scratch_flags {
 	IWL_PRPH_SCRATCH_IMR_DEBUG_EN		= BIT(1),
@@ -71,6 +73,7 @@ enum iwl_prph_scratch_flags {
 	IWL_PRPH_SCRATCH_RB_SIZE_EXT_8K		= 8 << 20,
 	IWL_PRPH_SCRATCH_RB_SIZE_EXT_12K	= 9 << 20,
 	IWL_PRPH_SCRATCH_RB_SIZE_EXT_16K	= 10 << 20,
+	IWL_PRPH_SCRATCH_SCU_FORCE_ACTIVE	= BIT(29),
 };
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index c8fc8b4fd85c..ebf11f276b20 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -1,13 +1,34 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
+#include <linux/dmi.h>
 #include "iwl-trans.h"
 #include "iwl-fh.h"
 #include "iwl-context-info-gen3.h"
 #include "internal.h"
 #include "iwl-prph.h"
 
+static const struct dmi_system_id dmi_force_scu_active_approved_list[] = {
+	{ .ident = "DELL",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+	},
+	{ .ident = "DELL",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+		},
+	},
+	/* keep last */
+	{}
+};
+
+static bool iwl_is_force_scu_active_approved(void)
+{
+	return !!dmi_check_system(dmi_force_scu_active_approved_list);
+}
+
 static void
 iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
 			      struct iwl_prph_scratch_hwm_cfg *dbg_cfg,
@@ -128,6 +149,14 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	if (trans->trans_cfg->imr_enabled)
 		control_flags |= IWL_PRPH_SCRATCH_IMR_DEBUG_EN;
 
+	if (CSR_HW_REV_TYPE(trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
+	    iwl_is_force_scu_active_approved()) {
+		control_flags |= IWL_PRPH_SCRATCH_SCU_FORCE_ACTIVE;
+		IWL_DEBUG_FW(trans,
+			     "Context Info: Set SCU_FORCE_ACTIVE (0x%x) in control_flags\n",
+			     IWL_PRPH_SCRATCH_SCU_FORCE_ACTIVE);
+	}
+
 	/* initialize RX default queue */
 	prph_sc_ctrl->rbd_cfg.free_rbd_addr =
 		cpu_to_le64(trans_pcie->rxq->bd_dma);
-- 
2.34.1



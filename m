Return-Path: <linux-wireless+bounces-3108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D44748490FC
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130611C21E05
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A23B190;
	Sun,  4 Feb 2024 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJBLrmyR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CD3A8F4
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084407; cv=none; b=XJur8tRiS/3zagkId4xZqhLB8HHu9iSK/7Qbt5BoVfHnkqgz8x8gaQq7AuQPehXLVOP+gcuKVDIhqSpByFfszF/aChNwuGp/oLu5WYkKeSg1oK81jP3W12rCS91JCeUQBZa6CsxMGKYbQ3/aciZTq6BvpPw8wowm0CK/qHoNeeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084407; c=relaxed/simple;
	bh=Zyd9Q0CN8v9gYy/7yTa7JukHyhwwQZoKRwEBd7Yy8Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssbpNZTkKyA/664EQ+H5WYKViDDGCA7sfJ/h0IdFTTipdVmg1NiUKUE/W03vu79TRp91X3y1Flax+b23msESpl36mw50updFPm8qgPE+RmPTogrmRn4Nz4UdirYstZpxlZN97XrymAXPMegr2o2KsJfSuhIxW3A+t6WrhK8Yrws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJBLrmyR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084406; x=1738620406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zyd9Q0CN8v9gYy/7yTa7JukHyhwwQZoKRwEBd7Yy8Qs=;
  b=kJBLrmyRI2kxmfjRo2+7l2mfNVaMoT0RLtOl3G33RrDqpV5MW9aLLcUg
   cfEVUTW+RiOseVCuzuRMEkbFihv5ZCZAsCMkRzVnxjuINHKYWSA9Mm1NB
   neImHyWXRUUK6RC9FVmfDMYGMy6baKy5TtOyWSM7jA2npCv5zwCEelf8g
   MSqT2spen1PrQLuKcpw4Zwy5iX8Ut4yeOl3tgqM0CCMpPG+T8Ufslwb4/
   fXOSZspALyt8oRN0vK3LMnGhrSgRNFoBG0VJiFndQSWpSz5a/GuoTt1we
   RcZ+jWG8QPDXgA2zL5tC7/FNDVaM1YTOL2p6n70YcYRI1CCxW0YLRGa7s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869377"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869377"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815878"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 07/15] wifi: iwlwifi: read mac step from aux register
Date: Mon,  5 Feb 2024 00:06:09 +0200
Message-Id: <20240204235836.dcc18b533f13.I0a6267fa0a142744bcf7500b45f667b596b492c5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

in BZ, the mac step is not updated to the HW REV CSR.
For BZ-I, read it from the CNVI aux register
For BZ-U always take B step.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |  6 +++++-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |  4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 14 ++++++++++++++
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index c1c7d44f421b..a7d44df06eab 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -368,7 +368,11 @@ enum {
 	WFPM_AUX_CTL_AUX_IF_MAC_OWNER_MSK	= 0x80000000,
 };
 
-#define CNVI_AUX_MISC_CHIP				0xA200B0
+#define CNVI_AUX_MISC_CHIP			0xA200B0
+#define CNVI_AUX_MISC_CHIP_MAC_STEP(_val)	(((_val) & 0xf000000) >> 24)
+#define CNVI_AUX_MISC_CHIP_PROD_TYPE(_val)	((_val) & 0xfff)
+#define CNVI_AUX_MISC_CHIP_PROD_TYPE_BZ_U	0x930
+
 #define CNVR_AUX_MISC_CHIP				0xA2B800
 #define CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM		0xA29890
 #define CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR	0xA29938
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index fa4a14546860..c8fc8b4fd85c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -119,7 +119,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 	prph_sc_ctrl->version.version = 0;
 	prph_sc_ctrl->version.mac_id =
-		cpu_to_le16((u16)iwl_read32(trans, CSR_HW_REV));
+		cpu_to_le16((u16)trans->hw_rev);
 	prph_sc_ctrl->version.size = cpu_to_le16(sizeof(*prph_scratch) / 4);
 
 	control_flags |= IWL_PRPH_SCRATCH_MTR_MODE;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 5f55efe64bf5..0fa92704cd14 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-fh.h"
@@ -180,7 +180,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 
 	ctxt_info->version.version = 0;
 	ctxt_info->version.mac_id =
-		cpu_to_le16((u16)iwl_read32(trans, CSR_HW_REV));
+		cpu_to_le16((u16)trans->hw_rev);
 	/* size is in DWs */
 	ctxt_info->version.size = cpu_to_le16(sizeof(*ctxt_info) / 4);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index bbc8dc390bdc..1ed67b76b516 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1155,6 +1155,20 @@ static void get_crf_id(struct iwl_trans *iwl_trans)
 	iwl_trans->hw_cnv_id =
 		iwl_read_prph_no_grab(iwl_trans, CNVI_AUX_MISC_CHIP);
 
+	/* In BZ, the MAC step must be read from the CNVI aux register */
+	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_BZ) {
+		u8 step = CNVI_AUX_MISC_CHIP_MAC_STEP(iwl_trans->hw_cnv_id);
+
+		/* For BZ-U, take B step also when A step is indicated */
+		if ((CNVI_AUX_MISC_CHIP_PROD_TYPE(iwl_trans->hw_cnv_id) ==
+		    CNVI_AUX_MISC_CHIP_PROD_TYPE_BZ_U) &&
+		    step == SILICON_A_STEP)
+			step = SILICON_B_STEP;
+
+		iwl_trans->hw_rev_step = step;
+		iwl_trans->hw_rev |= step;
+	}
+
 	/* Read cdb info (also contains the jacket info if needed in the future */
 	iwl_trans->hw_wfpm_id =
 		iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
-- 
2.34.1



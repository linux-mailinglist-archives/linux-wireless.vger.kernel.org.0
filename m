Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4AF7AA29C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjIUVXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjIUVXi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:23:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86664780E6
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318630; x=1726854630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zGZMClw6x2oz7yykgZP8h3q/8qu6Sk32wpUuqTdnzR0=;
  b=f+5xdX5VvRCEVhrW2xRhRgcYNNQ2g5j/GmnQNsiDJVGmbbIJTNunZjLV
   WvdyG++fEA5x+3yanpbPV5weTQqumsBXXey1H+p9RfQoqC1rgMOuU9k/f
   9VyywPjbbyRR5vjBCeMCIlbFM+MDsZcwZogQpliGCsKY794wJS4UYKqdD
   A9QXXYxlyRMRKtvDoNAulbkWdiKRco9ivD7aV/Uh9WcJGsllYVXYTWCay
   /0tB+ooF2v2DOsYJrZxYiUbmua57RQ6PwKR4P9DkD4JhMBjuerqiOhjE9
   QDS8LoSoOnnb9qIuzk42hlszJP0i8FpeHlQEVwhBjP28vntilXbYjCVvq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305319"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305319"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545533"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545533"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:51 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/12] wifi: iwlwifi: implement enable/disable for China 2022 regulatory
Date:   Thu, 21 Sep 2023 11:58:02 +0300
Message-Id: <20230921110726.ba7cb3003e53.If5a180a59ee85ed4a4c9146cfeff841c25b81066@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230921085810.693048-1-gregory.greenman@intel.com>
References: <20230921085810.693048-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

China 2022 regulations are enabled by default. Disable only when
disabled in BIOS or the firmware don't support this capability. If the
firmware has this capability, read BIOS configuration data in
function 4 using ACPI API and send GRP_REGULATORY_LARI_CONFIG_CHANGE_CMD
to the firmware. Any error while reading BIOS data results in enablement
of china 2022 regulations.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c   | 18 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h   |  5 +++++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  6 ++++--
 .../net/wireless/intel/iwlwifi/fw/debugfs.c    |  8 +++++++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h   |  3 ++-
 5 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index b26f90e52256..e83ce797a68b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1011,6 +1011,7 @@ __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
 	int ret;
 	u8 value;
+	u32 val;
 	__le32 config_bitmap = 0;
 
 	/*
@@ -1039,6 +1040,23 @@ __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 				cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
 	}
 
+	if (fw_has_capa(&fwrt->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT)) {
+		/*
+		 ** Evaluate func 'DSM_FUNC_REGULATORY_CONFIG'
+		 */
+		ret = iwl_acpi_get_dsm_u32(fwrt->dev, 0,
+					   DSM_FUNC_REGULATORY_CONFIG,
+					   &iwl_guid, &val);
+		/*
+		 * China 2022 enable if the BIOS object does not exist or
+		 * if it is enabled in BIOS.
+		 */
+		if (ret < 0 || val & DSM_MASK_CHINA_22_REG)
+			config_bitmap |=
+				cpu_to_le32(LARI_CONFIG_ENABLE_CHINA_22_REG_SUPPORT_MSK);
+	}
+
 	return config_bitmap;
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_lari_config_bitmap);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index c36c62d6414d..d129fc66d8bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -134,6 +134,7 @@ enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_DISABLE_SRD = 1,
 	DSM_FUNC_ENABLE_INDONESIA_5G2 = 2,
 	DSM_FUNC_ENABLE_6E = 3,
+	DSM_FUNC_REGULATORY_CONFIG = 4,
 	DSM_FUNC_11AX_ENABLEMENT = 6,
 	DSM_FUNC_ENABLE_UNII4_CHAN = 7,
 	DSM_FUNC_ACTIVATE_CHANNEL = 8,
@@ -164,6 +165,10 @@ enum iwl_dsm_values_rfi {
 	DSM_VALUE_RFI_MAX
 };
 
+enum iwl_dsm_masks_reg {
+	DSM_MASK_CHINA_22_REG = BIT(2)
+};
+
 #ifdef CONFIG_ACPI
 
 struct iwl_fw_runtime;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 28bfabb399b2..c4577219c501 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -480,18 +480,20 @@ union iwl_tas_config_cmd {
 	struct iwl_tas_config_cmd_v4 v4;
 };
 /**
- * enum iwl_lari_configs - bit masks for the various LARI config operations
+ * enum iwl_lari_config_masks - bit masks for the various LARI config operations
  * @LARI_CONFIG_DISABLE_11AC_UKRAINE_MSK: disable 11ac in ukraine
  * @LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK: ETSI 5.8GHz SRD passive scan
  * @LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK: ETSI 5.8GHz SRD disabled
  * @LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK: enable 5.15/5.35GHz bands in
  * 	Indonesia
+ * @LARI_CONFIG_ENABLE_CHINA_22_REG_SUPPORT_MSK: enable 2022 china regulatory
  */
 enum iwl_lari_config_masks {
 	LARI_CONFIG_DISABLE_11AC_UKRAINE_MSK		= BIT(0),
 	LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK		= BIT(1),
 	LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK		= BIT(2),
 	LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK		= BIT(3),
+	LARI_CONFIG_ENABLE_CHINA_22_REG_SUPPORT_MSK	= BIT(7),
 };
 
 #define IWL_11AX_UKRAINE_MASK 3
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 3cdbc6ac7ae5..b8d4a4d571e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -342,6 +342,12 @@ static int iwl_dbgfs_fw_info_seq_show(struct seq_file *seq, void *v)
 			   "    %d: %d\n",
 			   IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT,
 			   has_capa);
+		has_capa = fw_has_capa(&fw->ucode_capa,
+				       IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT) ? 1 : 0;
+		seq_printf(seq,
+			   "    %d: %d\n",
+			   IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT,
+			   has_capa);
 		seq_puts(seq, "fw_api_ver:\n");
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 41841524f983..7e0894ea1005 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2008-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2008-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -472,6 +472,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_OFFLOAD_BTM_SUPPORT		= (__force iwl_ucode_tlv_capa_t)113,
 	IWL_UCODE_TLV_CAPA_STA_EXP_MFP_SUPPORT		= (__force iwl_ucode_tlv_capa_t)114,
 	IWL_UCODE_TLV_CAPA_SNIFF_VALIDATE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)116,
+	IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)117,
 
 	NUM_IWL_UCODE_TLV_CAPA
 /*
-- 
2.38.1


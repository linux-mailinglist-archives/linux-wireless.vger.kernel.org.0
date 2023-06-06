Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180AB723A76
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjFFHvg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbjFFHtx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:49:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159971BE3
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037520; x=1717573520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SgNUsrKxEtgXO8noR/wQu57Z4ker2Rj26F2Spk+qLMo=;
  b=TzZvHpkDzrRoS20dgGhkIFrracFxj+9UMiuBK+fKjnRSLRegxsdQ2NW1
   VEw6yBKp3CH0oyXwbg9uZcm4i2AMBGRO7qru9XFVhgbeLusdnKwfWZ3RN
   DDV5F61BgSCJ7vZN8LmCnjLf5qppTIBWLVkVhv6ZjMaX6L4pmAXPvCCaw
   yqgU05Rx6Oja/fHUSjtrYzyORNOEPU+LbkmNSt0JJnuoJAR85gKr6cFQW
   AwYU53ST/l4mtQlDSUeGmeL+h1nGX4guyLtlzCjBPxtlTw3D2RTqsNrxc
   0Y2UNicxGbiDgaS0N4ksMql18nr6O4EzItEJ0Bfw0YTYTQvKOoWfzu6ve
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419108"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419108"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516390"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516390"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/13] wifi: iwlwifi: Separate reading and parsing of reduce power table
Date:   Tue,  6 Jun 2023 10:43:07 +0300
Message-Id: <20230606103519.71e3b3e0e794.Ifbe69ad99a7e805eb70e09280365821eb146b1c9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230606074310.889520-1-gregory.greenman@intel.com>
References: <20230606074310.889520-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alon Giladi <alon.giladi@intel.com>

It enables to better handle error cases. Also save the image till the
end of the loading and only then free it.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 40 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 31 +++++++-------
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 27 ++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +
 4 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index b556abece896..3b5a3c89fedf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -319,29 +319,39 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 
 reduce_tables:
 	/* now try to get the reduce power table, if not loaded yet */
+	if (trans->failed_to_load_reduce_power_image)
+		goto notification;
+
 	if (!trans->reduce_power_loaded) {
 		memset(&pnvm_data, 0, sizeof(pnvm_data));
-		ret = iwl_uefi_get_reduced_power(trans, &pnvm_data);
+		data = iwl_uefi_get_reduced_power(trans, &length);
+		if (IS_ERR(data)) {
+			ret = PTR_ERR(data);
+			trans->failed_to_load_reduce_power_image = true;
+			goto notification;
+		}
+
+		ret = iwl_uefi_reduce_power_parse(trans, data, length,
+						  &pnvm_data);
 		if (ret) {
-			/*
-			 * Pretend we've loaded it - at least we've tried and
-			 * couldn't load it at all, so there's no point in
-			 * trying again over and over.
-			 */
-			trans->reduce_power_loaded = true;
-		} else {
-			ret = iwl_trans_load_reduce_power(trans, &pnvm_data, capa);
-			if (ret) {
-				IWL_DEBUG_FW(trans,
-					     "Failed to load reduce power table %d\n",
-					     ret);
-				trans->reduce_power_loaded = true;
-			}
+			trans->failed_to_load_reduce_power_image = true;
 			kfree(data);
+			goto notification;
+		}
+
+		ret = iwl_trans_load_reduce_power(trans, &pnvm_data, capa);
+		kfree(data);
+		if (ret) {
+			IWL_DEBUG_FW(trans,
+				     "Failed to load reduce power table %d\n",
+				     ret);
+			trans->failed_to_load_reduce_power_image = true;
+			goto notification;
 		}
 	}
 	iwl_trans_set_reduce_power(trans, capa);
 
+notification:
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
 				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
 				   iwl_pnvm_complete_fn, trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 64b45a5b767e..1666ef3a482e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2021-2022 Intel Corporation
+ * Copyright(c) 2021-2023 Intel Corporation
  */
 
 #include "iwl-drv.h"
@@ -123,9 +123,9 @@ static int iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 	return 0;
 }
 
-static int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
-				       const u8 *data, size_t len,
-				       struct iwl_pnvm_image *pnvm_data)
+int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
+				const u8 *data, size_t len,
+				struct iwl_pnvm_image *pnvm_data)
 {
 	const struct iwl_ucode_tlv *tlv;
 
@@ -181,17 +181,15 @@ static int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 	return -ENOENT;
 }
 
-int iwl_uefi_get_reduced_power(struct iwl_trans *trans,
-			       struct iwl_pnvm_image *pnvm_data)
+u8 *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 {
 	struct pnvm_sku_package *package;
 	unsigned long package_size;
 	efi_status_t status;
-	int ret;
-	size_t len = 0;
+	u8 *data;
 
 	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 
 	/*
 	 * TODO: we hardcode a maximum length here, because reading
@@ -202,7 +200,7 @@ int iwl_uefi_get_reduced_power(struct iwl_trans *trans,
 
 	package = kmalloc(package_size, GFP_KERNEL);
 	if (!package)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	status = efi.get_variable(IWL_UEFI_REDUCED_POWER_NAME, &IWL_EFI_VAR_GUID,
 				  NULL, &package_size, package);
@@ -211,23 +209,22 @@ int iwl_uefi_get_reduced_power(struct iwl_trans *trans,
 			     "Reduced Power UEFI variable not found 0x%lx (len %lu)\n",
 			     status, package_size);
 		kfree(package);
-		return -ENOENT;
+		return ERR_PTR(-ENOENT);
 	}
 
 	IWL_DEBUG_FW(trans, "Read reduced power from UEFI with size %lu\n",
 		     package_size);
-	len = package_size;
 
 	IWL_DEBUG_FW(trans, "rev %d, total_size %d, n_skus %d\n",
 		     package->rev, package->total_size, package->n_skus);
 
-	ret = iwl_uefi_reduce_power_parse(trans, package->data,
-					  len - sizeof(*package),
-					  pnvm_data);
-
+	*len = package_size - sizeof(*package);
+	data = kmemdup(package->data, *len, GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
 	kfree(package);
 
-	return ret;
+	return data;
 }
 
 static int iwl_uefi_step_parse(struct uefi_cnv_common_step_data *common_step_data,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 03176f73151a..10bed372e67c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright(c) 2021-2022 Intel Corporation
+ * Copyright(c) 2021-2023 Intel Corporation
  */
 #ifndef __iwl_fw_uefi__
 #define __iwl_fw_uefi__
@@ -50,25 +50,32 @@ struct uefi_cnv_common_step_data {
  */
 #ifdef CONFIG_EFI
 void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len);
-int iwl_uefi_get_reduced_power(struct iwl_trans *trans,
-			       struct iwl_pnvm_image *pnvm_data);
+u8 *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len);
+int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
+				const u8 *data, size_t len,
+				struct iwl_pnvm_image *pnvm_data);
 void iwl_uefi_get_step_table(struct iwl_trans *trans);
 #else /* CONFIG_EFI */
-static inline
-void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
+static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline
-int iwl_uefi_get_reduced_power(struct iwl_trans *trans,
-			       struct iwl_pnvm_image *pnvm_data)
+static inline int
+iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
+			    const u8 *data, size_t len,
+			    struct iwl_pnvm_image *pnvm_data)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline
-void iwl_uefi_get_step_table(struct iwl_trans *trans)
+static inline u8 *
+iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void iwl_uefi_get_step_table(struct iwl_trans *trans)
 {
 }
 #endif /* CONFIG_EFI */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 61ee6c1f4a1e..2915f9b2534c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1047,6 +1047,7 @@ struct iwl_trans_txqs {
  * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
  * @fail_to_parse_pnvm_image: set to true if pnvm parsing failed
+ * @failed_to_load_reduce_power_image: set to true if pnvm loading failed
  * @wide_cmd_header: true when ucode supports wide command header format
  * @wait_command_queue: wait queue for sync commands
  * @num_rx_queues: number of RX queues allocated by the transport;
@@ -1096,6 +1097,7 @@ struct iwl_trans {
 	u8 pnvm_loaded:1;
 	u8 fail_to_parse_pnvm_image:1;
 	u8 reduce_power_loaded:1;
+	u8 failed_to_load_reduce_power_image:1;
 
 	const struct iwl_hcmd_arr *command_groups;
 	int command_groups_size;
-- 
2.38.1


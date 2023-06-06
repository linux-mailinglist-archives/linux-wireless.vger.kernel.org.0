Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56550723A64
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjFFHsd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjFFHq4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:46:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DEE2708
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037439; x=1717573439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxIXXqmm37OTDWZRVSt0hdOXEct73068IODL+TEEPBA=;
  b=OkBYngszccYvCmU2GHBMBCpRQFuSiphSoAcHv/XkDmlyC97qM9xzbgEK
   BU0cZpK6wfVldbdhUh/W9vtFI7rWQUOMFfS9Yq38fXKkZ93kFNJcd2BNq
   yiGwRxGb107z4wfx6HH0Q1FFN0wIuG3+Sazt46+jKsYGokTMK9hv4LWCG
   C8yIuQ9hEC5V2TwqfIhn6caXk6kyvhUey3jEi9hIwDGc7vtW0me8ojP+J
   vyPI69NvI4gTdWCyV5TExUV6SjE0QRRBiZLZS7FtTqDid8NPS5n194qUu
   tz1Bk9bOvm2m2jGjTHFTPic7ILk0d1SlYCbr8yKewIwq49scBUk2t/DgK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419061"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419061"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516262"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516262"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/13] wifi: iwlwifi: Take loading and setting of pnvm image out of parsing part
Date:   Tue,  6 Jun 2023 10:43:00 +0300
Message-Id: <20230606103519.504b42fc1611.I4ddf6ad76d922d118fcbcc4f0e9ec003753d0b75@changeid>
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

Change iwl_pnvm_parse so it will only save the information into the
iwl_pnvm_image struct. This enables to use the parsing code for the
power reduce tables in the future.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 130 ++++++++++--------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   4 +
 2 files changed, 73 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index f99328cc6b01..cb6a9191cf95 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2020-2022 Intel Corporation
+ * Copyright(c) 2020-2023 Intel Corporation
  */
 
 #include "iwl-drv.h"
@@ -31,17 +31,18 @@ static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
 }
 
 static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
-				   size_t len)
+				   size_t len,
+				   struct iwl_pnvm_image *pnvm_data)
 {
 	const struct iwl_ucode_tlv *tlv;
 	u32 sha1 = 0;
 	u16 mac_type = 0, rf_id = 0;
-	struct iwl_pnvm_image pnvm_data = {};
 	bool hw_match = false;
-	int ret;
 
 	IWL_DEBUG_FW(trans, "Handling PNVM section\n");
 
+	memset(pnvm_data, 0, sizeof(*pnvm_data));
+
 	while (len >= sizeof(*tlv)) {
 		u32 tlv_len, tlv_type;
 
@@ -73,6 +74,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 			IWL_DEBUG_FW(trans,
 				     "Got IWL_UCODE_TLV_PNVM_VERSION %0x\n",
 				     sha1);
+			pnvm_data->version = sha1;
 			break;
 		case IWL_UCODE_TLV_HW_TYPE:
 			if (tlv_len < 2 * sizeof(__le16)) {
@@ -110,7 +112,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 				break;
 			}
 
-			if (pnvm_data.n_chunks == IPC_DRAM_MAP_ENTRY_NUM_MAX) {
+			if (pnvm_data->n_chunks == IPC_DRAM_MAP_ENTRY_NUM_MAX) {
 				IWL_DEBUG_FW(trans,
 					     "too many payloads to allocate in DRAM.\n");
 				return -EINVAL;
@@ -119,9 +121,9 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 			IWL_DEBUG_FW(trans, "Adding data (size %d)\n",
 				     data_len);
 
-			pnvm_data.chunks[pnvm_data.n_chunks].data = section->data;
-			pnvm_data.chunks[pnvm_data.n_chunks].len = data_len;
-			pnvm_data.n_chunks++;
+			pnvm_data->chunks[pnvm_data->n_chunks].data = section->data;
+			pnvm_data->chunks[pnvm_data->n_chunks].len = data_len;
+			pnvm_data->n_chunks++;
 
 			break;
 		}
@@ -148,23 +150,17 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 		return -ENOENT;
 	}
 
-	if (!pnvm_data.n_chunks) {
+	if (!pnvm_data->n_chunks) {
 		IWL_DEBUG_FW(trans, "Empty PNVM, skipping.\n");
 		return -ENOENT;
 	}
 
-	ret = iwl_trans_load_pnvm(trans, &pnvm_data);
-	if (ret)
-		return ret;
-
-	IWL_INFO(trans, "loaded PNVM version %08x\n", sha1);
-
-	iwl_trans_set_pnvm(trans);
 	return 0;
 }
 
 static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
-			  size_t len)
+			  size_t len,
+			  struct iwl_pnvm_image *pnvm_data)
 {
 	const struct iwl_ucode_tlv *tlv;
 
@@ -205,7 +201,8 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 			    trans->sku_id[2] == le32_to_cpu(sku_id->data[2])) {
 				int ret;
 
-				ret = iwl_pnvm_handle_section(trans, data, len);
+				ret = iwl_pnvm_handle_section(trans, data, len,
+							      pnvm_data);
 				if (!ret)
 					return 0;
 			} else {
@@ -248,70 +245,81 @@ static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
 	return 0;
 }
 
+static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len)
+{
+	struct pnvm_sku_package *package;
+	u8 *image = NULL;
+
+	/* First attempt to get the PNVM from BIOS */
+	package = iwl_uefi_get_pnvm(trans_p, len);
+	if (!IS_ERR_OR_NULL(package)) {
+		if (*len >= sizeof(*package)) {
+			/* we need only the data */
+			*len -= sizeof(*package);
+			image = kmemdup(package->data, *len, GFP_KERNEL);
+		}
+		/* free package regardless of whether kmemdup succeeded */
+		kfree(package);
+		if (image)
+			return image;
+	}
+
+	/* If it's not available, try from the filesystem */
+	if (iwl_pnvm_get_from_fs(trans_p, &image, len))
+		return NULL;
+	return image;
+}
+
 int iwl_pnvm_load(struct iwl_trans *trans,
 		  struct iwl_notif_wait_data *notif_wait)
 {
 	u8 *data;
-	size_t len;
-	struct pnvm_sku_package *package;
+	size_t length;
 	struct iwl_notification_wait pnvm_wait;
 	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						PNVM_INIT_COMPLETE_NTFY) };
+	struct iwl_pnvm_image pnvm_data;
 	int ret;
 
 	/* if the SKU_ID is empty, there's nothing to do */
 	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
 		return 0;
 
-	/*
-	 * If we already loaded (or tried to load) it before, we just
-	 * need to set it again.
-	 */
-	if (trans->pnvm_loaded) {
-		iwl_trans_set_pnvm(trans);
-		goto skip_parse;
-	}
+	/* failed to get/parse the image in the past, no use to try again */
+	if (trans->fail_to_parse_pnvm_image)
+		goto reduce_tables;
 
-	/* First attempt to get the PNVM from BIOS */
-	package = iwl_uefi_get_pnvm(trans, &len);
-	if (!IS_ERR_OR_NULL(package)) {
-		if (len >= sizeof(*package)) {
-			/* we need only the data */
-			len -= sizeof(*package);
-			data = kmemdup(package->data, len, GFP_KERNEL);
-		} else {
-			data = NULL;
+	/* get the image, parse and load it, if not loaded yet */
+	if (!trans->pnvm_loaded) {
+		data = iwl_get_pnvm_image(trans, &length);
+		if (!data) {
+			trans->fail_to_parse_pnvm_image = true;
+			goto reduce_tables;
+		}
+		ret = iwl_pnvm_parse(trans, data, length, &pnvm_data);
+		if (ret) {
+			trans->fail_to_parse_pnvm_image = true;
+			kfree(data);
+			goto reduce_tables;
 		}
 
-		/* free package regardless of whether kmemdup succeeded */
-		kfree(package);
-
-		if (data)
-			goto parse;
-	}
-
-	/* If it's not available, try from the filesystem */
-	ret = iwl_pnvm_get_from_fs(trans, &data, &len);
-	if (ret) {
-		/*
-		 * Pretend we've loaded it - at least we've tried and
-		 * couldn't load it at all, so there's no point in
-		 * trying again over and over.
+		ret = iwl_trans_load_pnvm(trans, &pnvm_data);
+		/* can only free data after pvnm_data use, but
+		 * pnvm_data.version used below is not a pointer
 		 */
-		trans->pnvm_loaded = true;
-
-		goto skip_parse;
+		kfree(data);
+		if (ret)
+			goto reduce_tables;
+		IWL_INFO(trans, "loaded PNVM version %08x\n",
+			 pnvm_data.version);
 	}
 
-parse:
-	iwl_pnvm_parse(trans, data, len);
-
-	kfree(data);
+	iwl_trans_set_pnvm(trans);
 
-skip_parse:
+reduce_tables:
 	/* now try to get the reduce power table, if not loaded yet */
 	if (!trans->reduce_power_loaded) {
-		data = iwl_uefi_get_reduced_power(trans, &len);
+		data = iwl_uefi_get_reduced_power(trans, &length);
 		if (IS_ERR_OR_NULL(data)) {
 			/*
 			 * Pretend we've loaded it - at least we've tried and
@@ -320,7 +328,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 			 */
 			trans->reduce_power_loaded = true;
 		} else {
-			ret = iwl_trans_set_reduce_power(trans, data, len);
+			ret = iwl_trans_set_reduce_power(trans, data, length);
 			if (ret)
 				IWL_DEBUG_FW(trans,
 					     "Failed to set reduce power table %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a7e8d45c874c..684b57df9b48 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -466,6 +466,7 @@ struct iwl_trans_rxq_dma_data {
  * struct iwl_pnvm_image - contains info about the parsed pnvm image
  * @chunks: array of pointers to pnvm payloads and their sizes
  * @n_chunks: the number of the pnvm payloads.
+ * @version: the version of the loaded PNVM image
  */
 struct iwl_pnvm_image {
 	struct {
@@ -473,6 +474,7 @@ struct iwl_pnvm_image {
 		u32 len;
 	} chunks[IPC_DRAM_MAP_ENTRY_NUM_MAX];
 	u32 n_chunks;
+	u32 version;
 };
 
 /**
@@ -1023,6 +1025,7 @@ struct iwl_trans_txqs {
  * @hw_rev_step: The mac step of the HW
  * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
+ * @fail_to_parse_pnvm_image: set to true if pnvm parsing failed
  * @wide_cmd_header: true when ucode supports wide command header format
  * @wait_command_queue: wait queue for sync commands
  * @num_rx_queues: number of RX queues allocated by the transport;
@@ -1070,6 +1073,7 @@ struct iwl_trans {
 	bool pm_support;
 	bool ltr_enabled;
 	u8 pnvm_loaded:1;
+	u8 fail_to_parse_pnvm_image:1;
 	u8 reduce_power_loaded:1;
 
 	const struct iwl_hcmd_arr *command_groups;
-- 
2.38.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0724B1388
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbiBJQwc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:52:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244292AbiBJQwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:31 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C2B125
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:52:32 -0800 (PST)
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nICDZ-000Bxy-BH;
        Thu, 10 Feb 2022 18:22:52 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 10 Feb 2022 18:22:29 +0200
Message-Id: <iwlwifi.20220210181930.d7e1ff264766.If2327fd890a453cdc9069d26220394d0b4e79743@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210162234.285578-1-luca@coelho.fi>
References: <20220210162234.285578-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 06/11] iwlwifi: yoyo: support dump policy for the dump size
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Support dump size limitation based on the TLV by firmware.
This is needed for limited memory systems so only the most
important dumps are sent by driver.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 30 ++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 37 ++++++++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  8 ++--
 3 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 061fe6cc6cf5..55edd5ada899 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -11,7 +11,8 @@
 #define IWL_FW_INI_MAX_NAME			32
 #define IWL_FW_INI_MAX_CFG_NAME			64
 #define IWL_FW_INI_DOMAIN_ALWAYS_ON		0
-#define IWL_FW_INI_REGION_V2_MASK		0x0000FFFF
+#define IWL_FW_INI_REGION_ID_MASK		GENMASK(15, 0)
+#define IWL_FW_INI_REGION_DUMP_POLICY_MASK	GENMASK(31, 16)
 
 /**
  * struct iwl_fw_ini_hcmd
@@ -495,4 +496,31 @@ enum iwl_fw_ini_trigger_reset_fw_policy {
 	IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY,
 	IWL_FW_INI_RESET_FW_MODE_STOP_AND_RELOAD_FW
 };
+
+/**
+ * enum iwl_fw_ini_dump_policy - Determines how to handle dump based on enabled flags
+ *
+ * @IWL_FW_INI_DEBUG_DUMP_POLICY_NO_LIMIT: OS has no limit of dump size
+ * @IWL_FW_INI_DEBUG_DUMP_POLICY_MAX_LIMIT_600KB: mini dump only 600KB region dump
+ * @IWL_FW_IWL_DEBUG_DUMP_POLICY_MAX_LIMIT_5MB: mini dump 5MB size dump
+ */
+enum iwl_fw_ini_dump_policy {
+	IWL_FW_INI_DEBUG_DUMP_POLICY_NO_LIMIT           = BIT(0),
+	IWL_FW_INI_DEBUG_DUMP_POLICY_MAX_LIMIT_600KB    = BIT(1),
+	IWL_FW_IWL_DEBUG_DUMP_POLICY_MAX_LIMIT_5MB      = BIT(2),
+
+};
+
+/**
+ * enum iwl_fw_ini_dump_type - Determines dump type based on size defined by FW.
+ *
+ * @IWL_FW_INI_DUMP_BRIEF : only dump the most important regions
+ * @IWL_FW_INI_DEBUG_MEDIUM: dump more regions than "brief", but not all regions
+ * @IWL_FW_INI_DUMP_VERBOSE : dump all regions
+ */
+enum iwl_fw_ini_dump_type {
+	IWL_FW_INI_DUMP_BRIEF,
+	IWL_FW_INI_DUMP_MEDIUM,
+	IWL_FW_INI_DUMP_VERBOSE,
+};
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 238ba4384cd1..656a5e7fb4a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2096,21 +2096,40 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	struct iwl_fw_ini_error_dump_data *tlv;
 	struct iwl_fw_ini_error_dump_header *header;
 	u32 type = reg->type;
-	u32 id = le32_to_cpu(reg->id);
+	u32 id = le32_get_bits(reg->id, IWL_FW_INI_REGION_ID_MASK);
 	u32 num_of_ranges, i, size;
 	u8 *range;
 	u32 free_size;
 	u64 header_size;
+	u32 dump_policy = IWL_FW_INI_DUMP_VERBOSE;
 
-	/*
-	 * The higher part of the ID from 2 is irrelevant for
-	 * us, so mask it out.
-	 */
-	if (le32_to_cpu(reg->hdr.version) >= 2)
-		id &= IWL_FW_INI_REGION_V2_MASK;
+	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: dump type=%d, id=%d, type=%d\n",
+		     dump_policy, id, type);
 
-	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: id=%d, type=%d\n", id,
-		     type);
+	if (le32_to_cpu(reg->hdr.version) >= 2) {
+		u32 dp = le32_get_bits(reg->id,
+				       IWL_FW_INI_REGION_DUMP_POLICY_MASK);
+
+		if (dump_policy == IWL_FW_INI_DUMP_VERBOSE &&
+		    !(dp & IWL_FW_INI_DEBUG_DUMP_POLICY_NO_LIMIT)) {
+			IWL_DEBUG_FW(fwrt,
+				     "WRT: no dump - type %d and policy mismatch=%d\n",
+				     dump_policy, dp);
+			return 0;
+		} else if (dump_policy == IWL_FW_INI_DUMP_MEDIUM &&
+			   !(dp & IWL_FW_IWL_DEBUG_DUMP_POLICY_MAX_LIMIT_5MB)) {
+			IWL_DEBUG_FW(fwrt,
+				     "WRT: no dump - type %d and policy mismatch=%d\n",
+				     dump_policy, dp);
+			return 0;
+		} else if (dump_policy == IWL_FW_INI_DUMP_BRIEF &&
+			   !(dp & IWL_FW_INI_DEBUG_DUMP_POLICY_MAX_LIMIT_600KB)) {
+			IWL_DEBUG_FW(fwrt,
+				     "WRT: no dump - type %d and policy mismatch=%d\n",
+				     dump_policy, dp);
+			return 0;
+		}
+	}
 
 	if (!ops->get_num_of_ranges || !ops->get_size || !ops->fill_mem_hdr ||
 	    !ops->fill_range) {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 0cda8ac5024f..bf167bdd02cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #include <linux/firmware.h>
 #include "iwl-drv.h"
@@ -181,11 +181,11 @@ static int iwl_dbg_tlv_alloc_region(struct iwl_trans *trans,
 	u32 tlv_len = sizeof(*tlv) + le32_to_cpu(tlv->length);
 
 	/*
-	 * The higher part of the ID in from version 2 is irrelevant for
-	 * us, so mask it out.
+	 * The higher part of the ID from version 2 is debug policy.
+	 * The id will be only lsb 16 bits, so mask it out.
 	 */
 	if (le32_to_cpu(reg->hdr.version) >= 2)
-		id &= IWL_FW_INI_REGION_V2_MASK;
+		id &= IWL_FW_INI_REGION_ID_MASK;
 
 	if (le32_to_cpu(tlv->length) < sizeof(*reg))
 		return -EINVAL;
-- 
2.34.1


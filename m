Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D0B3A4E62
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFLLfS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 07:35:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47636 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231273AbhFLLfS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 07:35:18 -0400
Received: from [192.130.48.226] (helo=kveik.superpark.guest)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ls1sl-001V8i-29; Sat, 12 Jun 2021 14:32:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 12 Jun 2021 14:32:45 +0300
Message-Id: <iwlwifi.20210612142637.60dd4c60ab49.I44fe02af389d3ab089363bf9bde0d99a4c1ff383@changeid>
X-Mailer: git-send-email 2.32.0.rc2
In-Reply-To: <20210612113245.691117-1-luca@coelho.fi>
References: <20210612113245.691117-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 12/12] iwlwifi: yoyo: support region TLV version 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Region TLV version 2 now includes more data, but it is not
relevant for the driver.
In order to support this new version, just mask the new part out.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h |  3 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c         |  9 ++++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c    | 13 ++++++++++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 996d5cc5bd9a..5a2d9a1f7e73 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #ifndef __iwl_fw_dbg_tlv_h__
 #define __iwl_fw_dbg_tlv_h__
@@ -11,6 +11,7 @@
 #define IWL_FW_INI_MAX_NAME			32
 #define IWL_FW_INI_MAX_CFG_NAME			64
 #define IWL_FW_INI_DOMAIN_ALWAYS_ON		0
+#define IWL_FW_INI_REGION_V2_MASK		0x0000FFFF
 
 /**
  * struct iwl_fw_ini_hcmd
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index cc4e18ca9566..5a534d70f253 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1933,6 +1933,13 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	u32 num_of_ranges, i, size;
 	void *range;
 
+	/*
+	 * The higher part of the ID in version 2 is irrelevant for
+	 * us, so mask it out.
+	 */
+	if (le32_to_cpu(reg->hdr.version) == 2)
+		id &= IWL_FW_INI_REGION_V2_MASK;
+
 	if (!ops->get_num_of_ranges || !ops->get_size || !ops->fill_mem_hdr ||
 	    !ops->fill_range)
 		return 0;
@@ -1957,7 +1964,7 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	num_of_ranges = ops->get_num_of_ranges(fwrt, reg_data);
 
 	header = (void *)tlv->data;
-	header->region_id = reg->id;
+	header->region_id = cpu_to_le32(id);
 	header->num_of_ranges = cpu_to_le32(num_of_ranges);
 	header->name_len = cpu_to_le32(IWL_FW_INI_MAX_NAME);
 	memcpy(header->name, reg->name, IWL_FW_INI_MAX_NAME);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 4cd8c39cc3e9..0ddd255a8cc1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -57,7 +57,7 @@ dbg_ver_table[IWL_DBG_TLV_TYPE_NUM] = {
 	[IWL_DBG_TLV_TYPE_DEBUG_INFO]	= {.min_ver = 1, .max_ver = 1,},
 	[IWL_DBG_TLV_TYPE_BUF_ALLOC]	= {.min_ver = 1, .max_ver = 1,},
 	[IWL_DBG_TLV_TYPE_HCMD]		= {.min_ver = 1, .max_ver = 1,},
-	[IWL_DBG_TLV_TYPE_REGION]	= {.min_ver = 1, .max_ver = 1,},
+	[IWL_DBG_TLV_TYPE_REGION]	= {.min_ver = 1, .max_ver = 2,},
 	[IWL_DBG_TLV_TYPE_TRIGGER]	= {.min_ver = 1, .max_ver = 1,},
 };
 
@@ -178,9 +178,20 @@ static int iwl_dbg_tlv_alloc_region(struct iwl_trans *trans,
 	u32 type = le32_to_cpu(reg->type);
 	u32 tlv_len = sizeof(*tlv) + le32_to_cpu(tlv->length);
 
+	/*
+	 * The higher part of the ID in version 2 is irrelevant for
+	 * us, so mask it out.
+	 */
+	if (le32_to_cpu(reg->hdr.version) == 2)
+		id &= IWL_FW_INI_REGION_V2_MASK;
+
 	if (le32_to_cpu(tlv->length) < sizeof(*reg))
 		return -EINVAL;
 
+	/* for safe use of a string from FW, limit it to IWL_FW_INI_MAX_NAME */
+	IWL_DEBUG_FW(trans, "WRT: parsing region: %.*s\n",
+		     IWL_FW_INI_MAX_NAME, reg->name);
+
 	if (id >= IWL_FW_INI_MAX_REGION_ID) {
 		IWL_ERR(trans, "WRT: Invalid region id %u\n", id);
 		return -EINVAL;
-- 
2.32.0.rc2


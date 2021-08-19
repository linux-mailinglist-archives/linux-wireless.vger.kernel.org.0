Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D313F1D03
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbhHSPlX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:41:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56926 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240591AbhHSPlW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:41:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mGk9r-002Hje-CQ; Thu, 19 Aug 2021 18:40:45 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 19 Aug 2021 18:40:31 +0300
Message-Id: <iwlwifi.20210819183728.693c9891097d.Idcaab1fd659e8be2f56be647b2534befd61a4460@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210819154035.72584-1-luca@coelho.fi>
References: <20210819154035.72584-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 07/11] iwlwifi: fw: fix debug dump data declarations
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The debug dump ranges aren't just an array of such ranges
since each range has a variable size. Therefore, the use
of a struct array is misleading at best.

Change it to be a u8 data[] instead of the struct array,
the code doesn't significantly change since it's actually
doing things correctly now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  8 +++----
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 22 +++++++++++--------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index c1537a9515f7..f826e6c96095 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1547,7 +1547,7 @@ iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
 
 	dump->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
 
-	return dump->ranges;
+	return dump->data;
 }
 
 /**
@@ -1611,7 +1611,7 @@ iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt,
 
 	data->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
 
-	return data->ranges;
+	return data->data;
 }
 
 static void *
@@ -1647,7 +1647,7 @@ iwl_dump_ini_err_table_fill_header(struct iwl_fw_runtime *fwrt,
 	dump->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
 	dump->version = reg->err_table.version;
 
-	return dump->ranges;
+	return dump->data;
 }
 
 static void *
@@ -1662,7 +1662,7 @@ iwl_dump_ini_special_mem_fill_header(struct iwl_fw_runtime *fwrt,
 	dump->type = reg->special_mem.type;
 	dump->version = reg->special_mem.version;
 
-	return dump->ranges;
+	return dump->data;
 }
 
 static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 9fffac903b93..521ca2bb0e92 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2014, 2018-2021 Intel Corporation
  * Copyright (C) 2014-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -305,11 +305,12 @@ struct iwl_fw_ini_error_dump_header {
 /**
  * struct iwl_fw_ini_error_dump - ini region dump
  * @header: the header of this region
- * @ranges: the memory ranges of this region
+ * @data: data of memory ranges in this region,
+ *	see &struct iwl_fw_ini_error_dump_range
  */
 struct iwl_fw_ini_error_dump {
 	struct iwl_fw_ini_error_dump_header header;
-	struct iwl_fw_ini_error_dump_range ranges[];
+	u8 data[];
 } __packed;
 
 /* This bit is used to differentiate between lmac and umac rxf */
@@ -399,12 +400,13 @@ struct iwl_fw_ini_dump_info {
  * struct iwl_fw_ini_err_table_dump - ini error table dump
  * @header: header of the region
  * @version: error table version
- * @ranges: the memory ranges of this this region
+ * @data: data of memory ranges in this region,
+ *	see &struct iwl_fw_ini_error_dump_range
  */
 struct iwl_fw_ini_err_table_dump {
 	struct iwl_fw_ini_error_dump_header header;
 	__le32 version;
-	struct iwl_fw_ini_error_dump_range ranges[];
+	u8 data[];
 } __packed;
 
 /**
@@ -427,14 +429,15 @@ struct iwl_fw_error_dump_rb {
  * @write_ptr: write pointer position in the buffer
  * @cycle_cnt: cycles count
  * @cur_frag: current fragment in use
- * @ranges: the memory ranges of this this region
+ * @data: data of memory ranges in this region,
+ *	see &struct iwl_fw_ini_error_dump_range
  */
 struct iwl_fw_ini_monitor_dump {
 	struct iwl_fw_ini_error_dump_header header;
 	__le32 write_ptr;
 	__le32 cycle_cnt;
 	__le32 cur_frag;
-	struct iwl_fw_ini_error_dump_range ranges[];
+	u8 data[];
 } __packed;
 
 /**
@@ -442,13 +445,14 @@ struct iwl_fw_ini_monitor_dump {
  * @header: header of the region
  * @type: type of special memory
  * @version: struct special memory version
- * @ranges: the memory ranges of this this region
+ * @data: data of memory ranges in this region,
+ *	see &struct iwl_fw_ini_error_dump_range
  */
 struct iwl_fw_ini_special_device_memory {
 	struct iwl_fw_ini_error_dump_header header;
 	__le16 type;
 	__le16 version;
-	struct iwl_fw_ini_error_dump_range ranges[];
+	u8 data[];
 } __packed;
 
 /**
-- 
2.33.0


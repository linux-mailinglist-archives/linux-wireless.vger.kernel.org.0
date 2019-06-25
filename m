Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E087F52870
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfFYJpE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54626 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728066AbfFYJpC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0b-0007Nv-67; Tue, 25 Jun 2019 12:45:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 07/12] iwlwifi: dbg_ini: use different barker for ini dump
Date:   Tue, 25 Jun 2019 12:44:47 +0300
Message-Id: <20190625094452.19034-8-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625094452.19034-1-luca@coelho.fi>
References: <20190625094452.19034-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Use a different barker for ini dump to allow differentiation from legacy
dump. Also it allows to remove INI_BIT from dump TLVs.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 030889e3a10f..2f6881bfcde6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1690,7 +1690,7 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 
 	num_of_ranges = ops->get_num_of_ranges(fwrt, reg);
 
-	(*data)->type = cpu_to_le32(type | INI_DUMP_BIT);
+	(*data)->type = cpu_to_le32(type);
 	(*data)->len = cpu_to_le32(size);
 
 	header->region_id = reg->region_id;
@@ -1935,7 +1935,7 @@ iwl_fw_error_ini_dump_file(struct iwl_fw_runtime *fwrt,
 	if (!dump_file)
 		return NULL;
 
-	dump_file->barker = cpu_to_le32(IWL_FW_ERROR_DUMP_BARKER);
+	dump_file->barker = cpu_to_le32(IWL_FW_INI_ERROR_DUMP_BARKER);
 	dump_data = (void *)dump_file->data;
 	dump_file->file_len = cpu_to_le32(size);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 4ee9418c949b..50c5840644d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -67,6 +67,7 @@
 #include <linux/types.h>
 
 #define IWL_FW_ERROR_DUMP_BARKER	0x14789632
+#define IWL_FW_INI_ERROR_DUMP_BARKER	0x14789633
 
 /**
  * enum iwl_fw_error_dump_type - types of data in the dump file
@@ -283,9 +284,6 @@ struct iwl_fw_error_dump_mem {
  */
 #define IWL_INI_DUMP_VER 1
 
-/* This bit is used to differentiate the legacy dump from the ini dump */
-#define INI_DUMP_BIT BIT(31)
-
 /**
  * struct iwl_fw_ini_fifo_hdr - fifo range header
  * @fifo_num: the fifo number. In case of umac rx fifo, set BIT(31) to
-- 
2.20.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA72AA450
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbfIENXQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:23:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41216 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732933AbfIENXQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:23:16 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rio-00062D-9K; Thu, 05 Sep 2019 16:22:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:22:18 +0300
Message-Id: <20190905132220.23970-20-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905132220.23970-1-luca@coelho.fi>
References: <20190905132220.23970-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 19/21] iwlwifi: dbg_ini: fix dump structs doc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Fix the documentation of struct iwl_fw_ini_monitor_dump and
iwl_fw_ini_error_dump_range.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/error-dump.h   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 9529e5925ad5..2e763678dbdb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -323,10 +323,10 @@ struct iwl_fw_ini_fifo_hdr {
 /**
  * struct iwl_fw_ini_error_dump_range - range of memory
  * @range_data_size: the size of this range, in bytes
- * @internal_base_addr - base address of internal memory range
- * @dram_base_addr - base address of dram monitor range
- * @page_num - page number of memory range
- * @fifo_hdr - fifo header of memory range
+ * @internal_base_addr: base address of internal memory range
+ * @dram_base_addr: base address of dram monitor range
+ * @page_num: page number of memory range
+ * @fifo_hdr: fifo header of memory range
  * @data: the actual memory
  */
 struct iwl_fw_ini_error_dump_range {
@@ -454,10 +454,10 @@ struct iwl_fw_error_dump_rb {
 
 /**
  * struct iwl_fw_ini_monitor_dump - ini monitor dump
- * @header - header of the region
- * @write_ptr - write pointer position in the buffer
- * @cycle_cnt - cycles count
- * @ranges - the memory ranges of this this region
+ * @header: header of the region
+ * @write_ptr: write pointer position in the buffer
+ * @cycle_cnt: cycles count
+ * @ranges: the memory ranges of this this region
  */
 struct iwl_fw_ini_monitor_dump {
 	struct iwl_fw_ini_error_dump_header header;
-- 
2.23.0.rc1


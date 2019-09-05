Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3E1AA449
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388831AbfIENW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:22:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41174 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388828AbfIENW4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:22:56 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rin-00062D-K2; Thu, 05 Sep 2019 16:22:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:22:17 +0300
Message-Id: <20190905132220.23970-19-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905132220.23970-1-luca@coelho.fi>
References: <20190905132220.23970-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 18/21] iwlwifi: fw api: add DRAM buffer allocation command
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Add support code to be able to use the DRAM buffer allocation command,
which allows us to send information about a buffer to the firmware
to use it with the DBGC hardware.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 32 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index c67a6ab6491c..98e957ecbeed 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -87,6 +87,12 @@ enum iwl_debug_cmds {
 	 * 1 - suspend DBGC recording
 	 */
 	DBGC_SUSPEND_RESUME = 0x7,
+	/**
+	 * @BUFFER_ALLOCATION:
+	 * passes DRAM buffers to a DBGC
+	 * &struct iwl_buf_alloc_cmd
+	 */
+	BUFFER_ALLOCATION = 0x8,
 	/**
 	 * @MFU_ASSERT_DUMP_NTF:
 	 * &struct iwl_mfu_assert_dump_notif
@@ -361,4 +367,30 @@ struct iwl_dbg_suspend_resume_cmd {
 	__le32 operation;
 } __packed;
 
+#define BUF_ALLOC_MAX_NUM_FRAGS 16
+
+/**
+ * struct iwl_buf_alloc_frag - a DBGC fragment
+ * @addr: base address of the fragment
+ * @size: size of the fragment
+ */
+struct iwl_buf_alloc_frag {
+	__le64 addr;
+	__le32 size;
+} __packed; /* FRAGMENT_STRUCTURE_API_S_VER_1 */
+
+/**
+ * struct iwl_buf_alloc_cmd - buffer allocation command
+ * @alloc_id: &enum iwl_fw_ini_allocation_id
+ * @buf_location: &enum iwl_fw_ini_buffer_location
+ * @num_frags: number of fragments
+ * @frags: fragments array
+ */
+struct iwl_buf_alloc_cmd {
+	__le32 alloc_id;
+	__le32 buf_location;
+	__le32 num_frags;
+	struct iwl_buf_alloc_frag frags[BUF_ALLOC_MAX_NUM_FRAGS];
+} __packed; /* BUFFER_ALLOCATION_CMD_API_S_VER_2 */
+
 #endif /* __iwl_fw_api_debug_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 1bdcab9b9275..423cc0cf8e78 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -468,6 +468,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_MCC_UPDATE_11AX_SUPPORT	= (__force iwl_ucode_tlv_capa_t)89,
 	IWL_UCODE_TLV_CAPA_CSI_REPORTING		= (__force iwl_ucode_tlv_capa_t)90,
 	IWL_UCODE_TLV_CAPA_DBG_SUSPEND_RESUME_CMD_SUPP	= (__force iwl_ucode_tlv_capa_t)92,
+	IWL_UCODE_TLV_CAPA_DBG_BUF_ALLOC_CMD_SUPP	= (__force iwl_ucode_tlv_capa_t)93,
 
 	/* set 3 */
 	IWL_UCODE_TLV_CAPA_MLME_OFFLOAD			= (__force iwl_ucode_tlv_capa_t)96,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 28e836a55119..35af56acc30b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -468,6 +468,7 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
  */
 static const struct iwl_hcmd_names iwl_mvm_debug_names[] = {
 	HCMD_NAME(DBGC_SUSPEND_RESUME),
+	HCMD_NAME(BUFFER_ALLOCATION),
 	HCMD_NAME(MFU_ASSERT_DUMP_NTF),
 };
 
-- 
2.23.0.rc1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F926E1443
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDMSlb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMSla (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96B340FD
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411289; x=1712947289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yB/IxhMb9wL/5sKh7qz01VnMnn+ammT5lVr/9DrdSts=;
  b=WBJhQbjDKN2K1FsokTu0R2wW2ctBbsztUkmybGzfmmucNGxK9qK6bHrU
   YarfHqq/7nSCBRuOJ5omgEwQa3ENhwwroFMVYl0iREe3K1h49+5IrKn56
   67kANDRPqDRuTVFQNQTnj4GanfCtNZCD18Rb1oIrTwAyNp2LgAJleGlkB
   BhjHkG2MHZYYJo/Fh6uQpI+sELCq4pStd45ZKOr9JCvYLQV9EuTCmTAD5
   he1oXNJi2vdWIz60aJVUGbCLkee261xpQqhJraSioIW51y3/kpfDQnUVk
   PhHV7P6eqbVl2DzGt55Vh8t+zkeX8rFQC3Sz6xnIOuO55Kui/gESV4RnF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372126939"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372126939"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984326"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984326"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:40:51 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: dbg: print pc register data once fw dump occurred
Date:   Thu, 13 Apr 2023 21:40:21 +0300
Message-Id: <20230413213309.862790d336a9.I34e2ea05a79e8b2552f7f221bacf3af0166cb9c0@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add debug print for different FW program counter details of
different CPU. Program counter pc details will be read from
TLV during init.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c   | 11 +++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c   |  9 +++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 16 ++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c    | 10 ++++++++++
 5 files changed, 47 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 59ed321bcc27..f86f7b4baa18 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -484,6 +484,9 @@ static void iwl_fwrt_dump_fseq_regs(struct iwl_fw_runtime *fwrt)
 
 void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 {
+	struct iwl_pc_data *pc_data;
+	u8 count;
+
 	if (!test_bit(STATUS_DEVICE_ENABLED, &fwrt->trans->status)) {
 		IWL_ERR(fwrt,
 			"DEVICE_ENABLED bit is not set. Aborting dump.\n");
@@ -502,6 +505,14 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 		iwl_fwrt_dump_rcm_error_log(fwrt, 1);
 	iwl_fwrt_dump_iml_error_log(fwrt);
 	iwl_fwrt_dump_fseq_regs(fwrt);
+	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+		pc_data = fwrt->trans->dbg.pc_data;
+		for (count = 0; count < fwrt->trans->dbg.num_pc;
+		     count++, pc_data++)
+			IWL_ERR(fwrt, "%s: 0x%x\n",
+				pc_data->pc_name,
+				pc_data->pc_address);
+	}
 
 	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		u32 scratch = iwl_read32(fwrt->trans, CSR_FUNC_SCRATCH);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index f2eefca6e260..a0260a1fa099 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -101,6 +101,7 @@ enum iwl_ucode_tlv_type {
 
 	IWL_UCODE_TLV_SEC_TABLE_ADDR		= 66,
 	IWL_UCODE_TLV_D3_KEK_KCK_ADDR		= 67,
+	IWL_UCODE_TLV_CURRENT_PC		= 68,
 
 	IWL_UCODE_TLV_FW_NUM_STATIONS		= IWL_UCODE_TLV_CONST_BASE + 0,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 4c977ba9cd85..4959977a92a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -127,6 +127,7 @@ static void iwl_dealloc_ucode(struct iwl_drv *drv)
 	kfree(drv->fw.iml);
 	kfree(drv->fw.ucode_capa.cmd_versions);
 	kfree(drv->fw.phy_integration_ver);
+	kfree(drv->trans->dbg.pc_data);
 
 	for (i = 0; i < IWL_UCODE_TYPE_MAX; i++)
 		iwl_free_fw_img(drv, drv->fw.img + i);
@@ -1232,6 +1233,14 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			iwl_drv_set_dump_exclude(drv, tlv_type,
 						 tlv_data, tlv_len);
 			break;
+		case IWL_UCODE_TLV_CURRENT_PC:
+			if (tlv_len < sizeof(struct iwl_pc_data))
+				goto invalid_tlv_len;
+			drv->trans->dbg.num_pc =
+				tlv_len / sizeof(struct iwl_pc_data);
+			drv->trans->dbg.pc_data =
+				kmemdup(tlv_data, tlv_len, GFP_KERNEL);
+		break;
 		default:
 			IWL_DEBUG_INFO(drv, "unknown TLV: %d\n", tlv_type);
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index dd277a4fa8dd..74ff4788dc83 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -748,6 +748,18 @@ struct iwl_imr_data {
 	__le64 imr_base_addr;
 };
 
+#define IWL_TRANS_CURRENT_PC_NAME_MAX_BYTES      32
+
+/**
+ * struct iwl_pc_data - program counter details
+ * @pc_name: cpu name
+ * @pc_address: cpu program counter
+ */
+struct iwl_pc_data {
+	u8  pc_name[IWL_TRANS_CURRENT_PC_NAME_MAX_BYTES];
+	u32 pc_address;
+};
+
 /**
  * struct iwl_trans_debug - transport debug related data
  *
@@ -777,6 +789,8 @@ struct iwl_imr_data {
  * @ucode_preset: preset based on ucode
  * @dump_file_name_ext: dump file name extension
  * @dump_file_name_ext_valid: dump file name extension if valid or not
+ * @num_pc: number of program counter for cpu
+ * @pc_data: details of the program counter
  */
 struct iwl_trans_debug {
 	u8 n_dest_reg;
@@ -817,6 +831,8 @@ struct iwl_trans_debug {
 	struct iwl_imr_data imr_data;
 	u8 dump_file_name_ext[IWL_FW_INI_MAX_NAME];
 	bool dump_file_name_ext_valid;
+	u32 num_pc;
+	struct iwl_pc_data *pc_data;
 };
 
 struct iwl_dma_ptr {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 521eded39028..3f5cc6bf3f1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -321,6 +321,8 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	static const u16 alive_cmd[] = { UCODE_ALIVE_NTFY };
 	bool run_in_rfkill =
 		ucode_type == IWL_UCODE_INIT || iwl_mvm_has_unified_ucode(mvm);
+	u8 count;
+	struct iwl_pc_data *pc_data;
 
 	if (ucode_type == IWL_UCODE_REGULAR &&
 	    iwl_fw_dbg_conf_usniffer(mvm->fw, FW_DBG_START_FROM_ALIVE) &&
@@ -393,6 +395,14 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 
 		/* LMAC/UMAC PC info */
 		if (trans->trans_cfg->device_family >=
+					IWL_DEVICE_FAMILY_22000) {
+			pc_data = trans->dbg.pc_data;
+			for (count = 0; count < trans->dbg.num_pc;
+			     count++, pc_data++)
+				IWL_ERR(mvm, "%s: 0x%x\n",
+					pc_data->pc_name,
+					pc_data->pc_address);
+		} else if (trans->trans_cfg->device_family >=
 					IWL_DEVICE_FAMILY_9000) {
 			IWL_ERR(mvm, "UMAC PC: 0x%x\n",
 				iwl_read_umac_prph(trans,
-- 
2.38.1


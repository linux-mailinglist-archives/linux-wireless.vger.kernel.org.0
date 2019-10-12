Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6ADD50BA
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfJLPss (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 11:48:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48672 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729272AbfJLPss (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 11:48:48 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJJdM-0005yf-UR; Sat, 12 Oct 2019 18:48:45 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 18:48:24 +0300
Message-Id: <20191012184707.32c15e3f61c9.I65d0d5e782864f53b4ed8a6f43e72c50a09d9fd9@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012154828.9249-1-luca@coelho.fi>
References: <20191012154828.9249-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 12/16] iwlwifi: dbg_ini: support domain changing via debugfs
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Allow to change or read the debug domain bitmap at runtime via
fw_dbg_domain debugfs.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 37 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  5 +++
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index c1aa4360736b..7f1d299e8b0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -320,10 +320,47 @@ static ssize_t iwl_dbgfs_send_hcmd_write(struct iwl_fw_runtime *fwrt, char *buf,
 
 FWRT_DEBUGFS_WRITE_FILE_OPS(send_hcmd, 512);
 
+static ssize_t iwl_dbgfs_fw_dbg_domain_write(struct iwl_fw_runtime *fwrt,
+					     char *buf, size_t count)
+{
+	u32 new_domain;
+	long val;
+	int ret;
+
+	if (!iwl_trans_fw_running(fwrt->trans))
+		return -EIO;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	new_domain = (u32)val;
+	if (new_domain != fwrt->trans->dbg.domains_bitmap) {
+		ret = iwl_dbg_tlv_gen_active_trigs(fwrt, new_domain);
+		if (ret)
+			return ret;
+
+		iwl_dbg_tlv_time_point(fwrt, IWL_FW_INI_TIME_POINT_PERIODIC,
+				       NULL);
+	}
+
+	return count;
+}
+
+static ssize_t iwl_dbgfs_fw_dbg_domain_read(struct iwl_fw_runtime *fwrt,
+					    size_t size, char *buf)
+{
+	return scnprintf(buf, size, "0x%08x\n",
+			 fwrt->trans->dbg.domains_bitmap);
+}
+
+FWRT_DEBUGFS_READ_WRITE_FILE_OPS(fw_dbg_domain, 20);
+
 void iwl_fwrt_dbgfs_register(struct iwl_fw_runtime *fwrt,
 			    struct dentry *dbgfs_dir)
 {
 	INIT_DELAYED_WORK(&fwrt->timestamp.wk, iwl_fw_timestamp_marker_wk);
 	FWRT_DEBUGFS_ADD_FILE(timestamp_marker, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(send_hcmd, dbgfs_dir, 0200);
+	FWRT_DEBUGFS_ADD_FILE(fw_dbg_domain, dbgfs_dir, 0600);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 32e522991068..8cadad7364ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1249,6 +1249,11 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans)
 		iwl_op_mode_nic_error(trans->op_mode);
 }
 
+static inline bool iwl_trans_fw_running(struct iwl_trans *trans)
+{
+	return trans->state == IWL_TRANS_FW_ALIVE;
+}
+
 static inline void iwl_trans_sync_nmi(struct iwl_trans *trans)
 {
 	if (trans->ops->sync_nmi)
-- 
2.23.0


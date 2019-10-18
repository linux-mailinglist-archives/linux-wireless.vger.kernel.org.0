Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F868DC026
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 10:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405943AbfJRIlA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 04:41:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50154 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727903AbfJRIlA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 04:41:00 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLNog-00021q-Ty; Fri, 18 Oct 2019 11:40:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 18 Oct 2019 11:40:54 +0300
Message-Id: <20191018114032.47581f14cbb7.I65d0d5e782864f53b4ed8a6f43e72c50a09d9fd9@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014101813.7e2742c1e22f.I65d0d5e782864f53b4ed8a6f43e72c50a09d9fd9@changeid>
References: <20191014101813.7e2742c1e22f.I65d0d5e782864f53b4ed8a6f43e72c50a09d9fd9@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 03/16] iwlwifi: dbg_ini: support domain changing via debugfs
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
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 35 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  5 +++
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index c1aa4360736b..ca3b1a461dea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -320,10 +320,45 @@ static ssize_t iwl_dbgfs_send_hcmd_write(struct iwl_fw_runtime *fwrt, char *buf,
 
 FWRT_DEBUGFS_WRITE_FILE_OPS(send_hcmd, 512);
 
+static ssize_t iwl_dbgfs_fw_dbg_domain_write(struct iwl_fw_runtime *fwrt,
+					     char *buf, size_t count)
+{
+	u32 new_domain;
+	int ret;
+
+	if (!iwl_trans_fw_running(fwrt->trans))
+		return -EIO;
+
+	ret = kstrtou32(buf, 0, &new_domain);
+	if (ret)
+		return ret;
+
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


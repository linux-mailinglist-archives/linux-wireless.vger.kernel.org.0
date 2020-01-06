Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0A130EF3
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgAFIzM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:12 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51358 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgAFIzM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:12 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAI-0007qa-36; Mon, 06 Jan 2020 10:55:10 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:54:52 +0200
Message-Id: <20200106085502.363205-3-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106085502.363205-1-luca@coelho.fi>
References: <20200106085502.363205-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 02/12] iwlwifi: yoyo: don't allow changing the domain via debugfs
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We don't want to allow changing the domain via debugfs so that we can
apply the domain to all TLV types more easily (doing some at runtime
is difficult due to buffer allocations etc.).  Change the
fw_dbg_domain debugfs file to be read-only and remove the write
function.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 29 ++-----------------
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  3 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  1 -
 3 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index ca3b1a461dea..89f74116569d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -320,31 +320,6 @@ static ssize_t iwl_dbgfs_send_hcmd_write(struct iwl_fw_runtime *fwrt, char *buf,
 
 FWRT_DEBUGFS_WRITE_FILE_OPS(send_hcmd, 512);
 
-static ssize_t iwl_dbgfs_fw_dbg_domain_write(struct iwl_fw_runtime *fwrt,
-					     char *buf, size_t count)
-{
-	u32 new_domain;
-	int ret;
-
-	if (!iwl_trans_fw_running(fwrt->trans))
-		return -EIO;
-
-	ret = kstrtou32(buf, 0, &new_domain);
-	if (ret)
-		return ret;
-
-	if (new_domain != fwrt->trans->dbg.domains_bitmap) {
-		ret = iwl_dbg_tlv_gen_active_trigs(fwrt, new_domain);
-		if (ret)
-			return ret;
-
-		iwl_dbg_tlv_time_point(fwrt, IWL_FW_INI_TIME_POINT_PERIODIC,
-				       NULL);
-	}
-
-	return count;
-}
-
 static ssize_t iwl_dbgfs_fw_dbg_domain_read(struct iwl_fw_runtime *fwrt,
 					    size_t size, char *buf)
 {
@@ -352,7 +327,7 @@ static ssize_t iwl_dbgfs_fw_dbg_domain_read(struct iwl_fw_runtime *fwrt,
 			 fwrt->trans->dbg.domains_bitmap);
 }
 
-FWRT_DEBUGFS_READ_WRITE_FILE_OPS(fw_dbg_domain, 20);
+FWRT_DEBUGFS_READ_FILE_OPS(fw_dbg_domain, 20);
 
 void iwl_fwrt_dbgfs_register(struct iwl_fw_runtime *fwrt,
 			    struct dentry *dbgfs_dir)
@@ -360,5 +335,5 @@ void iwl_fwrt_dbgfs_register(struct iwl_fw_runtime *fwrt,
 	INIT_DELAYED_WORK(&fwrt->timestamp.wk, iwl_fw_timestamp_marker_wk);
 	FWRT_DEBUGFS_ADD_FILE(timestamp_marker, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(send_hcmd, dbgfs_dir, 0200);
-	FWRT_DEBUGFS_ADD_FILE(fw_dbg_domain, dbgfs_dir, 0600);
+	FWRT_DEBUGFS_ADD_FILE(fw_dbg_domain, dbgfs_dir, 0400);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index f266647dc08c..79c8c8057c2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -913,7 +913,8 @@ iwl_dbg_tlv_gen_active_trig_list(struct iwl_fw_runtime *fwrt,
 	}
 }
 
-int iwl_dbg_tlv_gen_active_trigs(struct iwl_fw_runtime *fwrt, u32 new_domain)
+static int iwl_dbg_tlv_gen_active_trigs(struct iwl_fw_runtime *fwrt,
+					u32 new_domain)
 {
 	int i;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index f18946872569..1360676b3b21 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -105,7 +105,6 @@ void iwl_dbg_tlv_init(struct iwl_trans *trans);
 void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_time_point tp_id,
 			    union iwl_dbg_tlv_tp_data *tp_data);
-int iwl_dbg_tlv_gen_active_trigs(struct iwl_fw_runtime *fwrt, u32 new_domain);
 void iwl_dbg_tlv_del_timers(struct iwl_trans *trans);
 
 #endif /* __iwl_dbg_tlv_h__*/
-- 
2.24.1


Return-Path: <linux-wireless+bounces-478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE7E806A1B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930AB281C60
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC912199D6;
	Wed,  6 Dec 2023 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jW8AEDjr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551331BF7
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852592; x=1733388592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sZp0vpaR6yvco0Yj77nO77CJ75aJ4VqgoH7o9vzET6w=;
  b=jW8AEDjrfe7u9sl4R8+V+5CDrnKRnl2XRu+sGRddRlqgE5/awTvfo2x8
   kvx66VoZw6w2aJ3pVLyrVPtaa5+PnhdjK8Kq6oBTE+KN/ArJXGHOD5P17
   FwB/YPvd+9L0XfOcTQlZp9I+mfOyxX/z7E/YFmwF4+sRHO60S4ZOeV7Um
   ZS7yWVVUnZAsZ1BJIK8DoOS/bG06PsqoIOHnU4dn4GGEufykRDoSEJQbK
   a0RkJzQL7Oge7h/1LVUVHwe85dgtlCM4OQ3FxAAt1zmNEmOI7u/mfFRN4
   6ICQkThLKdKSCUm/mqNsXABxR1vH4Z3vny4ALNdBNxgpK9QFKe1NRmfiH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916539"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916539"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575399"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575399"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:50 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 05/13] wifi: iwlwifi: mvm: add a debugfs hook to clear the monitor data
Date: Thu,  7 Dec 2023 04:50:10 +0200
Message-Id: <20231207044813.d5e97d5ec0d9.I7a5e836e6109e1fce7e6301dba8d1f28e60a5440@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This can be used by the user space when it wants to clear the data we
collected so far for privacy reasons.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c      | 10 ++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h      |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 16 ++++++++++++++++
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 7ee9b7c8a3ab..f6e399d1e95c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3395,3 +3395,13 @@ void iwl_fw_disable_dbg_asserts(struct iwl_fw_runtime *fwrt)
 	iwl_trans_send_cmd(fwrt->trans, &hcmd);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_disable_dbg_asserts);
+
+void iwl_fw_dbg_clear_monitor_buf(struct iwl_fw_runtime *fwrt)
+{
+	struct iwl_fw_dbg_params params = {0};
+
+	iwl_fw_dbg_stop_sync(fwrt);
+	iwl_dbg_tlv_init_cfg(fwrt);
+	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
+}
+IWL_EXPORT_SYMBOL(iwl_fw_dbg_clear_monitor_buf);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 66b233250c7c..eb38c686b5cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -330,6 +330,7 @@ void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
 				    u32 timepoint,
 				    u32 timepoint_data);
 void iwl_fw_disable_dbg_asserts(struct iwl_fw_runtime *fwrt);
+void iwl_fw_dbg_clear_monitor_buf(struct iwl_fw_runtime *fwrt);
 
 #define IWL_FW_CHECK_FAILED(_obj, _fmt, ...)				\
 	IWL_ERR_LIMIT(_obj, _fmt, __VA_ARGS__)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index b658cf228fbe..3b14f6476743 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1274,7 +1274,7 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 	return 0;
 }
 
-static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
+void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 {
 	enum iwl_fw_ini_buffer_location *ini_dest = &fwrt->trans->dbg.ini_dest;
 	int ret, i;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 06fb7d665390..7ed6329fd8ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -57,6 +57,7 @@ void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 			     enum iwl_fw_ini_time_point tp_id,
 			     union iwl_dbg_tlv_tp_data *tp_data,
 			     bool sync);
+void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt);
 
 static inline void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 					  enum iwl_fw_ini_time_point tp_id,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 329c545f65fd..e016fce7ab24 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1714,6 +1714,20 @@ static ssize_t iwl_dbgfs_fw_dbg_collect_write(struct iwl_mvm *mvm,
 	return count;
 }
 
+static ssize_t iwl_dbgfs_fw_dbg_clear_write(struct iwl_mvm *mvm,
+					    char *buf, size_t count,
+					    loff_t *ppos)
+{
+	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&mvm->mutex);
+	iwl_fw_dbg_clear_monitor_buf(&mvm->fwrt);
+	mutex_unlock(&mvm->mutex);
+
+	return count;
+}
+
 static ssize_t iwl_dbgfs_dbg_time_point_write(struct iwl_mvm *mvm,
 					      char *buf, size_t count,
 					      loff_t *ppos)
@@ -2166,6 +2180,7 @@ MVM_DEBUGFS_WRITE_FILE_OPS(bt_force_ant, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(scan_ant_rxchain, 8);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(fw_dbg_conf, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_dbg_collect, 64);
+MVM_DEBUGFS_WRITE_FILE_OPS(fw_dbg_clear, 64);
 MVM_DEBUGFS_WRITE_FILE_OPS(dbg_time_point, 64);
 MVM_DEBUGFS_WRITE_FILE_OPS(indirection_tbl,
 			   (IWL_RSS_INDIRECTION_TABLE_SIZE * 2));
@@ -2372,6 +2387,7 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	MVM_DEBUGFS_ADD_FILE(prph_reg, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(fw_dbg_conf, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(fw_dbg_collect, mvm->debugfs_dir, 0200);
+	MVM_DEBUGFS_ADD_FILE(fw_dbg_clear, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(dbg_time_point, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(send_echo_cmd, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(indirection_tbl, mvm->debugfs_dir, 0200);
-- 
2.34.1



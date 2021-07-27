Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E973D6FAF
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhG0Gvs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 02:51:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:21759 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235327AbhG0Gvq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 02:51:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="212104832"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="212104832"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 23:51:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="505368811"
Received: from lgeva1-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.255.198.250])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 23:51:45 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     luciano.coelho@intel.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Cc:     egrumbach@gmail.com,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v5 3/7] iwlwifi: mei: add debugfs hooks
Date:   Tue, 27 Jul 2021 09:51:30 +0300
Message-Id: <20210727065134.3902-3-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
References: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add three debugfs hooks:
* status: Check if we have a connection with the CSME
  firwmare. This hook is a read only.

* req_ownership: Send a SAP command to request ownership. This
  flow should be triggered by iwlwifi (from user space through
  vendor commands really), but being able to trigger an ownership
  request from debugfs allows us to request ownership without
  connecting afterwards. This is an "error" flow that the CSME
  firmware is designed to handle this way:
  + Grant ownership since the host asked for it
  + Wait 3 seconds to let the host connect
  + If the host didn't connect, take the device back (forcefully).
  + Don't grant any new ownership request in the following 30
  seconds.
  This debugfs hook allows us to test this flow.

* send_start_message: Restart the communication with the CSME
  firmware from the very beginning. At the very beginning (upon
  iwlwifi start), iwlmei send a special message: SAP_ME_MSG_START.
  This hook allows to send it again and this will retrigger the
  whole flow. It is important to test this restart in the middle
  of normal operation since it can happen (in case the CSME
  firmware decided to reset for example).

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 85 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index d0ddb707d4da..101ff7533af3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -10,6 +10,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mei_cl_bus.h>
 #include <linux/rcupdate.h>
+#include <linux/debugfs.h>
 #include <linux/skbuff.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
@@ -144,6 +145,7 @@ struct iwl_mei_filters {
  *	accessed without the mutex.
  * @sap_seq_no: the sequence number for the SAP messages
  * @seq_no: the sequence number for the SAP messages
+ * @dbgfs_dir: the debugfs dir entry
  */
 struct iwl_mei {
 	wait_queue_head_t get_nvm_wq;
@@ -162,6 +164,8 @@ struct iwl_mei {
 
 	atomic_t sap_seq_no;
 	atomic_t seq_no;
+
+	struct dentry *dbgfs_dir;
 };
 
 /**
@@ -1693,6 +1697,78 @@ void iwl_mei_unregister_complete(void)
 }
 EXPORT_SYMBOL_GPL(iwl_mei_unregister_complete);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
+static ssize_t
+iwl_mei_dbgfs_send_start_message_write(struct file *file,
+				       const char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	int ret;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_global_cldev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = iwl_mei_send_start(iwl_mei_global_cldev);
+
+out:
+	mutex_unlock(&iwl_mei_mutex);
+	return ret ?: count;
+}
+
+static const struct file_operations iwl_mei_dbgfs_send_start_message_ops = {
+	.write = iwl_mei_dbgfs_send_start_message_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t iwl_mei_dbgfs_req_ownership_write(struct file *file,
+						 const char __user *user_buf,
+						 size_t count, loff_t *ppos)
+{
+	iwl_mei_get_ownership();
+
+	return count;
+}
+
+static const struct file_operations iwl_mei_dbgfs_req_ownership_ops = {
+	.write = iwl_mei_dbgfs_req_ownership_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static void iwl_mei_dbgfs_register(struct iwl_mei *mei)
+{
+	mei->dbgfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	if (!mei->dbgfs_dir)
+		return;
+
+	debugfs_create_ulong("status", S_IRUSR,
+			     mei->dbgfs_dir, &iwl_mei_status);
+	debugfs_create_file("send_start_message", S_IWUSR, mei->dbgfs_dir,
+			    mei, &iwl_mei_dbgfs_send_start_message_ops);
+	debugfs_create_file("req_ownserhip", S_IWUSR, mei->dbgfs_dir,
+			    mei, &iwl_mei_dbgfs_req_ownership_ops);
+}
+
+static void iwl_mei_dbgfs_unregister(struct iwl_mei *mei)
+{
+	debugfs_remove_recursive(mei->dbgfs_dir);
+	mei->dbgfs_dir = NULL;
+}
+
+#else
+
+static void iwl_mei_dbgfs_register(struct iwl_mei *mei) {}
+static void iwl_mei_dbgfs_unregister(struct iwl_mei *mei) {}
+
+#endif /* CONFIG_DEBUG_FS */
+
 /**
  * iwl_mei_probe - the probe function called by the mei bus enumeration
  *
@@ -1731,6 +1807,8 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 	if (ret)
 		goto free_shared_mem;
 
+	iwl_mei_dbgfs_register(mei);
+
 	/*
 	 * We now have a Rx function in place, start the SAP procotol
 	 * we expect to get the SAP_ME_MSG_START_OK response later on.
@@ -1739,14 +1817,15 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 	ret = iwl_mei_send_start(cldev);
 	mutex_unlock(&iwl_mei_mutex);
 	if (ret)
-		goto disable;
+		goto debugfs_unregister;
 
 	/* must be last */
 	iwl_mei_global_cldev = cldev;
 
 	return 0;
 
-disable:
+debugfs_unregister:
+	iwl_mei_dbgfs_unregister(mei);
 	mei_cldev_disable(cldev);
 free_shared_mem:
 	iwl_mei_free_shared_mem(cldev);
@@ -1857,6 +1936,8 @@ static void iwl_mei_remove(struct mei_cl_device *cldev)
 
 	iwl_mei_free_shared_mem(cldev);
 
+	iwl_mei_dbgfs_unregister(mei);
+
 	mei_cldev_set_drvdata(cldev, NULL);
 
 	kfree(mei->nvm);
-- 
2.25.1


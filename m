Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC536E5D60
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDRJ25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjDRJ2z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8575BB0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810128; x=1713346128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LTYRzPuVSeFHU9AKrZ4Yh1BaWhWCPdN7cDAO/7dXUoY=;
  b=DZUWvKiXqNdhb6ZHIG1oh9sjAm0MK7HqPqKkntAzCDwq8/3a6Bsg0knh
   E7OOjey3KNy+tWTAdmmizKlFQg2pMGJpZt2NBV/1tHKCOh3oMD1jt4mMq
   2AnJX9nw9U6RKqsuJVGl3G1ns4raQ6e/ENYJlWfRKt9yeL0OxY/Mrv9XD
   s3xn2h2NlhpIsW0FoRLzDAK1WHOHeYIWA6rJ78W7k/T3t/cGz2hTbOVfZ
   qnu361Sd9RWJaE3uyrQn7r2a4QpmM/Z/udR77Ph8grdjS7eNTW7EQIWZK
   4dsvw0hcX+bcMofJdrQr9J6s8Afu7i6ifEpQ2fBUqbuoB4Nl0m4ApNqxK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341196"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341196"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511255"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511255"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:45 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/11] wifi: iwlwifi: mei: re-ask for ownership after it was taken by CSME
Date:   Tue, 18 Apr 2023 12:28:13 +0300
Message-Id: <20230418122405.a6c6ebc48f2d.I8a17003b86e71b3567521cc69864b9cbe9553ea9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When the host disconnects from the AP CSME takes ownership right away.
Since the driver never asks for ownership again wifi is left in rfkill
until CSME releases the NIC, although in many cases the host could
re-connect shortly after the disconnection. To allow the host to
recover from occasional disconnection, re-ask for ownership to let
the host connect again.
Allow one minute before re-asking for ownership to avoid too frequent
ownership transitions.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 67dfb77fedf7..f1e0fe806a00 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -31,6 +31,11 @@ MODULE_LICENSE("GPL");
 #define MEI_WLAN_UUID UUID_LE(0x13280904, 0x7792, 0x4fcb, \
 			      0xa1, 0xaa, 0x5e, 0x70, 0xcb, 0xb1, 0xe8, 0x65)
 
+/* After CSME takes ownership, it won't release it for 60 seconds to avoid
+ * frequent ownership transitions.
+ */
+#define MEI_OWNERSHIP_RETAKE_TIMEOUT_MS	msecs_to_jiffies(60000)
+
 /*
  * Since iwlwifi calls iwlmei without any context, hold a pointer to the
  * mei_cl_device structure here.
@@ -156,6 +161,8 @@ struct iwl_mei_filters {
  *	accessed without the mutex.
  * @netdev_work: used to defer registering and unregistering of the netdev to
  *	avoid taking the rtnl lock in the SAP messages handlers.
+ * @ownership_dwork: used to re-ask for NIC ownership after ownership was taken
+ *	by CSME or when a previous ownership request failed.
  * @sap_seq_no: the sequence number for the SAP messages
  * @seq_no: the sequence number for the SAP messages
  * @dbgfs_dir: the debugfs dir entry
@@ -179,6 +186,7 @@ struct iwl_mei {
 	bool pldr_active;
 	spinlock_t data_q_lock;
 	struct work_struct netdev_work;
+	struct delayed_work ownership_dwork;
 
 	atomic_t sap_seq_no;
 	atomic_t seq_no;
@@ -833,6 +841,8 @@ static void iwl_mei_handle_csme_taking_ownership(struct mei_cl_device *cldev,
 	} else {
 		iwl_mei_send_sap_msg(cldev,
 				     SAP_MSG_NOTIF_CSME_OWNERSHIP_CONFIRMED);
+		schedule_delayed_work(&mei->ownership_dwork,
+				      MEI_OWNERSHIP_RETAKE_TIMEOUT_MS);
 	}
 }
 
@@ -1447,7 +1457,13 @@ int iwl_mei_get_ownership(void)
 
 	ret = wait_event_timeout(mei->get_ownership_wq,
 				 mei->got_ownership, HZ / 2);
-	return (!ret) ? -ETIMEDOUT : 0;
+	if (!ret) {
+		schedule_delayed_work(&mei->ownership_dwork,
+				      MEI_OWNERSHIP_RETAKE_TIMEOUT_MS);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
 out:
 	mutex_unlock(&iwl_mei_mutex);
 	return ret;
@@ -1738,6 +1754,8 @@ void iwl_mei_device_state(bool up)
 	iwl_mei_send_sap_msg(mei->cldev,
 			     SAP_MSG_NOTIF_CSME_OWNERSHIP_CONFIRMED);
 	mei->csme_taking_ownership = false;
+	schedule_delayed_work(&mei->ownership_dwork,
+			      MEI_OWNERSHIP_RETAKE_TIMEOUT_MS);
 out:
 	mutex_unlock(&iwl_mei_mutex);
 }
@@ -1894,6 +1912,11 @@ static void iwl_mei_dbgfs_unregister(struct iwl_mei *mei) {}
 
 #endif /* CONFIG_DEBUG_FS */
 
+static void iwl_mei_ownership_dwork(struct work_struct *wk)
+{
+	iwl_mei_get_ownership();
+}
+
 #define ALLOC_SHARED_MEM_RETRY_MAX_NUM	3
 
 /*
@@ -1923,6 +1946,7 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 	init_waitqueue_head(&mei->pldr_wq);
 	spin_lock_init(&mei->data_q_lock);
 	INIT_WORK(&mei->netdev_work, iwl_mei_netdev_work);
+	INIT_DELAYED_WORK(&mei->ownership_dwork, iwl_mei_ownership_dwork);
 
 	mei_cldev_set_drvdata(cldev, mei);
 	mei->cldev = cldev;
@@ -2105,6 +2129,7 @@ static void iwl_mei_remove(struct mei_cl_device *cldev)
 	cancel_work_sync(&mei->send_csa_msg_wk);
 	cancel_delayed_work_sync(&mei->csa_throttle_end_wk);
 	cancel_work_sync(&mei->netdev_work);
+	cancel_delayed_work_sync(&mei->ownership_dwork);
 
 	/*
 	 * If someone waits for the ownership, let him know that we are going
-- 
2.38.1


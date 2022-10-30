Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D90612BC9
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Oct 2022 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJ3RSk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 13:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJ3RSg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 13:18:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE04AEB4
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667150313; x=1698686313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqe4uFJUf60/9KLFp1ym7W8/0ysf+3HQVxOIWkYPYg4=;
  b=DSDkuSWDXdfBdEVhyi/2uVsKRlLLDcjh4AsYlrt32oKF00yFFSl8svs1
   UkWyz2VclFY7PNgMm6HWfBcegDmQ9BbdysBZ1/xWtH3d1a8P9LnZB1GOz
   LAvFjErSltNQQJsz5HDkmIr+pd/btBQ1h0fhhbr6VXxiOc8n0zYm+vVn/
   cOumx4NEK4y9YFc/xUdIsVGrJkoBvceMnOjoIB8hzBRH0B8S2XdBwDmei
   as/SH0n4aKXJPpimljNrjngyPRcTwg6/2ZGmTB5QALyuNu7Ba3p57l3RU
   YYC5XQIuLf/Ir+MBpq7HZ4Qc3mxldbCQW93hGD2RdZciOqWvg1fQtfrt7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="372973243"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="372973243"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="633290259"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="633290259"
Received: from gustyuzh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.83.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:31 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 5/6] wifi: iwlwifi: mei: avoid blocking sap messages handling due to rtnl lock
Date:   Sun, 30 Oct 2022 19:17:44 +0200
Message-Id: <20221030191011.8599f2b4e9dd.I518f79e9099bf815c5f8d90235b4ce3250f59970@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221030171745.132081-1-gregory.greenman@intel.com>
References: <20221030171745.132081-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The AMT_STATE sap message handler tries to take the rtnl lock.
This means that in case the rtnl lock is already taken, sap messages
will not be processed.
When an interface is brought up, the host requests ownership from
csme. However, since the rtnl lock is already held, if there is a
pending amt state message, the host will not be able to read the
ownership confirm message because the amt state message handler
is pending. As a result, the host fails to get ownership although
csme granted it.
Fix it by moving the part that needs the rtnl lock into a dedicated
worker, so handling sap messages can continue.

Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 57 ++++++++++++-------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 64a637ef199c..c0142093c768 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -152,6 +152,8 @@ struct iwl_mei_filters {
  * @csa_throttle_end_wk: used when &csa_throttled is true
  * @data_q_lock: protects the access to the data queues which are
  *	accessed without the mutex.
+ * @netdev_work: used to defer registering and unregistering of the netdev to
+ *	avoid taking the rtnl lock in the SAP messages handlers.
  * @sap_seq_no: the sequence number for the SAP messages
  * @seq_no: the sequence number for the SAP messages
  * @dbgfs_dir: the debugfs dir entry
@@ -172,6 +174,7 @@ struct iwl_mei {
 	bool device_down;
 	struct delayed_work csa_throttle_end_wk;
 	spinlock_t data_q_lock;
+	struct work_struct netdev_work;
 
 	atomic_t sap_seq_no;
 	atomic_t seq_no;
@@ -591,6 +594,33 @@ static rx_handler_result_t iwl_mei_rx_handler(struct sk_buff **pskb)
 	return res;
 }
 
+static void iwl_mei_netdev_work(struct work_struct *wk)
+{
+	struct iwl_mei *mei =
+		container_of(wk, struct iwl_mei, netdev_work);
+	struct net_device *netdev;
+
+	/*
+	 * First take rtnl and only then the mutex to avoid an ABBA
+	 * with iwl_mei_set_netdev()
+	 */
+	rtnl_lock();
+	mutex_lock(&iwl_mei_mutex);
+
+	netdev = rcu_dereference_protected(iwl_mei_cache.netdev,
+					   lockdep_is_held(&iwl_mei_mutex));
+	if (netdev) {
+		if (mei->amt_enabled)
+			netdev_rx_handler_register(netdev, iwl_mei_rx_handler,
+						   mei);
+		else
+			netdev_rx_handler_unregister(netdev);
+	}
+
+	mutex_unlock(&iwl_mei_mutex);
+	rtnl_unlock();
+}
+
 static void
 iwl_mei_handle_rx_start_ok(struct mei_cl_device *cldev,
 			   const struct iwl_sap_me_msg_start_ok *rsp,
@@ -743,38 +773,23 @@ static void iwl_mei_handle_amt_state(struct mei_cl_device *cldev,
 				     const struct iwl_sap_msg_dw *dw)
 {
 	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
-	struct net_device *netdev;
 
-	/*
-	 * First take rtnl and only then the mutex to avoid an ABBA
-	 * with iwl_mei_set_netdev()
-	 */
-	rtnl_lock();
 	mutex_lock(&iwl_mei_mutex);
 
-	netdev = rcu_dereference_protected(iwl_mei_cache.netdev,
-					   lockdep_is_held(&iwl_mei_mutex));
-
 	if (mei->amt_enabled == !!le32_to_cpu(dw->val))
 		goto out;
 
 	mei->amt_enabled = dw->val;
 
-	if (mei->amt_enabled) {
-		if (netdev)
-			netdev_rx_handler_register(netdev, iwl_mei_rx_handler, mei);
-
+	if (mei->amt_enabled)
 		iwl_mei_set_init_conf(mei);
-	} else {
-		if (iwl_mei_cache.ops)
-			iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false);
-		if (netdev)
-			netdev_rx_handler_unregister(netdev);
-	}
+	else if (iwl_mei_cache.ops)
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false, false);
+
+	schedule_work(&mei->netdev_work);
 
 out:
 	mutex_unlock(&iwl_mei_mutex);
-	rtnl_unlock();
 }
 
 static void iwl_mei_handle_nic_owner(struct mei_cl_device *cldev,
@@ -1827,6 +1842,7 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 			  iwl_mei_csa_throttle_end_wk);
 	init_waitqueue_head(&mei->get_ownership_wq);
 	spin_lock_init(&mei->data_q_lock);
+	INIT_WORK(&mei->netdev_work, iwl_mei_netdev_work);
 
 	mei_cldev_set_drvdata(cldev, mei);
 	mei->cldev = cldev;
@@ -1989,6 +2005,7 @@ static void iwl_mei_remove(struct mei_cl_device *cldev)
 	 */
 	cancel_work_sync(&mei->send_csa_msg_wk);
 	cancel_delayed_work_sync(&mei->csa_throttle_end_wk);
+	cancel_work_sync(&mei->netdev_work);
 
 	/*
 	 * If someone waits for the ownership, let him know that we are going
-- 
2.35.3


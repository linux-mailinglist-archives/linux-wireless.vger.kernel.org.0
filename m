Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C287612BC5
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Oct 2022 18:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJ3RS2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 13:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJ3RS1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 13:18:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499422E7
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667150305; x=1698686305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vPTZ4a0XcgMebQ+iQqDZfr3C4xGhrl5i+VBCMvVGr7k=;
  b=T/CB0Mo9GbjOqbJmYGKsZzm7dij8XlezAe1LhhZUfIQTObxtRItnM5Nb
   g5E/OBDl7NrEPvgxbE/6wkYx9ofiYdSsaAOukQPKeZgt54tED6iBaBiqQ
   KU+Do8Cw7SbLOgsALiYuLKpFCD83VnpIWTuO586wv7lbWs/5gAfWf6TKp
   x2zUK8Pm59G95I9FXXM0GidM/cDuBpp/ECfXuQOZfvw6maR5xhodXw2kQ
   J9kKgPjc+mtSwOw0e5yFOdWc3RjQYUIsKrDD/4jI3KdQeJ/CP9HGnv+f2
   PCVMXrI1ZtvBlGNpebfReADTjGHzqlIuCYqz32jrGU7GuzgL925WQNAqV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="372973225"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="372973225"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="633290228"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="633290228"
Received: from gustyuzh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.83.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:23 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/6] wifi: iwlwifi: mei: make sure ownership confirmed message is sent
Date:   Sun, 30 Oct 2022 19:17:41 +0200
Message-Id: <20221030191011.b2a4c009e3e6.I7f931b7ee8b168e8ac88b11f23bff98b7ed3cb19@changeid>
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

It is possible that CSME will try to take ownership while the driver
is stopping. In this case, if the CSME takes ownership message arrives
after the driver started unregistering, the iwl_mei_cache->ops is
already invalid, so the host will not answer with the ownership
confirmed message.
Similarly, if the take ownership message arrived after the mac was
stopped or when iwl_mvm_up() failed, setting rfkill will not trigger
sending the confirm message. As a result, CSME will not take
ownership, which will result in a disconnection.

Fix it by sending the ownership confirmed message immediately in such
cases.

Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  7 +++--
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 30 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 5 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index bea61c8fb526..2e57438a70f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -448,9 +448,10 @@ void iwl_mei_host_associated(const struct iwl_mei_conn_info *conn_info,
 void iwl_mei_host_disassociated(void);
 
 /**
- * iwl_mei_device_down() - must be called when the device is down
+ * iwl_mei_device_state() - must be called when the device changes up/down state
+ * @up: true if the device is up, false otherwise.
  */
-void iwl_mei_device_down(void);
+void iwl_mei_device_state(bool up);
 
 #else
 
@@ -499,7 +500,7 @@ static inline void iwl_mei_host_associated(const struct iwl_mei_conn_info *conn_
 static inline void iwl_mei_host_disassociated(void)
 {}
 
-static inline void iwl_mei_device_down(void)
+static inline void iwl_mei_device_state(bool up)
 {}
 
 #endif /* CONFIG_IWLMEI */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 357f14626cf4..90646c54a3c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -147,6 +147,8 @@ struct iwl_mei_filters {
  *	to send CSME_OWNERSHIP_CONFIRMED when the driver completes its down
  *	flow.
  * @link_prot_state: true when we are in link protection PASSIVE
+ * @device_down: true if the device is down. Used to remember to send
+ *	CSME_OWNERSHIP_CONFIRMED when the driver is already down.
  * @csa_throttle_end_wk: used when &csa_throttled is true
  * @data_q_lock: protects the access to the data queues which are
  *	accessed without the mutex.
@@ -167,6 +169,7 @@ struct iwl_mei {
 	bool csa_throttled;
 	bool csme_taking_ownership;
 	bool link_prot_state;
+	bool device_down;
 	struct delayed_work csa_throttle_end_wk;
 	spinlock_t data_q_lock;
 
@@ -798,14 +801,18 @@ static void iwl_mei_handle_csme_taking_ownership(struct mei_cl_device *cldev,
 
 	mei->got_ownership = false;
 
-	/*
-	 * Remember to send CSME_OWNERSHIP_CONFIRMED when the wifi driver
-	 * is finished taking the device down.
-	 */
-	mei->csme_taking_ownership = true;
+	if (iwl_mei_cache.ops && !mei->device_down) {
+		/*
+		 * Remember to send CSME_OWNERSHIP_CONFIRMED when the wifi
+		 * driver is finished taking the device down.
+		 */
+		mei->csme_taking_ownership = true;
 
-	if (iwl_mei_cache.ops)
-		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, true);
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, true, true);
+	} else {
+		iwl_mei_send_sap_msg(cldev,
+				     SAP_MSG_NOTIF_CSME_OWNERSHIP_CONFIRMED);
+	}
 }
 
 static void iwl_mei_handle_nvm(struct mei_cl_device *cldev,
@@ -1616,7 +1623,7 @@ void iwl_mei_set_netdev(struct net_device *netdev)
 }
 EXPORT_SYMBOL_GPL(iwl_mei_set_netdev);
 
-void iwl_mei_device_down(void)
+void iwl_mei_device_state(bool up)
 {
 	struct iwl_mei *mei;
 
@@ -1630,7 +1637,9 @@ void iwl_mei_device_down(void)
 	if (!mei)
 		goto out;
 
-	if (!mei->csme_taking_ownership)
+	mei->device_down = !up;
+
+	if (up || !mei->csme_taking_ownership)
 		goto out;
 
 	iwl_mei_send_sap_msg(mei->cldev,
@@ -1639,7 +1648,7 @@ void iwl_mei_device_down(void)
 out:
 	mutex_unlock(&iwl_mei_mutex);
 }
-EXPORT_SYMBOL_GPL(iwl_mei_device_down);
+EXPORT_SYMBOL_GPL(iwl_mei_device_state);
 
 int iwl_mei_register(void *priv, const struct iwl_mei_ops *ops)
 {
@@ -1821,6 +1830,7 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 
 	mei_cldev_set_drvdata(cldev, mei);
 	mei->cldev = cldev;
+	mei->device_down = true;
 
 	do {
 		ret = iwl_mei_alloc_shared_mem(cldev);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f041e77af059..5de34edc51fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1665,6 +1665,8 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 			iwl_rfi_send_config_cmd(mvm, NULL);
 	}
 
+	iwl_mvm_mei_device_state(mvm, true);
+
 	IWL_DEBUG_INFO(mvm, "RT uCode started.\n");
 	return 0;
  error:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 97cba526e465..1ccb3cad7cdc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2201,10 +2201,10 @@ static inline void iwl_mvm_mei_host_disassociated(struct iwl_mvm *mvm)
 		iwl_mei_host_disassociated();
 }
 
-static inline void iwl_mvm_mei_device_down(struct iwl_mvm *mvm)
+static inline void iwl_mvm_mei_device_state(struct iwl_mvm *mvm, bool up)
 {
 	if (mvm->mei_registered)
-		iwl_mei_device_down();
+		iwl_mei_device_state(up);
 }
 
 static inline void iwl_mvm_mei_set_sw_rfkill_state(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d2d42cd48af2..5b8e9a06f6d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1375,7 +1375,7 @@ void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 	iwl_trans_stop_device(mvm->trans);
 	iwl_free_fw_paging(&mvm->fwrt);
 	iwl_fw_dump_conf_clear(&mvm->fwrt);
-	iwl_mvm_mei_device_down(mvm);
+	iwl_mvm_mei_device_state(mvm, false);
 }
 
 static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
-- 
2.35.3


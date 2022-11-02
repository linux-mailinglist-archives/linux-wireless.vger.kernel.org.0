Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E4861657D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKBPBL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKBPBJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:01:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDC42982B
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401267; x=1698937267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUbbjCUd2bUgYppN3XKvDx223/HTBuq83aak/pLXxlk=;
  b=Tcgye4v26M4Ab5A6L+gh0fn5ibmAABYBz0uWht3lAGc5i8gslk76FKGx
   kD0Ql4xX2npnjXghKPMVAacOFVavHXNAhZTUaaQd99EcyvS9Dh+XLeA7I
   KDQsEKyA2k4N/cbSGXhrlPP4iJyspsdXJzd/XRwJKq1nMBM0XkNA8EojR
   Nmi33bclHthLVJdmvD5Zh0Kcz3T5uTQb8MhCkdFZnq6oV60raa3eqkqIq
   bua+kqMmy1RnxL5MlllGcWenw5FqLcsIR69uMFkUoMscjrHNPP0V64ntj
   QrVHafeSQb3MEN5AUl3/yKfmkKrFcMhoj5E+kdeLSb/tz3Jda1pPFe8AH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523559"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523559"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810661"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810661"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:53 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/11] wifi: iwlwifi: mei: implement PLDR flow
Date:   Wed,  2 Nov 2022 16:59:55 +0200
Message-Id: <20221102165239.49eb8c6d455f.I7f0a5debb2d3d662a4151199bbec24613f324c13@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102145958.342864-1-gregory.greenman@intel.com>
References: <20221102145958.342864-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

If the FW needs to do OTP re-read, the driver must notify CSME before
loading the FW so CSME will not try to access the NIC during the
re-read. Once the alive notification is received, CSME is notified
that NIC access is allowed again.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   4 +
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  21 ++++
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 100 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mei/sap.h  |  51 +++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   7 ++
 5 files changed, 183 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 157d1f31c487..82cf904e0b6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -377,6 +377,7 @@ enum {
 #define PREG_PRPH_WPROT_22000		0xA04D00
 
 #define SB_MODIFY_CFG_FLAG		0xA03088
+#define SB_CFG_RESIDES_IN_OTP_MASK	0x10
 #define SB_CPU_1_STATUS			0xA01E30
 #define SB_CPU_2_STATUS			0xA01E34
 #define UMAG_SB_CPU_1_STATUS		0xA038C0
@@ -500,4 +501,7 @@ enum {
 
 #define REG_OTP_MINOR 0xA0333C
 
+#define WFPM_LMAC2_PD_NOTIFICATION 0xA033CC
+#define WFPM_LMAC2_PD_RE_READ BIT(31)
+
 #endif				/* __iwl_prph_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index 2e57438a70f0..2b639eef595d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -453,6 +453,21 @@ void iwl_mei_host_disassociated(void);
  */
 void iwl_mei_device_state(bool up);
 
+/**
+ * iwl_mei_pldr_req() - must be called before loading the fw
+ *
+ * Return: 0 if the PLDR flow was successful and the fw can be loaded, negative
+ *	value otherwise.
+ */
+int iwl_mei_pldr_req(void);
+
+/**
+ * iwl_mei_alive_notif() - must be called when alive notificaiton is received
+ * @success: true if received alive notification, false if waiting for the
+ *	notificaiton timed out.
+ */
+void iwl_mei_alive_notif(bool success);
+
 #else
 
 static inline bool iwl_mei_is_connected(void)
@@ -503,6 +518,12 @@ static inline void iwl_mei_host_disassociated(void)
 static inline void iwl_mei_device_state(bool up)
 {}
 
+static inline int iwl_mei_pldr_req(void)
+{ return 0; }
+
+static inline void iwl_mei_alive_notif(bool success)
+{}
+
 #endif /* CONFIG_IWLMEI */
 
 #endif /* __iwl_mei_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index c0142093c768..a467da8b2aed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -150,6 +150,8 @@ struct iwl_mei_filters {
  * @device_down: true if the device is down. Used to remember to send
  *	CSME_OWNERSHIP_CONFIRMED when the driver is already down.
  * @csa_throttle_end_wk: used when &csa_throttled is true
+ * @pldr_wq: the wait queue for PLDR flow
+ * @pldr_active: PLDR flow is in progress
  * @data_q_lock: protects the access to the data queues which are
  *	accessed without the mutex.
  * @netdev_work: used to defer registering and unregistering of the netdev to
@@ -173,6 +175,8 @@ struct iwl_mei {
 	bool link_prot_state;
 	bool device_down;
 	struct delayed_work csa_throttle_end_wk;
+	wait_queue_head_t pldr_wq;
+	bool pldr_active;
 	spinlock_t data_q_lock;
 	struct work_struct netdev_work;
 
@@ -881,6 +885,15 @@ static void iwl_mei_handle_rx_host_own_req(struct mei_cl_device *cldev,
 		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false);
 }
 
+static void iwl_mei_handle_pldr_ack(struct mei_cl_device *cldev,
+				    const struct iwl_sap_pldr_ack_data *ack)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+
+	mei->pldr_active = le32_to_cpu(ack->status) == SAP_PLDR_STATUS_SUCCESS;
+	wake_up_all(&mei->pldr_wq);
+}
+
 static void iwl_mei_handle_ping(struct mei_cl_device *cldev,
 				const struct iwl_sap_hdr *hdr)
 {
@@ -961,6 +974,8 @@ static void iwl_mei_handle_sap_msg(struct mei_cl_device *cldev,
 			iwl_mei_handle_can_release_ownership, 0);
 	SAP_MSG_HANDLER(CSME_TAKING_OWNERSHIP,
 			iwl_mei_handle_csme_taking_ownership, 0);
+	SAP_MSG_HANDLER(PLDR_ACK, iwl_mei_handle_pldr_ack,
+			sizeof(struct iwl_sap_pldr_ack_data));
 	default:
 	/*
 	 * This is not really an error, there are message that we decided
@@ -1337,6 +1352,62 @@ struct iwl_mei_nvm *iwl_mei_get_nvm(void)
 }
 EXPORT_SYMBOL_GPL(iwl_mei_get_nvm);
 
+#define IWL_MEI_PLDR_NUM_RETRIES	3
+
+int iwl_mei_pldr_req(void)
+{
+	struct iwl_mei *mei;
+	int ret;
+	struct iwl_sap_pldr_data msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_PLDR),
+		.hdr.len = cpu_to_le16(sizeof(msg) - sizeof(msg.hdr)),
+	};
+	int i;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	/* In case we didn't have a bind */
+	if (!iwl_mei_is_connected()) {
+		ret = 0;
+		goto out;
+	}
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (!mei->amt_enabled) {
+		ret = 0;
+		goto out;
+	}
+
+	for (i = 0; i < IWL_MEI_PLDR_NUM_RETRIES; i++) {
+		ret = iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
+		mutex_unlock(&iwl_mei_mutex);
+		if (ret)
+			return ret;
+
+		ret = wait_event_timeout(mei->pldr_wq, mei->pldr_active, HZ / 2);
+		if (ret)
+			break;
+
+		/* Take the mutex for the next iteration */
+		mutex_lock(&iwl_mei_mutex);
+	}
+
+	if (ret)
+		return 0;
+
+	ret = -ETIMEDOUT;
+out:
+	mutex_unlock(&iwl_mei_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iwl_mei_pldr_req);
+
 int iwl_mei_get_ownership(void)
 {
 	struct iwl_mei *mei;
@@ -1402,6 +1473,33 @@ int iwl_mei_get_ownership(void)
 }
 EXPORT_SYMBOL_GPL(iwl_mei_get_ownership);
 
+void iwl_mei_alive_notif(bool success)
+{
+	struct iwl_mei *mei;
+	struct iwl_sap_pldr_end_data msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_PLDR_END),
+		.hdr.len = cpu_to_le16(sizeof(msg) - sizeof(msg.hdr)),
+		.status = success ? cpu_to_le32(SAP_PLDR_STATUS_SUCCESS) :
+			cpu_to_le32(SAP_PLDR_STATUS_FAILURE),
+	};
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected())
+		goto out;
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+	if (!mei || !mei->pldr_active)
+		goto out;
+
+	mei->pldr_active = false;
+
+	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
+out:
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_alive_notif);
+
 void iwl_mei_host_associated(const struct iwl_mei_conn_info *conn_info,
 			     const struct iwl_mei_colloc_info *colloc_info)
 {
@@ -1841,6 +1939,7 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 	INIT_DELAYED_WORK(&mei->csa_throttle_end_wk,
 			  iwl_mei_csa_throttle_end_wk);
 	init_waitqueue_head(&mei->get_ownership_wq);
+	init_waitqueue_head(&mei->pldr_wq);
 	spin_lock_init(&mei->data_q_lock);
 	INIT_WORK(&mei->netdev_work, iwl_mei_netdev_work);
 
@@ -2013,6 +2112,7 @@ static void iwl_mei_remove(struct mei_cl_device *cldev)
 	 * the device.
 	 */
 	wake_up_all(&mei->get_ownership_wq);
+	wake_up_all(&mei->pldr_wq);
 
 	mutex_lock(&iwl_mei_mutex);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/sap.h b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
index ef2664589fc1..6c0ad4adbf32 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/sap.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
@@ -203,6 +203,7 @@ struct iwl_sap_me_msg_start_ok {
  * @SAP_MSG_NOTIF_NIC_OWNER: Payload is a DW. See &enum iwl_sap_nic_owner.
  * @SAP_MSG_NOTIF_CSME_CONN_STATUS: See &struct iwl_sap_notif_conn_status.
  * @SAP_MSG_NOTIF_NVM: See &struct iwl_sap_nvm.
+ * @SAP_MSG_NOTIF_PLDR_ACK: See &struct iwl_sap_pldr_ack_data.
  * @SAP_MSG_NOTIF_FROM_CSME_MAX: Not used.
  *
  * @SAP_MSG_NOTIF_FROM_HOST_MIN: Not used.
@@ -226,6 +227,8 @@ struct iwl_sap_me_msg_start_ok {
  * @SAP_MSG_NOTIF_HOST_OWNERSHIP_CONFIRMED: No payload.
  * @SAP_MSG_NOTIF_SAR_LIMITS: See &struct iwl_sap_notif_sar_limits.
  * @SAP_MSG_NOTIF_GET_NVM: No payload. Triggers %SAP_MSG_NOTIF_NVM.
+ * @SAP_MSG_NOTIF_PLDR: See &struct iwl_sap_pldr_data.
+ * @SAP_MSG_NOTIF_PLDR_END: See &struct iwl_sap_pldr_end_data.
  * @SAP_MSG_NOTIF_FROM_HOST_MAX: Not used.
  *
  * @SAP_MSG_DATA_MIN: Not used.
@@ -258,6 +261,8 @@ enum iwl_sap_msg {
 	SAP_MSG_NOTIF_NIC_OWNER				= 511,
 	SAP_MSG_NOTIF_CSME_CONN_STATUS			= 512,
 	SAP_MSG_NOTIF_NVM				= 513,
+	/* 514 - 517 not supported */
+	SAP_MSG_NOTIF_PLDR_ACK				= 518,
 	SAP_MSG_NOTIF_FROM_CSME_MAX,
 
 	SAP_MSG_NOTIF_FROM_HOST_MIN			= 1000,
@@ -279,6 +284,9 @@ enum iwl_sap_msg {
 	SAP_MSG_NOTIF_HOST_OWNERSHIP_CONFIRMED		= 1015,
 	SAP_MSG_NOTIF_SAR_LIMITS			= 1016,
 	SAP_MSG_NOTIF_GET_NVM				= 1017,
+	/* 1018 - 1023 not supported */
+	SAP_MSG_NOTIF_PLDR				= 1024,
+	SAP_MSG_NOTIF_PLDR_END				= 1025,
 	SAP_MSG_NOTIF_FROM_HOST_MAX,
 
 	SAP_MSG_DATA_MIN				= 2000,
@@ -732,4 +740,47 @@ struct iwl_sap_cb_data {
 	u8 payload[];
 };
 
+/**
+ * struct iwl_sap_pldr_data - payload of %SAP_MSG_NOTIF_PLDR
+ * @hdr: The SAP header.
+ * @version: SAP message version
+ */
+struct iwl_sap_pldr_data {
+	struct iwl_sap_hdr hdr;
+	__le32 version;
+} __packed;
+
+/**
+ * enum iwl_sap_pldr_status -
+ * @SAP_PLDR_STATUS_SUCCESS: PLDR started/ended successfully
+ * @SAP_PLDR_STATUS_FAILURE: PLDR failed to start/end
+ */
+enum iwl_sap_pldr_status {
+	SAP_PLDR_STATUS_SUCCESS	= 0,
+	SAP_PLDR_STATUS_FAILURE	= 1,
+};
+
+/*
+ * struct iwl_sap_pldr_end_data - payload of %SAP_MSG_NOTIF_PLDR_END
+ * @hdr: The SAP header.
+ * @version: SAP message version
+ * @status: PLDR end status
+ */
+struct iwl_sap_pldr_end_data {
+	struct iwl_sap_hdr hdr;
+	__le32 version;
+	__le32 status;
+} __packed;
+
+/*
+ * struct iwl_sap_pldr_ack_data - payload of %SAP_MSG_NOTIF_PLDR_ACK
+ * @version: SAP message version
+ * @status: CSME accept/refuse to the PLDR request
+ */
+struct iwl_sap_pldr_ack_data {
+	struct iwl_sap_hdr hdr;
+	__le32 version;
+	__le32 status;
+} __packed;
+
 #endif /* __sap_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5de34edc51fe..ef43f6971cd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -404,6 +404,8 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 		return -EIO;
 	}
 
+	iwl_mei_alive_notif(!ret);
+
 	ret = iwl_pnvm_load(mvm->trans, &mvm->notif_wait);
 	if (ret) {
 		IWL_ERR(mvm, "Timeout waiting for PNVM load!\n");
@@ -1456,6 +1458,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	struct ieee80211_channel *chan;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_supported_band *sband = NULL;
+	u32 sb_cfg;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1463,6 +1466,10 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	if (ret)
 		return ret;
 
+	sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
+	if (!(sb_cfg & SB_CFG_RESIDES_IN_OTP_MASK) && iwl_mei_pldr_req())
+		return ret;
+
 	ret = iwl_mvm_load_rt_fw(mvm);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
-- 
2.35.3


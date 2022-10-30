Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED4612BC6
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Oct 2022 18:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJ3RSc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 13:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3RSa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 13:18:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C7238
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667150308; x=1698686308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+gzqTxm3rJzkHLybbEQR/MWFnDBg+cEbixny7gGMp0o=;
  b=UrT2VyM5yImesEiqS+wj+7COAw5zsvAIYADIger4ZsEzBlbmRkzcwL3E
   frPlV7C/kYAE0GNEN8jnXYTGSM8/jgn+jTxgeNMkhsUKzVMK7GLjPTbh4
   PylJ2vAKXU26yZNVosyLvIAs+N5onUb7Z7L+XhpxuCQAcUrAHOsm8L+ew
   xUEr3hs+ztIWrpK85dLGaYKZZ3mdSAj/NI5b0uIFSf1ByUaQhRrIelLXn
   zFFQqgGWLOkpliNmVdMPSkdgHk/DqpclB2FTDHgv9upEu86qb8du55PJo
   5Q3TRJ3f1kV8uUdQYftE7fzvJsqurGRP//0ANFC/lwbGyodpLayHAECAV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="372973233"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="372973233"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="633290243"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="633290243"
Received: from gustyuzh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.83.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:25 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/6] wifi: iwlwifi: mei: don't send SAP commands if AMT is disabled
Date:   Sun, 30 Oct 2022 19:17:42 +0200
Message-Id: <20221030191011.ea222d41c781.Ifc90ddc3e35187683ff7f59371d792b61c8854c8@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221030171745.132081-1-gregory.greenman@intel.com>
References: <20221030171745.132081-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We should not send any SAP command to CSME if AMT is disabled.

Reported-by: Toke Høiland-Jørgensen <toke@toke.dk>
Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 85 ++++++++++---------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 90646c54a3c5..64a637ef199c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -596,8 +596,6 @@ iwl_mei_handle_rx_start_ok(struct mei_cl_device *cldev,
 			   const struct iwl_sap_me_msg_start_ok *rsp,
 			   ssize_t len)
 {
-	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
-
 	if (len != sizeof(*rsp)) {
 		dev_err(&cldev->dev,
 			"got invalid SAP_ME_MSG_START_OK from CSME firmware\n");
@@ -616,13 +614,10 @@ iwl_mei_handle_rx_start_ok(struct mei_cl_device *cldev,
 
 	mutex_lock(&iwl_mei_mutex);
 	set_bit(IWL_MEI_STATUS_SAP_CONNECTED, &iwl_mei_status);
-	/* wifi driver has registered already */
-	if (iwl_mei_cache.ops) {
-		iwl_mei_send_sap_msg(mei->cldev,
-				     SAP_MSG_NOTIF_WIFIDR_UP);
-		iwl_mei_cache.ops->sap_connected(iwl_mei_cache.priv);
-	}
-
+	/*
+	 * We'll receive AMT_STATE SAP message in a bit and
+	 * that will continue the flow
+	 */
 	mutex_unlock(&iwl_mei_mutex);
 }
 
@@ -715,6 +710,13 @@ static void iwl_mei_set_init_conf(struct iwl_mei *mei)
 		.val = cpu_to_le32(iwl_mei_cache.rf_kill),
 	};
 
+	/* wifi driver has registered already */
+	if (iwl_mei_cache.ops) {
+		iwl_mei_send_sap_msg(mei->cldev,
+				     SAP_MSG_NOTIF_WIFIDR_UP);
+		iwl_mei_cache.ops->sap_connected(iwl_mei_cache.priv);
+	}
+
 	iwl_mei_send_sap_msg(mei->cldev, SAP_MSG_NOTIF_WHO_OWNS_NIC);
 
 	if (iwl_mei_cache.conn_info) {
@@ -1420,10 +1422,7 @@ void iwl_mei_host_associated(const struct iwl_mei_conn_info *conn_info,
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei)
-		goto out;
-
-	if (!mei->amt_enabled)
+	if (!mei && !mei->amt_enabled)
 		goto out;
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
@@ -1452,7 +1451,7 @@ void iwl_mei_host_disassociated(void)
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei)
+	if (!mei && !mei->amt_enabled)
 		goto out;
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
@@ -1488,7 +1487,7 @@ void iwl_mei_set_rfkill_state(bool hw_rfkill, bool sw_rfkill)
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei)
+	if (!mei && !mei->amt_enabled)
 		goto out;
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
@@ -1517,7 +1516,7 @@ void iwl_mei_set_nic_info(const u8 *mac_address, const u8 *nvm_address)
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei)
+	if (!mei && !mei->amt_enabled)
 		goto out;
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
@@ -1545,7 +1544,7 @@ void iwl_mei_set_country_code(u16 mcc)
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei)
+	if (!mei && !mei->amt_enabled)
 		goto out;
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
@@ -1571,7 +1570,7 @@ void iwl_mei_set_power_limit(const __le16 *power_limit)
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei)
+	if (!mei && !mei->amt_enabled)
 		goto out;
 
 	memcpy(msg.sar_chain_info_table, power_limit, sizeof(msg.sar_chain_info_table));
@@ -1678,9 +1677,10 @@ int iwl_mei_register(void *priv, const struct iwl_mei_ops *ops)
 
 		/* we have already a SAP connection */
 		if (iwl_mei_is_connected()) {
-			iwl_mei_send_sap_msg(mei->cldev,
-					     SAP_MSG_NOTIF_WIFIDR_UP);
-			ops->rfkill(priv, mei->link_prot_state);
+			if (mei->amt_enabled)
+				iwl_mei_send_sap_msg(mei->cldev,
+						     SAP_MSG_NOTIF_WIFIDR_UP);
+			ops->rfkill(priv, mei->link_prot_state, false);
 		}
 	}
 	ret = 0;
@@ -1931,29 +1931,32 @@ static void iwl_mei_remove(struct mei_cl_device *cldev)
 
 	mutex_lock(&iwl_mei_mutex);
 
-	/*
-	 * Tell CSME that we are going down so that it won't access the
-	 * memory anymore, make sure this message goes through immediately.
-	 */
-	mei->csa_throttled = false;
-	iwl_mei_send_sap_msg(mei->cldev,
-			     SAP_MSG_NOTIF_HOST_GOES_DOWN);
+	if (mei->amt_enabled) {
+		/*
+		 * Tell CSME that we are going down so that it won't access the
+		 * memory anymore, make sure this message goes through immediately.
+		 */
+		mei->csa_throttled = false;
+		iwl_mei_send_sap_msg(mei->cldev,
+				     SAP_MSG_NOTIF_HOST_GOES_DOWN);
 
-	for (i = 0; i < SEND_SAP_MAX_WAIT_ITERATION; i++) {
-		if (!iwl_mei_host_to_me_data_pending(mei))
-			break;
+		for (i = 0; i < SEND_SAP_MAX_WAIT_ITERATION; i++) {
+			if (!iwl_mei_host_to_me_data_pending(mei))
+				break;
 
-		msleep(5);
-	}
+			msleep(20);
+		}
 
-	/*
-	 * If we couldn't make sure that CSME saw the HOST_GOES_DOWN message,
-	 * it means that it will probably keep reading memory that we are going
-	 * to unmap and free, expect IOMMU error messages.
-	 */
-	if (i == SEND_SAP_MAX_WAIT_ITERATION)
-		dev_err(&mei->cldev->dev,
-			"Couldn't get ACK from CSME on HOST_GOES_DOWN message\n");
+		/*
+		 * If we couldn't make sure that CSME saw the HOST_GOES_DOWN
+		 * message, it means that it will probably keep reading memory
+		 * that we are going to unmap and free, expect IOMMU error
+		 * messages.
+		 */
+		if (i == SEND_SAP_MAX_WAIT_ITERATION)
+			dev_err(&mei->cldev->dev,
+				"Couldn't get ACK from CSME on HOST_GOES_DOWN message\n");
+	}
 
 	mutex_unlock(&iwl_mei_mutex);
 
-- 
2.35.3


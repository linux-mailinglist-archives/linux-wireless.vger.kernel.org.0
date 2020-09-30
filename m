Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3798927EA04
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgI3Nbu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53374 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730197AbgI3Nbu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCm-002MJ5-Fr; Wed, 30 Sep 2020 16:31:37 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:22 +0300
Message-Id: <iwlwifi.20200930161256.b4893554d8e7.Ia4d7f389d4ac3256fcfe3ce6144e924dd6dbf6eb@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930133123.924256-1-luca@coelho.fi>
References: <20200930133123.924256-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: [PATCH 11/12] iwlwifi: thermal: support new temperature measurement API
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gil Adam <gil.adam@intel.com>

New API for temperature measurement (DTS_MEASUREMENT_TRIGGER)
involves getting an immediate response from FW, and not waiting
for a notification like in previous APIs. Support new API while
keeping backwards compatibility.

Signed-off-by: Gil Adam <gil.adam@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   | 13 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   | 78 ++++++++++++++++---
 2 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
index 8991ddffbf5e..0debca6dd037 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -213,6 +213,15 @@ struct iwl_dts_measurement_notif_v2 {
 	__le32 threshold_idx;
 } __packed; /* TEMPERATURE_MEASUREMENT_TRIGGER_NTFY_S_VER_2 */
 
+/**
+ * struct iwl_dts_measurement_resp - measurements response
+ *
+ * @temp: the measured temperature
+ */
+struct iwl_dts_measurement_resp {
+	__le32 temp;
+} __packed; /* CMD_DTS_MEASUREMENT_RSP_API_S_VER_1 */
+
 /**
  * struct ct_kill_notif - CT-kill entry notification
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 0c95663bf9ed..94e9b6de425e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -228,24 +228,67 @@ void iwl_mvm_ct_kill_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	iwl_mvm_enter_ctkill(mvm);
 }
 
-static int iwl_mvm_get_temp_cmd(struct iwl_mvm *mvm)
+/*
+ * send the DTS_MEASUREMENT_TRIGGER command with or without waiting for a
+ * response. If we get a response then the measurement is stored in 'temp'
+ */
+static int iwl_mvm_send_temp_cmd(struct iwl_mvm *mvm, bool response, s32 *temp)
 {
-	struct iwl_dts_measurement_cmd cmd = {
+	struct iwl_host_cmd cmd = {};
+	struct iwl_dts_measurement_cmd dts_cmd = {
 		.flags = cpu_to_le32(DTS_TRIGGER_CMD_FLAGS_TEMP),
 	};
-	struct iwl_ext_dts_measurement_cmd extcmd = {
+	struct iwl_ext_dts_measurement_cmd ext_cmd = {
 		.control_mode = cpu_to_le32(DTS_DIRECT_WITHOUT_MEASURE),
 	};
-	u32 cmdid;
+	struct iwl_dts_measurement_resp *resp;
+	void *cmd_ptr;
+	int ret;
+	u32 cmd_flags = 0;
+	u16 len;
+
+	/* Check which command format is used (regular/extended) */
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE)) {
+		len = sizeof(ext_cmd);
+		cmd_ptr = &ext_cmd;
+	} else {
+		len = sizeof(dts_cmd);
+		cmd_ptr = &dts_cmd;
+	}
+	/* The command version where we get a response is zero length */
+	if (response) {
+		cmd_flags = CMD_WANT_SKB;
+		len = 0;
+	}
 
-	cmdid = iwl_cmd_id(CMD_DTS_MEASUREMENT_TRIGGER_WIDE,
-			   PHY_OPS_GROUP, 0);
+	cmd.id =  WIDE_ID(PHY_OPS_GROUP, CMD_DTS_MEASUREMENT_TRIGGER_WIDE);
+	cmd.len[0] = len;
+	cmd.flags = cmd_flags;
+	cmd.data[0] = cmd_ptr;
 
-	if (!fw_has_capa(&mvm->fw->ucode_capa,
-			 IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE))
-		return iwl_mvm_send_cmd_pdu(mvm, cmdid, 0, sizeof(cmd), &cmd);
+	IWL_DEBUG_TEMP(mvm,
+		       "Sending temperature measurement command - %s response\n",
+		       response ? "with" : "without");
+	ret = iwl_mvm_send_cmd(mvm, &cmd);
 
-	return iwl_mvm_send_cmd_pdu(mvm, cmdid, 0, sizeof(extcmd), &extcmd);
+	if (ret) {
+		IWL_ERR(mvm,
+			"Failed to send the temperature measurement command (err=%d)\n",
+			ret);
+		return ret;
+	}
+
+	if (response) {
+		resp = (void *)cmd.resp_pkt->data;
+		*temp = le32_to_cpu(resp->temp);
+		IWL_DEBUG_TEMP(mvm,
+			       "Got temperature measurement response: temp=%d\n",
+			       *temp);
+		iwl_free_resp(&cmd);
+	}
+
+	return ret;
 }
 
 int iwl_mvm_get_temp(struct iwl_mvm *mvm, s32 *temp)
@@ -254,6 +297,18 @@ int iwl_mvm_get_temp(struct iwl_mvm *mvm, s32 *temp)
 	static u16 temp_notif[] = { WIDE_ID(PHY_OPS_GROUP,
 					    DTS_MEASUREMENT_NOTIF_WIDE) };
 	int ret;
+	u8 cmd_ver;
+
+	/*
+	 * If command version is 1 we send the command and immediately get
+	 * a response. For older versions we send the command and wait for a
+	 * notification (no command TLV for previous versions).
+	 */
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
+					CMD_DTS_MEASUREMENT_TRIGGER_WIDE,
+					IWL_FW_CMD_VER_UNKNOWN);
+	if (cmd_ver == 1)
+		return iwl_mvm_send_temp_cmd(mvm, true, temp);
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -261,9 +316,8 @@ int iwl_mvm_get_temp(struct iwl_mvm *mvm, s32 *temp)
 				   temp_notif, ARRAY_SIZE(temp_notif),
 				   iwl_mvm_temp_notif_wait, temp);
 
-	ret = iwl_mvm_get_temp_cmd(mvm);
+	ret = iwl_mvm_send_temp_cmd(mvm, false, temp);
 	if (ret) {
-		IWL_ERR(mvm, "Failed to get the temperature (err=%d)\n", ret);
 		iwl_remove_notification(&mvm->notif_wait, &wait_temp_notif);
 		return ret;
 	}
-- 
2.28.0


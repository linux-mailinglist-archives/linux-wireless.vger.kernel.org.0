Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0902B4AA7DE
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344666AbiBEJVs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:48 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37986 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343667AbiBEJVr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:47 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGL-0006b7-4t;
        Sat, 05 Feb 2022 11:21:46 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:31 +0200
Message-Id: <iwlwifi.20220205112029.48d0a1624fec.I8f9271959fc53223fa329ab097b12fd69b498b71@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205092140.751171-1-luca@coelho.fi>
References: <20220205092140.751171-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/12] iwlwifi: mvm: rfi: handle deactivation notification
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Sometimes RFIm can be deactivated in FW due to internal
errors. In this case, FW will send a notification to the
driver about that. Add a log message in this case since
FW logs are not always available.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h |  5 +++++
 drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h      | 10 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h         |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c         |  6 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c         |  9 +++++++++
 5 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index dded6e8a074a..a91bd66ecb30 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -605,6 +605,11 @@ enum iwl_system_subcmd_ids {
 	 * @SYSTEM_FEATURES_CONTROL_CMD: &struct iwl_system_features_control_cmd
 	 */
 	SYSTEM_FEATURES_CONTROL_CMD = 0xd,
+
+	/**
+	 * @RFI_DEACTIVATE_NOTIF: &struct iwl_rfi_deactivate_notif
+	 */
+	RFI_DEACTIVATE_NOTIF = 0xff,
 };
 
 #endif /* __iwl_fw_api_commands_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
index c678b9aa9b55..1a84a4081e7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2020 Intel Corporation
+ * Copyright (C) 2020-2021 Intel Corporation
  */
 #ifndef __iwl_fw_api_rfi_h__
 #define __iwl_fw_api_rfi_h__
@@ -57,4 +57,12 @@ struct iwl_rfi_freq_table_resp_cmd {
 	__le32 status;
 } __packed; /* RFI_CONFIG_CMD_API_S_VER_1 */
 
+/**
+ * struct iwl_rfi_deactivate_notif - notifcation that FW disaled RFIm
+ *
+ * @reason: used only for a log message
+ */
+struct iwl_rfi_deactivate_notif {
+	__le32 reason;
+} __packed; /* RFI_DEACTIVATE_NTF_S_VER_1 */
 #endif /* __iwl_fw_api_rfi_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3208a7670505..f6c69a4c1abf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2099,6 +2099,8 @@ void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
 int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm,
 			    struct iwl_rfi_lut_entry *rfi_table);
 struct iwl_rfi_freq_table_resp_cmd *iwl_rfi_get_freq_table(struct iwl_mvm *mvm);
+void iwl_rfi_deactivate_notif_handler(struct iwl_mvm *mvm,
+				      struct iwl_rx_cmd_buffer *rxb);
 
 static inline u8 iwl_mvm_phy_band_from_nl80211(enum nl80211_band band)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 5626eb091943..0d187d4fa8c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -24,6 +24,7 @@
 #include "iwl-prph.h"
 #include "rs.h"
 #include "fw/api/scan.h"
+#include "fw/api/rfi.h"
 #include "time-event.h"
 #include "fw-api.h"
 #include "fw/acpi.h"
@@ -396,6 +397,10 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       iwl_mvm_rx_thermal_dual_chain_req,
 		       RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_thermal_dual_chain_request),
+
+	RX_HANDLER_GRP(SYSTEM_GROUP, RFI_DEACTIVATE_NOTIF,
+		       iwl_rfi_deactivate_notif_handler, RX_HANDLER_ASYNC_UNLOCKED,
+		       struct iwl_rfi_deactivate_notif),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -505,6 +510,7 @@ static const struct iwl_hcmd_names iwl_mvm_system_names[] = {
 	HCMD_NAME(RFI_CONFIG_CMD),
 	HCMD_NAME(RFI_GET_FREQ_TABLE_CMD),
 	HCMD_NAME(SYSTEM_FEATURES_CONTROL_CMD),
+	HCMD_NAME(RFI_DEACTIVATE_NOTIF),
 };
 
 /* Please keep this array *SORTED* by hex value.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
index f054ce76bed5..7acb2be08e1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
@@ -134,3 +134,12 @@ struct iwl_rfi_freq_table_resp_cmd *iwl_rfi_get_freq_table(struct iwl_mvm *mvm)
 	iwl_free_resp(&cmd);
 	return resp;
 }
+
+void iwl_rfi_deactivate_notif_handler(struct iwl_mvm *mvm,
+				      struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_rfi_deactivate_notif *notif = (void *)pkt->data;
+
+	IWL_INFO(mvm, "RFIm is deactivated, reason = %d\n", notif->reason);
+}
-- 
2.34.1


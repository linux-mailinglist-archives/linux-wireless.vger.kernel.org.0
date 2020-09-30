Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3BC27EEE5
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgI3QUQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 12:20:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53454 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731244AbgI3QUL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 12:20:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNeps-002MPc-T1; Wed, 30 Sep 2020 19:20:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 19:19:55 +0300
Message-Id: <iwlwifi.20200930191738.6024b149e9e2.Ifcadb506e994ec352e9ce54399719926bc1bb7ee@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930161959.983283-1-luca@coelho.fi>
References: <20200930161959.983283-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/12] iwlwifi: support version 5 of the alive notification
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add support for the new version of the alive notification, which
includes the SKU ID.  We don't use the SKU ID yet, so we can just
handle the new notification as if it were version 4.

While at it, clean up a bit and rename the command and structure names
in the comments so that they are aligned with the ones used in the FW.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/alive.h | 25 +++++++++++++------
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  7 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 21 ++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 4 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
index df1bd0d2450e..4c5513a68d09 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018, 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +30,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018, 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -129,19 +128,31 @@ struct iwl_umac_alive {
 	struct iwl_umac_debug_addrs dbg_ptrs;
 } __packed; /* UMAC_ALIVE_DATA_API_S_VER_2 */
 
-struct mvm_alive_resp_v3 {
+struct iwl_sku_id {
+	u32 data[3];
+} __packed; /* SKU_ID_API_S_VER_1 */
+
+struct iwl_alive_ntf_v3 {
 	__le16 status;
 	__le16 flags;
 	struct iwl_lmac_alive lmac_data;
 	struct iwl_umac_alive umac_data;
-} __packed; /* ALIVE_RES_API_S_VER_3 */
+} __packed; /* UCODE_ALIVE_NTFY_API_S_VER_3 */
+
+struct iwl_alive_ntf_v4 {
+	__le16 status;
+	__le16 flags;
+	struct iwl_lmac_alive lmac_data[2];
+	struct iwl_umac_alive umac_data;
+} __packed; /* UCODE_ALIVE_NTFY_API_S_VER_4 */
 
-struct mvm_alive_resp {
+struct iwl_alive_ntf_v5 {
 	__le16 status;
 	__le16 flags;
 	struct iwl_lmac_alive lmac_data[2];
 	struct iwl_umac_alive umac_data;
-} __packed; /* ALIVE_RES_API_S_VER_4 */
+	struct iwl_sku_id sku_id;
+} __packed; /* UCODE_ALIVE_NTFY_API_S_VER_5 */
 
 /**
  * enum iwl_extended_cfg_flag - commands driver may send before
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 42e81c174205..14975a7e7203 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -104,11 +104,12 @@ enum iwl_mvm_command_groups {
  */
 enum iwl_legacy_cmds {
 	/**
-	 * @MVM_ALIVE:
+	 * @UCODE_ALIVE_NTFY:
 	 * Alive data from the firmware, as described in
-	 * &struct mvm_alive_resp_v3 or &struct mvm_alive_resp.
+	 * &struct iwl_alive_ntf_v3 or &struct iwl_alive_ntf_v4 or
+	 * &struct iwl_alive_ntf_v5.
 	 */
-	MVM_ALIVE = 0x1,
+	UCODE_ALIVE_NTFY = 0x1,
 
 	/**
 	 * @REPLY_ERROR: Cause an error in the firmware, for testing purposes.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 897249201b06..ccacf1576617 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -210,25 +210,36 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	struct iwl_mvm *mvm =
 		container_of(notif_wait, struct iwl_mvm, notif_wait);
 	struct iwl_mvm_alive_data *alive_data = data;
-	struct mvm_alive_resp_v3 *palive3;
-	struct mvm_alive_resp *palive;
 	struct iwl_umac_alive *umac;
 	struct iwl_lmac_alive *lmac1;
 	struct iwl_lmac_alive *lmac2 = NULL;
 	u16 status;
 	u32 lmac_error_event_table, umac_error_table;
 
-	if (iwl_rx_packet_payload_len(pkt) == sizeof(*palive)) {
+	/* we don't use the SKU ID from v5 yet, so handle it as v4 */
+	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
+				    UCODE_ALIVE_NTFY, 0) == 5 ||
+	    iwl_rx_packet_payload_len(pkt) == sizeof(struct iwl_alive_ntf_v4)) {
+		struct iwl_alive_ntf_v4 *palive;
+
 		palive = (void *)pkt->data;
 		umac = &palive->umac_data;
 		lmac1 = &palive->lmac_data[0];
 		lmac2 = &palive->lmac_data[1];
 		status = le16_to_cpu(palive->status);
-	} else {
+	} else if (iwl_rx_packet_payload_len(pkt) ==
+		   sizeof(struct iwl_alive_ntf_v3)) {
+		struct iwl_alive_ntf_v3 *palive3;
+
 		palive3 = (void *)pkt->data;
 		umac = &palive3->umac_data;
 		lmac1 = &palive3->lmac_data;
 		status = le16_to_cpu(palive3->status);
+	} else {
+		WARN(1, "unsupported alive notification (size %d)\n",
+		     iwl_rx_packet_payload_len(pkt));
+		/* get timeout later */
+		return false;
 	}
 
 	lmac_error_event_table =
@@ -306,7 +317,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	const struct fw_img *fw;
 	int ret;
 	enum iwl_ucode_type old_type = mvm->fwrt.cur_fw_img;
-	static const u16 alive_cmd[] = { MVM_ALIVE };
+	static const u16 alive_cmd[] = { UCODE_ALIVE_NTFY };
 	bool run_in_rfkill =
 		ucode_type == IWL_UCODE_INIT || iwl_mvm_has_unified_ucode(mvm);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 737ef0fd6ff1..078f5c2d2420 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -319,7 +319,7 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
  * Access is done through binary search
  */
 static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
-	HCMD_NAME(MVM_ALIVE),
+	HCMD_NAME(UCODE_ALIVE_NTFY),
 	HCMD_NAME(REPLY_ERROR),
 	HCMD_NAME(ECHO_CMD),
 	HCMD_NAME(INIT_COMPLETE_NOTIF),
-- 
2.28.0


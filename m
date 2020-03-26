Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24FB193F4C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgCZMzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:55:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44198 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728150AbgCZMzW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:55:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHS2Z-00040Z-US; Thu, 26 Mar 2020 14:55:20 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:55:00 +0200
Message-Id: <iwlwifi.20200326145047.81b06bbae5ca.Ib68d4c821ebcce253b42ed0ea15881fb4e3e01da@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326125510.621842-1-luca@coelho.fi>
References: <20200326125510.621842-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/12] iwlwifi: add support for version 2 of SOC_CONFIGURATION_CMD
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This new command is mostly backwards compatible, with the exception
that the device_type element was changed into a bitmask.  The device
type bit remains the same (because we only had 0 and 1 anyway), but
when using v1 we can't set any other bits, because that would change
the integer.

Other than that, the struct remains the same and the driver can set
the device_type bit in both cases, but it can only set the low_latency
bit if VER_2 is used.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/soc.h   | 24 +++++++++++--------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 21 ++++++++++++----
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h b/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
index 5d1fb98fe667..aadca78e9846 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
@@ -8,6 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2019        Intel Deutschland GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -30,6 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2019        Intel Deutschland GmbH
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -63,21 +65,23 @@
 #ifndef __iwl_fw_api_soc_h__
 #define __iwl_fw_api_soc_h__
 
-/* type of devices for defining SOC latency */
-enum iwl_soc_device_types {
-	SOC_CONFIG_CMD_INTEGRATED   = 0x0,
-	SOC_CONFIG_CMD_DISCRETE     = 0x1,
-};
+#define SOC_CONFIG_CMD_FLAGS_DISCRETE		BIT(0)
+#define SOC_CONFIG_CMD_FLAGS_LOW_LATENCY	BIT(1)
 
 /**
  * struct iwl_soc_configuration_cmd - Set device stabilization latency
  *
- * @device_type: the device type as defined in &enum iwl_soc_device_types
- * @soc_latency: time for SOC to ensure stable power & XTAL
+ * @flags: soc settings flags.  In VER_1, we can only set the DISCRETE
+ *	flag, because the FW treats the whole value as an integer. In
+ *	VER_2, we can set the bits independently.
+ * @latency: time for SOC to ensure stable power & XTAL
  */
 struct iwl_soc_configuration_cmd {
-	__le32 device_type;
-	__le32 soc_latency;
-} __packed; /* SOC_CONFIGURATION_CMD_S_VER_1 */
+	__le32 flags;
+	__le32 latency;
+} __packed; /*
+	     * SOC_CONFIGURATION_CMD_S_VER_1 (see description above)
+	     * SOC_CONFIGURATION_CMD_S_VER_2
+	     */
 
 #endif /* __iwl_fw_api_soc_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 8549e8a39705..3069a322ca75 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -303,6 +303,7 @@ struct iwl_pwr_tx_backoff {
  * @gen2: 22000 and on transport operation
  * @mq_rx_supported: multi-queue rx support
  * @integrated: discrete or integrated
+ * @low_latency_xtal: use the low latency xtal if supported
  */
 struct iwl_cfg_trans_params {
 	const struct iwl_base_params *base_params;
@@ -315,6 +316,7 @@ struct iwl_cfg_trans_params {
 	    gen2:1,
 	    mq_rx_supported:1,
 	    integrated:1,
+	    low_latency_xtal:1,
 	    bisr_workaround:1;
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 98978a475d93..bc040e9ca55f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -90,13 +90,24 @@ struct iwl_mvm_alive_data {
 /* set device type and latency */
 static int iwl_set_soc_latency(struct iwl_mvm *mvm)
 {
-	struct iwl_soc_configuration_cmd cmd;
+	struct iwl_soc_configuration_cmd cmd = {};
 	int ret;
 
-	cmd.device_type = (mvm->trans->trans_cfg->integrated) ?
-		cpu_to_le32(SOC_CONFIG_CMD_INTEGRATED) :
-		cpu_to_le32(SOC_CONFIG_CMD_DISCRETE);
-	cmd.soc_latency = cpu_to_le32(mvm->trans->trans_cfg->xtal_latency);
+	/*
+	 * In VER_1 of this command, the discrete value is considered
+	 * an integer; In VER_2, it's a bitmask.  Since we have only 2
+	 * values in VER_1, this is backwards-compatible with VER_2,
+	 * as long as we don't set any other bits.
+	 */
+	if (!mvm->trans->trans_cfg->integrated)
+		cmd.flags = cpu_to_le32(SOC_CONFIG_CMD_FLAGS_DISCRETE);
+
+	if (iwl_mvm_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+				   SCAN_REQ_UMAC) >= 2 &&
+	    (mvm->trans->trans_cfg->low_latency_xtal))
+		cmd.flags |= cpu_to_le32(SOC_CONFIG_CMD_FLAGS_LOW_LATENCY);
+
+	cmd.latency = cpu_to_le32(mvm->trans->trans_cfg->xtal_latency);
 
 	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SOC_CONFIGURATION_CMD,
 						   SYSTEM_GROUP, 0), 0,
-- 
2.25.1


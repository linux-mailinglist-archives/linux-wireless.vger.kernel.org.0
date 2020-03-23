Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0DEA18F58F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgCWNTi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:19:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43382 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728375AbgCWNTh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:19:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzO-00023f-D2; Mon, 23 Mar 2020 15:19:35 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:12 +0200
Message-Id: <iwlwifi.20200323151304.a491f6c5ae4b.I6829a46b89e4e701f80a0e4033f4dd41ee44ed12@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323131925.208376-1-luca@coelho.fi>
References: <20200323131925.208376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/14] iwlwifi: mvm: add soc latency support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Some devices require longer time to stabilize the power and XTAL.
This is especially true for devices integrated in the SoC.  Add
support for a new firmware API that allows the driver to set the
latency value accordingly.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  9 +-
 .../net/wireless/intel/iwlwifi/fw/api/soc.h   | 83 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  | 11 ++-
 .../net/wireless/intel/iwlwifi/mvm/fw-api.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 32 ++++++-
 5 files changed, 124 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/soc.h

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 22dff2c92d4f..4f46f3ed8794 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -5,9 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2012 - 2014, 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,9 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2012 - 2014, 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -646,6 +646,11 @@ enum iwl_system_subcmd_ids {
 	 */
 	SHARED_MEM_CFG_CMD = 0x0,
 
+	/**
+	 * @SOC_CONFIGURATION_CMD: &struct iwl_soc_configuration_cmd
+	 */
+	SOC_CONFIGURATION_CMD = 0x01,
+
 	/**
 	 * @INIT_EXTENDED_CFG_CMD: &struct iwl_init_extended_cfg_cmd
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h b/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
new file mode 100644
index 000000000000..5d1fb98fe667
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
@@ -0,0 +1,83 @@
+/******************************************************************************
+ *
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
+ * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * The full GNU General Public License is included in this distribution
+ * in the file called COPYING.
+ *
+ * Contact Information:
+ *  Intel Linux Wireless <linuxwifi@intel.com>
+ * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
+ *
+ * BSD LICENSE
+ *
+ * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
+ * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *  * Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ *  * Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *  * Neither the name Intel Corporation nor the names of its
+ *    contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *****************************************************************************/
+
+#ifndef __iwl_fw_api_soc_h__
+#define __iwl_fw_api_soc_h__
+
+/* type of devices for defining SOC latency */
+enum iwl_soc_device_types {
+	SOC_CONFIG_CMD_INTEGRATED   = 0x0,
+	SOC_CONFIG_CMD_DISCRETE     = 0x1,
+};
+
+/**
+ * struct iwl_soc_configuration_cmd - Set device stabilization latency
+ *
+ * @device_type: the device type as defined in &enum iwl_soc_device_types
+ * @soc_latency: time for SOC to ensure stable power & XTAL
+ */
+struct iwl_soc_configuration_cmd {
+	__le32 device_type;
+	__le32 soc_latency;
+} __packed; /* SOC_CONFIGURATION_CMD_S_VER_1 */
+
+#endif /* __iwl_fw_api_soc_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 1554f5fdd483..35f42e529a6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -5,11 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2008 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,11 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2008 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -369,6 +365,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	is supported.
  * @IWL_UCODE_TLV_CAPA_BT_COEX_RRC: supports BT Coex RRC
  * @IWL_UCODE_TLV_CAPA_GSCAN_SUPPORT: supports gscan (no longer used)
+ * @IWL_UCODE_TLV_CAPA_SOC_LATENCY_SUPPORT: the firmware supports setting
+ *	stabilization latency for SoCs.
  * @IWL_UCODE_TLV_CAPA_STA_PM_NOTIF: firmware will send STA PM notification
  * @IWL_UCODE_TLV_CAPA_TLC_OFFLOAD: firmware implements rate scaling algorithm
  * @IWL_UCODE_TLV_CAPA_DYNAMIC_QUOTA: firmware implements quota related
@@ -437,6 +435,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_GSCAN_SUPPORT		= (__force iwl_ucode_tlv_capa_t)31,
 
 	/* set 1 */
+	IWL_UCODE_TLV_CAPA_SOC_LATENCY_SUPPORT		= (__force iwl_ucode_tlv_capa_t)37,
 	IWL_UCODE_TLV_CAPA_STA_PM_NOTIF			= (__force iwl_ucode_tlv_capa_t)38,
 	IWL_UCODE_TLV_CAPA_BINDING_CDB_SUPPORT		= (__force iwl_ucode_tlv_capa_t)39,
 	IWL_UCODE_TLV_CAPA_CDB_SUPPORT			= (__force iwl_ucode_tlv_capa_t)40,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h b/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
index e3eb812e0248..05a06f88db6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
@@ -73,6 +73,7 @@
 #include "fw/api/datapath.h"
 #include "fw/api/phy.h"
 #include "fw/api/config.h"
+#include "fw/api/soc.h"
 #include "fw/api/alive.h"
 #include "fw/api/binding.h"
 #include "fw/api/cmdhdr.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 54c094e88474..1b3a2f52e13f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019        Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019       Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -89,6 +87,25 @@ struct iwl_mvm_alive_data {
 	u32 scd_base_addr;
 };
 
+/* set device type and latency */
+static int iwl_set_soc_latency(struct iwl_mvm *mvm)
+{
+	struct iwl_soc_configuration_cmd cmd;
+	int ret;
+
+	cmd.device_type = (mvm->trans->cfg->integrated) ?
+		cpu_to_le32(SOC_CONFIG_CMD_INTEGRATED) :
+		cpu_to_le32(SOC_CONFIG_CMD_DISCRETE);
+	cmd.soc_latency = cpu_to_le32(mvm->trans->cfg->soc_latency);
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SOC_CONFIGURATION_CMD,
+						   SYSTEM_GROUP, 0), 0,
+				   sizeof(cmd), &cmd);
+	if (ret)
+		IWL_ERR(mvm, "Failed to set soc latency: %d\n", ret);
+	return ret;
+}
+
 static int iwl_send_tx_ant_cfg(struct iwl_mvm *mvm, u8 valid_tx_ant)
 {
 	struct iwl_tx_ant_cfg_cmd tx_ant_cmd = {
@@ -1103,6 +1120,13 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	if (ret)
 		goto error;
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SOC_LATENCY_SUPPORT)) {
+		ret = iwl_set_soc_latency(mvm);
+		if (ret)
+			goto error;
+	}
+
 	/* Init RSS configuration */
 	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
 		ret = iwl_configure_rxq(mvm);
-- 
2.25.1


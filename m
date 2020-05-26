Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975D71ADADE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgDQKVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:21:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56568 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728631AbgDQKVx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:21:53 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPO86-000Kba-6F; Fri, 17 Apr 2020 13:21:51 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 13:21:34 +0300
Message-Id: <iwlwifi.20200417131727.9c61e7e42b26.I5ede9cc25ee8de7b8d2b5c574f917a18971da734@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200417102142.2173014-1-luca@coelho.fi>
References: <20200417102142.2173014-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/10] iwlwifi: move API version lookup to common code
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The API version lookup is parsed from a TLV and should be in shared code
make make it reusable across all opmodes.

Also change the function names from mvm to fw, since this is not
mvm-specific anymore.

Additionally, since this function is not just a single line of code, it
shouldn't be inline.  Convert them to actual functions.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.c   | 100 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  19 +---
 .../intel/iwlwifi/mvm/ftm-initiator.c         |   4 +-
 .../intel/iwlwifi/mvm/ftm-responder.c         |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  24 +----
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   8 +-
 9 files changed, 119 insertions(+), 53 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/img.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 0aae3fa4128c..fbcd1405aeea 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -13,7 +13,8 @@ iwlwifi-$(CONFIG_IWLDVM) += cfg/1000.o cfg/2000.o cfg/5000.o cfg/6000.o
 iwlwifi-$(CONFIG_IWLMVM) += cfg/7000.o cfg/8000.o cfg/9000.o cfg/22000.o
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
-iwlwifi-objs		+= fw/notif-wait.o
+
+iwlwifi-objs		+= fw/img.o fw/notif-wait.o
 iwlwifi-objs		+= fw/dbg.o
 iwlwifi-$(CONFIG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_ACPI) += fw/acpi.o
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.c b/drivers/net/wireless/intel/iwlwifi/fw/img.c
new file mode 100644
index 000000000000..dec95d09a324
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/******************************************************************************
+ *
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright(c) 2019 Intel Corporation
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
+ * Copyright(c) 2019 Intel Corporation
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
+ *****************************************************************************/
+
+#include "img.h"
+
+u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd)
+{
+	const struct iwl_fw_cmd_version *entry;
+	unsigned int i;
+
+	if (!fw->ucode_capa.cmd_versions ||
+	    !fw->ucode_capa.n_cmd_versions)
+		return IWL_FW_CMD_VER_UNKNOWN;
+
+	entry = fw->ucode_capa.cmd_versions;
+	for (i = 0; i < fw->ucode_capa.n_cmd_versions; i++, entry++) {
+		if (entry->group == grp && entry->cmd == cmd)
+			return entry->cmd_ver;
+	}
+
+	return IWL_FW_CMD_VER_UNKNOWN;
+}
+EXPORT_SYMBOL_GPL(iwl_fw_lookup_cmd_ver);
+
+u8 iwl_fw_lookup_notif_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def)
+{
+	const struct iwl_fw_cmd_version *entry;
+	unsigned int i;
+
+	if (!fw->ucode_capa.cmd_versions ||
+	    !fw->ucode_capa.n_cmd_versions)
+		return def;
+
+	entry = fw->ucode_capa.cmd_versions;
+	for (i = 0; i < fw->ucode_capa.n_cmd_versions; i++, entry++) {
+		if (entry->group == grp && entry->cmd == cmd) {
+			if (entry->notif_ver == IWL_FW_CMD_VER_UNKNOWN)
+				return def;
+			return entry->notif_ver;
+		}
+	}
+
+	return def;
+}
+EXPORT_SYMBOL_GPL(iwl_fw_lookup_notif_ver);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 90ca5f929cf9..a8630bf90b63 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -313,22 +313,7 @@ iwl_get_ucode_image(const struct iwl_fw *fw, enum iwl_ucode_type ucode_type)
 	return &fw->img[ucode_type];
 }
 
-static inline u8 iwl_mvm_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd)
-{
-	const struct iwl_fw_cmd_version *entry;
-	unsigned int i;
-
-	if (!fw->ucode_capa.cmd_versions ||
-	    !fw->ucode_capa.n_cmd_versions)
-		return IWL_FW_CMD_VER_UNKNOWN;
-
-	entry = fw->ucode_capa.cmd_versions;
-	for (i = 0; i < fw->ucode_capa.n_cmd_versions; i++, entry++) {
-		if (entry->group == grp && entry->cmd == cmd)
-			return entry->cmd_ver;
-	}
-
-	return IWL_FW_CMD_VER_UNKNOWN;
-}
+u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd);
 
+u8 iwl_fw_lookup_notif_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def);
 #endif  /* __iwl_fw_img_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 9e21f5e5d364..cdb87139100d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -508,8 +508,8 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return -EBUSY;
 
 	if (new_api) {
-		u8 cmd_ver = iwl_mvm_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
-						    TOF_RANGE_REQ_CMD);
+		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
+						   TOF_RANGE_REQ_CMD);
 
 		if (cmd_ver == 8)
 			err = iwl_mvm_ftm_start_v8(mvm, vif, req);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 834564198409..0b6c32098b5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -136,8 +136,8 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 				    IWL_TOF_RESPONDER_CMD_VALID_STA_ID),
 		.sta_id = mvmvif->bcast_sta.sta_id,
 	};
-	u8 cmd_ver = iwl_mvm_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
-					    TOF_RESPONDER_CONFIG_CMD);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
+					   TOF_RESPONDER_CONFIG_CMD);
 	int err;
 
 	lockdep_assert_held(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a4038f289ab3..8fe78ce37771 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -102,9 +102,9 @@ static int iwl_set_soc_latency(struct iwl_mvm *mvm)
 	if (!mvm->trans->trans_cfg->integrated)
 		cmd.flags = cpu_to_le32(SOC_CONFIG_CMD_FLAGS_DISCRETE);
 
-	if (iwl_mvm_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-				   SCAN_REQ_UMAC) >= 2 &&
-	    (mvm->trans->trans_cfg->low_latency_xtal))
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+				  SCAN_REQ_UMAC) >= 2 &&
+	    mvm->trans->trans_cfg->low_latency_xtal)
 		cmd.flags |= cpu_to_le32(SOC_CONFIG_CMD_FLAGS_LOW_LATENCY);
 
 	cmd.latency = cpu_to_le32(mvm->trans->trans_cfg->xtal_latency);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index afcf2b98a9cb..9e2a0858108c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2149,8 +2149,8 @@ iwl_mvm_set_chan_info_chandef(struct iwl_mvm *mvm,
 
 static inline int iwl_umac_scan_get_max_profiles(const struct iwl_fw *fw)
 {
-	u8 ver = iwl_mvm_lookup_cmd_ver(fw, IWL_ALWAYS_LONG_GROUP,
-					SCAN_OFFLOAD_UPDATE_PROFILES_CMD);
+	u8 ver = iwl_fw_lookup_cmd_ver(fw, IWL_ALWAYS_LONG_GROUP,
+				       SCAN_OFFLOAD_UPDATE_PROFILES_CMD);
 	return (ver == IWL_FW_CMD_VER_UNKNOWN || ver < 3) ?
 		IWL_SCAN_MAX_PROFILES : IWL_SCAN_MAX_PROFILES_V2;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index dfe02440d474..b00f4a8b8424 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -612,27 +612,6 @@ static const struct iwl_fw_runtime_ops iwl_mvm_fwrt_ops = {
 	.d3_debug_enable = iwl_mvm_d3_debug_enable,
 };
 
-static u8 iwl_mvm_lookup_notif_ver(struct iwl_mvm *mvm, u8 grp, u8 cmd, u8 def)
-{
-	const struct iwl_fw_cmd_version *entry;
-	unsigned int i;
-
-	if (!mvm->fw->ucode_capa.cmd_versions ||
-	    !mvm->fw->ucode_capa.n_cmd_versions)
-		return def;
-
-	entry = mvm->fw->ucode_capa.cmd_versions;
-	for (i = 0; i < mvm->fw->ucode_capa.n_cmd_versions; i++, entry++) {
-		if (entry->group == grp && entry->cmd == cmd) {
-			if (entry->notif_ver == IWL_FW_CMD_VER_UNKNOWN)
-				return def;
-			return entry->notif_ver;
-		}
-	}
-
-	return def;
-}
-
 static struct iwl_op_mode *
 iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
@@ -745,7 +724,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	INIT_DELAYED_WORK(&mvm->cs_tx_unblock_dwork, iwl_mvm_tx_unblock_dwork);
 
 	mvm->cmd_ver.d0i3_resp =
-		iwl_mvm_lookup_notif_ver(mvm, LEGACY_GROUP, D0I3_END_CMD, 0);
+		iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP, D0I3_END_CMD,
+					0);
 	/* we only support version 1 */
 	if (WARN_ON_ONCE(mvm->cmd_ver.d0i3_resp > 1))
 		goto out_free;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index bc48113f0568..51a061b138ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2228,8 +2228,8 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 
 	hcmd->id = iwl_cmd_id(SCAN_REQ_UMAC, IWL_ALWAYS_LONG_GROUP, 0);
 
-	scan_ver = iwl_mvm_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-					  SCAN_REQ_UMAC);
+	scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+					 SCAN_REQ_UMAC);
 
 	for (i = 0; i < ARRAY_SIZE(iwl_scan_umac_handlers); i++) {
 		const struct iwl_scan_umac_handler *ver_handler =
@@ -2568,8 +2568,8 @@ static int iwl_scan_req_umac_get_size(u8 scan_ver)
 int iwl_mvm_scan_size(struct iwl_mvm *mvm)
 {
 	int base_size, tail_size;
-	u8 scan_ver = iwl_mvm_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-					     SCAN_REQ_UMAC);
+	u8 scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+					    SCAN_REQ_UMAC);
 
 	base_size = iwl_scan_req_umac_get_size(scan_ver);
 	if (base_size)
-- 
2.25.1


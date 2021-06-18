Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E6E3AC5B1
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhFRIFs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:05:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48108 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233592AbhFRIEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:04:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lu9RT-001YIf-3e; Fri, 18 Jun 2021 11:01:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 11:01:21 +0300
Message-Id: <iwlwifi.20210618105614.c25913d2c08c.Ic0fefac81afb9a2fe396d73528e30e09a8c5eae0@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618080121.588233-1-luca@coelho.fi>
References: <20210618080121.588233-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.5-pre1
Subject: [PATCH 10/10] iwlwifi: mvm: introduce iwl_proto_offload_cmd_v4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We need to pass the station id to tell the firmware
on which station we want to configure the protocol
offload.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 16 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 11 +++++---
 .../wireless/intel/iwlwifi/mvm/offloading.c   | 26 ++++++++++++++-----
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 5373182c1364..a9e8f30ef91d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -159,6 +159,22 @@ struct iwl_proto_offload_cmd_v3_large {
 	struct iwl_ns_config ns_config[IWL_PROTO_OFFLOAD_NUM_NS_CONFIG_V3L];
 } __packed; /* PROT_OFFLOAD_CONFIG_CMD_DB_S_VER_3 */
 
+/**
+ * struct iwl_proto_offload_cmd_v4 - ARP/NS offload configuration
+ * @sta_id: station id
+ * @common: common/IPv4 configuration
+ * @num_valid_ipv6_addrs: number of valid IPv6 addresses
+ * @targ_addrs: target IPv6 addresses
+ * @ns_config: NS offload configurations
+ */
+struct iwl_proto_offload_cmd_v4 {
+	__le32 sta_id;
+	struct iwl_proto_offload_cmd_common common;
+	__le32 num_valid_ipv6_addrs;
+	struct iwl_targ_addr targ_addrs[IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS_V3L];
+	struct iwl_ns_config ns_config[IWL_PROTO_OFFLOAD_NUM_NS_CONFIG_V3L];
+} __packed; /* PROT_OFFLOAD_CONFIG_CMD_DB_S_VER_4 */
+
 /*
  * WOWLAN_PATTERNS
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6617fe5a7ece..7b13c4fc1b58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1693,10 +1693,13 @@ iwl_mvm_get_wakeup_status(struct iwl_mvm *mvm)
 {
 	int ret;
 
-	/* only for tracing for now */
-	ret = iwl_mvm_send_cmd_pdu(mvm, OFFLOADS_QUERY_CMD, 0, 0, NULL);
-	if (ret)
-		IWL_ERR(mvm, "failed to query offload statistics (%d)\n", ret);
+	if (!mvm->net_detect) {
+		/* only for tracing for now */
+		int ret = iwl_mvm_send_cmd_pdu(mvm, OFFLOADS_QUERY_CMD, 0,
+					       0, NULL);
+		if (ret)
+			IWL_ERR(mvm, "failed to query offload statistics (%d)\n", ret);
+	}
 
 	return iwl_mvm_send_wowlan_get_status(mvm);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
index 1cc90e61367b..41880517e8bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014 Intel Corporation
+ * Copyright (C) 2012-2014, 2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
@@ -36,7 +36,7 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 		struct iwl_proto_offload_cmd_v1 v1;
 		struct iwl_proto_offload_cmd_v2 v2;
 		struct iwl_proto_offload_cmd_v3_small v3s;
-		struct iwl_proto_offload_cmd_v3_large v3l;
+		struct iwl_proto_offload_cmd_v4 v4;
 	} cmd = {};
 	struct iwl_host_cmd hcmd = {
 		.id = PROT_OFFLOAD_CONFIG_CMD,
@@ -47,6 +47,9 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 	struct iwl_proto_offload_cmd_common *common;
 	u32 enabled = 0, size;
 	u32 capa_flags = mvm->fw->ucode_capa.flags;
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					PROT_OFFLOAD_CONFIG_CMD, 0);
+
 #if IS_ENABLED(CONFIG_IPV6)
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int i;
@@ -72,9 +75,9 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 			addrs = cmd.v3s.targ_addrs;
 			n_addrs = IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS_V3S;
 		} else {
-			nsc = cmd.v3l.ns_config;
+			nsc = cmd.v4.ns_config;
 			n_nsc = IWL_PROTO_OFFLOAD_NUM_NS_CONFIG_V3L;
-			addrs = cmd.v3l.targ_addrs;
+			addrs = cmd.v4.targ_addrs;
 			n_addrs = IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS_V3L;
 		}
 
@@ -116,7 +119,7 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 			cmd.v3s.num_valid_ipv6_addrs =
 				cpu_to_le32(i - num_skipped);
 		else
-			cmd.v3l.num_valid_ipv6_addrs =
+			cmd.v4.num_valid_ipv6_addrs =
 				cpu_to_le32(i - num_skipped);
 	} else if (capa_flags & IWL_UCODE_TLV_FLAGS_D3_6_IPV6_ADDRS) {
 		bool found = false;
@@ -171,8 +174,17 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 		common = &cmd.v3s.common;
 		size = sizeof(cmd.v3s);
 	} else if (capa_flags & IWL_UCODE_TLV_FLAGS_NEW_NSOFFL_LARGE) {
-		common = &cmd.v3l.common;
-		size = sizeof(cmd.v3l);
+		common = &cmd.v4.common;
+		size = sizeof(cmd.v4);
+		if (ver < 4) {
+			/*
+			 * This basically uses iwl_proto_offload_cmd_v3_large
+			 * which doesn't have the sta_id parameter before the
+			 * common part.
+			 */
+			size -= sizeof(cmd.v4.sta_id);
+			hcmd.data[0] = common;
+		}
 	} else if (capa_flags & IWL_UCODE_TLV_FLAGS_D3_6_IPV6_ADDRS) {
 		common = &cmd.v2.common;
 		size = sizeof(cmd.v2);
-- 
2.32.0


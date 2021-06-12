Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611833A4E5D
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 13:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhFLLev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 07:34:51 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47562 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231187AbhFLLeu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 07:34:50 -0400
Received: from [192.130.48.226] (helo=kveik.superpark.guest)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ls1se-001V8i-NA; Sat, 12 Jun 2021 14:32:50 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 12 Jun 2021 14:32:37 +0300
Message-Id: <iwlwifi.20210612142637.549b282ae9a4.Iced05882d73b869e19f50e6a6e7bf9ce6cd7899b@changeid>
X-Mailer: git-send-email 2.32.0.rc2
In-Reply-To: <20210612113245.691117-1-luca@coelho.fi>
References: <20210612113245.691117-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 04/12] iwlwifi: remove unused REMOTE_WAKE_CONFIG_CMD definitions
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We don't use this command anymore and it is going to be removed from
the FW.  Remove all related definitions.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  5 --
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 51 +------------------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 -
 3 files changed, 1 insertion(+), 56 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index c625d319142e..ce060c3dfd7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -534,11 +534,6 @@ enum iwl_legacy_cmds {
 	 */
 	OFFLOADS_QUERY_CMD = 0xd5,
 
-	/**
-	 * @REMOTE_WAKE_CONFIG_CMD: &struct iwl_wowlan_remote_wake_config
-	 */
-	REMOTE_WAKE_CONFIG_CMD = 0xd6,
-
 	/**
 	 * @D0I3_END_CMD: End D0i3/D3 state, no command data
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 758639084e0c..6488c0f8b471 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -683,55 +683,6 @@ static inline u8 iwlmvm_wowlan_gtk_idx(struct iwl_wowlan_gtk_status *gtk)
 	return gtk->key_flags & IWL_WOWLAN_GTK_IDX_MASK;
 }
 
-#define IWL_WOWLAN_TCP_MAX_PACKET_LEN		64
-#define IWL_WOWLAN_REMOTE_WAKE_MAX_PACKET_LEN	128
-#define IWL_WOWLAN_REMOTE_WAKE_MAX_TOKENS	2048
-
-struct iwl_tcp_packet_info {
-	__le16 tcp_pseudo_header_checksum;
-	__le16 tcp_payload_length;
-} __packed; /* TCP_PACKET_INFO_API_S_VER_2 */
-
-struct iwl_tcp_packet {
-	struct iwl_tcp_packet_info info;
-	u8 rx_mask[IWL_WOWLAN_MAX_PATTERN_LEN / 8];
-	u8 data[IWL_WOWLAN_TCP_MAX_PACKET_LEN];
-} __packed; /* TCP_PROTOCOL_PACKET_API_S_VER_1 */
-
-struct iwl_remote_wake_packet {
-	struct iwl_tcp_packet_info info;
-	u8 rx_mask[IWL_WOWLAN_MAX_PATTERN_LEN / 8];
-	u8 data[IWL_WOWLAN_REMOTE_WAKE_MAX_PACKET_LEN];
-} __packed; /* TCP_PROTOCOL_PACKET_API_S_VER_1 */
-
-struct iwl_wowlan_remote_wake_config {
-	__le32 connection_max_time; /* unused */
-	/* TCP_PROTOCOL_CONFIG_API_S_VER_1 */
-	u8 max_syn_retries;
-	u8 max_data_retries;
-	u8 tcp_syn_ack_timeout;
-	u8 tcp_ack_timeout;
-
-	struct iwl_tcp_packet syn_tx;
-	struct iwl_tcp_packet synack_rx;
-	struct iwl_tcp_packet keepalive_ack_rx;
-	struct iwl_tcp_packet fin_tx;
-
-	struct iwl_remote_wake_packet keepalive_tx;
-	struct iwl_remote_wake_packet wake_rx;
-
-	/* REMOTE_WAKE_OFFSET_INFO_API_S_VER_1 */
-	u8 sequence_number_offset;
-	u8 sequence_number_length;
-	u8 token_offset;
-	u8 token_length;
-	/* REMOTE_WAKE_PROTOCOL_PARAMS_API_S_VER_1 */
-	__le32 initial_sequence_number;
-	__le16 keepalive_interval;
-	__le16 num_tokens;
-	u8 tokens[IWL_WOWLAN_REMOTE_WAKE_MAX_TOKENS];
-} __packed; /* REMOTE_WAKE_CONFIG_API_S_VER_2 */
-
 /* TODO: NetDetect API */
 
 #endif /* __iwl_fw_api_d3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 1c310e2b2b61..7b67ee2c70aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -445,7 +445,6 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
 	HCMD_NAME(D3_CONFIG_CMD),
 	HCMD_NAME(PROT_OFFLOAD_CONFIG_CMD),
 	HCMD_NAME(OFFLOADS_QUERY_CMD),
-	HCMD_NAME(REMOTE_WAKE_CONFIG_CMD),
 	HCMD_NAME(MATCH_FOUND_NOTIFICATION),
 	HCMD_NAME(DTS_MEASUREMENT_NOTIFICATION),
 	HCMD_NAME(WOWLAN_PATTERNS),
-- 
2.32.0.rc2


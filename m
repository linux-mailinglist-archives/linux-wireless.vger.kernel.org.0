Return-Path: <linux-wireless+bounces-22678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006AAAACE34
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FE94E35D2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A11214228;
	Tue,  6 May 2025 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWvlG4Hv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E588209F46
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560483; cv=none; b=gm5M/DMpznnNY2JlgIIoBNlAY2VsrIs+c076rFqmQ4egsLnXO+HnF/Dl1dHaLQzIYwIHk2xgKJaLyUSFThiTX/J6RcIxuQIW6k/s0EwkvDI14CmkJvIVC9Y/95cQ2wtUGUv9AhfyzpC/r4qM1evkh2jDB7lEkVO05bebV4AGAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560483; c=relaxed/simple;
	bh=J1+vjc2CsnpwJmRFquZ5IVX2yWnzrRR8J+oOMY/3nPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1rHqEXtv9JfgroQGUokzo9ddNEIDK/+Gnh1tbZFzk2qq4cHcn93SEuYCQE+vh+7+tECw0/Fv8wuGHO8sCDogg1bsBq64AjudF9haUbxJUDCXcYNmfWPhIqMKnQXuesmUB9m43j3379f22tm0kFeTz67Ku4m8+3vnCN7q2DJerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWvlG4Hv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560482; x=1778096482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1+vjc2CsnpwJmRFquZ5IVX2yWnzrRR8J+oOMY/3nPQ=;
  b=VWvlG4HvKyA77cSTJd9y+wQepRiath+2uOrhO7vM8lFTwOW1rjeRDHp4
   Vc8yWifFLFJxuLs9BQttLxpvpnGM01XTpU8ljInvPu6Tlzn7X61nf7Z+N
   BrbsKnfyDkDwQy47BQU0m3xvd55+Fe66GWlwpFdLlzQyEofrLMxSBirp2
   //3dHBjxblJ2GoBPum2uTMXFjdnF14YDqq8ZHf5mLWiteP8ZoI+oNHwcz
   A9zA1u0f+DtofqTmsGCn73xu/rN7W2Qx1J11ZBF7OpdGJ7IutrIGgfQM6
   EenCte4nBC+O06eDAtSShxhL4Fb2awNYFyef1mhGSJCCodTAAyb5/gRGY
   g==;
X-CSE-ConnectionGUID: 3/+fA4OsT1ad9YSsGp0uoQ==
X-CSE-MsgGUID: YAwTtY5EQYOo3iVcCo3qiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961621"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961621"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:21 -0700
X-CSE-ConnectionGUID: lVpplWLoS7uySFRA3rUT6Q==
X-CSE-MsgGUID: sq36pFiyTCqImdWk6J5gEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465413"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: Add a new version for sta config command
Date: Tue,  6 May 2025 22:40:50 +0300
Message-Id: <20250506194102.3407967-4-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

Add a new version of sta configuration command
which includes these wifi8 features:

1. LDPC X2 CW size support indication
2. Indication if ICF frame is needed instead of RTS
3. support for MIC padding delays for protected control frames

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Message-Id: <20250506223834.e6e095374ee0.If2ff606e20ccf83e9b27ca2f81686108a829896a@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 73 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  8 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  8 +-
 3 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 35a370918251..58690bb6577d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -588,6 +588,62 @@ enum iwl_fw_sta_type {
 	STATION_TYPE_AUX,
 }; /* STATION_TYPE_E_VER_1 */
 
+/**
+ * struct iwl_sta_cfg_cmd_v1 - cmd structure to add a peer sta to the uCode's
+ *	station table
+ * ( STA_CONFIG_CMD = 0xA )
+ *
+ * @sta_id: index of station in uCode's station table
+ * @link_id: the id of the link that is used to communicate with this sta
+ * @peer_mld_address: the peers mld address
+ * @reserved_for_peer_mld_address: reserved
+ * @peer_link_address: the address of the link that is used to communicate
+ *	with this sta
+ * @reserved_for_peer_link_address: reserved
+ * @station_type: type of this station. See &enum iwl_fw_sta_type
+ * @assoc_id: for GO only
+ * @beamform_flags: beam forming controls
+ * @mfp: indicates whether the STA uses management frame protection or not.
+ * @mimo: indicates whether the sta uses mimo or not
+ * @mimo_protection: indicates whether the sta uses mimo protection or not
+ * @ack_enabled: indicates that the AP supports receiving ACK-
+ *	enabled AGG, i.e. both BACK and non-BACK frames in a single AGG
+ * @trig_rnd_alloc: indicates that trigger based random allocation
+ *	is enabled according to UORA element existence
+ * @tx_ampdu_spacing: minimum A-MPDU spacing:
+ *	4 - 2us density, 5 - 4us density, 6 - 8us density, 7 - 16us density
+ * @tx_ampdu_max_size: maximum A-MPDU length: 0 - 8K, 1 - 16K, 2 - 32K,
+ *	3 - 64K, 4 - 128K, 5 - 256K, 6 - 512K, 7 - 1024K.
+ * @sp_length: the size of the SP in actual number of frames
+ * @uapsd_acs:  4 LS bits are trigger enabled ACs, 4 MS bits are the deliver
+ *	enabled ACs.
+ * @pkt_ext: optional, exists according to PPE-present bit in the HE/EHT-PHY
+ *	capa
+ * @htc_flags: which features are supported in HTC
+ */
+struct iwl_sta_cfg_cmd_v1 {
+	__le32 sta_id;
+	__le32 link_id;
+	u8 peer_mld_address[ETH_ALEN];
+	__le16 reserved_for_peer_mld_address;
+	u8 peer_link_address[ETH_ALEN];
+	__le16 reserved_for_peer_link_address;
+	__le32 station_type;
+	__le32 assoc_id;
+	__le32 beamform_flags;
+	__le32 mfp;
+	__le32 mimo;
+	__le32 mimo_protection;
+	__le32 ack_enabled;
+	__le32 trig_rnd_alloc;
+	__le32 tx_ampdu_spacing;
+	__le32 tx_ampdu_max_size;
+	__le32 sp_length;
+	__le32 uapsd_acs;
+	struct iwl_he_pkt_ext_v2 pkt_ext;
+	__le32 htc_flags;
+} __packed; /* STA_CMD_API_S_VER_1 */
+
 /**
  * struct iwl_sta_cfg_cmd - cmd structure to add a peer sta to the uCode's
  *	station table
@@ -620,6 +676,14 @@ enum iwl_fw_sta_type {
  * @pkt_ext: optional, exists according to PPE-present bit in the HE/EHT-PHY
  *	capa
  * @htc_flags: which features are supported in HTC
+ * @use_ldpc_x2_cw: Indicates whether to use LDPC with double CW
+ * @use_icf: Indicates whether to use ICF instead of RTS
+ * @dps_pad_time: DPS (Dynamic Power Save) padding delay resolution to ensure
+ *	proper timing alignment
+ * @dps_trans_delay: DPS minimal time that takes the peer to return to low power
+ * @mic_prep_pad_delay: MIC prep time padding
+ * @mic_compute_pad_delay: MIC compute time padding
+ * @reserved: Reserved for alignment
  */
 struct iwl_sta_cfg_cmd {
 	__le32 sta_id;
@@ -642,7 +706,14 @@ struct iwl_sta_cfg_cmd {
 	__le32 uapsd_acs;
 	struct iwl_he_pkt_ext_v2 pkt_ext;
 	__le32 htc_flags;
-} __packed; /* STA_CMD_API_S_VER_1 */
+	u8 use_ldpc_x2_cw;
+	u8 use_icf;
+	u8 dps_pad_time;
+	u8 dps_trans_delay;
+	u8 mic_prep_pad_delay;
+	u8 mic_compute_pad_delay;
+	u8 reserved[2];
+} __packed; /* STA_CMD_API_S_VER_2 */
 
 /**
  * struct iwl_aux_sta_cmd - command for AUX STA configuration
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index b91f53341cdf..bddeb557fd5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -401,9 +401,11 @@ static u32 iwl_mld_get_htc_flags(struct ieee80211_link_sta *link_sta)
 static int iwl_mld_send_sta_cmd(struct iwl_mld *mld,
 				const struct iwl_sta_cfg_cmd *cmd)
 {
-	int ret = iwl_mld_send_cmd_pdu(mld,
-				       WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD),
-				       cmd);
+	u32 cmd_id = WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD);
+	int cmd_len = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0) > 1 ?
+		      sizeof(*cmd) :
+		      sizeof(struct iwl_sta_cfg_cmd_v1);
+	int ret = iwl_mld_send_cmd_pdu(mld, cmd_id, cmd, cmd_len);
 	if (ret)
 		IWL_ERR(mld, "STA_CONFIG_CMD send failed, ret=0x%x\n", ret);
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 9dd670041137..8f275397fddf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022-2024 Intel Corporation
+ * Copyright (C) 2022-2025 Intel Corporation
  */
 #include "mvm.h"
 #include "time-sync.h"
@@ -48,9 +48,13 @@ u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 static int iwl_mvm_mld_send_sta_cmd(struct iwl_mvm *mvm,
 				    struct iwl_sta_cfg_cmd *cmd)
 {
+	u32 cmd_id = WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD);
+	int cmd_len = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 0) > 1 ?
+		      sizeof(*cmd) :
+		      sizeof(struct iwl_sta_cfg_cmd_v1);
 	int ret = iwl_mvm_send_cmd_pdu(mvm,
 				       WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD),
-				       0, sizeof(*cmd), cmd);
+				       0, cmd_len, cmd);
 	if (ret)
 		IWL_ERR(mvm, "STA_CONFIG_CMD send failed, ret=0x%x\n", ret);
 	return ret;
-- 
2.34.1



Return-Path: <linux-wireless+bounces-7185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C53C8BBF73
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149A01F21716
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEB03FD4;
	Sun,  5 May 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVC0eLlg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600C6FBF
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890029; cv=none; b=OZPKiqeFF6mzRjNJYy2NPq58Pjr7nLPsopHP6lXhWc4I2DFXNfyGq19afLAmK9QpiRdkRMGhGJVYysXMY35j8Q330Kw+sTmLnZ1YMtlVDrFYyzPRPhn8i9MXZwUAX2zZOydKculSbJoH47JsQJg2fcbXI3K3COaW1EhdIhC2ScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890029; c=relaxed/simple;
	bh=PBeT75bxNvNKFP+MsMxDkFkB9Mh0LaxAm1hwlU9D000=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuIiEinQhyPKFQGGdTj7PsT7uH9mq0TmR9Xp+KzGV5HgvdU94VCEWBPTKaGtiIDLAj4jx8BN9oLVaOOW2ogC5bRElXPAnh5L2T7C5hfQxW3NexUINfk6yuXP6+dMla7hJYohX4qJlfwaccnUbc3CC9xSUrYkzqMWtkiCTFKGFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVC0eLlg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890028; x=1746426028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PBeT75bxNvNKFP+MsMxDkFkB9Mh0LaxAm1hwlU9D000=;
  b=RVC0eLlgGb+1TtWo1ac5WNcr8Fel8rGnSQKhQof6mcPl1oSHQ8eWCSN0
   VNJmdKlQrCMPGTBqWljXoWRhZHoY7juSpynXr0RJyC3j3U4pPMCKLyrW7
   aWIbWY6E5hjqcqqnnRzA0RkSi/s2gPnpb4fckEKitQXWYhtdQSWCt1Ch1
   OsUHBug4p0n56xbnrwxQJmrnW5wPwNMzKB/598PAwHRqEWE3fmEUi9KAa
   fGE0HxjDDvfSy2tsnegVZ3O0Sg+uEWlaVtEzmG5m451+X40sV/GHDip3w
   5ou5qh28LTHUsTN36s7ty/MIFJZtd54fyLtu80aIUO0XOTykt/rUZW4eZ
   Q==;
X-CSE-ConnectionGUID: N3gGtGYwT/CWO/Qw+jsUvw==
X-CSE-MsgGUID: VTAuRs/DRbi1KzuU8DcEnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461819"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461819"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:25 -0700
X-CSE-ConnectionGUID: NTcIwnOKT5ich4eO6Omu8w==
X-CSE-MsgGUID: WFdp5fzLRuWX2XyGKgLRaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903611"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: consider FWs recommendation for EMLSR
Date: Sun,  5 May 2024 09:19:51 +0300
Message-Id: <20240505091420.2fd3387882eb.I7a8a5b24658744ed732bfc03b1872c9298483d62@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

FW sends a notification indicating whether activating EMLSR mode is
recommended or not.
Support the notification and enter EMLSR only if recommended.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  7 ++++++
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 23 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 24 +++++++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 0f7903c5a4df..faa7b38df9e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
+ * Copyright (C) 2024 Intel Corporation
  * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
@@ -89,6 +90,12 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	SEC_KEY_CMD = 0x18,
 
+	/**
+	 * @ESR_MODE_NOTIF: notification to recommend/forct a wanted esr mode,
+	 *	uses &struct iwl_mvm_esr_mode_notif
+	 */
+	ESR_MODE_NOTIF = 0xF3,
+
 	/**
 	 * @MONITOR_NOTIF: Datapath monitoring notification, using
 	 *	&struct iwl_datapath_monitor_notif
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index c6d1f5644638..754c5d655ad0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -642,4 +642,25 @@ struct iwl_mvm_sta_disable_tx_cmd {
 	__le32 disable;
 } __packed; /* STA_DISABLE_TX_API_S_VER_1 */
 
+/**
+ * enum iwl_mvm_fw_esr_recommendation - FW recommendation code
+ * @ESR_RECOMMEND_LEAVE: recommendation to leave esr
+ * @ESR_FORCE_LEAVE: force exiting esr
+ * @ESR_RECOMMEND_ENTER: recommendation to enter esr
+ */
+enum iwl_mvm_fw_esr_recommendation {
+	ESR_RECOMMEND_LEAVE,
+	ESR_FORCE_LEAVE,
+	ESR_RECOMMEND_ENTER,
+}; /* ESR_MODE_RECOMMENDATION_CODE_API_E_VER_1 */
+
+/**
+ * struct iwl_mvm_esr_mode_notif - FWs recommendation/force for esr mode
+ *
+ * @action: the action to apply on esr state. See &iwl_mvm_fw_esr_recommendation
+ */
+struct iwl_mvm_esr_mode_notif {
+	__le32 action;
+} __packed; /* ESR_MODE_RECOMMENDATION_NTFY_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_mac_cfg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4c94f753c951..61b3c45e3f0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3949,6 +3949,9 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
 		iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_TPT, 0);
 
+		/* Block until FW notif will arrive */
+		iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_FW, 0);
+
 		/* when client is authorized (AP station marked as such),
 		 * try to enable the best link(s).
 		 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7f1a4ac56397..bc1826450048 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -357,6 +357,7 @@ struct iwl_mvm_vif_link_info {
  *	in a loop.
  * @IWL_MVM_ESR_BLOCKED_WOWLAN: WOWLAN is preventing the enablement of EMLSR
  * @IWL_MVM_ESR_BLOCKED_TPT: block EMLSR when there is not enough traffic
+ * @IWL_MVM_ESR_BLOCKED_FW: FW didn't recommended/forced exit from EMLSR
  * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
  * @IWL_MVM_ESR_EXIT_LOW_RSSI: link is deactivated/not allowed for EMLSR
  *	due to low RSSI.
@@ -367,6 +368,7 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
 	IWL_MVM_ESR_BLOCKED_WOWLAN	= 0x2,
 	IWL_MVM_ESR_BLOCKED_TPT		= 0x4,
+	IWL_MVM_ESR_BLOCKED_FW		= 0x8,
 	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
 	IWL_MVM_ESR_EXIT_LOW_RSSI	= 0x20000,
 	IWL_MVM_ESR_EXIT_COEX		= 0x40000,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index c4528a979add..55ac5552b2f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -145,6 +145,24 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 				       ~APMG_PS_CTRL_EARLY_PWR_OFF_RESET_DIS);
 }
 
+static void iwl_mvm_rx_esr_mode_notif(struct iwl_mvm *mvm,
+				      struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_mvm_esr_mode_notif *notif = (void *)pkt->data;
+	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
+
+	/* FW recommendations is only for entering EMLSR */
+	if (!vif || iwl_mvm_vif_from_mac80211(vif)->esr_active)
+		return;
+
+	if (le32_to_cpu(notif->action) == ESR_RECOMMEND_ENTER)
+		iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_FW);
+	else
+		iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_FW,
+				  iwl_mvm_get_primary_link(vif));
+}
+
 static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 				     struct iwl_rx_cmd_buffer *rxb)
 {
@@ -425,6 +443,11 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       iwl_mvm_channel_switch_error_notif,
 		       RX_HANDLER_ASYNC_UNLOCKED,
 		       struct iwl_channel_switch_error_notif),
+
+	RX_HANDLER_GRP(DATA_PATH_GROUP, ESR_MODE_NOTIF,
+		       iwl_mvm_rx_esr_mode_notif, RX_HANDLER_ASYNC_LOCKED,
+		       struct iwl_mvm_esr_mode_notif),
+
 	RX_HANDLER_GRP(DATA_PATH_GROUP, MONITOR_NOTIF,
 		       iwl_mvm_rx_monitor_notif, RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_datapath_monitor_notif),
@@ -607,6 +630,7 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(CHEST_COLLECTOR_FILTER_CONFIG_CMD),
 	HCMD_NAME(SCD_QUEUE_CONFIG_CMD),
 	HCMD_NAME(SEC_KEY_CMD),
+	HCMD_NAME(ESR_MODE_NOTIF),
 	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(THERMAL_DUAL_CHAIN_REQUEST),
 	HCMD_NAME(STA_PM_NOTIF),
-- 
2.34.1



Return-Path: <linux-wireless+bounces-7514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B36B28C3505
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772E7281C10
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1761E101EC;
	Sun, 12 May 2024 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jG8/7SFX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FB0DDC5
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488291; cv=none; b=Bb+CJ1QIWFv1+NnUGHwEVr1B8wWXxXlWXYSZpMqNKBetnvq2t069cj3LNrK71Y3uWkXSMDOBeKiku47FmBQDKdaYt/mHc+5QlAc4cpAI7HsEHArQ4jElCFZY41mxlEnSL2Gl7iJZGGH9Mf9C1oBCb9ajooa5TYoM1RWEneVUw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488291; c=relaxed/simple;
	bh=1SzQ1KPnrIk+Ueeoge/Wt5FxE0zq+7Itay+4Q5IpxCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EeuxODZI+ItA2PYYIZ+LHSiyX6w3x7KCJ59vZ+8BBA/csA21J0Lxv506XbVbArrlRnvBAy3I4x23gnrMp9g5vOzf4Ind44MNzJvm9v5CW2bvBUI6kKkCUAUv1fwI5OwG7otDS3FRREA3/ZwxMfzEw8VBDl0ScnSMybwFt0U/0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jG8/7SFX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488289; x=1747024289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1SzQ1KPnrIk+Ueeoge/Wt5FxE0zq+7Itay+4Q5IpxCM=;
  b=jG8/7SFXAFQCmdmB2AakLYoj4hEnyGAVzwLpnjzexd3TQ2TfbdlEyrkn
   ieg4waEGpdYjQzqaXFeJ54UJYC/Sw3TI0yuT8ML+2g//68P7xcu8SRLMb
   LHcpLjrbLF98/SnRC5xz2/oJ5NRoHygfagfQ2ICdXVnfTT2kdtEdhw6N/
   5R0iD8AX2JEPw+w5G1u9E2NXdETqCQ9S4EZ8ff8LGO3zflOfs2BR8wUx7
   N6pwcUvDOtPKqY7AjnSXiBD6JrE3W5cAnY3R+m4vUppq3+IKPI1rf/ofX
   dgsEYg7cAg9mvMqpEoUqP+s0FXN5Rl1d+NYBbBa7DM3AbYbZ5lgJzHU5e
   g==;
X-CSE-ConnectionGUID: OSdr/DLvQqed0Z3sI3p1Rw==
X-CSE-MsgGUID: AL8Fdt0+Q3ObIX8lAOpMwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323838"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323838"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:29 -0700
X-CSE-ConnectionGUID: R/hh+3NsShKUR4r2nrbOHQ==
X-CSE-MsgGUID: hNmKBBK0QRyLy8lHM4HmUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532147"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 03/16] wifi: iwlwifi: mvm: add a of print of a few commands
Date: Sun, 12 May 2024 07:30:57 +0300
Message-Id: <20240512072733.65fc46e2ffbc.I19d4ef2cc06bfee7d9644a376d39399f0f6eaa15@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is needed for debugging.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index f19577474f4b..c3cd5ab11aec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -572,6 +572,7 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
 	HCMD_NAME(D0I3_END_CMD),
 	HCMD_NAME(LTR_CONFIG),
 	HCMD_NAME(LDBG_CONFIG_CMD),
+	HCMD_NAME(DEBUG_LOG_MSG),
 };
 
 /* Please keep this array *SORTED* by hex value.
@@ -579,6 +580,7 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
  */
 static const struct iwl_hcmd_names iwl_mvm_system_names[] = {
 	HCMD_NAME(SHARED_MEM_CFG_CMD),
+	HCMD_NAME(SOC_CONFIGURATION_CMD),
 	HCMD_NAME(INIT_EXTENDED_CFG_CMD),
 	HCMD_NAME(FW_ERROR_RECOVERY_CMD),
 	HCMD_NAME(RFI_CONFIG_CMD),
@@ -593,8 +595,10 @@ static const struct iwl_hcmd_names iwl_mvm_system_names[] = {
  * Access is done through binary search
  */
 static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
+	HCMD_NAME(LOW_LATENCY_CMD),
 	HCMD_NAME(CHANNEL_SWITCH_TIME_EVENT_CMD),
 	HCMD_NAME(SESSION_PROTECTION_CMD),
+	HCMD_NAME(CANCEL_CHANNEL_SWITCH_CMD),
 	HCMD_NAME(MAC_CONFIG_CMD),
 	HCMD_NAME(LINK_CONFIG_CMD),
 	HCMD_NAME(STA_CONFIG_CMD),
@@ -603,7 +607,10 @@ static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
 	HCMD_NAME(STA_DISABLE_TX_CMD),
 	HCMD_NAME(ROC_CMD),
 	HCMD_NAME(ROC_NOTIF),
+	HCMD_NAME(CHANNEL_SWITCH_ERROR_NOTIF),
+	HCMD_NAME(MISSED_VAP_NOTIF),
 	HCMD_NAME(SESSION_PROTECTION_NOTIF),
+	HCMD_NAME(PROBE_RESPONSE_DATA_NOTIF),
 	HCMD_NAME(CHANNEL_SWITCH_START_NOTIF),
 };
 
@@ -627,6 +634,8 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(DQA_ENABLE_CMD),
 	HCMD_NAME(UPDATE_MU_GROUPS_CMD),
 	HCMD_NAME(TRIGGER_RX_QUEUES_NOTIF_CMD),
+	HCMD_NAME(WNM_PLATFORM_PTM_REQUEST_CMD),
+	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_CONFIG_CMD),
 	HCMD_NAME(STA_HE_CTXT_CMD),
 	HCMD_NAME(RLC_CONFIG_CMD),
 	HCMD_NAME(RFH_QUEUE_CONFIG_CMD),
@@ -650,6 +659,21 @@ static const struct iwl_hcmd_names iwl_mvm_statistics_names[] = {
 	HCMD_NAME(STATISTICS_OPER_PART1_NOTIF),
 };
 
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mvm_debug_names[] = {
+	HCMD_NAME(LMAC_RD_WR),
+	HCMD_NAME(UMAC_RD_WR),
+	HCMD_NAME(HOST_EVENT_CFG),
+	HCMD_NAME(DBGC_SUSPEND_RESUME),
+	HCMD_NAME(BUFFER_ALLOCATION),
+	HCMD_NAME(GET_TAS_STATUS),
+	HCMD_NAME(FW_DUMP_COMPLETE_CMD),
+	HCMD_NAME(FW_CLEAR_BUFFER),
+	HCMD_NAME(MFU_ASSERT_DUMP_NTF),
+};
+
 /* Please keep this array *SORTED* by hex value.
  * Access is done through binary search
  */
@@ -705,6 +729,7 @@ static const struct iwl_hcmd_arr iwl_mvm_groups[] = {
 	[PROT_OFFLOAD_GROUP] = HCMD_ARR(iwl_mvm_prot_offload_names),
 	[REGULATORY_AND_NVM_GROUP] =
 		HCMD_ARR(iwl_mvm_regulatory_and_nvm_names),
+	[DEBUG_GROUP] = HCMD_ARR(iwl_mvm_debug_names),
 	[STATISTICS_GROUP] = HCMD_ARR(iwl_mvm_statistics_names),
 };
 
-- 
2.34.1



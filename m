Return-Path: <linux-wireless+bounces-6379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577668A6920
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A450DB22E1A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBF2128820;
	Tue, 16 Apr 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZDQ4vH8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E21292CE
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264866; cv=none; b=M750weTo8ikk2EJzrhyRd5MxsNQZVPwdpzOASZqjYWzm1j4k2r11tgfFx7y1gv2mlwklvihvAEesm/aRSoSvjKEm7f2z9u0DU42HjqNPhWS19EHeo3UGcq7AtMRVXvDk/WG1lhhO2kKUyY7u7I1hEZJDeadg1tuURu1l+4zvERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264866; c=relaxed/simple;
	bh=7+17QiYZOHMTD7gdFlPuRTueDaZ87z2PgZTJNYmgPF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EiiG/isQj+OBoCKsXhhvKSZXjUn6dRL8RE+594mmjdlOvHPaA0mkw5HpW0utq2lHTx94K3cfuFIx68r7E2EZ54/hWuFbiuGzKEDV1TmuxcXLyXjwppzgvHsdOFnc/gFs3PgPxugBT/wQR2W8ZSvDPbA+Om4M+dkk/0gRUu25ld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZDQ4vH8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264865; x=1744800865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7+17QiYZOHMTD7gdFlPuRTueDaZ87z2PgZTJNYmgPF4=;
  b=QZDQ4vH8c4f0el0N5+mIeoLiPLn0yBjPEOr06nC39Y9q738qsHDvSNHq
   LHEVSkMfnahht6RF3Gowdlzwy2XVzQwE5I52VbGQUmAy6U3ZoDOeul8LT
   pcs3qoWsXmmsw7qCzvLn+/4Fw93Tvo1/NoMrZ73gDu/DnId8FqYktzuj6
   FEjBOpJWikupWM4Tw0+rmM09toV46MTC/Ka0ubJAYv42fiHoYA3Pwj3Ct
   iPbH8FJ5LpGypcyGgsO+/233JZVSO1c0EWlnglsjvk3aNPW6+Q34cU2xZ
   y3AW3vculZalIt9/8JybVGP1w5J9A4HYlZJdyDXOWL1gXq9EYE5xEjRqn
   w==;
X-CSE-ConnectionGUID: 7/nKHxiGQ6yio4VzSxhjow==
X-CSE-MsgGUID: Z3BEXBpGTeqmQcwjUbXrDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556030"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556030"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:25 -0700
X-CSE-ConnectionGUID: Gi7IDEPwScWt/qUvRAjIuw==
X-CSE-MsgGUID: PdBYaUXPQp+BajqnVH5mPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872412"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Subject: [PATCH 02/16] wifi: iwlwifi: mvm: send ap_tx_power_constraints cmd to FW in AP mode
Date: Tue, 16 Apr 2024 13:53:57 +0300
Message-Id: <20240416134215.b6af4ecfcfe8.I07e8db349190e0c58c468c18477d8551288ac069@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Send AP_TX_POWER_CONSTRAINTS_CMD with no local maximum transmit
power constraint to FW and FW will update the TPE element with
required tx power limits.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |  7 ++-
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 42 +++++++++++++++-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 50 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
index 5a3f30e5e06d..92e4b62c119f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2019-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2019-2022, 2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -42,6 +42,11 @@ enum iwl_phy_ops_subcmd_ids {
 	 */
 	PER_PLATFORM_ANT_GAIN_CMD = 0x07,
 
+	/**
+	 * @AP_TX_POWER_CONSTRAINTS_CMD: &struct iwl_txpower_constraints_cmd
+	 */
+	AP_TX_POWER_CONSTRAINTS_CMD = 0x0C,
+
 	/**
 	 * @CT_KILL_NOTIFICATION: &struct ct_kill_notif
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 8f84d4733b63..532d5cfa9162 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -732,4 +732,44 @@ struct iwl_beacon_filter_cmd {
 
 #define IWL_BF_CMD_CONFIG_DEFAULTS IWL_BF_CMD_CONFIG(_DEFAULT)
 #define IWL_BF_CMD_CONFIG_D0I3 IWL_BF_CMD_CONFIG(_D0I3)
+
+#define DEFAULT_TPE_TX_POWER 0x7F
+
+/*
+ *  Bandwidth: 20/40/80/(160/80+80)/320
+ */
+#define IWL_MAX_TX_EIRP_PWR_MAX_SIZE 5
+#define IWL_MAX_TX_EIRP_PSD_PWR_MAX_SIZE 16
+
+enum iwl_6ghz_ap_type {
+	IWL_6GHZ_AP_TYPE_LPI,
+	IWL_6GHZ_AP_TYPE_SP,
+	IWL_6GHZ_AP_TYPE_VLP,
+}; /* PHY_AP_TYPE_API_E_VER_1 */
+
+/**
+ * struct iwl_txpower_constraints_cmd
+ * AP_TX_POWER_CONSTRAINTS_CMD
+ * Used for VLP/LPI/AFC Access Point power constraints for 6GHz channels
+ * @link_id: linkId
+ * @ap_type: see &enum iwl_ap_type
+ * @eirp_pwr: 8-bit 2s complement signed integer in the range
+ *	-64 dBm to 63 dBm with a 0.5 dB step
+ *	default &DEFAULT_TPE_TX_POWER (no maximum limit)
+ * @psd_pwr: 8-bit 2s complement signed integer in the range
+ *	-63.5 to +63 dBm/MHz with a 0.5 step
+ *	value - 128 indicates that the corresponding 20
+ *	MHz channel cannot be used for transmission.
+ *	value +127 indicates that no maximum PSD limit
+ *	is specified for the corresponding 20 MHz channel
+ *	default &DEFAULT_TPE_TX_POWER (no maximum limit)
+ * @reserved: reserved (padding)
+ */
+struct iwl_txpower_constraints_cmd {
+	__le16 link_id;
+	__le16 ap_type;
+	__s8 eirp_pwr[IWL_MAX_TX_EIRP_PWR_MAX_SIZE];
+	__s8 psd_pwr[IWL_MAX_TX_EIRP_PSD_PWR_MAX_SIZE];
+	u8 reserved[3];
+} __packed; /* PHY_AP_TX_POWER_CONSTRAINTS_CMD_API_S_VER_1 */
 #endif /* __iwl_fw_api_power_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 7a2a18f8b86e..bcf2fd23300f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -468,6 +468,52 @@ static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
+static void
+iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *bss_conf)
+{
+	struct iwl_txpower_constraints_cmd cmd = {};
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *link_info =
+			mvmvif->link[bss_conf->link_id];
+	u32 cmd_id = WIDE_ID(PHY_OPS_GROUP, AP_TX_POWER_CONSTRAINTS_CMD);
+	u32 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
+					    IWL_FW_CMD_VER_UNKNOWN);
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (cmd_ver == IWL_FW_CMD_VER_UNKNOWN)
+		return;
+
+	if (!link_info->active ||
+	    link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)
+		return;
+
+	if (bss_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ ||
+	    bss_conf->chanreq.oper.chan->flags &
+		    IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT)
+		return;
+
+	cmd.link_id = cpu_to_le16(link_info->fw_link_id);
+	/*
+	 * Currently supporting VLP Soft AP only.
+	 */
+	cmd.ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
+	memset(cmd.psd_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.psd_pwr));
+	memset(cmd.eirp_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.eirp_pwr));
+
+	ret = iwl_mvm_send_cmd_pdu(mvm,
+				   WIDE_ID(PHY_OPS_GROUP,
+					   AP_TX_POWER_CONSTRAINTS_CMD),
+				   0, sizeof(cmd), &cmd);
+	if (ret)
+		IWL_ERR(mvm,
+			"failed to send AP_TX_POWER_CONSTRAINTS_CMD (%d)\n",
+			ret);
+}
+
 static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *link_conf)
@@ -477,6 +523,10 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	int ret;
 
 	mutex_lock(&mvm->mutex);
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif, link_conf);
+
 	/* Send the beacon template */
 	ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf);
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index a93981cb9714..5cdad4dfa699 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -586,6 +586,7 @@ static const struct iwl_hcmd_names iwl_mvm_phy_names[] = {
 	HCMD_NAME(CTDP_CONFIG_CMD),
 	HCMD_NAME(TEMP_REPORTING_THRESHOLDS_CMD),
 	HCMD_NAME(PER_CHAIN_LIMIT_OFFSET_CMD),
+	HCMD_NAME(AP_TX_POWER_CONSTRAINTS_CMD),
 	HCMD_NAME(CT_KILL_NOTIFICATION),
 	HCMD_NAME(DTS_MEASUREMENT_NOTIF_WIDE),
 };
-- 
2.34.1



Return-Path: <linux-wireless+bounces-36333-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP8UCfqAA2pB6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36333-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:35:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DD5528AF0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94FB7300A7E0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4793E299959;
	Tue, 12 May 2026 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1pSzKST"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126D368D58
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614504; cv=none; b=CxdZrTXYkWSZ/PlsN44ZEZw4Y4bYx2k4UyvOw3E3fvcTMb2ymCBALHrtTXP3kZnHjERfzoAymqvgYyLs53ysW+cGh0yTe6wIRjk226dEw8xUdm4wkIlEyiYyaERrBKkdSl8O+Zzib8c8qscfWdC4/ilOhF3ID7EIiHYf8u89tUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614504; c=relaxed/simple;
	bh=26gXqSsZqpmfv8RLp0S8MyAlzFk/Af1A6Ae8SC+0x38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=po+doXg1Z1cJEuDGP38EB6O+SKzqvroEvnR+YowV9lKzJZN1FX7Y2ZuLJHgs66HybXOKcTVjN2QYXcUv7IbVc0a3eiZqn76aceTJPxO2cBJuShDf6o5uUSSDIPGGp+2+6uW1jpS2DmF8ABOGTHCIDr/DO6s5w+LBku53WpJSSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1pSzKST; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614502; x=1810150502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=26gXqSsZqpmfv8RLp0S8MyAlzFk/Af1A6Ae8SC+0x38=;
  b=g1pSzKSTMiqgEj8qew9wuR1sdjUN6lENsCihol2aCcrD31x43yr1s04D
   9H8cuMjuK2NDWTlNA9aIPKAcmMX3hBUhTUmnj6GYmj1WHdYpAufgP9JVv
   xR2ik5ECiFnORVJp/920k0sAtM+U045qYoG1eWmEFphhfzM2sH3tkXoNP
   25CCNuH47lPIRt3G8t44pjWX6e+0tJnzdfRXf+yiu3pQtFPPZimfu+IHa
   M20pJZEQcteg971xF8IcBiUljfFYWaeCVhLCasb2CASDGWIngheA3kaqT
   zQ8d1kuYJbXdRhy4sz9Sr9pC1ebeTYv8ugTH8PVnzQEObnFKpuunXxYRB
   Q==;
X-CSE-ConnectionGUID: Vg9tazi3SCiuNkmAvtGDtQ==
X-CSE-MsgGUID: waJVBR9kTqKGPX2Y+M1ttg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148781"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148781"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:02 -0700
X-CSE-ConnectionGUID: I+RvggXCRv6mXbyg/GacMw==
X-CSE-MsgGUID: lMOWyhr9Rb20E74NOHN1Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471734"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: Transition to basic uAPSD with MAC_PM_POWER_TABLE API VER_3
Date: Tue, 12 May 2026 22:34:32 +0300
Message-Id: <20260512222731.96b6f53c8708.I4f01b97b25d91ebb1561845d7925103e274574fa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
References: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A3DD5528AF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36333-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Avinash Bhatt <avinash.bhatt@intel.com>

uAPSD is transitioning to a certification-only feature. The new
firmware API version 3 removes advanced uAPSD fields, keeping only
basic parameters needed for certification testing.

Support the new VER_3 API in the MLD driver while maintaining
backward compatibility with VER_1/2. The MVM driver continues
using VER_2 only. Remove the obsolete PSM_UAPSD_AP_MISBEHAVING_NOTIFICATION
notification from the MLD driver

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  48 ++++-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  18 --
 .../net/wireless/intel/iwlwifi/mld/iface.h    |   3 -
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   1 -
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   6 -
 .../net/wireless/intel/iwlwifi/mld/power.c    | 177 ++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  14 +-
 8 files changed, 214 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index a3f916630df2..115e65ba19f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -85,12 +85,13 @@ struct iwl_ltr_config_cmd {
  *		'1' PM could sleep over DTIM till listen Interval.
  * @POWER_FLAGS_SNOOZE_ENA_MSK: Enable snoozing only if uAPSD is enabled and all
  *		access categories are both delivery and trigger enabled.
+ *		(Not supported since version 3)
  * @POWER_FLAGS_BT_SCO_ENA: Enable BT SCO coex only if uAPSD and
  *		PBW Snoozing enabled
  * @POWER_FLAGS_ADVANCE_PM_ENA_MSK: Advanced PM (uAPSD) enable mask
  * @POWER_FLAGS_LPRX_ENA_MSK: Low Power RX enable.
  * @POWER_FLAGS_UAPSD_MISBEHAVING_ENA_MSK: AP/GO's uAPSD misbehaving
- *		detection enablement
+ *		detection enablement (Not supported since version 3)
  * @POWER_FLAGS_ENABLE_SMPS_MSK: SMPS is allowed for this vif
 */
 enum iwl_power_flags {
@@ -175,9 +176,9 @@ struct iwl_device_power_cmd {
 } __packed;
 
 /**
- * struct iwl_mac_power_cmd - New power command containing uAPSD support
+ * struct iwl_mac_power_cmd_v2 - power command V2 containing uAPSD support
  * MAC_PM_POWER_TABLE = 0xA9 (command, has simple generic response)
- * @id_and_color:	MAC contex identifier, &enum iwl_ctxt_id_and_color
+ * @id_and_color:	MAC context identifier, &enum iwl_ctxt_id_and_color
  * @flags:		Power table command flags from POWER_FLAGS_*
  * @keep_alive_seconds:	Keep alive period in seconds. Default - 25 sec.
  *			Minimum allowed:- 3 * DTIM. Keep alive period must be
@@ -216,7 +217,7 @@ struct iwl_device_power_cmd {
  * @limited_ps_threshold: (unused)
  * @reserved: reserved (padding)
  */
-struct iwl_mac_power_cmd {
+struct iwl_mac_power_cmd_v2 {
 	/* CONTEXT_DESC_API_T_VER_1 */
 	__le32 id_and_color;
 
@@ -242,6 +243,43 @@ struct iwl_mac_power_cmd {
 	u8 reserved;
 } __packed; /* CLIENT_PM_POWER_TABLE_S_VER_1, VER_2 */
 
+/**
+ * struct iwl_mac_power_cmd - power command
+ * MAC_PM_POWER_TABLE = 0xA9 (command, has simple generic response)
+ * @id_and_color:	MAC context identifier, &enum iwl_ctxt_id_and_color
+ * @flags:		Power table command flags from POWER_FLAGS_*
+ * @keep_alive_seconds:	Keep alive period in seconds. Default - 25 sec.
+ *			Minimum allowed:- 3 * DTIM. Keep alive period must be
+ *			set regardless of power scheme or current power state.
+ *			FW use this value also when PM is disabled.
+ * @rx_data_timeout:    Minimum time (usec) from last Rx packet for AM to
+ *			PSM transition - legacy PM
+ * @tx_data_timeout:    Minimum time (usec) from last Tx packet for AM to
+ *			PSM transition - legacy PM
+ * @lprx_rssi_threshold: Signal strength up to which LP RX can be enabled.
+ *			Default: 80dbm
+ * @skip_dtim_periods:	Number of DTIM periods to skip if Skip over DTIM flag
+ *			is set. For example, if it is required to skip over
+ *			one DTIM, this value need to be set to 2 (DTIM periods).
+ * @qndp_tid:		TID client shall use for uAPSD QNDP triggers
+ * @uapsd_ac_flags:	Set trigger-enabled and delivery-enabled indication for
+ *			each corresponding AC.
+ *			Use IEEE80211_WMM_IE_STA_QOSINFO_AC* for correct values.
+ */
+struct iwl_mac_power_cmd {
+	/* CONTEXT_DESC_API_T_VER_1 */
+	__le32 id_and_color;
+
+	__le16 flags;
+	__le16 keep_alive_seconds;
+	__le32 rx_data_timeout;
+	__le32 tx_data_timeout;
+	u8 lprx_rssi_threshold;
+	u8 skip_dtim_periods;
+	u8 qndp_tid;
+	u8 uapsd_ac_flags;
+} __packed; /* CLIENT_PM_POWER_TABLE_S_VER_3 */
+
 /*
  * struct iwl_uapsd_misbehaving_ap_notif - FW sends this notification when
  * associated AP is identified as improperly implementing uAPSD protocol.
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 5fc3f6729455..4fe57d79daa6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -739,24 +739,6 @@ void iwl_mld_handle_probe_resp_data_notif(struct iwl_mld *mld,
 		kfree_rcu(old_data, rcu_head);
 }
 
-void iwl_mld_handle_uapsd_misbehaving_ap_notif(struct iwl_mld *mld,
-					       struct iwl_rx_packet *pkt)
-{
-	struct iwl_uapsd_misbehaving_ap_notif *notif = (void *)pkt->data;
-	struct ieee80211_vif *vif;
-
-	if (IWL_FW_CHECK(mld, notif->mac_id >= ARRAY_SIZE(mld->fw_id_to_vif),
-			 "mac id is invalid: %d\n", notif->mac_id))
-		return;
-
-	vif = wiphy_dereference(mld->wiphy, mld->fw_id_to_vif[notif->mac_id]);
-
-	if (WARN_ON(!vif) || ieee80211_vif_is_mld(vif))
-		return;
-
-	IWL_WARN(mld, "uapsd misbehaving AP: %pM\n", vif->bss_conf.bssid);
-}
-
 void iwl_mld_handle_datapath_monitor_notif(struct iwl_mld *mld,
 					   struct iwl_rx_packet *pkt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 71c794204475..d6fb58e785e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -274,9 +274,6 @@ void iwl_mld_handle_probe_resp_data_notif(struct iwl_mld *mld,
 void iwl_mld_handle_datapath_monitor_notif(struct iwl_mld *mld,
 					   struct iwl_rx_packet *pkt);
 
-void iwl_mld_handle_uapsd_misbehaving_ap_notif(struct iwl_mld *mld,
-					       struct iwl_rx_packet *pkt);
-
 void iwl_mld_reset_cca_40mhz_workaround(struct iwl_mld *mld,
 					struct ieee80211_vif *vif);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 9a3b768fce7a..25bab6ab6375 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -162,7 +162,6 @@ static const struct iwl_hcmd_names iwl_mld_legacy_names[] = {
 	HCMD_NAME(PHY_CONFIGURATION_CMD),
 	HCMD_NAME(SCAN_OFFLOAD_UPDATE_PROFILES_CMD),
 	HCMD_NAME(POWER_TABLE_CMD),
-	HCMD_NAME(PSM_UAPSD_AP_MISBEHAVING_NOTIFICATION),
 	HCMD_NAME(BEACON_NOTIFICATION),
 	HCMD_NAME(BEACON_TEMPLATE_CMD),
 	HCMD_NAME(TX_ANT_CONFIGURATION_CMD),
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 4e9f3768c381..1c81152042ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -339,8 +339,6 @@ CMD_VERSIONS(emlsr_mode_notif,
 	     CMD_VER_ENTRY(2, iwl_esr_mode_notif))
 CMD_VERSIONS(emlsr_trans_fail_notif,
 	     CMD_VER_ENTRY(1, iwl_esr_trans_fail_notif))
-CMD_VERSIONS(uapsd_misbehaving_ap_notif,
-	     CMD_VER_ENTRY(1, iwl_uapsd_misbehaving_ap_notif))
 CMD_VERSIONS(time_msmt_notif,
 	     CMD_VER_ENTRY(1, iwl_time_msmt_notify))
 CMD_VERSIONS(time_sync_confirm_notif,
@@ -363,8 +361,6 @@ DEFINE_SIMPLE_CANCELLATION(scan_complete, iwl_umac_scan_complete, uid)
 DEFINE_SIMPLE_CANCELLATION(scan_start, iwl_umac_scan_start, uid)
 DEFINE_SIMPLE_CANCELLATION(probe_resp_data, iwl_probe_resp_data_notif,
 			   mac_id)
-DEFINE_SIMPLE_CANCELLATION(uapsd_misbehaving_ap, iwl_uapsd_misbehaving_ap_notif,
-			   mac_id)
 DEFINE_SIMPLE_CANCELLATION(ftm_resp, iwl_tof_range_rsp_ntfy, request_id)
 DEFINE_SIMPLE_CANCELLATION(beacon_filter, iwl_beacon_filter_notif, link_id)
 
@@ -455,8 +451,6 @@ const struct iwl_rx_handler iwl_mld_rx_handlers[] = {
 			     emlsr_mode_notif, RX_HANDLER_ASYNC)
 	RX_HANDLER_NO_OBJECT(MAC_CONF_GROUP, EMLSR_TRANS_FAIL_NOTIF,
 			     emlsr_trans_fail_notif, RX_HANDLER_ASYNC)
-	RX_HANDLER_OF_VIF(LEGACY_GROUP, PSM_UAPSD_AP_MISBEHAVING_NOTIFICATION,
-			  uapsd_misbehaving_ap_notif)
 	RX_HANDLER_NO_OBJECT(LEGACY_GROUP,
 			     WNM_80211V_TIMING_MEASUREMENT_NOTIFICATION,
 			     time_msmt_notif, RX_HANDLER_SYNC)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/power.c b/drivers/net/wireless/intel/iwlwifi/mld/power.c
index fe71da8b9c89..da065a446f81 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/power.c
@@ -88,10 +88,10 @@ static bool iwl_mld_power_is_radar(struct iwl_mld *mld,
 	return chanctx_conf->def.chan->flags & IEEE80211_CHAN_RADAR;
 }
 
-static void iwl_mld_power_configure_uapsd(struct iwl_mld *mld,
-					  struct iwl_mld_link *link,
-					  struct iwl_mac_power_cmd *cmd,
-					  bool ps_poll)
+static void iwl_mld_power_configure_uapsd_v2(struct iwl_mld *mld,
+					     struct iwl_mld_link *link,
+					     struct iwl_mac_power_cmd_v2 *cmd,
+					     bool ps_poll)
 {
 	bool tid_found = false;
 
@@ -150,10 +150,54 @@ static void iwl_mld_power_configure_uapsd(struct iwl_mld *mld,
 	cmd->uapsd_max_sp = mld->hw->uapsd_max_sp_len;
 }
 
+static void iwl_mld_power_configure_uapsd(struct iwl_mld *mld,
+					  struct iwl_mld_link *link,
+					  struct iwl_mac_power_cmd *cmd,
+					  bool ps_poll)
+{
+	bool tid_found = false;
+
+	/* set advanced pm flag with no uapsd ACs to enable ps-poll */
+	if (ps_poll) {
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_ADVANCE_PM_ENA_MSK);
+		return;
+	}
+
+	for (enum ieee80211_ac_numbers ac = IEEE80211_AC_VO;
+	     ac <= IEEE80211_AC_BK;
+	     ac++) {
+		if (!link->queue_params[ac].uapsd)
+			continue;
+
+		cmd->flags |=
+			cpu_to_le16(POWER_FLAGS_ADVANCE_PM_ENA_MSK);
+		cmd->uapsd_ac_flags |= BIT(ac);
+
+		/* QNDP TID - the highest TID with no admission control */
+		if (!tid_found && !link->queue_params[ac].acm) {
+			tid_found = true;
+			switch (ac) {
+			case IEEE80211_AC_VO:
+				cmd->qndp_tid = 6;
+				break;
+			case IEEE80211_AC_VI:
+				cmd->qndp_tid = 5;
+				break;
+			case IEEE80211_AC_BE:
+				cmd->qndp_tid = 0;
+				break;
+			case IEEE80211_AC_BK:
+				cmd->qndp_tid = 1;
+				break;
+			}
+		}
+	}
+}
+
 static void
 iwl_mld_power_config_skip_dtim(struct iwl_mld *mld,
 			       const struct ieee80211_bss_conf *link_conf,
-			       struct iwl_mac_power_cmd *cmd)
+			       u8 *skip_dtim_periods, __le16 *flags)
 {
 	unsigned int dtimper_tu;
 	unsigned int dtimper;
@@ -171,15 +215,15 @@ iwl_mld_power_config_skip_dtim(struct iwl_mld *mld,
 	/* configure skip over dtim up to 900 TU DTIM interval */
 	skip = max_t(int, 1, 900 / dtimper_tu);
 
-	cmd->skip_dtim_periods = skip;
-	cmd->flags |= cpu_to_le16(POWER_FLAGS_SKIP_OVER_DTIM_MSK);
+	*skip_dtim_periods = skip;
+	*flags |= cpu_to_le16(POWER_FLAGS_SKIP_OVER_DTIM_MSK);
 }
 
 #define POWER_KEEP_ALIVE_PERIOD_SEC    25
-static void iwl_mld_power_build_cmd(struct iwl_mld *mld,
-				    struct ieee80211_vif *vif,
-				    struct iwl_mac_power_cmd *cmd,
-				    bool d3)
+static void iwl_mld_power_build_cmd_v2(struct iwl_mld *mld,
+				       struct ieee80211_vif *vif,
+				       struct iwl_mac_power_cmd_v2 *cmd,
+				       bool d3)
 {
 	int dtimper, bi;
 	int keep_alive;
@@ -238,7 +282,9 @@ static void iwl_mld_power_build_cmd(struct iwl_mld *mld,
 	}
 
 	if (d3) {
-		iwl_mld_power_config_skip_dtim(mld, link_conf, cmd);
+		iwl_mld_power_config_skip_dtim(mld, link_conf,
+					       &cmd->skip_dtim_periods,
+					       &cmd->flags);
 		cmd->rx_data_timeout =
 			cpu_to_le32(IWL_MLD_WOWLAN_PS_RX_DATA_TIMEOUT);
 		cmd->tx_data_timeout =
@@ -259,6 +305,95 @@ static void iwl_mld_power_build_cmd(struct iwl_mld *mld,
 	 * mac80211 will allow uAPSD. Always call iwl_mld_power_configure_uapsd
 	 * which will look at what mac80211 is saying.
 	 */
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	ps_poll = mld_vif->use_ps_poll;
+#endif
+	iwl_mld_power_configure_uapsd_v2(mld, link, cmd, ps_poll);
+}
+
+static void iwl_mld_power_build_cmd(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif,
+				    struct iwl_mac_power_cmd *cmd,
+				    bool d3)
+{
+	int dtimper, bi;
+	int keep_alive;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct ieee80211_bss_conf *link_conf = &vif->bss_conf;
+	struct iwl_mld_link *link = &mld_vif->deflink;
+	bool ps_poll = false;
+	__le32 fw_id = cpu_to_le32(mld_vif->fw_id);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		int link_id;
+
+		if (WARN_ON(!vif->active_links))
+			return;
+
+		/* The firmware consumes one single configuration for the vif
+		 * and can't differentiate between links, just pick the lowest
+		 * link_id's configuration and use that.
+		 */
+		link_id = __ffs(vif->active_links);
+		link_conf = link_conf_dereference_check(vif, link_id);
+		link = iwl_mld_link_dereference_check(mld_vif, link_id);
+
+		if (WARN_ON(!link_conf || !link))
+			return;
+	}
+	dtimper = link_conf->dtim_period;
+	bi = link_conf->beacon_int;
+
+	/* Regardless of power management state the driver must set
+	 * keep alive period. FW will use it for sending keep alive NDPs
+	 * immediately after association. Check that keep alive period
+	 * is at least 3 * DTIM
+	 */
+	keep_alive = DIV_ROUND_UP(ieee80211_tu_to_usec(3 * dtimper * bi),
+				  USEC_PER_SEC);
+	keep_alive = max(keep_alive, POWER_KEEP_ALIVE_PERIOD_SEC);
+
+	cmd->id_and_color = fw_id;
+	cmd->keep_alive_seconds = cpu_to_le16(keep_alive);
+
+	if (iwlmld_mod_params.power_scheme != IWL_POWER_SCHEME_CAM)
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_POWER_SAVE_ENA_MSK);
+
+	if (vif->cfg.ps && iwl_mld_tdls_sta_count(mld) == 0) {
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_POWER_MANAGEMENT_ENA_MSK);
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_ENABLE_SMPS_MSK);
+
+		/* firmware supports LPRX for beacons at rate 1 Mbps or
+		 * 6 Mbps only
+		 */
+		if (link_conf->beacon_rate &&
+		    (link_conf->beacon_rate->bitrate == 10 ||
+		     link_conf->beacon_rate->bitrate == 60)) {
+			cmd->flags |= cpu_to_le16(POWER_FLAGS_LPRX_ENA_MSK);
+			cmd->lprx_rssi_threshold = POWER_LPRX_RSSI_THRESHOLD;
+		}
+	}
+
+	if (d3) {
+		iwl_mld_power_config_skip_dtim(mld, link_conf,
+					       &cmd->skip_dtim_periods,
+					       &cmd->flags);
+		cmd->rx_data_timeout =
+			cpu_to_le32(IWL_MLD_WOWLAN_PS_RX_DATA_TIMEOUT);
+		cmd->tx_data_timeout =
+			cpu_to_le32(IWL_MLD_WOWLAN_PS_TX_DATA_TIMEOUT);
+	} else if (iwl_mld_vif_low_latency(mld_vif) && vif->p2p) {
+		cmd->tx_data_timeout =
+			cpu_to_le32(IWL_MLD_SHORT_PS_TX_DATA_TIMEOUT);
+		cmd->rx_data_timeout =
+			cpu_to_le32(IWL_MLD_SHORT_PS_RX_DATA_TIMEOUT);
+	} else {
+		cmd->rx_data_timeout =
+			cpu_to_le32(IWL_MLD_DEFAULT_PS_RX_DATA_TIMEOUT);
+		cmd->tx_data_timeout =
+			cpu_to_le32(IWL_MLD_DEFAULT_PS_TX_DATA_TIMEOUT);
+	}
+
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	ps_poll = mld_vif->use_ps_poll;
 #endif
@@ -268,11 +403,23 @@ static void iwl_mld_power_build_cmd(struct iwl_mld *mld,
 int iwl_mld_update_mac_power(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			     bool d3)
 {
-	struct iwl_mac_power_cmd cmd = {};
+	int cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, MAC_PM_POWER_TABLE, 0);
 
-	iwl_mld_power_build_cmd(mld, vif, &cmd, d3);
+	if (cmd_ver >= 3) {
+		struct iwl_mac_power_cmd cmd = {};
 
-	return iwl_mld_send_cmd_pdu(mld, MAC_PM_POWER_TABLE, &cmd);
+		iwl_mld_power_build_cmd(mld, vif, &cmd, d3);
+		return iwl_mld_send_cmd_with_flags_pdu(mld,
+						       MAC_PM_POWER_TABLE, 0,
+						       &cmd, sizeof(cmd));
+	} else {
+		struct iwl_mac_power_cmd_v2 cmd = {};
+
+		iwl_mld_power_build_cmd_v2(mld, vif, &cmd, d3);
+		return iwl_mld_send_cmd_with_flags_pdu(mld,
+						       MAC_PM_POWER_TABLE, 0,
+						       &cmd, sizeof(cmd));
+	}
 }
 
 static void
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 402ba5dee8b2..be89b84204fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -469,7 +469,7 @@ struct iwl_mvm_vif {
 	struct dentry *dbgfs_slink;
 	struct iwl_dbgfs_pm dbgfs_pm;
 	struct iwl_dbgfs_bf dbgfs_bf;
-	struct iwl_mac_power_cmd mac_pwr_cmd;
+	struct iwl_mac_power_cmd_v2 mac_pwr_cmd;
 	int dbgfs_quota_min;
 	bool ftm_unprotected;
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 610de29b7be0..46792c508753 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2026 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -83,7 +83,7 @@ void iwl_mvm_beacon_filter_set_cqm_params(struct iwl_mvm *mvm,
 }
 
 static void iwl_mvm_power_log(struct iwl_mvm *mvm,
-			      struct iwl_mac_power_cmd *cmd)
+			      struct iwl_mac_power_cmd_v2 *cmd)
 {
 	IWL_DEBUG_POWER(mvm,
 			"Sending power table command on mac id 0x%X for power level %d, flags = 0x%X\n",
@@ -121,7 +121,7 @@ static void iwl_mvm_power_log(struct iwl_mvm *mvm,
 
 static void iwl_mvm_power_configure_uapsd(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
-					  struct iwl_mac_power_cmd *cmd)
+					  struct iwl_mac_power_cmd_v2 *cmd)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	enum ieee80211_ac_numbers ac;
@@ -296,7 +296,7 @@ static bool iwl_mvm_power_is_radar(struct ieee80211_bss_conf *link_conf)
 
 static void iwl_mvm_power_config_skip_dtim(struct iwl_mvm *mvm,
 					   struct ieee80211_vif *vif,
-					   struct iwl_mac_power_cmd *cmd)
+					   struct iwl_mac_power_cmd_v2 *cmd)
 {
 	struct ieee80211_bss_conf *link_conf;
 	unsigned int min_link_skip = ~0;
@@ -344,7 +344,7 @@ static void iwl_mvm_power_config_skip_dtim(struct iwl_mvm *mvm,
 
 static void iwl_mvm_power_build_cmd(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif,
-				    struct iwl_mac_power_cmd *cmd)
+				    struct iwl_mac_power_cmd_v2 *cmd)
 {
 	int dtimper, bi;
 	int keep_alive;
@@ -466,7 +466,7 @@ static void iwl_mvm_power_build_cmd(struct iwl_mvm *mvm,
 static int iwl_mvm_power_send_cmd(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif)
 {
-	struct iwl_mac_power_cmd cmd = {};
+	struct iwl_mac_power_cmd_v2 cmd = {};
 
 	iwl_mvm_power_build_cmd(mvm, vif, &cmd);
 	iwl_mvm_power_log(mvm, &cmd);
@@ -717,7 +717,7 @@ int iwl_mvm_power_mac_dbgfs_read(struct iwl_mvm *mvm,
 				 int bufsz)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mac_power_cmd cmd = {};
+	struct iwl_mac_power_cmd_v2 cmd = {};
 	int pos = 0;
 
 	mutex_lock(&mvm->mutex);
-- 
2.34.1



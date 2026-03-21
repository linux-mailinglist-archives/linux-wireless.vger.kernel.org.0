Return-Path: <linux-wireless+bounces-33632-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNwmK5PVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33632-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:29:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CAB2E6884
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05764301724C
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FC533AD85;
	Sat, 21 Mar 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amCgI4oN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C1334C33
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114182; cv=none; b=P54PZqF7NUJ2i+cP0pSxPO5mKNe0ovyv6ywpeT2Pn8b1dlG3JTmo+7GdcDmdHdDiTIpIykkCAXlfhEa4IpCBebLCydf/Y3jvh/fa1zeZklTHZ02vAt9gFVbnXvMXyPyu2GsaaEUdKAPP4WJodTFUr1fwGY6zihov232jHdGvp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114182; c=relaxed/simple;
	bh=8/8Nm0Tej7P2LvyPAh/TyRMBUg+j4O974fl4xeSgmjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CX8PqSlflgICZoNNsZo3quAbFn7lgH2a1lCcalPyrTy3EY5FEvZKtzBfqsEO/HisyE1mTmu6fqD/yTqzSC3wZ46zHGi/F/kn+pekyEhHxyG2Yz+jkDuMow9Kp/nLFb/4tlEn2N/I6MXewTzFeSfWZyiqIST4SOlrbRCzAQsE4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amCgI4oN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114180; x=1805650180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/8Nm0Tej7P2LvyPAh/TyRMBUg+j4O974fl4xeSgmjc=;
  b=amCgI4oNVqHAGoUo/T2AFzjFQ6KrgEGgA1SmfcjU7mEd4fk5jc/+71k8
   /KwW9BZBTqumEiyiU6zxjiBxVT0tuHAGXZHBl1H0C0W8LyDXwTtAHLjib
   YN3siClFNyqKSVEJ3WJ/Wco6Xy+1qyrxByrPq+mxqyjD6nCanKDC5zv8F
   wpxPE9bc1Mt0m2urdnvo/Ad1LyuuewrzJ7KMhp3vmRo32bDfjBORNc/DY
   umsweUsKciH/JZ88MVPQTlrMvPbzrb+MdJHk2SdqrBvOgMi64+81BZK9Y
   F+4t+1XbVQ2QPlnQNVFeMdWNjzR3dt/U55AbVYzng7j0yVWeTMwTDUkFX
   A==;
X-CSE-ConnectionGUID: 1dtRqpT8RI2KYE1LnJssUg==
X-CSE-MsgGUID: BtTwotPyR8aNDbYzgWwFpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244589"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244589"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:40 -0700
X-CSE-ConnectionGUID: QAHbmliRQ1+/oM644ivQWg==
X-CSE-MsgGUID: iY9C8OtoRKGTn5hr5fK8hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813585"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: add MAC context command version 4
Date: Sat, 21 Mar 2026 19:29:12 +0200
Message-Id: <20260321192637.5ab609ca1966.I860737f952865bd0b997f1c190c3891864c7c6ba@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
References: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33632-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 53CAB2E6884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Due to NAN additions, this command needs to grow. In iwlmvm
we just need to use the old _v3 (or v2) version, but iwlmld
needs to handle the difference and send both.  Do that as a
first step towards adding NAN support.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 64 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  6 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 13 +++-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 18 +++---
 4 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 2e3f437686b9..180eb8227582 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -34,7 +34,8 @@ enum iwl_mac_conf_subcmd_ids {
 	 */
 	CANCEL_CHANNEL_SWITCH_CMD = 0x6,
 	/**
-	 * @MAC_CONFIG_CMD: &struct iwl_mac_config_cmd
+	 * @MAC_CONFIG_CMD: &struct iwl_mac_config_cmd_v3 or
+	 *	&struct iwl_mac_config_cmd
 	 */
 	MAC_CONFIG_CMD = 0x8,
 	/**
@@ -357,7 +358,7 @@ struct iwl_mac_wifi_gen_support {
 } __packed;
 
 /**
- * struct iwl_mac_config_cmd - command structure to configure MAC contexts in
+ * struct iwl_mac_config_cmd_v3 - command structure to configure MAC contexts in
  *	MLD API for versions 2 and 3
  * ( MAC_CONTEXT_CONFIG_CMD = 0x8 )
  *
@@ -376,7 +377,7 @@ struct iwl_mac_wifi_gen_support {
  * @client: client mac data
  * @p2p_dev: mac data for p2p device
  */
-struct iwl_mac_config_cmd {
+struct iwl_mac_config_cmd_v3 {
 	__le32 id_and_color;
 	__le32 action;
 	/* MAC_CONTEXT_TYPE_API_E */
@@ -394,7 +395,62 @@ struct iwl_mac_config_cmd {
 		struct iwl_mac_client_data client;
 		struct iwl_mac_p2p_dev_data p2p_dev;
 	};
-} __packed; /* MAC_CONTEXT_CONFIG_CMD_API_S_VER_2_VER_3 */
+} __packed; /* MAC_CONTEXT_CONFIG_CMD_API_S_VER_2, _VER_3 */
+
+/**
+ * struct iwl_mac_nan_data - NAN specific MAC data
+ * @ndi_addrs: extra NDI addresses being used
+ * @ndi_addrs_count: number of extra NDI addresses
+ */
+struct iwl_mac_nan_data {
+	struct {
+		u8 addr[ETH_ALEN];
+		__le16 reserved;
+	} __packed ndi_addrs[2];
+	__le32 ndi_addrs_count;
+} __packed; /* MAC_CONTEXT_CONFIG_NAN_DATA_API_S_VER_1 */
+
+/**
+ * struct iwl_mac_config_cmd - command structure to configure MAC contexts in
+ *	MLD API for versions 4
+ * ( MAC_CONTEXT_CONFIG_CMD = 0x8 )
+ *
+ * @id_and_color: ID and color of the MAC
+ * @action: action to perform, see &enum iwl_ctxt_action
+ * @mac_type: one of &enum iwl_mac_types
+ * @local_mld_addr: mld address
+ * @reserved_for_local_mld_addr: reserved
+ * @filter_flags: combination of &enum iwl_mac_config_filter_flags
+ * @wifi_gen_v2: he/eht parameters as in cmd version 2
+ * @wifi_gen: he/eht/uhr parameters as in cmd version 3
+ * @nic_not_ack_enabled: mark that the NIC doesn't support receiving
+ *	ACK-enabled AGG, (i.e. both BACK and non-BACK frames in single AGG).
+ *	If the NIC is not ACK_ENABLED it may use the EOF-bit in first non-0
+ *	len delim to determine if AGG or single.
+ * @client: client mac data
+ * @p2p_dev: mac data for p2p device
+ * @nan: NAN specific data (NAN data interface addresses)
+ */
+struct iwl_mac_config_cmd {
+	__le32 id_and_color;
+	__le32 action;
+	/* MAC_CONTEXT_TYPE_API_E */
+	__le32 mac_type;
+	u8 local_mld_addr[6];
+	__le16 reserved_for_local_mld_addr;
+	__le32 filter_flags;
+	union {
+		struct iwl_mac_wifi_gen_support_v2 wifi_gen_v2;
+		struct iwl_mac_wifi_gen_support wifi_gen;
+	};
+	__le32 nic_not_ack_enabled;
+	/* MAC_CONTEXT_CONFIG_SPECIFIC_DATA_API_U_VER_3 */
+	union {
+		struct iwl_mac_client_data client;
+		struct iwl_mac_p2p_dev_data p2p_dev;
+		struct iwl_mac_nan_data nan;
+	};
+} __packed; /* MAC_CONTEXT_CONFIG_CMD_API_S_VER_4 */
 
 /**
  * enum iwl_link_ctx_modify_flags - indicate to the fw what fields are being
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 2a174c00b712..439a4530ec9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -57,8 +57,7 @@ enum iwl_mac_protection_flags {
  * @FW_MAC_TYPE_P2P_DEVICE: P2P Device
  * @FW_MAC_TYPE_P2P_STA: P2P client
  * @FW_MAC_TYPE_GO: P2P GO
- * @FW_MAC_TYPE_TEST: ?
- * @FW_MAC_TYPE_MAX: highest support MAC type
+ * @FW_MAC_TYPE_NAN: NAN (since version 4)
  */
 enum iwl_mac_types {
 	FW_MAC_TYPE_FIRST = 1,
@@ -70,8 +69,7 @@ enum iwl_mac_types {
 	FW_MAC_TYPE_P2P_DEVICE,
 	FW_MAC_TYPE_P2P_STA,
 	FW_MAC_TYPE_GO,
-	FW_MAC_TYPE_TEST,
-	FW_MAC_TYPE_MAX = FW_MAC_TYPE_TEST
+	FW_MAC_TYPE_NAN,
 }; /* MAC_CONTEXT_TYPE_API_E_VER_1 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 4d8052e65f93..d3b850259569 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -61,13 +61,20 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 static int iwl_mld_send_mac_cmd(struct iwl_mld *mld,
 				struct iwl_mac_config_cmd *cmd)
 {
+	u16 cmd_id = WIDE_ID(MAC_CONF_GROUP, MAC_CONFIG_CMD);
+	int len = sizeof(*cmd);
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	ret = iwl_mld_send_cmd_pdu(mld,
-				   WIDE_ID(MAC_CONF_GROUP, MAC_CONFIG_CMD),
-				   cmd);
+	if (iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0) < 4) {
+		if (WARN_ON(cmd->mac_type == cpu_to_le32(FW_MAC_TYPE_NAN)))
+			return -EINVAL;
+
+		len = sizeof(struct iwl_mac_config_cmd_v3);
+	}
+
+	ret = iwl_mld_send_cmd_pdu(mld, cmd_id, cmd, len);
 	if (ret)
 		IWL_ERR(mld, "Failed to send MAC_CONFIG_CMD ret = %d\n", ret);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index bf54b90a7c51..b65825747b9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -6,7 +6,7 @@
 
 static void iwl_mvm_mld_set_he_support(struct iwl_mvm *mvm,
 				       struct ieee80211_vif *vif,
-				       struct iwl_mac_config_cmd *cmd,
+				       struct iwl_mac_config_cmd_v3 *cmd,
 				       int cmd_ver)
 {
 	if (vif->type == NL80211_IFTYPE_AP) {
@@ -24,7 +24,7 @@ static void iwl_mvm_mld_set_he_support(struct iwl_mvm *mvm,
 
 static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 					    struct ieee80211_vif *vif,
-					    struct iwl_mac_config_cmd *cmd,
+					    struct iwl_mac_config_cmd_v3 *cmd,
 					    u32 action)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -83,7 +83,7 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 }
 
 static int iwl_mvm_mld_mac_ctxt_send_cmd(struct iwl_mvm *mvm,
-					 struct iwl_mac_config_cmd *cmd)
+					 struct iwl_mac_config_cmd_v3 *cmd)
 {
 	int ret = iwl_mvm_send_cmd_pdu(mvm,
 				       WIDE_ID(MAC_CONF_GROUP, MAC_CONFIG_CMD),
@@ -98,7 +98,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 					struct ieee80211_vif *vif,
 					u32 action, bool force_assoc_off)
 {
-	struct iwl_mac_config_cmd cmd = {};
+	struct iwl_mac_config_cmd_v3 cmd = {};
 
 	WARN_ON(vif->type != NL80211_IFTYPE_STATION);
 
@@ -151,7 +151,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_listener(struct iwl_mvm *mvm,
 					     struct ieee80211_vif *vif,
 					     u32 action)
 {
-	struct iwl_mac_config_cmd cmd = {};
+	struct iwl_mac_config_cmd_v3 cmd = {};
 
 	WARN_ON(vif->type != NL80211_IFTYPE_MONITOR);
 
@@ -170,7 +170,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_ibss(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
 					 u32 action)
 {
-	struct iwl_mac_config_cmd cmd = {};
+	struct iwl_mac_config_cmd_v3 cmd = {};
 
 	WARN_ON(vif->type != NL80211_IFTYPE_ADHOC);
 
@@ -187,7 +187,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_p2p_device(struct iwl_mvm *mvm,
 					       struct ieee80211_vif *vif,
 					       u32 action)
 {
-	struct iwl_mac_config_cmd cmd = {};
+	struct iwl_mac_config_cmd_v3 cmd = {};
 
 	WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE);
 
@@ -210,7 +210,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_ap_go(struct iwl_mvm *mvm,
 					  u32 action)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mac_config_cmd cmd = {};
+	struct iwl_mac_config_cmd_v3 cmd = {};
 
 	WARN_ON(vif->type != NL80211_IFTYPE_AP);
 
@@ -286,7 +286,7 @@ int iwl_mvm_mld_mac_ctxt_changed(struct iwl_mvm *mvm,
 int iwl_mvm_mld_mac_ctxt_remove(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mac_config_cmd cmd = {
+	struct iwl_mac_config_cmd_v3 cmd = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
 		.id_and_color = cpu_to_le32(mvmvif->id),
 	};
-- 
2.34.1



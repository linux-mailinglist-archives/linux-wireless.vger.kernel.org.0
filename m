Return-Path: <linux-wireless+bounces-33435-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKrzAYsRu2nGegIAu9opvQ
	(envelope-from <linux-wireless+bounces-33435-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:56:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 599352C2C00
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E5E931B38D6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 20:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC5237267E;
	Wed, 18 Mar 2026 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0m8R2nE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919636EAB8
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867300; cv=none; b=pe+sI4SCUQULSRuo1t2iYqD6VoZsQ+FM+LUphWhqcaBazuhUa4/xuJX7k/7NdBDQe0DiXO9Vnq0F6C8T6pz6auRm+vgoeb8lctcGTDGcgHVS10MXWNMgvjWMFoaek9duZGn1hf2Fp5Sx2oZ4hqhXuMg8srNIfcwcVH+6lSx69Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867300; c=relaxed/simple;
	bh=yLSysYn5qI+6IOI/+tbT1PKqC7rPv2Xr4flGUPg6H6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnsuJfXEROO1Sgk3pBMll4XsvlWHWKrEeySQ7N9cu1WfNr4pvggZWhw5f0MADXp5CUPl8c3n+DYRg/NgYPQkE8Y6L6XQiqMNc4pOeqUZa+DGQUEvWoPd/YpwQddu/kc9Olz2UK1S/klQRdIzjW40j7IW3vuhSk4cYnCTtjI5VMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0m8R2nE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773867298; x=1805403298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yLSysYn5qI+6IOI/+tbT1PKqC7rPv2Xr4flGUPg6H6k=;
  b=R0m8R2nEiPEwzbkbQM0Z9vLu4oaHgXaKgR8BI2DZiVrfhhntQY33f6wB
   X503KZ6mRcjvfxQEyascDP0D+m5MFt33JP9KA/xZaBSvYQBz7z1rvelvg
   1rO/tQ9oG7WVr566T8iZ5Q1MsnyuDCc1pAmJw+waT6nrX5vqesx39ckg2
   xnplm6kE4O1ZPbjfwnLppxKwfEM/JW8H1NnHqwcoNaBUyjMQUZtmU83Vj
   mV8B2ALX+4eULBl9SKaMfBO2DZx/t0WQPcVvS7pMPqiY9wlTRdNaA/V8F
   6XsmyOhg07nl2zXa1+VUDgs4Q2wtFOZd9vPFwTg/2ewISxPFLthmb79YA
   A==;
X-CSE-ConnectionGUID: JLOPgvFPTnGwcUOMCqSpcQ==
X-CSE-MsgGUID: Q6VNay1VTImh+ew6hhYLEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75010030"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75010030"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:57 -0700
X-CSE-ConnectionGUID: xxuS8qW/TJyb8bg5RkEYHw==
X-CSE-MsgGUID: wDQ7kyE/RIKFgmhrR8zy/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222793919"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mld: add support for sta command version 3
Date: Wed, 18 Mar 2026 22:54:26 +0200
Message-Id: <20260318225236.382a30bd1b70.Id6271e7eba233a11dc214ed2e07c2b186b167c66@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
References: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33435-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 599352C2C00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In this version, the link_id becomes a link_mask to support multiple
links that are used to communicate with the station in question.
This is needed for NAN, in which we can communicate on multiple channels
with the same station.
Also add a new STA type - NAN peer.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 94 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  | 42 +++++++--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  6 +-
 3 files changed, 129 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index c7a833f8041a..444d60a05a98 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -42,7 +42,8 @@ enum iwl_mac_conf_subcmd_ids {
 	 */
 	LINK_CONFIG_CMD = 0x9,
 	/**
-	 * @STA_CONFIG_CMD: &struct iwl_sta_cfg_cmd
+	 * @STA_CONFIG_CMD: &struct iwl_sta_cfg_cmd_v1,
+	 *	&struct iwl_sta_cfg_cmd_v2, or struct iwl_sta_cfg_cmd
 	 */
 	STA_CONFIG_CMD = 0xA,
 	/**
@@ -664,13 +665,21 @@ struct iwl_link_config_cmd {
  *	power save state and the DTIM timing
  * @STATION_TYPE_AUX: aux sta. In the FW there is no need for a special type
  *	for the aux sta, so this type is only for driver - internal use.
+ * @STATION_TYPE_NAN_PEER_NMI: NAN management peer station type. A station
+ *	of this type can have any number of links (even none) set in the
+ *	link_mask. (Supported since version 3.)
+ * @STATION_TYPE_NAN_PEER_NDI: NAN data peer station type. A station
+ *	of this type can have any number of links (even none) set in the
+ *	link_mask. (Supported since version 3.)
  */
 enum iwl_fw_sta_type {
 	STATION_TYPE_PEER,
 	STATION_TYPE_BCAST_MGMT,
 	STATION_TYPE_MCAST,
 	STATION_TYPE_AUX,
-}; /* STATION_TYPE_E_VER_1 */
+	STATION_TYPE_NAN_PEER_NMI,
+	STATION_TYPE_NAN_PEER_NDI,
+}; /* STATION_TYPE_E_VER_1, _VER_2 */
 
 /**
  * struct iwl_sta_cfg_cmd_v1 - cmd structure to add a peer sta to the uCode's
@@ -729,7 +738,7 @@ struct iwl_sta_cfg_cmd_v1 {
 } __packed; /* STA_CMD_API_S_VER_1 */
 
 /**
- * struct iwl_sta_cfg_cmd - cmd structure to add a peer sta to the uCode's
+ * struct iwl_sta_cfg_cmd_v2 - cmd structure to add a peer sta to the uCode's
  *	station table
  * ( STA_CONFIG_CMD = 0xA )
  *
@@ -769,7 +778,7 @@ struct iwl_sta_cfg_cmd_v1 {
  * @mic_compute_pad_delay: MIC compute time padding
  * @reserved: Reserved for alignment
  */
-struct iwl_sta_cfg_cmd {
+struct iwl_sta_cfg_cmd_v2 {
 	__le32 sta_id;
 	__le32 link_id;
 	u8 peer_mld_address[ETH_ALEN];
@@ -799,6 +808,83 @@ struct iwl_sta_cfg_cmd {
 	u8 reserved[2];
 } __packed; /* STA_CMD_API_S_VER_2 */
 
+/**
+ * struct iwl_sta_cfg_cmd - cmd structure to add a peer sta to the uCode's
+ *	station table
+ * ( STA_CONFIG_CMD = 0xA )
+ *
+ * @sta_id: index of station in uCode's station table
+ * @link_mask: bitmap of link FW IDs used with this STA
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
+ * @use_ldpc_x2_cw: Indicates whether to use LDPC with double CW
+ * @use_icf: Indicates whether to use ICF instead of RTS
+ * @dps_pad_time: DPS (Dynamic Power Save) padding delay resolution to ensure
+ *	proper timing alignment
+ * @dps_trans_delay: DPS minimal time that takes the peer to return to low power
+ * @dps_enabled: flag indicating whether or not DPS is enabled
+ * @mic_prep_pad_delay: MIC prep time padding
+ * @mic_compute_pad_delay: MIC compute time padding
+ * @nmi_sta_id: for an NDI peer STA, the NMI peer STA ID it relates to
+ * @ndi_local_addr: for an NDI peer STA, the local NDI interface MAC address
+ * @reserved: Reserved for alignment
+ */
+struct iwl_sta_cfg_cmd {
+	__le32 sta_id;
+	__le32 link_mask;
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
+	u8 use_ldpc_x2_cw;
+	u8 use_icf;
+	u8 dps_pad_time;
+	u8 dps_trans_delay;
+	u8 dps_enabled;
+	u8 mic_prep_pad_delay;
+	u8 mic_compute_pad_delay;
+	u8 nmi_sta_id;
+	u8 ndi_local_addr[ETH_ALEN];
+	u8 reserved[2];
+} __packed; /* STA_CMD_API_S_VER_3 */
+
 /**
  * struct iwl_aux_sta_cmd - command for AUX STA configuration
  * ( AUX_STA_CMD = 0xB )
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 6b7a89e050e6..f40c49377466 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -398,12 +398,42 @@ static u32 iwl_mld_get_htc_flags(struct ieee80211_link_sta *link_sta)
 	return htc_flags;
 }
 
+/* Note: modifies the command depending on FW command version */
 static int iwl_mld_send_sta_cmd(struct iwl_mld *mld,
-				const struct iwl_sta_cfg_cmd *cmd)
+				struct iwl_sta_cfg_cmd *cmd)
 {
-	int ret = iwl_mld_send_cmd_pdu(mld,
-				       WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD),
-				       cmd);
+	int cmd_id = WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD);
+	int cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0);
+	int len = sizeof(*cmd);
+	int ret;
+
+	if (cmd_ver < 2) {
+		IWL_ERR(mld, "Unsupported STA_CONFIG_CMD version %d\n",
+			cmd_ver);
+		return -EINVAL;
+	} else if (cmd_ver == 2) {
+		struct iwl_sta_cfg_cmd_v2 *cmd_v2 = (void *)cmd;
+
+		if (WARN_ON(cmd->station_type == cpu_to_le32(STATION_TYPE_NAN_PEER_NMI) ||
+			    cmd->station_type == cpu_to_le32(STATION_TYPE_NAN_PEER_NDI) ||
+			    hweight32(le32_to_cpu(cmd->link_mask)) != 1))
+			return -EINVAL;
+		/*
+		 * These fields are located in a different place in the struct of v2.
+		 * The assumption is that UHR won't be used with FW that has v2.
+		 */
+		if (WARN_ON(cmd->mic_prep_pad_delay || cmd->mic_compute_pad_delay))
+			return -EINVAL;
+
+		len = sizeof(struct iwl_sta_cfg_cmd_v2);
+		cmd_v2->link_id = cpu_to_le32(__ffs(le32_to_cpu(cmd->link_mask)));
+	} else if (WARN_ON(cmd->station_type != cpu_to_le32(STATION_TYPE_NAN_PEER_NMI) &&
+			   cmd->station_type != cpu_to_le32(STATION_TYPE_NAN_PEER_NDI) &&
+			   hweight32(le32_to_cpu(cmd->link_mask)) != 1)) {
+		return -EINVAL;
+	}
+
+	ret = iwl_mld_send_cmd_pdu(mld, cmd_id, cmd, len);
 	if (ret)
 		IWL_ERR(mld, "STA_CONFIG_CMD send failed, ret=0x%x\n", ret);
 	return ret;
@@ -431,8 +461,8 @@ iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
 		return -EINVAL;
 
 	cmd.sta_id = cpu_to_le32(fw_id);
+	cmd.link_mask = cpu_to_le32(BIT(mld_link->fw_id));
 	cmd.station_type = cpu_to_le32(mld_sta->sta_type);
-	cmd.link_id = cpu_to_le32(mld_link->fw_id);
 
 	memcpy(&cmd.peer_mld_address, sta->addr, ETH_ALEN);
 	memcpy(&cmd.peer_link_address, link_sta->addr, ETH_ALEN);
@@ -982,7 +1012,7 @@ iwl_mld_add_internal_sta_to_fw(struct iwl_mld *mld,
 		return iwl_mld_send_aux_sta_cmd(mld, internal_sta);
 
 	cmd.sta_id = cpu_to_le32((u8)internal_sta->sta_id);
-	cmd.link_id = cpu_to_le32(fw_link_id);
+	cmd.link_mask = cpu_to_le32(BIT(fw_link_id));
 	cmd.station_type = cpu_to_le32(internal_sta->sta_type);
 
 	/* FW doesn't allow to add a IGTK/BIGTK if the sta isn't marked as MFP.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 44e16ee9514e..da7ed4639a93 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -20,7 +20,7 @@ u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 }
 
 static int iwl_mvm_mld_send_sta_cmd(struct iwl_mvm *mvm,
-				    struct iwl_sta_cfg_cmd *cmd)
+				    struct iwl_sta_cfg_cmd_v2 *cmd)
 {
 	u32 cmd_id = WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD);
 	int cmd_len = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 0) > 1 ?
@@ -41,7 +41,7 @@ static int iwl_mvm_mld_add_int_sta_to_fw(struct iwl_mvm *mvm,
 					 struct iwl_mvm_int_sta *sta,
 					 const u8 *addr, int link_id)
 {
-	struct iwl_sta_cfg_cmd cmd;
+	struct iwl_sta_cfg_cmd_v2 cmd;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -416,7 +416,7 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	struct iwl_mvm_vif *mvm_vif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_vif_link_info *link_info =
 					mvm_vif->link[link_conf->link_id];
-	struct iwl_sta_cfg_cmd cmd = {
+	struct iwl_sta_cfg_cmd_v2 cmd = {
 		.sta_id = cpu_to_le32(mvm_link_sta->sta_id),
 		.station_type = cpu_to_le32(mvm_sta->sta_type),
 	};
-- 
2.34.1



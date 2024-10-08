Return-Path: <linux-wireless+bounces-13668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2F993DF4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAD5286174
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5847D3C0C;
	Tue,  8 Oct 2024 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5m2H+05"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB167DA87
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361550; cv=none; b=j/mP9yJc0H5RjA52vqR6UAq0mXNKlYuVQvNf0TjVmjKPEjqr58fnaKjAh2l29khIa1pR8dfeRD9iNn3iVMSqdzgHgTBsdyEqP6wj11Xp2BV7Z2Rk6Djfe3lHO16Wap1nENZgZm2CUgy/pHqHfjQlTcGbjX57aVahrzEIi0DLTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361550; c=relaxed/simple;
	bh=pWtlFPV37E8Kc2iQNvfMld01t5S9w5dMaNndYV0lPGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAll6VRURRqd5bkNJAHUREEMLugPP/2r5wwGI5lJ1z4zjbQDqu8PW9wBCmFqdoZ7smgcwavjF8HisDzQ4Sp0AYKPH8TYLqTz7Zi8HwQJcxAlSCeSIAMdpODh4XbB9BxbWb/xmPPTIsURyj7rECWLdK96tigUE4fGbAsBqCFJ6II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5m2H+05; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361549; x=1759897549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pWtlFPV37E8Kc2iQNvfMld01t5S9w5dMaNndYV0lPGE=;
  b=A5m2H+05kJsFGmqx0PXzjZGeLxPiZ8p95ICeCC8XLAOqKXwCdjnFqnP7
   KNVnG0KZ1JRGzRdAT2nf8KPFL5f5LFK0QF7OBrVD3HnKHNX3df4cqgoPs
   4ecGDm0QZcgnSzlkl6vNP4Q17Nn70w0C53EONwxj/qG6Ms9gFiMXEAv/K
   Pzr/FfgnGq//QsxO9R4MM2iFmEUPhx/amp51HkHiGyfTFdWwW57nejOlb
   vg85RzgNNEJsyM4pVapKUqYt7+/fzp/1EYHpROZPi2yXVlTn1UIYEsFF1
   g/zHvCbExlechUqJ/68T8XyHQaABbYg8G0AZw+OKVjz3mOz/wHyB7ZT2Y
   Q==;
X-CSE-ConnectionGUID: /qfdwMkOSV2clhYef4Cafg==
X-CSE-MsgGUID: E6fjOOh+QWCX4jG9AfbetA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024267"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024267"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:49 -0700
X-CSE-ConnectionGUID: KP8YL9K2Rnem+va4frvP3w==
X-CSE-MsgGUID: FNyPFohiSUi0ad2QXlYsng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486326"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/14] wifi: iwlwifi: fw: api: update link context API version
Date: Tue,  8 Oct 2024 07:25:19 +0300
Message-Id: <20241008072037.437c6573df3c.I03612cb6cf47b12038c1db11b95a554cdea714e9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The flags_mask field is becoming reserved, and a new bandwidth
request is being added for RX OMI purposes. Support the new API
version as preparation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 32 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  3 +-
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index c46e24fc6a1e..b23d5fc4bbe6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -382,6 +382,8 @@ struct iwl_mac_config_cmd {
  * @LINK_CONTEXT_MODIFY_EHT_PARAMS: covers iwl_link_ctx_cfg_cmd::puncture_mask.
  *	This flag can be set only if the MAC that this link relates to has
  *	eht_support set to true. No longer used since _VER_3 of this command.
+ * @LINK_CONTEXT_MODIFY_BANDWIDTH: Covers iwl_link_ctx_cfg_cmd::modify_bandwidth.
+ *	Request RX OMI to the AP to modify bandwidth of this link.
  * @LINK_CONTEXT_MODIFY_ALL: set all above flags
  */
 enum iwl_link_ctx_modify_flags {
@@ -393,6 +395,7 @@ enum iwl_link_ctx_modify_flags {
 	LINK_CONTEXT_MODIFY_HE_PARAMS		= BIT(5),
 	LINK_CONTEXT_MODIFY_BSS_COLOR_DISABLE	= BIT(6),
 	LINK_CONTEXT_MODIFY_EHT_PARAMS		= BIT(7),
+	LINK_CONTEXT_MODIFY_BANDWIDTH		= BIT(8),
 	LINK_CONTEXT_MODIFY_ALL			= 0xff,
 }; /* LINK_CONTEXT_MODIFY_MASK_E_VER_1 */
 
@@ -433,6 +436,22 @@ enum iwl_link_ctx_flags {
 	LINK_FLG_NDP_FEEDBACK_ENABLED	= BIT(3),
 }; /* LINK_CONTEXT_FLAG_E_VER_1 */
 
+/**
+ * enum iwl_link_modify_bandwidth - link modify (RX OMI) bandwidth
+ * @IWL_LINK_MODIFY_BW_20: request 20 MHz
+ * @IWL_LINK_MODIFY_BW_40: request 40 MHz
+ * @IWL_LINK_MODIFY_BW_80: request 80 MHz
+ * @IWL_LINK_MODIFY_BW_160: request 160 MHz
+ * @IWL_LINK_MODIFY_BW_320: request 320 MHz
+ */
+enum iwl_link_modify_bandwidth {
+	IWL_LINK_MODIFY_BW_20,
+	IWL_LINK_MODIFY_BW_40,
+	IWL_LINK_MODIFY_BW_80,
+	IWL_LINK_MODIFY_BW_160,
+	IWL_LINK_MODIFY_BW_320,
+};
+
 /**
  * struct iwl_link_config_cmd - command structure to configure the LINK context
  *	in MLD API
@@ -457,6 +476,8 @@ enum iwl_link_ctx_flags {
  * @block_tx: tell the firmware that this link can't Tx. This should be used
  *	only when a link is de-activated because of CSA with mode = 1.
  *	Available since version 5.
+ * @modify_bandwidth: bandwidth request value for RX OMI (see also
+ *	%LINK_CONTEXT_MODIFY_BANDWIDTH), from &enum iwl_link_modify_bandwidth.
  * @reserved1: in version 2, listen_lmac became reserved
  * @cck_rates: basic rates available for CCK
  * @ofdm_rates: basic rates available for OFDM
@@ -500,10 +521,11 @@ struct iwl_link_config_cmd {
 	__le32 modify_mask;
 	__le32 active;
 	union {
-		__le32 listen_lmac;
+		__le32 listen_lmac; /* only _VER_1 */
 		struct {
-			u8 block_tx;
-			u8 reserved1[3];
+			u8 block_tx; /* since _VER_5 */
+			u8 modify_bandwidth; /* since _VER_6 */
+			u8 reserved1[2];
 		};
 	};
 	__le32 cck_rates;
@@ -524,7 +546,7 @@ struct iwl_link_config_cmd {
 	__le16 puncture_mask; /* removed in _VER_3 */
 	__le16 frame_time_rts_th;
 	__le32 flags;
-	__le32 flags_mask;
+	__le32 flags_mask; /* removed in _VER_6 */
 	/* The below fields are for multi-bssid */
 	u8 ref_bssid_addr[6];
 	__le16 reserved_for_ref_bssid_addr;
@@ -535,7 +557,7 @@ struct iwl_link_config_cmd {
 	u8 ibss_bssid_addr[6];
 	__le16 reserved_for_ibss_bssid_addr;
 	__le32 reserved3[8];
-} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3, _VER_4, _VER_5 */
+} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3, _VER_4, _VER_5, _VER_6 */
 
 /* Currently FW supports link ids in the range 0-3 and can have
  * at most two active links for each vif.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 19ecd215f1dc..628baf67b208 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -361,7 +361,8 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 send_cmd:
 	cmd.modify_mask = cpu_to_le32(changes);
 	cmd.flags = cpu_to_le32(flags);
-	cmd.flags_mask = cpu_to_le32(flags_mask);
+	if (cmd_ver < 6)
+		cmd.flags_mask = cpu_to_le32(flags_mask);
 	cmd.spec_link_id = link_conf->link_id;
 	if (cmd_ver < 2)
 		cmd.listen_lmac = cpu_to_le32(link_info->listen_lmac);
-- 
2.34.1



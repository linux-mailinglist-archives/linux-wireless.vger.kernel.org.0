Return-Path: <linux-wireless+bounces-33564-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJIzKxkCvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33564-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:15:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F7C2D708A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 142FE304A863
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DEA377ED6;
	Fri, 20 Mar 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8XtUAFh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE0378D76
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994177; cv=none; b=HAP7nW/gXbK5Y5CXRBbmiXP8rbytarP+oJCZzbk1SB9AKXJMHVnqAuBGOLDTHzOAT/01H5jRRBIXBu6/PpQlTrTZ6fKOs4+fMkawJ4ZvBkvnHzD16EwIXB97SsNWebNiumAGUjzuGSjeNwMb1JwLans3KPdWlliKkq8FklHbZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994177; c=relaxed/simple;
	bh=t60Ex0SoIbmcPdLYTq10Yv+jHkd+EBjLyaSDbRL2KGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1hKHW8n9YTadJmJLGk9FQkif0h6X00QhTDotf0ygwgPi4RonHtUlaHHuqStwZ8OALpgWX8SHKHfnyh4fiA71fNn3Sp2Ulb+XdJEpTeE3OqHMNpM5oxFfdtTUAFE9cIBqVHfz4NLwZNBG/wt2y1XHS58K5NlZ99i+Kzqy1kRj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8XtUAFh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994175; x=1805530175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t60Ex0SoIbmcPdLYTq10Yv+jHkd+EBjLyaSDbRL2KGU=;
  b=k8XtUAFhRX+Z4rt0OzOGAX8sLmxrEXIiOHlMvEHcfFB96zn99mPeCzhr
   wkxesRENT6llJ2fsdJCCgsN9D7bpT5FB1TTZiwSARR3SGuOGxVcy3PrEd
   i1ChizPSg+QTor87nhSblQ9YXRZjahpWzD+2zB+yZduJiNtGUSa20fCwf
   FCVv7nngr6CxqJ9PmC95WoVkTbBLqPs9iVh89gJYUmzlyPYQda03HM2Bz
   k9bzejRGyJj6wOi4iymIFvfOizUm99XgfxaH41sQE4tN+RzjmVFb23hZb
   2G5mWugh56LQmcDR7xu05/JLScikSPzdwYFPfhYiqDIA1pRW1rJCzvQZo
   A==;
X-CSE-ConnectionGUID: pMTHHR1CTsas4v4Q6UfCnw==
X-CSE-MsgGUID: 2gwCZQZRR0G4D0ERPqjt+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154112"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154112"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:35 -0700
X-CSE-ConnectionGUID: uJm6RJXDTnyH+9x6doO5zQ==
X-CSE-MsgGUID: pgebkjlkQIWpPQ1wWjBZ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692559"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: advertise UHR capabilities for such devices
Date: Fri, 20 Mar 2026 10:09:06 +0200
Message-Id: <20260320100746.dda78e53dccc.I85b67f4973752bcf62416dabb943b9ddf1e63f16@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33564-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 03F7C2D708A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Advertise UHR capabilities for devices supporting UHR
(i.e. devices with some, but not all, PE RFs.)

For correct support it's also needed to plumb through
the regulatory flags the firmware might have/enforce.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/rf-pe.c    | 23 ++++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  7 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 87 +++++++++++++------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  2 +
 .../wireless/intel/iwlwifi/iwl-nvm-utils.h    |  3 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  4 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  2 +-
 7 files changed, 95 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
index 2c29054ce7b8..c02478b73057 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
@@ -4,7 +4,28 @@
  */
 #include "iwl-config.h"
 
-/* currently iwl_rf_wh/iwl_rf_wh_160mhz are just defines for the FM ones */
+#define IWL_PE_NVM_VERSION		0x0a1d
+
+#define IWL_DEVICE_PE							\
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	},								\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.non_shared_ant = ANT_B,					\
+	.vht_mu_mimo_supported = true,					\
+	.uhb_supported = true,						\
+	.eht_supported = true,						\
+	.uhr_supported = true,						\
+	.num_rbds = IWL_NUM_RBDS_EHT,					\
+	.nvm_ver = IWL_PE_NVM_VERSION,					\
+	.nvm_type = IWL_NVM_EXT
+
+const struct iwl_rf_cfg iwl_rf_pe = {
+	IWL_DEVICE_PE,
+};
 
 const char iwl_killer_bn1850w2_name[] =
 	"Killer(R) Wi-Fi 8 BN1850w2 320MHz Wireless Network Adapter (BN201.D2W)";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 5f40cd15e27f..da6d3686e7dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -416,6 +416,7 @@ struct iwl_mac_cfg {
  * @nvm_type: see &enum iwl_nvm_type
  * @uhb_supported: ultra high band channels supported
  * @eht_supported: EHT supported
+ * @uhr_supported: UHR supported
  * @num_rbds: number of receive buffer descriptors to use
  *	(only used for multi-queue capable devices)
  *
@@ -449,7 +450,8 @@ struct iwl_rf_cfg {
 	    lp_xtal_workaround:1,
 	    vht_mu_mimo_supported:1,
 	    uhb_supported:1,
-	    eht_supported:1;
+	    eht_supported:1,
+	    uhr_supported:1;
 	u8 valid_tx_ant;
 	u8 valid_rx_ant;
 	u8 non_shared_ant;
@@ -744,7 +746,8 @@ extern const struct iwl_rf_cfg iwl_rf_fm_160mhz;
 #define iwl_rf_wh iwl_rf_fm
 #define iwl_rf_wh_160mhz iwl_rf_fm_160mhz
 extern const struct iwl_rf_cfg iwl_rf_wh_non_eht;
-#define iwl_rf_pe iwl_rf_fm
+extern const struct iwl_rf_cfg iwl_rf_pe;
+#define iwl_rf_pe_no_uhr iwl_rf_fm
 #endif /* CONFIG_IWLMLD */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 6d235c417fdd..b24ac3cec412 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -204,28 +204,30 @@ enum iwl_reg_capa_flags_v2 {
 }; /* GEO_CHANNEL_CAPABILITIES_API_S_VER_2 */
 
 /**
- * enum iwl_reg_capa_flags_v4 - global flags applied for the whole regulatory
+ * enum iwl_reg_capa_flags_v5 - global flags applied for the whole regulatory
  * domain.
- * @REG_CAPA_V4_160MHZ_ALLOWED: 11ac channel with a width of 160Mhz is allowed
+ * @REG_CAPA_V5_160MHZ_ALLOWED: 11ac channel with a width of 160Mhz is allowed
  *	for this regulatory domain (valid only in 5Ghz).
- * @REG_CAPA_V4_80MHZ_ALLOWED: 11ac channel with a width of 80Mhz is allowed
+ * @REG_CAPA_V5_80MHZ_ALLOWED: 11ac channel with a width of 80Mhz is allowed
  *	for this regulatory domain (valid only in 5Ghz).
- * @REG_CAPA_V4_MCS_12_ALLOWED: 11ac with MCS 12 is allowed.
- * @REG_CAPA_V4_MCS_13_ALLOWED: 11ac with MCS 13 is allowed.
- * @REG_CAPA_V4_11BE_DISABLED: 11be is forbidden for this regulatory domain.
- * @REG_CAPA_V4_11AX_DISABLED: 11ax is forbidden for this regulatory domain.
- * @REG_CAPA_V4_320MHZ_ALLOWED: 11be channel with a width of 320Mhz is allowed
+ * @REG_CAPA_V5_MCS_12_ALLOWED: 11ac with MCS 12 is allowed.
+ * @REG_CAPA_V5_MCS_13_ALLOWED: 11ac with MCS 13 is allowed.
+ * @REG_CAPA_V5_11BE_DISABLED: 11be is forbidden for this regulatory domain.
+ * @REG_CAPA_V5_11AX_DISABLED: 11ax is forbidden for this regulatory domain.
+ * @REG_CAPA_V5_320MHZ_ALLOWED: 11be channel with a width of 320Mhz is allowed
  *	for this regulatory domain (valid only in 5GHz).
+ * @REG_CAPA_V5_11BN_DISABLED: UHR is not allowed for this regulatory domain
  */
-enum iwl_reg_capa_flags_v4 {
-	REG_CAPA_V4_160MHZ_ALLOWED		= BIT(3),
-	REG_CAPA_V4_80MHZ_ALLOWED		= BIT(4),
-	REG_CAPA_V4_MCS_12_ALLOWED		= BIT(5),
-	REG_CAPA_V4_MCS_13_ALLOWED		= BIT(6),
-	REG_CAPA_V4_11BE_DISABLED		= BIT(8),
-	REG_CAPA_V4_11AX_DISABLED		= BIT(13),
-	REG_CAPA_V4_320MHZ_ALLOWED		= BIT(16),
-}; /* GEO_CHANNEL_CAPABILITIES_API_S_VER_4 */
+enum iwl_reg_capa_flags_v5 {
+	REG_CAPA_V5_160MHZ_ALLOWED		= BIT(3),
+	REG_CAPA_V5_80MHZ_ALLOWED		= BIT(4),
+	REG_CAPA_V5_MCS_12_ALLOWED		= BIT(5),
+	REG_CAPA_V5_MCS_13_ALLOWED		= BIT(6),
+	REG_CAPA_V5_11BE_DISABLED		= BIT(8),
+	REG_CAPA_V5_11AX_DISABLED		= BIT(13),
+	REG_CAPA_V5_320MHZ_ALLOWED		= BIT(16),
+	REG_CAPA_V5_11BN_DISABLED		= BIT(17),
+}; /* GEO_CHANNEL_CAPABILITIES_API_S_VER_4, 5 */
 
 /*
 * API v2 for reg_capa_flags is relevant from version 6 and onwards of the
@@ -544,7 +546,7 @@ static const u8 iwl_vendor_caps[] = {
 	0x00
 };
 
-static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
+static const struct ieee80211_sband_iftype_data iwl_iftype_cap[] = {
 	{
 		.types_mask = BIT(NL80211_IFTYPE_STATION) |
 			      BIT(NL80211_IFTYPE_P2P_CLIENT),
@@ -688,6 +690,11 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			 */
 			.eht_ppe_thres = {0xc1, 0x0e, 0xe0 }
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
+				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -786,6 +793,11 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			 */
 			.eht_ppe_thres = {0xc1, 0x0e, 0xe0 }
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
+				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+		},
 	},
 };
 
@@ -853,6 +865,19 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	    fips_enabled)
 		iftype_data->eht_cap.has_eht = false;
 
+	if (!data->sku_cap_11bn_enable || !iftype_data->eht_cap.has_eht)
+		iftype_data->uhr_cap.has_uhr = false;
+
+	if (sband->band != NL80211_BAND_2GHZ) {
+		/* on 5 and 6 GHz ELR is uplink only */
+		if (is_ap)
+			iftype_data->uhr_cap.phy.cap &=
+				~IEEE80211_UHR_PHY_CAP_ELR_TX;
+		else
+			iftype_data->uhr_cap.phy.cap &=
+				~IEEE80211_UHR_PHY_CAP_ELR_RX;
+	}
+
 	/* Advertise an A-MPDU exponent extension based on
 	 * operating band
 	 */
@@ -1021,9 +1046,9 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 	struct ieee80211_sband_iftype_data *iftype_data;
 	int i;
 
-	BUILD_BUG_ON(sizeof(data->iftd.low) != sizeof(iwl_he_eht_capa));
-	BUILD_BUG_ON(sizeof(data->iftd.high) != sizeof(iwl_he_eht_capa));
-	BUILD_BUG_ON(sizeof(data->iftd.uhb) != sizeof(iwl_he_eht_capa));
+	BUILD_BUG_ON(sizeof(data->iftd.low) != sizeof(iwl_iftype_cap));
+	BUILD_BUG_ON(sizeof(data->iftd.high) != sizeof(iwl_iftype_cap));
+	BUILD_BUG_ON(sizeof(data->iftd.uhb) != sizeof(iwl_iftype_cap));
 
 	switch (sband->band) {
 	case NL80211_BAND_2GHZ:
@@ -1040,10 +1065,10 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 		return;
 	}
 
-	memcpy(iftype_data, iwl_he_eht_capa, sizeof(iwl_he_eht_capa));
+	memcpy(iftype_data, iwl_iftype_cap, sizeof(iwl_iftype_cap));
 
 	_ieee80211_set_sband_iftype_data(sband, iftype_data,
-					 ARRAY_SIZE(iwl_he_eht_capa));
+					 ARRAY_SIZE(iwl_iftype_cap));
 
 	for (i = 0; i < sband->n_iftype_data; i++)
 		iwl_nvm_fixup_sband_iftd(trans, data, sband, &iftype_data[i],
@@ -1609,6 +1634,9 @@ u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 	if (reg_capa.disable_11be)
 		flags |= NL80211_RRF_NO_EHT;
 
+	if (reg_capa.disable_11bn)
+		flags |= NL80211_RRF_NO_UHR;
+
 	return flags;
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_nvm_get_regdom_bw_flags);
@@ -1619,11 +1647,13 @@ static struct iwl_reg_capa iwl_get_reg_capa(u32 flags, u8 resp_ver)
 
 	if (resp_ver >= REG_CAPA_V4_RESP_VER) {
 		reg_capa.allow_40mhz = true;
-		reg_capa.allow_80mhz = flags & REG_CAPA_V4_80MHZ_ALLOWED;
-		reg_capa.allow_160mhz = flags & REG_CAPA_V4_160MHZ_ALLOWED;
-		reg_capa.allow_320mhz = flags & REG_CAPA_V4_320MHZ_ALLOWED;
-		reg_capa.disable_11ax = flags & REG_CAPA_V4_11AX_DISABLED;
-		reg_capa.disable_11be = flags & REG_CAPA_V4_11BE_DISABLED;
+		reg_capa.allow_80mhz = flags & REG_CAPA_V5_80MHZ_ALLOWED;
+		reg_capa.allow_160mhz = flags & REG_CAPA_V5_160MHZ_ALLOWED;
+		reg_capa.allow_320mhz = flags & REG_CAPA_V5_320MHZ_ALLOWED;
+		reg_capa.disable_11ax = flags & REG_CAPA_V5_11AX_DISABLED;
+		reg_capa.disable_11be = flags & REG_CAPA_V5_11BE_DISABLED;
+		/* can check: was reserved and irrelevant for pre-UHR devices */
+		reg_capa.disable_11bn = flags & REG_CAPA_V5_11BN_DISABLED;
 	} else if (resp_ver >= REG_CAPA_V2_RESP_VER) {
 		reg_capa.allow_40mhz = flags & REG_CAPA_V2_40MHZ_ALLOWED;
 		reg_capa.allow_80mhz = flags & REG_CAPA_V2_80MHZ_ALLOWED;
@@ -2072,6 +2102,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_MIMO_DISABLED);
 	if (trans->cfg->eht_supported)
 		nvm->sku_cap_11be_enable = true;
+	nvm->sku_cap_11bn_enable = trans->cfg->uhr_supported;
 
 	/* Initialize PHY sku data */
 	nvm->valid_tx_ant = (u8)le32_to_cpu(rsp->phy_sku.tx_chains);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index 12f28bb0e859..e676d7c2d6cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -35,6 +35,7 @@ enum iwl_nvm_sbands_flags {
  *	for this regulatory domain (valid only in 6 Ghz).
  * @disable_11ax: 11ax is forbidden for this regulatory domain.
  * @disable_11be: 11be is forbidden for this regulatory domain.
+ * @disable_11bn: UHR/11bn is not allowed for this regulatory domain
  */
 struct iwl_reg_capa {
 	bool allow_40mhz;
@@ -43,6 +44,7 @@ struct iwl_reg_capa {
 	bool allow_320mhz;
 	bool disable_11ax;
 	bool disable_11be;
+	bool disable_11bn;
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h
index ac0a29a1c31f..353f5269d17a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018, 2020-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018, 2020-2023, 2025 Intel Corporation
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  */
 #ifndef __iwl_eeprom_parse_h__
@@ -32,6 +32,7 @@ struct iwl_nvm_data {
 	bool sku_cap_ipan_enable;
 	bool sku_cap_mimo_disabled;
 	bool sku_cap_11be_enable;
+	bool sku_cap_11bn_enable;
 
 	u16 radio_cfg_type;
 	u8 radio_cfg_step;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 9215fc7e2eca..dc96214671d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -132,6 +132,8 @@ static void iwl_mld_mac_wifi_gen_sta_iter(void *_data,
 			data->support->he_support = 1;
 		if (link_sta->eht_cap.has_eht)
 			data->support->eht_support = 1;
+		if (link_sta->uhr_cap.has_uhr)
+			data->support->uhr_support = 1;
 	}
 }
 
@@ -151,12 +153,14 @@ static void iwl_mld_set_wifi_gen(struct iwl_mld *mld,
 		/* for sniffer, set to HW capabilities */
 		support->he_support = 1;
 		support->eht_support = mld->trans->cfg->eht_supported;
+		support->uhr_support = mld->trans->cfg->uhr_supported;
 		break;
 	case NL80211_IFTYPE_AP:
 		/* for AP set according to the link configs */
 		for_each_vif_active_link(vif, link_conf, link_id) {
 			support->he_ap_support |= link_conf->he_support;
 			support->eht_support |= link_conf->eht_support;
+			support->uhr_support |= link_conf->uhr_support;
 		}
 		break;
 	default:
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index dc99e7ac4726..78482db732c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1069,7 +1069,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* PE RF */
 	IWL_DEV_INFO(iwl_rf_pe, iwl_bn201_name, RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_rf_pe, iwl_be223_name, RF_TYPE(PE),
+	IWL_DEV_INFO(iwl_rf_pe_no_uhr, iwl_be223_name, RF_TYPE(PE),
 		     SUBDEV_MASKED(0x0524, 0xFFF)),
 	IWL_DEV_INFO(iwl_rf_pe, iwl_bn203_name, RF_TYPE(PE),
 		     SUBDEV_MASKED(0x0324, 0xFFF)),
-- 
2.34.1



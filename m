Return-Path: <linux-wireless+bounces-36163-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLgUM0LvAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36163-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D050654F
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC7973001CE4
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C8F331A56;
	Sun, 10 May 2026 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUdB4ZJe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95953329C6B
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446138; cv=none; b=f3G1oMWJFlN/5fMN+FhAQ5p3/a2n3CYFhxiu2ShcL33ewGPuJ47Og/zqMVvbGiQ+1qhjKYu6cP0bB3Ja5wWylSuvpHStYmu9sGxdgUuUF/zQ/Wgsuywz6Snw1qNwcl2E/sfwmYTNkVaShczqx0NXIvG2Z45N+0QJZyU4MC66auM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446138; c=relaxed/simple;
	bh=zsYTN7nMyhlP1vHAVFMd+0h9maf5uc6jS5LWD9yveYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+26koVujMs5B0QBHlHLwFIrgyOXEnOiyAHC85b1B0NgHzORUVkIEhniNSBqKwTn45+I4XvkDwbBBZwmjr1mFwDpbwn/Q4vUVz45lOdX0cWVSs4xGT5yrj2lbFabfn4dWBV3B8JW7JErKMC3qdntkehtpq2yPU+xmxCwI7WaLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUdB4ZJe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446137; x=1809982137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zsYTN7nMyhlP1vHAVFMd+0h9maf5uc6jS5LWD9yveYE=;
  b=UUdB4ZJeqadyrTZ/fO7LsdiSfEt84T8pLuVyq4BOgFrm/kjp+cLCWYIz
   fmVSjFko6wZDQjgwJgKoN0CNWmnzBaiiIziukIVdvLm/BEeCikTZgnmuo
   HikZgp78wK2oUWOcQB5d0qOZebFu/yIzSGF16rys5/bs409ZwQYu2dMP9
   XK8WpNVmpVlh/2fh67iQphLK6NuzOpfSzU12xAzgos9+S5kp7TJfQFfP5
   EcMCNeBD9bMitDp8sUXgZQGZKGWM43ie2DX80SzKMuDmFXyKBdxIF6ckr
   bPVMf8EFESO0dvxO+KIAnWk8kWbTiZfwFce/8KL41GLfgkzSeZunpeuzz
   Q==;
X-CSE-ConnectionGUID: AfxyUil1Q9W/pgbr+Zr6eA==
X-CSE-MsgGUID: WEpkPdWuTxmKe9z3RWc4Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904747"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904747"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:48:56 -0700
X-CSE-ConnectionGUID: k2awCHdARuqruQNN2VG1cA==
X-CSE-MsgGUID: X2fIa9C2RbmicwqXZgwFwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095025"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:48:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 01/15] wifi: iwlwifi: mld: set NAN phy capabilities
Date: Sun, 10 May 2026 23:48:26 +0300
Message-Id: <20260510234534.3a5e5251dbaf.I566e1749cd17baa672bdd43712114e434f810a69@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
References: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE3D050654F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36163-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Copy the HT, VHT and HE capabilities from the sbands:
- The HT capabilities from the 2.4 GHz sband (there is no difference
  between the bands anyway).
- The VHT capabilities from the 5 GHz sband, obviously.
- The HE capabilities from the 2.4 GHz and for NL80211_IFTYPE_STATION.
  Fix it up to include also the needed 5 GHz bits.

For HE, there are bits that are band-dependent and iftype-dependent. For
those set to what makes most sense, and leave a comment to re-visit.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 46 ++++++++++++++++++-
 .../wireless/intel/iwlwifi/iwl-nvm-utils.h    |  8 +++-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  6 ++-
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 2aa47c5fa7d4..0736c8c00d4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2023, 2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023, 2025-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1053,6 +1053,46 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 	iwl_init_he_6ghz_capa(trans, data, sband, tx_chains, rx_chains);
 }
 
+static void
+iwl_init_nan_phy_capa(const struct iwl_fw *fw, struct iwl_nvm_data *data)
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+
+	if (!fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_NAN_SYNC_SUPPORT))
+		return;
+
+	data->nan_phy_capa.ht = data->bands[NL80211_BAND_2GHZ].ht_cap;
+	data->nan_phy_capa.vht = data->bands[NL80211_BAND_5GHZ].vht_cap;
+
+	he_cap = ieee80211_get_he_iftype_cap(&data->bands[NL80211_BAND_2GHZ],
+					     NL80211_IFTYPE_STATION);
+	if (he_cap) {
+		data->nan_phy_capa.he = *he_cap;
+		data->nan_phy_capa.he.he_cap_elem.phy_cap_info[0] |=
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+	}
+
+	/*
+	 * FIXME: we copied HE capabilities from the 2.4 GHz band,
+	 * but there are bits that are band-dependent:
+	 *
+	 * IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_1 - 2.4 GHz - set
+	 * IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3 - 5 GHz - not set
+	 * IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G - set
+	 * IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G - set
+	 * IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G - set
+	 *
+	 * We copied from STA iftype - so we have the following bits set:
+	 * IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS
+	 * IEEE80211_HE_PHY_CAP2_MIDAMBLE_RX_TX_MAX_NSTS
+	 * IEEE80211_HE_PHY_CAP7_MAX_NC_1
+	 * IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO
+	 *
+	 * Need to check which one should actually be set for NAN.
+	 */
+}
+
 void iwl_reinit_cab(struct iwl_trans *trans, struct iwl_nvm_data *data,
 		    u8 tx_chains, u8 rx_chains, const struct iwl_fw *fw)
 {
@@ -1081,6 +1121,8 @@ void iwl_reinit_cab(struct iwl_trans *trans, struct iwl_nvm_data *data,
 	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
 		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains,
 				     fw);
+
+	iwl_init_nan_phy_capa(fw, data);
 }
 IWL_EXPORT_SYMBOL(iwl_reinit_cab);
 
@@ -2105,6 +2147,8 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 	iwl_init_sbands(trans, nvm, channel_profile, tx_ant, rx_ant,
 			sbands_flags, v4, fw);
 
+	iwl_init_nan_phy_capa(fw, nvm);
+
 	iwl_free_resp(&hcmd);
 	return nvm;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h
index ac0a29a1c31f..e0c31f328a6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018, 2020-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018, 2020-2023, 2026 Intel Corporation
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  */
 #ifndef __iwl_eeprom_parse_h__
@@ -55,6 +55,12 @@ struct iwl_nvm_data {
 		struct ieee80211_sband_iftype_data uhb[2];
 	} iftd;
 
+	struct {
+		struct ieee80211_sta_ht_cap ht;
+		struct ieee80211_sta_vht_cap vht;
+		struct ieee80211_sta_he_cap he;
+	} nan_phy_capa;
+
 	struct ieee80211_channel channels[];
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index b48ebec18dd5..e66b304f345a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -360,6 +360,10 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 		hw->wiphy->nan_capa.dev_capabilities =
 			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
 			NAN_DEV_CAPA_NDPE_SUPPORTED;
+
+		hw->wiphy->nan_capa.phy.ht = mld->nvm_data->nan_phy_capa.ht;
+		hw->wiphy->nan_capa.phy.vht = mld->nvm_data->nan_phy_capa.vht;
+		hw->wiphy->nan_capa.phy.he = mld->nvm_data->nan_phy_capa.he;
 	} else {
 		wiphy->iface_combinations = iwl_mld_iface_combinations;
 		/* Do not include NAN combinations */
-- 
2.34.1



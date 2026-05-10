Return-Path: <linux-wireless+bounces-36146-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JQ+Nv/QAGoMNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36146-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:39:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F00505B74
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EE49300A7C0
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2703128A2;
	Sun, 10 May 2026 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwNdUfDj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC823112C1
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438394; cv=none; b=adxtkmZeIITTivh+n5TnGqd+Fg7+qROzFDEgwD9jZB/bo0NnVXon0vsXY9qvs1S2cFEb+15rAXoZifep8xqu8e7fnE7BC2YhUy7i5mJa3chSFRfcVV2xceGkd0zMa1HQamkuWzP/GeUcY12dLPpwVnwoRt2RR/6ib0t8+h3wFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438394; c=relaxed/simple;
	bh=zsYTN7nMyhlP1vHAVFMd+0h9maf5uc6jS5LWD9yveYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pajwoQ//fTRH8OgCKbXFhgd8YFDVtYuoQ63DWVV468J9TLDVvF88ar1qYRDpVU+iKTkgv8y2xEPF8mQbtBvNv12Wa046P1fxek0Nh2e2jSFaX0rwb2s/O7Hy0SKTTUJhqpZLSl29nam4XlUEIa1LxA0Xzj2+0nG6tAyPvwNEGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwNdUfDj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438393; x=1809974393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zsYTN7nMyhlP1vHAVFMd+0h9maf5uc6jS5LWD9yveYE=;
  b=GwNdUfDjq+sZ9+KdGAk9e8dw2XsKwBtuAXVpu58njZpqsMWuDKfctKir
   cmAkLFglLEIa+BsKZ8Yw5qBLu7pIQwBpKDSDzQ0KCdimY3swYUTCNuCsB
   aBNVepFUh4sXUtn2Ji9XPAxnIw4YoY2cuUbkk/XHzz3cMvNKkRQhDV9xP
   dc32I/1X0DYllCQLyh4VttL7n8ApwYf3tN2vMQUUkL278Zx+vQOj4D5JY
   CQLg7e1HBD+91h6GcodWipNhAjs/hN3uRVx3ZxKYYwwpEoTfiCL8G85YE
   25hwBy3DdxngNI73VauMCT8L3B5K3SzvGB/qmAJ2ai6MiLPHMpT/wEtZB
   g==;
X-CSE-ConnectionGUID: YL0kxjHaT7OyMPBBVL0WHA==
X-CSE-MsgGUID: SmsWn4eSQ/aUYQ/08XMdig==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208968"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208968"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:39:53 -0700
X-CSE-ConnectionGUID: f6aECmnVRseFHVm2sPf51w==
X-CSE-MsgGUID: oiH7eafxSsiYWkMMCc3sdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626753"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:39:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: set NAN phy capabilities
Date: Sun, 10 May 2026 21:39:24 +0300
Message-Id: <20260510213745.3a5e5251dbaf.I566e1749cd17baa672bdd43712114e434f810a69@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
References: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58F00505B74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36146-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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



Return-Path: <linux-wireless+bounces-36164-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHusCkfvAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36164-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6730350655C
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDB8F3001FB6
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC2329C6B;
	Sun, 10 May 2026 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUpm8Mgw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD3335066
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446140; cv=none; b=X+qFgAVd5Oe+ZglUkusytELsR3HuQDXemsBu9tch7+doR2vj++t4wg4H/XBAU8/eXzlRtr/EUeX1mjZVA8sz63NFuuHfEYQ11KddX98k7TzoiEfqUqGzB+UElPe/rxzaZscVtW7mlRSFx/IHEmALTa+tiJKhW35yrLBgGWjmcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446140; c=relaxed/simple;
	bh=PY6SQkFZ4dvSy2fuwVaPhjyTVl3/cVeJl8dpz5X1v7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXVCWOqVUST/Z9JQMg+fPfsq/0ZgZLDgTo6cRl5tAWENq9WdJ5GQyWIOtWwyBF1tfQu9zhw2aoMy0pel7YZLwfBPmcXsCS08d7ya9u5o3OUH+yzZl40UAFUOsHu3cpt7DzLNFIIAQxusyGbtUzq1oVlAqUpx3vKjhzEJh9j3uYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUpm8Mgw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446138; x=1809982138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PY6SQkFZ4dvSy2fuwVaPhjyTVl3/cVeJl8dpz5X1v7g=;
  b=eUpm8MgwNf7z08GYcoEa3XobNA/JFNdoxefY8XBXDd3L4CxYbsEjqTZU
   c9e0TCVUlqW9QF1RMDRT6ySEojYdIn8TT6Ge8pzpjImT/2tg3GbCfCfRk
   PyDnHbZRMfz421OEAWNmjYWtMWhO0JUX2OWZ5J6R4itG2jWgyowWhmGB3
   vVlpXzmET8ufDTyxA4x12S6F9Iv1henQcgVkl2qpGOFvH0StFs9UFkCsC
   qpDcZdcDgXLpHU5+Z1qWeXfftkww0mhzuOjo9LcFwO4NYNVoGQqxoNiSC
   bZ9NVa9YB4a0qQVOL6RzTK8LSYjadMKd9ILXGnWr3ousZU4M3EEKUNktS
   w==;
X-CSE-ConnectionGUID: vHp1mJV5TN2IMG7RWPILpw==
X-CSE-MsgGUID: xsj3AEDuQOiHCdjBdPSvrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904748"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904748"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:48:58 -0700
X-CSE-ConnectionGUID: UVHZgnTtRhCrPcxd9pZuuQ==
X-CSE-MsgGUID: BGwmsaTFSK6ZBSkf7p/pqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095028"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:48:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 02/15] wifi: iwlwifi: mld: tlc: separate from link STA
Date: Sun, 10 May 2026 23:48:27 +0300
Message-Id: <20260510234534.2c6589aab9db.I01729ec8be4687884831fc8761bf3fd8bba83056@changeid>
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
X-Rspamd-Queue-Id: 6730350655C
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
	TAGGED_FROM(0.00)[bounces-36164-lists,linux-wireless=lfdr.de];
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

From: Johannes Berg <johannes.berg@intel.com>

While NAN stations have the deflink link STA and that even
carries their information, having link STAs mostly implies
having real links, and NAN muddies that by having stations
with deflink carrying their capabilities and links at the
NAN level, but no link stations corresponding to NAN links.

Separate out the data needed to build TLC commands into a
new struct iwl_mld_tlc_sta_capa data structure so that the
whole data usage in the TLC code is clarified and we won't
make assumptions, say about being able to look up the link
of an interface from the (NAN) link sta correctly, which
would result in a link but not with a chanctx.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c | 267 ++++++++++---------
 1 file changed, 139 insertions(+), 128 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index 78d6162d9297..b1722982db9c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -15,9 +15,9 @@
 #include "fw/api/context.h"
 #include "fw/api/dhc.h"
 
-static u8 iwl_mld_fw_bw_from_sta_bw(const struct ieee80211_link_sta *link_sta)
+static u8 iwl_mld_fw_bw_from_sta_bw(enum ieee80211_sta_rx_bandwidth bandwidth)
 {
-	switch (link_sta->bandwidth) {
+	switch (bandwidth) {
 	case IEEE80211_STA_RX_BW_320:
 		return IWL_TLC_MNG_CH_WIDTH_320MHZ;
 	case IEEE80211_STA_RX_BW_160:
@@ -32,40 +32,61 @@ static u8 iwl_mld_fw_bw_from_sta_bw(const struct ieee80211_link_sta *link_sta)
 	}
 }
 
+struct iwl_mld_tlc_sta_capa {
+	u16 non_ht_rates;
+	u16 max_amsdu_len;
+	u8 rx_nss;
+	enum ieee80211_sta_rx_bandwidth bandwidth;
+	enum ieee80211_smps_mode smps_mode;
+	const struct ieee80211_sta_ht_cap *ht_cap;
+	const struct ieee80211_sta_vht_cap *vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	const struct ieee80211_sta_uhr_cap *uhr_cap;
+
+	const struct ieee80211_sta_he_cap *own_he_cap;
+	const struct ieee80211_sta_eht_cap *own_eht_cap;
+	const struct ieee80211_sta_uhr_cap *own_uhr_cap;
+};
+
 static __le16
 iwl_mld_get_tlc_cmd_flags(struct iwl_mld *mld,
-			  struct ieee80211_vif *vif,
-			  struct ieee80211_link_sta *link_sta,
-			  const struct ieee80211_sta_he_cap *own_he_cap,
-			  const struct ieee80211_sta_eht_cap *own_eht_cap,
-			  const struct ieee80211_sta_uhr_cap *own_uhr_cap)
+			  struct iwl_mld_tlc_sta_capa *capa)
 {
-	struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
-	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
-	struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
-	bool has_vht = vht_cap->vht_supported;
+	const struct ieee80211_sta_ht_cap *ht_cap = capa->ht_cap;
+	const struct ieee80211_sta_vht_cap *vht_cap = capa->vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap = capa->he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap = capa->eht_cap;
+	const struct ieee80211_sta_uhr_cap *uhr_cap = capa->uhr_cap;
+	const struct ieee80211_sta_he_cap *own_he_cap = capa->own_he_cap;
+	const struct ieee80211_sta_eht_cap *own_eht_cap = capa->own_eht_cap;
+	const struct ieee80211_sta_uhr_cap *own_uhr_cap = capa->own_uhr_cap;
+	bool has_vht = vht_cap && vht_cap->vht_supported;
 	u16 flags = 0;
 
 	/* STBC flags */
 	if (mld->cfg->ht_params.stbc &&
 	    (hweight8(iwl_mld_get_valid_tx_ant(mld)) > 1)) {
-		if (he_cap->has_he && he_cap->he_cap_elem.phy_cap_info[2] &
-				      IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
+		if (he_cap && he_cap->has_he &&
+		    he_cap->he_cap_elem.phy_cap_info[2] &
+				IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
 			flags |= IWL_TLC_MNG_CFG_FLAGS_STBC_MSK;
-		else if (vht_cap->cap & IEEE80211_VHT_CAP_RXSTBC_MASK)
+		else if (vht_cap &&
+			 vht_cap->cap & IEEE80211_VHT_CAP_RXSTBC_MASK)
 			flags |= IWL_TLC_MNG_CFG_FLAGS_STBC_MSK;
-		else if (ht_cap->cap & IEEE80211_HT_CAP_RX_STBC)
+		else if (ht_cap && ht_cap->cap & IEEE80211_HT_CAP_RX_STBC)
 			flags |= IWL_TLC_MNG_CFG_FLAGS_STBC_MSK;
 	}
 
 	/* LDPC */
 	if (mld->cfg->ht_params.ldpc &&
-	    ((ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING) ||
+	    ((ht_cap && ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING) ||
 	     (has_vht && (vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC))))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
-	if (he_cap->has_he && (he_cap->he_cap_elem.phy_cap_info[1] &
-	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
+	if (he_cap && he_cap->has_he &&
+	    (he_cap->he_cap_elem.phy_cap_info[1] &
+			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
 	if (own_he_cap &&
@@ -74,7 +95,7 @@ iwl_mld_get_tlc_cmd_flags(struct iwl_mld *mld,
 		flags &= ~IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
 	/* DCM */
-	if (he_cap->has_he &&
+	if (he_cap && he_cap->has_he &&
 	    (he_cap->he_cap_elem.phy_cap_info[3] &
 	     IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK &&
 	     own_he_cap &&
@@ -85,15 +106,15 @@ iwl_mld_get_tlc_cmd_flags(struct iwl_mld *mld,
 	/* Extra EHT LTF */
 	if (own_eht_cap &&
 	    own_eht_cap->eht_cap_elem.phy_cap_info[5] &
-		IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF &&
-	    link_sta->eht_cap.has_eht &&
-	    link_sta->eht_cap.eht_cap_elem.phy_cap_info[5] &
-	    IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF) {
+			IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF &&
+	    eht_cap && eht_cap->has_eht &&
+	    eht_cap->eht_cap_elem.phy_cap_info[5] &
+			IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF) {
 		flags |= IWL_TLC_MNG_CFG_FLAGS_EHT_EXTRA_LTF_MSK;
 	}
 
-	if (link_sta->uhr_cap.has_uhr && own_uhr_cap &&
-	    link_sta->uhr_cap.phy.cap & IEEE80211_UHR_PHY_CAP_ELR_RX &&
+	if (uhr_cap && uhr_cap->has_uhr && own_uhr_cap &&
+	    uhr_cap->phy.cap & IEEE80211_UHR_PHY_CAP_ELR_RX &&
 	    own_uhr_cap->phy.cap & IEEE80211_UHR_PHY_CAP_ELR_TX)
 		flags |= IWL_TLC_MNG_CFG_FLAGS_UHR_ELR_1_5_MBPS_MSK |
 			 IWL_TLC_MNG_CFG_FLAGS_UHR_ELR_3_MBPS_MSK;
@@ -114,27 +135,27 @@ static u8 iwl_mld_get_fw_chains(struct iwl_mld *mld)
 	return fw_chains;
 }
 
-static u8 iwl_mld_get_fw_sgi(struct ieee80211_link_sta *link_sta)
+static u8 iwl_mld_get_fw_sgi(struct iwl_mld_tlc_sta_capa *capa)
 {
-	struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
-	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
-	struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
+	const struct ieee80211_sta_ht_cap *ht_cap = capa->ht_cap;
+	const struct ieee80211_sta_vht_cap *vht_cap = capa->vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap = capa->he_cap;
 	u8 sgi_chwidths = 0;
 
 	/* If the association supports HE, HT/VHT rates will never be used for
 	 * Tx and therefor there's no need to set the
 	 * sgi-per-channel-width-support bits
 	 */
-	if (he_cap->has_he)
+	if (he_cap && he_cap->has_he)
 		return 0;
 
-	if (ht_cap->cap & IEEE80211_HT_CAP_SGI_20)
+	if (ht_cap && ht_cap->cap & IEEE80211_HT_CAP_SGI_20)
 		sgi_chwidths |= BIT(IWL_TLC_MNG_CH_WIDTH_20MHZ);
-	if (ht_cap->cap & IEEE80211_HT_CAP_SGI_40)
+	if (ht_cap && ht_cap->cap & IEEE80211_HT_CAP_SGI_40)
 		sgi_chwidths |= BIT(IWL_TLC_MNG_CH_WIDTH_40MHZ);
-	if (vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_80)
+	if (vht_cap && vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_80)
 		sgi_chwidths |= BIT(IWL_TLC_MNG_CH_WIDTH_80MHZ);
-	if (vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_160)
+	if (vht_cap && vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_160)
 		sgi_chwidths |= BIT(IWL_TLC_MNG_CH_WIDTH_160MHZ);
 
 	return sgi_chwidths;
@@ -164,31 +185,30 @@ iwl_mld_get_highest_fw_mcs(const struct ieee80211_sta_vht_cap *vht_cap,
 }
 
 static void
-iwl_mld_fill_vht_rates(const struct ieee80211_link_sta *link_sta,
-		       const struct ieee80211_sta_vht_cap *vht_cap,
+iwl_mld_fill_vht_rates(struct iwl_mld_tlc_sta_capa *capa,
 		       struct iwl_tlc_config_cmd *cmd)
 {
 	u32 supp;
 	int i, highest_mcs;
-	u8 max_nss = link_sta->rx_nss;
+	u8 max_nss = capa->rx_nss;
 	struct ieee80211_vht_cap ieee_vht_cap = {
-		.vht_cap_info = cpu_to_le32(vht_cap->cap),
-		.supp_mcs = vht_cap->vht_mcs,
+		.vht_cap_info = cpu_to_le32(capa->vht_cap->cap),
+		.supp_mcs = capa->vht_cap->vht_mcs,
 	};
 
 	/* the station support only a single receive chain */
-	if (link_sta->smps_mode == IEEE80211_SMPS_STATIC)
+	if (capa->smps_mode == IEEE80211_SMPS_STATIC)
 		max_nss = 1;
 
 	for (i = 0; i < max_nss && i < IWL_TLC_NSS_MAX; i++) {
 		int nss = i + 1;
 
-		highest_mcs = iwl_mld_get_highest_fw_mcs(vht_cap, nss);
+		highest_mcs = iwl_mld_get_highest_fw_mcs(capa->vht_cap, nss);
 		if (!highest_mcs)
 			continue;
 
 		supp = BIT(highest_mcs + 1) - 1;
-		if (link_sta->bandwidth == IEEE80211_STA_RX_BW_20)
+		if (capa->bandwidth == IEEE80211_STA_RX_BW_20)
 			supp &= ~BIT(IWL_TLC_MNG_HT_RATE_MCS9);
 
 		cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_80] = cpu_to_le32(supp);
@@ -196,7 +216,7 @@ iwl_mld_fill_vht_rates(const struct ieee80211_link_sta *link_sta,
 		 * configuration is supported - only for MCS 0 since we already
 		 * decoded the MCS bits anyway ourselves.
 		 */
-		if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160 &&
+		if (capa->bandwidth == IEEE80211_STA_RX_BW_160 &&
 		    ieee80211_get_vht_max_nss(&ieee_vht_cap,
 					      IEEE80211_VHT_CHANWIDTH_160MHZ,
 					      0, true, nss) >= nss)
@@ -223,20 +243,19 @@ static u32 iwl_mld_he_mac80211_mcs_to_fw_mcs(u16 mcs)
 }
 
 static void
-iwl_mld_fill_he_rates(const struct ieee80211_link_sta *link_sta,
-		      const struct ieee80211_sta_he_cap *own_he_cap,
+iwl_mld_fill_he_rates(struct iwl_mld_tlc_sta_capa *capa,
 		      struct iwl_tlc_config_cmd *cmd)
 {
-	const struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
+	const struct ieee80211_sta_he_cap *he_cap = capa->he_cap;
 	u16 mcs_160 = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 	u16 mcs_80 = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
-	u16 tx_mcs_80 = le16_to_cpu(own_he_cap->he_mcs_nss_supp.tx_mcs_80);
-	u16 tx_mcs_160 = le16_to_cpu(own_he_cap->he_mcs_nss_supp.tx_mcs_160);
+	u16 tx_mcs_80 = le16_to_cpu(capa->own_he_cap->he_mcs_nss_supp.tx_mcs_80);
+	u16 tx_mcs_160 = le16_to_cpu(capa->own_he_cap->he_mcs_nss_supp.tx_mcs_160);
 	int i;
-	u8 nss = link_sta->rx_nss;
+	u8 nss = capa->rx_nss;
 
 	/* the station support only a single receive chain */
-	if (link_sta->smps_mode == IEEE80211_SMPS_STATIC)
+	if (capa->smps_mode == IEEE80211_SMPS_STATIC)
 		nss = 1;
 
 	for (i = 0; i < nss && i < IWL_TLC_NSS_MAX; i++) {
@@ -313,17 +332,15 @@ static u8 iwl_mld_get_eht_max_nss(u8 rx_nss, u8 tx_nss)
 
 static void
 iwl_mld_fill_eht_rates(struct ieee80211_vif *vif,
-		       const struct ieee80211_link_sta *link_sta,
-		       const struct ieee80211_sta_he_cap *own_he_cap,
-		       const struct ieee80211_sta_eht_cap *own_eht_cap,
+		       struct iwl_mld_tlc_sta_capa *capa,
 		       struct iwl_tlc_config_cmd *cmd)
 {
 	/* peer RX mcs capa */
 	const struct ieee80211_eht_mcs_nss_supp *eht_rx_mcs =
-		&link_sta->eht_cap.eht_mcs_nss_supp;
+		&capa->eht_cap->eht_mcs_nss_supp;
 	/* our TX mcs capa */
 	const struct ieee80211_eht_mcs_nss_supp *eht_tx_mcs =
-		&own_eht_cap->eht_mcs_nss_supp;
+		&capa->own_eht_cap->eht_mcs_nss_supp;
 
 	enum IWL_TLC_MCS_PER_BW bw;
 	struct ieee80211_eht_mcs_nss_supp_20mhz_only mcs_rx_20;
@@ -331,7 +348,7 @@ iwl_mld_fill_eht_rates(struct ieee80211_vif *vif,
 
 	/* peer is 20 MHz only */
 	if (vif->type == NL80211_IFTYPE_AP &&
-	    !(link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
+	    !(capa->he_cap->he_cap_elem.phy_cap_info[0] &
 	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
 		mcs_rx_20 = eht_rx_mcs->only_20mhz;
 	} else {
@@ -346,7 +363,7 @@ iwl_mld_fill_eht_rates(struct ieee80211_vif *vif,
 	}
 
 	/* NIC is capable of 20 MHz only */
-	if (!(own_he_cap->he_cap_elem.phy_cap_info[0] &
+	if (!(capa->own_he_cap->he_cap_elem.phy_cap_info[0] &
 	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
 		mcs_tx_20 = eht_tx_mcs->only_20mhz;
 	} else {
@@ -402,67 +419,51 @@ iwl_mld_fill_eht_rates(struct ieee80211_vif *vif,
 	}
 
 	/* the station support only a single receive chain */
-	if (link_sta->smps_mode == IEEE80211_SMPS_STATIC ||
-	    link_sta->rx_nss < 2)
+	if (capa->smps_mode == IEEE80211_SMPS_STATIC ||
+	    capa->rx_nss < 2)
 		memset(cmd->ht_rates[IWL_TLC_NSS_2], 0,
 		       sizeof(cmd->ht_rates[IWL_TLC_NSS_2]));
 }
 
 static void
-iwl_mld_fill_supp_rates(struct iwl_mld *mld, struct ieee80211_vif *vif,
-			struct ieee80211_link_sta *link_sta,
-			struct ieee80211_supported_band *sband,
-			const struct ieee80211_sta_he_cap *own_he_cap,
-			const struct ieee80211_sta_eht_cap *own_eht_cap,
-			const struct ieee80211_sta_uhr_cap *own_uhr_cap,
+iwl_mld_fill_supp_rates(struct iwl_mld *mld,
+			struct ieee80211_vif *vif,
+			struct iwl_mld_tlc_sta_capa *capa,
 			struct iwl_tlc_config_cmd *cmd)
 {
-	int i;
-	u16 non_ht_rates = 0;
-	unsigned long rates_bitmap;
-	const struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
-	const struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
-	const struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
-
-	/* non HT rates */
-	rates_bitmap = link_sta->supp_rates[sband->band];
-	for_each_set_bit(i, &rates_bitmap, BITS_PER_LONG)
-		non_ht_rates |= BIT(sband->bitrates[i].hw_value);
-
-	cmd->non_ht_rates = cpu_to_le16(non_ht_rates);
+	cmd->non_ht_rates = cpu_to_le16(capa->non_ht_rates);
 	cmd->mode = IWL_TLC_MNG_MODE_NON_HT;
 
-	if (link_sta->uhr_cap.has_uhr && own_uhr_cap) {
+	if (capa->uhr_cap && capa->uhr_cap->has_uhr && capa->own_uhr_cap) {
 		cmd->mode = IWL_TLC_MNG_MODE_UHR;
 		/*
 		 * FIXME: spec currently inherits from EHT but has no
 		 * finer MCS bits. Once that's there, need to add them
 		 * to the bitmaps (and maybe copy this to UHR, or so.)
 		 */
-		iwl_mld_fill_eht_rates(vif, link_sta, own_he_cap,
-				       own_eht_cap, cmd);
-	} else if (link_sta->eht_cap.has_eht && own_he_cap && own_eht_cap) {
+		iwl_mld_fill_eht_rates(vif, capa, cmd);
+	} else if (capa->eht_cap && capa->eht_cap->has_eht &&
+		   capa->own_he_cap && capa->own_eht_cap) {
 		cmd->mode = IWL_TLC_MNG_MODE_EHT;
-		iwl_mld_fill_eht_rates(vif, link_sta, own_he_cap,
-				       own_eht_cap, cmd);
-	} else if (he_cap->has_he && own_he_cap) {
+		iwl_mld_fill_eht_rates(vif, capa, cmd);
+	} else if (capa->he_cap && capa->he_cap->has_he && capa->own_he_cap) {
 		cmd->mode = IWL_TLC_MNG_MODE_HE;
-		iwl_mld_fill_he_rates(link_sta, own_he_cap, cmd);
-	} else if (vht_cap->vht_supported) {
+		iwl_mld_fill_he_rates(capa, cmd);
+	} else if (capa->vht_cap && capa->vht_cap->vht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_VHT;
-		iwl_mld_fill_vht_rates(link_sta, vht_cap, cmd);
-	} else if (ht_cap->ht_supported) {
+			iwl_mld_fill_vht_rates(capa, cmd);
+	} else if (capa->ht_cap && capa->ht_cap->ht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_HT;
 		cmd->ht_rates[IWL_TLC_NSS_1][IWL_TLC_MCS_PER_BW_80] =
-			cpu_to_le32(ht_cap->mcs.rx_mask[0]);
+			cpu_to_le32(capa->ht_cap->mcs.rx_mask[0]);
 
 		/* the station support only a single receive chain */
-		if (link_sta->smps_mode == IEEE80211_SMPS_STATIC)
+		if (capa->smps_mode == IEEE80211_SMPS_STATIC)
 			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_MCS_PER_BW_80] =
 				0;
 		else
 			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_MCS_PER_BW_80] =
-				cpu_to_le32(ht_cap->mcs.rx_mask[1]);
+				cpu_to_le32(capa->ht_cap->mcs.rx_mask[1]);
 	}
 }
 
@@ -527,60 +528,35 @@ static int iwl_mld_convert_tlc_cmd_to_v4(struct iwl_tlc_config_cmd *cmd,
 
 static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
-				 struct ieee80211_link_sta *link_sta,
-				 struct ieee80211_bss_conf *link)
+				 struct iwl_mld_sta *mld_sta,
+				 int fw_sta_id, int phy_id,
+				 struct iwl_mld_tlc_sta_capa *capa)
 {
-	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
-	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
-	enum nl80211_band band = link->chanreq.oper.chan->band;
-	struct ieee80211_supported_band *sband = mld->hw->wiphy->bands[band];
-	const struct ieee80211_sta_he_cap *own_he_cap =
-		ieee80211_get_he_iftype_cap_vif(sband, vif);
-	const struct ieee80211_sta_eht_cap *own_eht_cap =
-		ieee80211_get_eht_iftype_cap_vif(sband, vif);
-	const struct ieee80211_sta_uhr_cap *own_uhr_cap =
-		ieee80211_get_uhr_iftype_cap_vif(sband, vif);
 	struct iwl_tlc_config_cmd cmd = {
 		/* For AP mode, use 20 MHz until the STA is authorized */
 		.max_ch_width = mld_sta->sta_state > IEEE80211_STA_ASSOC ?
-			iwl_mld_fw_bw_from_sta_bw(link_sta) :
+			iwl_mld_fw_bw_from_sta_bw(capa->bandwidth) :
 			IWL_TLC_MNG_CH_WIDTH_20MHZ,
-		.flags = iwl_mld_get_tlc_cmd_flags(mld, vif, link_sta,
-						   own_he_cap, own_eht_cap,
-						   own_uhr_cap),
+		.flags = iwl_mld_get_tlc_cmd_flags(mld, capa),
 		.chains = iwl_mld_get_fw_chains(mld),
-		.sgi_ch_width_supp = iwl_mld_get_fw_sgi(link_sta),
-		.max_mpdu_len = cpu_to_le16(link_sta->agg.max_amsdu_len),
+		.sgi_ch_width_supp = iwl_mld_get_fw_sgi(capa),
+		.max_mpdu_len = cpu_to_le16(capa->max_amsdu_len),
 	};
-	int fw_sta_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
 	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD);
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0);
-	struct ieee80211_chanctx_conf *chan_ctx;
 	struct iwl_tlc_config_cmd_v5 cmd_v5 = {};
 	struct iwl_tlc_config_cmd_v4 cmd_v4 = {};
 	void *cmd_ptr;
 	u8 cmd_size;
-	u32 phy_id;
 	int ret;
 
 	if (fw_sta_id < 0)
 		return;
 
 	cmd.sta_mask = cpu_to_le32(BIT(fw_sta_id));
-
-	if (WARN_ON_ONCE(!mld_link))
-		return;
-
-	chan_ctx = rcu_dereference_wiphy(mld->wiphy, mld_link->chan_ctx);
-	if (WARN_ON(!chan_ctx))
-		return;
-
-	phy_id = iwl_mld_phy_from_mac80211(chan_ctx)->fw_id;
 	cmd.phy_id = cpu_to_le32(phy_id);
 
-	iwl_mld_fill_supp_rates(mld, vif, link_sta, sband,
-				own_he_cap, own_eht_cap,
-				own_uhr_cap, &cmd);
+	iwl_mld_fill_supp_rates(mld, vif, capa, &cmd);
 
 	if (cmd_ver == 6) {
 		cmd_ptr = &cmd;
@@ -647,10 +623,24 @@ void iwl_mld_config_tlc_link(struct iwl_mld *mld,
 			     struct ieee80211_link_sta *link_sta)
 {
 	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link_conf);
+	struct ieee80211_chanctx_conf *chan_ctx;
+	struct ieee80211_supported_band *sband;
+	struct iwl_mld_tlc_sta_capa capa = {};
+	unsigned long rates_bitmap;
+	enum nl80211_band band;
+	int fw_sta_id, i;
+
+	if (WARN_ON_ONCE(!mld_link))
+		return;
 
-	if (WARN_ON_ONCE(!link_conf->chanreq.oper.chan))
+	chan_ctx = rcu_dereference_wiphy(mld->wiphy, mld_link->chan_ctx);
+	if (WARN_ON_ONCE(!chan_ctx))
 		return;
 
+	band = chan_ctx->def.chan->band;
+	sband = mld->hw->wiphy->bands[band];
+
 	/* Before we have information about a station, configure the A-MSDU RC
 	 * limit such that iwlmd and mac80211 would not be allowed to build
 	 * A-MSDUs.
@@ -660,7 +650,28 @@ void iwl_mld_config_tlc_link(struct iwl_mld *mld,
 		ieee80211_sta_recalc_aggregates(link_sta->sta);
 	}
 
-	iwl_mld_send_tlc_cmd(mld, vif, link_sta, link_conf);
+	/* non HT rates */
+	rates_bitmap = link_sta->supp_rates[sband->band];
+	for_each_set_bit(i, &rates_bitmap, BITS_PER_LONG)
+		capa.non_ht_rates |= BIT(sband->bitrates[i].hw_value);
+
+	capa.rx_nss = link_sta->rx_nss;
+	capa.smps_mode = link_sta->smps_mode;
+	capa.bandwidth = link_sta->bandwidth;
+	capa.max_amsdu_len = link_sta->agg.max_amsdu_len;
+	capa.ht_cap = &link_sta->ht_cap;
+	capa.vht_cap = &link_sta->vht_cap;
+	capa.he_cap = &link_sta->he_cap;
+	capa.eht_cap = &link_sta->eht_cap;
+	capa.uhr_cap = &link_sta->uhr_cap;
+	capa.own_he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
+	capa.own_eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, vif);
+	capa.own_uhr_cap = ieee80211_get_uhr_iftype_cap_vif(sband, vif);
+
+	fw_sta_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
+	iwl_mld_send_tlc_cmd(mld, vif, mld_sta, fw_sta_id,
+			     iwl_mld_phy_from_mac80211(chan_ctx)->fw_id,
+			     &capa);
 }
 
 void iwl_mld_tlc_update_phy(struct iwl_mld *mld, struct ieee80211_vif *vif,
-- 
2.34.1
---
v2: use mld_link and not link_conf


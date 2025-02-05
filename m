Return-Path: <linux-wireless+bounces-18525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C6A28AFE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D2E3A56BE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703A7083D;
	Wed,  5 Feb 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw8rcC8b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9A138DEC
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760178; cv=none; b=IlxxKwfVR5QmOw++VwhuBziDEz0SW6ky2PxtQnzNN6JTDnGvQXauLZVDy5xULbIS4w9AGbpv2IGWLovjQ+aPvXmk3KBvlkfH8ol27f7rYUCWWDDBZxQRgfwCYUuXh12Es5JijVFpPfTDWFA3s2LA1TNp4KvlLhGGQ/i1dezSXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760178; c=relaxed/simple;
	bh=6jNiRVMf4U0W8Z8j13WyfuCnE2OmqtRaFWhKwjpWv64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEDdYJlCS+heI+XC+IRmB8oi2l3+1a1/9m6nujCE/l69s8d1WZny/bJM4AJEZFyFE7aS3Wj5T0nDRwOZMn+I3PiknW2uVpD7mXmc2b3NHh2eXdiOXFniYgzt9xiCg0vz6WPdM3GFTOp243JYUKQgdJmARCtN17X/qu3QPQQezxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw8rcC8b; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760177; x=1770296177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6jNiRVMf4U0W8Z8j13WyfuCnE2OmqtRaFWhKwjpWv64=;
  b=Iw8rcC8b884GcTnIUc+rk95Zk6AWqbooYAZWTpCN5XD8aiO5LpKC6nZO
   dq1jCLKsiLLfh+yYt444S7caAyfsJ/YNcg9mq1WY5XZf/NWQiLY7caP9M
   m9e8HZyv+nrDdnHi1O8vSuDB02CVGT25huggtWopEXuOXcx3WFBjHZwJT
   kWUJZSN73W7JVYkcOmm2OgPSVZPOChzMcsc4Vib+GkY4Ge3QHPFKuQi8/
   slVz4CWIgJN7CoC/lF91pHeSbHrCYG1+j9o2Wgk+Ft3d76K4QhNKWeKnp
   ZKgeYr6do9OayXS1XwfAZghRPugZTZcJeBKqVm0I4Pnu4lJwFBcYKlesE
   w==;
X-CSE-ConnectionGUID: otsXeMMYRyirBrrLhPFwTQ==
X-CSE-MsgGUID: ojzsvFVESr+/UA7attUWxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159184"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159184"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:16 -0800
X-CSE-ConnectionGUID: ZMUE9SSARB2GVaYBejEg4g==
X-CSE-MsgGUID: R0gLJDt+RA2f9yJTs+kO7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745464"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:15 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 07/19] wifi: iwlwifi: enable 320 MHz on slow PCIe links
Date: Wed,  5 Feb 2025 14:55:36 +0200
Message-Id: <20250205145347.1e5356a3b124.I1224023721aaeff8ebcaa47dff88613c7fd0533a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Despite not being able to sustain the full 320 MHz throughput
even at MCS 9, enable 320 MHz on slow PCIe links. This may in
some cases result in frames being dropped (on the air) by the
firmware if they cannot be delivered to the host, but it can
still be better to use 320 MHz.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c  | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 9f7e013252fe..76259ac261cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -913,11 +913,8 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 {
 	bool is_ap = iftype_data->types_mask & (BIT(NL80211_IFTYPE_AP) |
 						BIT(NL80211_IFTYPE_P2P_GO));
-	bool no_320;
-
-	no_320 = (!trans->trans_cfg->integrated &&
-		 trans->pcie_link_speed < PCI_EXP_LNKSTA_CLS_8_0GB) ||
-		 trans->reduced_cap_sku;
+	bool slow_pcie = (!trans->trans_cfg->integrated &&
+			  trans->pcie_link_speed < PCI_EXP_LNKSTA_CLS_8_0GB);
 
 	if (!data->sku_cap_11be_enable || iwlwifi_mod_params.disable_11be)
 		iftype_data->eht_cap.has_eht = false;
@@ -944,7 +941,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 				       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
 		break;
 	case NL80211_BAND_6GHZ:
-		if (!no_320) {
+		if (!trans->reduced_cap_sku) {
 			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[0] |=
 				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[1] |=
@@ -986,6 +983,14 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 				iftype_data->eht_cap.eht_cap_elem.phy_cap_info[4] |= 0x10;
 			}
 		}
+
+		if (slow_pcie) {
+			struct ieee80211_eht_mcs_nss_supp *mcs_nss =
+				&iftype_data->eht_cap.eht_mcs_nss_supp;
+
+			mcs_nss->bw._320.rx_tx_mcs11_max_nss = 0;
+			mcs_nss->bw._320.rx_tx_mcs13_max_nss = 0;
+		}
 	} else {
 		struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp =
 			&iftype_data->he_cap.he_mcs_nss_supp;
-- 
2.34.1



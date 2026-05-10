Return-Path: <linux-wireless+bounces-36172-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPNeC23vAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36172-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B815550659C
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DD86301939A
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C71F33C1B7;
	Sun, 10 May 2026 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+xN7gIa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7C64
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446148; cv=none; b=mjjK0ZD3LEwjesCY4SvJxj8SS8eoOehqZnCt4Xm1mlMhryJl7ZDDGBXGZFB/vI3RarEQl5n+9pzSAEYlP2sf6/O8CQKAyfxMt+hedhij7Mc1dCi4xOP1AxnbuPmpwPtUbzVva+CxQlxns7pdyNGYVmfjnGs04E7JJSsrXdUKHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446148; c=relaxed/simple;
	bh=vjZGmMT9asfY91hmfU7tdLkMlrL4vz3pBDeglzGC6Sc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5gF7zSxhDFG8guOitcKj3sfYOYh4vjRw9UKa2WkqpWhapV69EVR8+986Yf1Nz65zxwe8MLRt0Mojc491Ob79A6+PXKt2udvOQ7yJ8ZDZ4y5dN5BmRuuMn/bt5kBZoogtp4GcgZWRFVXQF89Q4zSnRZ8kMuxHQgCQ5TaZvaQHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+xN7gIa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446147; x=1809982147;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=vjZGmMT9asfY91hmfU7tdLkMlrL4vz3pBDeglzGC6Sc=;
  b=H+xN7gIatZPOgh1gCfk7oIIqSFBDEskzDVmJy2lCMny7kQ58qULL47nV
   iyyBISb1rG4DR4h+YazkDu31ygB/6CSd471g1ZQnJs9GhMJfzneR7DhC5
   OfNY27CDGZgOVGn63I82ykgwD5pK2NWc07cZAZztDvC9TK3qFSe0Apeqz
   /aw9Qbi0YyqGXOvgmcc2nKZJ5UagYjwhxMVRy/ASEauZVDr+7klmE1JON
   n2a6kFrt5KrKF87wrb+InhB5DFqjuc9O39P3mdmC5d6f1NqoZllMNmmY4
   jeROVcifnc89HNvwcxU4hnPYHt8Iewl26z6if3wTU59AmAOf4I74S6A4W
   w==;
X-CSE-ConnectionGUID: n5o+gKFpSjKa0PzFdTSsVQ==
X-CSE-MsgGUID: IRvJ17rbSBafo50pCKmHmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904758"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904758"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:07 -0700
X-CSE-ConnectionGUID: GKbF4mL4QhWnFJaw+jaWJg==
X-CSE-MsgGUID: JCGwPZ0MRx2tDPpQLUtXDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095063"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 10/15] wifi: iwlwifi: mld: extract NAN capabilities setting to a function
Date: Sun, 10 May 2026 23:48:35 +0300
Message-Id: <20260510234534.da1f380ced3b.I02013e9d5946a1b3372d2fcd570057fdb4416b65@changeid>
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
X-Rspamd-Queue-Id: B815550659C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36172-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

There are now quite a lot of capabilities to set, so move it to a
dedicated function, for better clarity.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 65 ++++++++++---------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index cabf47367fda..e76421a8a8e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -272,6 +272,38 @@ static void iwl_mac_hw_set_flags(struct iwl_mld *mld)
 	ieee80211_hw_set(hw, TDLS_WIDER_BW);
 }
 
+static void iwl_mld_hw_set_nan(struct iwl_mld *mld)
+{
+	struct ieee80211_hw *hw = mld->hw;
+
+	hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_NAN);
+
+	hw->wiphy->nan_supported_bands = BIT(NL80211_BAND_2GHZ);
+	if (mld->nvm_data->bands[NL80211_BAND_5GHZ].n_channels)
+		hw->wiphy->nan_supported_bands |=
+			BIT(NL80211_BAND_5GHZ);
+
+	hw->wiphy->nan_capa.flags = WIPHY_NAN_FLAGS_CONFIGURABLE_SYNC |
+				    WIPHY_NAN_FLAGS_USERSPACE_DE;
+
+	hw->wiphy->nan_capa.op_mode = NAN_OP_MODE_PHY_MODE_VHT |
+				      NAN_OP_MODE_PHY_MODE_HE |
+				      NAN_OP_MODE_160MHZ;
+
+	/* Support 2 antennas for Tx and Rx */
+	hw->wiphy->nan_capa.n_antennas = 0x22;
+
+	/* Maximal channel switch time is 4 msec */
+	hw->wiphy->nan_capa.max_channel_switch_time = 4;
+	hw->wiphy->nan_capa.dev_capabilities =
+		NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
+		NAN_DEV_CAPA_NDPE_SUPPORTED;
+
+	hw->wiphy->nan_capa.phy.ht = mld->nvm_data->nan_phy_capa.ht;
+	hw->wiphy->nan_capa.phy.vht = mld->nvm_data->nan_phy_capa.vht;
+	hw->wiphy->nan_capa.phy.he = mld->nvm_data->nan_phy_capa.he;
+}
+
 static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 {
 	struct ieee80211_hw *hw = mld->hw;
@@ -334,38 +366,13 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 
 	wiphy->hw_timestamp_max_peers = 1;
 
+	wiphy->iface_combinations = iwl_mld_iface_combinations;
+
 	if (iwl_mld_nan_supported(mld)) {
-		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_NAN);
-		hw->wiphy->iface_combinations = iwl_mld_iface_combinations;
-		hw->wiphy->n_iface_combinations =
+		wiphy->n_iface_combinations =
 			ARRAY_SIZE(iwl_mld_iface_combinations);
-
-		hw->wiphy->nan_supported_bands = BIT(NL80211_BAND_2GHZ);
-		if (mld->nvm_data->bands[NL80211_BAND_5GHZ].n_channels)
-			hw->wiphy->nan_supported_bands |=
-				BIT(NL80211_BAND_5GHZ);
-
-		hw->wiphy->nan_capa.flags = WIPHY_NAN_FLAGS_CONFIGURABLE_SYNC |
-					    WIPHY_NAN_FLAGS_USERSPACE_DE;
-
-		hw->wiphy->nan_capa.op_mode = NAN_OP_MODE_PHY_MODE_MASK |
-					      NAN_OP_MODE_80P80MHZ |
-					      NAN_OP_MODE_160MHZ;
-
-		/* Support 2 antenna's for Tx and Rx */
-		hw->wiphy->nan_capa.n_antennas = 0x22;
-
-		/* Maximal channel switch time is 4 msec */
-		hw->wiphy->nan_capa.max_channel_switch_time = 4;
-		hw->wiphy->nan_capa.dev_capabilities =
-			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
-			NAN_DEV_CAPA_NDPE_SUPPORTED;
-
-		hw->wiphy->nan_capa.phy.ht = mld->nvm_data->nan_phy_capa.ht;
-		hw->wiphy->nan_capa.phy.vht = mld->nvm_data->nan_phy_capa.vht;
-		hw->wiphy->nan_capa.phy.he = mld->nvm_data->nan_phy_capa.he;
+		iwl_mld_hw_set_nan(mld);
 	} else {
-		wiphy->iface_combinations = iwl_mld_iface_combinations;
 		/* Do not include NAN combinations */
 		wiphy->n_iface_combinations =
 			ARRAY_SIZE(iwl_mld_iface_combinations) - 2;
-- 
2.34.1



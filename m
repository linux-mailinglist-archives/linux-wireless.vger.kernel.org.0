Return-Path: <linux-wireless+bounces-36249-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KSONgQZAmognwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36249-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:59:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C259513F74
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614BC31E377C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D504C466B7D;
	Mon, 11 May 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3bMuIHN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDDB441022
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521020; cv=none; b=Tj9lFyMArvS/HSlhWKzAGBd1dOTjLdyB5lCKRdBLccJCa6zGlgqmUgyf6Ut4EVpRLbvniXdi36koxdzAOBmjhYIeDQHk6OFfJnubiXHGmlU65PK8fK1tbmf4KoDqaApgqHfeye34bTsb/34QrobckT8yVvh8cGyxWcuKK/vnGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521020; c=relaxed/simple;
	bh=k+iAtSl/J9nhC/1A4kQMls01/u4GHJ9ZlgCBMrwDy/g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l57Wpcut8hfcnDSYGAWnQHYx5rPe0IWRTCtXaQn4lgtxgFJsYxxqpxv0YFbrjGSuLbwhSpUwsj4cSpZz64CXVhObHUPeDCvAWvH2aPL8KdHFXXyUNvxA6KODaVCKjyUG+gPyZpEfN1YE4A4rDfk8w/E19c7DSmqtUiwCCaUoWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3bMuIHN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521019; x=1810057019;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=k+iAtSl/J9nhC/1A4kQMls01/u4GHJ9ZlgCBMrwDy/g=;
  b=W3bMuIHNKhYg6i0qjZkgsF5NORG1UnZtQdKDah3nsSZCjK9cuoEmmSwh
   hseWV/1JN190FrKybUp9mnFkgezu9hlmSgaEM44vjum40qboRTWWBw+Dp
   heqq0JTdic4pczT1dBbZToNPU3lz9p+HDuszt3656HFZ/pa+Nb08PyaoC
   VvY5DnCfHtpf32eY4vXyg60fAvqg6n7uaOTLi3dbur39qRx6ttRSpg4qZ
   P2BLuYRTeoKcOOr5ygYSy5xm80WVEt2glG460x5GE22ig0R7sn1aBT9v5
   Rz6k8jd8fiwetgq0hSKeXtDMOlRwzDqZm8dUsc18s7vJv9WQEZ7f6kTKV
   Q==;
X-CSE-ConnectionGUID: 9EhByjkfRdmqbMCqQmzE4A==
X-CSE-MsgGUID: djy886w4SdevYQj6WLDqpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314816"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314816"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:58 -0700
X-CSE-ConnectionGUID: CkJZhutCRce+Xy5b4mZTBw==
X-CSE-MsgGUID: PUXTElsEQXilEtBmtB3t6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004750"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: allow NAN data
Date: Mon, 11 May 2026 20:36:25 +0300
Message-Id: <20260511203428.c47453e9329a.I4a250a0df0ca0d184eb6ac84a4a9fcc3491e9e66@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
References: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C259513F74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36249-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

Allow NAN_DATA interfaces when FW supports it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 13 +++++++++----
 drivers/net/wireless/intel/iwlwifi/mld/nan.c      | 12 ++++++++++--
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 4b5f50ff2b05..8856f96a9760 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -62,13 +62,17 @@ static const struct ieee80211_iface_limit iwl_mld_limits_ap[] = {
 
 static const struct ieee80211_iface_limit iwl_mld_limits_nan[] = {
 	{
-		.max = 2,
+		.max = 1,
 		.types = BIT(NL80211_IFTYPE_STATION),
 	},
 	{
 		.max = 1,
 		.types = BIT(NL80211_IFTYPE_NAN),
 	},
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_NAN_DATA),
+	},
 };
 
 static const struct ieee80211_iface_combination
@@ -87,8 +91,8 @@ iwl_mld_iface_combinations[] = {
 	},
 	/* NAN combination follow, this excludes P2P and AP */
 	{
-		.num_different_channels = 2,
-		.max_interfaces = 3,
+		.num_different_channels = 3,
+		.max_interfaces = 4,
 		.limits = iwl_mld_limits_nan,
 		.n_limits = ARRAY_SIZE(iwl_mld_limits_nan),
 	},
@@ -266,6 +270,7 @@ static void iwl_mld_hw_set_nan(struct iwl_mld *mld)
 	struct ieee80211_hw *hw = mld->hw;
 
 	hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_NAN);
+	hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_NAN_DATA);
 
 	hw->wiphy->nan_supported_bands = BIT(NL80211_BAND_2GHZ);
 	if (mld->nvm_data->bands[NL80211_BAND_5GHZ].n_channels)
@@ -363,7 +368,7 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 			ARRAY_SIZE(iwl_mld_iface_combinations);
 		iwl_mld_hw_set_nan(mld);
 	} else {
-		/* Do not include NAN combinations */
+		/* Do not include NAN combination */
 		wiphy->n_iface_combinations =
 			ARRAY_SIZE(iwl_mld_iface_combinations) - 1;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 59e85818b613..cb7a3e01adb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -18,8 +18,16 @@
 
 bool iwl_mld_nan_supported(struct iwl_mld *mld)
 {
-	return fw_has_capa(&mld->fw->ucode_capa,
-			   IWL_UCODE_TLV_CAPA_NAN_SYNC_SUPPORT);
+	const struct iwl_fw *fw = mld->fw;
+
+	if (fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_NAN_SYNC_SUPPORT) &&
+	    iwl_fw_lookup_cmd_ver(fw, WIDE_ID(MAC_CONF_GROUP, NAN_SCHEDULE_CMD), 0) >= 1 &&
+	    iwl_fw_lookup_cmd_ver(fw, WIDE_ID(MAC_CONF_GROUP, NAN_PEER_CMD), 0) >= 1 &&
+	    iwl_fw_lookup_cmd_ver(fw, WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD), 0) >= 3 &&
+	    iwl_fw_lookup_cmd_ver(fw, WIDE_ID(MAC_CONF_GROUP, MAC_CONFIG_CMD), 0) >= 4 &&
+	    iwl_fw_lookup_cmd_ver(fw, WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD), 0) >= 6)
+		return true;
+	return false;
 }
 
 static int iwl_mld_nan_send_config_cmd(struct iwl_mld *mld,
-- 
2.34.1



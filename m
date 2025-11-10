Return-Path: <linux-wireless+bounces-28807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D7C47F21
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83D84A7B25
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE9127E1C5;
	Mon, 10 Nov 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g78dHJtn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408D273810
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790948; cv=none; b=ar+CF4T73MtSD7rUTBAnXooEm8MPh1VgAA1XXWZ2V1+M3L0pPQ1bdqoguYufAVtHAP8b7yzoOcVUsg3ZY493ksAgEOoJYiTjPhbGsfDHDG28soTyvLfG2k+/b/Ol433Ncysaj2/3JcarIawnAc4skwQx9Q+0L5noBRjjS/POk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790948; c=relaxed/simple;
	bh=oKafpu8UxAne3tgEDefHJbL1Lw06OAmQ4NsD3ftHlEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3vkina53rIGdtcB2ydbtvzLzSNzTtK1ofN9eOwNV6zvhZXWEg91s3gOO6Sz74zpjHrS91aELEqQj+nBTPvdg/F6Z/dp2gbgtwTlzTX1jzk21FwjRx+PdR7Ua5N9h8GO+mKQ+X8tguD3nfwAkvryXg4CMhtSv+eqfeuSaYjfkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g78dHJtn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762790946; x=1794326946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKafpu8UxAne3tgEDefHJbL1Lw06OAmQ4NsD3ftHlEs=;
  b=g78dHJtnnZ25G8sPXYbsGNv/mMW6sonCtm2jSPuZN+znuS5vYJ91HZXf
   T3jHvsO7iv/dHi9fC1S2eeW8ET7MtXpdRyv5TUKdS2dOo2JfTNteLwaUp
   MTMXnqzgwRTdTHw+HmH+Z/HGSauM59JiMh/UUnbp2oRhj5y1RxFdChPN/
   o8AZ+pXPvbWNp/syE25jzCM3lpXmxNm+FBA6xQ295d5R9z6uJJz1PGcjp
   StjWqJ4eSpT9wtVT6ISBb1aZGj9KJCsSApVI4KSiOSuuCmTIHSDHdfk/W
   +utKy+0qxhnvS9Cp/GtRAEloNb5H8NbpOvoaJbKaUxNdV63QqVCZ+swFq
   A==;
X-CSE-ConnectionGUID: irdqbigfSR6USGxPznQ/gg==
X-CSE-MsgGUID: rNW+/fA/TwiOPLc/wxuGjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64725174"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64725174"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:09:06 -0800
X-CSE-ConnectionGUID: Qxib8FyWRIypmc1DG37zXw==
X-CSE-MsgGUID: GngTZIQoT0SnPOsx2Q+P6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188877190"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:09:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next v2 5/6] wifi: iwlwifi: mld: Support changing NAN configuration
Date: Mon, 10 Nov 2025 18:08:49 +0200
Message-Id: <20251110180612.82dcdfeb9533.Ib8576873c92f68f1bcafbda409d45ef2b4133e9f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110160850.366979-1-miriam.rachel.korenblit@intel.com>
References: <20251110160850.366979-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for changing the NAN configuration.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 52 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  4 ++
 3 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 9a58f2751d4e..05ab6246eb17 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2770,4 +2770,5 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.can_neg_ttlm = iwl_mld_can_neg_ttlm,
 	.start_nan = iwl_mld_start_nan,
 	.stop_nan = iwl_mld_stop_nan,
+	.nan_change_conf = iwl_mld_nan_change_config,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 6cdee2aa0f50..e7a2c1ec7494 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -37,22 +37,19 @@ static int iwl_mld_nan_send_config_cmd(struct iwl_mld *mld,
 	return iwl_mld_send_cmd(mld, &hcmd);
 }
 
-int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		      struct cfg80211_nan_conf *conf)
+static int iwl_mld_nan_config(struct iwl_mld *mld,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_nan_conf *conf,
+			      enum iwl_ctxt_action action)
 {
-	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	struct iwl_mld_int_sta *aux_sta = &mld_vif->aux_sta;
 	struct iwl_nan_config_cmd cmd = {
-		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.action = cpu_to_le32(action),
 	};
 	u8 *data __free(kfree) = NULL;
-	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	IWL_DEBUG_MAC80211(mld, "Start NAN: bands=0x%x\n", conf->bands);
-
 	ether_addr_copy(cmd.nmi_addr, vif->addr);
 	cmd.master_pref = conf->master_pref;
 
@@ -117,15 +114,27 @@ int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			       conf->vendor_elems_len);
 	}
 
+	cmd.sta_id = mld_vif->aux_sta.sta_id;
+	return iwl_mld_nan_send_config_cmd(mld, &cmd, data,
+					   conf->extra_nan_attrs_len +
+					   conf->vendor_elems_len);
+}
+
+int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      struct cfg80211_nan_conf *conf)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_int_sta *aux_sta = &mld_vif->aux_sta;
+	int ret;
+
+	IWL_DEBUG_MAC80211(mld, "NAN: start: bands=0x%x\n", conf->bands);
+
 	ret = iwl_mld_add_aux_sta(mld, aux_sta);
 	if (ret)
 		return ret;
 
-	cmd.sta_id = aux_sta->sta_id;
-
-	ret = iwl_mld_nan_send_config_cmd(mld, &cmd, data,
-					  conf->extra_nan_attrs_len +
-					  conf->vendor_elems_len);
+	ret = iwl_mld_nan_config(mld, vif, conf, FW_CTXT_ACTION_ADD);
 	if (ret) {
 		IWL_ERR(mld, "Failed to start NAN. ret=%d\n", ret);
 		iwl_mld_remove_aux_sta(mld, vif);
@@ -134,6 +143,23 @@ int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return ret;
 }
 
+int iwl_mld_nan_change_config(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_nan_conf *conf,
+			      u32 changes)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+
+	IWL_DEBUG_MAC80211(mld, "NAN: change: changes=0x%x, bands=0x%x\n",
+			   changes, conf->bands);
+
+	/* Note that we do not use 'changes' as the FW always expects the
+	 * complete configuration, and mac80211 always provides the complete
+	 * configuration.
+	 */
+	return iwl_mld_nan_config(mld, vif, conf, FW_CTXT_ACTION_MODIFY);
+}
+
 int iwl_mld_stop_nan(struct ieee80211_hw *hw,
 		     struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index 97607b74a177..c9c83d1012f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -10,6 +10,10 @@ bool iwl_mld_nan_supported(struct iwl_mld *mld);
 int iwl_mld_start_nan(struct ieee80211_hw *hw,
 		      struct ieee80211_vif *vif,
 		      struct cfg80211_nan_conf *conf);
+int iwl_mld_nan_change_config(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_nan_conf *conf,
+			      u32 changes);
 int iwl_mld_stop_nan(struct ieee80211_hw *hw,
 		     struct ieee80211_vif *vif);
 void iwl_mld_handle_nan_cluster_notif(struct iwl_mld *mld,
-- 
2.34.1



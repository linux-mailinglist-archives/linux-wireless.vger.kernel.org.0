Return-Path: <linux-wireless+bounces-2869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492EB8438E4
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DFC28B988
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BF05DF0D;
	Wed, 31 Jan 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlyhcW7/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A385D8E8
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689505; cv=none; b=ALYgC/LAqJknFodxu8Sf08Uv6QC7p+mfAyeWHj0DgblEd+k1BPEWmblxVwPeXyvmOUfDRf+4tNyZGqFjfjW+9B+ojQ6nSZw382rYzDsrDBxN/7ych3UgvvXiagmFVEb1AWu/0BRaFJX4H0Wy8cJxcrw4Ix72C0TDTXje4AGvV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689505; c=relaxed/simple;
	bh=zZ999G5NC00+3SMAw7ucTtDVkLiSpmVdb6xNUcFlFiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eh6tZkyMWh59a2ef9egNTlWboe+p/7IhKxkpJhyaCW2uIzIRq4mvZrkKdI/TypF/wTU//a3zrTS6Me9ERACaYyoarS/nygSpNbcGlq/j2RFpVxiwYzZ+jVLzLCAM1KBkXV9E4sK4D3WCQ098DE/1RnSujrIPKqxl8ADPUf/37hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlyhcW7/; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689503; x=1738225503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZ999G5NC00+3SMAw7ucTtDVkLiSpmVdb6xNUcFlFiw=;
  b=IlyhcW7/z/Uowveb1mjrEaeMdIJfL0vLzi+y0br6Y5nmyc2DLypypDB1
   MSRFusw5qP1WEs2eldUcbZ/rR5B7qVRE3pme9MwA6yz1IU4s3c7xcynjb
   U+zXnlV1OpjAmcaRgHH0gy1fU01WEsKWyprEWqsX2at+SuV4wyEZz1Il9
   EY+p2PipoC8ar99Jk9TFyUwJc4ZmNeqynWTAuNUX5BnBa6RKb7nIKL5JP
   OwwXX3fy5TdgAtomDAmuDnLIzUJhYtk2etwOZdJSshoElCl8MZRpXPwhq
   mZw+WwyxjiyQ81adU3djIO6vxo/c5oHPHt979W9dU+ti75xUUTbZE1C/6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249889"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249889"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968813"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/14] wifi: iwlwifi: mvm: d3: implement suspend with MLO
Date: Wed, 31 Jan 2024 10:24:35 +0200
Message-Id: <20240131091413.38f0fd4d2db0.I27c7a1d08aecc5da0af2c351212f22e92ed70219@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
References: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When using MLO, we need to have only a single link active
when entering suspend and of course most of the code also
needs to be adjusted to not use deflink, apart from older
code that's not used with MLO-capable firmware. Implement
that.

Note that the link selection currently prefers the "best"
link, which might really not be the best for D3, but that
can be fixed later once we agree.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 79 ++++++++++++++-------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6ab9def2c670..6396fbde03c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -450,9 +450,9 @@ static void iwl_mvm_wowlan_get_rsc_v5_data(struct ieee80211_hw *hw,
 }
 
 static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
-					 struct ieee80211_vif *vif)
+					 struct ieee80211_vif *vif,
+					 struct iwl_mvm_vif_link_info *mvm_link)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_TSC_RSC_PARAM,
 					IWL_FW_CMD_VER_UNKNOWN);
 	int ret;
@@ -470,7 +470,7 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 		for (i = 0; i < ARRAY_SIZE(data.rsc->mcast_key_id_map); i++)
 			data.rsc->mcast_key_id_map[i] =
 				IWL_MCAST_KEY_MAP_INVALID;
-		data.rsc->sta_id = cpu_to_le32(mvmvif->deflink.ap_sta_id);
+		data.rsc->sta_id = cpu_to_le32(mvm_link->ap_sta_id);
 
 		ieee80211_iter_keys(mvm->hw, vif,
 				    iwl_mvm_wowlan_get_rsc_v5_data,
@@ -494,7 +494,7 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 		if (ver == 4) {
 			size = sizeof(*data.rsc_tsc);
 			data.rsc_tsc->sta_id =
-				cpu_to_le32(mvmvif->deflink.ap_sta_id);
+				cpu_to_le32(mvm_link->ap_sta_id);
 		} else {
 			/* ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN */
 			size = sizeof(data.rsc_tsc->params);
@@ -668,10 +668,9 @@ static int iwl_mvm_send_patterns_v1(struct iwl_mvm *mvm,
 }
 
 static int iwl_mvm_send_patterns(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
+				 struct iwl_mvm_vif_link_info *mvm_link,
 				 struct cfg80211_wowlan *wowlan)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_wowlan_patterns_cmd *pattern_cmd;
 	struct iwl_host_cmd cmd = {
 		.id = WOWLAN_PATTERNS,
@@ -693,7 +692,7 @@ static int iwl_mvm_send_patterns(struct iwl_mvm *mvm,
 
 	pattern_cmd->n_patterns = wowlan->n_patterns;
 	if (ver >= 3)
-		pattern_cmd->sta_id = mvmvif->deflink.ap_sta_id;
+		pattern_cmd->sta_id = mvm_link->ap_sta_id;
 
 	for (i = 0; i < wowlan->n_patterns; i++) {
 		int mask_len = DIV_ROUND_UP(wowlan->patterns[i].pattern_len, 8);
@@ -730,7 +729,8 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_time_quota_data *quota;
 	u32 status;
 
-	if (WARN_ON_ONCE(iwl_mvm_is_cdb_supported(mvm)))
+	if (WARN_ON_ONCE(iwl_mvm_is_cdb_supported(mvm) ||
+			 ieee80211_vif_is_mld(vif)))
 		return -EINVAL;
 
 	/* add back the PHY */
@@ -987,7 +987,8 @@ iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 }
 
 static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
-					    struct ieee80211_vif *vif)
+					    struct ieee80211_vif *vif,
+					    struct iwl_mvm_vif_link_info *mvm_link)
 {
 	bool unified = fw_has_capa(&mvm->fw->ucode_capa,
 				   IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
@@ -1016,7 +1017,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 			return -EIO;
 	}
 
-	ret = iwl_mvm_wowlan_config_rsc_tsc(mvm, vif);
+	ret = iwl_mvm_wowlan_config_rsc_tsc(mvm, vif, mvm_link);
 	if (ret)
 		return ret;
 
@@ -1030,7 +1031,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		if (ver == 2) {
 			size = sizeof(tkip_data.tkip);
 			tkip_data.tkip.sta_id =
-				cpu_to_le32(mvmvif->deflink.ap_sta_id);
+				cpu_to_le32(mvm_link->ap_sta_id);
 		} else if (ver == 1 || ver == IWL_FW_CMD_VER_UNKNOWN) {
 			size = sizeof(struct iwl_wowlan_tkip_params_cmd_ver_1);
 		} else {
@@ -1079,7 +1080,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		kek_kck_cmd.kek_len = cpu_to_le16(mvmvif->rekey_data.kek_len);
 		kek_kck_cmd.replay_ctr = mvmvif->rekey_data.replay_ctr;
 		kek_kck_cmd.akm = cpu_to_le32(mvmvif->rekey_data.akm);
-		kek_kck_cmd.sta_id = cpu_to_le32(mvmvif->deflink.ap_sta_id);
+		kek_kck_cmd.sta_id = cpu_to_le32(mvm_link->ap_sta_id);
 
 		if (cmd_ver == 4) {
 			cmd_size = sizeof(struct iwl_wowlan_kek_kck_material_cmd_v4);
@@ -1112,6 +1113,7 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 		      struct cfg80211_wowlan *wowlan,
 		      struct iwl_wowlan_config_cmd *wowlan_config_cmd,
 		      struct ieee80211_vif *vif, struct iwl_mvm_vif *mvmvif,
+		      struct iwl_mvm_vif_link_info *mvm_link,
 		      struct ieee80211_sta *ap_sta)
 {
 	int ret;
@@ -1130,7 +1132,7 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 			return ret;
 	}
 
-	ret = iwl_mvm_wowlan_config_key_params(mvm, vif);
+	ret = iwl_mvm_wowlan_config_key_params(mvm, vif, mvm_link);
 	if (ret)
 		return ret;
 
@@ -1142,7 +1144,7 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_WOWLAN_TCP_SYN_WAKE))
-		ret = iwl_mvm_send_patterns(mvm, vif, wowlan);
+		ret = iwl_mvm_send_patterns(mvm, mvm_link, wowlan);
 	else
 		ret = iwl_mvm_send_patterns_v1(mvm, wowlan);
 	if (ret)
@@ -1223,6 +1225,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	struct ieee80211_vif *vif = NULL;
 	struct iwl_mvm_vif *mvmvif = NULL;
 	struct ieee80211_sta *ap_sta = NULL;
+	struct iwl_mvm_vif_link_info *mvm_link;
 	struct iwl_d3_manager_config d3_cfg_cmd_data = {
 		/*
 		 * Program the minimum sleep time to 10 seconds, as many
@@ -1237,7 +1240,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 		.data[0] = &d3_cfg_cmd_data,
 		.len[0] = sizeof(d3_cfg_cmd_data),
 	};
-	int ret;
+	int ret, primary_link;
 	int len __maybe_unused;
 	bool unified_image = fw_has_capa(&mvm->fw->ucode_capa,
 					 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
@@ -1251,21 +1254,44 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 		return -EINVAL;
 	}
 
+	vif = iwl_mvm_get_bss_vif(mvm);
+	if (IS_ERR_OR_NULL(vif))
+		return 1;
+
+	if (ieee80211_vif_is_mld(vif) && vif->cfg.assoc) {
+		/*
+		 * Select the 'best' link. May need to revisit, it seems
+		 * better to not optimize for throughput but rather range,
+		 * reliability and power here - and select 2.4 GHz ...
+		 */
+		primary_link =
+			iwl_mvm_mld_get_primary_link(mvm, vif,
+						     vif->active_links);
+
+		if (WARN_ONCE(primary_link < 0, "no primary link in 0x%x\n",
+			      vif->active_links))
+			primary_link = __ffs(vif->active_links);
+
+		ret = ieee80211_set_active_links(vif, BIT(primary_link));
+		if (ret)
+			return ret;
+	} else {
+		primary_link = 0;
+	}
+
 	mutex_lock(&mvm->mutex);
 
 	set_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 
 	synchronize_net();
 
-	vif = iwl_mvm_get_bss_vif(mvm);
-	if (IS_ERR_OR_NULL(vif)) {
-		ret = 1;
-		goto out_noreset;
-	}
-
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA) {
+	mvm_link = mvmvif->link[primary_link];
+	if (WARN_ON_ONCE(!mvm_link))
+		return -EINVAL;
+
+	if (mvm_link->ap_sta_id == IWL_MVM_INVALID_STA) {
 		/* if we're not associated, this must be netdetect */
 		if (!wowlan->nd_config) {
 			ret = 1;
@@ -1281,10 +1307,10 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	} else {
 		struct iwl_wowlan_config_cmd wowlan_config_cmd = {};
 
-		wowlan_config_cmd.sta_id = mvmvif->deflink.ap_sta_id;
+		wowlan_config_cmd.sta_id = mvm_link->ap_sta_id;
 
 		ap_sta = rcu_dereference_protected(
-			mvm->fw_id_to_mac_id[mvmvif->deflink.ap_sta_id],
+			mvm->fw_id_to_mac_id[mvm_link->ap_sta_id],
 			lockdep_is_held(&mvm->mutex));
 		if (IS_ERR_OR_NULL(ap_sta)) {
 			ret = -EINVAL;
@@ -1296,7 +1322,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 		if (ret)
 			goto out_noreset;
 		ret = iwl_mvm_wowlan_config(mvm, wowlan, &wowlan_config_cmd,
-					    vif, mvmvif, ap_sta);
+					    vif, mvmvif, mvm_link, ap_sta);
 		if (ret)
 			goto out;
 
@@ -2846,6 +2872,9 @@ iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 		u8 sta_id = mvm->net_detect ? IWL_MVM_INVALID_STA :
 					      mvmvif->deflink.ap_sta_id;
 
+		/* bug - FW with MLO has status notification */
+		WARN_ON(ieee80211_vif_is_mld(vif));
+
 		d3_data->status = iwl_mvm_send_wowlan_get_status(mvm, sta_id);
 	}
 
-- 
2.34.1



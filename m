Return-Path: <linux-wireless+bounces-27323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB0EB57311
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025FF189D8DD
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D052F0693;
	Mon, 15 Sep 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiQO6YpL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47662EF677
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925319; cv=none; b=lYtp6TUnzVyuXfJp91HpwJkqmGkSkz/M/jUAy/+WfNV/ohV5P3zJ6cwIVKAYl60aSVB4f5ACoL31v4Pl64D7A9z1iizjiDpq6SwMZrPYyDJxHWyrIc/uAOsrU+FuXP4Q+25LJ/dJmfw49HwtcliN+JGbrpzLAFfW/mvrVzppJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925319; c=relaxed/simple;
	bh=+6JYyvmv+V3UrMiNlzYxGrwWL15vGp7lLc75Dkiuok0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sc1WEtLCEu3OwAjshYlHGdZEUZ5v2lmWuPOKIjUuYzPlCIwE/Ftry/F0xUxz5szIY2TKx8e0xYSQq2yzJ0KnQ6Br1OSD4b6xNtyV7GBuDNeSlVR7u4DVYB8jxvb6A/bezzOHhknLYPtHQRtT0xilKOJpGr+RHAMbSZlGBFJ8G5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiQO6YpL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925318; x=1789461318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+6JYyvmv+V3UrMiNlzYxGrwWL15vGp7lLc75Dkiuok0=;
  b=UiQO6YpLqD7vO4eclG1DEwkQMTZXJxfrQQKqbsMonBgZwf35Y1JuB6OY
   hY3w7pBrHIWYUXyR3PMNKdqRSNzyBFArRFiHWlL7n/6QRjjSM+k2altyV
   lQkQR6boMz3HEiBs82vN0ONn79zx+nRB4i99XXIrzxl4l1iaslajuGLLV
   oxb0PkbmOE7QmoFv2qYOjv29GtCeu3uPWPhUMz+eS0n6zMdFLdGxbZb5R
   DBdz67QGkfCDtl3KU2rTG3tUBMbotnc0vSvnCCEB4dfsfCSNXGeppCqQX
   djiNWD+gSddY3hUs8YSER6J0f9l5CzhyNivUqxss1QpQ1gE+yU7ck/c8b
   Q==;
X-CSE-ConnectionGUID: 5lpml5EMTH6H8d3vFoKI3w==
X-CSE-MsgGUID: lTpmgxhURxqBT+f6bxcH+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213088"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213088"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:15 -0700
X-CSE-ConnectionGUID: wNLUPFkxT12FBhGHG7X3XQ==
X-CSE-MsgGUID: VaDZtMIASVqYBdkgGSRktw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569914"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/11] wifi: iwlwifi: mld: set wiphy::iftype_ext_capab dynamically
Date: Mon, 15 Sep 2025 11:34:32 +0300
Message-Id: <20250915113137.b3c03b56d5a3.I38eaf8ebaf3256e78b4643bef7e3a54aeb4989df@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Instead of having a static const array for each possible combination of
features, build the extended capabilities dynamically.

With this we will also stop setting EHT capabilities when it might
actually be disabled.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mld/constants.h    |  2 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 63 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  4 ++
 3 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/constants.h b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
index 49accf96f44b..5d23a618ae3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
@@ -75,5 +75,7 @@
 #define IWL_MLD_FTM_RESP_LMR_FEEDBACK_SUPPORT	true
 #define IWL_MLD_FTM_NON_TB_MIN_TIME_BETWEEN_MSR	7
 #define IWL_MLD_FTM_NON_TB_MAX_TIME_BETWEEN_MSR	1000
+#define IWL_MLD_STA_EXT_CAPA_SIZE		9
+#define IWL_MLD_EXT_CAPA_NUM_IFTYPES		1
 
 #endif /* __iwl_mld_constants_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 98d47fed8421..5323c73ac827 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -76,13 +76,12 @@ iwl_mld_iface_combinations[] = {
 	},
 };
 
-static const u8 if_types_ext_capa_sta[] = {
-	 [0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
-	 [2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
-	 [7] = WLAN_EXT_CAPA8_OPMODE_NOTIF |
-	       WLAN_EXT_CAPA8_MAX_MSDU_IN_AMSDU_LSB,
-	 [8] = WLAN_EXT_CAPA9_MAX_MSDU_IN_AMSDU_MSB,
-	 [9] = WLAN_EXT_CAPA10_TWT_REQUESTER_SUPPORT,
+static const u8 ext_capa_base[IWL_MLD_STA_EXT_CAPA_SIZE] = {
+	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
+	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF |
+	      WLAN_EXT_CAPA8_MAX_MSDU_IN_AMSDU_LSB,
+	[8] = WLAN_EXT_CAPA9_MAX_MSDU_IN_AMSDU_MSB,
 };
 
 #define IWL_MLD_EMLSR_CAPA	(IEEE80211_EML_CAP_EMLSR_SUPP | \
@@ -95,18 +94,6 @@ static const u8 if_types_ext_capa_sta[] = {
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) | \
 			IEEE80211_MLD_CAP_OP_LINK_RECONF_SUPPORT)
 
-static const struct wiphy_iftype_ext_capab iftypes_ext_capa[] = {
-	{
-		.iftype = NL80211_IFTYPE_STATION,
-		.extended_capabilities = if_types_ext_capa_sta,
-		.extended_capabilities_mask = if_types_ext_capa_sta,
-		.extended_capabilities_len = sizeof(if_types_ext_capa_sta),
-		/* relevant only if EHT is supported */
-		.eml_capabilities = IWL_MLD_EMLSR_CAPA,
-		.mld_capa_and_ops = IWL_MLD_CAPA_OPS,
-	},
-};
-
 static void iwl_mld_hw_set_addresses(struct iwl_mld *mld)
 {
 	struct wiphy *wiphy = mld->wiphy;
@@ -336,21 +323,37 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 	if (fw_has_capa(ucode_capa, IWL_UCODE_TLV_CAPA_PROTECTED_TWT))
 		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_PROTECTED_TWT);
 
-	wiphy->iftype_ext_capab = NULL;
-	wiphy->num_iftype_ext_capab = 0;
-
-	if (!iwlwifi_mod_params.disable_11ax) {
-		wiphy->iftype_ext_capab = iftypes_ext_capa;
-		wiphy->num_iftype_ext_capab = ARRAY_SIZE(iftypes_ext_capa);
-
-		ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
-		ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
-	}
-
 	if (iwlmld_mod_params.power_scheme != IWL_POWER_SCHEME_CAM)
 		wiphy->flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
 	else
 		wiphy->flags &= ~WIPHY_FLAG_PS_ON_BY_DEFAULT;
+
+	/* We are done for non-HE */
+	if (iwlwifi_mod_params.disable_11ax)
+		return;
+
+	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
+	ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
+
+	wiphy->iftype_ext_capab = mld->ext_capab;
+	wiphy->num_iftype_ext_capab = ARRAY_SIZE(mld->ext_capab);
+
+	BUILD_BUG_ON(sizeof(mld->sta_ext_capab) < sizeof(ext_capa_base));
+
+	memcpy(mld->sta_ext_capab, ext_capa_base, sizeof(ext_capa_base));
+
+	mld->ext_capab[0].iftype = NL80211_IFTYPE_STATION;
+	mld->ext_capab[0].extended_capabilities = mld->sta_ext_capab;
+	mld->ext_capab[0].extended_capabilities_mask = mld->sta_ext_capab;
+	mld->ext_capab[0].extended_capabilities_len = sizeof(mld->sta_ext_capab);
+
+	if (!mld->nvm_data->sku_cap_11be_enable ||
+	    iwlwifi_mod_params.disable_11be)
+		return;
+
+	mld->ext_capab[0].eml_capabilities = IWL_MLD_EMLSR_CAPA;
+	mld->ext_capab[0].mld_capa_and_ops = IWL_MLD_CAPA_OPS;
+
 }
 
 static void iwl_mac_hw_set_misc(struct iwl_mld *mld)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index b1d44fdaa61b..ceda12c1672d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -134,6 +134,8 @@
  * @fw: a pointer to the fw object
  * @hw: pointer to the hw object.
  * @wiphy: a pointer to the wiphy struct, for easier access to it.
+ * @ext_capab: extended capabilities that will be set to wiphy on registration.
+ * @sta_ext_capab: extended capabilities for the station interface.
  * @nvm_data: pointer to the nvm_data that includes all our capabilities
  * @fwrt: fw runtime data
  * @debugfs_dir: debugfs directory
@@ -227,6 +229,8 @@ struct iwl_mld {
 	const struct iwl_fw *fw;
 	struct ieee80211_hw *hw;
 	struct wiphy *wiphy;
+	struct wiphy_iftype_ext_capab ext_capab[IWL_MLD_EXT_CAPA_NUM_IFTYPES];
+	u8 sta_ext_capab[IWL_MLD_STA_EXT_CAPA_SIZE];
 	struct iwl_nvm_data *nvm_data;
 	struct iwl_fw_runtime fwrt;
 	struct dentry *debugfs_dir;
-- 
2.34.1



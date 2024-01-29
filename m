Return-Path: <linux-wireless+bounces-2723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB8784133F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FC81F21F37
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C4E60ECF;
	Mon, 29 Jan 2024 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkFDRmpb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2A11C85
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556142; cv=none; b=tL015eTDsZ4Rlx2WVespPuO56o3nJo9HIyCECdhxwUK2Iwo3ARxybRkCCBodDmggLhTZ5Q/P58aMxzAHW5pLKlyOphKmv9+RXSRyO2hV6TY24H7XKA92tMS/vGmNxM/vu+RN/eXjlVGxQgiGMs76Kh4If6I+OO8BbNSUb2VOwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556142; c=relaxed/simple;
	bh=tA3WjDpQfQkCnpitqsZ8A3Z5rbYOMmTMx3Y2jJlnqwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MuDAax5XRy6iSzXh6R5XuPuW8n5zejbxdYxHDeKsoZdKk4kC5HQItkX+ILrPcQCXXC8fodkbc6WzP6oBIcF2kWG/0pi2uGON9s5KJ0ouKF8/TrY9fXVHLsoe+Cm5vJgS6IA6e4LozJJ/Ji4xCzNCdrY8u/YDlVtDuO+wMmEaPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkFDRmpb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556141; x=1738092141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tA3WjDpQfQkCnpitqsZ8A3Z5rbYOMmTMx3Y2jJlnqwY=;
  b=DkFDRmpbfigfNAC/eHOXj6gJFjXU424BHu9DvQOeHEYHlaCtWRW+vJPk
   PQ50VrNyrx5zThSL/CJbfxM1Kihr4lvMs1Udd6vljzdDQdVurYgmkeSNv
   odULmOB3U+3TTjq2Sx5TDH7CP7OhF6wWW+UxbuPO1WaTBZ8VTbh0zjA8I
   N4z5N2/QZDZ50ljH3C1Re8cNMw8tpK5ASg/ZF556+Pvu6XFeW8++uMc9d
   XBge6poqwvUOYgDeWCYXoNqYY4MBtl4p7jFzUh8y0BA5NtOkrncVB4Gzj
   mTv9i4Jbz79PkSYlWwtDAbeecgry+eywq+yoR6xHy8OZphGoJCr76AAZq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2942953"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2942953"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459058"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: add support for TID to link mapping neg request
Date: Mon, 29 Jan 2024 21:21:50 +0200
Message-Id: <20240129211905.aab9819c378d.Icf6b79a362763e2e8b85959471f303b586617242@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

Add support for handling TID to link mapping negotiation
request and decide whether to accept it or not.
Accept the request if all TIDs are mapped to the same link set,
otherwise reject it.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  5 +++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c82af4ac27ec..d19e478f382b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -263,6 +263,9 @@ static const u8 tm_if_types_ext_capa_sta[] = {
 					__bf_shf(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY) | \
 				 IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_64US << \
 					__bf_shf(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY))
+#define IWL_MVM_MLD_CAPA_OPS FIELD_PREP_CONST( \
+			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
+			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME)
 
 static const struct wiphy_iftype_ext_capab add_iftypes_ext_capa[] = {
 	{
@@ -272,6 +275,7 @@ static const struct wiphy_iftype_ext_capab add_iftypes_ext_capa[] = {
 		.extended_capabilities_len = sizeof(he_if_types_ext_capa_sta),
 		/* relevant only if EHT is supported */
 		.eml_capabilities = IWL_MVM_EMLSR_CAPA,
+		.mld_capa_and_ops = IWL_MVM_MLD_CAPA_OPS,
 	},
 	{
 		.iftype = NL80211_IFTYPE_STATION,
@@ -280,6 +284,7 @@ static const struct wiphy_iftype_ext_capab add_iftypes_ext_capa[] = {
 		.extended_capabilities_len = sizeof(tm_if_types_ext_capa_sta),
 		/* relevant only if EHT is supported */
 		.eml_capabilities = IWL_MVM_EMLSR_CAPA,
+		.mld_capa_and_ops = IWL_MVM_MLD_CAPA_OPS,
 	},
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 770e4c4e909a..9653d335d573 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1330,6 +1330,24 @@ static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static enum ieee80211_neg_ttlm_res
+iwl_mvm_mld_can_neg_ttlm(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 struct ieee80211_neg_ttlm *neg_ttlm)
+{
+	u16 map;
+	u8 i;
+
+	/* Verify all TIDs are mapped to the same links set */
+	map = neg_ttlm->downlink[0];
+	for (i = 0; i < IEEE80211_TTLM_NUM_TIDS; i++) {
+		if (neg_ttlm->downlink[i] != neg_ttlm->uplink[i] ||
+		    neg_ttlm->uplink[i] != map)
+			return NEG_TTLM_RES_REJECT;
+	}
+
+	return NEG_TTLM_RES_ACCEPT;
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
@@ -1425,4 +1443,5 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.change_vif_links = iwl_mvm_mld_change_vif_links,
 	.change_sta_links = iwl_mvm_mld_change_sta_links,
 	.can_activate_links = iwl_mvm_mld_can_activate_links,
+	.can_neg_ttlm = iwl_mvm_mld_can_neg_ttlm,
 };
-- 
2.34.1



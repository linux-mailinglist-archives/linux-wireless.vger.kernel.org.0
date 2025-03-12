Return-Path: <linux-wireless+bounces-20273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6EA5E745
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FE93B4250
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C15D1F03DE;
	Wed, 12 Mar 2025 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkB7DJUv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4721F03C5
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818185; cv=none; b=jxP+eScwMnvBqC1WpDHmYqA6bsBQmHrRETzEM++sWa8htGmJ1T9KiAgL5eTQjHqeYNfIkcBhjYZEOfHQ+mLs7w6A8jIp599Eu6Gj0Uq6Nl35UZhA54u2SIzKHkb/cFCERJN7t6+2sT18+3cEZkdZjwH4i/R6jt72mcS1cf6DgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818185; c=relaxed/simple;
	bh=Eo6oXvzLp6yT0GfnZ1iez1aCbAqXk/XG8yCxla3IIIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bD0uGpQrsE/BnV4JtcMeszwoeoSCJlC4YgR5QPUL9HT7vKaFfIBdW0dYrhVvEm/nA9SiS40M78jftheI0TwkzPLk9jFunqQ/mqR+Do21I1fn5efdjFfUeIR8o2+Y95dZF5t8SjBsl2JcNRth4zzRBAge572mNsOZGlfBP12kByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkB7DJUv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818184; x=1773354184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eo6oXvzLp6yT0GfnZ1iez1aCbAqXk/XG8yCxla3IIIo=;
  b=nkB7DJUv07a5h2Ed1vcHyRu4txhgsefBcPS+qH6pV+3x+o9qRotebAFi
   +QEKrx8wOnuWdBHL9Yh/nW6myJHF5RjOqFdkzV4PqwFXy4IpxxT9X7vqk
   vzOAYVm905qnIXUgewKs0v+S6jv36hiliLQFgHzY/DfaHxcWQek23bUbx
   dy0zi62W84HX5CBWBGGuKlj7lMh9s3Jo4DJONuLi9b4mVK3rKKaFdlVdV
   WI5ZkNozrNVz/VgyuTaCEsBwt1fPaqOBQA2VoAr5L/06zGLxVVFEtX1uN
   XJSWVKiawGyq7xJORskY22ck42bFOloDhqf4T8tCzshbWRTBX8y9Gzisp
   w==;
X-CSE-ConnectionGUID: 1YSPE/4CRayCJ1FlAT1/Mg==
X-CSE-MsgGUID: a7BhbyMVTuqls/xvA2plzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826752"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826752"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:04 -0700
X-CSE-ConnectionGUID: gZgUnkTBTCW7uGGR4rqrbg==
X-CSE-MsgGUID: ujWNOOHISiOf8KQ9i3lJVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267386"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 08/15] wifi: iwlwifi: mld: KUnit: introduce iwl_mld_kunit_link
Date: Thu, 13 Mar 2025 00:22:31 +0200
Message-Id: <20250313002008.f336491ccc4e.I6b727765eb394a3dbb78cea71e356be1bdc4a17c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

To allow setting up association/EMLSR states with more flexibility,
change the relevant functions to receive a new struct, iwl_mld_kunit_link,
which will contain all the link parameters (for now just link id, band
and bandwidth).

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../intel/iwlwifi/mld/tests/link-selection.c  | 13 +++---
 .../wireless/intel/iwlwifi/mld/tests/link.c   | 15 +++++--
 .../wireless/intel/iwlwifi/mld/tests/utils.c  | 45 +++++++++----------
 .../wireless/intel/iwlwifi/mld/tests/utils.h  | 22 ++++++---
 4 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
index d835550c1a6b..34782569d67e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
@@ -126,23 +126,24 @@ static void test_link_grading(struct kunit *test)
 	struct ieee80211_vif *vif;
 	struct ieee80211_bss_conf *link;
 	unsigned int actual_grade;
-	u8 assoc_link_id;
 	/* Extract test case parameters */
 	u8 link_id = test_param->input.link.link_id;
-	enum nl80211_band band = test_param->input.link.chandef->chan->band;
 	bool active = test_param->input.link.active;
 	u16 valid_links;
+	struct iwl_mld_kunit_link assoc_link = {
+		.band = test_param->input.link.chandef->chan->band,
+	};
 
 	/* If the link is not active, use a different link as the assoc link */
 	if (active) {
-		assoc_link_id = link_id;
+		assoc_link.id = link_id;
 		valid_links = BIT(link_id);
 	} else {
-		assoc_link_id = BIT(ffz(BIT(link_id)));
-		valid_links = BIT(assoc_link_id) | BIT(link_id);
+		assoc_link.id = BIT(ffz(BIT(link_id)));
+		valid_links = BIT(assoc_link.id) | BIT(link_id);
 	}
 
-	vif = iwlmld_kunit_setup_mlo_assoc(valid_links, assoc_link_id, band);
+	vif = iwlmld_kunit_setup_mlo_assoc(valid_links, &assoc_link);
 
 	wiphy_lock(mld->wiphy);
 	link = wiphy_dereference(mld->wiphy, vif->link_conf[link_id]);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
index 6e251dbc1dfe..4a4eaa134bd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for channel helper functions
  *
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #include <kunit/static_stub.h>
 
@@ -61,6 +61,14 @@ static void test_missed_beacon(struct kunit *test)
 		(const void *)(test->param_value);
 	struct ieee80211_vif *vif;
 	struct iwl_rx_packet *pkt;
+	struct iwl_mld_kunit_link link1 = {
+		.id = 0,
+		.band = NL80211_BAND_6GHZ,
+	};
+	struct iwl_mld_kunit_link link2 = {
+		.id = 1,
+		.band = NL80211_BAND_5GHZ,
+	};
 
 	kunit_activate_static_stub(test, ieee80211_connection_loss,
 				   fake_ieee80211_connection_loss);
@@ -68,12 +76,11 @@ static void test_missed_beacon(struct kunit *test)
 	notif = (void *)pkt->data;
 
 	if (test_param->input.emlsr) {
-		vif = iwlmld_kunit_assoc_emlsr(0x3, NL80211_BAND_5GHZ,
-					       NL80211_BAND_6GHZ);
+		vif = iwlmld_kunit_assoc_emlsr(&link1, &link2);
 	} else {
 		struct iwl_mld_vif *mld_vif;
 
-		vif = iwlmld_kunit_setup_non_mlo_assoc(NL80211_BAND_6GHZ);
+		vif = iwlmld_kunit_setup_non_mlo_assoc(&link1);
 		mld_vif = iwl_mld_vif_from_mac80211(vif);
 		notif->link_id = cpu_to_le32(mld_vif->deflink.fw_id);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index 6331cd91cdf6..fa2710661bd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -329,7 +329,7 @@ static void iwlmld_kunit_set_vif_associated(struct ieee80211_vif *vif)
 }
 
 static struct ieee80211_vif *
-iwlmld_kunit_setup_assoc(bool mlo, u8 link_id, enum nl80211_band band)
+iwlmld_kunit_setup_assoc(bool mlo, struct iwl_mld_kunit_link *assoc_link)
 {
 	struct kunit *test = kunit_get_current_test();
 	struct iwl_mld *mld = test->priv;
@@ -337,32 +337,32 @@ iwlmld_kunit_setup_assoc(bool mlo, u8 link_id, enum nl80211_band band)
 	struct ieee80211_bss_conf *link;
 	struct ieee80211_chanctx_conf *chan_ctx;
 
-	KUNIT_ASSERT_TRUE(test, mlo || link_id == 0);
+	KUNIT_ASSERT_TRUE(test, mlo || assoc_link->id == 0);
 
 	vif = iwlmld_kunit_add_vif(mlo, NL80211_IFTYPE_STATION);
 
 	if (mlo)
-		link = iwlmld_kunit_add_link(vif, link_id);
+		link = iwlmld_kunit_add_link(vif, assoc_link->id);
 	else
 		link = &vif->bss_conf;
 
-	chan_ctx = iwlmld_kunit_add_chanctx(band);
+	chan_ctx = iwlmld_kunit_add_chanctx(assoc_link->band);
 
 	wiphy_lock(mld->wiphy);
 	iwlmld_kunit_assign_chanctx_to_link(vif, link, chan_ctx);
 	wiphy_unlock(mld->wiphy);
 
 	/* The AP sta will now be pointer to by mld_vif->ap_sta */
-	iwlmld_kunit_setup_sta(vif, IEEE80211_STA_AUTHORIZED, link_id);
+	iwlmld_kunit_setup_sta(vif, IEEE80211_STA_AUTHORIZED, assoc_link->id);
 
 	iwlmld_kunit_set_vif_associated(vif);
 
 	return vif;
 }
 
-struct ieee80211_vif *iwlmld_kunit_setup_mlo_assoc(u16 valid_links,
-						   u8 assoc_link_id,
-						   enum nl80211_band band)
+struct ieee80211_vif *
+iwlmld_kunit_setup_mlo_assoc(u16 valid_links,
+			     struct iwl_mld_kunit_link *assoc_link)
 {
 	struct kunit *test = kunit_get_current_test();
 	struct ieee80211_vif *vif;
@@ -370,13 +370,13 @@ struct ieee80211_vif *iwlmld_kunit_setup_mlo_assoc(u16 valid_links,
 	KUNIT_ASSERT_TRUE(test,
 			  hweight16(valid_links) == 1 ||
 			  hweight16(valid_links) == 2);
-	KUNIT_ASSERT_TRUE(test, valid_links & BIT(assoc_link_id));
+	KUNIT_ASSERT_TRUE(test, valid_links & BIT(assoc_link->id));
 
-	vif = iwlmld_kunit_setup_assoc(true, assoc_link_id, band);
+	vif = iwlmld_kunit_setup_assoc(true, assoc_link);
 
 	/* Add the other link, if applicable */
 	if (hweight16(valid_links) > 1) {
-		u8 other_link_id = ffs(valid_links & ~BIT(assoc_link_id)) - 1;
+		u8 other_link_id = ffs(valid_links & ~BIT(assoc_link->id)) - 1;
 
 		iwlmld_kunit_add_link(vif, other_link_id);
 	}
@@ -384,9 +384,10 @@ struct ieee80211_vif *iwlmld_kunit_setup_mlo_assoc(u16 valid_links,
 	return vif;
 }
 
-struct ieee80211_vif *iwlmld_kunit_setup_non_mlo_assoc(enum nl80211_band band)
+struct ieee80211_vif *
+iwlmld_kunit_setup_non_mlo_assoc(struct iwl_mld_kunit_link *assoc_link)
 {
-	return iwlmld_kunit_setup_assoc(false, 0, band);
+	return iwlmld_kunit_setup_assoc(false, assoc_link);
 }
 
 struct iwl_rx_packet *
@@ -403,9 +404,8 @@ _iwl_mld_kunit_create_pkt(const void *notif, size_t notif_sz)
 	return pkt;
 }
 
-struct ieee80211_vif *iwlmld_kunit_assoc_emlsr(u16 valid_links,
-					       enum nl80211_band band1,
-					       enum nl80211_band band2)
+struct ieee80211_vif *iwlmld_kunit_assoc_emlsr(struct iwl_mld_kunit_link *link1,
+					       struct iwl_mld_kunit_link *link2)
 {
 	struct kunit *test = kunit_get_current_test();
 	struct iwl_mld *mld = test->priv;
@@ -414,23 +414,20 @@ struct ieee80211_vif *iwlmld_kunit_assoc_emlsr(u16 valid_links,
 	struct ieee80211_chanctx_conf *chan_ctx;
 	struct ieee80211_sta *sta;
 	struct iwl_mld_vif *mld_vif;
-	u8 assoc_link_id, other_link_id;
+	u16 valid_links = BIT(link1->id) | BIT(link2->id);
 
 	KUNIT_ASSERT_TRUE(test, hweight16(valid_links) == 2);
 
-	assoc_link_id = ffs(valid_links) - 1;
-	other_link_id = ffs(valid_links & ~BIT(assoc_link_id)) - 1;
-
-	vif = iwlmld_kunit_setup_mlo_assoc(valid_links, assoc_link_id, band1);
+	vif = iwlmld_kunit_setup_mlo_assoc(valid_links, link1);
 	mld_vif = iwl_mld_vif_from_mac80211(vif);
 
 	/* Activate second link */
 	wiphy_lock(mld->wiphy);
 
-	link = wiphy_dereference(mld->wiphy, vif->link_conf[other_link_id]);
+	link = wiphy_dereference(mld->wiphy, vif->link_conf[link2->id]);
 	KUNIT_EXPECT_NOT_NULL(test, link);
 
-	chan_ctx = iwlmld_kunit_add_chanctx(band2);
+	chan_ctx = iwlmld_kunit_add_chanctx(link2->band);
 	iwlmld_kunit_assign_chanctx_to_link(vif, link, chan_ctx);
 
 	wiphy_unlock(mld->wiphy);
@@ -439,7 +436,7 @@ struct ieee80211_vif *iwlmld_kunit_assoc_emlsr(u16 valid_links,
 	sta = mld_vif->ap_sta;
 	KUNIT_EXPECT_NOT_NULL(test, sta);
 
-	iwlmld_kunit_alloc_link_sta(sta, other_link_id);
+	iwlmld_kunit_alloc_link_sta(sta, link2->id);
 
 	return vif;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
index 9b1f2ada997f..bb757a7dd8e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
@@ -13,6 +13,12 @@ struct iwl_mld;
 
 int iwlmld_kunit_test_init(struct kunit *test);
 
+struct iwl_mld_kunit_link {
+	u8 id;
+	enum nl80211_band band;
+	enum nl80211_chan_width bandwidth;
+};
+
 enum nl80211_iftype;
 
 struct ieee80211_vif *iwlmld_kunit_add_vif(bool mlo, enum nl80211_iftype type);
@@ -88,10 +94,12 @@ struct ieee80211_sta *iwlmld_kunit_setup_sta(struct ieee80211_vif *vif,
 					     enum ieee80211_sta_state state,
 					     int link_id);
 
-struct ieee80211_vif *iwlmld_kunit_setup_mlo_assoc(u16 valid_links,
-						   u8 assoc_link_id,
-						   enum nl80211_band band);
-struct ieee80211_vif *iwlmld_kunit_setup_non_mlo_assoc(enum nl80211_band band);
+struct ieee80211_vif *
+iwlmld_kunit_setup_mlo_assoc(u16 valid_links,
+			     struct iwl_mld_kunit_link *assoc_link);
+
+struct ieee80211_vif *
+iwlmld_kunit_setup_non_mlo_assoc(struct iwl_mld_kunit_link *assoc_link);
 
 struct iwl_rx_packet *
 _iwl_mld_kunit_create_pkt(const void *notif, size_t notif_sz);
@@ -99,9 +107,9 @@ _iwl_mld_kunit_create_pkt(const void *notif, size_t notif_sz);
 #define iwl_mld_kunit_create_pkt(_notif)	\
 	_iwl_mld_kunit_create_pkt(&(_notif), sizeof(_notif))
 
-struct ieee80211_vif *iwlmld_kunit_assoc_emlsr(u16 valid_links,
-					       enum nl80211_band band1,
-					       enum nl80211_band band2);
+struct ieee80211_vif *
+iwlmld_kunit_assoc_emlsr(struct iwl_mld_kunit_link *link1,
+			 struct iwl_mld_kunit_link *link2);
 
 struct element *iwlmld_kunit_gen_element(u8 id, const void *data, size_t len);
 
-- 
2.34.1



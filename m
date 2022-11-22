Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C443634549
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 21:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiKVULo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 15:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiKVULh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 15:11:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94574B4808
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 12:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669147894; x=1700683894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OfJuOazZOkGXenkFsGJYDOPNlOCzvIkQqMh+MZ6RSvs=;
  b=ijetBNz6xb2K/2Q7ELbkD1UBVFVyhFYohGu/fHINcka9Rj+6zSOauaVU
   9ip1TjLoxuuA0b5yMZqTMiIIMO8AGFZPsXCQ71aml99qInM/eB5VRv5ZI
   MoiHg9EqerT8AXCKuGZqJMiwm7Euh2rGK7DA7xJUsbXB/rtOIvN2W8Kp3
   gdKnTbO2CEfqPqJeo5SSN0yO5aHU28fpCFxFihk32ogQJ3d9gYahiDRKT
   j2IQBL37vl8iUn/buEaqWcMRVyBwg471k6p3gYq2Hrm/EalYtaI7qqYle
   pLbxqB7iskTcwglBOf1FL/RyxxCGdDPGJanuqzFyaZ7NiTtofTwjawway
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="378163491"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="378163491"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:11:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747487079"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747487079"
Received: from mkoshili-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.209.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:11:32 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 6/9] wifi: iwlwifi: mvm: set HE PHY bandwidth according to band
Date:   Tue, 22 Nov 2022 22:10:37 +0200
Message-Id: <20221122220713.0a075d00c796.Ib4cac0b7f90dfadebceceb1e07c8cdfd7a4138f6@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221122201040.2618863-1-gregory.greenman@intel.com>
References: <20221122201040.2618863-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The bits are reserved on the opposite bands, so we shouldn't
always send them, only the 2G bit on 2.4 GHz and the 5G bits
on 5/6GHz. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 2b43fff4d3f9..e83382ded8af 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -571,10 +571,6 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 					IEEE80211_HE_MAC_CAP5_UL_2x996_TONE_RU |
 					IEEE80211_HE_MAC_CAP5_HE_DYNAMIC_SM_PS |
 					IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX,
-				.phy_cap_info[0] =
-					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
-					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
-					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
 					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
@@ -716,9 +712,6 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 					IEEE80211_HE_MAC_CAP1_MULTI_TID_AGG_RX_QOS_8,
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL,
-				.phy_cap_info[0] =
-					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
-					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD,
 				.phy_cap_info[2] =
@@ -874,9 +867,23 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->he_cap.he_cap_elem.mac_cap_info[3] |=
 			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3;
 
-	if (is_ap && iwlwifi_mod_params.nvm_file)
+	switch (sband->band) {
+	case NL80211_BAND_2GHZ:
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] |=
-			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+		break;
+	case NL80211_BAND_6GHZ:
+	case NL80211_BAND_5GHZ:
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] |=
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+		if (!is_ap || iwlwifi_mod_params.nvm_file)
+			iftype_data->he_cap.he_cap_elem.phy_cap_info[0] |=
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
 
 	if ((tx_chains & rx_chains) == ANT_AB) {
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] |=
-- 
2.35.3


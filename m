Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F518631556
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 18:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKTRBv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 12:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiKTRBm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 12:01:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23272EF3B
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 09:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668963701; x=1700499701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OfJuOazZOkGXenkFsGJYDOPNlOCzvIkQqMh+MZ6RSvs=;
  b=IMUduVytfCzjsg4De4ZIpk3IAWp2pQ+sjWcIu2AYDagaWykmpDd39RoW
   lZW/WrgJ+Cma53KomqRYQnUULTNjyzs97Xe28fEeN2572H4AHB5dMJz9N
   Li3l+CvMLNKbaZvOAIW978D0aTnfuLqsso0Cn22ZTu6HhsXh+LBHNCPbZ
   x+PDe4hW8R84ghhFmpJ2KI+6JP9gCEaxQKGN12gX48oEVXVKUonTygzLH
   HZjotUhjzuYF+8I6MQoWyOtzagv1GTailYiN7lrLPJpiPrT2xIriGRdok
   PuFWSC+dsUFeUn2ueeTWnPWl/ZVP9TEX63JI1Ir5NdLyIIz2Kb19T/j+b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315234892"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="315234892"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765719510"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="765719510"
Received: from dwiener-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.87.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:39 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 6/9] wifi: iwlwifi: mvm: set HE PHY bandwidth according to band
Date:   Sun, 20 Nov 2022 19:00:36 +0200
Message-Id: <20221120185147.881d46861305.Ib4cac0b7f90dfadebceceb1e07c8cdfd7a4138f6@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221120170039.1788067-1-gregory.greenman@intel.com>
References: <20221120170039.1788067-1-gregory.greenman@intel.com>
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


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3B631559
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 18:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKTRB7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 12:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiKTRBu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 12:01:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D34A2EF36
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 09:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668963709; x=1700499709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNgqj3bt5EnLue/+onWpNhEH5va255Wn+QZNxNGPdKo=;
  b=cqk/zq+ThJsanawb9rEe4atZtjtkE9v+arH7IHIkX6JNqOm8WO3GF84D
   JTA/lipAYL+P4/ZIcrl5eWPxRdyRqvHbiMkLdenu38D0e69zwNk5DmUDC
   /EIcuS4fvoYSvuPiOVZb90HiuJRzGkT/F1/M7tNKohX2QDee2cHXveOpE
   GIxsnSAiGzSR6mTI/342C1lNvhLSfvVVJoBJniccHT1t8iEM8ssK5x1uV
   r1WiZXJFCXrPTYWZQevWknw5UeyY8PAe4NcQo5nke/a8eLthE63/ux12m
   q1D4T06D4GJp9XTiLFoSobp3nIaS4zTzWKSWZw60til7NyBLD6EQAG9pY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315234916"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="315234916"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765719546"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="765719546"
Received: from dwiener-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.87.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:47 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Abhishek Naik <abhishek.naik@intel.com>,
        Greenman@vger.kernel.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 9/9] wifi: iwlwifi: nvm: Update EHT capabilities for GL device
Date:   Sun, 20 Nov 2022 19:00:39 +0200
Message-Id: <20221120185147.84b18b8b4f53.Ief570e27007c9e2ad3a97bee4b074e2fc1c75bae@changeid>
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

From: Abhishek Naik <abhishek.naik@intel.com>

Update EHT MAC and PHY capabilities for GL device
for station and softap interface.
Add relevant code in nvm_fixup_sband_iftd.

Signed-off-by: Abhishek Naik <abhishek.naik@intel.com>
Signed-off-by: Greenman, Gregory <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 3a646bce7b42..476b90f32626 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -950,6 +950,29 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		break;
 	}
 
+	if (CSR_HW_REV_TYPE(trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
+	    iftype_data->eht_cap.has_eht) {
+		iftype_data->eht_cap.eht_cap_elem.mac_cap_info[0] &=
+			~(IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
+			  IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
+			  IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2);
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[3] &=
+			~(IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO |
+			  IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
+			  IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
+			  IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
+			  IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
+			  IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK);
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[4] &=
+			~(IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO |
+			  IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP);
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[5] &=
+			~IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK;
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[6] &=
+			~(IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK |
+			  IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP);
+	}
+
 	if (fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_BROADCAST_TWT))
 		iftype_data->he_cap.he_cap_elem.mac_cap_info[2] |=
 			IEEE80211_HE_MAC_CAP2_BCAST_TWT;
-- 
2.35.3


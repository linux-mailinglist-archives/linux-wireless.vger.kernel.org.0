Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF4063476E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 21:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiKVUMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 15:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiKVUMk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 15:12:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDDF1149
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 12:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669147958; x=1700683958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNgqj3bt5EnLue/+onWpNhEH5va255Wn+QZNxNGPdKo=;
  b=eHqik97Q4bQG22PDKmp26kWxS61IGzosbZjDBuhZWVagGy17iqf7QjWy
   /G+ZJTNwrBWizWE/ZjzLTHFkmj7LSDQ1rKlPdQbt2MdAMcBIQCfxDMyid
   h1yAYBjVYnSCoHHbiZldosnDNshI3oS7ua/80Lbe3XmKheLZKScsDhb2Q
   r5FwKICYX8eF2Ut+PZeGjQlI9O7crYbMvrq6gVCAm9DhxNbOW0DhQaVz6
   oaX6wlUNuPXMnTjWW/Pbu+VXKyYoyts7jdnBMmxlPABD0mRUUrgcKXsjA
   Kpm/iBmcwziMRAnT1nesguAI3O1sG7vKn0UaM90feyT6MIGV76Hd7XuWX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315727497"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="315727497"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:12:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747487458"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747487458"
Received: from mkoshili-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.209.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:12:35 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Abhishek Naik <abhishek.naik@intel.com>,
        Greenman@vger.kernel.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH v2 9/9] wifi: iwlwifi: nvm: Update EHT capabilities for GL device
Date:   Tue, 22 Nov 2022 22:10:41 +0200
Message-Id: <20221122220713.1da816ab7ffc.Ief570e27007c9e2ad3a97bee4b074e2fc1c75bae@changeid>
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


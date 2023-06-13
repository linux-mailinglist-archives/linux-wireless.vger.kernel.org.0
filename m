Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB77672E373
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbjFMM57 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjFMM5y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:57:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3219B9
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661073; x=1718197073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyNTg/k4yV7PB37q1/DlyFkVB/XqUWvSawvGPtWoQfg=;
  b=mOmRkJe9VQ7hgAGiA0wC+6CTmCzfv3H/htK/AZW4BSBV74ieouzvO2DO
   Mndwz6+38cVjmTO9AHiKOTmNB7AHKvGwBmm5yTmlOmencPfXylf1c+6eq
   YY6Vf4q+TwGQecmEFxgIcjD/TZY17nNJcJXg0T4ykIe+UGdLQ/9DuzBA6
   QXYTeSxAEXtXrIY5irxknRNatS2QUl2Zci3njr9ojnlXfPSalZDAoUm3q
   FlnMCuCCe6NhBq7xG0xfHBSYnrelbWihGZouPnsJtennjQTFiQwZZWbAF
   w4bl6moZxpGQEjq8BgGn2tKC66pFqHOJK1eSx9BfnmczdhmnCJyARk/r8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973734"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973734"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880801"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880801"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:51 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/14] wifi: iwlwifi: mvm: add support for Extra EHT LTF
Date:   Tue, 13 Jun 2023 15:57:19 +0300
Message-Id: <20230613155501.de019d7cc174.I806f0f6042b89274192701a60b4f7900822db666@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613125727.300445-1-gregory.greenman@intel.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Add support for Extra EHT LTF defined in 9.4.2.313
EHT Capabilities element.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h    |  2 ++
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 15 +++++++++++++++
 include/linux/ieee80211.h                         |  1 +
 4 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index c9a48fc5fac8..a1a272433b09 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -21,6 +21,7 @@
  * @IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_2_MSK: enable HE Dual Carrier Modulation
  *					    for BPSK (MCS 0) with 2 spatial
  *					    streams
+ * @IWL_TLC_MNG_CFG_FLAGS_EHT_EXTRA_LTF_MSK: enable support for EHT extra LTF
  */
 enum iwl_tlc_mng_cfg_flags {
 	IWL_TLC_MNG_CFG_FLAGS_STBC_MSK			= BIT(0),
@@ -28,6 +29,7 @@ enum iwl_tlc_mng_cfg_flags {
 	IWL_TLC_MNG_CFG_FLAGS_HE_STBC_160MHZ_MSK	= BIT(2),
 	IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_1_MSK		= BIT(3),
 	IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_2_MSK		= BIT(4),
+	IWL_TLC_MNG_CFG_FLAGS_EHT_EXTRA_LTF_MSK		= BIT(6),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 7edb98ef8093..fad71f490313 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1012,6 +1012,8 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[6] &=
 			~(IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK |
 			  IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP);
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[5] |=
+			IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF;
 	}
 
 	if (fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_BROADCAST_TWT))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 992642edfcbe..782d53d15a1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -592,6 +592,21 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	int cmd_ver;
 	int ret;
 
+	/* Enable external EHT LTF only for GL device and if there's
+	 * mutual support by AP and client
+	 */
+	if (CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
+	    sband->iftype_data->eht_cap.has_eht &&
+	    sband->iftype_data->eht_cap.eht_cap_elem.phy_cap_info[5] &
+	    IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF &&
+	    link_sta->eht_cap.has_eht &&
+	    link_sta->eht_cap.eht_cap_elem.phy_cap_info[5] &
+	    IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF) {
+		IWL_DEBUG_RATE(mvm, "Set support for Extra EHT LTF\n");
+		cfg_cmd.flags |=
+			cpu_to_le16(IWL_TLC_MNG_CFG_FLAGS_EHT_EXTRA_LTF_MSK);
+	}
+
 	rcu_read_lock();
 	mvm_link_sta = rcu_dereference(mvmsta->link[link_id]);
 	if (WARN_ON_ONCE(!mvm_link_sta)) {
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 516cd32d6196..5dfed1a6625c 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2859,6 +2859,7 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 
 /* Maximum number of supported EHT LTF is split */
 #define IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK	0xc0
+#define IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF		0x40
 #define IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK	0x07
 
 #define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK			0x78
-- 
2.38.1


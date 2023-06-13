Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6DD72E37B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbjFMM5s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbjFMM5o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:57:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9073F1A1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661062; x=1718197062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Ne7mW5U02n5M2lStNpzGnRm3H7ii//Ul+sX7UyH6ac=;
  b=DmYhix7FSgeb0H6rpYL3JleIUGYFQsjCzPlJ8hULCKHvEgrXYq2BQLm1
   O1G/RL65l0OgWJU4SM9gI+3xmSdmH1RBq35L+soFwBZKRvdXbNXhylBK9
   lgHZWQ3mpD5bZNmFkeF07QF0YaL7ofgclzCKm4HpIskgq5xdQ1drcVQBz
   d3SwyK+mQuvBUuY7YYOZDvY/UFaH27kS1aBaoeL1U3NjLFjhPbUehGRIb
   s6wsUu+hKNVj+W/tHMGBPgSCGAAOoaSOT+Dgmdlq2s/qIh0lODHpSnTMA
   rchXPdIOGnahMzTk+/VELprA65GL8EOZaXqGQHX2uYx7s6ycf2pJcb5Li
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973710"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973710"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880758"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880758"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/14] wifi: iwlwifi: mvm: support U-SIG EHT validate checks
Date:   Tue, 13 Jun 2023 15:57:14 +0300
Message-Id: <20230613155501.c20480aa1171.Icc0d077dae01d662ccb948823e196aa9c5c87976@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Support new firmware that can validate the validate bits in
sniffer mode, and advertise that fact and the result of the
checks in the U-SIG radiotap field.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h   | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c  | 9 +++++++++
 include/net/ieee80211_radiotap.h               | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 67af922fd3ba..25e2e23dce3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -292,7 +292,7 @@ enum iwl_rx_phy_he_data0 {
 /* TSF overload low dword */
 enum iwl_rx_phy_eht_data0 {
 	/* info type: EHT any */
-	/* 1 bits reserved */
+	IWL_RX_PHY_DATA0_EHT_VALIDATE				= BIT(0),
 	IWL_RX_PHY_DATA0_EHT_UPLINK				= BIT(1),
 	IWL_RX_PHY_DATA0_EHT_BSS_COLOR_MASK			= 0x000000fc,
 	IWL_RX_PHY_DATA0_ETH_SPATIAL_REUSE_MASK			= 0x00000f00,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index a78b68c2ae3d..1a4f7c04ebae 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -467,6 +467,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT	= (__force iwl_ucode_tlv_capa_t)112,
 	IWL_UCODE_TLV_CAPA_OFFLOAD_REJ_BTM_SUPPORT	= (__force iwl_ucode_tlv_capa_t)113,
 	IWL_UCODE_TLV_CAPA_STA_EXP_MFP_SUPPORT		= (__force iwl_ucode_tlv_capa_t)114,
+	IWL_UCODE_TLV_CAPA_SNIFF_VALIDATE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)116,
 
 #ifdef __CHECKER__
 	/* sparse says it cannot increment the previous enum member */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 89ab440ad377..70db4fef6290 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1773,6 +1773,15 @@ static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
 					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR);
 	}
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SNIFF_VALIDATE_SUPPORT)) {
+		usig->common |=
+			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_VALIDATE_BITS_CHECKED);
+		usig->common |=
+			LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_VALIDATE,
+				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_VALIDATE_BITS_OK);
+	}
+
 	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE);
 	eht->data[0] |= LE32_DEC_ENC(data0,
 				     IWL_RX_PHY_DATA0_ETH_SPATIAL_REUSE_MASK,
diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index f980a72f2ce6..c4722a9963de 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -535,6 +535,8 @@ enum ieee80211_radiotap_eht_usig_common {
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN	= 0x00000008,
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN		= 0x00000010,
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC		= 0x00000020,
+	IEEE80211_RADIOTAP_EHT_USIG_COMMON_VALIDATE_BITS_CHECKED = 0x00000040,
+	IEEE80211_RADIOTAP_EHT_USIG_COMMON_VALIDATE_BITS_OK	= 0x00000080,
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER		= 0x00007000,
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW			= 0x00038000,
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL		= 0x00040000,
-- 
2.38.1


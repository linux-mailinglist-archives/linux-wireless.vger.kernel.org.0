Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36A86AAF63
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCEMRP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCEMRO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED00125BD
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018630; x=1709554630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ESNhZ69aW+nS15CoA/Hba1KDneBW4bFWM3Altz7UR7s=;
  b=RpTSt9P/QSjmqXoD9MvkW0Hm2HHS5Y4R+ykucDdzpuKNb8xpRwwDe5Nq
   znFegLvC9zsg0381gIeuGvnBhEaO6wA2dfM3wHZDyKlNm6ACdeq4lThat
   Sh1fvi4CIeVLyWptkG456ecJPQnPXnneNzTnQ3iUFf+t18xdgQBxY4ugk
   6Yt+Ch0WvIzZP4xuchGnUAPEDo7jhG0Dc3KJXZygWwHLo/b7X/NTWFWkN
   +772Vu1SCnkUq7ToZCJLTlqgOePvI1w96kB/E3if/7nDcXBAKVevhxu/b
   O9MBl3SCkaK8L5LQXu5e+YHz90eoUb1bw9+vCT9a1gz468nTGRnPdtUvu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193189"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193189"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355077"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355077"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:08 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/21] wifi: iwlwifi: mvm: add all EHT based on data0 info from HW
Date:   Sun,  5 Mar 2023 14:16:21 +0200
Message-Id: <20230305124407.730f219e02ee.Ife3dd85c65758694d7602e8bc8660887d77faacf@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Update all radiotap EHT TLVs that we can extract from data0 in HW.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 73 ++++++++++++++++++-
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 1c4e84932058..544d22472a6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -367,7 +367,8 @@ enum iwl_rx_phy_eht_data1 {
 	/* number of EHT-LTF symbols 0 - 1 EHT-LTF, 1 - 2 EHT-LTFs, 2 - 4 EHT-LTFs,
 	 * 3 - 6 EHT-LTFs, 4 - 8 EHT-LTFs */
 	IWL_RX_PHY_DATA1_EHT_SIG_LTF_NUM		= 0x000000e0,
-	IWL_RX_PHY_DATA1_EHT_RU_ALLOC			= 0x0000ff00,
+	IWL_RX_PHY_DATA1_EHT_B0				= 0x00000100,
+	IWL_RX_PHY_DATA1_EHT_RU_B1_B7_ALLOC		= 0x0000fe00,
 };
 
 /* goes into Metadata DW 7 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 57ca34341c05..f6297a05e014 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -1455,6 +1455,74 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 	}
 }
 
+#define LE32_DEC_ENC(value, dec_bits, enc_bits) \
+	le32_encode_bits(le32_get_bits(value, dec_bits), enc_bits)
+
+static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
+					struct iwl_mvm_rx_phy_data *phy_data,
+					struct ieee80211_rx_status *rx_status,
+					struct ieee80211_radiotap_eht *eht,
+					struct ieee80211_radiotap_eht_usig *usig)
+
+{
+	__le32 data0 = phy_data->d0;
+	__le32 data1 = phy_data->d1;
+	u8 info_type = phy_data->info_type;
+
+	/* Not in EHT range */
+	if (info_type < IWL_RX_PHY_INFO_TYPE_EHT_MU ||
+	    info_type > IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT)
+		return;
+
+	usig->common |= cpu_to_le32
+		(IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL_KNOWN |
+		 IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN);
+	usig->common |= LE32_DEC_ENC(data0,
+				     IWL_RX_PHY_DATA0_EHT_UPLINK,
+				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL);
+	usig->common |= LE32_DEC_ENC(data0,
+				     IWL_RX_PHY_DATA0_EHT_BSS_COLOR_MASK,
+				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN);
+
+	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE);
+	eht->data[0] |= LE32_DEC_ENC(data0,
+				     IWL_RX_PHY_DATA0_ETH_SPATIAL_REUSE_MASK,
+				     IEEE80211_RADIOTAP_EHT_DATA0_SPATIAL_REUSE);
+
+	/* All RU allocating size/index is in TB format */
+	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_RU_ALLOC_TB_FMT);
+	eht->data[8] |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_PS160,
+				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_PS_160);
+	eht->data[8] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_B0,
+				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B0);
+	eht->data[8] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_RU_B1_B7_ALLOC,
+				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B7_B1);
+
+	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN);
+	usig->common |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_TXOP_DUR_MASK,
+				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
+	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_LDPC_EXTRA_SYM_OM);
+	eht->data[0] |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_LDPC_EXT_SYM,
+				     IEEE80211_RADIOTAP_EHT_DATA0_LDPC_EXTRA_SYM_OM);
+
+	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_PRE_PADD_FACOR_OM);
+	eht->data[0] |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_PRE_FEC_PAD_MASK,
+				    IEEE80211_RADIOTAP_EHT_DATA0_PRE_PADD_FACOR_OM);
+
+	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_PE_DISAMBIGUITY_OM);
+	eht->data[0] |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_PE_DISAMBIG,
+				     IEEE80211_RADIOTAP_EHT_DATA0_PE_DISAMBIGUITY_OM);
+
+	/* TODO: what about IWL_RX_PHY_DATA0_EHT_BW320_SLOT */
+
+	if (!le32_get_bits(data0, IWL_RX_PHY_DATA0_EHT_SIGA_CRC_OK))
+		usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
+
+	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER_KNOWN);
+	usig->common |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_PHY_VER,
+				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER);
+}
+
 static void iwl_mvm_rx_eht(struct iwl_mvm *mvm, struct sk_buff *skb,
 			   struct iwl_mvm_rx_phy_data *phy_data,
 			   int queue)
@@ -1510,7 +1578,8 @@ static void iwl_mvm_rx_eht(struct iwl_mvm *mvm, struct sk_buff *skb,
 		}
 	}
 
-	/* TODO: fill usig info (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD) */
+	if (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
+		iwl_mvm_decode_eht_phy_data(mvm, phy_data, rx_status, eht, usig);
 
 #define CHECK_TYPE(F)							\
 	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA1_FORMAT_ ## F !=	\
-- 
2.38.1


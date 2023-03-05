Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C266AAF66
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCEMRX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCEMRW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22FD13502
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018637; x=1709554637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xAG9YF29ZSh2r5ItN66CWfoT6OypDs3dSSi//S7gG90=;
  b=KEOxKGlRVd9xSLpU+ZSribz593E5jb90Awtcp9rS8mG7BFH7QRJyVdr7
   hyfKnXSWlK1l1HrK4I8yYAc8J9/RkzouGpCyH8wAgOZssxE7XUuHIXZZE
   UOquuMaoG8DT+ZGq2H/BxXxuSsbswLoDuNnlm42dRcTPCaYZnf1vZ2wZn
   w3rZtQNKyK+VYphH3HlKLJhqTDcvcqOUjaTFzC/nYX/X8HZnPPhu8F1rF
   4iUGZejeigg2J9opGprNN+dHzfXpKSJizygimqZcl5UF4YNRcgBex0vFP
   xTAB8lF07ZacjW261Jic0+EfS7c5ayLA+7Z4b1haB7RGjDgtMtETp1UXZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193213"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193213"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355101"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355101"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:15 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/21] wifi: iwlwifi: mvm: decode USIG_B1_B7 RU to nl80211 RU width
Date:   Sun,  5 Mar 2023 14:16:24 +0200
Message-Id: <20230305124407.0b720d6d6a48.I0034dd108696223494799d3ffe4f09685800b831@changeid>
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

This is based on spec BE D1.5 table 9-53a

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 30f2830d66ba..e5e066f04bf9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1458,6 +1458,75 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 #define LE32_DEC_ENC(value, dec_bits, enc_bits) \
 	le32_encode_bits(le32_get_bits(value, dec_bits), enc_bits)
 
+static void iwl_mvm_decode_eht_ru(struct iwl_mvm *mvm,
+				  struct ieee80211_rx_status *rx_status,
+				  struct ieee80211_radiotap_eht *eht)
+{
+	u32 ru = le32_get_bits(eht->data[8],
+			       IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B7_B1);
+	enum nl80211_eht_ru_alloc nl_ru;
+
+	/* Using D1.5 Table 9-53a - Encoding of PS160 and RU Allocation subfields
+	 * in an EHT variant User Info field
+	 */
+
+	switch (ru) {
+	case 0 ... 36:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_26;
+		break;
+	case 37 ... 52:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_52;
+		break;
+	case 53 ... 60:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_106;
+		break;
+	case 61 ... 64:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_242;
+		break;
+	case 65 ... 66:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_484;
+		break;
+	case 67:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_996;
+		break;
+	case 68:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_2x996;
+		break;
+	case 69:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_4x996;
+		break;
+	case 70 ... 81:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_52P26;
+		break;
+	case 82 ... 89:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_106P26;
+		break;
+	case 90 ... 93:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_484P242;
+		break;
+	case 94 ... 95:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_996P484;
+		break;
+	case 96 ... 99:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242;
+		break;
+	case 100 ... 103:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484;
+		break;
+	case 104:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_3x996;
+		break;
+	case 105 ... 106:
+		nl_ru = NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484;
+		break;
+	default:
+		return;
+	}
+
+	rx_status->bw = RATE_INFO_BW_EHT_RU;
+	rx_status->eht.ru = nl_ru;
+}
+
 static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
 					struct iwl_mvm_rx_phy_data *phy_data,
 					struct ieee80211_rx_status *rx_status,
@@ -1498,6 +1567,8 @@ static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
 	eht->data[8] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_RU_B1_B7_ALLOC,
 				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B7_B1);
 
+	iwl_mvm_decode_eht_ru(mvm, rx_status, eht);
+
 	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN);
 	usig->common |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_TXOP_DUR_MASK,
 				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
-- 
2.38.1


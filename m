Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15907187CC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEaQvR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEaQvM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74062133
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551871; x=1717087871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zt7utCpCqcuX0OLH97efmmvZWFmUpoQJbrxZ/y5OUxc=;
  b=Alr9J3V4rfg8TUxnFoUamgLu2TGOMUROYGp+XXkOepAcFoI7HpagvvEc
   Z9RZGS4FXwlyQFIxeEGc6tZofYoMF5PeMHI3F4yG2shpw4K+CAEztSw9X
   JfSyA5acm6E3vr4vwlMr4zdocKYO6pCxcq7NCUYvJtVjaBXC+Z+KmMhzn
   /dEORChWyr4npDJNYWTiv2/BXO5SueuH+9J6Xrz2XfFDhJWTdh3cU0N/1
   bYerxftMtKtt2V+TmXWq7/CWie6/CT/wIQFZOg7Zc0KNjh6xY4LPcBJ9U
   iMiLvjr4zAeT3DdKNVYP3QGR3DYWAn1Gwo+TWEakqVSKzq5M8BUaRMZi4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890393"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890393"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987954"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987954"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/14] wifi: iwlwifi: mvm: clarify EHT RU allocation bits
Date:   Wed, 31 May 2023 19:49:56 +0300
Message-Id: <20230531194629.824edb28c0eb.Ia9f74573e3ac771911b679558984f1bfb36de674@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531165006.273284-1-gregory.greenman@intel.com>
References: <20230531165006.273284-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Calling this IWL_RX_PHY_DATA1_EHT_B0 is just confusing,
it's the RU allocation bit 0. Also then align the name
for B1-B7 accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index fdd8b01f09e4..67af922fd3ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -367,8 +367,8 @@ enum iwl_rx_phy_eht_data1 {
 	/* number of EHT-LTF symbols 0 - 1 EHT-LTF, 1 - 2 EHT-LTFs, 2 - 4 EHT-LTFs,
 	 * 3 - 6 EHT-LTFs, 4 - 8 EHT-LTFs */
 	IWL_RX_PHY_DATA1_EHT_SIG_LTF_NUM		= 0x000000e0,
-	IWL_RX_PHY_DATA1_EHT_B0				= 0x00000100,
-	IWL_RX_PHY_DATA1_EHT_RU_B1_B7_ALLOC		= 0x0000fe00,
+	IWL_RX_PHY_DATA1_EHT_RU_ALLOC_B0		= 0x00000100,
+	IWL_RX_PHY_DATA1_EHT_RU_ALLOC_B1_B7		= 0x0000fe00,
 };
 
 /* goes into Metadata DW 7 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index e1d02c260e69..82ac0ef1c31b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1775,9 +1775,9 @@ static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
 	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_RU_ALLOC_TB_FMT);
 	eht->data[8] |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_PS160,
 				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_PS_160);
-	eht->data[8] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_B0,
+	eht->data[8] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_RU_ALLOC_B0,
 				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B0);
-	eht->data[8] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_RU_B1_B7_ALLOC,
+	eht->data[8] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_RU_ALLOC_B1_B7,
 				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B7_B1);
 
 	iwl_mvm_decode_eht_ru(mvm, rx_status, eht);
-- 
2.38.1


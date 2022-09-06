Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DA45AEBDA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiIFOFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241283AbiIFODz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:03:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C5316580
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471885; x=1694007885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eLTKNs2xRpBl+HRdpQSAS6NVnjHB428wqLA1/yU+acc=;
  b=fuLFCHWwKA/UPjilqRBicRu8JR2udHIMbAHUaBMhVyx7sBWmfbiSg2Nz
   GAKLjavDT6HY2bS0ly1jjr2gPFXXQ109fJTAsTYa4ul0eHGJ2YMXhZMA6
   JSUX32TGw1nn7pzMhNzODmqpikQO1qIFqnhlKU0S2px5bj0UJhkG7CtmB
   tpCCrgmatvm4nJw54H7nbZ3jSHWGIxP3yf3JL04dKVuJBSGyRfdmP1wjJ
   aDnqC41M/IS76PK9Wrte1zPDHQ3W8AF+ZrsFuVr+vYij23uOQVG7T2glx
   //2kuGHLlsa3Alqb0X2riFyiZnLGdykxDa9Tpg3qqxJs5fxWqAAEN8o5G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276332703"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276332703"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459640"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:22 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: mvm: rxmq: further unify some VHT/HE code
Date:   Tue,  6 Sep 2022 16:42:08 +0300
Message-Id: <20220906161827.d1e8673b9443.I6d81fc9dd0856d75e3a799c23f0f8d212b077fca@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's some duplication here, unify it so that adding EHT
becomes easier.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 36 ++++++++-----------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c0a779867938..1aadccd8841f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1473,7 +1473,7 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct ieee80211_radiotap_he_mu *he_mu = NULL;
 	u32 rate_n_flags = phy_data->rate_n_flags;
 	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
-	u8 stbc, ltf;
+	u8 ltf;
 	static const struct ieee80211_radiotap_he known = {
 		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
 				     IEEE80211_RADIOTAP_HE_DATA1_DATA_DCM_KNOWN |
@@ -1538,19 +1538,6 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 		he->data1 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN);
 
-	stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >> RATE_MCS_STBC_POS;
-	rx_status->nss =
-		((rate_n_flags & RATE_MCS_NSS_MSK) >>
-		 RATE_MCS_NSS_POS) + 1;
-	rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
-	rx_status->encoding = RX_ENC_HE;
-	rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-	if (rate_n_flags & RATE_MCS_BF_MSK)
-		rx_status->enc_flags |= RX_ENC_FLAG_BF;
-
-	rx_status->he_dcm =
-		!!(rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK);
-
 #define CHECK_TYPE(F)							\
 	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA1_FORMAT_ ## F !=	\
 		     (RATE_MCS_HE_TYPE_ ## F >> RATE_MCS_HE_TYPE_POS))
@@ -1730,6 +1717,17 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 	if (rate_n_flags & RATE_MCS_LDPC_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
 
+	switch (format) {
+	case RATE_MCS_VHT_MSK:
+		rx_status->encoding = RX_ENC_VHT;
+		break;
+	case RATE_MCS_HE_MSK:
+		rx_status->encoding = RX_ENC_HE;
+		rx_status->he_dcm =
+			!!(rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK);
+		break;
+	}
+
 	switch (format) {
 	case RATE_MCS_HT_MSK:
 		rx_status->encoding = RX_ENC_HT;
@@ -1737,17 +1735,11 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
 		break;
 	case RATE_MCS_VHT_MSK:
+	case RATE_MCS_HE_MSK:
 		rx_status->nss =
-			((rate_n_flags & RATE_MCS_NSS_MSK) >>
-			RATE_MCS_NSS_POS) + 1;
+			u32_get_bits(rate_n_flags, RATE_MCS_NSS_MSK) + 1;
 		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
-		rx_status->encoding = RX_ENC_VHT;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-		if (rate_n_flags & RATE_MCS_BF_MSK)
-			rx_status->enc_flags |= RX_ENC_FLAG_BF;
-		break;
-	case RATE_MCS_HE_MSK:
-		/* handled above */
 		break;
 	default: {
 		int rate = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
-- 
2.35.3


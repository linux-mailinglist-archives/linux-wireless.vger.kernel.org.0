Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C3F67D88B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjAZWgs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjAZWgk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E693935A1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772597; x=1706308597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b1pzuIa0jyeHnHQZbjyGjupMyFneRNwTc6iIP+G+b6Q=;
  b=CeBmSLHB4gs//WJfnhiAIgQmrITLLXjedoY8BmdG8jTMMJC/HLCdecz2
   kldretIZBy2R2mVIBvmpp3uZFSLVxNgKxL40u0/9e/45qC+VEH7/Tz5DK
   uBu4t6Xr+R7ZtOQvcybE7TDvsw7BU05Sa+zr9IjhUfz+gKOHh9KR9F31o
   9BKaiTWcxy2sfiEI/aHGddWUTx5HksaUmgQlT8gqeizaQ8b2uKpuAd4Q5
   RnVxACqxWmPXyDkDFd/njBNNM/DsuuJblan7wB9DKxLqNfIn/EGpOyc5x
   DrQjtTYOJxhGLcwJnXNKk0BZAHURfxVH4h4hqteCzdDdycB1Oy4RXGudH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098686"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098686"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986274"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986274"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:20 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/12] wifi: iwlwifi: mvm: simplify by using SKB MAC header pointer
Date:   Fri, 27 Jan 2023 00:28:17 +0200
Message-Id: <20230127002430.3ec5493934a4.I1d41a2af28588b5899fcd2402f8c4bd8cc29a12e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Instead of calculating the offset to the 802.11 header based on radiotap
bits and length, shorten the code path by always setting the MAC header
in the skb and using skb_mac_header().

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 44 +++++++------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 83e2be64b33f..4e7115ebede7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -11,37 +11,11 @@
 #include "fw-api.h"
 #include "time-sync.h"
 
-static void *iwl_mvm_skb_get_hdr(struct sk_buff *skb)
-{
-	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
-	u8 *data = skb->data;
-
-	/* Alignment concerns */
-	BUILD_BUG_ON(sizeof(struct ieee80211_radiotap_he) % 4);
-	BUILD_BUG_ON(sizeof(struct ieee80211_radiotap_he_mu) % 4);
-	BUILD_BUG_ON(sizeof(struct ieee80211_radiotap_lsig) % 4);
-	BUILD_BUG_ON(sizeof(struct ieee80211_vendor_radiotap) % 4);
-
-	if (rx_status->flag & RX_FLAG_RADIOTAP_HE)
-		data += sizeof(struct ieee80211_radiotap_he);
-	if (rx_status->flag & RX_FLAG_RADIOTAP_HE_MU)
-		data += sizeof(struct ieee80211_radiotap_he_mu);
-	if (rx_status->flag & RX_FLAG_RADIOTAP_LSIG)
-		data += sizeof(struct ieee80211_radiotap_lsig);
-	if (rx_status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA) {
-		struct ieee80211_vendor_radiotap *radiotap = (void *)data;
-
-		data += sizeof(*radiotap) + radiotap->len + radiotap->pad;
-	}
-
-	return data;
-}
-
 static inline int iwl_mvm_check_pn(struct iwl_mvm *mvm, struct sk_buff *skb,
 				   int queue, struct ieee80211_sta *sta)
 {
 	struct iwl_mvm_sta *mvmsta;
-	struct ieee80211_hdr *hdr = iwl_mvm_skb_get_hdr(skb);
+	struct ieee80211_hdr *hdr = (void *)skb_mac_header(skb);
 	struct ieee80211_rx_status *stats = IEEE80211_SKB_RXCB(skb);
 	struct iwl_mvm_key_pn *ptk_pn;
 	int res;
@@ -180,6 +154,10 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (unlikely(headlen < hdrlen))
 		return -EINVAL;
 
+	/* Since data doesn't move data while putting data on skb and that is
+	 * the only way we use, data + len is the next place that hdr would be put
+	 */
+	skb_set_mac_header(skb, skb->len);
 	skb_put_data(skb, hdr, hdrlen);
 	skb_put_data(skb, (u8 *)hdr + hdrlen + pad_len, headlen - hdrlen);
 
@@ -937,7 +915,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 			    struct iwl_rx_mpdu_desc *desc)
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
-	struct ieee80211_hdr *hdr = iwl_mvm_skb_get_hdr(skb);
+	struct ieee80211_hdr *hdr = (void *)skb_mac_header(skb);
 	struct iwl_mvm_sta *mvm_sta;
 	struct iwl_mvm_baid_data *baid_data;
 	struct iwl_mvm_reorder_buffer *buffer;
@@ -2153,6 +2131,16 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	iwl_mvm_rx_fill_status(mvm, skb, &phy_data, queue);
 
+	/* no more radio tap info should be put after this point.
+	 *
+	 * We mark it as mac header, for upper layers to know where
+	 * all radio tap header ends.
+	 *
+	 * Since data doesn't move data while putting data on skb and that is
+	 * the only way we use, data + len is the next place that hdr would be put
+	 */
+	skb_set_mac_header(skb, skb->len);
+
 	/*
 	 * Override the nss from the rx_vec since the rate_n_flags has
 	 * only 2 bits for the nss which gives a max of 4 ss but there
-- 
2.38.1


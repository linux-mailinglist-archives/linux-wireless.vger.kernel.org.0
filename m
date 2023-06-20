Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB17368C6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjFTKFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjFTKEz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D8E7F
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255494; x=1718791494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Pv7DpwL6dPY29Hb3/kRW9xlFtGj7Dzef9kp10Zyr2Q=;
  b=AsYjErlVMls1xeMhsBfH75atokFTcgmO3BOLVzZc9VwWVTy8IYReO9BL
   a868LaEovX9HdnGeujZE/5ROTDxFNgshRpTvGAjR76xOSOLmUbrBaDjPg
   yDuK21sDxZ+vIstlnz2inreVFHLCP0MRglYhZBMfNe+DN4hk5eG0cJNRf
   9GkfTMQE9SLnJfjq0kewJXb8Q7b4koBwqyJYpmV8fjK7JOApT19TIwZhi
   6r/CmL9xm04RA1Xax+BYyhdiLMoPo/9tSfb5mj7KgvkDNFyaKoWeN5E97
   N8AM+sEmB/yVUv7k6X/95Tg/JmWKCR7q6bvHScmjNNnoz2Lj6n+eZl4rE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819652"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819652"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143568"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143568"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/19] wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection
Date:   Tue, 20 Jun 2023 13:04:01 +0300
Message-Id: <20230620125813.a50cf68fbf2e.Ieceacbe3789d81ea02ae085ad8d1f8813a33c31b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We've already done the 'decryption' here, so tell
mac80211 it need not do it again.

Fixes: b1fdc2505abc ("iwlwifi: mvm: advertise BIGTK client support if available")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 9dbe71d299ae..8d1e44fd9de7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -279,7 +279,8 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 				struct ieee80211_hdr *hdr,
 				struct iwl_rx_mpdu_desc *desc,
-				u32 status)
+				u32 status,
+				struct ieee80211_rx_status *stats)
 {
 	struct iwl_mvm_sta *mvmsta;
 	struct iwl_mvm_vif *mvmvif;
@@ -308,8 +309,10 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 
 	/* good cases */
 	if (likely(status & IWL_RX_MPDU_STATUS_MIC_OK &&
-		   !(status & IWL_RX_MPDU_STATUS_REPLAY_ERROR)))
+		   !(status & IWL_RX_MPDU_STATUS_REPLAY_ERROR))) {
+		stats->flag |= RX_FLAG_DECRYPTED;
 		return 0;
+	}
 
 	if (!sta)
 		return -1;
@@ -378,7 +381,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 
 	if (unlikely(ieee80211_is_mgmt(hdr->frame_control) &&
 		     !ieee80211_has_protected(hdr->frame_control)))
-		return iwl_mvm_rx_mgmt_prot(sta, hdr, desc, status);
+		return iwl_mvm_rx_mgmt_prot(sta, hdr, desc, status, stats);
 
 	if (!ieee80211_has_protected(hdr->frame_control) ||
 	    (status & IWL_RX_MPDU_STATUS_SEC_MASK) ==
-- 
2.38.1


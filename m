Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46972CAB1
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbjFLPwV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjFLPwU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:52:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182C5E8
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585136; x=1718121136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yqIBFc0KdyecEZ6YtbTTKhb2WJqiAXIe0ZjoQkmgBV8=;
  b=Yb3Dgh6UnWqMfhzCPzRUqWgCSU+hfSjmwG4ShmIz2QHvn/fa/x2INs04
   7uM5E1wsxyXh5Y7xH1k5DFozpMeOa6/PjYN/DDZ8Ruu1Z9qqBG4gECeOx
   EmzXX/DsQURGJ/q7e7+Wj5VZxK4VW7vhFPnRCkHLaETRux+Nx0sTQchzv
   whYzafjnN4vOdOflocS7DHJl+d2t1PqvAb7ju4/7I35PdAt9cOOde7vJi
   ittBKuMs8ZEIyjMlR+J2Kl2bm0edN1JbQPuBElrXIqmrVzHCAz6/6afdM
   2xfig6fSkLjxt3bTViiL3pGcf2dzhVGx4GeOTBZ9o5f6N7LllZE/YfW3q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674277"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674277"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499369"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499369"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: always set MH len in offload_assist
Date:   Mon, 12 Jun 2023 18:51:12 +0300
Message-Id: <20230612184434.bba713f7495a.Idbc8e3ce313b51af4060326e0191bd338b3163a2@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612155116.168000-1-gregory.greenman@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some versions of the new hardware don't have a functional
version of the new offload method, but still have stricter
checks on the MAC header (MH) length in the offload assist
word. Include that even if checksumming isn't offloaded to
hardware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ccd1e41604f3..547694c89ffa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -44,9 +44,9 @@ static u16 iwl_mvm_tx_csum_pre_bz(struct iwl_mvm *mvm, struct sk_buff *skb,
 				  struct ieee80211_tx_info *info, bool amsdu)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
+	u16 mh_len = ieee80211_hdrlen(hdr->frame_control);
 	u16 offload_assist = 0;
 #if IS_ENABLED(CONFIG_INET)
-	u16 mh_len = ieee80211_hdrlen(hdr->frame_control);
 	u8 protocol = 0;
 
 	/* Do not compute checksum if already computed */
@@ -118,6 +118,8 @@ static u16 iwl_mvm_tx_csum_pre_bz(struct iwl_mvm *mvm, struct sk_buff *skb,
 	else
 		udp_hdr(skb)->check = 0;
 
+out:
+#endif
 	/*
 	 * mac header len should include IV, size is in words unless
 	 * the IV is added by the firmware like in WEP.
@@ -130,8 +132,6 @@ static u16 iwl_mvm_tx_csum_pre_bz(struct iwl_mvm *mvm, struct sk_buff *skb,
 	mh_len /= 2;
 	offload_assist |= mh_len << TX_CMD_OFFLD_MH_SIZE;
 
-out:
-#endif
 	if (amsdu)
 		offload_assist |= BIT(TX_CMD_OFFLD_AMSDU);
 	else if (ieee80211_hdrlen(hdr->frame_control) % 4)
-- 
2.38.1


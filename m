Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B75572CAAC
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbjFLPvv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbjFLPvu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:51:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0279ACA
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585106; x=1718121106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VhjU8x+TFm14+FhzchqbvbRFCgIWzI9qsjyKva6DRok=;
  b=b6XBQQV/P+gPPgFpV0hbEN6CblSyTSOmT2pRUCBdYspdgv+uG6IeDvuw
   NWKql4paEempefpxI6iFsMckIvpHkXzj3y66NQ0q5DbLyHmvf/W8wFgwl
   6InAMxNK2pwOYst8neR7YeaR3sQbCpUIs+xTFRkuzXrpKL86pQUULbwBL
   TZ/gb+T0lxanXRWbE8bpDAYQsqsVE147XIoPxMJBSj/rN6aHGvGDk1FxE
   tn83EywPh08bhDMSoSF4fk1t23pLn810U3c7xdEtCIyR+LUisH/sCQWGG
   LN1pQ5gcR4d1gEGfNqSXlESiHqQTuX0Ce+u+t+eg43h74mtsZvm5N/WCS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674224"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674224"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499324"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499324"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: fix getting LDPC/STBC support
Date:   Mon, 12 Jun 2023 18:51:08 +0300
Message-Id: <20230612184434.5a8856739b11.I6af4a55b22ed856f484ba77f87723dceec4904f2@changeid>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Use flags field from struct ieee80211_tx_info in order to get
LDPC/STBC support. The rate parameter, used originally, is 16
bits only and does not have details of LDPC/STBC support.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 5fa6f98b8e55..ccd1e41604f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -343,9 +343,9 @@ static u32 iwl_mvm_get_inject_tx_rate(struct iwl_mvm *mvm,
 			result |= RATE_MCS_SGI_MSK_V1;
 		if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
 			result |= u32_encode_bits(1, RATE_MCS_CHAN_WIDTH_MSK_V1);
-		if (rate->flags & IEEE80211_TX_CTL_LDPC)
+		if (info->flags & IEEE80211_TX_CTL_LDPC)
 			result |= RATE_MCS_LDPC_MSK_V1;
-		if (u32_get_bits(rate->flags, IEEE80211_TX_CTL_STBC))
+		if (u32_get_bits(info->flags, IEEE80211_TX_CTL_STBC))
 			result |= RATE_MCS_STBC_MSK;
 	} else {
 		return 0;
-- 
2.38.1


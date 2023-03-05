Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD256AAF6A
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCEMRh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCEMRg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1EB1258A
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018649; x=1709554649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mFmTSZn7GOqoJmrI7ExbBX7KfTWI+2tsDW2ema75MAY=;
  b=OzJjX9WWPtkqCnoCl7trr7W+iC9EBIKAf0BC/efme6BDxs87hrsCmFa6
   xbBN3u4BRklJjrcNPeafVcWNTr6fk9cyMWta8QhQ0/Dqzxv6aYwHu1ghO
   WrxSyjlND3sUyNOcRuPZC4eXnFBC2bR47ILb7cqb5pckGBmYdraS4a6Qr
   Pm5a+sZDgUtVG6wBVGqYQUb+pCMyE3f3xT079uv0XjQTeV8WcrTrVWdk8
   GjlK69MEkEv4wgmZSeIWwZz49pDqpZ/nXh9jB7ejJ5N/za1ULMbWY4MH0
   U9jouP9BeFTx9Hb+Am3Ffvvmyv0xps1WLUEks0X0SFntJJVEKfDStnO0Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193255"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193255"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355167"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355167"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:27 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/21] wifi: iwlwifi: mvm: make flush code a bit clearer
Date:   Sun,  5 Mar 2023 14:16:28 +0200
Message-Id: <20230305124407.c0795543f254.I302124a8584dd049577b0c2c74ecd7c48ddf4f3e@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

The mask building here is only relevant for the old TX API,
so move it into the else branch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c9911750d8af..04e62b0182d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5057,9 +5057,10 @@ static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
 			if (iwl_mvm_flush_sta(mvm, mvmsta, false))
 				IWL_ERR(mvm, "flush request fail\n");
 		} else {
-			msk |= mvmsta->tfd_queue_msk;
 			if (iwl_mvm_has_new_tx_api(mvm))
 				iwl_mvm_wait_sta_queues_empty(mvm, mvmsta);
+			else /* only used for !iwl_mvm_has_new_tx_api() below */
+				msk |= mvmsta->tfd_queue_msk;
 		}
 	}
 
-- 
2.38.1


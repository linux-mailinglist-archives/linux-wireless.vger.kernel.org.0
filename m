Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C03D67D88F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjAZWgw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjAZWgl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CC35688F
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772599; x=1706308599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BvxxPNfBRpBro73o8Hy+pVw5hAjPuAw0dXxu3yXsc/8=;
  b=NARkF1xxEE2QPnY65vDpBfdwu7zbHhoVi9bkITHvJsiiuXKGtOjI0Tpz
   lOMtq27vqW0OycsI7x+8lF0YKfV4gtl3yfE2qvET2/Zuk8ROjS7fg1M1v
   dFSgd+7NrFQkUv5mYJ/LW0raTwtCvaiFNeOKc+r9qfpHma+hBZOrVQplE
   J0Kva5ImiCkW+dZnc2jKvN5EXqAWNag7gnUKSPtSgzPCI5B3O8UycO7Rf
   0VyAexEzJyBL2T9rWl7egA3uThF6l5EpWMKoJA7oR+aRULUcwBNreO0Vm
   fSkEAyNQ9tn+Dq7OTCdD8QpX+ij2tnby6Uooaav2uAfwdLge+f4aS2gUB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098713"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098713"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986292"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986292"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:27 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/12] wifi: iwlwifi: mvm: Reset rate index if rate is wrong
Date:   Fri, 27 Jan 2023 00:28:18 +0200
Message-Id: <20230127002430.8eede67758bb.I585ab389e27d61153540b7cb5ebed66e21f765f0@changeid>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Setting rate index should not depend on net_ratelimit().
Fix that for the case of invalid rate.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 4e7115ebede7..8453c5e13667 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1730,10 +1730,11 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 
 		rx_status->rate_idx = rate;
 
-		if ((rate < 0 || rate > 0xFF) && net_ratelimit()) {
-			IWL_ERR(mvm, "Invalid rate flags 0x%x, band %d,\n",
-				rate_n_flags, rx_status->band);
+		if ((rate < 0 || rate > 0xFF)) {
 			rx_status->rate_idx = 0;
+			if (net_ratelimit())
+				IWL_ERR(mvm, "Invalid rate flags 0x%x, band %d,\n",
+					rate_n_flags, rx_status->band);
 		}
 
 		break;
-- 
2.38.1


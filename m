Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33736E385D
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjDPMse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjDPMsd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32472D4C
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649303; x=1713185303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4oMFAL08iJW4+3rso2Sk/8KfiWIfZDfbgVVqNAP2u18=;
  b=DHqYaFs4kL0fAMmbF31z6N2uFpgvJwaM/19uN6Q5/4vvdp2FIeR6HF6n
   aerK++gKjFRLUTSGd7dQtEXJtWRz53eJTz1clADtfJ+bxm2ZKyGSKOoLK
   EF7l/XQ7CDcVrpM21/Q1F3Bs/V/vqCNxZThXi0txIVFVpcxjh0UqBwh/r
   JVkYByere/NG9khlItObMgXHsMYnz92AvTa6jGNJ3XONMPR8XLWc34MdA
   ZOME2morEg2IAta2NWRGq6+aSmIgz3mgDdenEoJ1dLojiiXuovzWryeb1
   kR+aSgkj8PFVWNRkL2STcoQk53DRJSMx0x8SaYOf6Ofpby4H2H0idX4XE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520579"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520579"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670459"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670459"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Lorenzo Zolfanelli <lorenzo@zolfa.nl>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: make the loop for card preparation effective
Date:   Sun, 16 Apr 2023 15:47:38 +0300
Message-Id: <20230416154301.615b683ab9c8.Ic52c3229d3345b0064fa34263293db095d88daf8@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Since we didn't reset t to 0, only the first iteration of the loop
did checked the ready bit several times.
From the second iteration and on, we just tested the bit once and
continued to the next iteration.

Reported-and-tested-by: Lorenzo Zolfanelli <lorenzo@zolfa.nl>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216452
Fixes: 289e5501c314 ("iwlwifi: fix the preparation of the card")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index c5446b82c6c7..b281850fbf7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -599,7 +599,6 @@ static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
 int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 {
 	int ret;
-	int t = 0;
 	int iter;
 
 	IWL_DEBUG_INFO(trans, "iwl_trans_prepare_card_hw enter\n");
@@ -616,6 +615,8 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 	usleep_range(1000, 2000);
 
 	for (iter = 0; iter < 10; iter++) {
+		int t = 0;
+
 		/* If HW is not ready, prepare the conditions to check again */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
 			    CSR_HW_IF_CONFIG_REG_PREPARE);
-- 
2.38.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55B66E0809
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjDMHpa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDMHp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDCA83FF
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371925; x=1712907925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PIc40iBxwvAHsg0n1HYBLVQjdYlUHowSdr5oWCxhdvI=;
  b=nu63Z17PSE8eOKXpamn/85680kOUAjY3/Iw2a2VIWZJfeyuY29rVeLOH
   4qVU23DyBeL/zVQiLrrTayKBoRrD558qavFJbjU3U98SULxVkUTatb67a
   EMKQxVux5vCml6agwxc4cM52Vu6o4wVZWVZ+6LkgCagt942mRk18qVQp7
   BqIvyYer8+djH3FHiQqKutDZDQY9GmYlGGq2zo+1FuQniYJol0JCtC1tp
   aWApQhzV1dd7IQPAx0EXKSKJGs0HqvdmwBSW4y9fZITzV0R6U34QtLLhL
   fxZXslN+7zDnHJIF6FU1BuA5T6y9thZo50rEbnJIpFXz+PTm4eShJKhug
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323735981"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323735981"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034747"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034747"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Golan Ben Ami <golan.ben.ami@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: enable bz hw checksum from c step
Date:   Thu, 13 Apr 2023 10:44:07 +0300
Message-Id: <20230413102635.697a9d74e84d.I6724874112692a04e29287cac9dad7140532557f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

B step doesn't support full checksum yet, move to c step.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 9a6e7dd166c0..b3545c3273e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -187,7 +187,7 @@ static u32 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ ||
 	    (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
 	     CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
-	     mvm->trans->hw_rev_step == SILICON_A_STEP))
+	     mvm->trans->hw_rev_step <= SILICON_B_STEP))
 		return iwl_mvm_tx_csum_pre_bz(mvm, skb, info, amsdu);
 	return iwl_mvm_tx_csum_bz(mvm, skb, amsdu);
 }
-- 
2.38.1


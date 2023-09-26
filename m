Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590087AE76A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjIZIHs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 04:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjIZIHq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 04:07:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9119116
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715658; x=1727251658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zyI83O6v6u6POcXpZnpBLLMhA4sCX6RxrNuokLGcc/8=;
  b=bqH/q6iMmOsiOIBke9pcjkYSukHSlZQDoy+k7zL9WAKufCWAUIvX8c0Y
   qsNIVB3qNHbhtY4IV4jeynX7nVhPwoD+cRLHJU1eQc0BquHZvUX/TU+dN
   g3JbSym+wj5fKamvWpwUHHoLtgcquBYixRcS38CVc0RFX9zMtv5i+HZSd
   9I8zESto4RAt/blqFPPakO3QZB2/34MsGpNmg2FcyiGFzU/CTVz1sFBbs
   cMy9vf2j9K7e74EAIICFyq6UpaHzSRrAO9LvCgbllRGKIZrm16xfa6k15
   QTTqfcwDzWSPoX/oeQ574qw3zvBW00S6R5RKo29/1HQ/VRp4O+tOV1Xc3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467797239"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467797239"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698369266"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698369266"
Received: from nbenitzh-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.250])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:37 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/9] wifi: iwlwifi: pcie: propagate iwl_pcie_gen2_apm_init() error
Date:   Tue, 26 Sep 2023 11:07:14 +0300
Message-Id: <20230926110319.883768afe77b.Ic47cb8ce0a0abba3b4745cc2a721217c33360d6c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926080721.876640-1-gregory.greenman@intel.com>
References: <20230926080721.876640-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

If iwl_pcie_gen2_apm_init() fails, we should propagate the
error code up, rather than ignoring it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index fa46dad5fd68..085c4b49be87 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -230,11 +230,14 @@ static int iwl_pcie_gen2_nic_init(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int queue_size = max_t(u32, IWL_CMD_QUEUE_SIZE,
 			       trans->cfg->min_txq_size);
+	int ret;
 
 	/* TODO: most of the logic can be removed in A0 - but not in Z0 */
 	spin_lock_bh(&trans_pcie->irq_lock);
-	iwl_pcie_gen2_apm_init(trans);
+	ret = iwl_pcie_gen2_apm_init(trans);
 	spin_unlock_bh(&trans_pcie->irq_lock);
+	if (ret)
+		return ret;
 
 	iwl_op_mode_nic_config(trans->op_mode);
 
-- 
2.38.1


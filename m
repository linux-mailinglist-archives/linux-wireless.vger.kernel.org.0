Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFEF616579
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKBPAz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiKBPAw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:00:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1272A97E
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401251; x=1698937251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sIs7TvbR8prnY9VrApCFSU6WHs+pqeSUdxFKPjsoxW0=;
  b=g9OvRg4EB6zAFiDztj/ZPYIjTkUAtyRdZCU1tEPV0ngD1nYEJ0ZaKHK1
   blqW7OrUjyy5hrwp3upQSypEgTYeIqr5eijgv3esSZQQwiSnQDV+23J8m
   3UtwEFjAxtCLrJ58Gu8Th1mwCWO4SvT7E2a82uaYkM7MIqdpKFF93kVwP
   srgIv1crNXm3+PZaHTXdXSvOqzqa/mrLXPc1uWrBD09B0Z3loV5Ne687p
   exYGLTh/6yaTJQodcMeInteSx0J83UHEuq+ijBnS56L7Ahx0CaS0M8hZF
   8JvFZjsagZ8LaWMpyJXNdEH2pViUjqnu/IGBfwnwRcm0KfJBv1OFiyvqT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523461"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523461"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810516"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810516"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:42 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rotem Saado <rotem.saado@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/11] wifi: iwlwifi: dbg: use bit of DRAM alloc ID to store failed allocs
Date:   Wed,  2 Nov 2022 16:59:52 +0200
Message-Id: <20221102165239.688dec28b1d9.I470b8d29c28d16f25f4192773f075940de7ed33c@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102145958.342864-1-gregory.greenman@intel.com>
References: <20221102145958.342864-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rotem Saado <rotem.saado@intel.com>

The failed_alloc variable is used as a bitmask in the loop where we
check DRAM allocations.  But erroneously, we were clearing the DRAM
alloc IDs we removed as an integer.

Fix that by clearing them as bits instead.

Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index cd7a84c553e9..6d6c12999645 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1327,7 +1327,7 @@ static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 			     "WRT: removing allocation id %d from region id %d\n",
 			     le32_to_cpu(reg->dram_alloc_id), i);
 
-		failed_alloc &= ~le32_to_cpu(reg->dram_alloc_id);
+		failed_alloc &= ~BIT(le32_to_cpu(reg->dram_alloc_id));
 		fwrt->trans->dbg.unsupported_region_msk |= BIT(i);
 
 		kfree(*active_reg);
-- 
2.35.3


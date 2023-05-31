Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84B57187CD
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEaQvU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEaQvT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CA598
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551878; x=1717087878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8+8KzMpUs6UOC7OEksZw+brEUTDs/YtMFaL3qv3CT4g=;
  b=UASvLBoaK/9P3aeG5TI0SOhr72E9l2S4o52bz3BNu7ZDd9epYE/yy5nc
   W78uQ5pDC366mu49M0or3GZgY/uevLOV69d2hRBTkSmAyeVGJx1H1JyFN
   1uNjg0Y9STjZDcoyqFbBnCTQssrmnhmuXBsehdDdogza81Z9YFFC1l5Uw
   +rbJ5CDaU5RYZucau54y7z0WiP65Q9SYvecRpe4KblcpK+2//6dcpy3nF
   BGb63jmiEk48Arxx7pK9K39cHf3kDuFwbBAWMvuaqv7J7n8kLg5kMK2G5
   a7uuMKl4WG75lDCj7UW9SYA7IVaN26gExjvdBz1PAvFKMI1ajPdi1BVee
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890457"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890457"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987963"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987963"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/14] wifi: iwlwifi: do not log undefined DRAM buffers unnecessarily
Date:   Wed, 31 May 2023 19:49:58 +0300
Message-Id: <20230531194629.ecae60cf2d7f.Ib44a94d4aeb55dbb2e52edea8b69a09bc0f722c3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531165006.273284-1-gregory.greenman@intel.com>
References: <20230531165006.273284-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

DRAM buffers that are not defined in the TLVs (or are unused in the
preset) would cause a log message. To avoid confusion, skip processing
buffers with an invalid (i.e. uninitialized) DRAM path.

This further reduces the noise of the message in cases where it is
unlikely to be helpful. Also update a related debug log string to better
describe what is happening.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 898d5dcf1012..fb0277bd12cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -738,7 +738,8 @@ static int iwl_dbg_tlv_update_dram(struct iwl_fw_runtime *fwrt,
 
 	if (le32_to_cpu(fwrt->trans->dbg.fw_mon_cfg[alloc_id].buf_location) !=
 			IWL_FW_INI_LOCATION_DRAM_PATH) {
-		IWL_DEBUG_FW(fwrt, "DRAM_PATH is not supported alloc_id %u\n", alloc_id);
+		IWL_DEBUG_FW(fwrt, "WRT: alloc_id %u location is not in DRAM_PATH\n",
+			     alloc_id);
 		return -1;
 	}
 
@@ -799,6 +800,10 @@ static void iwl_dbg_tlv_update_drams(struct iwl_fw_runtime *fwrt)
 
 	for (i = IWL_FW_INI_ALLOCATION_ID_DBGC1;
 	     i < IWL_FW_INI_ALLOCATION_NUM; i++) {
+		if (fwrt->trans->dbg.fw_mon_cfg[i].buf_location ==
+				IWL_FW_INI_LOCATION_INVALID)
+			continue;
+
 		ret = iwl_dbg_tlv_update_dram(fwrt, i, dram_info);
 		if (!ret)
 			dram_alloc = true;
-- 
2.38.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2C4616576
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKBPAu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKBPAs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:00:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A92FE
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401247; x=1698937247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZSbQkhsCAVWfNadqBpVQEX7SKfKjbprLiz5fPLZUWuE=;
  b=HsEdlFAGGKORLdeHq03JO6aawXF70D8TTmM42I2ppzfr3QaYyjiK+6nS
   Ek+ihVzql/eyjsuKmBXUN63Hte7IRQbSV4PJ8J5qhCU7hFhl0ZRrxwmPd
   qQBFt+tC9Ml3W99PAHqytHD0biuPx7bgVzVfkDmnEe8bkuUzxvAONi4Pg
   xaAveYBzpr1EMGTWGCEvuqa8YQEE8dS9LUvRQXmjRja+I3VsT6R0XFR08
   37s3wh/9js37o4KeC7iJ71oxfDiJRvTMgRpnSpF7bDFvJRtmhuBfOfK5q
   6sYOf9ANa+aW2r7XjsFBpHA981L2ittg74UV3DefEi6Z3/uvW+ybZB8Sf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523404"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523404"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810416"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810416"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:31 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rotem Saado <rotem.saado@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/11] wifi: iwlwifi: dbg: add support for DBGC4 on BZ family and above
Date:   Wed,  2 Nov 2022 16:59:49 +0200
Message-Id: <20221102165239.0b6050b41060.Id662c716c2e3c2c850740d1f71e2801e02aeddaf@changeid>
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

Update the for loop that iterates over all the DBGCs to include DBGC4.
DBGC4 is only supported staring from the BZ family of devices, so check
the family before accepting it.

Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 3237d4b528b5..cd7a84c553e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -590,6 +590,9 @@ static int iwl_dbg_tlv_alloc_fragments(struct iwl_fw_runtime *fwrt,
 		if (alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1)
 			return -EIO;
 		num_frags = 1;
+	} else if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ &&
+			   alloc_id > IWL_FW_INI_ALLOCATION_ID_DBGC3) {
+		return -EIO;
 	}
 
 	remain_pages = DIV_ROUND_UP(le32_to_cpu(fw_mon_cfg->req_size),
@@ -789,7 +792,7 @@ static void iwl_dbg_tlv_update_drams(struct iwl_fw_runtime *fwrt)
 	dram_info->second_word = cpu_to_le32(DRAM_INFO_SECOND_MAGIC_WORD);
 
 	for (i = IWL_FW_INI_ALLOCATION_ID_DBGC1;
-	     i <= IWL_FW_INI_ALLOCATION_ID_DBGC3; i++) {
+	     i < IWL_FW_INI_ALLOCATION_NUM; i++) {
 		ret = iwl_dbg_tlv_update_dram(fwrt, i, dram_info);
 		if (!ret)
 			dram_alloc = true;
-- 
2.35.3


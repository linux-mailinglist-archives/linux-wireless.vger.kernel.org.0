Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54256E206F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDNKMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjDNKMc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:12:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9797AA0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467149; x=1713003149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmQXJpAbV62eerNVSuf2ZBBe0ugbQhovY7awLHk1NTc=;
  b=NrIyD8CBgVLfqFlWBZNKOeEZrKjG3WJRnkANca+wpWmyca0pvFgZmJFg
   KpA37I1B19l3E7z2AUc827HlnVLI3YL2D8ledN05BOAhaBmjYC17/0J7S
   37PcbYs8hWDgFEz45p0YU+6BJgOwLZY2UBSU/HI50Y4PC+7Q4AT3V9aBI
   eu8zoAHdMn71Q/X9yDyKLis24tvHYUx03Xun5otfSWSrfeUKz55ucFYtL
   Be7g8rDUoOyZB0LBGd3WWyDsmcLCWQI9ksmcHGgdFoJkHmnZH7ZWz0ejz
   u51MLiB+6hyT9E+cE3Wcl1suV4NQsjgQJU9uWTwxsDLJnPdWY68hp8VBE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263569"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263569"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351688"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351688"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: Fix spelling mistake "Gerenal" -> "General"
Date:   Fri, 14 Apr 2023 13:11:56 +0300
Message-Id: <20230414130637.eac55cbef8f1.I15cc5d3f1489759bf915bfb3cbbb72b67b18f8b6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in a IWL_DEBUG_SCAN debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 7749f15b7f14..7ac9bdbfe194 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2297,7 +2297,7 @@ iwl_mvm_scan_umac_fill_general_p_v11(struct iwl_mvm *mvm,
 
 	iwl_mvm_scan_umac_dwell_v11(mvm, gp, params);
 
-	IWL_DEBUG_SCAN(mvm, "Gerenal: flags=0x%x, flags2=0x%x\n",
+	IWL_DEBUG_SCAN(mvm, "General: flags=0x%x, flags2=0x%x\n",
 		       gen_flags, gen_flags2);
 
 	gp->flags = cpu_to_le16(gen_flags);
-- 
2.38.1


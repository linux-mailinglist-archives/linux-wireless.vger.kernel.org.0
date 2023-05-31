Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFD47187C8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjEaQvO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjEaQvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3121F12E
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551870; x=1717087870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIONNmoO/Q69pG8dbX8zLKy8Y2oVU3xv03UgSNi4n6k=;
  b=MU0H/4f54kk1xKHjyX3zqRmx8k1b5swIoIQXg1RhUasrdrIWaFtXZdY5
   w1mDQ5aSby4PuWSUBr2Wjjsqo93auadb6LApVVfJJKTXUNnixeEFR2rsJ
   aq8GSZVoLM8EWeGowoyEDtto1KFi3hk4OuTjVw92Syi9ic5MvU3T3t0sS
   TLfaFBXwGp/HPancafDDGIXYlfqMq8Lz/YSicS6dx4TivB5N8kGliBxJV
   B1u2wz2/ax+MPI8t9brPWzmKJXb/If4yAoaL6X3vhGCoKEWcDjum8FxRK
   4Fe22Gaadg6HfXQeTRKkylQTqfvRAmAgYAmUZaadYtYKC6xkosCGoKGty
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890388"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890388"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987950"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987950"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/14] wifi: iwlwifi: Add vendors to TAS approved list
Date:   Wed, 31 May 2023 19:49:54 +0300
Message-Id: <20230531194629.845c205e4def.Iab5c849617ed7e13304e4dfc7def668659439946@changeid>
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

From: Alon Giladi <alon.giladi@intel.com>

Allows vendors to use the time average sar feature.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 25 ++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 08b1e15241ce..3546638779c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1104,7 +1104,26 @@ static const struct dmi_system_id dmi_tas_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
 		},
 	},
-
+	{ .ident = "Acer",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		},
+	},
+	{ .ident = "ASUS",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		},
+	},
+	{ .ident = "MSI",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
+		},
+	},
+	{ .ident = "Honor",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+		},
+	},
 	/* keep last */
 	{}
 };
@@ -1176,6 +1195,10 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 					"Unable to add US/Canada to TAS block list, disabling TAS\n");
 			return;
 		}
+	} else {
+		IWL_DEBUG_RADIO(mvm,
+				"System vendor '%s' is in the approved list.\n",
+				dmi_get_system_info(DMI_SYS_VENDOR));
 	}
 
 	/* v4 is the same size as v3, so no need to differentiate here */
-- 
2.38.1


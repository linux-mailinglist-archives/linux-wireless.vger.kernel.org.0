Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF76E6E42D2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDQImg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQImf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C177EE6C
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720943; x=1713256943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RUWnt41J0CjhpTwGSW49zJ4mu5e99N3071XrQ5usNBc=;
  b=NCvtfN8N3KVFg2DFiyD3W5Z1zEo1oRWhMjHG8kv+6I4brAH+cfcyICTq
   tTVDmPTFZCSiim5Z+JLMteQYDjAclbGRnZDDr7djpejMhDxUiRGO/+b3P
   pKIa06bl3ckvSAP9PHYxjnM7IqaEUW+x3jyH4w0Tme68Ob7IeIRP5cJdG
   EGpuADd34uPvBLNdI6RW005hZFsthgyzCvkjJBMnp0UvywhZmoeh4fHY2
   roy/VpFUtt/JPyjw6B+LqFQ56nOV8h5A3Mp3VnmtiKBLVBjlEXUVtw8uR
   UlfbpslgtBWku86qJERGzeJAd6PUvTRUknmdjGRjsy6W7QTt1/hhDRrd0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634453"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634453"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173908"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173908"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:21 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: bump FW API to 78 for AX devices
Date:   Mon, 17 Apr 2023 11:41:34 +0300
Message-Id: <20230417113648.5a4dcbf5a2c1.I125808566fe892ee0865e392bf1b1872daafe8ad@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Start supporting API version 78 for AX devices.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index b98f0ff02362..532d14f61253 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_22000_UCODE_API_MAX	77
+#define IWL_22000_UCODE_API_MAX	78
 
 /* Lowest firmware API version supported */
 #define IWL_22000_UCODE_API_MIN	39
-- 
2.38.1


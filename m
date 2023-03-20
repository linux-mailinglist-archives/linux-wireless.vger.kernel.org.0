Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2CE6C0EFB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCTKfb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCTKek (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:34:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B5C1A4BB
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308447; x=1710844447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ojQVWqNWmTKcUl3TF6J0AlZoviIUrV6JR5vWE3fCVf8=;
  b=SiZ9KMDXOkmJnZNycmEt3YawPMnnq9G8AIp/EJ2/uYpv4DBTDBXNcHvx
   xhm38CUCAhxD5Xa5/2D1OR8Z0lHANb8hDEIsT78fqs8cOPpi2hdsFwbbE
   /ZG+6pZ1R/8NwMIsP6+YrsqLqE4se9vFfh1+Ke2fJDpBdavUbyv3R3TL1
   WcwgekKGPiRmcwM2vYVgI03v59AYaXNxLltukYXHUDm0pCu0glRA8tLYx
   p4I8XkicDmlMZ6XhVzGWVH0KhNXDtPV3RPVBYnVugMKHhpFpz/yroJhKr
   Nuie8hAGdEvw1UyzQ/QTmJO9uJi6k4eOQc/mRw3LAHpFVBzBcbfKyGuq9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997902"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997902"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523665"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523665"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/18] wifi: iwlwifi: mvm: select ptp cross timestamp from multiple reads
Date:   Mon, 20 Mar 2023 12:33:08 +0200
Message-Id: <20230320122330.d9e6f8f8998a.I569939ec4ddf0c6c64c112e7d0c30583f5509d9a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

iwl_mvm_get_sync_time() reads the gp2 from the device and then
reads the system clock. Since the two reads are not done atomically,
unexpected delays may happen between the two reads (e.g. context
switch) which make it inaccurate.
In order to improve the accuracy of the cross timestamp, call
iwl_mvm_get_sync_time() multiple times in a loop and take the
result in which the difference between the two clock is the smallest.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c | 27 ++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
index 1eafaaed415d..5c2bfc8ed88d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -18,6 +18,8 @@
 #define SCALE_FACTOR	65536000000ULL
 #define IWL_PTP_WRAP_THRESHOLD_USEC	(5000)
 
+#define IWL_PTP_GET_CROSS_TS_NUM	5
+
 static void iwl_mvm_ptp_update_new_read(struct iwl_mvm *mvm, u32 gp2)
 {
 	/* If the difference is above the threshold, assume it's a wraparound.
@@ -122,6 +124,28 @@ iwl_mvm_get_crosstimestamp_fw(struct iwl_mvm *mvm, u32 *gp2, u64 *sys_time)
 	return ret;
 }
 
+static void iwl_mvm_phc_get_crosstimestamp_loop(struct iwl_mvm *mvm,
+						ktime_t *sys_time, u32 *gp2)
+{
+	u64 diff = 0, new_diff;
+	u64 tmp_sys_time;
+	u32 tmp_gp2;
+	int i;
+
+	for (i = 0; i < IWL_PTP_GET_CROSS_TS_NUM; i++) {
+		iwl_mvm_get_sync_time(mvm, CLOCK_REALTIME, &tmp_gp2, NULL,
+				      &tmp_sys_time);
+		new_diff = tmp_sys_time - ((u64)tmp_gp2 * NSEC_PER_USEC);
+		if (!diff || new_diff < diff) {
+			*sys_time = tmp_sys_time;
+			*gp2 = tmp_gp2;
+			diff = new_diff;
+			IWL_DEBUG_INFO(mvm, "PTP: new times: gp2=%u sys=%lld\n",
+				       *gp2, *sys_time);
+		}
+	}
+}
+
 static int
 iwl_mvm_phc_get_crosstimestamp(struct ptp_clock_info *ptp,
 			       struct system_device_crosststamp *xtstamp)
@@ -150,8 +174,7 @@ iwl_mvm_phc_get_crosstimestamp(struct ptp_clock_info *ptp,
 		if (ret)
 			goto out;
 	} else {
-		iwl_mvm_get_sync_time(mvm, CLOCK_REALTIME, &gp2, NULL,
-				      &sys_time);
+		iwl_mvm_phc_get_crosstimestamp_loop(mvm, &sys_time, &gp2);
 	}
 
 	gp2_ns = iwl_mvm_ptp_get_adj_time(mvm, (u64)gp2 * NSEC_PER_USEC);
-- 
2.38.1


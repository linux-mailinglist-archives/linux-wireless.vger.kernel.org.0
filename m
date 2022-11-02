Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE189616580
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKBPBS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiKBPBR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:01:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE3655F
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401275; x=1698937275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y/jE7E4jVpH2iC/JMi3dJ4fGtJtES2Xlz4v5bnJkc8g=;
  b=ExkLlqwbCA+phEQf/bHNzS2RWocDZTBerkoiix9LPtNcBg9dZyifPn41
   THtqwvvVALxQuRH2318rjuoldnRDhPAXzlWpzSEkvUEsVuzmmEe45UiKe
   wBGPuBBWzFKjN/IP/x7UgQZsezGKafBrtAFGA32E8kWVkgZYdHROOT5nl
   MiLwK8A3NdyPmB3oPztNnMdXUAAN2ZaC+nWQFvwEAX3uIUeEcejUaA6XI
   cYNlgtTMhSXFYii9dkU5wnqIr8s3qEF7sWf7yG05kXw8EiL5Yd2raQ0ih
   fPU0NmpFNT9mrlsgJAo/RRLMkmpCIQuPJP/8fnmDQNwutJbL3Rl8A6PKL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523634"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523634"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:01:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810790"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810790"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:01:02 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/11] wifi: iwlwifi: mei: wait for the mac to stop on suspend
Date:   Wed,  2 Nov 2022 16:59:58 +0200
Message-Id: <20221102165239.371102f04586.I813a964607b3e92ea275a0cf56df57227c11ae88@changeid>
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

From: Avraham Stern <avraham.stern@intel.com>

When iwlmei driver is removed, it removes all the interfaces
since CSME will take over the NIC while there is no SAP connection.
When the iwlmei driver is removed due to the host being suspended,
this results in the interface being down after resume since the
interface was removed on suspend so mac80211 will not try to bring it
up on resume.
Since on suspend the mac is stopped anyway by mac80211, there is
no need to remove the interface in this case. Wait for the mac
to stop instead. Once the mac is stopped, the driver will not
access the NIC anymore so it is safe for CSME to take over.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 9a49361cd059..b89989b6399a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1990,6 +1990,7 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 }
 
 #define SEND_SAP_MAX_WAIT_ITERATION 10
+#define IWLMEI_DEVICE_DOWN_WAIT_ITERATION 50
 
 static void iwl_mei_remove(struct mei_cl_device *cldev)
 {
@@ -2000,8 +2001,26 @@ static void iwl_mei_remove(struct mei_cl_device *cldev)
 	 * We are being removed while the bus is active, it means we are
 	 * going to suspend/ shutdown, so the NIC will disappear.
 	 */
-	if (mei_cldev_enabled(cldev) && iwl_mei_cache.ops)
-		iwl_mei_cache.ops->nic_stolen(iwl_mei_cache.priv);
+	if (mei_cldev_enabled(cldev) && iwl_mei_cache.ops) {
+		unsigned int iter = IWLMEI_DEVICE_DOWN_WAIT_ITERATION;
+		bool down = false;
+
+		/*
+		 * In case of suspend, wait for the mac to stop and don't remove
+		 * the interface. This will allow the interface to come back
+		 * on resume.
+		 */
+		while (!down && iter--) {
+			mdelay(1);
+
+			mutex_lock(&iwl_mei_mutex);
+			down = mei->device_down;
+			mutex_unlock(&iwl_mei_mutex);
+		}
+
+		if (!down)
+			iwl_mei_cache.ops->nic_stolen(iwl_mei_cache.priv);
+	}
 
 	if (rcu_access_pointer(iwl_mei_cache.netdev)) {
 		struct net_device *dev;
-- 
2.35.3


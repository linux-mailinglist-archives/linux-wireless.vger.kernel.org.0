Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412956E080A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDMHph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDMHpc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C93D8A4B
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371927; x=1712907927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aMNSqU6lkawhrAxrpVJ5KRUpaiQXTacuFzN1Bn0aKTw=;
  b=XXyF2fz/6e2PALRHa9ffiV6ukuMIXuK5vIPDWvwKYSuY1h9jUGmKkYgY
   iUpIrXPz2eyJmehL6slTQ9+qmuVa7I2b6Hiz8rt82QLtumetBwv920WxM
   c7XJYs8BB3POmT8X1dGdwuYdTgJjVxc7vsty82sN4LagQokiomg0seGcD
   T34iXF3mbLg8NU05EyPVmrBBcVCrfmO4o04ye+nHjyV/UZDidU8dikFZz
   rta7OcYGjYaf1dSF5/CCy//E71cfpeQ8Ervo2sArzD4/oaajxjF4gt6Zn
   /gdS0AU9K4f83vVerLWbk2YjoIFVRJT1Zea4wRKjNP74VARVyoEkCw4g+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323736042"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323736042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034758"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034758"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:25 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: fix A-MSDU checks
Date:   Thu, 13 Apr 2023 10:44:08 +0300
Message-Id: <20230413102635.8c445b943fee.Ibf772102ca712f59e2ee0cdd4c344011fcf445aa@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Since Gl A-step devices use the old checksum hardware,
we shouldn't use the Bz code to check for A-MSDU
combining ability; fix that.

Fixes: ec18e7d4d20d ("wifi: iwlwifi: mvm: use old checksum for Bz A-step")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index aaa7e3c561a0..0ee5169de034 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6129,7 +6129,10 @@ static bool iwl_mvm_mac_can_aggregate(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (mvm->trans->trans_cfg->device_family > IWL_DEVICE_FAMILY_BZ ||
+	    (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
+	     !(CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
+	       mvm->trans->hw_rev_step == SILICON_A_STEP)))
 		return iwl_mvm_tx_csum_bz(mvm, head, true) ==
 		       iwl_mvm_tx_csum_bz(mvm, skb, true);
 
-- 
2.38.1


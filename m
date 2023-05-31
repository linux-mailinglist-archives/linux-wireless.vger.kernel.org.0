Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA04E7187D5
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjEaQwF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjEaQwE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:52:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189E18F
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551918; x=1717087918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sR+E+LLzKeE4jgOe8GFhOvwLo20YE6gk5BYR3BIH9TU=;
  b=Tq5ErLbLTgBlCRs8GeIrgFQNHobOKM+aawA2htue0/fjxjp4Lde0Ugau
   04Lck3Gfv4338ISPsdH8c71prTKKUnCi4cf5UZud8UnbmV8YYn1wAzFKR
   ZMkA+jnqvtmbuGx3p3APdhb99FS8N8klFt0XrCF4gPO7L6lZFKhKai0Ri
   khI661RA+/3tY4kG0BXmckOLN03VVeb881fV4zrFas+PBCD29ajrvizlo
   zstMF84mWGJkcxUSTnWDK2dkozxrDLiyd3jDkJRlR6k0oKTSvLvnBLSvJ
   6FqMoN59z0oalXWj2CqnV+Fdgu9Xf93uhQcR45hGXk/3eFpz5gIICOTXY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890805"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890805"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706988009"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706988009"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:54 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/14] wifi: iwlwifi: mvm: send time sync only if needed
Date:   Wed, 31 May 2023 19:50:06 +0300
Message-Id: <20230531194630.0fb9f81f1852.Idcc41b67d1fbb421e5ed9bac2177b948b7b4d1c9@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

If there's no peer configured then there's no point in sending
the command down to the firmware with an invalid peer address.

Fixes: cf85123a210f ("wifi: iwlwifi: mvm: support enabling and disabling HW timestamping")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 3546638779c4..a97969075b7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1725,9 +1725,11 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		iwl_mvm_send_recovery_cmd(mvm, ERROR_RECOVERY_UPDATE_DB);
-		iwl_mvm_time_sync_config(mvm, mvm->time_sync.peer_addr,
-					 IWL_TIME_SYNC_PROTOCOL_TM |
-					 IWL_TIME_SYNC_PROTOCOL_FTM);
+
+		if (mvm->time_sync.active)
+			iwl_mvm_time_sync_config(mvm, mvm->time_sync.peer_addr,
+						 IWL_TIME_SYNC_PROTOCOL_TM |
+						 IWL_TIME_SYNC_PROTOCOL_FTM);
 	}
 
 	if (!mvm->ptp_data.ptp_clock)
-- 
2.38.1


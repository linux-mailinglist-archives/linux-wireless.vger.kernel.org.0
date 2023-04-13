Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6647A6E1447
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDMSlk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDMSlj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122FD40E7
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411296; x=1712947296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MUf+GIAZAeu5JmH4aWMqsM7I8R5C1/W3YiUzeCnA8ME=;
  b=T9LZhp3hWMlGCgrvSp8dlf6rg25FlQTWcWBG7OdyfLuwDPdOpIUTf/on
   0xrnPdWfCmcik5Hkcv3YughpVr/cmwChLT1+liylgUh0k0ovFbdpDj6/X
   4QOtZBQHqOgolmKrSExfuUPQXAZYBi2AZv93fQ3h0RveOPdUujSgPIG3B
   8Nt6Nw/C0AhwpHQiqlFShVr08Joqn8c3pNeK2poX/a1Pc7xr6O9yUtHrf
   q/h3lFyb0Ojl0YeMFcgy1MKWAO+60SOki3v63Rd+XzT+DXfva28D5FG6j
   GLRt/ANG9cszQuWCuywWsHbbtWGbOE0K+dM1FxyBU1ZRz8/nEKTWEuqRl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372126982"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372126982"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984339"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984339"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:40:58 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: mvm: fix shift-out-of-bounds
Date:   Thu, 13 Apr 2023 21:40:24 +0300
Message-Id: <20230413213309.c41a33c32898.Idc15f9eed005345a4137c28ef62efd80a405fad0@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The aux queue is initialized to IWL_MVM_INVALID_QUEUE. This is
later used for a bitmask of the queue, which results in a
shift-out-of-bounds. Fix it.

Fixes: b85f7ebb2497 ("wifi: iwlwifi: mvm: avoid UB shift of snif_queue")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 6b2690534f59..3e5bed885bd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2231,11 +2231,13 @@ static int iwl_mvm_add_int_sta_with_queue(struct iwl_mvm *mvm, int macidx,
 int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
 {
 	int ret;
+	u32 qmask = mvm->aux_queue == IWL_MVM_INVALID_QUEUE ? 0 :
+		BIT(mvm->aux_queue);
 
 	lockdep_assert_held(&mvm->mutex);
 
 	/* Allocate aux station and assign to it the aux queue */
-	ret = iwl_mvm_allocate_int_sta(mvm, &mvm->aux_sta, BIT(mvm->aux_queue),
+	ret = iwl_mvm_allocate_int_sta(mvm, &mvm->aux_sta, qmask,
 				       NL80211_IFTYPE_UNSPECIFIED,
 				       IWL_STA_AUX_ACTIVITY);
 	if (ret)
-- 
2.38.1


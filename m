Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C77368C7
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjFTKFX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjFTKE6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B46C118
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255497; x=1718791497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ggwMVEJ0/oSmkoPg6/+Le0nDMhajGjBs67w+Nlcx8zU=;
  b=VW4zKmKNHJ5/CEvGtYDRm5ONndIzjSXtD7ODX7E6/IY96rvOMuCRlGz+
   z4sBOCIqEykEMR5nSgrzHHbeJsMNCwGP7zOqCDWxtwXOFbgfvuW3Cxswz
   mTcM1a9nFxeblgyZ1WcK6JGUGCuZih720UwzoeCz+e4C/VZLr7ElNIvSc
   X+R70W5QhSUCv5a3XAYFmnJL5A+cVwP7Q4AuLBIc+icZLR2XLh15/LHpJ
   +yB8/LseDlzzJunViVqtoZJX3zwzZWeg9m5Ee9wLXK0TibiY2lBVm2lWw
   2bHRzWpLaVVYArpA0Cutdt20VFYr+YqCbXEx3zOe5sq+YHvunIwOFMBQE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819660"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819660"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143576"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143576"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Roee Goldfiner <roee.h.goldfiner@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/19] wifi: iwlwifi: mvm: avoid baid size integer overflow
Date:   Tue, 20 Jun 2023 13:04:02 +0300
Message-Id: <20230620125813.f428c856030d.I2c2bb808e945adb71bc15f5b2bac2d8957ea90eb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Roee reported various hard-to-debug crashes with pings in
EHT aggregation scenarios. Enabling KASAN showed that we
access the BAID allocation out of bounds, and looking at
the code a bit shows that since the reorder buffer entry
(struct iwl_mvm_reorder_buf_entry) is 128 bytes if debug
such as lockdep is enabled, then staring from an agg size
512 we overflow the size calculation, and allocate a much
smaller structure than we should, causing slab corruption
once we initialize this.

Fix this by simply using u32 instead of u16.

Reported-by: Roee Goldfiner <roee.h.goldfiner@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 37a52ffa8897..3b9a343d4f67 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2885,7 +2885,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	}
 
 	if (iwl_mvm_has_new_rx_api(mvm) && start) {
-		u16 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
+		u32 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
 
 		/* sparse doesn't like the __align() so don't check */
 #ifndef __CHECKER__
-- 
2.38.1


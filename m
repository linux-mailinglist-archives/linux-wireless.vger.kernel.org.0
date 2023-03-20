Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863BB6C0EFE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCTKfh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjCTKfI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:35:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007CD18AB8
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308473; x=1710844473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2cbW/ZDiSRg5XnbfcXBk/BIZqzfpWrHA5c1CYOLPdQ=;
  b=napn1ANJ80cHTL3QopdxFpkl1KPTljAtBLgKUWi/kxCb1kRESFerkRnp
   2RUvKJve3Y889+55jc1Ka7gL0tRhgLD6POKbIvbl7jeY45kroIl73ios4
   zNvoicf+xjeDVzGBBUUFNvA8zuk60GzA5tLMj3W+6Wj3Rx2UceQxC7bDt
   p2AXsQV5wro+vQH3MgZZfItMxQTsIXxiDKSn6WVWCpkXeZUiAKuG9ksAT
   kNFUosviZA+VdkXyUK4wgwFLYzRgUPvDbaQic5LXhPl0P5cosBj2gpLk6
   kYRhaZks5dg9qn9ahuNSHcVhicIp/vgV0IMH35fFJfY/TGU4eLVEgIKoS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997920"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997920"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523678"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523678"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/18] wifi: iwlwifi: mvm: Don't send MAC CTXT cmd after deauthorization
Date:   Mon, 20 Mar 2023 12:33:11 +0200
Message-Id: <20230320122330.11b3481bc497.I9672acff9cfc00e7e1a187e7178caa3a1911a1b5@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

We used to send a MAC CTXT cmd to ask the FW to not pass MCAST frames
if we're associated but not authorized, because we don't have the
keys in that stage, and after authorization - we sent the cmd again
to ask the FW to pass MCAST, as we have the keys now.
The patch linked below was changing this strategy to always allow
MCAST frames, and if we're not authorized - the driver will drop them.
But we're still sending the MAC CTXT cmd after deaouthorization even
though we don't tell the FW to not pass MCAST frames anymore.
Basically we don't tell the FW anything new with this cmd.
Fix this by not sending MAC CTXT command after deauthorization.
For authorization we're sending the cmd to configure other changes too,
so keep it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c6eb4cb44a09..d5708f9ebbe9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3547,11 +3547,6 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 
 			mvmvif->authorized = 1;
 
-			/*
-			 * Now that the station is authorized, i.e., keys were already
-			 * installed, need to indicate to the FW that
-			 * multicast data frames can be forwarded to the driver
-			 */
 			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 			iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
 		}
@@ -3566,12 +3561,10 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
 				     false);
 		if (!sta->tdls) {
-			/* Multicast data frames are no longer allowed */
-			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
-
 			/*
-			 * Set this after the above iwl_mvm_mac_ctxt_changed()
-			 * to avoid sending high prio again for a little time.
+			 * Set this but don't call iwl_mvm_mac_ctxt_changed()
+			 * yet to avoid sending high prio again for a little
+			 * time.
 			 */
 			mvmvif->authorized = 0;
 
-- 
2.38.1


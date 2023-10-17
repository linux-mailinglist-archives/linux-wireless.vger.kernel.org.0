Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34F67CBEC5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjJQJRb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjJQJR2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9785F5
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534246; x=1729070246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z5RuR884J9DuXiSLU2S7hlUVh1uq7UFvdyIWaBJxcaA=;
  b=ig8jt1s5C3tpu9akw/qut/UFscUvXAPQrhIatDRTGIdURK4xaXqBtI/l
   jTi2tYXHk/BocrX9eIVEdUwWBB9rvhyy+NnxS1Ymd2woQJeHsSSr9OKTq
   LUqfFWBVG/bUYmKFHb3CE4eAOmc6hREqxluMryS2rFsg3Jvtp8r/oEx1w
   KN1X7i/1eWXECEQYuF8swHl1Ru+O8PmS1Jes1o/M+MahipE6HYnstREM/
   P664/+XglBjdg3ueuZCLgn1VtguVhoUXiEGARQpI+OAMe/YvtZAU4+xG8
   2Papu+npf6vtppoIUG88X0rwaWlVkWvvTk4WUJXGyUeM27wH/O/aWJ/38
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808559"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808559"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731952"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731952"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:25 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/14] wifi: iwlwifi: disable multi rx queue for 9000
Date:   Tue, 17 Oct 2023 12:16:46 +0300
Message-Id: <20231017115047.2917eb8b7af9.Iddd7dcf335387ba46fcbbb6067ef4ff9cd3755a7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Multi rx queue allows to spread the load of the Rx streams on different
CPUs. 9000 series required complex synchronization mechanisms from the
driver side since the hardware / firmware is not able to provide
information about duplicate packets and timeouts inside the reordering
buffer.

Users have complained that for newer devices, all those synchronization
mechanisms have caused spurious packet drops. Those packet drops
disappeared if we simplify the code, but unfortunately, we can't have
RSS enabled on 9000 series without this complex code.

Remove support for RSS on 9000 so that we can make the code much simpler
for newer devices and fix the bugs for them.

The down side of this patch is a that all the Rx path will be routed to
a single CPU, but this has never been an issue, the modern CPUs are just
fast enough to cope with all the traffic.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     | 11 ++++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 3d58a2b9518c..cab4d7351088 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -279,7 +279,7 @@ static inline void iwl_free_rxb(struct iwl_rx_cmd_buffer *r)
 #define IWL_MGMT_TID		15
 #define IWL_FRAME_LIMIT	64
 #define IWL_MAX_RX_HW_QUEUES	16
-#define IWL_9000_MAX_RX_HW_QUEUES	6
+#define IWL_9000_MAX_RX_HW_QUEUES	1
 
 /**
  * enum iwl_wowlan_status - WoWLAN image/device status
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c1c9cdf49a41..28da98e75e52 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -376,7 +376,9 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	}
 
-	if (iwl_mvm_has_new_rx_api(mvm))
+	/* We want to use the mac80211's reorder buffer for 9000 */
+	if (iwl_mvm_has_new_rx_api(mvm) &&
+	    mvm->trans->trans_cfg->device_family > IWL_DEVICE_FAMILY_9000)
 		ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 
 	if (fw_has_capa(&mvm->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 041afc97a911..17c3d00d4d27 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -957,6 +957,9 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	baid = (reorder & IWL_RX_MPDU_REORDER_BAID_MASK) >>
 		IWL_RX_MPDU_REORDER_BAID_SHIFT;
 
+	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000)
+		return false;
+
 	/*
 	 * This also covers the case of receiving a Block Ack Request
 	 * outside a BA session; we'll pass it to mac80211 and that
@@ -2617,9 +2620,15 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	if (!iwl_mvm_reorder(mvm, napi, queue, sta, skb, desc) &&
 	    likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr2)) &&
-	    likely(!iwl_mvm_mei_filter_scan(mvm, skb)))
+	    likely(!iwl_mvm_mei_filter_scan(mvm, skb))) {
+		if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
+		    (desc->mac_flags2 & IWL_RX_MPDU_MFLG2_AMSDU) &&
+		    !(desc->amsdu_info & IWL_RX_MPDU_AMSDU_LAST_SUBFRAME))
+			rx_status->flag |= RX_FLAG_AMSDU_MORE;
+
 		iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb, queue, sta,
 						link_sta);
+	}
 out:
 	rcu_read_unlock();
 }
-- 
2.38.1


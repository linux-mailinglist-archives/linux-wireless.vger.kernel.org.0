Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B757368B9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjFTKE6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjFTKEf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228B410FE
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255474; x=1718791474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PF2XlS9VLjgnVjIqT3HPYQyeN9AiYx7ZWBUnR2/+U9I=;
  b=GKnejD+7dZA0qlydcBh/6IAPPsBE2O77ZeRjtLpXBWq603BbEle0AdP8
   1aunU8h6vpUdfEWeuaRxD5T6SBqY9Rqmu4dM+nffs7zUxFOaQvb0+IeSw
   dbjaIJMbRYS2wFaMBKZG4YaGhnCTNTYUIJmx18Wh7+TTjuK+G7uYHsS3l
   bcifUOTU6FosQhj0LCSL0WX/Erz905o441KdTP1TFxYWkpHoK42KXVUY6
   hKO4/HiHd+Vj0I3lxpSOK5vjIAoSjjbJCg/phIhQgni/Yl8IytVvUtJ6R
   Fvt7IUXElIR6Egfzv+5ieS5j3m5xZHd6HNhrpjt9Unn1LYnGR9YZEPNsG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819531"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819531"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838142897"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838142897"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/19] wifi: iwlwifi: mvm: check the right csa_active
Date:   Tue, 20 Jun 2023 13:03:49 +0300
Message-Id: <20230620125813.63f835a4f578.I0bb2a231e4da506b7c751dc23a428558f9ecfa75@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When the firmware says that the channel switch is happening, we check
that we know about that switch by checking the csa_active bit.

Until now, we checked the bss_conf from the vif instead of taking the
bss_conf of the link.
Fix that.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index b8143ae8b403..7369a45f7f2b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1763,6 +1763,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 	u32 id;
 	u8 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
 					       CHANNEL_SWITCH_START_NOTIF, 0);
+	bool csa_active;
 
 	rcu_read_lock();
 
@@ -1778,6 +1779,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 			goto out_unlock;
 
 		id = mac_id;
+		csa_active = vif->bss_conf.csa_active;
 	} else {
 		struct iwl_channel_switch_start_notif *notif = (void *)pkt->data;
 		u32 link_id = le32_to_cpu(notif->link_id);
@@ -1789,6 +1791,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 
 		id = link_id;
 		vif = bss_conf->vif;
+		csa_active = bss_conf->csa_active;
 	}
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -1828,7 +1831,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 		 */
 		if (iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
 					    CHANNEL_SWITCH_ERROR_NOTIF,
-					    0) && !vif->bss_conf.csa_active) {
+					    0) && !csa_active) {
 			IWL_DEBUG_INFO(mvm, "Channel Switch was canceled\n");
 			iwl_mvm_cancel_channel_switch(mvm, vif, id);
 			break;
-- 
2.38.1


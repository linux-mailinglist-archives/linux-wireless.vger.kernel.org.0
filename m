Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CD46CD2A4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjC2HIv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjC2HIu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55EA30D8
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073721; x=1711609721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HWY9tONK8i0m/FnmSGJJVoo656+0qD5GP5aLVN451hg=;
  b=KVqY2GiCTBG1AffJOqE1xmlueOimqSOnoifhKnhDyjMN0x8sxDTiGe5x
   Jop955aQ1ZlGUtgOWV/bOXUp5E30Sh15Ray0GLHbJEySxhnzye64dhp7B
   /Qdy28Nb8/jJwBxPADhq90kvkUZJc4XzHUb53dZ12ty2oQDMBPvO0anYQ
   6zo3oYMDefHj3ixAF/AUlwCUegSUilIVREwvhRML+JTSGXlMmIM2HO6Vg
   73MpVcGMLjLCXBjO67PKIuTvzzQeZLivZsgJZa1nmG6Bqm5RJHIMHaSMT
   k/ECbVmUtcGGocZLYELowmsPY1YoZ7K6MEpnahx6RmuMnx5BF8W3qoNv1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320451021"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320451021"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111523"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111523"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:56 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 32/34] wifi: iwlwifi: mvm: free probe_resp_data later
Date:   Wed, 29 Mar 2023 10:05:38 +0300
Message-Id: <20230329100040.152b1715fc13.Ibd37fed1b24cd25012923ad9170d1fe33ab35c5c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In the MLD code, we free probe_resp_data before we remove
the MAC from the firmware, so we might receive another one
from the device after freeing, and thus might leak it. Fix
that by moving the free later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 4d56b2fc5f33..203f2513e7ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -159,12 +159,6 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 		mvm->csme_vif = NULL;
 	}
 
-	probe_data = rcu_dereference_protected(mvmvif->deflink.probe_resp_data,
-					       lockdep_is_held(&mvm->mutex));
-	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
-	if (probe_data)
-		kfree_rcu(probe_data, rcu_head);
-
 	if (mvm->bf_allowed_vif == mvmvif) {
 		mvm->bf_allowed_vif = NULL;
 		vif->driver_flags &= ~(IEEE80211_VIF_BEACON_FILTER |
@@ -207,6 +201,12 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 
 	RCU_INIT_POINTER(mvm->vif_id_to_mac[mvmvif->id], NULL);
 
+	probe_data = rcu_dereference_protected(mvmvif->deflink.probe_resp_data,
+					       lockdep_is_held(&mvm->mutex));
+	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
+	if (probe_data)
+		kfree_rcu(probe_data, rcu_head);
+
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		mvm->monitor_on = false;
 		__clear_bit(IEEE80211_HW_RX_INCLUDES_FCS, mvm->hw->flags);
-- 
2.38.1


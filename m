Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE456E42C7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDQImM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjDQImJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3F81FEE
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720927; x=1713256927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7CH2siJYuVCCNBRspq4jsHGBoE832W/0ITeZ78o1fac=;
  b=BIjByPcKTukXc3iFTcMqGrtPPdCMzmuqK/Ki3aH9jH1M3cpKvaaxJ2GJ
   2xDZLpNc8I1Kj5bvRBzcmz/BPQ+IhfAhAE6a7vrdzumlO7EKM0aR+p6Me
   hLn/e5QqW1zT4KciSExmTGWck7+w5T6y6YC1UVMAhNXiQgBB7lIwy3kju
   EMJLe0UoisBGocE0R8o9J+hS66OtLJMTtl1sw6WbYdC8Y9JoIlOWd3kBc
   CM1mmdme5T75nvc6KirSE6ZJgUFsOZT13ItXAEh8K55NZXoBvHUqydqQ6
   ZAk1hhrL5xhhper8P/IDL+B5BZeRDmRPHBrNAsRPM/st0WSIlE7IdlD8R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634318"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634318"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173808"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173808"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:41:57 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: mvm: use BSSID when building probe requests
Date:   Mon, 17 Apr 2023 11:41:22 +0300
Message-Id: <20230417113648.0be90360cad7.If279c28079a1db34280a824cee7c3f6545fd8b9e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

A long time, ago in commit 818965d39177 ("cfg80211: Allow a
scan request for a specific BSSID"), the stack started passing
the BSSID that should be scanned for. Use it in iwlwifi for the
intended optimisation, and to also allow the use of this for an
implementation sending multi-link probe requests.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 38b68827a4bd..1e20f9538640 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -98,6 +98,7 @@ struct iwl_mvm_scan_params {
 	bool scan_6ghz;
 	bool enable_6ghz_passive;
 	bool respect_p2p_go, respect_p2p_go_hb;
+	u8 bssid[ETH_ALEN] __aligned(2);
 };
 
 static inline void *iwl_mvm_get_scan_req_umac_data(struct iwl_mvm *mvm)
@@ -760,7 +761,7 @@ iwl_mvm_build_scan_probe(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	frame->frame_control = cpu_to_le16(IEEE80211_STYPE_PROBE_REQ);
 	eth_broadcast_addr(frame->da);
-	eth_broadcast_addr(frame->bssid);
+	ether_addr_copy(frame->bssid, params->bssid);
 	frame->seq_ctrl = 0;
 
 	pos = frame->u.probe_req.variable;
@@ -2801,6 +2802,7 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	params.pass_all = true;
 	params.n_match_sets = 0;
 	params.match_sets = NULL;
+	ether_addr_copy(params.bssid, req->bssid);
 
 	params.scan_plans = &scan_plan;
 	params.n_scan_plans = 1;
@@ -2894,6 +2896,7 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 	params.pass_all =  iwl_mvm_scan_pass_all(mvm, req);
 	params.n_match_sets = req->n_match_sets;
 	params.match_sets = req->match_sets;
+	eth_broadcast_addr(params.bssid);
 	if (!req->n_scan_plans)
 		return -EINVAL;
 
-- 
2.38.1


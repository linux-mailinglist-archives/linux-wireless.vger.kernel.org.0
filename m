Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4349E529D76
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244348AbiEQJIF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbiEQJHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:07:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E82B22517
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652778404; x=1684314404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dV+/fCo4yDPRxSJ3vGr0tb3zHuXYYXTeok5QnsfazUk=;
  b=D1mk2X+kAII2P4RJbnVYZJkdplVsp4BusJNGq7IhMMB8NRKQ6rvBmHzV
   D6CCAYGc020obyEta6MJzkexDvT/FTeJVJdLB0dnQfy6Ube7VHjQcE2Ps
   HZ16TvPpOLIROC4AWF6ryRBv7ooWL222t7bEE1W2y4nz1lT/bPze+wq33
   7xpQHfyc+FwHusY72kFZPoPty/SxvHH5rLJeRcPcWBgS/eqkkU/RbhIJ2
   cqj22myqH2xwdFwvEd+qrHhxXDuVVQNONJdfulQ/mMcvPoYFZtYg454td
   gGHTV1nc4nQsS3ZVfYbQ4ZFEFC17smzTZtmtyeUTuiZObSWrWO27PE8Jd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271064745"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271064745"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="741679707"
Received: from sgens-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.212.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:21 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/10] iwlwifi: mvm: clean up authorized condition
Date:   Tue, 17 May 2022 12:05:07 +0300
Message-Id: <20220517120044.41f528383a6b.I1cdf165581b781c53c8e6ac8779a2282b1f67c59@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We track in mvmvif->authorized when the AP STA becomes authorized
and no longer authorized, so we don't need the complex condition
with station lookup. Simplify the code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 23 +++----------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 5aa4520b70ac..e7f18f549ca9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -567,7 +567,6 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	if (vif->bss_conf.assoc && vif->bss_conf.dtim_period &&
 	    !force_assoc_off) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-		u8 ap_sta_id = mvmvif->ap_sta_id;
 		u32 dtim_offs;
 
 		/*
@@ -614,24 +613,8 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 		 * allow multicast data frames only as long as the station is
 		 * authorized, i.e., GTK keys are already installed (if needed)
 		 */
-		if (ap_sta_id < mvm->fw->ucode_capa.num_stations) {
-			struct ieee80211_sta *sta;
-
-			rcu_read_lock();
-
-			sta = rcu_dereference(mvm->fw_id_to_mac_id[ap_sta_id]);
-			if (!IS_ERR_OR_NULL(sta)) {
-				struct iwl_mvm_sta *mvmsta =
-					iwl_mvm_sta_from_mac80211(sta);
-
-				if (mvmsta->sta_state ==
-				    IEEE80211_STA_AUTHORIZED)
-					cmd.filter_flags |=
-						cpu_to_le32(MAC_FILTER_ACCEPT_GRP);
-			}
-
-			rcu_read_unlock();
-		}
+		if (mvmvif->authorized)
+			cmd.filter_flags |= cpu_to_le32(MAC_FILTER_ACCEPT_GRP);
 	} else {
 		ctxt_sta->is_assoc = cpu_to_le32(0);
 
-- 
2.35.1


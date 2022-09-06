Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987AE5AECFE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiIFOLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbiIFOJY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:09:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBAD8673E
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471993; x=1694007993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=62X+ntw2Zl4eAMvqexhE4PG72DyERaXLa7R+np6oI5o=;
  b=Y6ewPprlFW/3sxHtJAdhSqMu+cagpzrA/fBetW6g0OejwYHNIsjDvKid
   zW1zbx9klqfprVmwnaojgSLKprcSppHmrdsJPPA874BQGZJ26W5g3tZLY
   X4Ff5L0vLp/KD6RL1zHd2gTPqK0Bt28BlpmaGjVuIJHTyCnx6f84fI8bp
   MxugHlX29v2U+QUHxFzKZB3KayPUCcCM4AhwP+ybugVwU88Q5ANP3Wv9O
   SCOMvDVlKdEHsVz0b8JRsXPJlQ0qrQWf/dtsa7WkZER+9Vi22yhDd0PWG
   AfdBo+tdXaKRWSoVMEA5e3ciJQJdM/g/iG4JDuwzdEmWNsq/x9jvkhXAx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276989078"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276989078"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:45:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459965"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:58 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: iterate over interfaces after an assert in d3
Date:   Tue,  6 Sep 2022 16:42:18 +0300
Message-Id: <20220906161827.ad888cc6cd91.Ib56e416fce17df089edf76d22896430df5ebe080@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

In recent patches notifications based d3 resume flow was added,
and the resume flow was changed.

Currently, when resuming from d3 during which an assert was thrown,
the resume flow skips the iteration over active interfaces
preventing the sta to reconnect to the ap.

Perform the iteration in case an assert was thrown to fix it.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 012fe872d9aa..d8a67f391ab9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2555,7 +2555,7 @@ static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
  *	1. The mutex is already held.
  *	2. The callee functions unlock the mutex.
  */
-static void
+static bool
 iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif,
 				    struct iwl_d3_data *d3_data)
@@ -2581,12 +2581,9 @@ iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 			mvm->keep_vif = vif;
 #endif
 
-		if (!d3_data->test)
-			ieee80211_iterate_active_interfaces_mtx(mvm->hw,
-								IEEE80211_IFACE_ITER_NORMAL,
-								iwl_mvm_d3_disconnect_iter,
-								keep ? vif : NULL);
+		return keep;
 	}
+	return false;
 }
 
 #define IWL_WOWLAN_WAKEUP_REASON_HAS_WAKEUP_PKT (IWL_WOWLAN_WAKEUP_BY_MAGIC_PACKET | \
@@ -2863,6 +2860,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	bool d0i3_first = fw_has_capa(&mvm->fw->ucode_capa,
 				      IWL_UCODE_TLV_CAPA_D0I3_END_FIRST);
 	bool resume_notif_based = iwl_mvm_d3_resume_notif_based(mvm);
+	bool keep = false;
 
 	mutex_lock(&mvm->mutex);
 
@@ -2935,7 +2933,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	}
 
 query_wakeup_reasons:
-	iwl_mvm_choose_query_wakeup_reasons(mvm, vif, &d3_data);
+	keep = iwl_mvm_choose_query_wakeup_reasons(mvm, vif, &d3_data);
 	/* has unlocked the mutex, so skip that */
 	goto out;
 
@@ -2947,6 +2945,12 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	kfree(d3_data.status);
 	iwl_mvm_free_nd(mvm);
 
+	if (!d3_data.test && !mvm->net_detect)
+		ieee80211_iterate_active_interfaces_mtx(mvm->hw,
+							IEEE80211_IFACE_ITER_NORMAL,
+							iwl_mvm_d3_disconnect_iter,
+							keep ? vif : NULL);
+
 	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 
 	/* no need to reset the device in unified images, if successful */
-- 
2.35.3


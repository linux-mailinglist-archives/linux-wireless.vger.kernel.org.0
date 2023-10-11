Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567D57C4FBA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbjJKKJl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjJKKJC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:09:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1699195
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018885; x=1728554885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4tfEmY9OCD/myEiMa2J3W1rCJRFWM0zU1Pz3yrw5QhI=;
  b=UqV8vMHjEfTJYvGv4WdtZFS0X9vUYNTVnOheU0hWRkc0em7cn9PyhgK0
   1shVjZTjtzTVuxSNX/bh8tOy0A/HsOB0ghm8NSFulNRlh3Reby9sZu+ej
   tmpDb7nlGe19wNyJsRixuZvojVCxn2q5mzaGOQu4YJ9ZmUboOVxzdli2+
   bPRc8RQSZIw2nbk7cduPSvBNGsRWMm6W6V7Xi/j05Z2N2BR71AuZIyz1I
   D5lCfB/0vZIwtMSnkD4U0U3wm7CdUL6yt3w7+GlgsB/m7TxLN4Sv4D8Cx
   vRhX7mbQ7zfR85lsQqOf1AN1qPgdvIwISi5hRJb7ycnxHEQJRo6tUl4In
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670610"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670610"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050306"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050306"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:03 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/16] wifi: iwlwifi: mvm: fold the ref++ into iwl_mvm_phy_ctxt_add
Date:   Wed, 11 Oct 2023 13:07:25 +0300
Message-Id: <20231011130030.c19c07746b26.I5b0cbe0760811631a320218a10b88870b5bf0897@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we want to add a phy_ctxt, we need to increase the ref.
Note that all the WARN_ONs are already in place:
* We check that we don't add a context with ref != 0
* We check that we don't modify a context with ref = 0

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 --
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 20 ++++++++++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0d78a9efbe2f..d161e2ea1ac5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4716,7 +4716,6 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			goto out_unlock;
 		}
 
-		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
 		goto link_and_start_p2p_roc;
 	}
 
@@ -4812,7 +4811,6 @@ static int __iwl_mvm_add_chanctx(struct iwl_mvm *mvm,
 		goto out;
 	}
 
-	iwl_mvm_phy_ctxt_ref(mvm, phy_ctxt);
 	*phy_ctxt_id = phy_ctxt->id;
 out:
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index c3c1b57a05ce..8baf261888a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -265,6 +265,8 @@ int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 			 struct cfg80211_chan_def *chandef,
 			 u8 chains_static, u8 chains_dynamic)
 {
+	int ret;
+
 	WARN_ON(!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
 		ctxt->ref);
 	lockdep_assert_held(&mvm->mutex);
@@ -273,9 +275,16 @@ int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 	ctxt->width = chandef->width;
 	ctxt->center_freq1 = chandef->center_freq1;
 
-	return iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
-				      chains_static, chains_dynamic,
-				      FW_CTXT_ACTION_ADD);
+	ret = iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
+				     chains_static, chains_dynamic,
+				     FW_CTXT_ACTION_ADD);
+
+	if (ret)
+		return ret;
+
+	ctxt->ref++;
+
+	return 0;
 }
 
 /*
@@ -285,6 +294,11 @@ int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 void iwl_mvm_phy_ctxt_ref(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt)
 {
 	lockdep_assert_held(&mvm->mutex);
+
+	/* If we were taking the first ref, we should have
+	 * called iwl_mvm_phy_ctxt_add.
+	 */
+	WARN_ON(!ctxt->ref);
 	ctxt->ref++;
 }
 
-- 
2.38.1


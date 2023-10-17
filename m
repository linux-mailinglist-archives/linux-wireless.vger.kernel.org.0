Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5150B7CBEC8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbjJQJRi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343505AbjJQJRf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83787F9
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534253; x=1729070253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2423up6+XrnAJTfyV2+clcnazPWsPTSuqg8FGcMlrys=;
  b=mF2gn8qr1VRBv6WHLHLQHDtHcS+FHlH7KCWcqgakdgHvbV8O5sGvhliw
   /K6pb5uhftoPTZCqPp6DwG+M6wIzuhfvplxMBRo7jNrrIdcYLwMtFDytP
   kC29t2CIK9v/bYxdOk5eVchxRYvjDEpKFExPzB8FNdDRF01es7v6qGIqn
   vzQoU4shkE3BCYtPk0YfVJ5fYrgj2Ch6ClDQ/WoyLprA3Ma3jVzn6L61B
   JKGvLnsx4FdMDlbcR+IUot7mxpRCYg9T17xMyYv+ykQpnuzC+ZlsjxMFA
   X6tSSz708ADZssJ3OOLbV8LKS4SFI07Cn+QYLXpj0dbQ33OK8Vfpk/hwQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808569"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808569"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731975"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731975"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/14] wifi: iwlwifi: mvm: fix regdb initialization
Date:   Tue, 17 Oct 2023 12:16:49 +0300
Message-Id: <20231017115047.78b2c5b891b0.Iac49d52e0bfc0317372015607c63ea9276bbb188@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

In order to get regulatory domain, driver sends MCC_UPDATE_CMD to the
FW. One of the parameters in the response is the status which can tell
if the regdomain has changed or not.

When iwl_mvm_init_mcc() is called during iwl_op_mode_mvm_start(), then
sband is still NULL and channel parameters (i.e. chan->flags)  cannot be
initialized. When, further in the flow, iwl_mvm_update_mcc() is called
during iwl_mvm_up(), it first checks if the regdomain has changed and
then skips the update if it remains the same. But, since channel
parameters weren't initialized yet, the update should be forced in this
codepath. Fix that by adding a corresponding parameter to
iwl_mvm_init_fw_regd().

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 8 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c      | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 46ee280231ea..92c45571bd69 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -818,7 +818,7 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (ret)
 		IWL_ERR(mvm, "Failed to send quota: %d\n", ret);
 
-	if (iwl_mvm_is_lar_supported(mvm) && iwl_mvm_init_fw_regd(mvm))
+	if (iwl_mvm_is_lar_supported(mvm) && iwl_mvm_init_fw_regd(mvm, false))
 		IWL_ERR(mvm, "Failed to initialize D3 LAR information\n");
 
 	return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 28da98e75e52..bb330f1b5d9e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -186,7 +186,7 @@ struct ieee80211_regdomain *iwl_mvm_get_current_regdomain(struct iwl_mvm *mvm,
 				     MCC_SOURCE_OLD_FW, changed);
 }
 
-int iwl_mvm_init_fw_regd(struct iwl_mvm *mvm)
+int iwl_mvm_init_fw_regd(struct iwl_mvm *mvm, bool force_regd_sync)
 {
 	enum iwl_mcc_source used_src;
 	struct ieee80211_regdomain *regd;
@@ -213,8 +213,10 @@ int iwl_mvm_init_fw_regd(struct iwl_mvm *mvm)
 	if (IS_ERR_OR_NULL(regd))
 		return -EIO;
 
-	/* update cfg80211 if the regdomain was changed */
-	if (changed)
+	/* update cfg80211 if the regdomain was changed or the caller explicitly
+	 * asked to update regdomain
+	 */
+	if (changed || force_regd_sync)
 		ret = regulatory_set_wiphy_regd_sync(mvm->hw->wiphy, regd);
 	else
 		ret = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 81f7b0a644f9..760cebf22fee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2241,7 +2241,7 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 						  bool *changed);
 struct ieee80211_regdomain *iwl_mvm_get_current_regdomain(struct iwl_mvm *mvm,
 							  bool *changed);
-int iwl_mvm_init_fw_regd(struct iwl_mvm *mvm);
+int iwl_mvm_init_fw_regd(struct iwl_mvm *mvm, bool force_regd_sync);
 void iwl_mvm_update_changed_regdom(struct iwl_mvm *mvm);
 
 /* smart fifo */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 17a1e5717dde..c0dd441e800e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -573,7 +573,7 @@ int iwl_mvm_init_mcc(struct iwl_mvm *mvm)
 	 * try to replay the last set MCC to FW. If it doesn't exist,
 	 * queue an update to cfg80211 to retrieve the default alpha2 from FW.
 	 */
-	retval = iwl_mvm_init_fw_regd(mvm);
+	retval = iwl_mvm_init_fw_regd(mvm, true);
 	if (retval != -ENOENT)
 		return retval;
 
-- 
2.38.1


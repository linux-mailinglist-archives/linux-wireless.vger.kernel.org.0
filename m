Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0716E4C9E55
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 08:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbiCBH2K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 02:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbiCBH2J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 02:28:09 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CCE10D6
        for <linux-wireless@vger.kernel.org>; Tue,  1 Mar 2022 23:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646206044; x=1677742044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e5Y1raGdenCQtezNDRWOyXk6tYnim8ImIc1wnIMaU/8=;
  b=e3SudJjr8o7WVHJowIhb2XheV3hjJOq7Qd1ss+INlkWZ4PwIeg6JKU3p
   BCPeqSuEJy2GNQJ4YrpGFnOzl3GTsJDGsE3O1EYhHmRuUD+NLW3MGfUEJ
   EC+7/IXo9UWFzddVe6M5BBUfXPsyyJyFYcB4ViUK3FNowfUMQ6on1lpWi
   dOg+33mCu49Lz4/bz8fJ9VP1Jie62s9q8VDnA3bTOhhHhaIZbXByTdvXB
   OSv7RQ9txX7bsvwOX/l2ZsxheTsBTFdVjBqdlwwfs8lltvJRTi0EW+Tkh
   xkRF5+SBRtH9oJVpTgt/2hwY235NOJYSCulMXgDtyAzTqYitTi6oxxiRl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="236840331"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="236840331"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 23:27:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="709400755"
Received: from tbarkana-mobl2.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.255.193.154])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 23:27:22 -0800
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 5.17] iwlwifi: mvm: return value for request_ownership
Date:   Wed,  2 Mar 2022 09:27:15 +0200
Message-Id: <20220302072715.4885-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Propagate the value to the user space

Fixes: bfcfdb59b669 ("iwlwifi: mvm: add vendor commands needed for iwlmei")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c b/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
index 78450366312b..080a1587caa5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
@@ -71,12 +71,13 @@ static int iwl_mvm_vendor_host_get_ownership(struct wiphy *wiphy,
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	int ret;
 
 	mutex_lock(&mvm->mutex);
-	iwl_mvm_mei_get_ownership(mvm);
+	ret = iwl_mvm_mei_get_ownership(mvm);
 	mutex_unlock(&mvm->mutex);
 
-	return 0;
+	return ret;
 }
 
 static const struct wiphy_vendor_command iwl_mvm_vendor_commands[] = {
-- 
2.25.1


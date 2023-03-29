Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A586CD289
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjC2HHL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjC2HHH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4E63AB4
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073609; x=1711609609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r8BxuyyHOqc0CyM2WILHC+Cb+nOhCeSXeLzrGlI5Jqg=;
  b=AO7IDhb5VCCS9wK0SpbDp9oU9ssXpPwbIfpKC+un5x/rNqozxs8E/IAE
   tVZmhHKdxQj5ex4fDLPGNAJVkrJJLMO5Ld9ghUAG4jq1TNUAPiB7wepDs
   ABYUvwQDyxnYTcuD2omFreEG5/FwOkD+srmUxccMEdRWXJQIN+LQpwD0M
   ctJLgWbMArh906ZDhvMYK+BZVcC9wKYIPZwY2WEGkRNTisG84oe7fg0+q
   WlCMnYp+SWhYZnyeoGcV1BZXfaFCSJMGxhTd8ku5X1hTEl3wk+bLfy/3q
   juWK98ktHPj+ZNkHv06wWyk/RmaNCz7hVrHx0oVDoa6mFyq938vkSwiz0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450763"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450763"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111232"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111232"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:07 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/34] wifi: iwlwifi: mvm: make a few warnings only trigger once
Date:   Wed, 29 Mar 2023 10:05:13 +0300
Message-Id: <20230329100039.f333741d3dcf.If063d4cfe8a583f0f980a1b0ae4e63e17ba4ddc9@changeid>
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

We're hitting these while starting to enable MLO in the
driver, but getting them each and every time isn't very
useful one way or the other. Make these warnings trigger
only once.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 294e1c1de6b6..2b2221d7582b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5591,7 +5591,7 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			continue;
 
 		/* make sure only TDLS peers or the AP are flushed */
-		WARN_ON(i != mvmvif->deflink.ap_sta_id && !sta->tdls);
+		WARN_ON_ONCE(i != mvmvif->deflink.ap_sta_id && !sta->tdls);
 
 		if (drop) {
 			if (iwl_mvm_flush_sta(mvm, mvmsta, false))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 154f145396ce..aa8b4fb9c201 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -213,8 +213,8 @@ void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 	u32 sec_key_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
 	u8 sec_key_ver = iwl_fw_lookup_cmd_ver(mvm->fw, sec_key_id, 0);
 
-	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION ||
-		    mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON_ONCE(vif->type != NL80211_IFTYPE_STATION ||
+			 mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA))
 		return;
 
 	if (!sec_key_ver)
-- 
2.38.1


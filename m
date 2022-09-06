Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A235AEC18
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbiIFOFP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiIFOER (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:04:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA0222BE5
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471897; x=1694007897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52D2F/yHOk+iTcQqICjsrT1eKWDPzyaGsuGa54hUkHQ=;
  b=irBfpWYkeWVspkYfQGwqYprOZFEfIo3V3l2uZEqdYARgqJtEPjJ7cf3V
   bis8ceO9o38+RNThXZnCjKZyt6pyAPVYFU4wm16s47pYv6YpyLhLb0zXh
   SxqqhntCCLLpZaNpKMZB7xhmuih5FB2tvdtRgn4V3lmDew3440Z20sx6e
   OtoNqXHqbGk7uHaBCXpTNROakbqdn3D6PY2BYgfZjUZebr9hcALILtWui
   mrQ1+tsDhK81NcEYOdnYDke5HE4CGXGRTHapUEHWi4DVzk0gEF3P78Q06
   rq0fu30N7lYcUIbtHP4Ftr1D+qpZSK6P9CDesAN7GY3j6QuAliD8DCK96
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276332709"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276332709"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459646"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:24 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: refactor iwl_mvm_set_sta_rate() a bit
Date:   Tue,  6 Sep 2022 16:42:09 +0300
Message-Id: <20220906161827.623e32931b67.Id743a7879e84ae37a849179e536c58b1bf55380f@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Use a switch statement over the rate type instead of the
if chain, to simplify.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5eb28f8ee87e..735d5ed412d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4949,6 +4949,7 @@ static int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 {
 	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+	u32 gi_ltf;
 
 	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
 	case RATE_MCS_CHAN_WIDTH_20:
@@ -5019,9 +5020,12 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 		RATE_HT_MCS_INDEX(rate_n_flags) :
 		u32_get_bits(rate_n_flags, RATE_MCS_CODE_MSK);
 
-	if (format == RATE_MCS_HE_MSK) {
-		u32 gi_ltf = u32_get_bits(rate_n_flags,
-					  RATE_MCS_HE_GI_LTF_MSK);
+	if (rate_n_flags & RATE_MCS_SGI_MSK)
+		rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+	switch (format) {
+	case RATE_MCS_HE_MSK:
+		gi_ltf = u32_get_bits(rate_n_flags, RATE_MCS_HE_GI_LTF_MSK);
 
 		rinfo->flags |= RATE_INFO_FLAGS_HE_MCS;
 
@@ -5060,19 +5064,14 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 
 		if (rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK)
 			rinfo->he_dcm = 1;
-		return;
-	}
-
-	if (rate_n_flags & RATE_MCS_SGI_MSK)
-		rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
-
-	if (format == RATE_MCS_HT_MSK) {
+		break;
+	case RATE_MCS_HT_MSK:
 		rinfo->flags |= RATE_INFO_FLAGS_MCS;
-
-	} else if (format == RATE_MCS_VHT_MSK) {
+		break;
+	case RATE_MCS_VHT_MSK:
 		rinfo->flags |= RATE_INFO_FLAGS_VHT_MCS;
+		break;
 	}
-
 }
 
 static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
-- 
2.35.3


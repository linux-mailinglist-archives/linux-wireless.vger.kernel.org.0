Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C209063454A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 21:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiKVULr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 15:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiKVULl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 15:11:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0028EB4F0B
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 12:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669147897; x=1700683897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QBIYFnMQFFPMhIsuqqzsXoF3HXKBoVOcLPx9YjcMeNU=;
  b=CgfCBkXGjhmGH5YkSJr1aRs9YFNy+BmogtCRXArYzFEh7p9dreiIyMIc
   vTO/5ulx+ehq3E6VBcrH9MuLndRHI55kmgq+BVqgc6sE6cSV9f5rTUmqM
   i+XrKnVs6A+0CTPIAsxGzr3l0oH2QV7lnaA/jQjvfx5tfEKv3ysLJfBvy
   LKUQI/nyqxg+rbNmA33gSJr85jJoh2bef5zSkjY7B3SNbqHKv4bSwjaPa
   UKbC87B7pQ3YKhY35aOxiqRf/4fABWN3nJ1NtdiC2i91aOeDcPfY9z0v+
   ZbfaYUz6wEvm/NfY9YQscj508EzVRotc14jhqPjxr30ymnPwBcq5Duuec
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="378163500"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="378163500"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:11:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747487129"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747487129"
Received: from mkoshili-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.209.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:11:35 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 7/9] wifi: iwlwifi: mvm: advertise 320 MHz in 6 GHz only conditionally
Date:   Tue, 22 Nov 2022 22:10:38 +0200
Message-Id: <20221122220713.293ef3e5a1c4.I867526a6bd3f93ee50076ff359436dfb5ec6101c@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221122201040.2618863-1-gregory.greenman@intel.com>
References: <20221122201040.2618863-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We can't have it in AP mode unless for debug, since we don't have
160 MHz in HE PHY capabilities, and also set it only in 6 GHz even
if (unlike in HE) it's always defined.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index e83382ded8af..b59e61a76b70 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -873,6 +873,10 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
 		break;
 	case NL80211_BAND_6GHZ:
+		if (!is_ap || iwlwifi_mod_params.nvm_file)
+			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[0] |=
+				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+		fallthrough;
 	case NL80211_BAND_5GHZ:
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] |=
 			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
-- 
2.35.3


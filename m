Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B0163454B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiKVULt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 15:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiKVULo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 15:11:44 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E63B0414
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 12:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669147901; x=1700683901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PY8vHTd2YLpK4p9wP+wSQIDlc0bD1r5f1J9WKL+k7bk=;
  b=E6WHckTry5R9DihpeQ3LlqOmTuFysC4xKGdFBO3jnKCP80q5s5+yCs+D
   bHUWBPYVjmVWYLQXIfccjCMFokc3T1pAAr0X3GwlMgbERfOlkS74dJdVU
   Upn0n06+s7pFJO5sItNMb7RH6o9KEFKBOKF5X126556Dq5I70wZr2woVh
   GwKJo+IJsOlpcO5D1gQOJRa+60Fjp9u9hGSK0g31jrLraP2coO5i1epLc
   /YjwG8pidJN+/J7YK+rhmEumBZcX0Ed5UBb7S/5l1+D+5YOG5l6d++rzp
   duNe7kIjQJd4prtUUuHq+n8oEdwsXCwQhzDjpCacbvCR91vibAywW8HWe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="378163511"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="378163511"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:11:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747487165"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747487165"
Received: from mkoshili-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.209.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:11:38 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 8/9] wifi: iwlwifi: nvm-parse: support A-MPDU in EHT 2.4 GHz
Date:   Tue, 22 Nov 2022 22:10:39 +0200
Message-Id: <20221122220713.3e7449760415.Id394d7fd0acaca48d429feccda4e66dbadaab993@changeid>
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

We support large A-MPDU in EHT in 2.4 GHz, so add the right
bits for that in the EHT capabilities.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index b59e61a76b70..3a646bce7b42 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -871,6 +871,9 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	case NL80211_BAND_2GHZ:
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] |=
 			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+		iftype_data->eht_cap.eht_cap_elem.mac_cap_info[0] |=
+			u8_encode_bits(IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454,
+				       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
 		break;
 	case NL80211_BAND_6GHZ:
 		if (!is_ap || iwlwifi_mod_params.nvm_file)
-- 
2.35.3


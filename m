Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A89631558
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 18:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKTRB5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 12:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKTRBs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 12:01:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE01E2C135
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 09:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668963706; x=1700499706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PY8vHTd2YLpK4p9wP+wSQIDlc0bD1r5f1J9WKL+k7bk=;
  b=DpgL1Od3nQX2sHK6BInba7OdCPV5syJwLLRqM42EoO6wnKjlFxuM/d6M
   u77LZzqKE510ZoR61ksbHAMjV6/bofJ5q1E/v3hHLghOD8vKrhysGTjab
   4ViZxngLgZcRFD95azWbzuccrwJCS3Tovwneg+zYCZZXdZRK8klqXorN+
   rG826hHnpMweRqXN0B1u9H2dLozyyeyfj5LrbWehsbU24+VP95Ydy2BZ1
   ts8feCuu8pLQI3OQcTAwJkeXWlsh589IWLYV8BLedsKSI+h9Kso6MhNSc
   vK4oF1d2oOkDBTh+1rvxdESoQngdSKu2qslQPN3nmFUTKwDflSLmpH2d8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315234911"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="315234911"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765719533"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="765719533"
Received: from dwiener-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.87.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:44 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 8/9] wifi: iwlwifi: nvm-parse: support A-MPDU in EHT 2.4 GHz
Date:   Sun, 20 Nov 2022 19:00:38 +0200
Message-Id: <20221120185147.55addb264f95.Id394d7fd0acaca48d429feccda4e66dbadaab993@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221120170039.1788067-1-gregory.greenman@intel.com>
References: <20221120170039.1788067-1-gregory.greenman@intel.com>
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


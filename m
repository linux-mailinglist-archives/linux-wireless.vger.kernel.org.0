Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A0F631557
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 18:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKTRBy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 12:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKTRBp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 12:01:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8152B25D
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 09:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668963704; x=1700499704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QBIYFnMQFFPMhIsuqqzsXoF3HXKBoVOcLPx9YjcMeNU=;
  b=Jj+BIjeJ7GWwkEh+wXJ0enkqhwXSTE8rCzyS/mwi32qaQc53dieWt19h
   frtzaBx8CL8Q+FkD12jSkR+FSnhLtRf3/GfZahP78MY+HFf1rvsR9AoJL
   0p5LMKtivCRcfF/8G/8RYN/q8eKpyo3VFbzTKTgF/ySBCFa2snGnVOB0W
   3qkBy+j+LwANUvA3donxReZtsXeHIYxOl5VD7lioSJpb4aVsCbNxubSfp
   +tpxFQVACuyp6Gld3sKvvD9q432bUyi95sA5bTQ6/fziZ3bGkL5frCLAs
   eTZbMZ7HsLFozNi+JrqmR9Z8GoBX4I7QHM9JIH3u1HGUEhtWlcopQ9tqL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315234903"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="315234903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765719517"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="765719517"
Received: from dwiener-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.87.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:42 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 7/9] wifi: iwlwifi: mvm: advertise 320 MHz in 6 GHz only conditionally
Date:   Sun, 20 Nov 2022 19:00:37 +0200
Message-Id: <20221120185147.27cfb3327635.I867526a6bd3f93ee50076ff359436dfb5ec6101c@changeid>
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


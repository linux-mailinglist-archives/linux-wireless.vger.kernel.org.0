Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D16E0801
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDMHpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjDMHpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63D6199
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371913; x=1712907913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Er4LdcfhFx8vpr4ObBAOHcIRq2uJNilvhXMAcAvFWJ4=;
  b=L00rXONM5y+KrJfcBUUVlAw/ZAVIosCjR4k6XFBpdSqNFYRGveLAv41F
   KxH8RUl8sr87AFoELsAHohPWQX318X56Xv0E0OfepDx7591s4/TmojuOT
   lkLqtraE1y3HjdLEZI5RL2V6I4sPEiankzNCpFfzjQ4ldNlNYvkSXW4kX
   lanpaLeV1bG11BQy5Jlk0uJGxeidurxnF2K57KgmBB0cVC4v1tkV6cW8v
   9aqpsgJP8mYouqR7dTk3ZfQR44aQq53bVfV2vQ1V3SaQ7oDoTAerBCl2Q
   2KJgKjrAhQuOmjT5MqKtsic4rIpkddyymsbD4uY1cgD4NpcmHXKv8g8M9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323735931"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323735931"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034690"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034690"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:12 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: nvm-parse: enable 160/320 MHz for AP mode
Date:   Thu, 13 Apr 2023 10:44:02 +0300
Message-Id: <20230413102635.ed04de3a2833.Ie3991179dfaf24880b96a0904a625dbf6b8fd579@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Initially, 160/320 MHz in AP mode were not supported.
After testing, enable the wider bandwidths in AP mode
as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 923bbfc151dd..449a1922a215 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -876,16 +876,13 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 				       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
 		break;
 	case NL80211_BAND_6GHZ:
-		if (!is_ap || iwlwifi_mod_params.nvm_file)
-			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[0] |=
-				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[0] |=
+			IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 		fallthrough;
 	case NL80211_BAND_5GHZ:
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] |=
-			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
-		if (!is_ap || iwlwifi_mod_params.nvm_file)
-			iftype_data->he_cap.he_cap_elem.phy_cap_info[0] |=
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 		break;
 	default:
 		WARN_ON(1);
-- 
2.38.1


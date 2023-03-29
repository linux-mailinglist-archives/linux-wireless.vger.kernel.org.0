Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55A6CD281
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjC2HGY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjC2HGU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:06:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C16140EA
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073558; x=1711609558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ZpGtJ9v6cISMFUMRXDUDRt8D9NtY/oFieMgJvIQnYI=;
  b=lmLAUB0WOs+SBASb/3AgAVjHrUya7U+2StcAfL79lAO3AUZOFeMoo5e8
   crAIF2GrkyF400+66WxV5FEPK24ApL40vboT+m3bSXPROcCRPOHHqxVmn
   46Ydeaw9eXz4izltyOHW2oFXs9/UvnMwlMu5AIGqI54iYGP+jW6aWrpYD
   M3XFTp1aF/7AgqivTnGGmBrChp1yMGhZ99k6j6Mw03uCv/Fp3hxmWF3VT
   2JbaFd7XF4OXINTcnMWKiIXgp+V007oOEQcu/idNJf8gekF4tZvo0Ts3T
   FeU6Fpowa9exlUAzoBFdB3TU/lvUKbJjOkvNRsimz5tk4/tLmi7+TJ0bh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450692"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450692"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111130"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111130"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:05:56 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/34] wifi: iwlwifi: mvm: fix narrow RU check for MLO
Date:   Wed, 29 Mar 2023 10:05:08 +0300
Message-Id: <20230329100039.0347fa77d522.Ibdf7a40cbe86e64ce086f243330fc27f43aeb3aa@changeid>
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

This needs to apply to the link, not deflink.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c76c6b1f0218..9eb95ed48d02 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3392,20 +3392,27 @@ static void iwl_mvm_check_he_obss_narrow_bw_ru_iter(struct wiphy *wiphy,
 	rcu_read_unlock();
 }
 
-static void iwl_mvm_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
-					       struct ieee80211_vif *vif)
+static void
+iwl_mvm_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   unsigned int link_id,
+				   struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_he_obss_narrow_bw_ru_data iter_data = {
 		.tolerated = true,
 	};
 
-	if (!(vif->bss_conf.chandef.chan->flags & IEEE80211_CHAN_RADAR)) {
-		mvmvif->deflink.he_ru_2mhz_block = false;
+	if (WARN_ON_ONCE(!link_conf->chandef.chan ||
+			 !mvmvif->link[link_id]))
+		return;
+
+	if (!(link_conf->chandef.chan->flags & IEEE80211_CHAN_RADAR)) {
+		mvmvif->link[link_id]->he_ru_2mhz_block = false;
 		return;
 	}
 
-	cfg80211_bss_iter(hw->wiphy, &vif->bss_conf.chandef,
+	cfg80211_bss_iter(hw->wiphy, &link_conf->chandef,
 			  iwl_mvm_check_he_obss_narrow_bw_ru_iter,
 			  &iter_data);
 
@@ -3413,7 +3420,7 @@ static void iwl_mvm_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
 	 * If there is at least one AP on radar channel that cannot
 	 * tolerate 26-tone RU UL OFDMA transmissions using HE TB PPDU.
 	 */
-	mvmvif->deflink.he_ru_2mhz_block = !iter_data.tolerated;
+	mvmvif->link[link_id]->he_ru_2mhz_block = !iter_data.tolerated;
 }
 
 static void iwl_mvm_reset_cca_40mhz_workaround(struct iwl_mvm *mvm,
@@ -3615,7 +3622,8 @@ static void iwl_mvm_vif_set_he_support(struct ieee80211_hw *hw,
 		if (is_sta) {
 			mvmvif->link[i]->he_ru_2mhz_block = false;
 			if (link_sta->he_cap.has_he)
-				iwl_mvm_check_he_obss_narrow_bw_ru(hw, vif);
+				iwl_mvm_check_he_obss_narrow_bw_ru(hw, vif, i,
+								   link_conf);
 		}
 	}
 }
-- 
2.38.1


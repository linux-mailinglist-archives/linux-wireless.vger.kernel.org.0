Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEEB6CD280
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjC2HGU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjC2HGN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:06:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413AF40C9
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073556; x=1711609556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=no8izANkEYWi4aRfVAwbaC1WRf2S58nyJoM7CR+Zkco=;
  b=HQ04IAehgrOHlw1HnJq6YLO5fdiAmvpmB5m+KPvG9TW2A4UyI3DRNSOW
   /QGzqDndW673RqEOWz3DWkBLVDswfga5/6tFP/fylYEXcFTmDhYfj9j7y
   tOZKp4Nc8DRVMVVIF/rcQEv9qGE34E3Yu3o9juaQsGifwsqrDhi26vEHA
   Ry1Zy3/Ci18pDVJ5B9xYnE/RELDAXPReexCh4tB95Rzx+FXKi+snZ+fEC
   ZGPstB8dNsR2kPzOSCJ/AgQfQCVaBfsPD6muADeY/c+jvqMRf+6Mv3bEF
   K1qcbZgF51WV7LB6mlqa2OJa6MCMF0gzHsn5tglI8No1Drsa67vON7V/t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450684"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450684"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111115"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111115"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:05:54 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/34] wifi: iwlwifi: mvm: make some HW flags conditional
Date:   Wed, 29 Mar 2023 10:05:07 +0300
Message-Id: <20230329100039.28ec631487bf.I6eb27c3d4c0289a5ec3682f573aae3424f45619f@changeid>
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

With newer MLD firmware API we no longer need beacon timing
information from the host, so disable TIMING_BEACON_ONLY.

If MLO is enabled (currently only for testing), then we must
not have DEAUTH_NEED_MGD_TX_PREP because mac80211 doesn't
support it yet, we'll have to fix that later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c60aff0df801..c76c6b1f0218 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -291,17 +291,28 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
-	ieee80211_hw_set(hw, TIMING_BEACON_ONLY);
 	ieee80211_hw_set(hw, CONNECTION_MONITOR);
 	ieee80211_hw_set(hw, CHANCTX_STA_CSA);
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, NEEDS_UNIQUE_STA_ADDR);
-	ieee80211_hw_set(hw, DEAUTH_NEED_MGD_TX_PREP);
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	ieee80211_hw_set(hw, BUFF_MMPDU_TXQ);
 	ieee80211_hw_set(hw, STA_MMPDU_TXQ);
+
+	/* With MLD FW API, it tracks timing by itself,
+	 * no need for any timing from the host
+	 */
+	if (!mvm->mld_api_is_used)
+		ieee80211_hw_set(hw, TIMING_BEACON_ONLY);
+
+	/* We should probably have this, but mac80211
+	 * currently doesn't support it for MLO.
+	 */
+	if (!(hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO))
+		ieee80211_hw_set(hw, DEAUTH_NEED_MGD_TX_PREP);
+
 	/*
 	 * On older devices, enabling TX A-MSDU occasionally leads to
 	 * something getting messed up, the command read from the FIFO
-- 
2.38.1


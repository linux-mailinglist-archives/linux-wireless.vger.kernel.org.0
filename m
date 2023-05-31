Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850817187D1
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjEaQvm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjEaQvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B44132
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551900; x=1717087900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tgBySgEV6wO14tBDNpJ3NT9E/EPCPboQMS+K8ZGKIbA=;
  b=WkwF3xGA+yXcsQb7wKrpQLcecsZMzmw7MYRXKFDNHbyekxqtv7V5UvFy
   m+QwLVhgs2yjIx5K/r16JApsBUmgHxHn3poMQwpccy0/kCRf3142W1s6M
   5bqg9jM7WQNfVdhEH98PNxI7fPER7k195pcSDWYfrYoQ60r0jf7XmPa4l
   U36xP73ktDUIzd+DmrdLniraLCMcPDAuZCK8/GxJwA5eBsiE2gE5KW7Kd
   O4YHLcPAQUyXVNzXAU19HvGLuPayzOKOjiKMAicIHWYY7T2XRHC98fKKR
   hQwLHGtJX1xep+fxIAwUsGa1bpIl7SJgnMAWURlI1JoztqEuA5y9lTtR1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890619"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890619"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987984"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987984"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:44 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/14] wifi: iwlwifi: mvm: tell firmware about per-STA MFP enablement
Date:   Wed, 31 May 2023 19:50:02 +0300
Message-Id: <20230531194629.4863db2ad382.I1b46b751d5808e65ea3d0e7b8b38209c5aecf042@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531165006.273284-1-gregory.greenman@intel.com>
References: <20230531165006.273284-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Indicate to the firmware for each station whether or not MFP
is used with this station. Note that we indicate MFP for it
before authorized since we don't know yet, and that will make
the firmware not handle should-be-protected management frames
without being able to check them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h     | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 42de95a22784..319ab4d7188e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -464,6 +464,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_SCAN_DONT_TOGGLE_ANT         = (__force iwl_ucode_tlv_capa_t)111,
 	IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT	= (__force iwl_ucode_tlv_capa_t)112,
 	IWL_UCODE_TLV_CAPA_OFFLOAD_REJ_BTM_SUPPORT	= (__force iwl_ucode_tlv_capa_t)113,
+	IWL_UCODE_TLV_CAPA_STA_EXP_MFP_SUPPORT		= (__force iwl_ucode_tlv_capa_t)114,
 
 #ifdef __CHECKER__
 	/* sparse says it cannot increment the previous enum member */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 401f94bd1f9c..659bd6327cdf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -442,6 +442,11 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	if (mvm_sta->sta_state >= IEEE80211_STA_ASSOC)
 		cmd.assoc_id = cpu_to_le32(sta->aid);
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_STA_EXP_MFP_SUPPORT) &&
+	    (sta->mfp || mvm_sta->sta_state < IEEE80211_STA_AUTHORIZED))
+		cmd.mfp = cpu_to_le32(1);
+
 	switch (link_sta->rx_nss) {
 	case 1:
 		cmd.mimo = cpu_to_le32(0);
-- 
2.38.1


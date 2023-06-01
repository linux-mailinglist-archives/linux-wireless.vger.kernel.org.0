Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36231719395
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 08:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjFAGxY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 02:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFAGxX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 02:53:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393DE7
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 23:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685602402; x=1717138402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CoHhN4Dih1PdpGLnACE57A225oMvgU8wD2Or3LLe44M=;
  b=jj1Q8LQ6ePFz884DWAD0wTlrSGh+jC/cQ+UoxmW1F4lh9DRvAP2j2NhX
   p85hZW7yovoZOjjFBDlTctqGQ675SzyktPNvYIym/c1SQnEaujRyYKCvj
   q3ZPWiYNKklCir1rDZQ8zpv6KWTJTvGF3VtEa0uW3c2VC6RHtUkkl51Yd
   XRSR1uvHQ09QvSoguPUOV7Gg0TfAQNOJKEvCo5HSiGXr3/cpII/E7lu67
   J3+pMPdqJ93B6S0FcehOSz0rPqJEQ9QZB46d6qFGR5DhI2hiVHYDMu/gL
   XEMRKS04k43bZIQHb0FMgfoQTGJ99LqUTSpa0KJs/Jbq1NQwlU0FT8+sr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="340071731"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="340071731"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 23:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="701425718"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="701425718"
Received: from dvinnyc-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.93.27])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 23:53:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 10/14] wifi: iwlwifi: mvm: tell firmware about per-STA MFP enablement
Date:   Thu,  1 Jun 2023 09:52:46 +0300
Message-Id: <20230601095201.b1052f39af4c.I1b46b751d5808e65ea3d0e7b8b38209c5aecf042@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/net/wireless/intel/iwlwifi/fw/file.h     |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

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
index 401f94bd1f9c..b3296aa65f20 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -71,6 +71,11 @@ static int iwl_mvm_mld_add_int_sta_to_fw(struct iwl_mvm *mvm,
 
 	cmd.station_type = cpu_to_le32(sta->type);
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_STA_EXP_MFP_SUPPORT) &&
+	    sta->type == STATION_TYPE_BCAST_MGMT)
+		cmd.mfp = cpu_to_le32(1);
+
 	if (addr) {
 		memcpy(cmd.peer_mld_address, addr, ETH_ALEN);
 		memcpy(cmd.peer_link_address, addr, ETH_ALEN);
@@ -442,6 +447,11 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
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


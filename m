Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3FC6623D9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 12:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjAILH6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 06:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjAILHz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 06:07:55 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23679C7F
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 03:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673262474; x=1704798474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c7jQUZdkDunEJxBTew9IwU3qIN/Rn6dYJ+oB+VHPjNU=;
  b=XoiSC+GAXLLqClAWdoh9suypRCSDNIrHBrbglCyIwRSXCylFh+R8Z8cO
   ptfgxI7JVz6M0mk825z7SN9sZBpT7uRh22ucZAkPufQa5qw/fwVIuvFEw
   3yuHKC/G1RqScGBt6QnV4550ewL8NMHzH8+5QJq+HdVSxVCs73yLiec2l
   ICbzOG3QDx0J1AGqwZICVNe1bLvn1IfBqrpAkaFkvyGuCUK8KA1N+BTMC
   GreDPhwZT3u1jz+jEWQz0PLUOwmUcZiyWmoyxz40pkoByP9vINDQUrT+o
   oQGLG0LvUttb0Fz+444lS+h8mHANA3X0C2Z8srbGE+cNo6dtgYPsrm3Io
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="387296451"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="387296451"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:07:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="689003136"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="689003136"
Received: from djacobi-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.191.194])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:07:52 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/2] iwlwifi: mvm: add minimal EHT rate reporting
Date:   Mon,  9 Jan 2023 13:07:22 +0200
Message-Id: <20230109130329.5f34d73d1f74.Ib27ae7bd23bc152d61021fd73aabdc76679b9fe4@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230109110722.212758-1-gregory.greenman@intel.com>
References: <20230109110722.212758-1-gregory.greenman@intel.com>
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

Now with all the prework, this is fairly simple, just report the
new bandwidth and RX_ENC_EHT type in RX, and for now just do a
minimal report of the EHT TLC rate in iwl_mvm_set_sta_rate().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 7 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5273ade71117..565522466eba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5116,6 +5116,9 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 	case RATE_MCS_CHAN_WIDTH_160:
 		rinfo->bw = RATE_INFO_BW_160;
 		break;
+	case RATE_MCS_CHAN_WIDTH_320:
+		rinfo->bw = RATE_INFO_BW_320;
+		break;
 	}
 
 	if (format == RATE_MCS_CCK_MSK ||
@@ -5176,6 +5179,10 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 		rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
 
 	switch (format) {
+	case RATE_MCS_EHT_MSK:
+		/* TODO: GI/LTF/RU. How does the firmware encode them? */
+		rinfo->flags |= RATE_INFO_FLAGS_EHT_MCS;
+		break;
 	case RATE_MCS_HE_MSK:
 		gi_ltf = u32_get_bits(rate_n_flags, RATE_MCS_HE_GI_LTF_MSK);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 97b67270f384..a6f0aed5a815 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1690,6 +1690,9 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 	case RATE_MCS_CHAN_WIDTH_160:
 		rx_status->bw = RATE_INFO_BW_160;
 		break;
+	case RATE_MCS_CHAN_WIDTH_320:
+		rx_status->bw = RATE_INFO_BW_320;
+		break;
 	}
 
 	/* must be before L-SIG data */
@@ -1726,6 +1729,9 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 		rx_status->he_dcm =
 			!!(rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK);
 		break;
+	case RATE_MCS_EHT_MSK:
+		rx_status->encoding = RX_ENC_EHT;
+		break;
 	}
 
 	switch (format) {
@@ -1736,6 +1742,7 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 		break;
 	case RATE_MCS_VHT_MSK:
 	case RATE_MCS_HE_MSK:
+	case RATE_MCS_EHT_MSK:
 		rx_status->nss =
 			u32_get_bits(rate_n_flags, RATE_MCS_NSS_MSK) + 1;
 		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
-- 
2.38.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90AA67D88A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjAZWgn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjAZWgh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED443298DA
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772595; x=1706308595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5nBjJnY1edsbG886PCganggYQaEvPD9Whs4sJhiy+xk=;
  b=O+ikbQrnwn+1/LTJn4vZRYTNjH6yYVzYirvaf9wJuht437UAuzU3W6Zi
   /KMpu9xFJm4l8onKDS0tMvSYp1+LXQnHRIjUsxl2WBojGvMv8n+f/htew
   cp4llsDaoytayCkazmbMtE20leBcljPIy8AS2fgMq5qBPJnlVYj9INgDT
   9utTbyOY5w4qMaqQmYpUImFof5lvrAAHZ3E4IlVh9aaUJbQtOjwuvDTo5
   JKYzpAmBXre5+vtKoGJEU2somZKYl9h6IruuzhmRor6qHnYu/6gSnREaV
   jTTWvpajsyXTwW6C+Zgsa92RiBpiqF1vUgjJbSD/sCQCiKvp2Z8jC1Jls
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098637"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098637"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986240"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986240"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:09 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/12] wifi: iwlwifi: mvm: remove h from printk format specifier
Date:   Fri, 27 Jan 2023 00:28:13 +0200
Message-Id: <20230127002430.a25158d58fd7.Ibfe217f12a63c1d5349218e74c4b802c70c13c7c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
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

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
  unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 1ce9450e5add..85b99316d029 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -324,12 +324,12 @@ static ssize_t iwl_dbgfs_sar_geo_profile_read(struct file *file,
 		pos += scnprintf(buf + pos, bufsz - pos,
 				 "Use geographic profile %d\n", tbl_idx);
 		pos += scnprintf(buf + pos, bufsz - pos,
-				 "2.4GHz:\n\tChain A offset: %hhu dBm\n\tChain B offset: %hhu dBm\n\tmax tx power: %hhu dBm\n",
+				 "2.4GHz:\n\tChain A offset: %u dBm\n\tChain B offset: %u dBm\n\tmax tx power: %u dBm\n",
 				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[0].chains[0],
 				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[0].chains[1],
 				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[0].max);
 		pos += scnprintf(buf + pos, bufsz - pos,
-				 "5.2GHz:\n\tChain A offset: %hhu dBm\n\tChain B offset: %hhu dBm\n\tmax tx power: %hhu dBm\n",
+				 "5.2GHz:\n\tChain A offset: %u dBm\n\tChain B offset: %u dBm\n\tmax tx power: %u dBm\n",
 				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[1].chains[0],
 				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[1].chains[1],
 				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[1].max);
@@ -1069,7 +1069,7 @@ iwl_dbgfs_scan_ant_rxchain_read(struct file *file,
 		pos += scnprintf(buf + pos, bufsz - pos, "A");
 	if (mvm->scan_rx_ant & ANT_B)
 		pos += scnprintf(buf + pos, bufsz - pos, "B");
-	pos += scnprintf(buf + pos, bufsz - pos, " (%hhx)\n", mvm->scan_rx_ant);
+	pos += scnprintf(buf + pos, bufsz - pos, " (%x)\n", mvm->scan_rx_ant);
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 6eee3d0b2157..05f3136b1c43 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1206,7 +1206,7 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	}
 
 	IWL_DEBUG_INFO(mvm, "Range response received\n");
-	IWL_DEBUG_INFO(mvm, "request id: %lld, num of entries: %hhu\n",
+	IWL_DEBUG_INFO(mvm, "request id: %lld, num of entries: %u\n",
 		       mvm->ftm_initiator.req->cookie, num_of_aps);
 
 	for (i = 0; i < num_of_aps && i < IWL_MVM_TOF_MAX_APS; i++) {
@@ -1298,7 +1298,7 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 		if (fw_has_api(&mvm->fw->ucode_capa,
 			       IWL_UCODE_TLV_API_FTM_RTT_ACCURACY))
-			IWL_DEBUG_INFO(mvm, "RTT confidence: %hhu\n",
+			IWL_DEBUG_INFO(mvm, "RTT confidence: %u\n",
 				       fw_ap->rttConfidence);
 
 		iwl_mvm_debug_range_resp(mvm, i, &result);
-- 
2.38.1


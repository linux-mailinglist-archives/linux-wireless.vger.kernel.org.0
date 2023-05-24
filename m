Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C586170FD00
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjEXRqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjEXRpy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:45:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144D6135
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950318; x=1716486318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PqtcsslFkkVNO7nrIn1NxBzz1jUiP1SwibqK0cqnKLU=;
  b=Q6o2eYB9WjLH6z5iB15r0WGMtuF9PjLB6CgDEFXyWpjPgW4YMeQASpmY
   sCh81YMaAhvvHyNlL6SzgAs89gf19uQUFNHM3U3iR/v3ZiBlDtutExC0V
   LcbFAcsviea7ps6pnTbSiiT+wcBPw/uafwYuno13ItVnob6Glp5YWOvE1
   BVqD99p1A1PLEOCjaiSPCkh7sZSV/wj8pPg4B56Had+Q/AcInlX1YG8Jr
   EcCcwCrjr8j/uAWFklRemviemJsA8AJdGNjsrUBTzNBD+noWUhW9N4kqW
   AW4Fj0rk3TStJzw8B51Syj2S03Yr9yzSIFDl8yYGAZDATgDV/aMlOX9/H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000423"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000423"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769547941"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769547941"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:48 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/14] wifi: iwlwifi: mvm: Make iwl_mvm_diversity_iter() MLO aware
Date:   Wed, 24 May 2023 20:42:04 +0300
Message-Id: <20230524203151.56a9c709e987.I9716195ec288cce2c929338c254ee9add8cfcc1f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524174211.1482360-1-gregory.greenman@intel.com>
References: <20230524174211.1482360-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

This function is MLO related, so it should iterate over all the links,
and not only on deflink.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index af31b09c3966..2a10d851d2e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -413,16 +413,20 @@ static void iwl_mvm_diversity_iter(void *_data, u8 *mac,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_diversity_iter_data *data = _data;
-	int i;
+	int i, link_id;
 
-	if (mvmvif->deflink.phy_ctxt != data->ctxt)
-		return;
+	for_each_mvm_vif_valid_link(mvmvif, link_id) {
+		struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
 
-	for (i = 0; i < NUM_IWL_MVM_SMPS_REQ; i++) {
-		if (mvmvif->deflink.smps_requests[i] == IEEE80211_SMPS_STATIC ||
-		    mvmvif->deflink.smps_requests[i] == IEEE80211_SMPS_DYNAMIC) {
-			data->result = false;
-			break;
+		if (link_info->phy_ctxt != data->ctxt)
+			continue;
+
+		for (i = 0; i < NUM_IWL_MVM_SMPS_REQ; i++) {
+			if (link_info->smps_requests[i] == IEEE80211_SMPS_STATIC ||
+			    link_info->smps_requests[i] == IEEE80211_SMPS_DYNAMIC) {
+				data->result = false;
+				break;
+			}
 		}
 	}
 }
-- 
2.38.1


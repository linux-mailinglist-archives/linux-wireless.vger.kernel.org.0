Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8033B6FA22A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjEHIZf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjEHIZL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:25:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695991FAB3
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534307; x=1715070307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PqtcsslFkkVNO7nrIn1NxBzz1jUiP1SwibqK0cqnKLU=;
  b=jp35HRkMh6+ax1tGm8tNL9GBGJGJYaBw/57CAkXh9wgVouNe9g+zkOPu
   UdHSP+fBNg6/aFk/7FyeKJoWe7UoG+flaumZI48C5A2kPfVf4Tm8LI0mK
   fY1RrYhgNnXNcddNoq/LAASlZlNH6j04dmoGTaju648SFAZ4/0AAmVgae
   ewTbMQgTPT8Ts51S2Z9+A5r7yDhNcF7xbU8M09xGXHVWnKV7S9wtLBXWR
   PHdcgIHMRTKI7/Ff7Piqc0eFg+ZRb99/K+tqM+Ugg39LzbC5AAXm3bCyL
   DRn7xO/qggsauGc1ilCt1wb/b8MwchINlcL6/G/qaOQ5b5Lffg77is/g7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949899"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949899"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982668"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982668"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:03 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/14] wifi: iwlwifi: mvm: Make iwl_mvm_diversity_iter() MLO aware
Date:   Mon,  8 May 2023 11:24:29 +0300
Message-Id: <20230508082433.1349733-11-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508082433.1349733-1-gregory.greenman@intel.com>
References: <20230508082433.1349733-1-gregory.greenman@intel.com>
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


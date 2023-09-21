Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52717A9DDF
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjIUTu3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjIUTo3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:44:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC345A554
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318624; x=1726854624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ez6OMbG56Oz+kGhavzXmhZUc+zxBbDsBUtxINxLSAeQ=;
  b=hGwcDNeuDgm6JZdwxDPAyjba0q9y9mwxuvyVb1IxOdGvZyjvEZQ3d0a6
   wtLYTU0f0NX+yUpKTb9zYHZFG7tBHTvnbXel6iO1weCFIOzPzDC0rQgWP
   CjtMz8tlVUJmmr9lU0xYp2i+iHfwGh2uTOERjHoMeV772DokTArICkbT0
   i2+5OVMDEfuUq2ddv0suLMUiMi89GOgpkhADSCSZXYYUF9dOH1TUT3x0o
   r/1Zxz3Ttv+km18EuJ7Py7lqlsH4x6Wq0a9QhPXjihgX8efM4JwICpuCy
   Sr2FyjmoLmjBnRLSZaKHe7/4sE4WbPl7crx3rhGvawqq4chVkYZEYO8ph
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305312"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305312"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545519"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545519"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:49 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/12] wifi: iwlwifi: mvm: handle link-STA allocation in restart
Date:   Thu, 21 Sep 2023 11:58:01 +0300
Message-Id: <20230921110726.99b7cc754b00.Iaa0503a3100250489fed8b4bdcf60e24a96d3392@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230921085810.693048-1-gregory.greenman@intel.com>
References: <20230921085810.693048-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

During HW restart, STA link changes happen while the link-sta is
already allocated (had been prior to the restart). Adjust the
allocation and checks to handle that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 524852cf5cd2..4e9d19eb31f1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -1104,15 +1104,26 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 			link_sta_dereference_protected(sta, link_id);
 		mvm_vif_link = mvm_vif->link[link_id];
 
-		if (WARN_ON(!mvm_vif_link || !link_conf || !link_sta ||
-			    mvm_sta->link[link_id])) {
+		if (WARN_ON(!mvm_vif_link || !link_conf || !link_sta)) {
 			ret = -EINVAL;
 			goto err;
 		}
 
-		ret = iwl_mvm_mld_alloc_sta_link(mvm, vif, sta, link_id);
-		if (WARN_ON(ret))
-			goto err;
+		if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+			if (WARN_ON(!mvm_sta->link[link_id])) {
+				ret = -EINVAL;
+				goto err;
+			}
+		} else {
+			if (WARN_ON(mvm_sta->link[link_id])) {
+				ret = -EINVAL;
+				goto err;
+			}
+			ret = iwl_mvm_mld_alloc_sta_link(mvm, vif, sta,
+							 link_id);
+			if (WARN_ON(ret))
+				goto err;
+		}
 
 		link_sta->agg.max_rc_amsdu_len = 1;
 		ieee80211_sta_recalc_aggregates(sta);
-- 
2.38.1


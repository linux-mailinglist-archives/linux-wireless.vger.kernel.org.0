Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBDE6CD293
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjC2HHx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjC2HHu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8483240C6
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073648; x=1711609648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sUjdFdCl5qf3MAWcHUwaOOIbP66mqANCdUz7N82PUEY=;
  b=U20hzOwqWlQ0JS+rQBFowjw3TPxN9q+CKn97RInnnff+iIHstvGblCuu
   nBGmZ+Rq3KCvUusn8/6mpJWqQa3tA9FPfmGXkDcBj7IiSQ+/ZlIiSJFx2
   hpuoTpxUJkr1new8/WEon7Fpb6bafqJ/6eyP70o9Hd/D/zaK1jrM4oO3a
   U3gzuZYVVKQtb1oTY9m6uvygF2OyGNY9DSqR0/7/rrQH8yqec/OWI558U
   VPAvSsPD9kKVu4j6OirgCTiQQOlkn2FxrQazlNjH7Y/BTQgWRMIFXBhqX
   +TtR9T7Vpv1TwlVLrLfmAOiK0D1JU/oG3ZnPx+j0imfx5iNAuaGRE6vEn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450837"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450837"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111331"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111331"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:24 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/34] wifi: iwlwifi: mvm: adjust iwl_mvm_scan_respect_p2p_go_iter() for MLO
Date:   Wed, 29 Mar 2023 10:05:22 +0300
Message-Id: <20230329100039.4eb25d5655d0.Ie69f7313e4337f78c262a835aea3f707273a4209@changeid>
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

From: Avraham Stern <avraham.stern@intel.com>

When looking for a GO on for setting the scan parameters, iterate
over all the available links.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 975edc02e637..07045092c717 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2677,11 +2677,23 @@ static void iwl_mvm_scan_respect_p2p_go_iter(void *_data, u8 *mac,
 	if (vif == data->current_vif)
 		return;
 
-	if (vif->type == NL80211_IFTYPE_AP && vif->p2p &&
-	    mvmvif->deflink.phy_ctxt->id < NUM_PHY_CTX &&
-	    (data->band == NUM_NL80211_BANDS ||
-	     mvmvif->deflink.phy_ctxt->channel->band == data->band))
-		data->p2p_go = true;
+	if (vif->type == NL80211_IFTYPE_AP && vif->p2p) {
+		u32 link_id;
+
+		for (link_id = 0;
+		     link_id < ARRAY_SIZE(mvmvif->link);
+		     link_id++) {
+			struct iwl_mvm_vif_link_info *link =
+				mvmvif->link[link_id];
+
+			if (link && link->phy_ctxt->id < NUM_PHY_CTX &&
+			    (data->band == NUM_NL80211_BANDS ||
+			     link->phy_ctxt->channel->band == data->band)) {
+				data->p2p_go = true;
+				break;
+			}
+		}
+	}
 }
 
 static bool _iwl_mvm_get_respect_p2p_go(struct iwl_mvm *mvm,
-- 
2.38.1


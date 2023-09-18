Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247BB7A480B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbjIRLLq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241525AbjIRLLe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA22399
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035488; x=1726571488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1bBLce+jGNc+E6bmMNdLb8a/41nDF9Tww7XllDfufM=;
  b=XEHahJo0/b6/8LZ5eFko+lOZ5rxhrdNtbN7HrBGJRuYFwaC444rTUI+H
   A34HR4OofZW8IYN+g3vY+PHnEWcQCFi/PjezsEAY38VT21JfTRBK0l/6D
   LVA/pugjmZyMcFlm2Xqyni47bKikIZ1IQXHrFtBYDrMGuOolLqv5DL3Mu
   msNBSS+eFK81dSbk+m2pm/eJUtcY/cDDOc1NQpJqPedDvDvtG9I9Bm/UG
   irFeT3gNOejSzkkV/umVQ6oz7yvJNI78JePPWsf74BdL3FVQglRu2KxLu
   SBketZeM2ig4GM/euwcs9T15EPgFzsfl3Ym7tfMXaJ6VZhuRsHo02NYwK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535700"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535700"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025235"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025235"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/18] wifi: mac80211: update the rx_chains after set_antenna()
Date:   Mon, 18 Sep 2023 14:10:47 +0300
Message-Id: <20230918140607.d7373054dc25.I904223c868c77cf2ba132a3088fe6506fcbb443b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

rx_chains was set only upon registration and it we rely on it for the
active chains upon SMPS configuration after association.

When we use the set_antenna() API to limit the rx_chains from 2 to 1,
this caused issues with iwlwifi since we still had 2 active_chains
requested.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/cfg.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e751d4eba8f5..6b3ccb55aae5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4044,11 +4044,17 @@ ieee80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
 static int ieee80211_set_antenna(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
+	int ret;
 
 	if (local->started)
 		return -EOPNOTSUPP;
 
-	return drv_set_antenna(local, tx_ant, rx_ant);
+	ret = drv_set_antenna(local, tx_ant, rx_ant);
+	if (ret)
+		return ret;
+
+	local->rx_chains = hweight8(rx_ant);
+	return 0;
 }
 
 static int ieee80211_get_antenna(struct wiphy *wiphy, u32 *tx_ant, u32 *rx_ant)
-- 
2.38.1


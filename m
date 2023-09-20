Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0997A8BA7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjITS02 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjITS0Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96719F9
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234378; x=1726770378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1bBLce+jGNc+E6bmMNdLb8a/41nDF9Tww7XllDfufM=;
  b=jKWeb0/mwkfHIE6ts3UADUh8U9TlLhH+bgnPEvjdCymOm3ZIliNjnwYg
   gNBQqpRqJbBaBP54nsFPIYIuF/cCObjLjZQzDl+yxBABqSWgOM6L7Rr5e
   aGJAACTFzEDYwVoiQgBCLDQTGaI8c/T1E6JRGDOgUUclLqlq5haeRYLSt
   /pM2By43Yn4dwEwZANBUscpeWmLeR8k07579p7D74ipLxoQWB3OF4R8pg
   LiAPsaK1k/5NnHgY8+EUKbr69vrWObx/Ijne/+Tvh8fI+jRnOC/Z5kNPf
   D6tZhHTkEU9dwyskxmfMmdwtcEfcPkQldoBIeyKcGu5HVEnBwZyKIAmMt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556308"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556308"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424206"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424206"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 02/18] wifi: mac80211: update the rx_chains after set_antenna()
Date:   Wed, 20 Sep 2023 21:25:13 +0300
Message-Id: <20230920211508.2dde4da246b2.I904223c868c77cf2ba132a3088fe6506fcbb443b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
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


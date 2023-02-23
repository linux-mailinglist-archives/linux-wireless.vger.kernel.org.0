Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55FB6A05C9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjBWKM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjBWKMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F0251905
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147137; x=1708683137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hXY5qTtZq3b2PfxHMP+0NvIkKw8kRfAzTzrnagwivw=;
  b=ZiVgMyDlYhOvVVHlv9mGj/dzQ+WAs4lkzcq8mGpVYBI6TPdIjgK3nrwx
   sPw77b0xj1ceoPHPJVjiUJysTEeHhUN4DsOeP2n/V/Kx/4fknQUStb3vo
   vebMJaAgiM9q/5xmtOYrZQxbPPmlBvX14kb/JgqMcBeucU56YFN+Uil+R
   7noHIxOlBty4+xWS4d8Yn6pKC6KJxSrS6Cz2UnXFu1FphhfIVm7JYRguj
   VdHvufV1dm+TgdByHMORa6Vn04XuGAgur/MHeJA6OGbz5RWpcojWaRNe5
   RkLhlvpSkK0oSFaUyzAsVoe3+WhUjdPt9qFI63nrWCJCY/jsF4awV9+rI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396445"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396445"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:11:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245575"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245575"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:11:02 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/21] wifi: mac80211_hwsim: Indicate support for NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT
Date:   Thu, 23 Feb 2023 12:09:37 +0200
Message-Id: <20230223114629.c4c16196e4ea.I908b68c5127525da3388c0d61a3d5d221ba451f6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
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

From: Ilan Peer <ilan.peer@intel.com>

mac80211_hwsim always uses the probe request coming from mac80211,
which has support for minimal probe request content.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 4cc4eaf80b14..e9b9340a97dc 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -4446,6 +4446,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
 
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT);
+
 	hw->wiphy->interface_modes = param->iftypes;
 
 	/* ask mac80211 to reserve space for magic */
-- 
2.38.1


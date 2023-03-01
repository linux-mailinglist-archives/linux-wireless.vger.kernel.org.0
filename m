Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228F26A6A9A
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCAKLE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjCAKKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EDB3B0F0
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665445; x=1709201445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hXY5qTtZq3b2PfxHMP+0NvIkKw8kRfAzTzrnagwivw=;
  b=W4oqmMG8IQp1FkP430qmwSrOXMNaF2kXCi+/85fwT3kaP+FLY2GYCkeM
   4x408j/FzR+090gpOYxZDvMg0nLrx7NeY/gGnSbugZh6dfzxkE31/V8kp
   +S8ns24JbtcIbMPuqE3eYAqGvqOr64ligwSILlTGH3IfSUvjKb3pBAZ4d
   D6u6ETPQVlJAKBA3jrsjNOyQAH79RI4QV+K+5yj/9nEQpcrPEDaGaqYYg
   JCsFv7FsQqXWWKzJo0gGuRMTD0DjRbzKjXeejOuN9cBcf1oFWUSpnGaaD
   D2FkbuAfs5SKsQThbF9jTAz6cRyVp6XjgV7rpXXOw6zdrJc0YAUOhTLMC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662921"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662921"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589201"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589201"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:40 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 16/23] wifi: mac80211_hwsim: Indicate support for NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT
Date:   Wed,  1 Mar 2023 12:09:28 +0200
Message-Id: <20230301115906.67d31166ffd1.I908b68c5127525da3388c0d61a3d5d221ba451f6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
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


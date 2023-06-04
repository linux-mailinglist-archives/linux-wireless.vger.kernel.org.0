Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA797215BA
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjFDJMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjFDJMC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:12:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D791A7
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869921; x=1717405921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W+5a/XY0UWItE274Ga9fF+CH4rS0N9eDxGlBPNGGrE8=;
  b=SycF8cCZU4fsayccqdbwexZg8k1/IDUkfgNabvzMeVooqxWYXumQ+FwW
   Heg3ay9Re4YAmNEw196f+G5v2zqtqpX7oYqYdY81zmphW/bPQrjgkl+oR
   emAYWN8Rr6NYQvYeekMTExBy1Pbv2DfYdmlTPTOc+drjCyyHhr122H3vG
   nR/S0XJsSf68t/1qi9RHhFkjGforewp2XRgKBS3ntvM/vC2tRg2zvmZjY
   BpHy9LPfsRiv1GPdJAbBR0+vl6GA0NRfPjdnG43VX26N8LYfi/sf6EtKy
   2rLKJPADLYX5hCvQhKLq6IBOUkh0yDyI7zSl9bGOJCcJOQFVQc2hTkVRD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526515"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526515"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804591"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804591"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/16] wifi: mac80211_hwsim: check the return value of nla_put_u32
Date:   Sun,  4 Jun 2023 12:11:19 +0300
Message-Id: <20230604120651.de5168568cf6.Ie16442af9be879fd835506ba5dade780edecfb60@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230604091128.609335-1-gregory.greenman@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Check the return value of nla_put_u32() and handle it accordingly.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 5ff193bcd4b9..b06a6e78169d 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -582,8 +582,9 @@ static int mac80211_hwsim_vendor_cmd_test(struct wiphy *wiphy,
 		 */
 
 		/* Add vendor data */
-		nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 1);
-
+		err = nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 1);
+		if (err)
+			return err;
 		/* Send the event - this will call nla_nest_end() */
 		cfg80211_vendor_event(skb, GFP_KERNEL);
 	}
-- 
2.38.1


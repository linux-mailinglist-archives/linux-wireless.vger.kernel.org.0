Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5107215BB
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjFDJMK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjFDJMJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:12:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD41B6
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869923; x=1717405923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F3Ow0No4lLC4oxqbdm3u/l77IA8dwSgSfujgpZ4Uzrw=;
  b=Ig5flcgit48i0OZzKnZ/BYhH/iOKewH/V47SNFzrNAd7wHCsIliIGJ61
   l6B5W/RFGg2nX3tQGjVkyoMVsGd2NEu21+KsOh0yTS6PLWiUg/9R3UjIJ
   BbxqxU1rYq9OWNyBok+UHLgSN/1OFcnwHif6BV1eJn/c4IgOIFH+CQZgA
   CgWV92dEPDxb+rHkWYd9Su20ltBNOB8oqF5hdecidHM4vPTR1qnHCxieS
   xUAI1lJZJKQqpmpRKNQhw44d//lRmdTZqx62InlV7KMRRVKblL2SWi2qA
   hnFyx8dFsU/ckhsYX3ovBu6tTK6DXMBVrQdoAHRwUUQPwfFfoHbmxzzG/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526518"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526518"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804648"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804648"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/16] wifi: mac80211: recalc min chandef for new STA links
Date:   Sun,  4 Jun 2023 12:11:20 +0300
Message-Id: <20230604120651.377adf3c789a.I91bf28f399e16e6ac1f83bacd1029a698b4e6685@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

When adding a new link to a station, this needs to cause a
recalculation of the minimum chandef since otherwise we can
have a higher bandwidth station connected on that link than
the link is operating at. Do the appropriate recalc.

Fixes: cb71f1d136a6 ("wifi: mac80211: add sta link addition/removal")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/sta_info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 1400512e0dde..a1cd5c234f47 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2913,6 +2913,8 @@ int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
 	if (!test_sta_flag(sta, WLAN_STA_INSERTED))
 		goto hash;
 
+	ieee80211_recalc_min_chandef(sdata, link_id);
+
 	/* Ensure the values are updated for the driver,
 	 * redone by sta_remove_link on failure.
 	 */
-- 
2.38.1


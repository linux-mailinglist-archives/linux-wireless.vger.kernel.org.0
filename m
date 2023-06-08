Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CED72824D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjFHOHb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbjFHOHW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72CA2D5F
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233239; x=1717769239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iiudbld3Kg3ARQeH0/YlzSWeVSO5WiOwFADWgSY2r1E=;
  b=P+1PEvH2wW81W+KQOwwjb7H/3lwDOTtQ8dv5dMkwjFai61cJhV2gEZb7
   BqWwNUWOOCyXcwHagUZZkh03IerHXwmAiaWSsk36QGIgv5Zzs3fUBhVsP
   XAscM89z+2JCEWphwSbfgOoqsWesX51JhLzbE8qQzINoKv7xwn4gieazY
   5S2JNG2eUj8Up8goayyuWBoW4qZqo7/IO6TCJnq/NPwqXMVcnz2pW+p2n
   rRkEVa/5ESs6KubKhAZEhHsM2WuyTbrodzkfO5LGBBY2/TRrzuZvLqLJs
   yKNpTeWNYPgWJiuBPM9c5zsSKOjy9oQGN0h43M+JSWHY3poy/3sBRrDmz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176285"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176285"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706366"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706366"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: mac80211_hwsim: Don't access vif valid links directly
Date:   Thu,  8 Jun 2023 16:36:09 +0300
Message-Id: <20230608163202.8966bd5ce7c8.Ia73e3555aaf4ddf9917bced8d413fad08cc28f1b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608133611.1303724-1-gregory.greenman@intel.com>
References: <20230608133611.1303724-1-gregory.greenman@intel.com>
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

From: Ilan Peer <ilan.peer@intel.com>

And instead use the vif getter functions, as a preparation for
supporting disabled/dormant links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 37bf392ae9a2..f446fd0e8cd0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1860,7 +1860,7 @@ mac80211_hwsim_select_tx_link(struct mac80211_hwsim_data *data,
 	struct hwsim_sta_priv *sp = (void *)sta->drv_priv;
 	int i;
 
-	if (!vif->valid_links)
+	if (!ieee80211_vif_is_mld(vif))
 		return &vif->bss_conf;
 
 	WARN_ON(is_multicast_ether_addr(hdr->addr1));
@@ -2636,7 +2636,8 @@ static int mac80211_hwsim_sta_state(struct ieee80211_hw *hw,
 	 */
 	if (vif->type == NL80211_IFTYPE_STATION &&
 	    new_state == IEEE80211_STA_AUTHORIZED && !sta->tdls)
-		ieee80211_set_active_links_async(vif, vif->valid_links);
+		ieee80211_set_active_links_async(vif,
+						 ieee80211_vif_usable_links(vif));
 
 	return 0;
 }
-- 
2.38.1


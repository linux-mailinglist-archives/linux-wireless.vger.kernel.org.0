Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A75696066
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 11:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjBNKLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 05:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjBNKLC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 05:11:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE82115
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 02:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676369461; x=1707905461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CABN2CPWBnimV4fRCxHovFa8yLClii5Oq51tMdcdNqE=;
  b=MUOzPKaD2RCEkgrFGv6ntxx5l+g/7QMhLb+Uj+3rps55I061As1e95Gc
   //MKIOAxz89UG0Wi7PKs2ni2f4N50ayQUUJ6IpCL0ult0r22Ras6QkcfU
   qjsdgekmlWADVGKfyN6q+2fGkknC8grLdcUTjyGfxn59w3BvDW7qapzTI
   TB5Zof5XecLiGx/BEpiBr47r3cRg2ZuIQJ8QuUKqmBaL+9VM06mDnIyri
   aZQc1mWIG862UoVXFhA96Uer48irgaV1JWv2uAUXB9CYcExDF3WHp54Zm
   okcbu/FtMmMahlafgtXVxhTVSM6fwnu+h6B8UcGkTUroUl9L5QI0u4jg1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="393529574"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="393529574"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 02:11:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="998024518"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="998024518"
Received: from allangfe-mobl2.amr.corp.intel.com (HELO aotchere-desk.intel.com) ([10.255.194.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 02:10:59 -0800
From:   Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH] wifi: mac80211: Don't translate MLD addresses for multicast
Date:   Tue, 14 Feb 2023 12:10:48 +0200
Message-Id: <20230214101048.792414-1-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.38.1
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

MLD address translation should be done only for individually addressed
frames. Otherwise, AAD calculation would be wrong and the decryption
would fail.

Fixes: e66b7920aa5ac ("wifi: mac80211: fix initialization of rx->link and rx->link_sta")
Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
---
 net/mac80211/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e284897ba5e9..b32206ae32b8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4843,7 +4843,8 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 		hdr = (struct ieee80211_hdr *)rx->skb->data;
 	}
 
-	if (unlikely(rx->sta && rx->sta->sta.mlo)) {
+	if (unlikely(rx->sta && rx->sta->sta.mlo) &&
+	    is_unicast_ether_addr(hdr->addr1)) {
 		/* translate to MLD addresses */
 		if (ether_addr_equal(link->conf->addr, hdr->addr1))
 			ether_addr_copy(hdr->addr1, rx->sdata->vif.addr);
-- 
2.38.1


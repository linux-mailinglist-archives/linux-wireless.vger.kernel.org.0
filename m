Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BCC73587C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjFSN1O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 09:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFSN1N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 09:27:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD9F127
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181232; x=1718717232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UYwcI5hXKKt6Zlt+1/2aE0pxraW6U7dye9Rm2EfxxDs=;
  b=H7af1rtkwZrSFA1p6x95dGOpAMwg3hFrm95VHh2QN5eD0aomPF3p40SG
   81MQGdu0SHQ5h6HqHgDlWkx48CR1FVTR5lN/Fsqa7dgije3YOyASK9SWq
   kNUIfFpE2ezeB6+TLopwnuUjrk+WMmu1HKCUCnG9c7ypDXodS8aGKEsIZ
   CMoI/MIjHr39/AJr7ySDHZ5llkGgvvID7pMABTuuO+xgoZBFEmWOI4zgw
   z23+L+vr9rijULmTMwt0FcOfD5aP2659kopARD1QccrEdFxW8lzdvpF7v
   QQYpRkWqH3gsIzBv4GNJJoO3McFjSnA9qHcyA5y/+RaQpMoa8LLgNkfoN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339240660"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339240660"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="716871716"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716871716"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/9] wifi: mac80211: drop some unprotected action frames
Date:   Mon, 19 Jun 2023 16:26:47 +0300
Message-Id: <20230619161906.eb4461108129.I3c2223cf29d8a3586dfc74b2dda3f6fa2a4eea7c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619132653.902084-1-gregory.greenman@intel.com>
References: <20230619132653.902084-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We should not receive/handle unicast protected dual
or public action frames that aren't protected, so
drop them - in the latter case of course only if MFP
is used.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/rx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 5c1d6c2674ef..04dd714b8730 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2405,9 +2405,9 @@ static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 
 static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 {
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)rx->skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
-	__le16 fc = hdr->frame_control;
+	struct ieee80211_mgmt *mgmt = (void *)rx->skb->data;
+	__le16 fc = mgmt->frame_control;
 
 	/*
 	 * Pass through unencrypted frames if the hardware has
@@ -2416,6 +2416,11 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 	if (status->flag & RX_FLAG_DECRYPTED)
 		return 0;
 
+	/* drop unicast protected dual (that wasn't protected) */
+	if (ieee80211_is_action(fc) &&
+	    mgmt->u.action.category == WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION)
+		return -EACCES;
+
 	if (rx->sta && test_sta_flag(rx->sta, WLAN_STA_MFP)) {
 		if (unlikely(!ieee80211_has_protected(fc) &&
 			     ieee80211_is_unicast_robust_mgmt_frame(rx->skb))) {
@@ -2450,6 +2455,12 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 		if (unlikely(ieee80211_is_action(fc) && !rx->key &&
 			     ieee80211_is_robust_mgmt_frame(rx->skb)))
 			return -EACCES;
+
+		/* drop unicast public action frames when using MPF */
+		if (is_unicast_ether_addr(mgmt->da) &&
+		    ieee80211_is_public_action((void *)rx->skb->data,
+					       rx->skb->len))
+			return -EACCES;
 	}
 
 	return 0;
-- 
2.38.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454B06A6A92
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCAKKe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCAKKL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F2A2A6E2
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665411; x=1709201411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LZuXV+m3i2eMmrtC1PDbIBCPg61VsyqbOHwpglQ6DN0=;
  b=Hu35B24/d8AIHcKZFgYqjxLn2tOta0VLS8eUx4BO6xaLrEhi1gp6yJzm
   ylWqT13PP2jnGqyKZroURTHY6Mwe+bXrDkHd7e6jrO4Jb+Zn9hRxUT3KO
   gCnJ3IptvpUwSU+uGKWBbqEunse178hfxHNvSv01xXmUzTmd7w1MTSW75
   ezfMk7sawFoYUaIv989iuX36okLoq22GHNIJWqWmz5AqwggZurBYQFCcC
   z3aZ9+HknWs7Fu/hHVU0OFiZahrNMpoCXp/YX96KYICqZXqkEDy/lKXB2
   KrW1K7OTR/T5YCu1P0Cj2XXr/WQfEEgvbepbDdyJZLWGv3gdilCcAuUdc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662777"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662777"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589013"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589013"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:01 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 03/23] wifi: mac80211: clear all bits that relate rtap fields on skb
Date:   Wed,  1 Mar 2023 12:09:15 +0200
Message-Id: <20230301115906.74d3efe19eae.Ie17a35864d2e120f9858516a2e3d3047d83cf805@changeid>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Since we remove radiotap from skb data, clear all RX_FLAG_X related
info that indicate info on the skb data.

Also we need to do it only once so remove the clear from cooked_monitor.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/rx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index f7fdfe710951..f131df282d0b 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -43,6 +43,7 @@ static struct sk_buff *ieee80211_clean_skb(struct sk_buff *skb,
 					   unsigned int present_fcs_len,
 					   unsigned int rtap_space)
 {
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr;
 	unsigned int hdrlen;
 	__le16 fc;
@@ -51,6 +52,14 @@ static struct sk_buff *ieee80211_clean_skb(struct sk_buff *skb,
 		__pskb_trim(skb, skb->len - present_fcs_len);
 	pskb_pull(skb, rtap_space);
 
+	/* After pulling radiotap header, clear all flags that indicate
+	 * info on skb->data.
+	 */
+	status->flag &= ~(RX_FLAG_RADIOTAP_VENDOR_DATA |
+			  RX_FLAG_RADIOTAP_LSIG |
+			  RX_FLAG_RADIOTAP_HE_MU |
+			  RX_FLAG_RADIOTAP_HE);
+
 	hdr = (void *)skb->data;
 	fc = hdr->frame_control;
 
@@ -3916,8 +3925,6 @@ static void ieee80211_rx_cooked_monitor(struct ieee80211_rx_data *rx,
 	if (!local->cooked_mntrs)
 		goto out_free_skb;
 
-	/* vendor data is long removed here */
-	status->flag &= ~RX_FLAG_RADIOTAP_VENDOR_DATA;
 	/* room for the radiotap header based on driver features */
 	needed_headroom = ieee80211_rx_radiotap_hdrlen(local, status, skb);
 
-- 
2.38.1


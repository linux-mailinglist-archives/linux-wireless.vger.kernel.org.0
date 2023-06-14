Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5547215B5
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjFDJLx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjFDJLw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:11:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE2EE3
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869911; x=1717405911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oinPS/59FhzKbL9jairtcH3HqPZOtOm8RGgvaCxtiz4=;
  b=fOVfxIPpy1m1846iGD4WylYlFxrAjgLQv5yVrzyGZ1EnW+/tP54YPcVV
   lgVbecTm/uKthEuX11LXRDxlYuMe9oCljqs9lHAndUPZabqJU8vM21YG0
   awO7rWXuczRrSEw7+B+22usQW5xoCTy7E0YtRA6hVlQ8sET6DHAP5D3ki
   NFsFswFFAQHNipRuJ1UlAJR0MM2XGKW5KJveJWyQo0F/DJ+ymh/V1nCUT
   r0IXmKAx4pF2Nr6LOOlsflgZZ9EtVB43lnLprCdnw5xUfu5U38SksZdfh
   X7pIyB8Ejo6aIAPjn95prHIm86I9c0SBWqN0Ew90PN/cX7ZXftrE1pkE2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526481"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526481"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804333"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804333"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/16] wifi: mac80211: refactor ieee80211_select_link_key()
Date:   Sun,  4 Jun 2023 12:11:14 +0300
Message-Id: <20230604120651.a4e332755bb0.Iff4a2b6ed767b2a329c51c29bb597ece9ebe2af8@changeid>
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

Simplify ieee80211_select_link_key(), no functional changes are made.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/tx.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1a3327407552..e809c4236f78 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -581,25 +581,9 @@ ieee80211_select_link_key(struct ieee80211_tx_data *tx)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
-	enum {
-		USE_NONE,
-		USE_MGMT_KEY,
-		USE_MCAST_KEY,
-	} which_key = USE_NONE;
 	struct ieee80211_link_data *link;
 	unsigned int link_id;
 
-	if (ieee80211_is_group_privacy_action(tx->skb))
-		which_key = USE_MCAST_KEY;
-	else if (ieee80211_is_mgmt(hdr->frame_control) &&
-		 is_multicast_ether_addr(hdr->addr1) &&
-		 ieee80211_is_robust_mgmt_frame(tx->skb))
-		which_key = USE_MGMT_KEY;
-	else if (is_multicast_ether_addr(hdr->addr1))
-		which_key = USE_MCAST_KEY;
-	else
-		return NULL;
-
 	link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
 	if (link_id == IEEE80211_LINK_UNSPECIFIED) {
 		link = &tx->sdata->deflink;
@@ -609,14 +593,14 @@ ieee80211_select_link_key(struct ieee80211_tx_data *tx)
 			return NULL;
 	}
 
-	switch (which_key) {
-	case USE_NONE:
-		break;
-	case USE_MGMT_KEY:
+	if (ieee80211_is_group_privacy_action(tx->skb))
+		return rcu_dereference(link->default_multicast_key);
+	else if (ieee80211_is_mgmt(hdr->frame_control) &&
+		 is_multicast_ether_addr(hdr->addr1) &&
+		 ieee80211_is_robust_mgmt_frame(tx->skb))
 		return rcu_dereference(link->default_mgmt_key);
-	case USE_MCAST_KEY:
+	else if (is_multicast_ether_addr(hdr->addr1))
 		return rcu_dereference(link->default_multicast_key);
-	}
 
 	return NULL;
 }
-- 
2.38.1


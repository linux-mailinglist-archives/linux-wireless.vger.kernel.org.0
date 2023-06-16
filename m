Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F278732804
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbjFPGzF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243554AbjFPGyu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE661FF5
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898489; x=1718434489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bjdK2ytjFWqHRAwB3tzLstFcPQHesMYxeOmI/ME6zrA=;
  b=O5dRyqYt0TyYf03Rkr0552EUm1hLS9o7I7+tZP7cIdfyKEcNLCxk2ubF
   tKDiv8uVY2DKrSK0WQ5cl9YrwAr6ciKEaaRN5loTY4fo/94dzlXx8u/b8
   iqBz8+WEPX0thnHsHv+aMH5kALstDDBbM1fecR8vRku4qxHb1N9aYW6wE
   XupOk0vTj2+n/so29IYRUCvrKA1+N1lES/zOOgC1/BqKVlxC9ey9zdTra
   WDPyb1gr2NQskplmoon+wwxBG6j1sXYkiTD0VMvaH/81qYannoLEeCSQy
   waEcbD1Rtobha/U5SjzCN/9lv7B1W5RuH5+tDM/6KlagAjxUUsvaXNjlI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078872"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078872"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720098"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720098"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:46 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/20] wifi: cfg80211: keep bss_lock held when informing
Date:   Fri, 16 Jun 2023 09:53:59 +0300
Message-Id: <20230616094948.61701884ff0d.I3358228209eb6766202aff04d1bae0b8fdff611f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

It is reasonable to hold bss_lock for a little bit longer after
cfg80211_bss_update is done. Right now, this does not make any big
difference, but doing so in preparation for the next patch which adds
a call to the driver.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 66 ++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 19e7014f8bc3..8984f74da891 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1701,10 +1701,10 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 }
 
 /* Returned bss is reference counted and must be cleaned up appropriately. */
-struct cfg80211_internal_bss *
-cfg80211_bss_update(struct cfg80211_registered_device *rdev,
-		    struct cfg80211_internal_bss *tmp,
-		    bool signal_valid, unsigned long ts)
+static struct cfg80211_internal_bss *
+__cfg80211_bss_update(struct cfg80211_registered_device *rdev,
+		      struct cfg80211_internal_bss *tmp,
+		      bool signal_valid, unsigned long ts)
 {
 	struct cfg80211_internal_bss *found = NULL;
 
@@ -1713,10 +1713,7 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 
 	tmp->ts = ts;
 
-	spin_lock_bh(&rdev->bss_lock);
-
 	if (WARN_ON(!rcu_access_pointer(tmp->pub.ies))) {
-		spin_unlock_bh(&rdev->bss_lock);
 		return NULL;
 	}
 
@@ -1724,7 +1721,7 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 
 	if (found) {
 		if (!cfg80211_update_known_bss(rdev, found, tmp, signal_valid))
-			goto drop;
+			return NULL;
 	} else {
 		struct cfg80211_internal_bss *new;
 		struct cfg80211_internal_bss *hidden;
@@ -1744,7 +1741,7 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 			ies = (void *)rcu_dereference(tmp->pub.proberesp_ies);
 			if (ies)
 				kfree_rcu(ies, rcu_head);
-			goto drop;
+			return NULL;
 		}
 		memcpy(new, tmp, sizeof(*new));
 		new->refcount = 1;
@@ -1775,14 +1772,14 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 			 */
 			if (!cfg80211_combine_bsses(rdev, new)) {
 				bss_ref_put(rdev, new);
-				goto drop;
+				return NULL;
 			}
 		}
 
 		if (rdev->bss_entries >= bss_entries_limit &&
 		    !cfg80211_bss_expire_oldest(rdev)) {
 			bss_ref_put(rdev, new);
-			goto drop;
+			return NULL;
 		}
 
 		/* This must be before the call to bss_ref_get */
@@ -1799,12 +1796,22 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 
 	rdev->bss_generation++;
 	bss_ref_get(rdev, found);
-	spin_unlock_bh(&rdev->bss_lock);
 
 	return found;
- drop:
+}
+
+struct cfg80211_internal_bss *
+cfg80211_bss_update(struct cfg80211_registered_device *rdev,
+		    struct cfg80211_internal_bss *tmp,
+		    bool signal_valid, unsigned long ts)
+{
+	struct cfg80211_internal_bss *res;
+
+	spin_lock_bh(&rdev->bss_lock);
+	res = __cfg80211_bss_update(rdev, tmp, signal_valid, ts);
 	spin_unlock_bh(&rdev->bss_lock);
-	return NULL;
+
+	return res;
 }
 
 int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
@@ -2015,15 +2022,15 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	rcu_assign_pointer(tmp.pub.ies, ies);
 
 	signal_valid = data->chan == channel;
-	res = cfg80211_bss_update(wiphy_to_rdev(wiphy), &tmp, signal_valid, ts);
+	spin_lock_bh(&rdev->bss_lock);
+	res = __cfg80211_bss_update(rdev, &tmp, signal_valid, ts);
 	if (!res)
-		return NULL;
+		goto drop;
 
 	if (non_tx_data) {
 		/* this is a nontransmitting bss, we need to add it to
 		 * transmitting bss' list if it is not there
 		 */
-		spin_lock_bh(&rdev->bss_lock);
 		if (cfg80211_add_nontrans_list(non_tx_data->tx_bss,
 					       &res->pub)) {
 			if (__cfg80211_unlink_bss(rdev, res)) {
@@ -2031,15 +2038,19 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 				res = NULL;
 			}
 		}
-		spin_unlock_bh(&rdev->bss_lock);
 
 		if (!res)
-			return NULL;
+			goto drop;
 	}
+	spin_unlock_bh(&rdev->bss_lock);
 
 	trace_cfg80211_return_bss(&res->pub);
-	/* cfg80211_bss_update gives us a referenced result */
+	/* __cfg80211_bss_update gives us a referenced result */
 	return &res->pub;
+
+drop:
+	spin_unlock_bh(&rdev->bss_lock);
+	return NULL;
 }
 
 static const struct element
@@ -2376,6 +2387,7 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 				      struct ieee80211_mgmt *mgmt, size_t len,
 				      gfp_t gfp)
 {
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct cfg80211_internal_bss tmp = {}, *res;
 	struct cfg80211_bss_ies *ies;
 	struct ieee80211_channel *channel;
@@ -2485,14 +2497,20 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	ether_addr_copy(tmp.parent_bssid, data->parent_bssid);
 
 	signal_valid = data->chan == channel;
-	res = cfg80211_bss_update(wiphy_to_rdev(wiphy), &tmp, signal_valid,
-				  jiffies);
+	spin_lock_bh(&rdev->bss_lock);
+	res = __cfg80211_bss_update(rdev, &tmp, signal_valid, jiffies);
 	if (!res)
-		return NULL;
+		goto drop;
+
+	spin_unlock_bh(&rdev->bss_lock);
 
 	trace_cfg80211_return_bss(&res->pub);
-	/* cfg80211_bss_update gives us a referenced result */
+	/* __cfg80211_bss_update gives us a referenced result */
 	return &res->pub;
+
+drop:
+	spin_unlock_bh(&rdev->bss_lock);
+	return NULL;
 }
 
 struct cfg80211_bss *
-- 
2.38.1


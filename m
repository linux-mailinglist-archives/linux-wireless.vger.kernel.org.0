Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28615466480
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 14:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358219AbhLBNcV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 08:32:21 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50178 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1358213AbhLBNcT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 08:32:19 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1msm8t-0015J4-Fg; Thu, 02 Dec 2021 15:28:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  2 Dec 2021 15:28:54 +0200
Message-Id: <iwlwifi.20211202152831.527686cda037.I40ad9372a47cbad53b4aae7b5a6ccc0dc3fddf8b@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <iwlwifi.20211129152938.faf291271590.I40ad9372a47cbad53b4aae7b5a6ccc0dc3fddf8b@changeid>
References: <iwlwifi.20211129152938.faf291271590.I40ad9372a47cbad53b4aae7b5a6ccc0dc3fddf8b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2] cfg80211: Acquire wiphy mutex on regulatory work
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The function cfg80211_reg_can_beacon_relax() expects wiphy
mutex to be held when it is being called. However, when
reg_leave_invalid_chans() is called the mutex is not held.
Fix it by acquiring the lock before calling the function.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---

In v2:
    * Remove duplicate Fixes tag.

net/wireless/reg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index df87c7f3a049..6f6da1cedd80 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2338,6 +2338,7 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	struct cfg80211_chan_def chandef = {};
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	enum nl80211_iftype iftype;
+	bool ret;
 
 	wdev_lock(wdev);
 	iftype = wdev->iftype;
@@ -2387,7 +2388,11 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_ADHOC:
-		return cfg80211_reg_can_beacon_relax(wiphy, &chandef, iftype);
+		wiphy_lock(wiphy);
+		ret = cfg80211_reg_can_beacon_relax(wiphy, &chandef, iftype);
+		wiphy_unlock(wiphy);
+
+		return ret;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
 		return cfg80211_chandef_usable(wiphy, &chandef,
@@ -2409,7 +2414,6 @@ static void reg_leave_invalid_chans(struct wiphy *wiphy)
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
 	ASSERT_RTNL();
-
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		if (!reg_wdev_chan_valid(wiphy, wdev))
 			cfg80211_leave(rdev, wdev);
-- 
2.33.1


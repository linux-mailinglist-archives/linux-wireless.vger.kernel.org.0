Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C30E78AF98
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjH1MGS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjH1MFp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7801A120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Rt6saajgFG5kejgNAgKf6h0ul6dTZo9+PraTTD/QW2o=;
        t=1693224343; x=1694433943; b=wuflq8jSUZn/RlIQYftPJWEnqdSJbDC/t0a7y889L4YvJSJ
        ufSt5bzX9HoXJn/RWhMiCjoBe3JzYCc3QqdIWytZNuIiWVPGHorPh2iL2+lcoCtFPg6I9zRfB4Fta
        MF3cWpMximyG2w/R0DVBMeYLHEtAWuQNRgLraAZmMnF/h3Smu2CEuXSDW+tRX6FIubzlqyvhAwjM4
        0sD7FVKLxvuSM+hk3H91x+3DxWqexg8au34y8XBvGsjV95PYYJniGvGBUYfR6i83NM6D47cHg+WUG
        Uix98IW6LmRQHyWH71YhxdgykjO6Nuolu/NKpnVyLEbxgnynp2dm5REYHvSxgBag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab01-00Gjgt-13;
        Mon, 28 Aug 2023 14:05:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 27/40] wifi: cfg80211: hold wiphy lock in cfg80211_any_wiphy_oper_chan()
Date:   Mon, 28 Aug 2023 13:59:55 +0200
Message-ID: <20230828135928.2716b4dd8037.Id7b961619349e497260d6752852a1dbd623944e7@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We have the RTNL here for the iteration, but we need to lock
each wiphy separately as well for using its data. Hold the
wiphy lock for all of the ones in the iteration. Note that
this implies we cannot already hold the wiphy mutex for the
wiphy passed by the argument, but that's true now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/chan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 3c691ae904d1..b2469e2c1e70 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -824,13 +824,17 @@ bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 		return false;
 
 	for_each_rdev(rdev) {
+		bool found;
+
 		if (!reg_dfs_domain_same(wiphy, &rdev->wiphy))
 			continue;
 
-		if (cfg80211_is_wiphy_oper_chan(&rdev->wiphy, chan))
-			return true;
+		wiphy_lock(&rdev->wiphy);
+		found = cfg80211_is_wiphy_oper_chan(&rdev->wiphy, chan) ||
+			cfg80211_offchan_chain_is_active(rdev, chan);
+		wiphy_unlock(&rdev->wiphy);
 
-		if (cfg80211_offchan_chain_is_active(rdev, chan))
+		if (found)
 			return true;
 	}
 
-- 
2.41.0


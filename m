Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ABD72423C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjFFMfH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbjFFMey (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:34:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B1C10C3
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WqjL5yyHzRtngED1gZIYy34CpUDhDaZeCYROUGK0tvw=;
        t=1686054893; x=1687264493; b=mY2K4cQrvkBme56yMZhVCo/lSOQBWxPYvvym5v3jx33OhdC
        TlgdXbB3MgZ8ItAxvVqGHFVw8BjwN2hk0eOl2kD9V+zbsRGgTkGyGuBPZBJEb/qUk4wBV1z+YS5MF
        ME52SVMbT7+tDE5oCp4cF3jfK6cGMc12INMjWGBbz2c0ehDn88FinJ1pu33533wpSKBc21fgTM/BN
        oUUHgTqNh1mbidYS6faj7gq6n/m+XV/oPAYhKa/tJ1lVTnolXvx/rvb7wr6P8D7wB9XVAWu79WjZx
        OfdiQTt1XGTmPl7NkoUkhzvynXjG80W8LkFr/67vmdDWGNEC6YaPv4gPnH783Unw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6Vti-00FYss-2R;
        Tue, 06 Jun 2023 14:34:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: cfg80211: fix locking in regulatory disconnect
Date:   Tue,  6 Jun 2023 14:34:48 +0200
Message-Id: <20230606143447.4a1050335c13.Idc40d8c530615a12a3f8a601c4dc8e59c9480927@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143447.3fb899fe7aba.I16cd047ee371b7ea34822cc84fd51a09e9778d8f@changeid>
References: <20230606143447.3fb899fe7aba.I16cd047ee371b7ea34822cc84fd51a09e9778d8f@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This should use wiphy_lock() now instead of requiring the
RTNL, since __cfg80211_leave() via cfg80211_leave() is now
requiring that lock to be held.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0d40d6af7e10..949e1fb3bec6 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2440,11 +2440,11 @@ static void reg_leave_invalid_chans(struct wiphy *wiphy)
 	struct wireless_dev *wdev;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	ASSERT_RTNL();
-
+	wiphy_lock(wiphy);
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		if (!reg_wdev_chan_valid(wiphy, wdev))
 			cfg80211_leave(rdev, wdev);
+	wiphy_unlock(wiphy);
 }
 
 static void reg_check_chans_work(struct work_struct *work)
-- 
2.40.1


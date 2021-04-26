Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F6D36BA04
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 21:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbhDZTaV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 15:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbhDZTaR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 15:30:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303A5C061574
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 12:29:34 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lb6vE-000MXn-GP; Mon, 26 Apr 2021 21:29:32 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Harald Arnesen <harald@skogtun.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wil6210: remove erroneous wiphy locking
Date:   Mon, 26 Apr 2021 21:29:30 +0200
Message-Id: <20210426212929.83f1de07c2cd.I630a2a00eff185ba0452324b3d3f645e01128a95@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We already hold the wiphy lock in all cases when we get
here, so this would deadlock, remove the erroneous locking.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 6746fd206d2a..1ff2679963f0 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2842,9 +2842,7 @@ void wil_p2p_wdev_free(struct wil6210_priv *wil)
 	wil->radio_wdev = wil->main_ndev->ieee80211_ptr;
 	mutex_unlock(&wil->vif_mutex);
 	if (p2p_wdev) {
-		wiphy_lock(wil->wiphy);
 		cfg80211_unregister_wdev(p2p_wdev);
-		wiphy_unlock(wil->wiphy);
 		kfree(p2p_wdev);
 	}
 }
-- 
2.30.2


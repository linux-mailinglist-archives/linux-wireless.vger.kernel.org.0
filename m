Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1433C1679B1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 10:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBUJr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Feb 2020 04:47:27 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55530 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgBUJr1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Feb 2020 04:47:27 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j54u5-00EuFr-4f; Fri, 21 Feb 2020 10:47:25 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH] mac80211: Remove a redundant mutex unlock
Date:   Fri, 21 Feb 2020 10:47:20 +0100
Message-Id: <20200221104719.cce4741cf6eb.I671567b185c8a4c2409377e483fd149ce590f56d@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

The below-mentioned commit added missing unlocks, however didn't
remove the now redundant mutex unlock in the caller function.
Fix this.

Fixes: 33483a6b88e4 ("mac80211: fix missing unlock on error in ieee80211_mark_sta_auth()")
Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
---
 net/mac80211/mlme.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e041af2f021a..88d7a692a965 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2959,7 +2959,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	    (auth_transaction == 2 &&
 	     ifmgd->auth_data->expected_transaction == 2)) {
 		if (!ieee80211_mark_sta_auth(sdata, bssid))
-			goto out_err;
+			return; /* ignore frame -- wait for timeout */
 	} else if (ifmgd->auth_data->algorithm == WLAN_AUTH_SAE &&
 		   auth_transaction == 2) {
 		sdata_info(sdata, "SAE peer confirmed\n");
@@ -2967,10 +2967,6 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	}
 
 	cfg80211_rx_mlme_mgmt(sdata->dev, (u8 *)mgmt, len);
-	return;
- out_err:
-	mutex_unlock(&sdata->local->sta_mtx);
-	/* ignore frame -- wait for timeout */
 }
 
 #define case_WLAN(type) \
-- 
2.24.1


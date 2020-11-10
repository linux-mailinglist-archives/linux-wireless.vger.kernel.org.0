Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A767E2AD2DD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 10:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgKJJvu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 04:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJJvu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 04:51:50 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F70C0613CF
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 01:51:50 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kcQJX-004qvb-3U; Tue, 10 Nov 2020 10:51:47 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+6a7fe9faf0d1d61bc24a@syzkaller.appspotmail.com,
        syzbot+abed06851c5ffe010921@syzkaller.appspotmail.com,
        syzbot+b7aeb9318541a1c709f1@syzkaller.appspotmail.com,
        syzbot+d5a9416c6cafe53b5dd0@syzkaller.appspotmail.com
Subject: [PATCH] mac80211: wind down station state earlier
Date:   Tue, 10 Nov 2020 10:51:39 +0100
Message-Id: <20201110105138.3f84f2055a30.I65a9d01564067122c47d0b5b6448bb4702a06b02@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

sta_info_free() may be used in a context that cannot sleep,
so do the wind-down earlier in __cleanup_single_sta(). We
should probably just unify that, by doing the free inside
sta_info_insert_finish() instead of the caller, but that'll
be a separate cleanup patch.

Reported-by: syzbot+6a7fe9faf0d1d61bc24a@syzkaller.appspotmail.com
Reported-by: syzbot+abed06851c5ffe010921@syzkaller.appspotmail.com
Reported-by: syzbot+b7aeb9318541a1c709f1@syzkaller.appspotmail.com
Reported-by: syzbot+d5a9416c6cafe53b5dd0@syzkaller.appspotmail.com
Fixes: dcd479e10a05 ("mac80211: always wind down STA state")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 4fe284ff1ea3..377ec1aea9c6 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -145,6 +145,24 @@ static void __cleanup_single_sta(struct sta_info *sta)
 		ieee80211_purge_tx_queue(&local->hw, &tid_tx->pending);
 		kfree(tid_tx);
 	}
+
+	/*
+	 * If we had used sta_info_pre_move_state() then we might not
+	 * have gone through the state transitions down again, so do
+	 * it here now (and warn if it's inserted).
+	 *
+	 * This will clear state such as fast TX/RX that may have been
+	 * allocated during state transitions.
+	 */
+	while (sta->sta_state > IEEE80211_STA_NONE) {
+		int ret;
+
+		WARN_ON_ONCE(test_sta_flag(sta, WLAN_STA_INSERTED));
+
+		ret = sta_info_move_state(sta, sta->sta_state - 1);
+		if (WARN_ONCE(ret, "sta_info_move_state() returned %d\n", ret))
+			break;
+	}
 }
 
 static void cleanup_single_sta(struct sta_info *sta)
@@ -258,24 +276,6 @@ struct sta_info *sta_info_get_by_idx(struct ieee80211_sub_if_data *sdata,
  */
 void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 {
-	/*
-	 * If we had used sta_info_pre_move_state() then we might not
-	 * have gone through the state transitions down again, so do
-	 * it here now (and warn if it's inserted).
-	 *
-	 * This will clear state such as fast TX/RX that may have been
-	 * allocated during state transitions.
-	 */
-	while (sta->sta_state > IEEE80211_STA_NONE) {
-		int ret;
-
-		WARN_ON_ONCE(test_sta_flag(sta, WLAN_STA_INSERTED));
-
-		ret = sta_info_move_state(sta, sta->sta_state - 1);
-		if (WARN_ONCE(ret, "sta_info_move_state() returned %d\n", ret))
-			break;
-	}
-
 	if (sta->rate_ctrl)
 		rate_control_free_sta(sta);
 
-- 
2.26.2


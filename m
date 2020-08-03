Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C64023A165
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 11:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgHCJC1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgHCJC0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 05:02:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63C0C06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 02:02:26 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k2WMO-00Fawt-6Y; Mon, 03 Aug 2020 11:02:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix misplaced while instead of if
Date:   Mon,  3 Aug 2020 11:02:10 +0200
Message-Id: <20200803110209.253009ae41ff.I3522aad099392b31d5cf2dcca34cbac7e5832dde@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This never was intended to be a 'while' loop, it should've
just been an 'if' instead of 'while'. Fix this.

I noticed this while applying another patch from Ben that
intended to fix a busy loop at this spot.

Fixes: b16798f5b907 ("mac80211: mark station unauthorized before key removal")
Reported-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 1dc747de30cc..f2840d1d95cf 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1050,7 +1050,7 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 	might_sleep();
 	lockdep_assert_held(&local->sta_mtx);
 
-	while (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
+	if (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
 		ret = sta_info_move_state(sta, IEEE80211_STA_ASSOC);
 		WARN_ON_ONCE(ret);
 	}
-- 
2.26.2


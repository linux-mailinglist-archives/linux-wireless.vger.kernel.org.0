Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9371F2E2DD7
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Dec 2020 10:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgLZJjb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Dec 2020 04:39:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgLZJjb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Dec 2020 04:39:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ACD2221EA;
        Sat, 26 Dec 2020 09:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608975530;
        bh=cExNd86JSBKa2BA04CpeJlUzxqF3H/tkHDOQB53rA+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=X0qyWMPR2vNYcD392qpuFGP1in+uZ5VgXKcEfI3hUWmeRs9r3085Lpfhtg7B/DDmC
         vq0W4NGUVV7YdHUTe6z2OZbWbY+JI+KZ3hLl9W+wf59lrLlWYqaHS3cA5UfZiuAg8F
         FtLLh+ysiIMbS1l1Wx2LSsoqBFm2MHGx3SOp79tJ2E97pmPgNt3KHKrMDEXUhCtxrm
         WemPWvh87WutVPnvOUrb8rx7wfghm0GliIaHkpubgzXE1Pe8dxRWVCdhg0EkT8/Cwp
         HtOaGOQNHq4zbr4NpL7vouGR6Ae+cukL5YLwnQDoN7SFwQ8RJJ7LmqcAtQ9ZjNVC8c
         L+oEBD+l9xtqA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     toke@toke.dk, johannes@sipsolutions.net
Subject: [PATCH mac80211] mac80211: check if atf has been disabled in __ieee80211_schedule_txq
Date:   Sat, 26 Dec 2020 10:39:08 +0100
Message-Id: <93889406c50f1416214c079ca0b8c9faecc5143e.1608975195.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check if atf has been disabled in __ieee80211_schedule_txq() in order to
avoid a given sta is always put to the beginning of the active_txqs list
and never moved to the end since deficit is not decremented in
ieee80211_sta_register_airtime()

Fixes: b4809e9484da1 ("mac80211: Add airtime accounting and scheduling to TXQs")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 56a4d0d20a26..fa69644a14f9 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3836,7 +3836,7 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 		 * get immediately moved to the back of the list on the next
 		 * call to ieee80211_next_txq().
 		 */
-		if (txqi->txq.sta &&
+		if (txqi->txq.sta && local->airtime_flags &&
 		    wiphy_ext_feature_isset(local->hw.wiphy,
 					    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
 			list_add(&txqi->schedule_order,
-- 
2.29.2


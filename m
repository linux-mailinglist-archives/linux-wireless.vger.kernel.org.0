Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E942347B78A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 03:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhLUCA1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 21:00:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33932 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhLUB7g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 20:59:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CBAAB8110A;
        Tue, 21 Dec 2021 01:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70941C36AEB;
        Tue, 21 Dec 2021 01:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640051973;
        bh=EwU1W6zye0oxIzP4RBnEX/iAIIeFiHxwVjNWBI/c6GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWGLRK+9HAhQ/1pDkEJoWdeU+n7ipfxZU5CU1OFOZ6wy6Pt8l1w9W5/5z577xneF2
         AyGO5ICoI0+8kwsDCDOyD4HT/opXKwtkinPQTjxsj2x22nJyhoQKl/4lFXZhqhufQQ
         ZNKpLHBoG5dAoY8jqmR/T+/DN0MJnyS4bVYJBJtzLr86dZq/1qXNXB5mC17wZ8qAXr
         dc3DCJ+d48nprcvfMA176jH1h3R0ZqwrZAZenh56nfeX5AQBFb8DApQh3BPfpkzkXQ
         O5Zz7gfWsAARDWUJP7yhpnySGAzxRlLtvjQS2y+ztyr+GlWVleYdb0o8J5EfWyA3ar
         xIV2dl/eeBcng==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/19] mac80211: do drv_reconfig_complete() before restarting all
Date:   Mon, 20 Dec 2021 20:59:07 -0500
Message-Id: <20211221015914.116767-12-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221015914.116767-1-sashal@kernel.org>
References: <20211221015914.116767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 13dee10b30c058ee2c58c5da00339cc0d4201aa6 ]

When we reconfigure, the driver might do some things to complete
the reconfiguration. It's strange and could be broken in some
cases because we restart other works (e.g. remain-on-channel and
TX) before this happens, yet only start queues later.

Change this to do the reconfig complete when reconfiguration is
actually complete, not when we've already started doing other
things again.

For iwlwifi, this should fix a race where the reconfig can race
with TX, for ath10k and ath11k that also use this it won't make
a difference because they just start queues there, and mac80211
also stopped the queues and will restart them later as before.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20211129152938.cab99f22fe19.Iefe494687f15fd85f77c1b989d1149c8efdfdc36@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 5dfa26b533802..dcebb0eb8a4be 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2624,6 +2624,13 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		mutex_unlock(&local->sta_mtx);
 	}
 
+	/*
+	 * If this is for hw restart things are still running.
+	 * We may want to change that later, however.
+	 */
+	if (local->open_count && (!suspended || reconfig_due_to_wowlan))
+		drv_reconfig_complete(local, IEEE80211_RECONFIG_TYPE_RESTART);
+
 	if (local->in_reconfig) {
 		local->in_reconfig = false;
 		barrier();
@@ -2642,13 +2649,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 					IEEE80211_QUEUE_STOP_REASON_SUSPEND,
 					false);
 
-	/*
-	 * If this is for hw restart things are still running.
-	 * We may want to change that later, however.
-	 */
-	if (local->open_count && (!suspended || reconfig_due_to_wowlan))
-		drv_reconfig_complete(local, IEEE80211_RECONFIG_TYPE_RESTART);
-
 	if (!suspended)
 		return 0;
 
-- 
2.34.1


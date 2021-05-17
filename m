Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD3386BF3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhEQVJ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbhEQVJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 17:09:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58808C06175F
        for <linux-wireless@vger.kernel.org>; Mon, 17 May 2021 14:08:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1likT2-00AVFx-O0; Mon, 17 May 2021 23:08:00 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/4] mac80211: simplify ieee80211_add_station()
Date:   Mon, 17 May 2021 23:07:57 +0200
Message-Id: <20210517230754.55abd10056c0.I6f5a3b7b23347b2cdaf64e6d5ce1d9e904059654@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517230754.113b65febd5a.Ie0e1d58a2885e75f242cb6e06f3b9660117fef93@changeid>
References: <20210517230754.113b65febd5a.Ie0e1d58a2885e75f242cb6e06f3b9660117fef93@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no need to do some kind of weird err and RCU dance
just use sta_info_insert() directly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7a99892e5aba..0d29a9d1f910 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1693,15 +1693,7 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 	    test_sta_flag(sta, WLAN_STA_ASSOC))
 		rate_control_rate_init(sta);
 
-	err = sta_info_insert_rcu(sta);
-	if (err) {
-		rcu_read_unlock();
-		return err;
-	}
-
-	rcu_read_unlock();
-
-	return 0;
+	return sta_info_insert(sta);
 }
 
 static int ieee80211_del_station(struct wiphy *wiphy, struct net_device *dev,
-- 
2.31.1


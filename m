Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19177D03D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbjHOQlr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 12:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbjHOQlh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 12:41:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9185B0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=/2ZkFBJKy5WpRt26o7Iy74lduVHQFfgZcHJ8FOKFzg4=; t=1692117696; x=1693327296; 
        b=rBF8n5VTQGikcuEtXBs4yY7C9dAPPKeQH8IBPQAg++o71kaQpLKxXdaaeuVYvZaqWMi4dEaHLJP
        BM/UhQ7Fc2msF0D7ntRSrEiaJPx1dBZxmmbhXg0duNzvq9XEqwmdXITAJMasE0dhfnM7zAJVAo0O4
        EOikUwCbZO8epfnJRATM3WNZKAcIPjsEu1PBl1AvJo+36YldNoqn7S8JsHCAi1lV+U3dHA1a4wmIS
        uo62qhyWlIj0BMtVeG5zbraSn3Fxa2NQbjJr1JGne9VBNxTf++6qt9x1X6mU1JE4uzYdyrWZLakna
        ai4ADqmzDKvKK2dCkRjqja3NzvMdV5WEnVpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVx6s-0093WM-0k;
        Tue, 15 Aug 2023 18:41:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+999fac712d84878a7379@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: check for station first in client probe
Date:   Tue, 15 Aug 2023 18:41:32 +0200
Message-ID: <20230815184131.ebcf5435b717.If30b0a67f136b7e174638a979e04c9408675c599@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When probing a client, first check if we have it, and then
check for the channel context, otherwise you can trigger
the warning there easily by probing when the AP isn't even
started yet. Since a client existing means the AP is also
operating, we can then keep the warning.

Also simplify the moved code a bit.

Reported-by: syzbot+999fac712d84878a7379@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e7ac24603892..953f24166ffc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4133,19 +4133,20 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	mutex_lock(&local->mtx);
 
 	rcu_read_lock();
+	sta = sta_info_get_bss(sdata, peer);
+	if (!sta) {
+		ret = -ENOLINK;
+		goto unlock;
+	}
+
+	qos = sta->sta.wme;
+
 	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		ret = -EINVAL;
 		goto unlock;
 	}
 	band = chanctx_conf->def.chan->band;
-	sta = sta_info_get_bss(sdata, peer);
-	if (sta) {
-		qos = sta->sta.wme;
-	} else {
-		ret = -ENOLINK;
-		goto unlock;
-	}
 
 	if (qos) {
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-- 
2.41.0


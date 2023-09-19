Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140FD7A59FF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjISGed (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 02:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjISGeb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 02:34:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8F115
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 23:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=LRSu3FBEVbqu2CH/FpI6JhHJOW8DAQtGfL9v8FXZNts=; t=1695105264; x=1696314864; 
        b=U5gT7Oy469/mllFZQHd2OtYfin1OV1JFow2ggQVBV2fWeUEuvBzUpZUhLvy7hB9IFLR0mU7Y1w+
        OxH3grgMxIq3Qt7VFTFQo4p3gj0lyUscD3Jk8b6Vtv9/09qbLRG5JziFe0AC7/SlNz3rSSV8LEdaQ
        d8v8UBUEmTnRCHxKsw0d+3/IZYpaegd0t9pqfOYEmXKoKCvHzW1PUlnEYx+dtqUMmrny4NEGUoRyG
        7XZsLU6AUZD32Zc0HIWuDZyOsWvVKCFBNGzzTsPdShqh7vDfltStWp6MwhKGzXvVq4p7vSf4tzdgN
        blZtUQlU5mbYTRb7hGO2Ie07+FejYDNIqy6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qiUJQ-008tsE-25;
        Tue, 19 Sep 2023 08:34:21 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 1/2] wifi: mac80211: fix potential key use-after-free
Date:   Tue, 19 Sep 2023 08:34:15 +0200
Message-ID: <20230919083414.d97c3dfda70e.I058ce0718e73c97de9cd19f499d40891df984ece@changeid>
X-Mailer: git-send-email 2.41.0
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

When ieee80211_key_link() is called by ieee80211_gtk_rekey_add()
but returns 0 due to KRACK protection (identical key reinstall),
ieee80211_gtk_rekey_add() will still return a pointer into the
key, in a potential use-after-free. This normally doesn't happen
since it's only called by iwlwifi in case of WoWLAN rekey offload
which has its own KRACK protection, but still better to fix, do
that by returning an error code and converting that to success on
the cfg80211 boundary only, leaving the error for bad callers of
ieee80211_gtk_rekey_add().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: fdf7cb4185b6 ("mac80211: accept key reinstall without changing anything")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 3 +++
 net/mac80211/key.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 45e7a5d9c7d9..e883c41a2163 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -566,6 +566,9 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	err = ieee80211_key_link(key, link, sta);
+	/* KRACK protection, shouldn't happen but just silently accept key */
+	if (err == -EALREADY)
+		err = 0;
 
  out_unlock:
 	mutex_unlock(&local->sta_mtx);
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 13050dc9321f..84ba20c3e3dc 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -905,7 +905,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 */
 	if (ieee80211_key_identical(sdata, old_key, key)) {
 		ieee80211_key_free_unused(key);
-		ret = 0;
+		ret = -EALREADY;
 		goto out;
 	}
 
-- 
2.41.0


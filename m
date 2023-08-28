Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B9C78AF9D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjH1MGT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjH1MFr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893CF120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yBiVEMTd0DL39nD81c53OpjxjEYedL+UWVaGbDW+gu4=;
        t=1693224345; x=1694433945; b=asDoh7iTfzCLHV4NcLLnmC04gqYWV/m+ra2Rv2M5bsTThzx
        0PHdEBJ9LmzVQKTeb1CFTkPfru5eGjMKjXjy/uVieNuriEYTgs1Gr0LzHJdtNX9OWDvdjFuS4ErM8
        w0Wimj/0dm6VYUc8hOJ0elw8n068wl/qzz4k77Be10McwEf9SkNREIBBa2CvkyYEsx7QMhCO6QfrS
        DbRiVUOmHc6lNCJ8g0/f2C8E6GsBRU1P9vc6XkeFH8QUrDPKwAPCH71iGueVDBI9Bhw024T7rukJT
        5qjSKsL9RDD8rAptXOAp4XWd9G+4mxuXD6TKUxbhA3S+8+l8UEmKPs/sCZCwx4gQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab03-00Gjgt-15;
        Mon, 28 Aug 2023 14:05:43 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 30/40] wifi: mac80211: hold wiphy_lock around concurrency checks
Date:   Mon, 28 Aug 2023 13:59:58 +0200
Message-ID: <20230828135928.04daa44cf409.Iba518adcdb81c898d009114ae50a30e83e7f478a@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
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

We want to replace the locking in mac80211 by just the wiphy
mutex, so hold the lock here around concurrency checks for
the future where the chanctx_mtx used inside goes away.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e09fec1507a6..c528a4bb7f4f 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -430,12 +430,13 @@ static int ieee80211_open(struct net_device *dev)
 	if (!is_valid_ether_addr(dev->dev_addr))
 		return -EADDRNOTAVAIL;
 
+	wiphy_lock(sdata->local->hw.wiphy);
 	err = ieee80211_check_concurrent_iface(sdata, sdata->vif.type);
 	if (err)
-		return err;
+		goto out;
 
-	wiphy_lock(sdata->local->hw.wiphy);
 	err = ieee80211_do_open(&sdata->wdev, true);
+out:
 	wiphy_unlock(sdata->local->hw.wiphy);
 
 	return err;
-- 
2.41.0


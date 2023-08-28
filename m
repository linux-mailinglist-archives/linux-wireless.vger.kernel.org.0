Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A80D78B159
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjH1NJk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 09:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjH1NJd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 09:09:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB429D
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=5yi49mfdGIOp96pkHby9afyXCFwBPcgol8l4fI6JCa8=; t=1693228170; x=1694437770; 
        b=N8T4w3p941Nw5pTtED7JNO2IkkMag/H6mRe6KloRe8Lj7Wu5pnkxqge9zHPPLp3tISs09aDYfZw
        N4bSgUZYjFvZ77KVzj0UyGhxnPcniMRjrYzsHJJ9H/9276j3halz+fB55d5Qd5gXvCjv5Qw0r8x5t
        a7gFwt1rP3kCJ71twe3hYxiJHAthcDW+oNNPXddZ+DJ0ST9qWL9cWaLzLeb9JhfozNEilTgdDsAjv
        QSbiiRkgrWPqzlRtNU8KoWrVFR7NAWmXWU1cd5QNkwZ4RcBp/jPXOHCFI9kJSAZ9SH/mD/WJUCo9n
        1g3kbGdTk66UXlcHOciU+fLSU7F7Fh/+NfGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qabzj-00Go8O-0x;
        Mon, 28 Aug 2023 15:09:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 1/4] wifi: mac80211: tx: clarify conditions in if statement
Date:   Mon, 28 Aug 2023 15:09:23 +0200
Message-ID: <20230828150922.c5182ba79e0f.I5efd1399be8e6dedc1e48982b7f20c531ff37616@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This really just reformats the statement, but makes it
more readable.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 7fe7280e8437..3a5b41c2ee3d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2855,9 +2855,10 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		goto free;
 	}
 
-	if (unlikely(!multicast && ((skb->sk &&
-		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ||
-		     ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS)))
+	if (unlikely(!multicast &&
+		     ((skb->sk &&
+		       skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ||
+		      ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS)))
 		info_id = ieee80211_store_ack_skb(local, skb, &info_flags,
 						  cookie);
 
-- 
2.41.0


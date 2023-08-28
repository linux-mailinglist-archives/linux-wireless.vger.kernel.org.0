Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57A678AF60
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjH1L7p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 07:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjH1L7X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 07:59:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70972122
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=5yi49mfdGIOp96pkHby9afyXCFwBPcgol8l4fI6JCa8=; t=1693223960; x=1694433560; 
        b=O19jOeiLH3NxqK/41NRLFztelwOwsvU4iIkP9lws1czcj/gmPqqzaXn1HYmcArlv4A5cUKYAfdU
        1MWqBnbhMlgaXGQbO5sktATHcu6/NAQUatP/zDYRWYO08x8tYN19+TGXt3Rap082snNET6ODcNd1z
        jO7xCdpIVukmRGLgEiWC09xsjtEr2S6JDYmpVjCCe2QivXQ7/pMdAwAJEP5J5XqC+89lyReSXHknF
        DDTOAJ2LNhwll9z4+mrZpjsTK6uDV63ExRzdjSFR5+0y1AgMS1/2K1nWWJ3oDCtH4waGbDeKtWqQl
        8VN5/cewyNcwaIqTCXXwCxWNhdrxBZ/zsqSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaatp-00GjIn-13;
        Mon, 28 Aug 2023 13:59:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/4] wifi: mac80211: tx: clarify conditions in if statement
Date:   Mon, 28 Aug 2023 13:58:59 +0200
Message-ID: <20230828135858.c5182ba79e0f.I5efd1399be8e6dedc1e48982b7f20c531ff37616@changeid>
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


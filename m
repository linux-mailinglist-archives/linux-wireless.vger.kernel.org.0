Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1869C5F75B5
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Oct 2022 11:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJGJFT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJGJFR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 05:05:17 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619AF7F138
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KLnUyUxmIoYwBmiwoJN9ZWyuBI+oze9qdKD7WvSerEk=; b=PucM57S5XFvh58kleH3kAFEm3/
        28lUs1tl8JhdrZebtnxtDOGJNS55LulSHw8otud1WWvAb4ygz5ipiLOGQH45SraUWuyUg/01p57pU
        371OL2XwUYvJUuDi9hfT23k8f9p++u8+ZVr9nd0MN9RKul+ROb34435JZKDE2eGeIURo=;
Received: from p200300daa7301d00c861250ac39289eb.dip0.t-ipconnect.de ([2003:da:a730:1d00:c861:250a:c392:89eb] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ogjI8-00Ayi8-04; Fri, 07 Oct 2022 11:05:12 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Chad Monroe <chad.monroe@smartrg.com>
Subject: [PATCH 6.1 2/2] wifi: mac80211: do not drop packets smaller than the LLC-SNAP header on fast-rx
Date:   Fri,  7 Oct 2022 11:05:09 +0200
Message-Id: <20221007090509.18503-2-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221007090509.18503-1-nbd@nbd.name>
References: <20221007090509.18503-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since STP TCN frames are only 7 bytes, the pskb_may_pull call returns an error.
Instead of dropping those packets, bump them back to the slow path for proper
processing.

Fixes: 49ddf8e6e234 ("mac80211: add fast-rx path")
Reported-by: Chad Monroe <chad.monroe@smartrg.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 9183e5f1ad29..589521717c35 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4709,7 +4709,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 
 	if (!(status->rx_flags & IEEE80211_RX_AMSDU)) {
 		if (!pskb_may_pull(skb, snap_offs + sizeof(*payload)))
-			goto drop;
+			return false;
 
 		payload = (void *)(skb->data + snap_offs);
 
-- 
2.36.1


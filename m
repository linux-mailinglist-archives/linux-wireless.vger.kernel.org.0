Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94741263304
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgIIQzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 12:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730599AbgIIPwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:52:31 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AE5C061798
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 04:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=S3W/Lj5seWBSHQmGwrH1oj7Gg/MLfvXUG7iE1G9mPIM=; b=IxJax5gdXCO4ohhf8pBOHJYIWR
        QKCJfhSwpYFfi9dLaD+5fZH4wanpD/0+zyQo4Fs3JLn5q/ofYSN6S0hifvNcOC5mYWd/tZ2mkyRLI
        GuRjSllrtHYZJ0OIDpZZ4Y6/a+u4PAxjYzusuwyjptiuLfcg9g1N0u4/Kgz/JjokWXPU=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFyho-0006Ix-2b; Wed, 09 Sep 2020 13:56:04 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.9 2/2] mac80211: add AQL support for VHT160 tx rates
Date:   Wed,  9 Sep 2020 13:56:02 +0200
Message-Id: <20200909115602.21783-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909115602.21783-1-nbd@nbd.name>
References: <20200909115602.21783-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When converting from struct ieee80211_tx_rate to ieee80211_rx_status,
there was one check missing to fill in the bandwidth for 160 MHz

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/airtime.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 45140e535151..26d2f8ba7029 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -560,7 +560,9 @@ static int ieee80211_fill_rx_status(struct ieee80211_rx_status *stat,
 	if (rate->idx < 0 || !rate->count)
 		return -1;
 
-	if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+	if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
+		stat->bw = RATE_INFO_BW_160;
+	else if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
 		stat->bw = RATE_INFO_BW_80;
 	else if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
 		stat->bw = RATE_INFO_BW_40;
-- 
2.28.0


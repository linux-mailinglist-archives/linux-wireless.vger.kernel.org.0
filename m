Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5425A26A16B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Sep 2020 10:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgIOI7w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Sep 2020 04:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIOI7u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Sep 2020 04:59:50 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61242C061788
        for <linux-wireless@vger.kernel.org>; Tue, 15 Sep 2020 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=S3W/Lj5seWBSHQmGwrH1oj7Gg/MLfvXUG7iE1G9mPIM=; b=WGAJ2KbfwpfMhHpnfv2vj74O1N
        dZEzw547Wd6gVTWezUKwO16ZZWy2es1IBo7FIEN4kEKhEMytp0Az6IJDGoKhkRwbE6HSZ9VjO802x
        IMLpJWSt2dLdBCFKUnEYzZ91uMrbwwRSYiYYr5mzn1gMQWJlNcFk4wFOK4j5JKBI8yXM=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kI6oV-00064H-2V; Tue, 15 Sep 2020 10:59:47 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, toke@redhat.com
Subject: [PATCH 5.9 v2 2/2] mac80211: add AQL support for VHT160 tx rates
Date:   Tue, 15 Sep 2020 10:59:45 +0200
Message-Id: <20200915085945.3782-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915085945.3782-1-nbd@nbd.name>
References: <20200915085945.3782-1-nbd@nbd.name>
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


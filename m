Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0F2F783C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 13:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbhAOMDu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 07:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbhAOMDt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 07:03:49 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B2C06179B
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jan 2021 04:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9k/exsfZa3rvg7x7pBpbm55Uw2AMj4el3amiL1W/WbI=; b=oY+2fKwtdiEEN+2B/NtEviEr2S
        0rBqdWUCvTbxRZcTjGxOElEg0P+3v/P2avJTdT67iK01mVcXF76pP7ZRkdpkyEnFj3TW23h7Hdoay
        ak8avXdcN2eSr4OfbQS4PgbWl/wYu1YjsL6ECGgQpiif8I2gAYIUHXePa7qkCkCUr/4s=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l0NoV-0006Y0-7G; Fri, 15 Jan 2021 13:02:47 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v3 8/9] mac80211: minstrel_ht: increase stats update interval
Date:   Fri, 15 Jan 2021 13:02:41 +0100
Message-Id: <20210115120242.89616-9-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210115120242.89616-1-nbd@nbd.name>
References: <20210115120242.89616-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The shorter interval was leading to too many frames being used for probing

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index d3bead4b5b04..6496aa39f60b 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1865,7 +1865,7 @@ minstrel_ht_alloc(struct ieee80211_hw *hw)
 		mp->has_mrr = true;
 
 	mp->hw = hw;
-	mp->update_interval = HZ / 20;
+	mp->update_interval = HZ / 10;
 
 	minstrel_ht_init_cck_rates(mp);
 	for (i = 0; i < ARRAY_SIZE(mp->hw->wiphy->bands); i++)
-- 
2.28.0


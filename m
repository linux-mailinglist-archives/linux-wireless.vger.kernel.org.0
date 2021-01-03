Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2464F2E8C05
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jan 2021 12:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbhACLwo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Jan 2021 06:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbhACLwl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Jan 2021 06:52:41 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C4C061795
        for <linux-wireless@vger.kernel.org>; Sun,  3 Jan 2021 03:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KrY41mNexjt1HP1pekyxBBbNDHxgJowu7G8nFgBwy3A=; b=ZzxHfNz2CzUgHFpGlJJutOWhA9
        oJmaTlTCGWpPYoDLSW1YfxZrJ1N1gOHusfTRqnrYMjibt8wztguVQc/Eq4YqhMeADDb3qoyq1TPPy
        kKcVvwYQHet7h9LWvByVKueINmK4DTAub2kKswchudU2TXZzz3OKRVA9KrJZyx+xGpuo=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kw1vD-0000gv-H6; Sun, 03 Jan 2021 12:51:43 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 8/8] mac80211: minstrel_ht: increase stats update interval
Date:   Sun,  3 Jan 2021 12:51:40 +0100
Message-Id: <20210103115140.18614-8-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210103115140.18614-1-nbd@nbd.name>
References: <20210103115140.18614-1-nbd@nbd.name>
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
index b80495cc4dce..bfc46e0f95db 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1864,7 +1864,7 @@ minstrel_ht_alloc(struct ieee80211_hw *hw)
 		mp->has_mrr = true;
 
 	mp->hw = hw;
-	mp->update_interval = HZ / 20;
+	mp->update_interval = HZ / 10;
 
 	minstrel_ht_init_cck_rates(mp);
 	for (i = 0; i < ARRAY_SIZE(mp->hw->wiphy->bands); i++)
-- 
2.28.0


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B219B2E8C02
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jan 2021 12:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbhACLwm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Jan 2021 06:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbhACLwl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Jan 2021 06:52:41 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E34C0613D3
        for <linux-wireless@vger.kernel.org>; Sun,  3 Jan 2021 03:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Rq3gq4RyV7FSvf2OBOhD4HjvRyFRLwP4U7dMtG2ytI8=; b=gWzGm4l1oX0sZTP0Ixfx+/5RPY
        nQDA/6NcZ3DzSHmTCIYTz1huP9itQt+yfaz8ePnTDGU487OYO1EedtZEde5aeOFeHE0AixLH+zdYR
        zONVfMKccPrvj1vkid5EB1FMHuj6inu88XeOphbIDGVh6N0RfUnvhXg4YYTAS8jJVMjk=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kw1vD-0000gv-3s; Sun, 03 Jan 2021 12:51:43 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 6/8] mac80211: minstrel_ht: improve sample rate selection
Date:   Sun,  3 Jan 2021 12:51:38 +0100
Message-Id: <20210103115140.18614-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210103115140.18614-1-nbd@nbd.name>
References: <20210103115140.18614-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Always allow sampling of rates faster than the primary max throughput rate.
When the second max_tp_rate is higher than the first one, sample attempts were
previously skipped, potentially causing rate control to get stuck at a slightly
lower rate

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 5b20e17ec2e6..58f7400b78b2 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1379,13 +1379,13 @@ minstrel_get_sample_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 	mrs = &mg->rates[sample_idx];
 	sample_idx += sample_group * MCS_GROUP_RATES;
 
-	/* Set tp_rate1, tp_rate2 to the highest / second highest max_tp_rate */
+	tp_rate1 = mi->max_tp_rate[0];
+
+	/* Set tp_rate2 to the second highest max_tp_rate */
 	if (minstrel_get_duration(mi->max_tp_rate[0]) >
 	    minstrel_get_duration(mi->max_tp_rate[1])) {
-		tp_rate1 = mi->max_tp_rate[1];
 		tp_rate2 = mi->max_tp_rate[0];
 	} else {
-		tp_rate1 = mi->max_tp_rate[0];
 		tp_rate2 = mi->max_tp_rate[1];
 	}
 
-- 
2.28.0


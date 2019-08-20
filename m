Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F495BB5
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfHTJyv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 05:54:51 -0400
Received: from nbd.name ([46.4.11.11]:35134 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTJyv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 05:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tTp1fjksS0JpZH20cKYmebD4iIPFT82tIq/AMBeJzhQ=; b=LRrmS6+bVD1sXmNJBo7MIFHByt
        25mvakMZJrnze/9fA1a+Okg2DR/Rqhc8zKGf6JFZR7jmEIgKOLFb71smCg8ewKqEX49YOSzf9CRpO
        B9fnVX6mi3mt+9zQtYq9R8WmQuhHOKNWxrayZF9gm9H+kgqXrA32Oh1FgeywhHeqegeY=;
Received: from p54ae9443.dip0.t-ipconnect.de ([84.174.148.67] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i00qn-0003nu-V9; Tue, 20 Aug 2019 11:54:50 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 5788063E610C; Tue, 20 Aug 2019 11:54:49 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 1/4] mac80211: minstrel_ht: fix per-group max throughput rate initialization
Date:   Tue, 20 Aug 2019 11:54:46 +0200
Message-Id: <20190820095449.45255-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The group number needs to be multiplied by the number of rates per group
to get the full rate index

Fixes: 5935839ad73583 ("mac80211: improve minstrel_ht rate sorting by throughput & probability")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 5a882da82f0e..ba230b037257 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -575,7 +575,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 
 		/* (re)Initialize group rate indexes */
 		for(j = 0; j < MAX_THR_RATES; j++)
-			tmp_group_tp_rate[j] = group;
+			tmp_group_tp_rate[j] = MCS_GROUP_RATES * group;
 
 		for (i = 0; i < MCS_GROUP_RATES; i++) {
 			if (!(mi->supported[group] & BIT(i)))
-- 
2.17.0


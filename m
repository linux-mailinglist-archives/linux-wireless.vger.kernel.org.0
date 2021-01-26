Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5BE3042D2
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 16:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391255AbhAZPp2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 10:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391958AbhAZPpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 10:45:11 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8986C061A29
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jan 2021 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XAOl6Gr+MjIDiMkLNr0RdlUD3qcUIb5ZRjkvkP9PH5I=; b=gK3Cb5Xu0e7hnoonpVYvyGNMSr
        5B9FnRbus3Jg5Mq/FTwug+VURfxO7hQNIjzur63pRrbWC0bFlVjD9XSBc4YMIkkcthNX9Mq+W2Rbt
        MbFI8/eo2hXogX51ZBfl3pctgPhzDKtWzgZCx/BqYCjEbSm/TGKcFZl+06LwIUosrBVM=;
Received: from p54ae953c.dip0.t-ipconnect.de ([84.174.149.60] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l4QVo-0007Dc-Vg; Tue, 26 Jan 2021 16:44:13 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: minstrel_ht: fix regression in the max_prob_rate fix
Date:   Tue, 26 Jan 2021 16:44:09 +0100
Message-Id: <20210126154409.6755-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since mi->max_prob_rate is overwritten after the loop that calls
minstrel_ht_set_best_prob_rate, the new best rate needs to be written to *dest

Fixes: a7fca4e4037f ("mac80211: minstrel_ht: fix max probability rate selection")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 8e9e30c468a6..d48798fa15cb 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -545,7 +545,7 @@ minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 *dest, u16 index)
 		cur_tp_avg = minstrel_ht_get_tp_avg(mi, cur_group, cur_idx,
 						    mrs->prob_avg);
 		if (cur_tp_avg > tmp_tp_avg)
-			mi->max_prob_rate = index;
+			*dest = index;
 
 		max_gpr_tp_avg = minstrel_ht_get_tp_avg(mi, max_gpr_group,
 							max_gpr_idx,
-- 
2.28.0


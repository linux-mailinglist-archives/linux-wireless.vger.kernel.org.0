Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FEC2AF7FA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 19:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgKKSeE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 13:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgKKSeD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 13:34:03 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D77C0613D1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Nov 2020 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mUQJj/5A6aqLOlEFlwB9HFVaFwNXf6zvmBqCM09Y7ww=; b=K2aS83x1+C9oO+MXikl70fw+Jr
        LzhUBluUBYka1d+1ceHP7Q/HSrE1fEohcKigiNwpU9EJWh/kbaeH2AgM7LzOgfMEn5krw/zRz1/Rt
        svxOdnNlNlkR6uxDh5e//X/MGdSWvWCz2wU3OGgeRFgHXsz6fQbvAKWth3zkDmEVn1LQ=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kcuwT-00034H-7F; Wed, 11 Nov 2020 19:34:01 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.10 3/3] mac80211: minstrel: fix tx status processing corner case
Date:   Wed, 11 Nov 2020 19:33:59 +0100
Message-Id: <20201111183359.43528-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111183359.43528-1-nbd@nbd.name>
References: <20201111183359.43528-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some drivers fill the status rate list without setting the rate index after
the final rate to -1. minstrel_ht already deals with this, but minstrel
doesn't, which causes it to get stuck at the lowest rate on these drivers.

Fix this by checking the count as well.

Cc: stable@vger.kernel.org
Fixes: cccf129f820e ("mac80211: add the 'minstrel' rate control algorithm")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rc80211_minstrel.c b/net/mac80211/rc80211_minstrel.c
index a8a940e97a9a..b13b1da19386 100644
--- a/net/mac80211/rc80211_minstrel.c
+++ b/net/mac80211/rc80211_minstrel.c
@@ -274,7 +274,7 @@ minstrel_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	success = !!(info->flags & IEEE80211_TX_STAT_ACK);
 
 	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
-		if (ar[i].idx < 0)
+		if (ar[i].idx < 0 || !ar[i].count)
 			break;
 
 		ndx = rix_to_ndx(mi, ar[i].idx);
-- 
2.28.0


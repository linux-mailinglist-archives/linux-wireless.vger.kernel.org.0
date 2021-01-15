Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643522F7845
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 13:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbhAOMEP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 07:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbhAOMEP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 07:04:15 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF4C06179C
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jan 2021 04:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OVQpEEDveWeQgJiIBCw9TIVF7ODOND/QMES/7ziT390=; b=IbqAymDswBEYitg+EClnkQUyZM
        9a6Bgzzi9qfNRdX+BdtAVMmDsffO+k1JaEgRBddaz7eNSRJHhHvPZCrPTudwyO0aDhbkojOcFhjjC
        hQzqer8ALxmA95OPA+yQWEyGPfUdkwZELoG4Vo9FLA9NciiBI5S6Y4mm6Elfjm1S03JQ=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l0NoV-0006Y0-Ds; Fri, 15 Jan 2021 13:02:47 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v3 9/9] mac80211: minstrel_ht: fix rounding error in throughput calculation
Date:   Fri, 15 Jan 2021 13:02:42 +0100
Message-Id: <20210115120242.89616-10-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210115120242.89616-1-nbd@nbd.name>
References: <20210115120242.89616-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On lower data rates, the throughput calculation has a significant rounding
error, causing rates like 48M and 54M OFDM to share the same throughput
value with >= 90% success probablity.

This is because the result of the division (prob_avg * 1000) / nsecs
is really small (8 in this example).

Improve accuracy by moving over some zeroes, making better use of the full
range of u32 before the division.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 6496aa39f60b..9e010c8dd063 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -445,10 +445,9 @@ minstrel_ht_get_tp_avg(struct minstrel_ht_sta *mi, int group, int rate,
 	 * (prob is scaled - see MINSTREL_FRAC above)
 	 */
 	if (prob_avg > MINSTREL_FRAC(90, 100))
-		return MINSTREL_TRUNC(100000 * ((MINSTREL_FRAC(90, 100) * 1000)
-								      / nsecs));
-	else
-		return MINSTREL_TRUNC(100000 * ((prob_avg * 1000) / nsecs));
+		prob_avg = MINSTREL_FRAC(90, 100);
+
+	return MINSTREL_TRUNC(100 * ((prob_avg * 1000000) / nsecs));
 }
 
 /*
-- 
2.28.0


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F47D2632FE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 18:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgIIQzP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 12:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbgIIPwj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:52:39 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA81C061797
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 04:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ggZD/IaPV7dTTeEWa6PoBMa66z1vyjZ1H4UdFj0yw3Y=; b=T/0yg8TwKqUgusjDVLJCID2/w5
        sHDvrdFQU6pnPCMb/2ZNEvlnWMevD6pM8+UjaWHE93Gz5Ut+qhsHqhVRNgw8HC4YUuWtEKLUiR2m8
        9Qqj8MBugImUGyA0rnLiJzPEcrQxtfIVbcGrX+jqPZcsjX3V/ekz3f47v16gO5lNCD/4=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFyhn-0006Ix-SD; Wed, 09 Sep 2020 13:56:03 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.9 1/2] mac80211: extend AQL aggregation estimation to HE and fix unit mismatch
Date:   Wed,  9 Sep 2020 13:56:01 +0200
Message-Id: <20200909115602.21783-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The unit of the return value of ieee80211_get_rate_duration is nanoseconds, not
milliseconds. Adjust the duration checks to account for that.
For higher data rates, allow larger estimated aggregation sizes, and add some
values for HE as well, which can use much larger aggregates.
Since small packets with high data rates can now lead to duration values too
small for info->tx_time_est, return a minimum of 4us.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/airtime.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 314973033d03..45140e535151 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -668,20 +668,26 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 		 * This will not be very accurate, but much better than simply
 		 * assuming un-aggregated tx in all cases.
 		 */
-		if (duration > 400) /* <= VHT20 MCS2 1S */
+		if (duration > 400 * 1024) /* <= VHT20 MCS2 1S */
 			agg_shift = 1;
-		else if (duration > 250) /* <= VHT20 MCS3 1S or MCS1 2S */
+		else if (duration > 250 * 1024) /* <= VHT20 MCS3 1S or MCS1 2S */
 			agg_shift = 2;
-		else if (duration > 150) /* <= VHT20 MCS5 1S or MCS3 2S */
+		else if (duration > 150 * 1024) /* <= VHT20 MCS5 1S or MCS2 2S */
 			agg_shift = 3;
-		else
+		else if (duration > 70 * 1024) /* <= VHT20 MCS5 2S */
 			agg_shift = 4;
+		else if (stat.encoding != RX_ENC_HE ||
+			 duration > 20 * 1024) /* <= HE40 MCS6 2S */
+			agg_shift = 5;
+		else
+			agg_shift = 6;
 
 		duration *= len;
 		duration /= AVG_PKT_SIZE;
 		duration /= 1024;
+		duration += (overhead >> agg_shift);
 
-		return duration + (overhead >> agg_shift);
+		return max_t(u32, duration, 4);
 	}
 
 	if (!conf)
-- 
2.28.0


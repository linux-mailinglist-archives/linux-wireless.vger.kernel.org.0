Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9426DC08
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgIQMur (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 08:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgIQMuj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 08:50:39 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76609C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 17 Sep 2020 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZQWmms9IHekLSWdvPYDSutVwV5lVClq29+tMl16AEJM=; b=iQstjQkP+Qqj5XNum9pk324IXo
        5hBvpSPQWz4JYqvRjKeB2/GZADrZ9vUHr4Is6jiJv5kNxHGGtC/nH7LhQ669FsKowCYN3seLsi1uD
        6icml9rtg+qd+rlrIwBpExLlBZkVdZkZtlISxLYbXYM4NiP8FZqz51aIbZl7kAvTiGS0=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kItMu-0006KQ-Tw; Thu, 17 Sep 2020 14:50:32 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: do not allow bigger VHT MPDUs than the hardware supports
Date:   Thu, 17 Sep 2020 14:50:31 +0200
Message-Id: <20200917125031.45009-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Limit maximum VHT MPDU size by local capability

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/vht.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 7e601d067d53..fb0e3a657d2d 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -168,10 +168,7 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	/* take some capabilities as-is */
 	cap_info = le32_to_cpu(vht_cap_ie->vht_cap_info);
 	vht_cap->cap = cap_info;
-	vht_cap->cap &= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895 |
-			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
-			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
-			IEEE80211_VHT_CAP_RXLDPC |
+	vht_cap->cap &= IEEE80211_VHT_CAP_RXLDPC |
 			IEEE80211_VHT_CAP_VHT_TXOP_PS |
 			IEEE80211_VHT_CAP_HTC_VHT |
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
@@ -180,6 +177,9 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 			IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN |
 			IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN;
 
+	vht_cap->cap |= min_t(u32, cap_info & IEEE80211_VHT_CAP_MAX_MPDU_MASK,
+			      own_cap.cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK);
+
 	/* and some based on our own capabilities */
 	switch (own_cap.cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
 	case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
-- 
2.28.0


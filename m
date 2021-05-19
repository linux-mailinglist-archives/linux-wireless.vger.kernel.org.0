Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDDF388DE2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346511AbhESMWE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 08:22:04 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54567 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346486AbhESMWD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 08:22:03 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <pborgers@zedat.fu-berlin.de>)
          id 1ljLBr-00039K-Lf; Wed, 19 May 2021 14:20:43 +0200
Received: from a36t-ffs1.berlin.freifunk.net ([77.87.51.11] helo=mi.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <borgers@mi.fu-berlin.de>)
          id 1ljLBq-000PKX-G7; Wed, 19 May 2021 14:20:43 +0200
Received: by mi.fu-berlin.de (sSMTP sendmail emulation); Wed, 19 May 2021 14:20:42 +0200
From:   Philipp Borgers <borgers@mi.fu-berlin.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Subject: [PATCH v2 3/3] mac80211: refactor rc_no_data_or_no_ack_use_min function
Date:   Wed, 19 May 2021 14:20:19 +0200
Message-Id: <20210519122019.92359-4-borgers@mi.fu-berlin.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519122019.92359-1-borgers@mi.fu-berlin.de>
References: <20210519122019.92359-1-borgers@mi.fu-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: borgers@mi.fu-berlin.de
X-Originating-IP: 77.87.51.11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use newly introduced helper function ieee80211_is_tx_data to check if
frame is a data frame. Takes into account that hardware encapsulation
can be enabled for a frame and therefore no ieee80211 header is present.

Signed-off-by: Philipp Borgers <borgers@mi.fu-berlin.de>
---
 net/mac80211/rate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index fa1c73d0ceff..208bd0c2b671 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -297,15 +297,11 @@ void ieee80211_check_rate_mask(struct ieee80211_sub_if_data *sdata)
 static bool rc_no_data_or_no_ack_use_min(struct ieee80211_tx_rate_control *txrc)
 {
 	struct sk_buff *skb = txrc->skb;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	__le16 fc;
-
-	fc = hdr->frame_control;
 
 	return (info->flags & (IEEE80211_TX_CTL_NO_ACK |
 			       IEEE80211_TX_CTL_USE_MINRATE)) ||
-		!ieee80211_is_data(fc);
+		!ieee80211_is_tx_data(skb);
 }
 
 static void rc_send_low_basicrate(struct ieee80211_tx_rate *rate,
-- 
2.31.1


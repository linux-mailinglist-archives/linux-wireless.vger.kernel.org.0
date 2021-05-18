Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454E838771D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 May 2021 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348329AbhERLJk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 May 2021 07:09:40 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:45569 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348290AbhERLJj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 May 2021 07:09:39 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <pborgers@zedat.fu-berlin.de>)
          id 1lixaH-003tl1-32; Tue, 18 May 2021 13:08:21 +0200
Received: from a36t-ffs1.berlin.freifunk.net ([77.87.51.11] helo=mi.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <borgers@mi.fu-berlin.de>)
          id 1lixaF-001ULR-SE; Tue, 18 May 2021 13:08:21 +0200
Received: by mi.fu-berlin.de (sSMTP sendmail emulation); Tue, 18 May 2021 13:08:19 +0200
From:   Philipp Borgers <borgers@mi.fu-berlin.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Subject: [PATCH 2/2] mac80211: refactor rc_no_data_or_no_ack_use_min function
Date:   Tue, 18 May 2021 13:07:55 +0200
Message-Id: <20210518110755.43077-2-borgers@mi.fu-berlin.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518110755.43077-1-borgers@mi.fu-berlin.de>
References: <20210518110755.43077-1-borgers@mi.fu-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: borgers@mi.fu-berlin.de
X-Originating-IP: 77.87.51.11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Philipp Borgers <borgers@mi.fu-berlin.de>
---
 net/mac80211/rate.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 4f5b35a0ea28..ae8d595aa2c2 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -294,18 +294,11 @@ void ieee80211_check_rate_mask(struct ieee80211_sub_if_data *sdata)
 	sdata->rc_rateidx_mask[band] = (1 << sband->n_bitrates) - 1;
 }
 
-static bool rc_no_data_or_no_ack_use_min(struct ieee80211_tx_rate_control *txrc)
+static bool rc_no_data_or_no_ack_use_min(u32 flags, __le16 frame_control)
 {
-	struct sk_buff *skb = txrc->skb;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	__le16 fc;
-
-	fc = hdr->frame_control;
-
-	return (info->flags & (IEEE80211_TX_CTL_NO_ACK |
+	return (flags & (IEEE80211_TX_CTL_NO_ACK |
 			       IEEE80211_TX_CTL_USE_MINRATE)) ||
-		!ieee80211_is_data(fc);
+		!ieee80211_is_data(frame_control);
 }
 
 static void rc_send_low_basicrate(struct ieee80211_tx_rate *rate,
@@ -396,12 +389,13 @@ static bool rate_control_send_low(struct ieee80211_sta *pubsta,
 	struct sta_info *sta;
 	int mcast_rate;
 	bool use_basicrate = false;
+	__le16 frame_control = hdr->frame_control;
 
-	if (ieee80211_is_data(hdr->frame_control) &&
+	if (ieee80211_is_data(frame_control) &&
 			(info->flags & IEEE80211_TX_CTL_NO_ACK))
 		return false;
 
-	if (!pubsta || rc_no_data_or_no_ack_use_min(txrc)) {
+	if (!pubsta || rc_no_data_or_no_ack_use_min(info->flags, frame_control)) {
 		__rate_control_send_low(txrc->hw, sband, pubsta, info,
 					txrc->rate_idx_mask);
 
-- 
2.31.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39CC388DE1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 14:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346488AbhESMWC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 08:22:02 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:41239 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346486AbhESMWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 08:22:01 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <pborgers@zedat.fu-berlin.de>)
          id 1ljLBp-00038k-4Q; Wed, 19 May 2021 14:20:41 +0200
Received: from a36t-ffs1.berlin.freifunk.net ([77.87.51.11] helo=mi.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <borgers@mi.fu-berlin.de>)
          id 1ljLBn-000PKK-Ul; Wed, 19 May 2021 14:20:41 +0200
Received: by mi.fu-berlin.de (sSMTP sendmail emulation); Wed, 19 May 2021 14:20:39 +0200
From:   Philipp Borgers <borgers@mi.fu-berlin.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Subject: [PATCH v2 2/3] mac80211: do not use low data rates for data frames with no ack flag
Date:   Wed, 19 May 2021 14:20:18 +0200
Message-Id: <20210519122019.92359-3-borgers@mi.fu-berlin.de>
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

Data Frames with no ack flag set should be handled by the rate
controler. Make sure we reach the rate controler by returning early
from rate_control_send_low if the frame is a data frame with no ack
flag.

Signed-off-by: Philipp Borgers <borgers@mi.fu-berlin.de>
---
 net/mac80211/rate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 63652c39c8e0..fa1c73d0ceff 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -396,6 +396,10 @@ static bool rate_control_send_low(struct ieee80211_sta *pubsta,
 	int mcast_rate;
 	bool use_basicrate = false;
 
+	if (ieee80211_is_tx_data(txrc->skb) &&
+			(info->flags & IEEE80211_TX_CTL_NO_ACK))
+		return false;
+
 	if (!pubsta || rc_no_data_or_no_ack_use_min(txrc)) {
 		__rate_control_send_low(txrc->hw, sband, pubsta, info,
 					txrc->rate_idx_mask);
-- 
2.31.1


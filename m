Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75C30272B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 16:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbhAYPrU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 10:47:20 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:41839 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730419AbhAYPrQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 10:47:16 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <pborgers@zedat.fu-berlin.de>)
          id 1l43TK-003mVf-Cv; Mon, 25 Jan 2021 16:08:06 +0100
Received: from a36t-ffs1.berlin.freifunk.net ([77.87.51.11] helo=mi.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <borgers@mi.fu-berlin.de>)
          id 1l43TI-003QZF-TX; Mon, 25 Jan 2021 16:08:06 +0100
Received: by mi.fu-berlin.de (sSMTP sendmail emulation); Mon, 25 Jan 2021 16:08:03 +0100
From:   Philipp Borgers <borgers@mi.fu-berlin.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Subject: [PATCH] mac80211: add STBC encoding to ieee80211_parse_tx_radiotap
Date:   Mon, 25 Jan 2021 16:07:44 +0100
Message-Id: <20210125150744.83065-1-borgers@mi.fu-berlin.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: borgers@mi.fu-berlin.de
X-Originating-IP: 77.87.51.11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for STBC encoding to the radiotap tx parse
function. Prior to this change adding the STBC flag to the radiotap
header did not encode frames with STBC.

Signed-off-by: Philipp Borgers <borgers@mi.fu-berlin.de>
---
 net/mac80211/tx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ebb3228ce971..cd53675d9955 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2038,6 +2038,7 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 	u16 vht_known;
 	u8 vht_mcs = 0, vht_nss = 0;
 	int i;
+	int stbc;
 
 	/* check for not even having the fixed radiotap header part */
 	if (unlikely(skb->len < sizeof(struct ieee80211_radiotap_header)))
@@ -2133,6 +2134,12 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 			if (mcs_known & IEEE80211_RADIOTAP_MCS_HAVE_BW &&
 			    mcs_bw == IEEE80211_RADIOTAP_MCS_BW_40)
 				rate_flags |= IEEE80211_TX_RC_40_MHZ_WIDTH;
+
+			if (mcs_known & IEEE80211_RADIOTAP_MCS_HAVE_STBC) {
+				stbc = mcs_flags & IEEE80211_RADIOTAP_MCS_STBC_MASK;
+				stbc = stbc >> IEEE80211_RADIOTAP_MCS_STBC_SHIFT;
+				info->flags |= stbc << IEEE80211_TX_CTL_STBC_SHIFT;
+			}
 			break;
 
 		case IEEE80211_RADIOTAP_VHT:
-- 
2.30.0


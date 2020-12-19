Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20452DF09D
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Dec 2020 18:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgLSRIj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Dec 2020 12:08:39 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:49635 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727186AbgLSRIj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Dec 2020 12:08:39 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <pborgers@zedat.fu-berlin.de>)
          id 1kqfi1-000Usq-Dp; Sat, 19 Dec 2020 18:07:57 +0100
Received: from a36t-ffs1.berlin.freifunk.net ([77.87.51.11] helo=mi.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <borgers@mi.fu-berlin.de>)
          id 1kqfi0-001v1t-7m; Sat, 19 Dec 2020 18:07:57 +0100
Received: by mi.fu-berlin.de (sSMTP sendmail emulation); Sat, 19 Dec 2020 18:07:55 +0100
From:   Philipp Borgers <borgers@mi.fu-berlin.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Subject: [PATCH] mac80211: add LDPC encoding to ieee80211_parse_tx_radiotap
Date:   Sat, 19 Dec 2020 18:07:10 +0100
Message-Id: <20201219170710.11706-1-borgers@mi.fu-berlin.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: borgers@mi.fu-berlin.de
X-Originating-IP: 77.87.51.11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for LDPC encoding to the radiotap tx parse
function. Piror to this change adding the LDPC flag to the radiotap
header did not encode frames with LDPC.

Signed-off-by: Philipp Borgers <borgers@mi.fu-berlin.de>
---
 net/mac80211/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8ba10a48ded4..7e84dad88b4e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2132,6 +2132,10 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 			if (mcs_known & IEEE80211_RADIOTAP_MCS_HAVE_BW &&
 			    mcs_bw == IEEE80211_RADIOTAP_MCS_BW_40)
 				rate_flags |= IEEE80211_TX_RC_40_MHZ_WIDTH;
+
+			if (mcs_known & IEEE80211_RADIOTAP_MCS_HAVE_FEC &&
+			    mcs_flags & IEEE80211_RADIOTAP_MCS_FEC_LDPC)
+				info->flags |= IEEE80211_TX_CTL_LDPC;
 			break;
 
 		case IEEE80211_RADIOTAP_VHT:
-- 
2.29.2


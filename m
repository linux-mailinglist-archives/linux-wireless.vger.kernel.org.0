Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAC4382BB3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 14:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhEQMDX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 08:03:23 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51259 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236859AbhEQMDX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 08:03:23 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <pborgers@zedat.fu-berlin.de>)
          id 1libwj-000zBK-Ik; Mon, 17 May 2021 14:02:05 +0200
Received: from a36t-ffs1.berlin.freifunk.net ([77.87.51.11] helo=mi.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <borgers@mi.fu-berlin.de>)
          id 1libwi-002qHZ-B1; Mon, 17 May 2021 14:02:05 +0200
Received: by mi.fu-berlin.de (sSMTP sendmail emulation); Mon, 17 May 2021 14:02:03 +0200
From:   Philipp Borgers <borgers@mi.fu-berlin.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Subject: [PATCH] mac80211: minstrel_ht: ignore frame that was sent with noAck flag
Date:   Mon, 17 May 2021 14:01:45 +0200
Message-Id: <20210517120145.132814-1-borgers@mi.fu-berlin.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: borgers@mi.fu-berlin.de
X-Originating-IP: 77.87.51.11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QoS Data Frames that were sent with a No Ack policy should be ignored by
the minstrel statistics. There will never be an Ack for these frames so
there is no way to draw conclusions about the success of the transmission.

Signed-off-by: Philipp Borgers <borgers@mi.fu-berlin.de>
---
 net/mac80211/rc80211_minstrel_ht.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 6487b05da6fa..4288ef4bf178 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1211,6 +1211,10 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	bool last, update = false;
 	int i;
 
+	/* Ignore packet that was sent with noAck flag */
+	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+		return;
+
 	/* This packet was aggregated but doesn't carry status info */
 	if ((info->flags & IEEE80211_TX_CTL_AMPDU) &&
 	    !(info->flags & IEEE80211_TX_STAT_AMPDU))
-- 
2.31.1


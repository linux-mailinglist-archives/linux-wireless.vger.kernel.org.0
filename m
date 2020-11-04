Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62622A5E13
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 07:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKDGTh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 01:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgKDGTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 01:19:36 -0500
Received: from rhcavuit01.kulnet.kuleuven.be (rhcavuit01.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F481C061A4D
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 22:19:36 -0800 (PST)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 98292120325.A2667
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit01.kulnet.kuleuven.be (Postfix) with ESMTP id 98292120325
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 07:19:34 +0100 (CET)
Received: from mathy-work.localhost (unknown [92.96.39.204])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id CFDBF200A1;
        Wed,  4 Nov 2020 07:19:32 +0100 (CET)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 4/5] mac80211: assure that certain drivers adhere to DONT_REORDER flag
Date:   Wed,  4 Nov 2020 10:18:22 +0400
Message-Id: <20201104061823.197407-5-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
References: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some drivers use skb->priority to determine on which queue to send
a frame. An example is mt76x2u (this was tested on an AWUS036ACM).
This means these drivers currently do not adhere to the DONT_REORDER
flag. To fix this, we do not set skb->priority based on the QoS TID
of injected frames when the DONT_REORDER flag is set.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 net/mac80211/tx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8bf80b675..1651cf7b2 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2271,8 +2271,13 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 						    payload[7]);
 	}
 
-	/* Initialize skb->priority for QoS frames */
-	if (ieee80211_is_data_qos(hdr->frame_control)) {
+	/* Initialize skb->priority for QoS frames. If the DONT_REORDER flag
+	 * is set, stick to the default value for skb->priority to assure
+	 * frames injected with this flag are not reordered relative to each
+	 * other.
+	 */
+	if (ieee80211_is_data_qos(hdr->frame_control) &&
+	    !(info->control.flags & IEEE80211_TX_CTRL_DONT_REORDER)) {
 		u8 *p = ieee80211_get_qos_ctl(hdr);
 		skb->priority = *p & IEEE80211_QOS_CTL_TAG1D_MASK;
 	}
-- 
2.28.0


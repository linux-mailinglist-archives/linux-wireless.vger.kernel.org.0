Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A04122BDBA
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 07:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGXFv7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 01:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgGXFv7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 01:51:59 -0400
Received: from rhcavuit02.kulnet.kuleuven.be (rhcavuit02.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D17C0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 22:51:59 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 346C9120338.AE804
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-1.cc.kuleuven.be (icts-p-smtps-1e.kulnet.kuleuven.be [134.58.240.33])
        by rhcavuit02.kulnet.kuleuven.be (Postfix) with ESMTP id 346C9120338
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 07:51:57 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-1.cc.kuleuven.be (Postfix) with ESMTPSA id CE9DA40B2;
        Fri, 24 Jul 2020 07:51:55 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [RFC 4/5] mac80211: assure that certain drivers adhere to DONT_REORDER flag
Date:   Fri, 24 Jul 2020 09:51:03 +0400
Message-Id: <20200724055104.105675-4-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724055104.105675-1-Mathy.Vanhoef@kuleuven.be>
References: <20200724054724.105520-1-Mathy.Vanhoef@kuleuven.be>
 <20200724055104.105675-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some drivers use skb->priority to determine on which queue to send
a frame. An example is mt76x2u (this was tested on an AWUS036ACM).
This means these drivers do not adhere to the DONT_REORDER flag.
To fix this, we do not set skb->priority based on the QoS TID of
injected frames when the DONT_REORDER flag is set.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 net/mac80211/tx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 96069683f..33697c5dc 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2266,8 +2266,12 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 						    payload[7]);
 	}
 
-	/* Initialize skb->priority for QoS frames */
-	if (ieee80211_is_data_qos(hdr->frame_control)) {
+	/* Initialize skb->priority for QoS frames. If the DONT_REORDER flag
+	 * is, stick to the default value to assure frames injected with this
+	 * flag are not reordered relative to each other.
+	 */
+	if (ieee80211_is_data_qos(hdr->frame_control) &&
+	    !(info->control.flags & IEEE80211_TX_CTRL_DONT_REORDER)) {
 		u8 *p = ieee80211_get_qos_ctl(hdr);
 		skb->priority = *p & IEEE80211_QOS_CTL_TAG1D_MASK;
 	}
-- 
2.27.0


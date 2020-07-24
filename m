Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F78522BDB9
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 07:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGXFvz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 01:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXFvz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 01:51:55 -0400
Received: from rhcavuit03.kulnet.kuleuven.be (rhcavuit03.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE5C0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 22:51:55 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 8060E12032F.AE601
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-1.cc.kuleuven.be (icts-p-smtps-1e.kulnet.kuleuven.be [134.58.240.33])
        by rhcavuit03.kulnet.kuleuven.be (Postfix) with ESMTP id 8060E12032F
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 07:51:52 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-1.cc.kuleuven.be (Postfix) with ESMTPSA id 082CB40B2;
        Fri, 24 Jul 2020 07:51:50 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [RFC 3/5] mac80211: don't overwrite QoS TID of injected frames
Date:   Fri, 24 Jul 2020 09:51:02 +0400
Message-Id: <20200724055104.105675-3-Mathy.Vanhoef@kuleuven.be>
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

Currently ieee80211_set_qos_hdr overwrites the QoS TID of injected
frames based on the value assigned to skb->priority. The commit
753ffad3d624 ("mac80211: fix TID field in monitor mode transmit")
worked around this problem by setting skb->priority to the TID of
the injected frame, which assured the QoS TID will not be changed
to a different value. Unfortunately, this workaround complicates
the handling of injected frames because we can't set skb->priority
without affecting the TID value of injected frames.

To avoid this, and to simplify the next patch, detect if a frame is
injected in ieee80211_set_qos_hdr and if so do not change its QoS
field.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 net/mac80211/tx.c  | 5 +----
 net/mac80211/wme.c | 8 ++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 23fa19148..96069683f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2266,10 +2266,7 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 						    payload[7]);
 	}
 
-	/*
-	 * Initialize skb->priority for QoS frames. This is put in the TID field
-	 * of the frame before passing it to the driver.
-	 */
+	/* Initialize skb->priority for QoS frames */
 	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		u8 *p = ieee80211_get_qos_ctl(hdr);
 		skb->priority = *p & IEEE80211_QOS_CTL_TAG1D_MASK;
diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index a49dd7f1f..e66d1463d 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -252,6 +252,14 @@ void ieee80211_set_qos_hdr(struct ieee80211_sub_if_data *sdata,
 
 	p = ieee80211_get_qos_ctl(hdr);
 
+	/* don't overwrite the QoS field of injected frames */
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
+		/* do take into account Ack policy of injected frames */
+		if (*p & IEEE80211_QOS_CTL_ACK_POLICY_NOACK)
+			info->flags |= IEEE80211_TX_CTL_NO_ACK;
+		return;
+	}
+
 	/* set up the first byte */
 
 	/*
-- 
2.27.0


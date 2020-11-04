Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593582A5E12
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 07:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgKDGTd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 01:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgKDGTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 01:19:33 -0500
Received: from rhcavuit03.kulnet.kuleuven.be (rhcavuit03.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E336CC061A4D
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 22:19:32 -0800 (PST)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 92ADA12032F.A1C46
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit03.kulnet.kuleuven.be (Postfix) with ESMTP id 92ADA12032F
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 07:19:30 +0100 (CET)
Received: from mathy-work.localhost (unknown [92.96.39.204])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id D17A8200A1;
        Wed,  4 Nov 2020 07:19:28 +0100 (CET)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 3/5] mac80211: don't overwrite QoS TID of injected frames
Date:   Wed,  4 Nov 2020 10:18:21 +0400
Message-Id: <20201104061823.197407-4-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
References: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently ieee80211_set_qos_hdr set the QoS TID of all frames based
on the value assigned to skb->priority. This means it will also
overwrite the QoS TID of injected frames. The commit 753ffad3d624
("mac80211: fix TID field in monitor mode transmit") prevented
injected frames from being modified because of this by setting
skb->priority to the TID of the injected frame, which assured the
QoS TID will not be changed to a different value. Unfortunately,
this workaround complicates the handling of injected frames because
we can't set skb->priority without affecting the TID value in the
QoS field of injected frames.

To avoid this, and to implify the next patch, detect if a frame is
injected in ieee80211_set_qos_hdr and if so do not change its QoS
field.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 net/mac80211/tx.c  | 5 +----
 net/mac80211/wme.c | 8 ++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d4e1a2720..8bf80b675 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2271,10 +2271,7 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
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
index 3d7dea387..2702d314e 100644
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
2.28.0


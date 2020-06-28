Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21C20C970
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2020 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgF1SNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jun 2020 14:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1SNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jun 2020 14:13:47 -0400
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 Jun 2020 11:13:46 PDT
Received: from rhcavspool01.kulnet.kuleuven.be (rhcavspool01.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A195FC03E979
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2020 11:13:46 -0700 (PDT)
Received: from rhcavuit04.kulnet.kuleuven.be (rhcavuit04.kulnet.kuleuven.be [134.58.240.137])
        by rhcavspool01.kulnet.kuleuven.be (Postfix) with ESMTP id 13CAC60B7
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2020 20:05:25 +0200 (CEST)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: D5B55120337.AF6FB
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-1.cc.kuleuven.be (icts-p-smtps-1e.kulnet.kuleuven.be [134.58.240.33])
        by rhcavuit04.kulnet.kuleuven.be (Postfix) with ESMTP id D5B55120337
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2020 20:05:16 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by icts-p-smtps-1.cc.kuleuven.be (Postfix) with ESMTPSA id 244DC40B2;
        Sun, 28 Jun 2020 20:05:16 +0200 (CEST)
Date:   Sun, 28 Jun 2020 22:05:12 +0400
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     mathy.vanhoef@nyu.edu
Subject: [PATCH] mac80211: keep non-zero sequence counter of injected frames
Message-ID: <20200628220512.28535ebc@mathy-work.localhost>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The sequence number of injected frames is being overwritten by the
function ieee80211_tx_h_sequence when the following two conditions
are met:

1. The frame is injected on a virtual interface, and a second virtual
   interface on this device is operating in managed/AP/.. mode.

2. The sender MAC address of the injected frame matches the MAC
   address of the second interface operating in managed/AP/.. mode.

In some cases this may be desired, for instance when hostap is
configured to send certain frames using a monitor interface, in which
case the user-space will not assign a sequence number and instead
injects frames with a sequence number of zero.

However, in case the user-space does assign a non-zero sequence
number, this number should not be overwritten by the kernel. This
patch adds a check to see if injected frames have already been assigned
a non-zero sequence number, and if so, this sequence number will not
be overwritten by the kernel.

Signed-off-by: Mathy Vanhoef <mathy.vanhoef@nyu.edu>
---
 net/mac80211/tx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1a2941e52..8bb8c548c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -808,11 +808,14 @@ ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
 	int tid;
 
 	/*
-	 * Packet injection may want to control the sequence
-	 * number, if we have no matching interface then we
-	 * neither assign one ourselves nor ask the driver to.
+	 * Packet injection may want to control the sequence number.
+	 * Do not assign one ourselves, and do not ask the driver to,
+	 * if there is no matching interface or if the injected frame
+	 * was already assigned a non-zero sequence number.
 	 */
-	if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR))
+	if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
+		     (info->flags & IEEE80211_TX_CTL_INJECTED != 0 &&
+		      hdr->seq_ctrl != 0)))
 		return TX_CONTINUE;
 
 	if (unlikely(ieee80211_is_ctl(hdr->frame_control)))
-- 
2.20.1

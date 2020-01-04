Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 854AA1301F7
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jan 2020 12:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgADLTq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Jan 2020 06:19:46 -0500
Received: from mail.w1.fi ([212.71.239.96]:46980 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgADLTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Jan 2020 06:19:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id 2013611D0F;
        Sat,  4 Jan 2020 11:19:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RTybslCnDNGU; Sat,  4 Jan 2020 11:19:43 +0000 (UTC)
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>
Subject: [PATCH] mac80211: Fix TKIP replay protection immediately after key setup
Date:   Sat,  4 Jan 2020 13:19:31 +0200
Message-Id: <20200104111931.18144-1-j@w1.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TKIP replay protection was skipped for the very first frame received
after a new key is configured. While this is potentially needed to avoid
dropping a frame in some cases, this does leave a window for replay
attacks with group-addressed frames at the station side. Any earlier
frame sent by the AP using the same key would be accepted as a valid
frame and the internal RSC counter would then be updated to the TSC from
that frame. This would allow multiple previously transmitted
group-addressed frames to be replayed until the next valid new
group-addressed frame from the AP is received by the station.

Fix this by limiting the no-replay-protection exception to apply only
for the case where TSC=0, i.e., when this is for the very first frame
protected using the new key. There cannot be previously transmitted
frames in such a case, so there cannot be a replay attack either.

Signed-off-by: Jouni Malinen <j@w1.fi>
---
 net/mac80211/tkip.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tkip.c b/net/mac80211/tkip.c
index 727dc9f3f3b3..7a62b3aaf248 100644
--- a/net/mac80211/tkip.c
+++ b/net/mac80211/tkip.c
@@ -263,9 +263,17 @@ int ieee80211_tkip_decrypt_data(struct arc4_ctx *ctx,
 	if ((keyid >> 6) != key->conf.keyidx)
 		return TKIP_DECRYPT_INVALID_KEYIDX;
 
-	if (rx_ctx->ctx.state != TKIP_STATE_NOT_INIT &&
-	    (iv32 < rx_ctx->iv32 ||
-	     (iv32 == rx_ctx->iv32 && iv16 <= rx_ctx->iv16)))
+	/* Reject replays if the received TSC is smaller than or equal to the
+	 * last received value in a valid message, but with an exception for
+	 * the case where a new key has been set, but not yet fully initialized
+	 * and the received value is 0. This exception allows the very first
+	 * frame sent by the transmitter to be accepted.
+	 */
+	if (iv32 < rx_ctx->iv32 ||
+	    (iv32 == rx_ctx->iv32 &&
+	     (iv16 < rx_ctx->iv16 ||
+	      (iv16 == rx_ctx->iv16 &&
+	       (iv32 || iv16 || rx_ctx->ctx.state != TKIP_STATE_NOT_INIT)))))
 		return TKIP_DECRYPT_REPLAY;
 
 	if (only_iv) {
-- 
2.20.1


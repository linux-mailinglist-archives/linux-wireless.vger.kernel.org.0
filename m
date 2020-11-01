Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C42A21CE
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgKAVRU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 16:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgKAVRT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 16:17:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38515C0617A6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Nov 2020 13:17:19 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604265437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/G6jhunyYonKt/zfjJmfGJ6HFdyJdyKil2v62NvxSdM=;
        b=tLTi8vqXu05mdK9kFwVSWtCkvZhAO/TAM03VRbJb+oUGEGUpQU1pSZ382fo6gua0J0k7JM
        ZklW4ZcjrLZE0UKJe+YJVHunqmvOM6N7ClDUFyiA06JmqsrufAtgsR4ixm4MDfyk+PgKbK
        e0Ox0cZoPn8VAd3LZCfaZZI7iNmj4FdkwIxB0V5SYP9Byz+infjN5y2Oy9VzOAYH8XyLHQ
        cv0xf33+Kac/Q0U8uN3HPreDDS73df6ZZF8EdXZoKn8YhzOVUPcWgRecg2BxwVusoJAa3G
        WKGaDjSKerq+BD14YhqqLlLUnPw3QcGywGADJdQYBnpKk7oIel1zxKfxBw1wFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604265437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/G6jhunyYonKt/zfjJmfGJ6HFdyJdyKil2v62NvxSdM=;
        b=ObVIm6HAiCS49yFAhVJyxq71SKtCTTl/Gy/hPnkh9iGMCv9NXGl06jKksPFkDps/680Py4
        r0X02n1byu7BNiBQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/8] airo: Always use JOB_STATS and JOB_EVENT
Date:   Sun,  1 Nov 2020 22:15:31 +0100
Message-Id: <20201101211536.2966644-4-bigeasy@linutronix.de>
In-Reply-To: <20201101211536.2966644-1-bigeasy@linutronix.de>
References: <20201101211536.2966644-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

issuecommand() is using in_atomic() to decide if it is safe to invoke
schedule() while waiting for the command to be accepted.

Usage of in_atomic() for this is only half correct as it can not detect all
condition where it is not allowed to schedule(). Also Linus clearly
requested that code which changes behaviour depending on context should
either be seperated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

Chasing the call chains leading up to issuecommand() is straight forward,
but airo_link() and airo_get_stats() would require to pass the context
through a quite large amount of functions.

As this is ancient hardware, avoid the churn and enforce the invocation of
those functions through the JOB machinery.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/cisco/airo.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco=
/airo.c
index ca423f3b6b3ea..369a6ca44d1ff 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -2286,12 +2286,8 @@ static struct net_device_stats *airo_get_stats(struc=
t net_device *dev)
 	struct airo_info *local =3D  dev->ml_priv;
=20
 	if (!test_bit(JOB_STATS, &local->jobs)) {
-		/* Get stats out of the card if available */
-		if (down_trylock(&local->sem) !=3D 0) {
-			set_bit(JOB_STATS, &local->jobs);
-			wake_up_interruptible(&local->thr_wait);
-		} else
-			airo_read_stats(dev);
+		set_bit(JOB_STATS, &local->jobs);
+		wake_up_interruptible(&local->thr_wait);
 	}
=20
 	return &dev->stats;
@@ -3277,11 +3273,9 @@ static void airo_handle_link(struct airo_info *ai)
 		set_bit(FLAG_UPDATE_UNI, &ai->flags);
 		set_bit(FLAG_UPDATE_MULTI, &ai->flags);
=20
-		if (down_trylock(&ai->sem) !=3D 0) {
-			set_bit(JOB_EVENT, &ai->jobs);
-			wake_up_interruptible(&ai->thr_wait);
-		} else
-			airo_send_event(ai->dev);
+		set_bit(JOB_EVENT, &ai->jobs);
+		wake_up_interruptible(&ai->thr_wait);
+
 		netif_carrier_on(ai->dev);
 	} else if (!scan_forceloss) {
 		if (auto_wep && !ai->expires) {
--=20
2.29.1


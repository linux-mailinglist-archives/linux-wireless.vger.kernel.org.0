Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D9C2A21CC
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 22:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgKAVRT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 16:17:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54802 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgKAVRS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 16:17:18 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604265436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=noj1B5ca/uIxTGRkvRWYeOtEiiJK/kLamBwf0a04x0U=;
        b=FE5ZDCLtTSGik+U1/WhfQKejt41N1dPm9GEQ40mXwNn12u04UeoTS53Fsi8GbvRA5cBTEE
        Vr6viBx2jXXU60QOS0n5KEZnb9PQWnk5f9UQTYH4SXD2K3pbLVauFnFIQmQkxsWRILGx3w
        ZB7QYA0QT954HSgPKCExinlqo0K/kO5cAjn3bn+5hf4eAaqLo49wJZelIV7qM0HYcubJt0
        1FoNrXDHT8f/eHwv3DSpP4lK7L//JiT2S9EpVve1jw1LPEu8hkkKqf2Ryia+lgJmWf2NYq
        wtgJX1K0I/3TPlRY3MrZTNocoN4DmKxPHo7x/8Yzly2vbXy05ldeAr6n6zZQIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604265436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=noj1B5ca/uIxTGRkvRWYeOtEiiJK/kLamBwf0a04x0U=;
        b=3WdxC80E6my0Y09fE6+rw6C/Q9LY2Z2iZAJrKEOaBxrRe4/dwJZFz44BRpnm7F4GOJFLWo
        z0lz21a2krFUwDCg==
To:     linux-wireless@vger.kernel.org
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/8] airo: Invoke airo_read_wireless_stats() directly
Date:   Sun,  1 Nov 2020 22:15:30 +0100
Message-Id: <20201101211536.2966644-3-bigeasy@linutronix.de>
In-Reply-To: <20201101211536.2966644-1-bigeasy@linutronix.de>
References: <20201101211536.2966644-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

airo_get_wireless_stats() is the iw_handler_if::get_wireless_stats()
callback of this driver. This callback was not allowed to sleep until
commit a160ee69c6a46 ("wext: let get_wireless_stats() sleep") in v2.6.32.

airo still delegates the readout to a thread, which is not longer
necessary.

Invoke airo_read_wireless_stats() directly from the callback and remove
the now unused JOB_WSTATS handling.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/cisco/airo.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco=
/airo.c
index 87b9398b03fd4..ca423f3b6b3ea 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -1144,7 +1144,6 @@ static int airo_thread(void *data);
 static void timer_func(struct net_device *dev);
 static int airo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static struct iw_statistics *airo_get_wireless_stats(struct net_device *de=
v);
-static void airo_read_wireless_stats(struct airo_info *local);
 #ifdef CISCO_EXT
 static int readrids(struct net_device *dev, aironet_ioctl *comp);
 static int writerids(struct net_device *dev, aironet_ioctl *comp);
@@ -1200,7 +1199,6 @@ struct airo_info {
 #define JOB_MIC	5
 #define JOB_EVENT	6
 #define JOB_AUTOWEP	7
-#define JOB_WSTATS	8
 #define JOB_SCAN_RESULTS  9
 	unsigned long jobs;
 	int (*bap_read)(struct airo_info*, __le16 *pu16Dst, int bytelen,
@@ -3155,8 +3153,6 @@ static int airo_thread(void *data)
 			airo_end_xmit11(dev);
 		else if (test_bit(JOB_STATS, &ai->jobs))
 			airo_read_stats(dev);
-		else if (test_bit(JOB_WSTATS, &ai->jobs))
-			airo_read_wireless_stats(ai);
 		else if (test_bit(JOB_PROMISC, &ai->jobs))
 			airo_set_promisc(ai);
 		else if (test_bit(JOB_MIC, &ai->jobs))
@@ -7732,15 +7728,12 @@ static void airo_read_wireless_stats(struct airo_in=
fo *local)
 	__le32 *vals =3D stats_rid.vals;
=20
 	/* Get stats out of the card */
-	clear_bit(JOB_WSTATS, &local->jobs);
-	if (local->power.event) {
-		up(&local->sem);
+	if (local->power.event)
 		return;
-	}
+
 	readCapabilityRid(local, &cap_rid, 0);
 	readStatusRid(local, &status_rid, 0);
 	readStatsRid(local, &stats_rid, RID_STATS, 0);
-	up(&local->sem);
=20
 	/* The status */
 	local->wstats.status =3D le16_to_cpu(status_rid.mode);
@@ -7783,15 +7776,10 @@ static struct iw_statistics *airo_get_wireless_stat=
s(struct net_device *dev)
 {
 	struct airo_info *local =3D  dev->ml_priv;
=20
-	if (!test_bit(JOB_WSTATS, &local->jobs)) {
-		/* Get stats out of the card if available */
-		if (down_trylock(&local->sem) !=3D 0) {
-			set_bit(JOB_WSTATS, &local->jobs);
-			wake_up_interruptible(&local->thr_wait);
-		} else
-			airo_read_wireless_stats(local);
+	if (!down_interruptible(&local->sem)) {
+		airo_read_wireless_stats(local);
+		up(&local->sem);
 	}
-
 	return &local->wstats;
 }
=20
--=20
2.29.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA92A21CF
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 22:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgKAVRV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 16:17:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54840 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgKAVRU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 16:17:20 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604265438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuPd7FRq7scdHyo1TxyQj2+a/5t/jyiPa90zNB96s9U=;
        b=Fhb/tJX1nBEgSsiyqyhC1bO1LnPg29xfYW2Uy+FbH8cTQF6g0MdOWjIsIfHFFZCFLv9RsX
        Xu2ce+RglTbtbeS2h5UYe2G6h/sdRSu6pgd3TLvv5jUDe41zIVSZehVKoe34fgtgvgigXW
        rBdYu4RG2q7wW5VdYZL/VXuGMgml0D8SYS4XM7VZyJE5xDv/g8OWTOyLfx/Y2I9kGcjgS4
        RHddveU53bd/0nnPuUO2Q/nxIkrTbzmswQcPzxEPKHoeCarNc8LN7Zcx++CVIghBPvpTld
        /y63K2jSqafPw8aP/xRBDFtpxHIueds2hGi0mg37zbqMGD/bRs+Qye546ildcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604265438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuPd7FRq7scdHyo1TxyQj2+a/5t/jyiPa90zNB96s9U=;
        b=KdqQ7mjcu1sD8E2HO0tD5g7UBe1awjrFos/C3yBOqdqvaMFKoowZjr5Qc1u6LuIWU/4RZP
        voasUhV2yG3lRsAg==
To:     linux-wireless@vger.kernel.org
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 6/8] zd1211rw: Remove in_atomic() usage.
Date:   Sun,  1 Nov 2020 22:15:34 +0100
Message-Id: <20201101211536.2966644-7-bigeasy@linutronix.de>
In-Reply-To: <20201101211536.2966644-1-bigeasy@linutronix.de>
References: <20201101211536.2966644-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The usage of in_atomic() in driver code is deprecated as it can not
always detect all states where it is not allowed to sleep.

All callers are in premptible thread context and all functions invoke core
functions which have checks for invalid calling contexts already.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ulrich Kunitz <kune@deine-taler.de>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wir=
eless/zydas/zd1211rw/zd_usb.c
index 66367ab7e4c1e..5c4cd0e1adebb 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -1711,11 +1711,6 @@ int zd_usb_ioread16v(struct zd_usb *usb, u16 *values,
 			 count, USB_MAX_IOREAD16_COUNT);
 		return -EINVAL;
 	}
-	if (in_atomic()) {
-		dev_dbg_f(zd_usb_dev(usb),
-			 "error: io in atomic context not supported\n");
-		return -EWOULDBLOCK;
-	}
 	if (!usb_int_enabled(usb)) {
 		dev_dbg_f(zd_usb_dev(usb),
 			  "error: usb interrupt not enabled\n");
@@ -1882,11 +1877,6 @@ int zd_usb_iowrite16v_async(struct zd_usb *usb, cons=
t struct zd_ioreq16 *ioreqs,
 			count, USB_MAX_IOWRITE16_COUNT);
 		return -EINVAL;
 	}
-	if (in_atomic()) {
-		dev_dbg_f(zd_usb_dev(usb),
-			"error: io in atomic context not supported\n");
-		return -EWOULDBLOCK;
-	}
=20
 	udev =3D zd_usb_to_usbdev(usb);
=20
@@ -1966,11 +1956,6 @@ int zd_usb_rfwrite(struct zd_usb *usb, u32 value, u8=
 bits)
 	int i, req_len, actual_req_len;
 	u16 bit_value_template;
=20
-	if (in_atomic()) {
-		dev_dbg_f(zd_usb_dev(usb),
-			"error: io in atomic context not supported\n");
-		return -EWOULDBLOCK;
-	}
 	if (bits < USB_MIN_RFWRITE_BIT_COUNT) {
 		dev_dbg_f(zd_usb_dev(usb),
 			"error: bits %d are smaller than"
--=20
2.29.1


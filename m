Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF52A21CD
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgKAVRU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 16:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgKAVRT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 16:17:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8415AC061A04
        for <linux-wireless@vger.kernel.org>; Sun,  1 Nov 2020 13:17:19 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604265437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=psH6A7v8XpxWeO9K6sVB4+NN8/b2kgPe6aRvHhvnGOM=;
        b=JR89ghZeaQ9eFB6bYKOpVIPBmK4udWPaFIKucgOJ00uhAqY0xM2D1R8x4LRisB0Ih2zVJs
        htz1+SZdaVwgDgsk81WfQ8eP8Iw6Digu/UTvT6mo+CQcL8RKx+cWT+aiQCBnrdKA+Hvy0B
        FUb3ESdazM3fyVBzYrppxh6yoURbEUPFLjPxFvupnWcaefjgoZKQpKWlMjbgQA5JN8SOK0
        hjhQrYYw/IOQIDbJYzgH+6KPdNDW5DEUakjsxEoCg39dI/u+ObdH+YuSH+MHI3UWjCKtVb
        GuJ3Aw8zzJiEREU3qsjRxsflcNJHct9waI03NB1wMQ8JU9hKZYb4e7n8dIjFUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604265437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=psH6A7v8XpxWeO9K6sVB4+NN8/b2kgPe6aRvHhvnGOM=;
        b=O2r8x/6Op5enT8qwna+zYpgGfktp2ufW+6BmH/GA4vAENvumRICFmPr+yrgt4uDMBSIgbO
        sNNc4qVRxNowHABg==
To:     linux-wireless@vger.kernel.org
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/8] hostap: Remove in_atomic() check.
Date:   Sun,  1 Nov 2020 22:15:33 +0100
Message-Id: <20201101211536.2966644-6-bigeasy@linutronix.de>
In-Reply-To: <20201101211536.2966644-1-bigeasy@linutronix.de>
References: <20201101211536.2966644-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hostap_get_wireless_stats() is the iw_handler_if::get_wireless_stats()
callback of this driver. This callback was not allowed to sleep until
commit a160ee69c6a46 ("wext: let get_wireless_stats() sleep") in v2.6.32.

Remove the therefore pointless in_atomic() check.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jouni Malinen <j@w1.fi>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/intersil/hostap/hostap_ioctl.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_ioctl.c b/drivers/=
net/wireless/intersil/hostap/hostap_ioctl.c
index 514c7b01dbf6f..49766b285230c 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
@@ -44,19 +44,8 @@ static struct iw_statistics *hostap_get_wireless_stats(s=
truct net_device *dev)
=20
 	if (local->iw_mode !=3D IW_MODE_MASTER &&
 	    local->iw_mode !=3D IW_MODE_REPEAT) {
-		int update =3D 1;
-#ifdef in_atomic
-		/* RID reading might sleep and it must not be called in
-		 * interrupt context or while atomic. However, this
-		 * function seems to be called while atomic (at least in Linux
-		 * 2.5.59). Update signal quality values only if in suitable
-		 * context. Otherwise, previous values read from tick timer
-		 * will be used. */
-		if (in_atomic())
-			update =3D 0;
-#endif /* in_atomic */
=20
-		if (update && prism2_update_comms_qual(dev) =3D=3D 0)
+		if (prism2_update_comms_qual(dev) =3D=3D 0)
 			wstats->qual.updated =3D IW_QUAL_ALL_UPDATED |
 				IW_QUAL_DBM;
=20
--=20
2.29.1


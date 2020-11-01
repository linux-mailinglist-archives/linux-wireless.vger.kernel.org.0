Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B952A21CB
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 22:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgKAVRS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 16:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgKAVRS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 16:17:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE8C0617A6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Nov 2020 13:17:17 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604265436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4gF6uF2MewoDhtcChx+sLXBtFz03453YzVW4AULfuY=;
        b=pBUxUZ48DsWFh9nxdiG232I99mrrRy2nf8H0KHU3BNUS3SHL5EY+4ZVOEbGOXBC1zoXnG3
        C5uYWaZLFHx4VRZ9OhLEqZK3jOGyalJeERYiNEP6cgWNyOs+3MROGxUEfcuH+vFUfi048G
        GdlKPEXrpBlzyutwEpDr/3UCILVKXgHjFIMs3Dgxtqer9/k4rOZlBnPEZcDG9kNWMdaL2G
        Nb+tTH2JxjuOSOnRdt8QNc8r4WBcuNR/dkKN4A3Q3/EfgIbKuQhO9yvGMxQPxTtBdD19t4
        kbSo/EPZcQH+tDVVuGHAo/V/BIGc1mzc5oN+V8xjZSAxLFWWaepuhSK+eshmxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604265436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4gF6uF2MewoDhtcChx+sLXBtFz03453YzVW4AULfuY=;
        b=c/wktzj5MGkYdKhiC3bWCYd3Vln4QH64gtY6hQm1OQx0Z0K1+jNaLcYxu+NZTyViRh8svt
        2QjTFhQRj/bSfMDg==
To:     linux-wireless@vger.kernel.org
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/8] orinoco: Remove BUG_ON(in_interrupt/irq())
Date:   Sun,  1 Nov 2020 22:15:29 +0100
Message-Id: <20201101211536.2966644-2-bigeasy@linutronix.de>
In-Reply-To: <20201101211536.2966644-1-bigeasy@linutronix.de>
References: <20201101211536.2966644-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The usage of in_irq()/in_interrupt() in drivers is phased out and the
BUG_ON()'s based on those are not covering all contexts in which these
functions cannot be called.

Aside of that BUG_ON() should only be used as last resort, which is clearly
not the case here.

A broad variety of checks in the invoked functions (always enabled or debug
option dependent) cover these conditions already, so the BUG_ON()'s do not
really provide additional value.

Just remove them.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/=
net/wireless/intersil/orinoco/orinoco_usb.c
index b849d27bd741e..046f2453ad5d9 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -859,8 +859,6 @@ static int ezusb_access_ltv(struct ezusb_priv *upriv,
 	int retval =3D 0;
 	enum ezusb_state state;
=20
-	BUG_ON(in_irq());
-
 	if (!upriv->udev) {
 		retval =3D -ENODEV;
 		goto exit;
@@ -1349,7 +1347,6 @@ static int ezusb_init(struct hermes *hw)
 	struct ezusb_priv *upriv =3D hw->priv;
 	int retval;
=20
-	BUG_ON(in_interrupt());
 	if (!upriv)
 		return -EINVAL;
=20
@@ -1448,7 +1445,6 @@ static inline void ezusb_delete(struct ezusb_priv *up=
riv)
 	struct list_head *tmp_item;
 	unsigned long flags;
=20
-	BUG_ON(in_interrupt());
 	BUG_ON(!upriv);
=20
 	mutex_lock(&upriv->mtx);
--=20
2.29.1


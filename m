Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE24D2B26E0
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 22:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgKMVcC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 16:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgKMVbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 16:31:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C7C061A47
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 13:23:14 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605302592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiowGlEOoC0lyB71Q2LCjtIjPwZglkLw/8AF/ek6Ppo=;
        b=IORm0v87Uy7pDCUjZi51fTTc/4Ii4Tr3MDbggMdbwAZ0QDIHzB5ZxsjzxLquyT0Hp+gMzc
        4zmvk8+EZXe5CdaahyoCmMKbP6uh2d/l/+Q8MnlPm3oG8ckRAWA2zNqfKu0uNhyfMtfeAj
        /+XDtDz9/jaxcXIl2MBI83aqxMXbzP+1psOg5tAY6GTsfTYi1fvY24m0zJbMEUUw8Wqob7
        1pINbuUrfWYt+jUuKHpV5GVm4Vm7ViYKAmdtR/jcELc7czOxz4HYK9ZB7c8m21DPEV8X13
        HQ1ED8iXWvf065fIKzk1V/ZFNqwdFKnpqgTioo/lvFiKPzf4vfqEDuIoN+MeYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605302592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiowGlEOoC0lyB71Q2LCjtIjPwZglkLw/8AF/ek6Ppo=;
        b=CvVOPJLBASgL4Rz4aj0Db9H4egENS8S4A25I0VGEFokvSYxgmh5SFhtC/GHuQ1TZ0YU8s2
        642NBQvOuOQM/bAA==
To:     linux-wireless@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Williams <dcbw@redhat.com>,
        Jes Sorensen <jes.sorensen@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 04/10] orinoco: Annotate ezusb_init()
Date:   Fri, 13 Nov 2020 22:22:46 +0100
Message-Id: <20201113212252.2243570-5-bigeasy@linutronix.de>
In-Reply-To: <20201113212252.2243570-1-bigeasy@linutronix.de>
References: <20201113212252.2243570-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ezusb_init() is always invoked in preemptible context during device
probe. Only orinoco_up() -> orinoco_reinit_firmware() may invoke the
function from atomic context but this is never used for the USB
interface.

Use ezusb_req_ctx_wait_compl() for the ezusb_write_ltv() and
ezusb_docmd_wait() invocations from within ezusb_init().
Preserve the generic versions which have still other user via the
callback.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../wireless/intersil/orinoco/orinoco_usb.c   | 35 ++++++++++++++-----
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/=
net/wireless/intersil/orinoco/orinoco_usb.c
index 66d77af91d22c..3f49e15967a48 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -994,8 +994,9 @@ static int ezusb_access_ltv(struct ezusb_priv *upriv,
 	return retval;
 }
=20
-static int ezusb_write_ltv(struct hermes *hw, int bap, u16 rid,
-			   u16 length, const void *data)
+static int __ezusb_write_ltv(struct hermes *hw, int bap, u16 rid,
+			   u16 length, const void *data,
+			   ezusb_ctx_wait ezusb_ctx_wait_func)
 {
 	struct ezusb_priv *upriv =3D hw->priv;
 	u16 frame_type;
@@ -1021,7 +1022,14 @@ static int ezusb_write_ltv(struct hermes *hw, int ba=
p, u16 rid,
 		frame_type =3D EZUSB_FRAME_CONTROL;
=20
 	return ezusb_access_ltv(upriv, ctx, length, data, frame_type,
-				NULL, 0, NULL, ezusb_req_ctx_wait);
+				NULL, 0, NULL, ezusb_ctx_wait_func);
+}
+
+static int ezusb_write_ltv(struct hermes *hw, int bap, u16 rid,
+			   u16 length, const void *data)
+{
+	return __ezusb_write_ltv(hw, bap, rid, length, data,
+				 ezusb_req_ctx_wait);
 }
=20
 static int ezusb_read_ltv(struct hermes *hw, int bap, u16 rid,
@@ -1065,8 +1073,9 @@ static int ezusb_doicmd_wait(struct hermes *hw, u16 c=
md, u16 parm0, u16 parm1,
 				ezusb_req_ctx_wait);
 }
=20
-static int ezusb_docmd_wait(struct hermes *hw, u16 cmd, u16 parm0,
-			    struct hermes_response *resp)
+static int __ezusb_docmd_wait(struct hermes *hw, u16 cmd, u16 parm0,
+			    struct hermes_response *resp,
+			    ezusb_ctx_wait ezusb_ctx_wait_func)
 {
 	struct ezusb_priv *upriv =3D hw->priv;
 	struct request_context *ctx;
@@ -1084,7 +1093,13 @@ static int ezusb_docmd_wait(struct hermes *hw, u16 c=
md, u16 parm0,
=20
 	return ezusb_access_ltv(upriv, ctx, sizeof(data), &data,
 				EZUSB_FRAME_CONTROL, NULL, 0, NULL,
-				ezusb_req_ctx_wait);
+				ezusb_ctx_wait_func);
+}
+
+static int ezusb_docmd_wait(struct hermes *hw, u16 cmd, u16 parm0,
+			    struct hermes_response *resp)
+{
+	return __ezusb_docmd_wait(hw, cmd, parm0, resp, ezusb_req_ctx_wait);
 }
=20
 static int ezusb_bap_pread(struct hermes *hw, int bap,
@@ -1416,14 +1431,16 @@ static int ezusb_init(struct hermes *hw)
 	usb_kill_urb(upriv->read_urb);
 	ezusb_submit_in_urb(upriv);
=20
-	retval =3D ezusb_write_ltv(hw, 0, EZUSB_RID_INIT1,
-				 HERMES_BYTES_TO_RECLEN(2), "\x10\x00");
+	retval =3D __ezusb_write_ltv(hw, 0, EZUSB_RID_INIT1,
+				 HERMES_BYTES_TO_RECLEN(2), "\x10\x00",
+				 ezusb_req_ctx_wait_compl);
 	if (retval < 0) {
 		printk(KERN_ERR PFX "EZUSB_RID_INIT1 error %d\n", retval);
 		return retval;
 	}
=20
-	retval =3D ezusb_docmd_wait(hw, HERMES_CMD_INIT, 0, NULL);
+	retval =3D __ezusb_docmd_wait(hw, HERMES_CMD_INIT, 0, NULL,
+				    ezusb_req_ctx_wait_compl);
 	if (retval < 0) {
 		printk(KERN_ERR PFX "HERMES_CMD_INIT error %d\n", retval);
 		return retval;
--=20
2.29.2


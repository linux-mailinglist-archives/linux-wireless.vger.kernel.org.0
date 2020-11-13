Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61472B26EA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 22:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKMVcR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 16:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgKMVbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 16:31:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4EDC0617A7
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 13:23:13 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605302592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sU+wW7m2X02toZnEFM429Q1WId+meKGMNFV6J+kQHu0=;
        b=NWCEshaLST+Xdd5aWg/13UmSBjRm5HDctHy0re/TCqcnHRKZNAozoFhnCmw8hz93uHJPMl
        3PafDAn8KvGOw+VmtZwZrpcJj1BE0EhNUhCsOHlAPW5z6e8o8vmLzMlrPRciJJL3A78tWK
        5VH4P/wqJ2maLzmasinNnWV8KDKLEef8xDMEIo1Ktav4wYvHk/3sjmTOKY5UDgmsXYVPKZ
        83BniXVwifXqbvvAtUZYaAJdsxRGkLQ0tYA/3XsYrs/BVni3NMQq+JdkfsPmVleg4BWaEq
        PhgCK1QI9UbOYYY26kI+0Y15si5yGmZMY/u9taKlnzU8r6/fRBoR8sFyUKkmEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605302592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sU+wW7m2X02toZnEFM429Q1WId+meKGMNFV6J+kQHu0=;
        b=JSse2mX5zTjzOBqy7JW1Z3N9I/y7ZkhiCgQ8ITXOjzCdMPuAGnCKBT7C3nbrQHe/dcH4D+
        hMnRU1UYMqqZAYDw==
To:     linux-wireless@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Williams <dcbw@redhat.com>,
        Jes Sorensen <jes.sorensen@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 02/10] orinoco: Prepare stubs for in_interrupt() removal
Date:   Fri, 13 Nov 2020 22:22:44 +0100
Message-Id: <20201113212252.2243570-3-bigeasy@linutronix.de>
In-Reply-To: <20201113212252.2243570-1-bigeasy@linutronix.de>
References: <20201113212252.2243570-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ezusb_access_ltv() sends the prepared request to the USB device.
Requests which have ->in_rid set expect an answer from the USB device
and the function has to wait until the URB with the answer arrives.
The function uses in_interrupt() to determine if it can simply sleep on
the completion and be woken up once the answer arrives or if it needs to
poll on the completion.

The usage of in_interrupt() in drivers is phased out and Linus clearly
requested that code which changes behaviour depending on context should
either be separated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

Aside of that in_interrupt() is not correct as it does not catch preempt
disabled regions in which sleeping is also not allowed.

Provide stubs which can be used as a replacement. The current default is
the current behaviour which sleeps/polls depending on in_interrupt().
The goal is to audit all callers and use either the poll or sleep
version.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../wireless/intersil/orinoco/orinoco_usb.c   | 81 ++++++++++++++++---
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/=
net/wireless/intersil/orinoco/orinoco_usb.c
index 8419e13a79e2a..6642948809e1c 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -665,6 +665,7 @@ static void ezusb_request_in_callback(struct ezusb_priv=
 *upriv,
 	}			/* switch */
 }
=20
+typedef void (*ezusb_ctx_wait)(struct ezusb_priv *, struct request_context=
 *);
=20
 static void ezusb_req_ctx_wait(struct ezusb_priv *upriv,
 			       struct request_context *ctx)
@@ -692,6 +693,54 @@ static void ezusb_req_ctx_wait(struct ezusb_priv *upri=
v,
 	}
 }
=20
+static void ezusb_req_ctx_wait_compl(struct ezusb_priv *upriv,
+				     struct request_context *ctx)
+{
+	switch (ctx->state) {
+	case EZUSB_CTX_QUEUED:
+	case EZUSB_CTX_REQ_SUBMITTED:
+	case EZUSB_CTX_REQ_COMPLETE:
+	case EZUSB_CTX_RESP_RECEIVED:
+		wait_for_completion(&ctx->done);
+		break;
+	default:
+		/* Done or failed - nothing to wait for */
+		break;
+	}
+}
+
+static void ezusb_req_ctx_wait_poll(struct ezusb_priv *upriv,
+				    struct request_context *ctx)
+{
+	int msecs;
+
+	switch (ctx->state) {
+	case EZUSB_CTX_QUEUED:
+	case EZUSB_CTX_REQ_SUBMITTED:
+	case EZUSB_CTX_REQ_COMPLETE:
+	case EZUSB_CTX_RESP_RECEIVED:
+		/* If we get called from a timer or with our lock acquired, then
+		 * we can't wait for the completion and have to poll. This won't
+		 * happen if the USB controller completes the URB requests in
+		 * BH.
+		 */
+		msecs =3D DEF_TIMEOUT * (1000 / HZ);
+
+		while (!try_wait_for_completion(&ctx->done) && msecs--)
+			udelay(1000);
+		break;
+	default:
+		/* Done or failed - nothing to wait for */
+		break;
+	}
+}
+
+static void ezusb_req_ctx_wait_skip(struct ezusb_priv *upriv,
+				    struct request_context *ctx)
+{
+	WARN(1, "Shouldn't be invoked for in_rid\n");
+}
+
 static inline u16 build_crc(struct ezusb_packet *data)
 {
 	u16 crc =3D 0;
@@ -853,7 +902,8 @@ static int ezusb_firmware_download(struct ezusb_priv *u=
priv,
 static int ezusb_access_ltv(struct ezusb_priv *upriv,
 			    struct request_context *ctx,
 			    u16 length, const void *data, u16 frame_type,
-			    void *ans_buff, unsigned ans_size, u16 *ans_length)
+			    void *ans_buff, unsigned ans_size, u16 *ans_length,
+			    ezusb_ctx_wait ezusb_ctx_wait_func)
 {
 	int req_size;
 	int retval =3D 0;
@@ -883,7 +933,7 @@ static int ezusb_access_ltv(struct ezusb_priv *upriv,
 	spin_unlock_bh(&upriv->reply_count_lock);
=20
 	if (ctx->in_rid)
-		ezusb_req_ctx_wait(upriv, ctx);
+		ezusb_ctx_wait_func(upriv, ctx);
=20
 	state =3D ctx->state;
 	switch (state) {
@@ -971,7 +1021,7 @@ static int ezusb_write_ltv(struct hermes *hw, int bap,=
 u16 rid,
 		frame_type =3D EZUSB_FRAME_CONTROL;
=20
 	return ezusb_access_ltv(upriv, ctx, length, data, frame_type,
-				NULL, 0, NULL);
+				NULL, 0, NULL, ezusb_req_ctx_wait);
 }
=20
 static int ezusb_read_ltv(struct hermes *hw, int bap, u16 rid,
@@ -988,7 +1038,7 @@ static int ezusb_read_ltv(struct hermes *hw, int bap, =
u16 rid,
 		return -ENOMEM;
=20
 	return ezusb_access_ltv(upriv, ctx, 0, NULL, EZUSB_FRAME_CONTROL,
-				buf, bufsize, length);
+				buf, bufsize, length, ezusb_req_ctx_wait);
 }
=20
 static int ezusb_doicmd_wait(struct hermes *hw, u16 cmd, u16 parm0, u16 pa=
rm1,
@@ -1011,7 +1061,8 @@ static int ezusb_doicmd_wait(struct hermes *hw, u16 c=
md, u16 parm0, u16 parm1,
 		return -ENOMEM;
=20
 	return ezusb_access_ltv(upriv, ctx, sizeof(data), &data,
-				EZUSB_FRAME_CONTROL, NULL, 0, NULL);
+				EZUSB_FRAME_CONTROL, NULL, 0, NULL,
+				ezusb_req_ctx_wait);
 }
=20
 static int ezusb_docmd_wait(struct hermes *hw, u16 cmd, u16 parm0,
@@ -1032,7 +1083,8 @@ static int ezusb_docmd_wait(struct hermes *hw, u16 cm=
d, u16 parm0,
 		return -ENOMEM;
=20
 	return ezusb_access_ltv(upriv, ctx, sizeof(data), &data,
-				EZUSB_FRAME_CONTROL, NULL, 0, NULL);
+				EZUSB_FRAME_CONTROL, NULL, 0, NULL,
+				ezusb_req_ctx_wait);
 }
=20
 static int ezusb_bap_pread(struct hermes *hw, int bap,
@@ -1090,7 +1142,7 @@ static int ezusb_read_pda(struct hermes *hw, __le16 *=
pda,
=20
 	return ezusb_access_ltv(upriv, ctx, sizeof(data), &data,
 				EZUSB_FRAME_CONTROL, &pda[2], pda_len - 4,
-				NULL);
+				NULL, ezusb_req_ctx_wait);
 }
=20
 static int ezusb_program_init(struct hermes *hw, u32 entry_point)
@@ -1104,7 +1156,8 @@ static int ezusb_program_init(struct hermes *hw, u32 =
entry_point)
 		return -ENOMEM;
=20
 	return ezusb_access_ltv(upriv, ctx, sizeof(data), &data,
-				EZUSB_FRAME_CONTROL, NULL, 0, NULL);
+				EZUSB_FRAME_CONTROL, NULL, 0, NULL,
+				ezusb_req_ctx_wait);
 }
=20
 static int ezusb_program_end(struct hermes *hw)
@@ -1117,7 +1170,8 @@ static int ezusb_program_end(struct hermes *hw)
 		return -ENOMEM;
=20
 	return ezusb_access_ltv(upriv, ctx, 0, NULL,
-				EZUSB_FRAME_CONTROL, NULL, 0, NULL);
+				EZUSB_FRAME_CONTROL, NULL, 0, NULL,
+				ezusb_req_ctx_wait);
 }
=20
 static int ezusb_program_bytes(struct hermes *hw, const char *buf,
@@ -1133,7 +1187,8 @@ static int ezusb_program_bytes(struct hermes *hw, con=
st char *buf,
 		return -ENOMEM;
=20
 	err =3D ezusb_access_ltv(upriv, ctx, sizeof(data), &data,
-			       EZUSB_FRAME_CONTROL, NULL, 0, NULL);
+			       EZUSB_FRAME_CONTROL, NULL, 0, NULL,
+			       ezusb_req_ctx_wait);
 	if (err)
 		return err;
=20
@@ -1142,7 +1197,8 @@ static int ezusb_program_bytes(struct hermes *hw, con=
st char *buf,
 		return -ENOMEM;
=20
 	return ezusb_access_ltv(upriv, ctx, len, buf,
-				EZUSB_FRAME_CONTROL, NULL, 0, NULL);
+				EZUSB_FRAME_CONTROL, NULL, 0, NULL,
+				ezusb_req_ctx_wait);
 }
=20
 static int ezusb_program(struct hermes *hw, const char *buf,
@@ -1262,7 +1318,8 @@ static netdev_tx_t ezusb_xmit(struct sk_buff *skb, st=
ruct net_device *dev)
 	tx_size =3D ALIGN(buf - ctx->buf->data, 2);
=20
 	err =3D ezusb_access_ltv(upriv, ctx, tx_size, NULL,
-			       EZUSB_FRAME_DATA, NULL, 0, NULL);
+			       EZUSB_FRAME_DATA, NULL, 0, NULL,
+			       ezusb_req_ctx_wait);
=20
 	if (err) {
 		netif_start_queue(dev);
--=20
2.29.2


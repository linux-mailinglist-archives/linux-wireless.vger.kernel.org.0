Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDED2B26D6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 22:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgKMVb4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 16:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgKMVbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 16:31:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4035C061A48
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 13:23:14 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605302592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Oroj6G8eqmy8fhRUJyk0c4cmjv0sHraR6w1u1xbeD4=;
        b=Np10DhK4HiEGnSrPWiVvi+BJVgBjGorEBVH7uaZPKrDposMy2b+bhMCrFGIWhujS0tuaFq
        pCAM9C9L8XTeEDv6PmqxcAa6B2FTrF1vKmK9E1HB/r3C9JfKtR/ym1jS4Pml+8SeCCKYbb
        gx+shseMUvtAUAFCqTbh5LH+ikfg0DOeDSgV3L8PBjkp0db4D0tNeJkouFiQ/NJLBp8gjv
        Q+Hy4j2pCalOBZ56g7vgkFVl/FDDPmSdTOCE0c7n6w4PReoDHYsaWt43S4ffeqPxAS+v1B
        veNyRV7c446EOqzvGUv+nNIZANLfeT/3IT/MOCzMP5QpCr2WRxAZUJyIcmgOoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605302592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Oroj6G8eqmy8fhRUJyk0c4cmjv0sHraR6w1u1xbeD4=;
        b=XlpoIohTkdgqrzXrQ8o7UP6ewa4vc/jd3F4waxdWcrh97Fz5g+r0iF0D1lRfbGBHIGt0QW
        NFsLXShDbax9e/Dg==
To:     linux-wireless@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Williams <dcbw@redhat.com>,
        Jes Sorensen <jes.sorensen@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/10] orinoco: Annotate firmware loading
Date:   Fri, 13 Nov 2020 22:22:47 +0100
Message-Id: <20201113212252.2243570-6-bigeasy@linutronix.de>
In-Reply-To: <20201113212252.2243570-1-bigeasy@linutronix.de>
References: <20201113212252.2243570-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ezusb_program() is invoked via ->program() in preemptible
context during firmware loading. This is also true for the
->program_init() and ->program_end() callback.

Use ezusb_req_ctx_wait_compl() in ezusb_program_init(),
ezusb_program_bytes(), ezusb_program_end() which are part of firmware
loading during device probe.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/=
net/wireless/intersil/orinoco/orinoco_usb.c
index 3f49e15967a48..2c9c55569e8f4 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -1172,7 +1172,7 @@ static int ezusb_program_init(struct hermes *hw, u32 =
entry_point)
=20
 	return ezusb_access_ltv(upriv, ctx, sizeof(data), &data,
 				EZUSB_FRAME_CONTROL, NULL, 0, NULL,
-				ezusb_req_ctx_wait);
+				ezusb_req_ctx_wait_compl);
 }
=20
 static int ezusb_program_end(struct hermes *hw)
@@ -1186,7 +1186,7 @@ static int ezusb_program_end(struct hermes *hw)
=20
 	return ezusb_access_ltv(upriv, ctx, 0, NULL,
 				EZUSB_FRAME_CONTROL, NULL, 0, NULL,
-				ezusb_req_ctx_wait);
+				ezusb_req_ctx_wait_compl);
 }
=20
 static int ezusb_program_bytes(struct hermes *hw, const char *buf,
@@ -1203,7 +1203,7 @@ static int ezusb_program_bytes(struct hermes *hw, con=
st char *buf,
=20
 	err =3D ezusb_access_ltv(upriv, ctx, sizeof(data), &data,
 			       EZUSB_FRAME_CONTROL, NULL, 0, NULL,
-			       ezusb_req_ctx_wait);
+			       ezusb_req_ctx_wait_compl);
 	if (err)
 		return err;
=20
@@ -1213,7 +1213,7 @@ static int ezusb_program_bytes(struct hermes *hw, con=
st char *buf,
=20
 	return ezusb_access_ltv(upriv, ctx, len, buf,
 				EZUSB_FRAME_CONTROL, NULL, 0, NULL,
-				ezusb_req_ctx_wait);
+				ezusb_req_ctx_wait_compl);
 }
=20
 static int ezusb_program(struct hermes *hw, const char *buf,
--=20
2.29.2


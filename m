Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA992B26EF
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 22:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKMVcW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 16:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgKMVbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 16:31:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACD0C061A4B
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 13:23:15 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605302593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVCxA0v1aqJA5y2SXn2VIYReIMNMEMz6PBid6Ip5Ghs=;
        b=yDoU2vSz4R+3bUyStnXrlxuofUwVVlgYkjLFAS1rPNoOF3sI2j6HgHd0VHvBt1u6B8wse+
        dmv96LdPU1yAb2peC6y+0vNrpB66nPwCaBxPsYZosgQ2sBv1IRmUjm7Z8dI6KTwqCGXKbi
        66VpclBDzBCgnHIzeyUiRqNnKOV/eFthb04kAUxbpHXGFJ/Fh+wQojkEtHBwoY+r8OF/ER
        t88k7C9NnEcXouHfL4/Y9+Ta2oEMLAQ6qiCSdBrWJ7u1LtkZuHG9L9uI19qU0MaRtz9r8f
        vY3HrgXdP4sIKIpketpXh0IiChgVfgOBVm2WpFCn24BXdWKka2nTEM2GwTLMiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605302593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVCxA0v1aqJA5y2SXn2VIYReIMNMEMz6PBid6Ip5Ghs=;
        b=tEfnjL724lMQTGjqz2zcNP2XYp71GyXthGJaljNpM2Xd0jQ4uZ7Mq65DWisTP98pEKkJt9
        BRjVEeyUWIOvqdBw==
To:     linux-wireless@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Williams <dcbw@redhat.com>,
        Jes Sorensen <jes.sorensen@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 07/10] orinoco: Annotate ezusb_write_ltv()
Date:   Fri, 13 Nov 2020 22:22:49 +0100
Message-Id: <20201113212252.2243570-8-bigeasy@linutronix.de>
In-Reply-To: <20201113212252.2243570-1-bigeasy@linutronix.de>
References: <20201113212252.2243570-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All invocation of ezusb_write_ltv() happen via ->write_ltv() and are
performed under the orinoco_lock() which disables BH.

Use ezusb_req_ctx_wait_poll() for ezusb_write_ltv() because it must not
sleep.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/=
net/wireless/intersil/orinoco/orinoco_usb.c
index 7178889f9ec4c..d12bd5be4cde6 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -1029,7 +1029,7 @@ static int ezusb_write_ltv(struct hermes *hw, int bap=
, u16 rid,
 			   u16 length, const void *data)
 {
 	return __ezusb_write_ltv(hw, bap, rid, length, data,
-				 ezusb_req_ctx_wait);
+				 ezusb_req_ctx_wait_poll);
 }
=20
 static int ezusb_read_ltv(struct hermes *hw, int bap, u16 rid,
--=20
2.29.2


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629DC3BC05
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbfFJSux (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 14:50:53 -0400
Received: from bues.ch ([80.190.117.144]:52898 "EHLO bues.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387643AbfFJSux (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 14:50:53 -0400
Received: by bues.ch with esmtpsa (Exim 4.89)
        (envelope-from <m@bues.ch>)
        id 1haPNS-0002VR-Rf; Mon, 10 Jun 2019 20:50:42 +0200
Date:   Mon, 10 Jun 2019 20:49:27 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     H Buus <ubuntu@hbuus.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: [PATCH] ssb/gpio: Remove unnecessary WARN_ON from driver_gpio
Message-ID: <20190610204927.2de21c9a@wiggum>
In-Reply-To: <946c86bf-7e90-a981-b9fc-757adb98adfa@hbuus.com>
References: <946c86bf-7e90-a981-b9fc-757adb98adfa@hbuus.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/=aAChw9jp+ZBq/eLygL=Q5F"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/=aAChw9jp+ZBq/eLygL=Q5F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The WARN_ON triggers on older BCM4401-B0 100Base-TX ethernet controllers.
The warning serves no purpose. So let's just remove it.

Reported-by: H Buus <ubuntu@hbuus.com>
Signed-off-by: Michael B=C3=BCsch <m@bues.ch>

---

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index e809dae4c470..66a76fd83248 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -460,9 +460,6 @@ int ssb_gpio_init(struct ssb_bus *bus)
 		return ssb_gpio_chipco_init(bus);
 	else if (ssb_extif_available(&bus->extif))
 		return ssb_gpio_extif_init(bus);
-	else
-		WARN_ON(1);
-
 	return -1;
 }
=20
@@ -472,9 +469,6 @@ int ssb_gpio_unregister(struct ssb_bus *bus)
 	    ssb_extif_available(&bus->extif)) {
 		gpiochip_remove(&bus->gpio);
 		return 0;
-	} else {
-		WARN_ON(1);
 	}
-
 	return -1;
 }

--Sig_/=aAChw9jp+ZBq/eLygL=Q5F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAlz+pjcACgkQ9TK+HZCN
iw4Jdg//ehl1NpCjzEposBgzTwIUcrTrVMIOb7pM6uWKtJXJvy6Z8OypBgHXA5av
P8r26xazFPf5mzAV0HLNyRJkx8yYK7D9a0mwh6fFaWtiNtiefxCrdJePUiradRZU
TFvyXMCx7Qrnl4K9FjYTO+KF3m5ixLY2zjIPXVeKuydPz4xQj2oz0vO6l3YS2Bim
nELFrX4pCwzHtJSIHKuPgi80DGBI0aAVyyvE5nRDOuDq8AnDn70aLARvXy715COZ
dzfRPYinum/PBFLlkcV62YAtD/8enMiptj1vv67vKsImaYADatTnorTdqHGOJ/zB
upvdr4iEQuBTtv2WuR/82Ui/gxwI9cz87HbQ7aLRDNqSlsDAqHCD81+K/djzYRe+
2e4GTfVGV3/GTs5QdvC6jEOd9XfVTLkqMQs6USET58RxZrdnbaAhfdMVzexylw0H
MnZMsEawL7TdFoE7fR+Lix9o9cO2tDt0Q9KUqnfQOnYlMWVqHkCmrLp1XD5oqXz8
Rct7FMmEgfF1GXYbXBzqo8pdW0IB2RtMC6Al0VXeQwHQUdVRqN94z0+2JOjo/sxl
NDw/TOn9h+llDYNFEehOOZHbhkVjIrq34E7WUWxTDEqYI0XqAZgYRqWaJgzfW8dW
8P+PgzRXcM07vl/JyC84cLXKMgYvkLaoUcGf5PlHLbN15vJQvDw=
=wwDB
-----END PGP SIGNATURE-----

--Sig_/=aAChw9jp+ZBq/eLygL=Q5F--

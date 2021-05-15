Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD70381AA6
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 21:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhEOTIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbhEOTIE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 15:08:04 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90046C06174A
        for <linux-wireless@vger.kernel.org>; Sat, 15 May 2021 12:06:49 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1lhzcd-0004VQ-7m; Sat, 15 May 2021 21:06:47 +0200
Date:   Sat, 15 May 2021 21:02:52 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Albert Herranz <albert_herranz@yahoo.es>
Subject: [PATCH] drivers/ssb/sdio: Don't overwrite const buffer if
 block_write fails
Message-ID: <20210515210252.318be2ba@wiggum>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y6ZcHqRV_gAh0=B3sN6C5LL";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/Y6ZcHqRV_gAh0=B3sN6C5LL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

It doesn't make sense to clobber the const driver-side buffer, if a
write-to-device attempt failed. All other SSB variants (PCI, PCMCIA and SoC)
also don't corrupt the buffer on any failure in block_write.
Therefore, remove this memset from the SDIO variant.

Signed-off-by: Michael B=C3=BCsch <m@bues.ch>
Cc: stable@vger.kernel.org

---


This memset has been introduced by the original patch that added SDIO suppo=
rt to SSB:
24ea602e183ca
Better late than never.

This change is only build tested, because I don't own the hardware.
But to me this change looks reasonable.


diff --git a/drivers/ssb/sdio.c b/drivers/ssb/sdio.c
index 7fe0afb42234..66c5c2169704 100644
--- a/drivers/ssb/sdio.c
+++ b/drivers/ssb/sdio.c
@@ -411,7 +411,6 @@ static void ssb_sdio_block_write(struct ssb_device *dev=
, const void *buffer,
 	sdio_claim_host(bus->host_sdio);
 	if (unlikely(ssb_sdio_switch_core(bus, dev))) {
 		error =3D -EIO;
-		memset((void *)buffer, 0xff, count);
 		goto err_out;
 	}
 	offset |=3D bus->sdio_sbaddr & 0xffff;


--=20
Michael

--Sig_/Y6ZcHqRV_gAh0=B3sN6C5LL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmCgGtwACgkQ9TK+HZCN
iw6GFBAAvwpJgpOa92RaQ5DJO9Em5nqPv0WHnbGTrmj07TgDkHhWMNCrPux0gVpE
Xj2eXv1C8foZYktFlk7eJXWsxIFuYuJDPagpuAgVCpCQUMrY9kHjZoJO3Tk5nxHX
4Dk4+i2yZ8GjyXX2oWG0wdROvhonHEp4/lHg4gxY1YUAyg+saB+No618tVnHGHj8
YHU6DWb+F70FW6L42UDoEe6IeCGFiay2felWO8yhHmX81PZ2wynCDrm9GDV66PtR
Cki2gHXTIr2r6Z9wKqMrxpV1LyaKwGn48MFm2f85w48JIMy5uqFxJo0omA1y6rxT
Ke30Zp0ojdGA9Ortzhb8khLkgPzR2c5sfvkWvuZDgroNSmAHpYvHZ+TZ08qUIemg
gNP62CkDjVOsZxH2tPtCTTsvgDf0DyN5aPUp1GnPqtne3IuqcF7AAMa9F5F7+uHK
4ZpwvPTM26EtinQz8vXjSw/4OZechKhSAj5ZeNjPB7vO6QecAUeXrCNojKDxj9A8
xQBAxz9wfaxqsk6lqRh64r9dBwIK3vtrhDPqzj2O1XiPsYbC7tzWa+6SpNfLM5c5
GXLE6jjbtIC7DjlF0azTJLRyi+BJ+EfJ+OIEG41778QZtejCz+LAZzrFRVHTTzMY
Vs/Gc3tXxLRwgF1WQG4Rlc4EwtMJ/naeKDaiwNPf2rthh7lYm7s=
=6acF
-----END PGP SIGNATURE-----

--Sig_/Y6ZcHqRV_gAh0=B3sN6C5LL--

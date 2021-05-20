Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD038B4A6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhETQyz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 12:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhETQyz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 12:54:55 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB1EC061574
        for <linux-wireless@vger.kernel.org>; Thu, 20 May 2021 09:53:32 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1ljlvK-0002fj-5Z; Thu, 20 May 2021 18:53:26 +0200
Date:   Thu, 20 May 2021 18:51:36 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH] ssb: remove unreachable code
Message-ID: <20210520185136.2cc3b32b@wiggum>
In-Reply-To: <1621306352-3632-1-git-send-email-tiantao6@hisilicon.com>
References: <1621306352-3632-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9yn_9Xi7aIz1uvrSem5xeul";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/9yn_9Xi7aIz1uvrSem5xeul
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 May 2021 10:52:32 +0800
Tian Tao <tiantao6@hisilicon.com> wrote:

> The return value of ssb_bus_unregister can only be 0 or 1, so this
> condition if (err =3D=3D -EBUSY) will not hold, so delete it.

> @@ -431,9 +431,7 @@ void ssb_bus_unregister(struct ssb_bus *bus)
>  	int err;
> =20
>  	err =3D ssb_gpio_unregister(bus);
> -	if (err =3D=3D -EBUSY)
> -		pr_debug("Some GPIOs are still in use\n");
> -	else if (err)
> +	if (err)
>  		pr_debug("Can not unregister GPIO driver: %i\n", err);
> =20
>  	ssb_buses_lock();

Good catch.
Minor correction: The return value can be 0 or -1.

Acked-by: Michael B=C3=BCsch <m@bues.ch>

--=20
Michael

--Sig_/9yn_9Xi7aIz1uvrSem5xeul
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmCmk5gACgkQ9TK+HZCN
iw4Zjw/+PR1JOV5qLSRVoN5mk9nni2A6yBSjUESK0YBOlNeS1GV1OeELa8feTR4+
thkjdR+/6yTwznd1a7PovBUK1XGsctHWaYWwc0Rm7nRAZX3rYBBcsglWwqyKj3EK
UE8tFQwanZnnLRHRcoHHyAMi6uxs+KPkoLvy4RIfF+V9OCsQk31nXlg5tk6cgai5
VqliB7keK2F1yHNCzaejzkm1P9mvlCcowoslc+pLnr1zOKhboUDZKtT8Ikyt1gw8
B3cbbV5slaR5vwfsyeY7UrseN0QCw7rtGN4I81U/4L72T9wK4SJ5W5czwjxsMd0p
F3x8VQ7nXKYIJLL6uCPV8ephX98kkJrqiKovfI3QMv5JBCosLTHItkmDoXGg+McO
0cnWsBEAsLlv+1RBSrrxbsc0iCZOjm4G7MsusOHw6Mm62/3ZDL4U9P3u1XcMWY3v
o8MrqzxLl7UPiOHso7a9mzLyB6VD1aaoj8SMadmZnLROIWu43TIYd4rR1DiI+J7s
dmkaHMajpq10KsKnF9jE3gsatHAvzyPUa2ffqxfrf/tdDvADnhK05mpOdJQsbdOe
1l4Btql9CzuJOntbV/XYD5qb6qKE0aanyJpDj0Aj98qMQa5PCTXRqG1M3qCdhhnD
PMrFekUl1rImxLxXbU0XfsolX7i64bPHEgKirq1yPFkFRp6G5VI=
=I41V
-----END PGP SIGNATURE-----

--Sig_/9yn_9Xi7aIz1uvrSem5xeul--

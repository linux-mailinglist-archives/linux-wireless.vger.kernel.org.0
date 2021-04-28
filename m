Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A99F36DB71
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 17:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhD1PUh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 11:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhD1PUh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 11:20:37 -0400
X-Greylist: delayed 1934 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Apr 2021 08:19:52 PDT
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602A5C061573;
        Wed, 28 Apr 2021 08:19:52 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1lblTS-0007jW-ED; Wed, 28 Apr 2021 16:47:34 +0200
Date:   Wed, 28 Apr 2021 16:46:45 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanjanasrinidhi1810@gmail.com
Subject: Re: [PATCH] drivers: ssb: driver_gpio.c: Fix alignment of comment
Message-ID: <20210428164645.39559ed3@wiggum>
In-Reply-To: <20210428083020.gt6ea2guhfp75pan@kewl-virtual-machine>
References: <20210428083020.gt6ea2guhfp75pan@kewl-virtual-machine>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CK_k+jLTsDph9zu/18x_P=.";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/CK_k+jLTsDph9zu/18x_P=.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Apr 2021 14:00:20 +0530
Shubhankar Kuranagatti <shubhankarvk@gmail.com> wrote:

> The closing */ has been shifted to a new line
> This is done to maintain code uniformity.
>=20
> Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>


Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael

--Sig_/CK_k+jLTsDph9zu/18x_P=.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmCJdVUACgkQ9TK+HZCN
iw69Dw//XtghbaJTr8uQ5t5U+qHplAR3ZqAsj8TgiQciTw969R78gz+NpeC65TZ6
zTgZMZKDLW/NUSgVb+y5VJMOb9Ia6nVXoExJlqR2qOndFcVH0hLdeB9SioK4oVZL
eHvv+S3EYJ6Un/ipgpc+/i5q1WKx90RfbkC1M0tAR/5b+Em3A81n4V3yi52wwzO2
gZ5WTSspmmYArYwpZBzi04E2yNtdO/SSjRhKj+C7+eg0Uyfrq6GiDUEZghv7rNxj
cvKUmKeNbU+cUdUhhvCc/vsjCgvwYfoRqBaVXhqj3dMqFrehbt99xPHjlZgVuZnT
crcvAWUFOpL+o5TKET2NGvkdC8GJm89stldla2lrqkbgun10LKQ53Ayu6lf78Wbn
2mGLeocjc1C8TYz49chkbq9GdpixuTewoLjPzPHL1Nm76fstm0j/Q5V7SLOXo+E0
bH0PCIPKR6Ju8rDBzuuFeai4hc7d0k43apNd2oO0PnE5gkhzRixSqmwTB2cEyEsb
wu3onZv7vAaj1r9IWU1ucHSkj9qdC8uUCmmraXBRxELl7MwwCS41rhziY0rS248N
BekkNCAKV/FkAG2IzvRhoegU8sNn7emSBSqa5xo7EjcLpa2oVKauf+G0ZaIDSrV+
f0TzqvxAIzMQyb/q9Zob7CqkPTi5jmtZ7jNMgoRimOH9R1vCqvY=
=adWp
-----END PGP SIGNATURE-----

--Sig_/CK_k+jLTsDph9zu/18x_P=.--

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDB3149AC9
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 14:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgAZNZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 08:25:41 -0500
Received: from smtp.fennosys.fi ([62.241.241.27]:51738 "EHLO mail.fennosys.fi"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgAZNZl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 08:25:41 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jan 2020 08:25:41 EST
Received: (qmail 16871 invoked by uid 210); 26 Jan 2020 13:18:59 -0000
Received: from 49.158.119.22 (antti@fennosys.fi@49.158.119.22) by mail01-fennosys (envelope-from <antti@fennosys.fi>, uid 201) with qmail-scanner-2.08st 
 (clamdscan: 0.98.7/25706. spamassassin: 3.4.0. perlscan: 2.08st.  
 Clear:RC:1(49.158.119.22):. 
 Processed in 0.21049 secs); 26 Jan 2020 13:18:59 -0000
Received: from unknown (HELO gail) (antti@fennosys.fi@49.158.119.22)
  by 10.200.232.5 with ESMTPA; 26 Jan 2020 13:18:58 -0000
Date:   Sun, 26 Jan 2020 21:18:44 +0800
From:   Antti Antinoja <antti@fennosys.fi>
To:     linux-wireless@vger.kernel.org
Cc:     <amitkarwar@gmail.com>, <nishants@marvell.com>,
        <gbhat@marvell.com>, <huxinming820@gmail.com>
Subject: mwifiex: exit on error - without calling rcu_read_unlock()
Message-ID: <20200126211844.0dd4a761@gail>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UwmPMJ2Igkv4Q90MjlGL93c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/UwmPMJ2Igkv4Q90MjlGL93c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Please refer to:

* https://grsecurity.net/the_life_of_a_bad_security_fix
* https://github.com/torvalds/linux/commit/3d94a4a8373bf5f45cf5f939e88b8354=
dbf2311b#diff-c5e2f17b92b8e8f30306c5dd148d874f

At quick glance it looks to me like the issue really is there: Not calling =
rcu_read_unlock() before return on line 237.

Happy Lunar New Year to everyone! =3D)=20

Cheers,
Antti

--=20
Antti Antinoja            =E8=AB=BE=E4=BA=9E=E5=AE=89=E6=8F=90

Fennosys Oy
PL 14
10211 Inkoo
Finland

25141 =E6=96=B0=E5=8C=97=E5=B8=82=E6=B7=A1=E6=B0=B4=E5=8D=80=E8=95=83=E8=96=
=AF=E8=A3=A1 =E6=B0=B4=E7=A2=9325=E5=B7=B722=E8=99=9F1=E6=A8=93
=E8=8A=AC=E8=AB=BE=E5=AF=A6=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8

--Sig_/UwmPMJ2Igkv4Q90MjlGL93c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8+R7AHHq1TlJE3ZM7YNZ6NYh5+MFAl4tkbQACgkQ7YNZ6NYh
5+ObVxAAiCRDjCPpY6HTA+4ocu4H/zTRwm/V/32ezt1PR9ej9Cgz8QptJxlvXtQI
CLxQfStKKLqkI2McW5f1/ysyZuzQne2GfOygXqBKqZ8gJbJbnxmJhxhySPO//CxU
66muTB7AVRzzeqErZCdFPrTCY3btpBRbcldKzYz4o/Vt5BOle09sBNo6aXb7laK+
342LZCxdYJm5kHdVL/9R7aK2/Mq3GmtuQqCaBVKBpFj+4/qXchRbL9BH9N80WV6B
YGB93ZHhVpHu6VUm3Mb6rkBnyG+4ByirQWNc48le2OUrs3HiYUjJl1xZs6JaCTqj
O4ZVuCes62KD9lb2CDXH5y60z7wD2QbGk4d6m+jvFrLccIcyec2bMmu8yeUjTlyR
TSpeL+Kv2vZaSVizLBzFoyJNVp4UGIPM7Yqnij0trCxjGGJnHJXPNIkhJuRLD859
Mk6E5RXwnaxnd2X1VPxg+6wXUFM3/wCcQ2XMf/lUOOUpvI6gT2quAx5reQxT3VEk
X1fkvMxkLESS/3Uy2lt2WBktWEvGgwANhAQBKW0eqSB/O/w+pmmcMCkAFOtVAtpO
gpDBo1lDIqDdDSCTdNGlgJ+c4UqV97njZr0KAA8CS2aBzuLNbdsnTtOlKxHTJUD3
rHPpsDHU5pYAzlCD50MAch/5jmkjqcATiyEycrg0PN5/uDF2PnU=
=ZPoE
-----END PGP SIGNATURE-----

--Sig_/UwmPMJ2Igkv4Q90MjlGL93c--

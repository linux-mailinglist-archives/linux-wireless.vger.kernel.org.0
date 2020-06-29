Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC620E4D4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 00:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391071AbgF2V30 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 17:29:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:40480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbgF2SlZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3DA10AC12;
        Mon, 29 Jun 2020 17:29:20 +0000 (UTC)
Message-ID: <18c8d37bd02dd163fc5ba7d1ee69b341cf42e9aa.camel@suse.de>
Subject: 5GHz inbound connection latency spikes on Raspberry Pi
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Date:   Mon, 29 Jun 2020 19:29:18 +0200
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jQFVCaWKrmLwbeEqE53B"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-jQFVCaWKrmLwbeEqE53B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
I'm seeing latency spikes on inbound 5GHz connections with brcmfmac on RPi4=
.
For example, this is me pinging an idle RPi4 running today's linux-next bui=
ld
from my work computer (although I can reproduce this with older kernels and=
/or
RPi3):

	nico@linux-9qgx:~> ping 192.168.1.18
	PING 192.168.1.18 (192.168.1.18) 56(84) bytes of data.
	64 bytes from 192.168.1.18: icmp_seq=3D1 ttl=3D64 time=3D306 ms
	64 bytes from 192.168.1.18: icmp_seq=3D2 ttl=3D64 time=3D1351 ms
	64 bytes from 192.168.1.18: icmp_seq=3D3 ttl=3D64 time=3D326 ms
	64 bytes from 192.168.1.18: icmp_seq=3D4 ttl=3D64 time=3D175 ms
	64 bytes from 192.168.1.18: icmp_seq=3D5 ttl=3D64 time=3D1431 ms
	64 bytes from 192.168.1.18: icmp_seq=3D6 ttl=3D64 time=3D425 ms
	64 bytes from 192.168.1.18: icmp_seq=3D7 ttl=3D64 time=3D1457 ms
	64 bytes from 192.168.1.18: icmp_seq=3D8 ttl=3D64 time=3D441 ms
	64 bytes from 192.168.1.18: icmp_seq=3D9 ttl=3D64 time=3D360 ms
	64 bytes from 192.168.1.18: icmp_seq=3D10 ttl=3D64 time=3D1395 ms
	64 bytes from 192.168.1.18: icmp_seq=3D11 ttl=3D64 time=3D388 ms
	64 bytes from 192.168.1.18: icmp_seq=3D12 ttl=3D64 time=3D1431 ms
	64 bytes from 192.168.1.18: icmp_seq=3D13 ttl=3D64 time=3D416 ms
	64 bytes from 192.168.1.18: icmp_seq=3D14 ttl=3D64 time=3D1272 ms
	64 bytes from 192.168.1.18: icmp_seq=3D15 ttl=3D64 time=3D257 ms
	64 bytes from 192.168.1.18: icmp_seq=3D16 ttl=3D64 time=3D1291 ms
	64 bytes from 192.168.1.18: icmp_seq=3D17 ttl=3D64 time=3D277 ms

It turns out that if I disable the low power mode on the wireless network
interface: 'iwconfig wlan0 power off', everything behaves as expected, with
latencies between averaging 10ms. I've also found this patch[1] from RPi's
downstream kernel tree which tweaks the LPM entry delay and makes things a
little better. With it, SSHing into the machine is bearable.

I can understand that tweak not being OK for all brcmfmac users so I figure=
d I
could apply it conditionally on RPi's compatible strings. That said, before
doing anything I wonder if you have a better solution in mind.

Also note that latencies on 2GHz connections are also visible, but in the o=
rder
of 150-200ms, which is more acceptable.

Regards,
Nicolas

[1]=20
https://github.com/raspberrypi/linux/commit/3e0d7cb39d3229a00f06de5b3e60bd7=
acf0ece3f#diff-1b8fac2d29272755e8f53049866fc1e5


--=-jQFVCaWKrmLwbeEqE53B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl76JO8ACgkQlfZmHno8
x/6SbggApJERYtm8BstgLfwEcQpLAfZ2DY2xL7BB2fSmrQ/5Gf/KUOEHqgDs3se0
zM5muczJATP1SvIRZVU06Ss+cJjKxXqqIUIJK9nt5OitSYmuciFWQCTy15mM4qTt
e3IUsm4dep49K2+Kcx11/v9BYwLGAAhbHsaVUQ4E2VQWVI9SSlfQXFZtks+km39z
Z3molekb9yVDllufwyRlrTil7TpzEr1WKC550qqLwB+84HIKvfPHCGazWuxzwEKP
+UG/2XYwQm4opBk7LTzuPF07jYiWmYXl8AM2llJQ5glKQXQ5g0Va8iRyqvlWjAqC
DVpYaKokfygKc96kkEX6JWd5JM9BGw==
=N34j
-----END PGP SIGNATURE-----

--=-jQFVCaWKrmLwbeEqE53B--


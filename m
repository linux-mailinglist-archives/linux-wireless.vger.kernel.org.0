Return-Path: <linux-wireless+bounces-12889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C84B979F2D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 12:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28B6281969
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53BD14E2C0;
	Mon, 16 Sep 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="f2kYwbDC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144FA935
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482085; cv=none; b=cYX8oAabJ2HCqdZK4VSBJOsyEM/oglpcG12wzLhj8bTLpy2jEIz11N/0NyXEg5SYXPmQbqQNMalwUJ/LJ45duTXY3v0507skxQeDAG4zl2xtedevMU5pAjTRAUSc7CPSL82/JsaVcPdQ0shB6ZpQSIgwuktOwOjdhp/Zk/32CMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482085; c=relaxed/simple;
	bh=rOcmnoe1FSxkCxkOprDoSHqeBErSJaOiByo1hVRwFv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pb8g5ywkmhbP9JByfObyZTE+pOdupWkdShVppFmDcc2+MswYYkmgx2RY5FTfU6E34FDcpIzyIWglepYoNM5vY6IEV9qLgQvAJTn3n0yMzuxvWEJYt4+6z+w09kLgNlPyTv4qbWw8P4Cxb2TjX3Kaam45wj6Ih5gL/ZlMTkJqNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=f2kYwbDC; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726482071; x=1727086871; i=s.l-h@gmx.de;
	bh=kTCm+NXCEOV/Oem4vJO48DeGdxULj80Tpe8AqqiA0mo=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f2kYwbDClhHJhdiQihakXTO7DOZ77IKrnRAvSI5q600BVU8tfFRk1OQTOjIs/NB8
	 ui8nL7IBA4K+4aHDWPMiFbQ6Pogj3qUKHArG2EJJSwuf+ClJBgXN9QxByOUVlV3sh
	 Y2F/lxTNhtF83M4cBjB5l03Aml+oNKjpBdVEGZOzg9lXQjdFIo1wvtB9I63D5KGNC
	 l/9jtKEhAhINnrwb4pL1cGAUa6HS8sPEBTwCFLC9qsTTU6kfDvj5J4EN2EvzghWpj
	 49udgrCas4rt6SDKZXy6FYuSiXdDXsakEUk+PZXpLkkX4zj1592a3PV6unQ/NLKXw
	 K5+ZdXsNtDyeAAMccA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.81.155]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1sYt7O2rUv-00YNCn; Mon, 16
 Sep 2024 12:21:11 +0200
Date: Mon, 16 Sep 2024 12:21:08 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Message-ID: <20240916122108.165d5741@mir>
In-Reply-To: <f0900afbfbd54f5a9fae875e1cb53470@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	<20240313064917.527110c4@mir>
	<4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
	<20240915080434.564d1c66@mir>
	<f0900afbfbd54f5a9fae875e1cb53470@realtek.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XTxqrbIuZ4a3D+P5vsQf0lI";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ls0YHEsx5QaRreavLaCLJQgGNxmMUmuArsaPyHRKGe+OUS2AXod
 EuA9E5B49KU8aQYL+uCk5Pi/ERvfV+3UrH1zO2g3MwJNx4H0Ej17LijdO5oFNh3Blmqpb9M
 ee60gfqkxagmlut1oOxmrY1JET5dhY/NbK1pIz6Lf8c1X+Tgj7EXOVy8BmHeoZ0raKKSNMf
 5suPZycOlgyLa8XfOXfBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yXIzVrQez8U=;k16RIikY9RfP4xsvSU5+j+WBHyM
 bbtJzO3TNPbTWl6zwdbGS1J6a4tnKrtpEgMq7nt0NktuKVsP1qZzv2azPK5JXUaWxz7nXD1LV
 RB/Xg9ZpRex+JfEKpj5DBd2/B3PHzlQJ0K6PTMXp+OpEbSaHSa7kQGC53Q8yRAJp6LbqvU0SD
 NlUhaUA1YGWzE34LMl7n7pINOyYv5uD/q6sAGGjBp7g+c7nPqcNPr5FBhItCEzzN/eHgzKLJN
 83AlLakfpxiAQfnv6MHN5Kx/M1A92v4TYOiE29pdjMsOA0vyPv0kmbWYjxpGlbWWAwc8JScm/
 +FvZXb4fquoL3rW1zkBy8JUbSSYpOJpfJKSbO6j7YdfPH/l3NONVBjn5e6XIDLQygkdBbtYgT
 padQkOZE1sKxchrAzGh9qLEvjNI0RRptxK8cAn0gJPujeoAYHzUCCibq3ZWLAMkIWhINkOYn+
 iZDaozLEoWGVbPf6tQp1jz2aNmnYHwxBvhk/0TmDO5OQAw4uPBSqunJ7NStqZ2+LSFd+gLxwt
 ezJfhV89DjuWY+sWVXUSrKEa3GJHNmQSxNoMZ9XAPLsrUTIg5UcWUv0E806jnzAQiHJORc0KX
 zhrJG6DmG1Kp0vT8hctm9GY3tI9WyC6y21d1yrUqzEzlvzh5/xoJZcqP2YJaU+4WGp2A03xKO
 sUVJXZlwHnYFUelPLtCmsH3CakRnwgGHuRev2An3cFthtnzHKv3buTvavhFImI3wSj7E9tD+A
 5Kn3PQ/7qiU0XAPXEsLlDIFqeRn+/TO3ST9317XRpW6pqn3HvDjHYJ2sfbiWRIG2TkDIdCSFQ
 UxpSjNp69T1GT4WUpB/qmafw==

--Sig_/XTxqrbIuZ4a3D+P5vsQf0lI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi

On 2024-09-16, Ping-Ke Shih wrote:
> Stefan Lippers-Hollmann <s.l-h@gmx.de> wrote:
> > On 2024-03-13, Ping-Ke Shih wrote:
> > > On Wed, 2024-03-13 at 06:49 +0100, Stefan Lippers-Hollmann wrote:
> > > > On 2024-03-13, Bitterblue Smith wrote:
> > > > > Create the new module rtl8192d-common and move some code into it =
from
> > > > > rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du d=
river
> > > > > (USB) can share some of the code.
> > [...]
> > > > Using the firmware from https://github.com/lwfinger/rtl8192du/,
> > > > it would be great if someone could publish the necessary firmware
> > > > to linux-firmware.
> > > >
> > > > MD5:
> > > > abccba1e9bb456eb81dfc88502a56300  /lib/firmware/rtlwifi/rtl8192dufw=
.bin
>=20
> I found its version is 38 that is little bit older than [1] (version 39).=
=20
> Bitterblue has made a binary from [1] and I have verified the binary.=20
> I will send this firmware days later because my previous firmware is
> still under review.=20

[...]

> [1] https://github.com/lwfinger/rtl8192du/blob/master/hal/Hal8192DUHWImg.c

Great, just a quick functionality check with this firmware (v39):

MD5:
18eb8791673dcc38b268ad19c92ba6a2 */lib/firmware/rtlwifi/rtl8192dufw.bin

SHA256:
710c4a28904b180e5a316a372e1038972102b2545909bc117c2455cf536e4490 */lib/firm=
ware/rtlwifi/rtl8192dufw.bin

Connects and works fine with kernel v6.11, using WPA3SAE over 5 GHz.

[  202.941904] usb 3-5: new high-speed USB device number 5 using xhci_hcd
[  203.070437] usb 3-5: New USB device found, idVendor=3D0bda, idProduct=3D=
8194, bcdDevice=3D 0.00
[  203.070453] usb 3-5: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[  203.070460] usb 3-5: Product: 802.11n NIC
[  203.070464] usb 3-5: Manufacturer: Realtek
[  203.070468] usb 3-5: SerialNumber: 00e04c000001
[  203.220236] rtl_usb: rx_max_size 15360, rx_urb_num 8, in_ep 1
[  203.220248] rtl8192du: Driver for Realtek RTL8192DU WLAN interface
[  203.220249] rtl8192du: Loading firmware file rtlwifi/rtl8192dufw.bin
[  203.220324] ieee80211 phy1: Selected rate control algorithm 'rtl_rc'
[  203.220648] usbcore: registered new interface driver rtl8192du
[  203.227708] rtl8192du 3-5:1.0 wlxXXXlocalMACXXX: renamed from wlan0
[  230.852662] wlxXXXlocalMACXXX: authenticate with XXXAP1MACXXX (local add=
ress=3DXXXlocalMACXXX)
[  230.852670] wlxXXXlocalMACXXX: send auth to XXXAP1MACXXX (try 1/3)
[  230.870370] wlxXXXlocalMACXXX: authenticate with XXXAP1MACXXX (local add=
ress=3DXXXlocalMACXXX)
[  230.870381] wlxXXXlocalMACXXX: send auth to XXXAP1MACXXX (try 1/3)
[  230.873195] wlxXXXlocalMACXXX: authenticated
[  230.874472] wlxXXXlocalMACXXX: associate with XXXAP1MACXXX (try 1/3)
[  230.885511] wlxXXXlocalMACXXX: RX AssocResp from XXXAP1MACXXX (capab=3D0=
x1511 status=3D0 aid=3D2)
[  230.887245] wlxXXXlocalMACXXX: associated
[  230.897180] wlxXXXlocalMACXXX: Limiting TX power to 23 (23 - 0) dBm as a=
dvertised by XXXAP1MACXXX
[  240.889472] wlxXXXlocalMACXXX: deauthenticating from XXXAP1MACXXX by loc=
al choice (Reason: 3=3DDEAUTH_LEAVING)
[  244.386457] wlxXXXlocalMACXXX: authenticate with XXXAP2MACXXX (local add=
ress=3DXXXlocalMACXXX)
[  244.386470] wlxXXXlocalMACXXX: send auth to XXXAP2MACXXX (try 1/3)
[  244.397502] wlxXXXlocalMACXXX: authenticate with XXXAP2MACXXX (local add=
ress=3DXXXlocalMACXXX)
[  244.397515] wlxXXXlocalMACXXX: send auth to XXXAP2MACXXX (try 1/3)
[  244.399226] wlxXXXlocalMACXXX: authenticated
[  244.400306] wlxXXXlocalMACXXX: associate with XXXAP2MACXXX (try 1/3)
[  244.407420] wlxXXXlocalMACXXX: RX AssocResp from XXXAP2MACXXX (capab=3D0=
x1511 status=3D0 aid=3D3)
[  244.408977] wlxXXXlocalMACXXX: associated
[  244.461286] wlxXXXlocalMACXXX: Limiting TX power to 23 (23 - 0) dBm as a=
dvertised by XXXAP2MACXXX

(there is AP-side active bandsteering/ roaming at play)

# wpa_cli -i wlxXXXlocalMACXXX status
bssid=3DXXXAP2MACXXX
freq=3D5260
ssid=3DXXX
id=3D4
id_str=3DXXX
mode=3Dstation
wifi_generation=3D4
pairwise_cipher=3DCCMP
group_cipher=3DCCMP
key_mgmt=3DSAE
pmf=3D2
mgmt_group_cipher=3DBIP
sae_group=3D19
sae_h2e=3D0
sae_pk=3D0
wpa_state=3DCOMPLETED
p2p_device_address=3DXXXlocalMACXXX
address=3DXXXlocalMACXXX
uuid=3DXXXUUIDXXX

$ iperf3 -c XXXremoteIPv6XXX
Connecting to host XXXremoteIPv6XXX, port 5201
[  5] local XXXlocalXXX port 45116 connected to XXXremoteIPv6XXX port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  13.9 MBytes   116 Mbits/sec    0    441 KBytes    =
  =20
[  5]   1.00-2.00   sec  12.1 MBytes   102 Mbits/sec    0    471 KBytes    =
  =20
[  5]   2.00-3.00   sec  11.4 MBytes  95.4 Mbits/sec    0    471 KBytes    =
  =20
[  5]   3.00-4.00   sec  12.5 MBytes   105 Mbits/sec    0    604 KBytes    =
  =20
[  5]   4.00-5.00   sec  11.1 MBytes  93.3 Mbits/sec    0    604 KBytes    =
  =20
[  5]   5.00-6.00   sec  11.4 MBytes  95.4 Mbits/sec    0    604 KBytes    =
  =20
[  5]   6.00-7.00   sec  11.9 MBytes  99.6 Mbits/sec    0    637 KBytes    =
  =20
[  5]   7.00-8.00   sec  10.8 MBytes  90.2 Mbits/sec    0    637 KBytes    =
  =20
[  5]   8.00-9.00   sec  11.8 MBytes  98.6 Mbits/sec    0    637 KBytes    =
  =20
[  5]   9.00-10.00  sec  12.0 MBytes   101 Mbits/sec    0    722 KBytes    =
  =20
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   119 MBytes  99.6 Mbits/sec    0             sender
[  5]   0.00-10.02  sec   116 MBytes  97.2 Mbits/sec                  recei=
ver

iperf Done.

$ iperf3 -c XXXremoteIPv6XXX --reverse
Connecting to host XXXremoteIPv6XXX, port 5201
Reverse mode, remote host XXXremoteIPv6XXX is sending
[  5] local XXXlocalXXX port 58256 connected to XXXremoteIPv6XXX port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  12.6 MBytes   106 Mbits/sec                 =20
[  5]   1.00-2.00   sec  13.6 MBytes   114 Mbits/sec                 =20
[  5]   2.00-3.00   sec  14.1 MBytes   118 Mbits/sec                 =20
[  5]   3.00-4.00   sec  14.0 MBytes   117 Mbits/sec                 =20
[  5]   4.00-5.00   sec  12.2 MBytes   103 Mbits/sec                 =20
[  5]   5.00-6.00   sec  14.2 MBytes   120 Mbits/sec                 =20
[  5]   6.00-7.00   sec  12.5 MBytes   105 Mbits/sec                 =20
[  5]   7.00-8.00   sec  12.5 MBytes   105 Mbits/sec                 =20
[  5]   8.00-9.00   sec  13.9 MBytes   116 Mbits/sec                 =20
[  5]   9.00-10.00  sec  14.1 MBytes   118 Mbits/sec                 =20
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.01  sec   138 MBytes   116 Mbits/sec    0             sender
[  5]   0.00-10.00  sec   134 MBytes   112 Mbits/sec                  recei=
ver

iperf Done.

$ iperf3 -c XXXremoteIPv6XXX --bidir
Connecting to host XXXremoteIPv6XXX, port 5201
[  5] local XXXlocalXXX port 50634 connected to XXXremoteIPv6XXX port 5201
[  7] local XXXlocalXXX port 50646 connected to XXXremoteIPv6XXX port 5201
[ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
[  5][TX-C]   0.00-1.00   sec  6.25 MBytes  52.4 Mbits/sec    0    300 KByt=
es      =20
[  7][RX-C]   0.00-1.00   sec  7.00 MBytes  58.7 Mbits/sec                 =
=20
[  5][TX-C]   1.00-2.00   sec  3.88 MBytes  32.5 Mbits/sec    0    414 KByt=
es      =20
[  7][RX-C]   1.00-2.00   sec  10.1 MBytes  84.9 Mbits/sec                 =
=20
[  5][TX-C]   2.00-3.00   sec  1.88 MBytes  15.7 Mbits/sec    0    464 KByt=
es      =20
[  7][RX-C]   2.00-3.00   sec  12.4 MBytes   104 Mbits/sec                 =
=20
[  5][TX-C]   3.00-4.00   sec  1.88 MBytes  15.7 Mbits/sec    0    487 KByt=
es      =20
[  7][RX-C]   3.00-4.00   sec  12.2 MBytes   103 Mbits/sec                 =
=20
[  5][TX-C]   4.00-5.00   sec  2.38 MBytes  19.9 Mbits/sec    0    582 KByt=
es      =20
[  7][RX-C]   4.00-5.00   sec  10.9 MBytes  91.2 Mbits/sec                 =
=20
[  5][TX-C]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0    602 KBytes=
      =20
[  7][RX-C]   5.00-6.00   sec  10.2 MBytes  86.0 Mbits/sec                 =
=20
[  5][TX-C]   6.00-7.00   sec  1.50 MBytes  12.6 Mbits/sec    0    661 KByt=
es      =20
[  7][RX-C]   6.00-7.00   sec  10.6 MBytes  89.1 Mbits/sec                 =
=20
[  5][TX-C]   7.00-8.00   sec  1.38 MBytes  11.5 Mbits/sec    0    728 KByt=
es      =20
[  7][RX-C]   7.00-8.00   sec  11.5 MBytes  96.5 Mbits/sec                 =
=20
[  5][TX-C]   8.00-9.00   sec  1.38 MBytes  11.5 Mbits/sec    0    777 KByt=
es      =20
[  7][RX-C]   8.00-9.00   sec  10.4 MBytes  87.0 Mbits/sec                 =
=20
[  5][TX-C]   9.00-10.00  sec  1.38 MBytes  11.5 Mbits/sec    2    593 KByt=
es      =20
[  7][RX-C]   9.00-10.00  sec  11.1 MBytes  93.1 Mbits/sec                 =
=20
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec  21.9 MBytes  18.3 Mbits/sec    2            =
 sender
[  5][TX-C]   0.00-10.02  sec  19.5 MBytes  16.3 Mbits/sec                 =
 receiver
[  7][RX-C]   0.00-10.00  sec   110 MBytes  92.7 Mbits/sec    0            =
 sender
[  7][RX-C]   0.00-10.02  sec   106 MBytes  89.2 Mbits/sec                 =
 receiver

iperf Done.

# iw dev wlxXXXlocalMACXXX station dump
Station XXXAP2MACXXX (on wlxXXXlocalMACXXX)
        inactive time:  1 ms
        rx bytes:       819594565
        rx packets:     556734
        tx bytes:       379056249
        tx packets:     427613
        tx retries:     0
        tx failed:      0
        beacon loss:    0
        rx drop misc:   0
        signal:         10 dBm
        signal avg:     -66 dBm
        tx bitrate:     300.0 MBit/s MCS 15 40MHz short GI
        tx duration:    0 us
        rx bitrate:     243.0 MBit/s MCS 14 40MHz
        rx duration:    0 us
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            yes
        TDLS peer:      no
        DTIM period:    3
        beacon interval:100
        short slot time:yes
        connected time: 556 seconds
        associated at [boottime]:       244.363s
        associated at:  1726480574210 ms
        current time:   1726481129874 ms

# iw phy phy1 info
Wiphy phy1
        wiphy index: 1
        max # scan SSIDs: 4
        max scan IEs length: 2257 bytes
        max # sched scan SSIDs: 0
        max # match sets: 0
        RTS threshold: 2347
        Retry short limit: 7
        Retry long limit: 4
        Coverage class: 0 (up to 0m)
        Device supports RSN-IBSS.
        Supported Ciphers:
                * WEP40 (00-0f-ac:1)
                * WEP104 (00-0f-ac:5)
                * TKIP (00-0f-ac:2)
                * CCMP-128 (00-0f-ac:4)
                * CCMP-256 (00-0f-ac:10)
                * GCMP-128 (00-0f-ac:8)
                * GCMP-256 (00-0f-ac:9)
                * CMAC (00-0f-ac:6)
                * CMAC-256 (00-0f-ac:13)
                * GMAC-128 (00-0f-ac:11)
                * GMAC-256 (00-0f-ac:12)
        Available Antennas: TX 0 RX 0
        Supported interface modes:
                 * IBSS
                 * managed
                 * AP
                 * AP/VLAN
                 * monitor
                 * mesh point
                 * P2P-client
                 * P2P-GO
        Band 1:
                Capabilities: 0x186e
                        HT20/HT40
                        SM Power Save disabled
                        RX HT20 SGI
                        RX HT40 SGI
                        No RX STBC
                        Max AMSDU length: 7935 bytes
                        DSSS/CCK HT40
                Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
                Minimum RX AMPDU time spacing: 16 usec (0x07)
                HT Max RX data rate: 300 Mbps
                HT TX/RX MCS rate indexes supported: 0-15, 32
                Bitrates (non-HT):
                        * 1.0 Mbps
                        * 2.0 Mbps
                        * 5.5 Mbps
                        * 11.0 Mbps
                        * 6.0 Mbps
                        * 9.0 Mbps
                        * 12.0 Mbps
                        * 18.0 Mbps
                        * 24.0 Mbps
                        * 36.0 Mbps
                        * 48.0 Mbps
                        * 54.0 Mbps
                Frequencies:
                        * 2412.0 MHz [1] (20.0 dBm)
                        * 2417.0 MHz [2] (20.0 dBm)
                        * 2422.0 MHz [3] (20.0 dBm)
                        * 2427.0 MHz [4] (20.0 dBm)
                        * 2432.0 MHz [5] (20.0 dBm)
                        * 2437.0 MHz [6] (20.0 dBm)
                        * 2442.0 MHz [7] (20.0 dBm)
                        * 2447.0 MHz [8] (20.0 dBm)
                        * 2452.0 MHz [9] (20.0 dBm)
                        * 2457.0 MHz [10] (20.0 dBm)
                        * 2462.0 MHz [11] (20.0 dBm)
                        * 2467.0 MHz [12] (20.0 dBm)
                        * 2472.0 MHz [13] (20.0 dBm)
                        * 2484.0 MHz [14] (disabled)
        Band 2:
                Capabilities: 0x186e
                        HT20/HT40
                        SM Power Save disabled
                        RX HT20 SGI
                        RX HT40 SGI
                        No RX STBC
                        Max AMSDU length: 7935 bytes
                        DSSS/CCK HT40
                Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
                Minimum RX AMPDU time spacing: 16 usec (0x07)
                HT Max RX data rate: 300 Mbps
                HT TX/RX MCS rate indexes supported: 0-15, 32
                Bitrates (non-HT):
                        * 6.0 Mbps
                        * 9.0 Mbps
                        * 12.0 Mbps
                        * 18.0 Mbps
                        * 24.0 Mbps
                        * 36.0 Mbps
                        * 48.0 Mbps
                        * 54.0 Mbps
                Frequencies:
                        * 5180.0 MHz [36] (23.0 dBm)
                        * 5200.0 MHz [40] (23.0 dBm)
                        * 5220.0 MHz [44] (23.0 dBm)
                        * 5240.0 MHz [48] (23.0 dBm)
                        * 5260.0 MHz [52] (20.0 dBm) (no IR, radar detectio=
n)
                        * 5280.0 MHz [56] (20.0 dBm) (no IR, radar detectio=
n)
                        * 5300.0 MHz [60] (20.0 dBm) (no IR, radar detectio=
n)
                        * 5320.0 MHz [64] (20.0 dBm) (no IR, radar detectio=
n)
                        * 5500.0 MHz [100] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5520.0 MHz [104] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5540.0 MHz [108] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5560.0 MHz [112] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5580.0 MHz [116] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5600.0 MHz [120] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5620.0 MHz [124] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5640.0 MHz [128] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5660.0 MHz [132] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5680.0 MHz [136] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5700.0 MHz [140] (26.0 dBm) (no IR, radar detecti=
on)
                        * 5745.0 MHz [149] (13.0 dBm)
                        * 5765.0 MHz [153] (13.0 dBm)
                        * 5785.0 MHz [157] (13.0 dBm)
                        * 5805.0 MHz [161] (13.0 dBm)
                        * 5825.0 MHz [165] (13.0 dBm)
        Supported commands:
                 * new_interface
                 * set_interface
                 * new_key
                 * start_ap
                 * new_station
                 * new_mpath
                 * set_mesh_config
                 * set_bss
                 * authenticate
                 * associate
                 * deauthenticate
                 * disassociate
                 * join_ibss
                 * join_mesh
                 * remain_on_channel
                 * set_tx_bitrate_mask
                 * frame
                 * frame_wait_cancel
                 * set_wiphy_netns
                 * set_channel
                 * probe_client
                 * set_noack_map
                 * register_beacons
                 * start_p2p_device
                 * set_mcast_rate
                 * testmode
                 * connect
                 * disconnect
                 * set_qos_map
                 * set_multicast_to_unicast
        software interface modes (can always be added):
                 * AP/VLAN
                 * monitor
        interface combinations are not supported
        HT Capability overrides:
                 * MCS: ff ff ff ff ff ff ff ff ff ff
                 * maximum A-MSDU length
                 * supported channel width
                 * short GI for 40 MHz
                 * max A-MPDU length exponent
                 * min MPDU start spacing
        Device supports TX status socket option.
        Device supports HT-IBSS.
        Device supports SAE with AUTHENTICATE command
        Device supports low priority scan.
        Device supports scan flush.
        Device supports AP scan.
        Device supports per-vif TX power setting
        Driver supports full state transitions for AP/GO clients
        Driver supports a userspace MPM
        Device supports configuring vdev MAC-addr on create.
        max # scan plans: 1
        max scan plan interval: -1
        max scan plan iterations: 0
        Supported TX frame types:
                 * IBSS: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 =
0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x=
90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0x=
a0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * AP/VLAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x=
90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * mesh point: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80=
 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80=
 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x9=
0 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80=
 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
        Supported RX frame types:
                 * IBSS: 0x40 0xb0 0xc0 0xd0
                 * managed: 0x40 0xb0 0xd0
                 * AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
                 * AP/VLAN: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
                 * mesh point: 0xb0 0xc0 0xd0
                 * P2P-client: 0x40 0xd0
                 * P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
                 * P2P-device: 0x40 0xd0
        Supported extended features:
                * [ RRM ]: RRM
                * [ FILS_STA ]: STA FILS (Fast Initial Link Setup)
                * [ CONTROL_PORT_OVER_NL80211 ]: control port over nl80211
                * [ TXQS ]: FQ-CoDel-enabled intermediate TXQs
                * [ SCAN_RANDOM_SN ]: use random sequence numbers in scans
                * [ SCAN_MIN_PREQ_CONTENT ]: use probe request with only ra=
te IEs in scans
                * [ CONTROL_PORT_NO_PREAUTH ]: disable pre-auth over nl8021=
1 control port support
                * [ DEL_IBSS_STA ]: deletion of IBSS station support
                * [ SCAN_FREQ_KHZ ]: scan on kHz frequency support
                * [ CONTROL_PORT_OVER_NL80211_TX_STATUS ]: tx status for nl=
80211 control port support
                * [ POWERED_ADDR_CHANGE ]: can change MAC address while up

Regards
	Stefan Lippers-Hollmann

--Sig_/XTxqrbIuZ4a3D+P5vsQf0lI
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEMQMcJCzZm4GSqVV4v+AtZbHRQu0FAmboBpQACgkQv+AtZbHR
Qu2kthAAnyQNMTNoDT9ApyhJpPE8odR0lCtr1srYntEHT4VTxGz0vWDlFXdpa8s5
Cke9rRwOAD6Dc6JuLDPvwJBJ78hJ4xuOSfgLaNcAJJGwNFn8agTxgjhJ1XXIzfAe
lWpBGbZV4dz9ZZLUV8nIIjgonuZkfEsM/IjlzGqOQXMq64TBl7jP6ijs5LyNqKOZ
Gj582I32t2MuQ4yaG+0AqqcFjKsRpnt49mNv/AtJtugW1GRRPLwpu+aZtu4p1Eyp
x82MvEvngze4G9caBt/OOMSZaLGViw8VGcajQvrL/dvpALp8Gbbl0m8RKOZnazmo
G9BjuS+mor0sgDDdC+Jd0QH9BTpE7Ds1D4FVKZreEK7dzkFNcR2M7AAh7DqLzE9y
ONeAvQIQz4/m8A9N2DVzOwR7DKwx7ZRV/d72BRAO2MiB3LbIQD0b8wTi7n2z5wlw
MXpBCdFqO50wcfk+3Fs6SRmkITkODBcWL19O3YSHtE7tJ2NKbEyk1jp2TvNU1BXR
oykoNDDaChkqVUFKCPF1STlTEb6dMywCDuNXGi2XjlCcF64baIHnf0CoOemlMtOm
4QvuFHe+cANN+bZ6NfN3wX+FPLyfq/teZO6aqGXYHysqYwFYum7bxw5WqfnWn8n5
brIPv3QtXjrDX+dE5wdCQQDKLk6NkEdEVmt4p8DRMFA+pmdUaM0=
=B35V
-----END PGP SIGNATURE-----

--Sig_/XTxqrbIuZ4a3D+P5vsQf0lI--


Return-Path: <linux-wireless+bounces-6061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23F89E937
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 06:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6651F234AE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 04:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0D28FD;
	Wed, 10 Apr 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="bc+thpQ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DE10958
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724814; cv=none; b=fEpWZSdaqeHwETUuC/JZIuHmHKAA+qz9ygCoFXtQSdiR9pW9DlKKVOxn1OIIzqjn2d0/LSDErq/CkOlLd/7jOENGwxJ1NDWOXE40z+SmvqLlphcbEFtpT71FCX1tyuivgn2zf//T3/TjiMQTAqrntjcLv9hd6dQ/iVlzStMUIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724814; c=relaxed/simple;
	bh=WxbCYz2A6fHX+A+gfhZ060T+Q+2fDrdBxmNNra1x80Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRnlXydqZtzgGuszy4ibnV6oNZHhrM6kC5tbTJDc6+NTJRYRaJA7mQxZ18rCaHFMBkCkNzvAb5GOzpYZ57OOhOXpreB72KdOGIVU5OEAdx4vwa3wC7iV3xI0jXTi3AvjxulxkZWoXksKrPVCBqsOHtiMuh5lI1BQOrQJ5zr14Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=bc+thpQ3; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712724792; x=1713329592; i=s.l-h@gmx.de;
	bh=p80A2YBPrRUKWod8qbaFw64Jqvyf4Bz2huZqqRSyukY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=bc+thpQ3gWrH6ht8IcGjUOb7InB9G8EfCs48FN5Imp6Y+xtjfuGrahiR/ZXjovZQ
	 gaEx/mLY6CE4jjZbXIMfEAQ8S5vnPqg1dhpQD8Yedx8vi7DcAISYw05fql8jD8Ddw
	 xLzAc1UgiZNB9NKdJf27NrxTmyi28fDL93FFy56H9UHk04RGOnGOwmDKT6nJTK+VT
	 4ADEbP6bZLuVfpJCfG06k4diap4YMNr1DtnF1sY+Gk9meWmtRT/8/O0OhydEHqdZ2
	 IqoKOh2duB1c9UO3hmsVq9d9bNq7hTJYF/FRSFvz6hotW3TsOXta4ob6ExRlbf2eM
	 LdYRMyON+p//VoESng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV63q-1sJGta2Xva-00S6NG; Wed, 10
 Apr 2024 06:53:12 +0200
Date: Wed, 10 Apr 2024 06:53:08 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger
 <Larry.Finger@lwfinger.net>, Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH v4 02/14] wifi: rtlwifi: rtl8192de: Fix low speed with
 WPA3-SAE
Message-ID: <20240410065308.57328623@mir>
In-Reply-To: <ed12ec17-ae6e-45fa-a72f-23e0a34654da@gmail.com>
References: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
	<ed12ec17-ae6e-45fa-a72f-23e0a34654da@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7+f7kB9RcpcGxut6/mCF9oSbp2HQxJPdxhVGi5a2uwfzu+Gll0P
 n8VI5pJvhEwMQdGhgKW/7oYm3KzqZ8kqbfcok2dOnym8gj0pJ+vnEUN+l0HF0bZUgpPmqY5
 ZpAtG0xUYWsOEJxsuwvVwr8hpstxBiMoD07lexV/ZihAqb4yrNDlkM/oyCujwfWkqlletwa
 ZVZ71iBKyM+QbRA4Cx/tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xl0KhMZRUlc=;TA/NZBVNxHi7eiPyRQFicMi4PGD
 mRjwTWyC8ckjAllT+TleMhiV6t/oLVt1e288cagc2w6XHKQLffpmdIBTxa5r9viMobpzhzr/4
 9Yq2uAKhh1Rb+VUn+FhYWOaEJ/fuUvyUxwA/EIiasWyKQ3shRhMx+qnm+O8dhTuVwhsPLybZB
 MFi7i9Hb8KbHdFEFGtFoKAL9TsdokTDquUS8QATHUX7P7FM5W/p77Re9QhKTMmfDfqAE6vuXg
 +KG2ImpY6AbCEVeyXO09nKEqkFspLGToB9H45Hc7tk7OwHMgi9iQoS6ARgl7WTYX7U2Ip6K80
 tHFk9TDwZnkvJoKoj+34EOAuSFxjELSeGhyWrCXZIX/4+sh8r3tXgB6n73vZaLrVqtl9hj0Y0
 rrWSDRV8/pABSC4s2l4UjhY2lXFnMSAkiPGw7+bFmFTolD5xBNNIDbOBoRhKlT0lPqA+Fw2Eq
 wTUcS+Kgr2fwWbyHnyAhL1I2XsfRdsyGJrrlHO/9yjAmHyU+y1u4AtRWCdW10TyCpA9+F6Ow2
 oZr+5gu/OxrXtTEbQE1kVg5wAJCO6lhBasnhMeFnWSUpzFcwP6HHVmDZa2rghvxJGVAoL256i
 jiXP+Yn0Ms6X3LO26DsngexxtqnO2LitLD6hmIhQN4El2riU6KPqOC2KAtanCQBNJwnGLw+j1
 /YhBu2R4nDDOyklOsKRY41BbA2MxuCL22XAiH7slOB0vSrg+95d4Tv3sv2tPDh1zQesgm1whL
 HzEscxISshK5YheqKfJN7BdeBFvno8qUtBs+I3ETUz2q1fFFCVbAiz0ITu+jT620nl0OUaQl8
 jSLvMr3Hfc1NuxO9UvdJ1ejKT5skEgITlOlpeajqT6Avg=

Hi

On 2024-04-09, Bitterblue Smith wrote:
> Some (all?) management frames are incorrectly reported to mac80211 as
> decrypted when actually the hardware did not decrypt them. This results
> in speeds 3-5 times lower than expected, 20-30 Mbps instead of 100
> Mbps.
>
> Fix this by checking the encryption type field of the RX descriptor.
> rtw88 does the same thing.
>
> This fix was tested only with rtl8192du, which will use the same code.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v4:
>  - Patch is new in v4.

This patch indeed provides a nice speedup with WPA3/ SAE on my
rtl8192du:

v3 of the patch series:

$ iperf3 -c <remote_server_ipv6>
Connecting to host <remote_server_ipv6>, port 5201
[  5] local <local_client_ipv6> port 45806 connected to <remote_server_ipv=
6> port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  3.75 MBytes  31.4 Mbits/sec    0    241 KBytes
[  5]   1.00-2.00   sec  3.88 MBytes  32.5 Mbits/sec    0    411 KBytes
[  5]   2.00-3.00   sec  3.88 MBytes  32.5 Mbits/sec    0    580 KBytes
[  5]   3.00-4.00   sec  3.88 MBytes  32.5 Mbits/sec    0    720 KBytes
[  5]   4.00-5.00   sec  2.62 MBytes  22.0 Mbits/sec    0    846 KBytes
[  5]   5.00-6.00   sec  2.75 MBytes  23.1 Mbits/sec    0   1004 KBytes
[  5]   6.00-7.00   sec  2.62 MBytes  22.0 Mbits/sec    0   1.14 MBytes
[  5]   7.00-8.00   sec  2.75 MBytes  23.1 Mbits/sec    0   1.27 MBytes
[  5]   8.00-9.00   sec  2.62 MBytes  22.0 Mbits/sec    0   1.41 MBytes
[  5]   9.00-10.00  sec  2.75 MBytes  23.1 Mbits/sec    0   1.55 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  31.5 MBytes  26.4 Mbits/sec    0             send=
er
[  5]   0.00-10.00  sec  30.4 MBytes  25.5 Mbits/sec                  rece=
iver

iperf Done.

$ iperf3 -c <remote_server_ipv6> --reverse
Connecting to host <remote_server_ipv6>, port 5201
Reverse mode, remote host <remote_server_ipv6> is sending
[  5] local <local_client_ipv6> port 57564 connected to <remote_server_ipv=
6> port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  3.25 MBytes  27.2 Mbits/sec
[  5]   1.00-2.00   sec  2.50 MBytes  21.0 Mbits/sec
[  5]   2.00-3.00   sec  2.25 MBytes  18.9 Mbits/sec
[  5]   3.00-4.00   sec  2.25 MBytes  18.9 Mbits/sec
[  5]   4.00-5.00   sec  2.88 MBytes  24.1 Mbits/sec
[  5]   5.00-6.00   sec  2.88 MBytes  24.1 Mbits/sec
[  5]   6.00-7.00   sec  2.38 MBytes  19.9 Mbits/sec
[  5]   7.00-8.00   sec  2.62 MBytes  22.0 Mbits/sec
[  5]   8.00-9.00   sec  3.00 MBytes  25.2 Mbits/sec
[  5]   9.00-10.00  sec  3.00 MBytes  25.2 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.01  sec  29.9 MBytes  25.0 Mbits/sec    0             send=
er
[  5]   0.00-10.00  sec  27.0 MBytes  22.6 Mbits/sec                  rece=
iver

iperf Done.

$ iperf3 -c <remote_server_ipv6> --bidir
Connecting to host <remote_server_ipv6>, port 5201
[  5] local <local_client_ipv6> port 44242 connected to <remote_server_ipv=
6> port 5201
[  7] local <local_client_ipv6> port 44252 connected to <remote_server_ipv=
6> port 5201
[ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
[  5][TX-C]   0.00-1.00   sec  2.00 MBytes  16.8 Mbits/sec    0    109 KBy=
tes
[  7][RX-C]   0.00-1.00   sec  1.00 MBytes  8.38 Mbits/sec
[  5][TX-C]   1.00-2.00   sec  2.75 MBytes  23.1 Mbits/sec    0    212 KBy=
tes
[  7][RX-C]   1.00-2.00   sec   640 KBytes  5.24 Mbits/sec
[  5][TX-C]   2.00-3.00   sec  2.25 MBytes  18.9 Mbits/sec    0    315 KBy=
tes
[  7][RX-C]   2.00-3.00   sec   640 KBytes  5.24 Mbits/sec
[  5][TX-C]   3.00-4.00   sec  3.12 MBytes  26.2 Mbits/sec    0    421 KBy=
tes
[  7][RX-C]   3.00-4.00   sec   512 KBytes  4.19 Mbits/sec
[  5][TX-C]   4.00-5.00   sec  4.00 MBytes  33.6 Mbits/sec    0    551 KBy=
tes
[  7][RX-C]   4.00-5.00   sec   640 KBytes  5.24 Mbits/sec
[  5][TX-C]   5.00-6.00   sec  2.50 MBytes  21.0 Mbits/sec    0    676 KBy=
tes
[  7][RX-C]   5.00-6.00   sec   384 KBytes  3.15 Mbits/sec
[  5][TX-C]   6.00-7.00   sec  2.75 MBytes  23.1 Mbits/sec    0    802 KBy=
tes
[  7][RX-C]   6.00-7.00   sec   384 KBytes  3.15 Mbits/sec
[  5][TX-C]   7.00-8.00   sec  2.62 MBytes  22.0 Mbits/sec    0    925 KBy=
tes
[  7][RX-C]   7.00-8.00   sec   256 KBytes  2.10 Mbits/sec
[  5][TX-C]   8.00-9.00   sec  2.75 MBytes  23.1 Mbits/sec    0   1.05 MBy=
tes
[  7][RX-C]   8.00-9.00   sec   512 KBytes  4.19 Mbits/sec
[  5][TX-C]   9.00-10.00  sec  2.62 MBytes  22.0 Mbits/sec    0   1.19 MBy=
tes
[  7][RX-C]   9.00-10.00  sec   256 KBytes  2.10 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec  27.4 MBytes  23.0 Mbits/sec    0           =
  sender
[  5][TX-C]   0.00-10.00  sec  25.4 MBytes  21.3 Mbits/sec                =
  receiver
[  7][RX-C]   0.00-10.00  sec  6.12 MBytes  5.14 Mbits/sec    1           =
  sender
[  7][RX-C]   0.00-10.00  sec  5.12 MBytes  4.30 Mbits/sec                =
  receiver

iperf Done.

***********************************************************************

v4 of the patch series:

$ iperf3 -c <remote_server_ipv6>
Connecting to host <remote_server_ipv6>, port 5201
[  5] local <local_client_ipv6> port 60528 connected to <remote_server_ipv=
6> port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  13.1 MBytes   110 Mbits/sec    0    445 KBytes
[  5]   1.00-2.00   sec  13.2 MBytes   111 Mbits/sec    0    644 KBytes
[  5]   2.00-3.00   sec  11.9 MBytes  99.6 Mbits/sec    0    768 KBytes
[  5]   3.00-4.00   sec  11.5 MBytes  96.5 Mbits/sec    0    855 KBytes
[  5]   4.00-5.00   sec  12.0 MBytes   101 Mbits/sec    0    945 KBytes
[  5]   5.00-6.00   sec  11.4 MBytes  95.5 Mbits/sec    0    945 KBytes
[  5]   6.00-7.00   sec  11.6 MBytes  97.5 Mbits/sec    0    945 KBytes
[  5]   7.00-8.00   sec  11.2 MBytes  94.4 Mbits/sec    0    945 KBytes
[  5]   8.00-9.00   sec  13.0 MBytes   109 Mbits/sec    0    945 KBytes
[  5]   9.00-10.00  sec  12.0 MBytes   101 Mbits/sec    0   1000 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   121 MBytes   101 Mbits/sec    0             send=
er
[  5]   0.00-10.03  sec   118 MBytes  98.3 Mbits/sec                  rece=
iver

iperf Done.

$ iperf3 -c <remote_server_ipv6> --reverse
Connecting to host <remote_server_ipv6>, port 5201
Reverse mode, remote host <remote_server_ipv6> is sending
[  5] local <local_client_ipv6> port 59562 connected to <remote_server_ipv=
6> port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  16.0 MBytes   134 Mbits/sec
[  5]   1.00-2.00   sec  14.9 MBytes   125 Mbits/sec
[  5]   2.00-3.00   sec  19.2 MBytes   162 Mbits/sec
[  5]   3.00-4.00   sec  14.9 MBytes   125 Mbits/sec
[  5]   4.00-5.00   sec  18.2 MBytes   153 Mbits/sec
[  5]   5.00-6.00   sec  18.9 MBytes   158 Mbits/sec
[  5]   6.00-7.00   sec  17.8 MBytes   149 Mbits/sec
[  5]   7.00-8.00   sec  17.5 MBytes   147 Mbits/sec
[  5]   8.00-9.00   sec  15.1 MBytes   127 Mbits/sec
[  5]   9.00-10.00  sec  14.8 MBytes   124 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.01  sec   171 MBytes   144 Mbits/sec    1             send=
er
[  5]   0.00-10.00  sec   167 MBytes   140 Mbits/sec                  rece=
iver

iperf Done

$ iperf3 -c <remote_server_ipv6> --bidir
Connecting to host <remote_server_ipv6>, port 5201
[  5] local <local_client_ipv6> port 34312 connected to <remote_server_ipv=
6> port 5201
[  7] local <local_client_ipv6> port 34318 connected to <remote_server_ipv=
6> port 5201
[ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
[  5][TX-C]   0.00-1.00   sec  8.25 MBytes  69.1 Mbits/sec    0    395 KBy=
tes
[  7][RX-C]   0.00-1.00   sec  7.00 MBytes  58.7 Mbits/sec
[  5][TX-C]   1.00-2.00   sec  3.38 MBytes  28.3 Mbits/sec    0    420 KBy=
tes
[  7][RX-C]   1.00-2.00   sec  14.6 MBytes   123 Mbits/sec
[  5][TX-C]   2.00-3.00   sec  2.88 MBytes  24.1 Mbits/sec    0    473 KBy=
tes
[  7][RX-C]   2.00-3.00   sec  15.4 MBytes   129 Mbits/sec
[  5][TX-C]   3.00-4.00   sec  1.12 MBytes  9.44 Mbits/sec    0    531 KBy=
tes
[  7][RX-C]   3.00-4.00   sec  10.9 MBytes  91.2 Mbits/sec
[  5][TX-C]   4.00-5.00   sec  1.12 MBytes  9.44 Mbits/sec    0    558 KBy=
tes
[  7][RX-C]   4.00-5.00   sec  10.8 MBytes  90.2 Mbits/sec
[  5][TX-C]   5.00-6.00   sec  1.38 MBytes  11.5 Mbits/sec    0    600 KBy=
tes
[  7][RX-C]   5.00-6.00   sec  3.62 MBytes  30.4 Mbits/sec
[  5][TX-C]   6.00-7.00   sec  2.75 MBytes  23.1 Mbits/sec    0    718 KBy=
tes
[  7][RX-C]   6.00-7.00   sec  12.2 MBytes   103 Mbits/sec
[  5][TX-C]   7.00-8.00   sec  2.75 MBytes  23.1 Mbits/sec    0    853 KBy=
tes
[  7][RX-C]   7.00-8.00   sec  11.1 MBytes  93.3 Mbits/sec
[  5][TX-C]   8.00-9.00   sec  2.75 MBytes  23.1 Mbits/sec    0   1.03 MBy=
tes
[  7][RX-C]   8.00-9.00   sec  13.6 MBytes   114 Mbits/sec
[  5][TX-C]   9.00-10.00  sec  4.12 MBytes  34.6 Mbits/sec    0   1.12 MBy=
tes
[  7][RX-C]   9.00-10.00  sec  16.6 MBytes   139 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec  30.5 MBytes  25.6 Mbits/sec    0           =
  sender
[  5][TX-C]   0.00-10.04  sec  27.1 MBytes  22.7 Mbits/sec                =
  receiver
[  7][RX-C]   0.00-10.00  sec   119 MBytes  99.7 Mbits/sec   10           =
  sender
[  7][RX-C]   0.00-10.04  sec   116 MBytes  96.8 Mbits/sec                =
  receiver

iperf Done.


Regards
	Stefan Lippers-Hollmann


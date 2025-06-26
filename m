Return-Path: <linux-wireless+bounces-24576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01227AEA8F3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B8E642BD9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 21:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACBB25EF81;
	Thu, 26 Jun 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUaXqM/n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAA260576
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750974203; cv=none; b=S5xVgX5e/kMNjzez7ZMtnF0QEhcQ2ZQmDIGhXFQFzPgH132xTJIVdDLlJlyJz3sHrNOcPvWO4StwL0JEVGwJuHHHaVNd/vmlRiS1L3YeVsHG+8eCuLiYFBTkajThSic5WInJ7K048mrRmUwWSucstazne9cyhONdH57S104oAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750974203; c=relaxed/simple;
	bh=pw6xK40rku8NDOLy6KT9yvZzuOy6y0/JZHQPwZMvE8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uByR2Pvsz2H3GhWtbIARlsN3PF1QBsL15oWuTPTELzL36NOIaaVGOyv2DOHFIjYmZum8iUPmUmpHEQj1QHelQK2JrTr8QYcCK3OpDyMJgxi0y2io7bH9t6bhoshlmhFMGP3Tu7C553iFqfgy25lrGXO1UtekVB/STHvWlAbVldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUaXqM/n; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e7949d9753so397613137.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 14:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750974200; x=1751579000; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0fcSToKtDjFu+STsYFG6ZOh3l1V2v+F/ieuz4CccIc=;
        b=QUaXqM/nbc8NPfu9kyRF453zpoGMkT/M3L+R3d4LXGzzsZBXw6l/pe5y7Sw81Ti1rt
         1AaGlijnkdaqypm8bz+9xJoSzSoi7/kwTF0XoZ8GLFTyx2Mdzz6UOffZMkTUJsw7KStl
         z5QVT0DYjK4QO+KvK7H2yGC0ZwdIKyvKYKJffb0pFhVEOfWv1o9brlDbK0fjSvWp0hWO
         UE/9LkEbYNl4C6P1FVYKXs1k9uAq4H+i/gdHK1SO11Qu846RPLPA63vezwMNhh4M/aNc
         nq0SKHk6Y/4FM0D02078f1Btb3lfUsosiu2wPDdNnuCMyWs6OqhXKdSV8dkNDTXCiRUO
         ZMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750974200; x=1751579000;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0fcSToKtDjFu+STsYFG6ZOh3l1V2v+F/ieuz4CccIc=;
        b=sITZ76924iGMmYHmR+WH2Z8FlHGRBFJU6d8mmiyVdY7DfrQFVdaYl1gnVGrdvzz6xu
         fl8sWjTboYnvh3E/SxzwhDdncpLXB+UL/5li48JWzGcCud8Mjri22vUjQb+N5odECJWO
         RIpSv5YAhdzxuvdTxQEwB6IVGsdPqg1bpZYSPMk4cGJnL3FGAUG42diHJT9VsotGnOmr
         4R+Pu01fqq70BIsiT2t8tRUyUhqzmvlpyrl7nv/lEY6l+tdULYpjxaAbkL26DEcUIUBc
         F0+4++VPKVxzp1cEp8XOkES7P6W8Tx+djAWUFyx2Zc+9cooYrXD33DdcXQv1OZYDN4tp
         z9qQ==
X-Gm-Message-State: AOJu0YzJxQRK7RhhimydWttDfiCs5/hZoa8F3ZQ+a+9SxdBbXqOEEV+h
	r+NW+lya1F00HlsPKDQic7ZfOi8pIzRY7ZssiFOEgaEuPS+d1Tv7YGRZRmk8Qmbnch0fbfriJ2C
	5h3GyrEprOffODB5VZrLvWdzPjwfJA4oF0cCy0x4=
X-Gm-Gg: ASbGnctPl1P7D59QHD5o7p+pWyhf0qOHTDv+L+9T73Sz/OHQWRakbmJkyqpPfEiHpfB
	6jHPKO+eiJOgA51td6iwyRSDbyrMznnE/RpNIFpOsSJyFu9A2JxdI1rntW76pArOV53qOafV9vG
	qmcqTN4PER+rt5UM7gLkGwgl4aqAo5lcNujAXLsUBLvqk=
X-Google-Smtp-Source: AGHT+IGsxVOqZCmtpx/NFQZIKOrYWgDwiZDMfF54u8NqFJlYvOcElBJs1TEGQVRaI5rs91k8VM8SR+J3aZWEPI+amys=
X-Received: by 2002:a05:6102:3596:b0:4e5:963b:738a with SMTP id
 ada2fe7eead31-4ee4f8973c7mr1039515137.16.1750974200286; Thu, 26 Jun 2025
 14:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZsTtL_Amydo+N6O5OY9U7U1ZKyQAOnqBQx7kAOwY7amZQ@mail.gmail.com>
In-Reply-To: <CAA85sZsTtL_Amydo+N6O5OY9U7U1ZKyQAOnqBQx7kAOwY7amZQ@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Thu, 26 Jun 2025 23:43:08 +0200
X-Gm-Features: Ac12FXxFIFEwNdDUxrw8KWvZLoDCKR6CSIr3I8ec97VmeizanaEF0KCPWdAEAGw
Message-ID: <CAA85sZv94-GDMKjuQizvwzhVuptdG5UWUus1j4q6NaZ_FuuJAA@mail.gmail.com>
Subject: Re: mt7925 performance issues?
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Some more information that might be helpful

And in reverse mode
WIFI 7 MLO,
Reverse mode, remote host 10.0.0.129 is sending
[  5] local 10.0.0.54 port 42062 connected to 10.0.0.129 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  1.75 MBytes  14.7 Mbits/sec
[  5]   1.00-2.00   sec   128 KBytes  1.05 Mbits/sec
[  5]   2.00-3.00   sec   128 KBytes  1.05 Mbits/sec
[  5]   3.00-4.00   sec   256 KBytes  2.10 Mbits/sec
[  5]   4.00-5.00   sec   128 KBytes  1.05 Mbits/sec
[  5]   5.00-6.00   sec   256 KBytes  2.10 Mbits/sec
[  5]   6.00-7.00   sec   384 KBytes  3.14 Mbits/sec
[  5]   7.00-8.00   sec   896 KBytes  7.34 Mbits/sec
[  5]   8.00-9.00   sec   384 KBytes  3.15 Mbits/sec
[  5]   9.00-10.00  sec  1.00 MBytes  8.38 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.01  sec  5.62 MBytes  4.72 Mbits/sec    1            sender
[  5]   0.00-10.00  sec  5.25 MBytes  4.40 Mbits/sec                  recei=
ver

Wifi 7:
Reverse mode, remote host 10.0.0.129 is sending
[  5] local 10.0.0.53 port 57988 connected to 10.0.0.129 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  41.9 MBytes   351 Mbits/sec
[  5]   1.00-2.00   sec  53.2 MBytes   447 Mbits/sec
[  5]   2.00-3.00   sec  43.9 MBytes   368 Mbits/sec
[  5]   3.00-4.00   sec  55.6 MBytes   467 Mbits/sec
[  5]   4.00-5.00   sec  55.2 MBytes   463 Mbits/sec
[  5]   5.00-6.00   sec  56.2 MBytes   472 Mbits/sec
[  5]   6.00-7.00   sec  52.8 MBytes   443 Mbits/sec
[  5]   7.00-8.00   sec  60.4 MBytes   506 Mbits/sec
[  5]   8.00-9.00   sec  57.5 MBytes   482 Mbits/sec
[  5]   9.00-10.00  sec  47.8 MBytes   401 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.02  sec   541 MBytes   453 Mbits/sec    0            sender
[  5]   0.00-10.00  sec   524 MBytes   440 Mbits/sec                  recei=
ver

Wifi 5:
Reverse mode, remote host 10.0.0.129 is sending
[  5] local 10.0.0.64 port 46632 connected to 10.0.0.129 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  27.4 MBytes   229 Mbits/sec
[  5]   1.00-2.00   sec  27.1 MBytes   228 Mbits/sec
[  5]   2.00-3.00   sec  26.5 MBytes   222 Mbits/sec
[  5]   3.00-4.00   sec  27.9 MBytes   234 Mbits/sec
[  5]   4.00-5.00   sec  26.9 MBytes   225 Mbits/sec
[  5]   5.00-6.00   sec  28.6 MBytes   240 Mbits/sec
[  5]   6.00-7.00   sec  27.4 MBytes   230 Mbits/sec
[  5]   7.00-8.00   sec  23.4 MBytes   196 Mbits/sec
[  5]   8.00-9.00   sec  23.0 MBytes   193 Mbits/sec
[  5]   9.00-10.00  sec  23.9 MBytes   200 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.01  sec   271 MBytes   227 Mbits/sec    5            sender
[  5]   0.00-10.00  sec   262 MBytes   220 Mbits/sec                  recei=
ver

Dmesg, connecting to wifi 5:
[  710.879456] wlp192s0: authenticate with 28:bd:89:bd:85:b5 (local
address=3D06:72:c6:7d:fa:71)
[  710.897099] wlp192s0: send auth to 28:bd:89:bd:85:b5 (try 1/3)
[  710.925295] wlp192s0: authenticate with 28:bd:89:bd:85:b5 (local
address=3D06:72:c6:7d:fa:71)
[  710.937335] wlp192s0: send auth to 28:bd:89:bd:85:b5 (try 1/3)
[  710.939884] wlp192s0: authenticated
[  710.943737] wlp192s0: associate with 28:bd:89:bd:85:b5 (try 1/3)
[  710.959794] wlp192s0: RX AssocResp from 28:bd:89:bd:85:b5
(capab=3D0x1011 status=3D0 aid=3D1)
[  711.003933] wlp192s0: associated
[  711.060218] wlp192s0: Limiting TX power to 20 (20 - 0) dBm as
advertised by 28:bd:89:bd:85:b5

connecting to wifi7 mlo:
[  747.760815] wlp192s0: [link 2] regulatory prevented using AP
config, downgraded
[  747.921523] wlp192s0: authenticate with 84:78:48:1a:7b:89 (local
address=3D82:c7:e0:db:f7:be)
[  748.055412] wlp192s0: send auth to 84:78:48:1a:7b:89 (try 1/3)
[  748.085076] wlp192s0: authenticate with 84:78:48:1a:7b:89 (local
address=3D82:c7:e0:db:f7:be)
[  748.096669] wlp192s0: send auth to 84:78:48:1a:7b:89 (try 1/3)
[  748.099984] wlp192s0: authenticated
[  748.104727] wlp192s0: associate with 84:78:48:1a:7b:89 (try 1/3)
[  748.196697] wlp192s0: RX AssocResp from 84:78:48:1a:7b:89
(capab=3D0x1111 status=3D0 aid=3D16)
[  748.206900] wlp192s0: [link 0] local address 26:09:c7:9c:94:40, AP
link address 8a:78:48:1a:7b:8b
[  748.207025] wlp192s0: [link 1] local address d6:89:a5:d1:0a:da, AP
link address 8e:78:48:1a:7b:8a
[  748.207087] wlp192s0: [link 2] local address 82:c7:e0:db:f7:be, AP
link address 86:78:48:1a:7b:8c (assoc)
[  748.257096] wlp192s0: associated
[  751.623567] wlp192s0: Limiting TX power to 20 (20 - 0) dBm as
advertised by 8a:78:48:1a:7b:8b

Connecting to wifi7:
[  795.799038] wlp192s0: regulatory prevented using AP config, downgraded
[  795.829049] wlp192s0: authenticate with 86:78:48:1a:7b:8d (local
address=3D8e:b3:e9:89:36:2f)
[  795.835430] wlp192s0: send auth to 86:78:48:1a:7b:8d (try 1/3)
[  795.861369] wlp192s0: authenticate with 86:78:48:1a:7b:8d (local
address=3D8e:b3:e9:89:36:2f)
[  795.873062] wlp192s0: send auth to 86:78:48:1a:7b:8d (try 1/3)
[  795.878880] wlp192s0: authenticated
[  795.882712] wlp192s0: associate with 86:78:48:1a:7b:8d (try 1/3)
[  795.910918] wlp192s0: RX AssocResp from 86:78:48:1a:7b:8d
(capab=3D0x1111 status=3D0 aid=3D18)
[  795.950640] wlp192s0: associated


On Thu, Jun 26, 2025 at 11:20=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com=
> wrote:
>
> Hi,
>
> I just got a new laptop with
> c0:00.0 Network controller: MEDIATEK Corp. MT7925 (RZ717) Wi-Fi 7 160MHz
>
> I have read that there is a lot of theories, and ideas about what
> could be going wrong in the driver...
>
> I did some tests, wifi5 is a google wifi next ap, which seems to work
> fine for this card.
>
> Wifi 7 is a unifi wifi7 ap -. max measured with other clients is 931
> mbit - with the same measuring server but with a iwlwifi
> card reporting a txpower of 22dbm
>
> Also interesting that i get 0 at times with wifi 7 and especially with ML=
O
> this is testing with 6.16 HEAD e34a79b96ab9d49ed8b605fee11099cf3efbb428
>
> Any benchmarks/tests i can do to help fix this?
> ----
> Wifi 5
>
>         channel 36 (5180 MHz), width: 80 MHz, center1: 5210 MHz
>         txpower 3.00 dBm
>         multicast TXQ:
>                 qsz-byt qsz-pkt flows   drops   marks   overlmt
> hashcol tx-bytes        tx-packets
>                 0       0       0       0       0       0       0
>  0               0
>
>
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  59.8 MBytes   501 Mbits/sec    2    724 KBytes
> [  5]   1.00-2.00   sec  32.0 MBytes   268 Mbits/sec    0    863 KBytes
> [  5]   2.00-3.00   sec  42.8 MBytes   359 Mbits/sec    0   1.11 MBytes
> [  5]   3.00-4.00   sec  10.6 MBytes  89.1 Mbits/sec    0   1.17 MBytes
> [  5]   4.00-5.00   sec  21.1 MBytes   177 Mbits/sec    0   1.22 MBytes
> [  5]   5.00-6.00   sec  21.4 MBytes   179 Mbits/sec    1   1.24 MBytes
> [  5]   6.00-7.00   sec  21.5 MBytes   180 Mbits/sec    0   1012 KBytes
> [  5]   7.00-8.00   sec  21.4 MBytes   179 Mbits/sec    0   1004 KBytes
> [  5]   8.00-9.00   sec  43.4 MBytes   364 Mbits/sec    0    897 KBytes
> [  5]   9.00-10.00  sec  32.6 MBytes   274 Mbits/sec    2    993 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec   306 MBytes   257 Mbits/sec    5            send=
er
> [  5]   0.00-10.00  sec   284 MBytes   238 Mbits/sec                  rec=
eiver
> ---
>
> Wifi 7
>
>         type managed
>         wiphy 0
>         multicast TXQ:
>                 qsz-byt qsz-pkt flows   drops   marks   overlmt
> hashcol tx-bytes        tx-packets
>                 0       0       0       0       0       0       0
>  0               0
>         MLD with links:
>          - link ID  0 link addr ce:67:53:b2:b1:9d
>            channel 6 (2437 MHz), width: 40 MHz, center1: 2447 MHz
>          - link ID  1 link addr c2:e3:9b:67:2b:67
>          - link ID  2 link addr 1e:5a:37:e5:97:b2
>            channel 37 (6135 MHz), width: 160 MHz, center1: 6185 MHz
>
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  5.50 MBytes  46.1 Mbits/sec    1    160 KBytes
> [  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    0    136 KBytes
> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0    137 KBytes
> [  5]   3.00-4.00   sec  2.00 MBytes  16.8 Mbits/sec    0    110 KBytes
> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0    178 KBytes
> [  5]   5.00-6.00   sec  2.25 MBytes  18.9 Mbits/sec    0   82.0 KBytes
> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   73.5 KBytes
> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   82.0 KBytes
> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   96.2 KBytes
> [  5]   9.00-10.00  sec  2.12 MBytes  17.8 Mbits/sec    0    184 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  11.9 MBytes  9.96 Mbits/sec    1            send=
er
> [  5]   0.00-10.02  sec  5.50 MBytes  4.60 Mbits/sec                  rec=
eiver
> ----
>
>         type managed
>         wiphy 0
>         channel 37 (6135 MHz), width: 160 MHz, center1: 6185 MHz
>         txpower 3.00 dBm
>         multicast TXQ:
>                 qsz-byt qsz-pkt flows   drops   marks   overlmt
> hashcol tx-bytes        tx-packets
>                 0       0       0       0       0       0       0
>  0               0
>
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  25.6 MBytes   215 Mbits/sec    0    461 KBytes
> [  5]   1.00-2.00   sec  13.4 MBytes   112 Mbits/sec    0    413 KBytes
> [  5]   2.00-3.00   sec  26.6 MBytes   223 Mbits/sec    0    390 KBytes
> [  5]   3.00-4.00   sec  13.4 MBytes   112 Mbits/sec    0    413 KBytes
> [  5]   4.00-5.00   sec  20.0 MBytes   168 Mbits/sec    0    515 KBytes
> [  5]   5.00-6.00   sec  20.1 MBytes   169 Mbits/sec    0    390 KBytes
> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    1    444 KBytes
> [  5]   7.00-8.00   sec  13.4 MBytes   112 Mbits/sec    1    348 KBytes
> [  5]   8.00-9.00   sec  20.2 MBytes   170 Mbits/sec    0    379 KBytes
> [  5]   9.00-10.00  sec  20.6 MBytes   173 Mbits/sec    0    373 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec   173 MBytes   145 Mbits/sec    2            send=
er
> [  5]   0.00-10.01  sec   160 MBytes   134 Mbits/sec                  rec=
eiver
> ----


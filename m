Return-Path: <linux-wireless+bounces-4667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54CA87A2E8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 07:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBCB1C212F8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 06:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A756E134A3;
	Wed, 13 Mar 2024 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="Q6/AD0yU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424EAD4E
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710310752; cv=none; b=D8LnxX9lG9qXqXfHE5Ygc95ploeVu+Rdo76DyIS7VooSa9LuA3sB3RzoLi7XrXLJIkqOV99qOvqxAhKhvMKQkCY/kVJ9gI/phOYp3HmYXdQU59qMi22Di+y3oYY0aW3BGC4qPbctGL6uQxnXWPAAbvjUbZX27Vo52DEFk6Yc6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710310752; c=relaxed/simple;
	bh=YruPU41vLrmKuK3NUpb/k5p0fjtHSY0KVvbgFlXJhIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDUwPCYBT4sGd1fO2FqgpYx2+cnIMbWUZixg3EEHHh0+eV003/0uJjmIJuOEA8tVsCNWe22Qmuh8Tk/c10xN/N5PT82OUCgA5xkqXTn+0dUOAKqd1EuA4q1CZaIxvX7m9TIs5Hengr2azWAZDL89tZFVJkQcGakahqngaHlt7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=Q6/AD0yU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710310732; x=1710915532; i=s.l-h@gmx.de;
	bh=YruPU41vLrmKuK3NUpb/k5p0fjtHSY0KVvbgFlXJhIU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=Q6/AD0yUi7zZFy94Ou4BHktSzJ5G8WXpOUEXNU94M2e18QuKPm1bikrEMs8pmgfj
	 PqPOnD/GSwtmRJqv9zjNoYd3SNG7aLUcf25RBdpAAi5eivuSfrdNlO6Cdw/m5w3hs
	 CjASf28b6cAv3vopt6cwufHNEgcH2lI4NJA8p4thUJEkWS0sh0QOJktD93DUCF8OC
	 jWYOvL3Mq9XSBh+M1m7wzRfvmt3xaepuY2ka+Gj/aljNbziKjCmp8q3qrNdsRwwoC
	 PYep7Ch8egOWHmjSqnkpzXJlYQ7kMlf7jNJkhjKTKaWv6Nc0RhZh5/PALxHo9EExI
	 RZX8QxH5agUtD7YwWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.82.155]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1r3prn2Tsl-00kBh9; Wed, 13
 Mar 2024 07:18:52 +0100
Date: Wed, 13 Mar 2024 07:18:50 +0100
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Message-ID: <20240313071850.61a42e4f@mir>
In-Reply-To: <4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	<20240313064917.527110c4@mir>
	<4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IIlBu7bJjJbY2DyY3rDHXti1K1bfHkcV/on8oDuQH+76MS+bASt
 yw0m7glaD0exISYUW5M8H7ClvMDndAULR+IKjc3kPD15r8Cq2t5M/b1eI3n/hGIvwiTYFGv
 5RmKxuc4l+7Q8/0nKdBnUyDxagbLmSckPW3FOH6i6nvgJHN9G90Y5N/HMJyjRsiuBjZy4Jz
 dZQw6s9OFs/CuhDGnzrKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oseFGtEJQXw=;W5iJDXjOFIgqHFYiwnAdJ6IQcdi
 NGoWXNIQsAHV3U/ZuVM16nhUwC/lghz/JEGlpqbsn6XpAckqeXSZFjcggSmzd7ZBfnwr0YTSd
 p7IkgqoUSunW3DfQzLQ2zmulB5yvqJt5C809VWeqOb+TVH1Jc2q5iHIQPDjlXkcRi+b57mZ/t
 qcl8QkDgLqDluA9AdaoQzlRuetyIOpGjwXtj0McVooMer4PrH0Ao47073oHHWWtg6RslWPJWe
 TaLTtUo/04GGFTucoAdUCr3KRFYLSOirOw9yHQrBMpyv4dTFrrIen+C8WADte1iciTLqGHsee
 MDmR+TUdgYRs3D8gEyddOs5+mz5Nf5UoPEfVJt6LYKFY5ovdu4BCGKaDlqKG7QYd9mojDtQAX
 xcCGheIs800M2TDGu/m06FhCs4iKgVZUiHm8GB+oUDLcTZ+2MKvh9nekZUergLhj4bgLso5/6
 /uzCxOdMuPlqOPtY1kVNqLvdjwrQqUJ0PZtcmWdvQybmuKCrM7SaQzXCwX6NYJZWPc1OSr4Ey
 xWW/MjnelQ6wYjSX5rk8603ydRreYcAi2hUZEJLwmNdjeUPPvqZ6/MfB/kL4YytEB0/Y1q6hI
 CnO4hyVXo77gI8g4ayWXg+lyPUB7/U6LO3sn/j2lvnVsrBYHrdZPh+VvXjRRsFEsC5ltbYXwk
 dbnFE/fmdmdKA4uceDnNaXjyw/dXzm/A4seKHhieyAK+7JY6GgTUutm2wPLqTvTQ230MTr2Xn
 Vh/0dagHoPsJUI8Dw7Tu0EZP04WuBql+vn7DP6VRvnLLYkfr+ALoZfbMt/cC6/FQvJfmfGchu
 xrRh/W13VHo5rZV7WyuVYXpu6DNpOpKijJtTuiqriQTmI=

Hi

On 2024-03-13, Ping-Ke Shih wrote:
> On Wed, 2024-03-13 at 06:49 +0100, Stefan Lippers-Hollmann wrote:
> > On 2024-03-13, Bitterblue Smith wrote:
> > > Create the new module rtl8192d-common and move some code into it fro=
m
> > > rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driv=
er
> > > (USB) can share some of the code.
> > [...]
> > > Tested only with RTL8192DU.
> > >
> > > Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> >
> > Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
>
> Thanks for the report. Could I know the throughput performance in your s=
ide?
> Just for a record.

The performance is okay - the driver has been working reliably all day
long (WPA2SAE and WPA2PSK/ CCMP, 2.4 GHz and 5 GHz, against an
ipq8071a+qcn5024+qcn5054 AP running recent OpenWrt).

# wpa_cli -i wlxXXXXXXXXXXXX status
bssid=3DXX:XX:XX:XX:XX:XX
freq=3D5260
ssid=3DXXX
id=3D0
id_str=3DXXX
mode=3Dstation
wifi_generation=3D4
pairwise_cipher=3DCCMP
group_cipher=3DCCMP
key_mgmt=3DWPA2-PSK
wpa_state=3DCOMPLETED
p2p_device_address=3DXX:XX:XX:XX:XX:XX
address=3DXX:XX:XX:XX:XX:XX
uuid=3DXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX

$ iperf3 -c 2a00:XXXX:XXXX:XXXX::XXXX:401
Connecting to host 2a00:XXXX:XXXX:XXXX::XXXX:401, port 5201
[  5] local 2a00:XXXX:XXXX:XXXX::XXXX:c046 port 33696 connected to 2a00:XX=
XX:XXXX:XXXX::XXXX:401 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  12.2 MBytes   103 Mbits/sec    0    442 KBytes
[  5]   1.00-2.00   sec  10.6 MBytes  89.1 Mbits/sec    0    498 KBytes
[  5]   2.00-3.00   sec  11.6 MBytes  97.5 Mbits/sec    0    582 KBytes
[  5]   3.00-4.00   sec  11.1 MBytes  93.3 Mbits/sec    0    587 KBytes
[  5]   4.00-5.00   sec  12.0 MBytes   101 Mbits/sec    0    660 KBytes
[  5]   5.00-6.00   sec  11.5 MBytes  96.5 Mbits/sec    0    694 KBytes
[  5]   6.00-7.00   sec  11.1 MBytes  93.3 Mbits/sec    0    694 KBytes
[  5]   7.00-8.00   sec  12.9 MBytes   108 Mbits/sec    0    694 KBytes
[  5]   8.00-9.00   sec  12.4 MBytes   104 Mbits/sec    0    694 KBytes
[  5]   9.00-10.00  sec  12.8 MBytes   107 Mbits/sec    0    694 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   118 MBytes  99.2 Mbits/sec    0             send=
er
[  5]   0.00-10.02  sec   115 MBytes  96.1 Mbits/sec                  rece=
iver

iperf Done.

$ iperf3 -c 2a00:XXXX:XXXX:XXXX::XXXX:401 --reverse
Connecting to host 2a00:XXXX:XXXX:XXXX::XXXX:401, port 5201
Reverse mode, remote host 2a00:XXXX:XXXX:XXXX::XXXX:401 is sending
[  5] local 2a00:XXXX:XXXX:XXXX::XXXX:c046 port 57880 connected to 2a00:XX=
XX:XXXX:XXXX::XXXX:401 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  18.4 MBytes   154 Mbits/sec
[  5]   1.00-2.00   sec  20.5 MBytes   172 Mbits/sec
[  5]   2.00-3.00   sec  20.4 MBytes   171 Mbits/sec
[  5]   3.00-4.00   sec  19.9 MBytes   167 Mbits/sec
[  5]   4.00-5.00   sec  20.2 MBytes   170 Mbits/sec
[  5]   5.00-6.00   sec  21.1 MBytes   177 Mbits/sec
[  5]   6.00-7.00   sec  21.1 MBytes   177 Mbits/sec
[  5]   7.00-8.00   sec  20.9 MBytes   175 Mbits/sec
[  5]   8.00-9.00   sec  20.8 MBytes   174 Mbits/sec
[  5]   9.00-10.00  sec  20.9 MBytes   175 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.03  sec   207 MBytes   173 Mbits/sec    0             send=
er
[  5]   0.00-10.00  sec   204 MBytes   171 Mbits/sec                  rece=
iver

iperf Done.

$ iperf3 -c 2a00:XXXX:XXXX:XXXX::XXXX:401 --bidir
Connecting to host 2a00:XXXX:XXXX:XXXX::XXXX:401, port 5201
[  5] local 2a00:XXXX:XXXX:XXXX::XXXX:c046 port 44960 connected to 2a00:XX=
XX:XXXX:XXXX::XXXX:401 port 5201
[  7] local 2a00:XXXX:XXXX:XXXX::XXXX:c046 port 44966 connected to 2a00:XX=
XX:XXXX:XXXX::XXXX:401 port 5201
[ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
[  5][TX-C]   0.00-1.00   sec  8.25 MBytes  69.2 Mbits/sec    0    357 KBy=
tes
[  7][RX-C]   0.00-1.00   sec  10.9 MBytes  91.2 Mbits/sec
[  5][TX-C]   1.00-2.00   sec  5.00 MBytes  41.9 Mbits/sec    0    547 KBy=
tes
[  7][RX-C]   1.00-2.00   sec  15.2 MBytes   128 Mbits/sec
[  5][TX-C]   2.00-3.00   sec  2.50 MBytes  21.0 Mbits/sec    0    628 KBy=
tes
[  7][RX-C]   2.00-3.00   sec  16.9 MBytes   142 Mbits/sec
[  5][TX-C]   3.00-4.00   sec  2.62 MBytes  22.0 Mbits/sec    0    674 KBy=
tes
[  7][RX-C]   3.00-4.00   sec  17.6 MBytes   148 Mbits/sec
[  5][TX-C]   4.00-5.00   sec  2.88 MBytes  24.1 Mbits/sec    0    764 KBy=
tes
[  7][RX-C]   4.00-5.00   sec  15.0 MBytes   126 Mbits/sec
[  5][TX-C]   5.00-6.00   sec  1.38 MBytes  11.5 Mbits/sec    0    848 KBy=
tes
[  7][RX-C]   5.00-6.00   sec  11.2 MBytes  94.4 Mbits/sec
[  5][TX-C]   6.00-7.00   sec  1.50 MBytes  12.6 Mbits/sec    0    957 KBy=
tes
[  7][RX-C]   6.00-7.00   sec  11.9 MBytes  99.6 Mbits/sec
[  5][TX-C]   7.00-8.00   sec  4.00 MBytes  33.6 Mbits/sec    0   1.09 MBy=
tes
[  7][RX-C]   7.00-8.00   sec  11.9 MBytes  99.6 Mbits/sec
[  5][TX-C]   8.00-9.00   sec  1.75 MBytes  14.7 Mbits/sec    0   1.20 MBy=
tes
[  7][RX-C]   8.00-9.00   sec  9.75 MBytes  81.8 Mbits/sec
[  5][TX-C]   9.00-10.00  sec  2.75 MBytes  23.1 Mbits/sec    0   1.31 MBy=
tes
[  7][RX-C]   9.00-10.00  sec  10.6 MBytes  89.1 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec  32.6 MBytes  27.4 Mbits/sec    0           =
  sender
[  5][TX-C]   0.00-10.04  sec  29.4 MBytes  24.5 Mbits/sec                =
  receiver
[  7][RX-C]   0.00-10.00  sec   134 MBytes   113 Mbits/sec    0           =
  sender
[  7][RX-C]   0.00-10.04  sec   131 MBytes   109 Mbits/sec                =
  receiver

iperf Done.

$ /sbin/iw dev wlxXXXXXXXXXXXX station dump
Station XX:XX:XX:XX:XX:XX (on wlxXXXXXXXXXXXX)
        inactive time:  0 ms
        rx bytes:       359255660
        rx packets:     241259
        tx bytes:       168308006
        tx packets:     190031
        tx retries:     0
        tx failed:      0
        beacon loss:    0
        rx drop misc:   4
        signal:         -22 dBm
        signal avg:     -22 dBm
        tx bitrate:     300.0 MBit/s MCS 15 40MHz short GI
        tx duration:    0 us
        rx bitrate:     270.0 MBit/s MCS 15 40MHz
        rx duration:    0 us
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    1
        beacon interval:100
        short slot time:yes
        connected time: 116 seconds
        associated at [boottime]:       8521.829s
        associated at:  1710309820764 ms
        current time:   1710309936171 ms

$ /sbin/iw phy phy1 info
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
                        * 5260.0 MHz [52] (20.0 dBm) (no IR, radar detecti=
on)
                        * 5280.0 MHz [56] (20.0 dBm) (no IR, radar detecti=
on)
                        * 5300.0 MHz [60] (20.0 dBm) (no IR, radar detecti=
on)
                        * 5320.0 MHz [64] (20.0 dBm) (no IR, radar detecti=
on)
                        * 5500.0 MHz [100] (26.0 dBm) (no IR, radar detect=
ion)
                        * 5520.0 MHz [104] (26.0 dBm) (no IR, radar detect=
ion)
                        * 5540.0 MHz [108] (26.0 dBm) (no IR, radar detect=
ion)
                        * 5560.0 MHz [112] (26.0 dBm) (no IR, radar detect=
ion)
                        * 5580.0 MHz [116] (26.0 dBm) (no IR, radar detect=
ion)
                        * 5600.0 MHz [120] (26.0 dBm) (no IR, radar detect=
ion)
                        * 5620.0 MHz [124] (26.0 dBm) (no IR, radar detect=
ion)
                        * 5640.0 MHz [128] (26.0 dBm) (no IR, radar detect=
ion)
                        * 5660.0 MHz [132] (26.0 dBm) (no IR, radar detect=
ion)
                        * 5680.0 MHz [136] (26.0 dBm) (no IR, radar detect=
ion)
                        * 5700.0 MHz [140] (26.0 dBm) (no IR, radar detect=
ion)
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
                 * IBSS: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90=
 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0=
x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0=
xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * AP/VLAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0=
x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * mesh point: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x8=
0 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x8=
0 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x=
90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x8=
0 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
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
                * [ SCAN_MIN_PREQ_CONTENT ]: use probe request with only r=
ate IEs in scans
                * [ CONTROL_PORT_NO_PREAUTH ]: disable pre-auth over nl802=
11 control port support
                * [ DEL_IBSS_STA ]: deletion of IBSS station support
                * [ SCAN_FREQ_KHZ ]: scan on kHz frequency support
                * [ CONTROL_PORT_OVER_NL80211_TX_STATUS ]: tx status for n=
l80211 control port support
                * [ POWERED_ADDR_CHANGE ]: can change MAC address while up

> > Using the firmware from https://github.com/lwfinger/rtl8192du/,
> > it would be great if someone could publish the necessary firmware
> > to linux-firmware.
>
> I can do that after this patchset get merged.

Great :)

Regards
	Stefan Lippers-Hollmann


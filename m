Return-Path: <linux-wireless+bounces-23508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F01BFAC9735
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 23:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A451883039
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 21:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912B283FD8;
	Fri, 30 May 2025 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd33wHBV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89A28315A
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640877; cv=none; b=NiSgsj/n4SkjaIKyFJBUmXwkeY+XOAbB2RKVoOrKFJFTm7zEx7YeWg9N38IeraHij9kDpb7xHfNUmZ/Fhs94R0PHN2V99sdXxERY0H0KQ+cIYD2ByREUhAxOEBlLskRcpPc8LXopYgFJANMm9liSYVvn5jv14hHbQwv/IuSEqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640877; c=relaxed/simple;
	bh=fQ+v87RjdjjZ/dbAMj34Cne2wxpgPtHzRMd4oBjMlzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYrjAVem1Mzu3L6ZYN+Uij5R+8Lcz5/hjYFUc3Oe8xvo9VpUIiKTHaDIS83dEZFsv4aCCZ4ld+u1na5q8IyEREa3ma0Kz6zdijACQrjPDWenbGbRrZoQWRyctJD8WGMeBLNI3ik7fzGFurj9HN5pWEs2elxgLW1+34FcYi3nrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd33wHBV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a35c894313so2183146f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748640873; x=1749245673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHy++R1rn6WMCIOn/bL09U319YcQdKCIPa7l/Bzad8k=;
        b=Jd33wHBVvrOPPEefYpE0sxQHIR2LjJyvW7lBWBpfBOTd6mzgK3BSTFMlIKtwuFckrA
         N28skGKTSLDitkRrps09RPenovMTnCPltPuWt6TVEbnEXyvB+gMNkleIvgH1anI5aE87
         IttmzGJhU7UMS0rSVgFsK6+RvkQRFJ2tywmveU2EntDNeMCpfkRT2wGFuzUZUqzICx3+
         Pfja2dWOzt08+xnh/0MQgN8g2Ii2F6QgIekh0zuiH1PFYLitYQJCZu5JSFUROlnyphkZ
         0e8cFNSWBBwHtIg1ARzzj1OTzpYijTomRDCN4eXBT5p/ud1x79m71ctfazhA4MCHGKes
         VoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640873; x=1749245673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHy++R1rn6WMCIOn/bL09U319YcQdKCIPa7l/Bzad8k=;
        b=LkU+OzIS+v9gA7UZafk0Ouca5VvPHVtrjdh8SajEbevhJEiQ26gspomsl8DFWBdlGp
         Phd4twMhumJpbreNc8+YFXPQfTTLJUmnV0WI2WinM7Rd5CqEuz6AQ6F+/zSFFu3oOfrx
         JTy75+xHxU4HWeH8O8rPl0Sn3M7y3sQQ3XsYhjtyij5F+oxR6Q2tFf7VGqEeoW2Gi8cQ
         k1qORjihKrM0kAraTFEtsHTRLiF1X4tu78gJKH5T0uOC0R/Z+l5HSPjWsrY906zZTPT6
         2bmww5k8BPOiNv3G9yR6ix55ZRqSdEGpNHtii159HhSWHvVFhSY9iU9UQXDTe/sUjc4n
         aviw==
X-Forwarded-Encrypted: i=1; AJvYcCUZqoXXaAZPbfRwPILZIZmEk4dxFoHfL8EUBwZeB+m8WSMCEhsHW3pm/FTcXv/sy8fugyDF1L+UfLolBReAug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyja/J9xMSVMwSYSPDVTd/ASVAxfzIx0/GOp1VYeH8/P/YWJRLa
	r4+WjP0706APBS8RjTHcezSdqxhJQW5qdBlVXdkEfZ1YgF8zoJ4dzaGUHc43NhXPidZXZ1FJaay
	m+V/rhIGZiG2M23ZIWktcChBI5KPLZ/ZtMR14
X-Gm-Gg: ASbGncvwDZkAT6uLZhXBMM9YEc9jbs0b4nBOWC0u1tNmgDk+i/zglXC603deSwpvPDG
	mSivB+ci5QAg8E7vT2TPAoVv73SMBdGN2LYjsoxKrixu9fND+iX6kcqQ8xyHUcRzpkTYHL150ym
	vNuFYPnalwg8j6+UUpCggT2s1ushON1l0=
X-Google-Smtp-Source: AGHT+IGgZtGnrU+wXeZezNOGJ9W3i3BZkgV3eIu+RUngPqLnv7SuEbTUrmG2gRLy1hTi5sxkh44N5+7W72d3DoYeVqI=
X-Received: by 2002:a05:6000:2313:b0:3a4:efc0:c90b with SMTP id
 ffacd0b85a97d-3a4fe17961cmr25347f8f.15.1748640872221; Fri, 30 May 2025
 14:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <0933d8d6-5b72-40df-95f8-69f6fbbdfde7@oss.qualcomm.com> <CAMb39_nHO_TbHPQawdLVY8nt3yt4wDuEHyEuzMa-p5Ab1n94sA@mail.gmail.com>
 <CAMb39_nQ-uyKAqCz1HEUDt5qjszbhzf3oikVcvzHcVwt4_qt=A@mail.gmail.com>
 <CAMb39_n89hBL_GvfXb7Jw9h5-h-+Qg-3GyqvpahL7MT5ewpvJw@mail.gmail.com>
 <CAMb39_=YPYg0q7Lf0sMgTx5QwKOqcyJrZR7kTspyXEDa6qz9Bw@mail.gmail.com>
 <e9da4ad5-52cb-416d-991a-259140469e2c@oss.qualcomm.com> <87774003-d0a5-4408-b710-20bd3c194cec@quicinc.com>
 <CAMb39_ntK9Zv3pOuMSza5hRfs_KZBhya=GAPnpBWjN2wZDst9w@mail.gmail.com>
 <c7c0dfd4-bda9-4a63-84f9-a47b716c6ddd@quicinc.com> <CAMb39_k6bkaU9ED+iUVFT33e3S1UU+U49bYpp-qyFW-wjSd4RQ@mail.gmail.com>
 <d432fd29-316a-4ba8-aefa-eb4c22482e34@quicinc.com> <CAMb39_mSN_HQ+78NVzVWSDaY4c2Lv1Xb1prnmV177Fn9H6WEVw@mail.gmail.com>
 <be026084-0906-4609-9e00-8b1fa6808eb3@quicinc.com> <CAMb39_=RHns4CtjFa960ck57oXn7nSJcR1Jk=SHhmU0o+iyNew@mail.gmail.com>
 <b9f1d650-336b-4af6-a17f-e9e8a76e6200@oss.qualcomm.com>
In-Reply-To: <b9f1d650-336b-4af6-a17f-e9e8a76e6200@oss.qualcomm.com>
From: Walt Holman <waltholman09@gmail.com>
Date: Fri, 30 May 2025 16:34:21 -0500
X-Gm-Features: AX0GCFvhJ5lgV-GlxF_k5vvBFCC_V4hJs0RmGyjyybuOUj2QHxyFOLS9LtdwIUA
Message-ID: <CAMb39_n+CRgty6CDv__0a0QBgx7qG62QX7a0pTJdYLJb7-vZJg@mail.gmail.com>
Subject: Re: ath12k: No 6GHz Wireless found
To: Kang Yang <kang.yang@oss.qualcomm.com>
Cc: Kang Yang <quic_kangyang@quicinc.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 3:24=E2=80=AFAM Kang Yang <kang.yang@oss.qualcomm.c=
om> wrote:
>
>
> On 5/28/2025 5:03 AM, Walt Holman wrote:
> > On Thu, May 22, 2025 at 9:12=E2=80=AFPM Kang Yang <quic_kangyang@quicin=
c.com> wrote:
> >>
> >>
> >> On 5/23/2025 1:48 AM, Walt Holman wrote:
> >>> On Wed, May 21, 2025 at 1:07=E2=80=AFAM Kang Yang <quic_kangyang@quic=
inc.com> wrote:
> >>>>
> >>>>
> >>>> On 5/21/2025 1:05 PM, Walt Holman wrote:
> >>>>> On Thu, May 15, 2025 at 10:06=E2=80=AFPM Kang Yang <quic_kangyang@q=
uicinc.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 5/16/2025 1:47 AM, Walt Holman wrote:
> >>>>>>> On Thu, May 15, 2025 at 4:22=E2=80=AFAM Kang Yang <quic_kangyang@=
quicinc.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 5/15/2025 4:12 PM, Kang Yang wrote:
> >>>>>>>>> On 4/20/2025 11:18 PM, Walt Holman wrote:
> >>>>>>>>>> On Fri, Apr 18, 2025 at 4:18=E2=80=AFPM Walt Holman <waltholma=
n09@gmail.com>
> >>>>>>>>>> wrote:
> >>>>>>>>>>> On Tue, Apr 15, 2025 at 4:23=E2=80=AFPM Walt Holman <waltholm=
an09@gmail.com>
> >>>>>>>>>>> wrote:
> >>>>>>>>>>>> On Thu, Apr 10, 2025 at 10:32=E2=80=AFAM Walt Holman
> >>>>>>>>>>>> <waltholman09@gmail.com> wrote:
> >>>>>>>>>>>>> On Thu, Apr 10, 2025 at 3:26=E2=80=AFAM Kang Yang
> >>>>>>>>>>>>> <kang.yang@oss.qualcomm.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 4/10/2025 3:37 AM, Walt Holman wrote:
> >>>>>>>>>>>>>>> On Tue, Apr 8, 2025 at 4:17=E2=80=AFAM Kang Yang
> >>>>>>>>>>>>>>> <quic_kangyang@quicinc.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 4/8/2025 1:49 AM, Walt Holman wrote:
> >>>>>>>>>>>>>>>>> Attached is a small packet capture where I did an 'iw w=
lp99s0
> >>>>>>>>>>>>>>>>> scan'
> >>>>>>>>>>>>>>>>> and also deactivated and reactivated wireless while the=
 scan was
> >>>>>>>>>>>>>>>>> ongoing. Hopefully there's something interesting for yo=
u in there.
> >>>>>>>>>>>>>>>>> Also, I've take 3 screenshots showing the configs of th=
e
> >>>>>>>>>>>>>>>>> wireless AP
> >>>>>>>>>>>>>>>>> for the 6ghz network. The first screen is just the defi=
nition
> >>>>>>>>>>>>>>>>> of the
> >>>>>>>>>>>>>>>>> network. No advanced settings are used. The 2nd screen =
shows the
> >>>>>>>>>>>>>>>>> channels and radio enabled. The 3rd screen has the adva=
nced
> >>>>>>>>>>>>>>>>> (professional) settings for the network. I believe I ch=
anged
> >>>>>>>>>>>>>>>>> 'Agile
> >>>>>>>>>>>>>>>>> Multiband' to enabled, but other settings are their def=
aults. Hope
> >>>>>>>>>>>>>>>>> some of this helps. Let me know if you need anything el=
se. Thanks,
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Your packets are Ethernet packets. I need wireless packe=
ts.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Not sure if you know how to add a seperate monitor inter=
face to
> >>>>>>>>>>>>>>>> capture
> >>>>>>>>>>>>>>>> 6 G channels' packet on your AP(you can google for speci=
fic
> >>>>>>>>>>>>>>>> command).
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Also, please capture firmware log:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> 1. sudo apt install trace-cmd
> >>>>>>>>>>>>>>>> 2. sudo trace-cmd record -e ath12k_wmi_diag
> >>>>>>>>>>>>>>>> 3. run test
> >>>>>>>>>>>>>>>> 4. "ctrl c" to stop recording:
> >>>>>>>>>>>>>>>> Hit Ctrl^C to stop recording
> >>>>>>>>>>>>>>>> ^CCPU0 data recorded at offset=3D0xdf5000
> >>>>>>>>>>>>>>>>            2605056 bytes in size
> >>>>>>>>>>>>>>>> Then share the trace.dat to us.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> So you need to:
> >>>>>>>>>>>>>>>> 1. try to capture wireless packets.
> >>>>>>>>>>>>>>>> 2. capture firmware log(trade.data).
> >>>>>>>>>>>>>>>> 3. save kernel/wpa_supplicant/iw logs.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> -Walt
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> On Sun, Apr 6, 2025 at 8:58=E2=80=AFPM Kang Yang
> >>>>>>>>>>>>>>>>> <quic_kangyang@quicinc.com> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> On 4/4/2025 12:04 AM, Walt Holman wrote:
> >>>>>>>>>>>>>>>>>>> On Thu, Apr 3, 2025 at 3:20=E2=80=AFAM Kang Yang
> >>>>>>>>>>>>>>>>>>> <quic_kangyang@quicinc.com> wrote:
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> On 4/3/2025 1:48 AM, Walt Holman wrote:
> >>>>>>>>>>>>>>>>>>>>> On Tue, Apr 1, 2025 at 9:48=E2=80=AFPM Kang Yang
> >>>>>>>>>>>>>>>>>>>>> <quic_kangyang@quicinc.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>> Test on 6.14.0-rc5-wt-ath+, with the firmware you =
used.
> >>>>>>>>>>>>>>>>>>>>>> I can get 6 GHz AP and connect to it.
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> ath12k_pci 0000:03:00.0: fw_version 0x100301e1
> >>>>>>>>>>>>>>>>>>>>>> fw_build_timestamp
> >>>>>>>>>>>>>>>>>>>>>> 2023-12-06 04:05 fw_build_id
> >>>>>>>>>>>>>>>>>>>>>> QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-
> >>>>>>>>>>>>>>>>>>>>>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> yk@yk-Mayan:~$ sudo iw wls1 scan | tee iw_scan.log=
:
> >>>>>>>>>>>>>>>>>>>>>> BSS 62:03:7f:12:64:64(on wls1) -- associated
> >>>>>>>>>>>>>>>>>>>>>>                   TSF: 606308271476 usec (7d, 00:2=
5:08)
> >>>>>>>>>>>>>>>>>>>>>>                   freq: 6275
> >>>>>>>>>>>>>>>>>>>>>>                   beacon interval: 100 TUs
> >>>>>>>>>>>>>>>>>>>>>>                   capability: ESS Privacy Spectrum=
Mgmt
> >>>>>>>>>>>>>>>>>>>>>> ShortSlotTime (0x0511)
> >>>>>>>>>>>>>>>>>>>>>>                   signal: -17.00 dBm
> >>>>>>>>>>>>>>>>>>>>>>                   last seen: 52 ms ago
> >>>>>>>>>>>>>>>>>>>>>>                   Information elements from Probe =
Response frame:
> >>>>>>>>>>>>>>>>>>>>>>                   SSID: MLO-KANG-6G
> >>>>>>>>>>>>>>>>>>>>>> and other 6 GHz APs:
> >>>>>>>>>>>>>>>>>>>>>>                  SSID: 6G-gxia
> >>>>>>>>>>>>>>>>>>>>>>                  SSID: NETGEAR97-6G
> >>>>>>>>>>>>>>>>>>>>>>                  =E2=80=A6=E2=80=A6
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> kernel log:
> >>>>>>>>>>>>>>>>>>>>>> [88158.033218] wls1: Inserted STA 62:03:7f:12:64:6=
4
> >>>>>>>>>>>>>>>>>>>>>> [88158.033232] wls1: authenticate with 62:03:7f:12=
:64:64
> >>>>>>>>>>>>>>>>>>>>>> (local
> >>>>>>>>>>>>>>>>>>>>>> address=3D00:03:7f:37:12:54)
> >>>>>>>>>>>>>>>>>>>>>> [88158.033242] wls1: send auth to 62:03:7f:12:64:6=
4 (try 1/3)
> >>>>>>>>>>>>>>>>>>>>>> [88158.041895] wls1: authenticated
> >>>>>>>>>>>>>>>>>>>>>> [88158.041914] wls1: moving STA 62:03:7f:12:64:64 =
to state 2
> >>>>>>>>>>>>>>>>>>>>>> [88158.044291] wls1: determined local STA to be EH=
T, BW
> >>>>>>>>>>>>>>>>>>>>>> limited to 320 MHz
> >>>>>>>>>>>>>>>>>>>>>> [88158.045719] wls1: associate with 62:03:7f:12:64=
:64 (try
> >>>>>>>>>>>>>>>>>>>>>> 1/3)
> >>>>>>>>>>>>>>>>>>>>>> [88158.067045] wls1: RX AssocResp from 62:03:7f:12=
:64:64
> >>>>>>>>>>>>>>>>>>>>>> (capab=3D0x511
> >>>>>>>>>>>>>>>>>>>>>> status=3D0 aid=3D4)
> >>>>>>>>>>>>>>>>>>>>>> [88158.089090] wls1: associated
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> I can even connect to it by Ubuntu GUI.
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> Can you update to 6.14.0-rc5-wt-ath+ and have a re=
try?
> >>>>>>>>>>>>>>>>>>>>>> Also please make
> >>>>>>>>>>>>>>>>>>>>>> sure that your wpa_supplicant/iw support 6 GHz(or =
directly
> >>>>>>>>>>>>>>>>>>>>>> update to the
> >>>>>>>>>>>>>>>>>>>>>> latest version).
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> If you still cannot find 6 GHz AP, you can set deb=
ug_mask
> >>>>>>>>>>>>>>>>>>>>>> to 0xffffffff
> >>>>>>>>>>>>>>>>>>>>>> to get ath12k logs. Then give it to us.
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>> -Walt
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> OK, I retested with the wt-ath 033125 tagged build.=
 This
> >>>>>>>>>>>>>>>>>>>>> included the
> >>>>>>>>>>>>>>>>>>>>> patch the Jeff suggested I try, but the rest of the=
 tree
> >>>>>>>>>>>>>>>>>>>>> was clean.
> >>>>>>>>>>>>>>>>>>>>> Still no 6ghz Wifi. I'm attaching a log file of the=
 boot
> >>>>>>>>>>>>>>>>>>>>> and first few
> >>>>>>>>>>>>>>>>>>>>> seconds with the debug mask turned on. I noticed th=
at if I
> >>>>>>>>>>>>>>>>>>>>> rmmod the
> >>>>>>>>>>>>>>>>>>>>> module and then modprobe it, it complains about not=
 finding
> >>>>>>>>>>>>>>>>>>>>> firmware-2.bin, however, I thought that was only fo=
r the
> >>>>>>>>>>>>>>>>>>>>> qcn based
> >>>>>>>>>>>>>>>>>>>>> chip? The HW info from dmesg looks like this:
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> I cannot find this tag...
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>          From the log, the 6 GHz channel should work=
. When scan
> >>>>>>>>>>>>>>>>>>>> is triggered, FW
> >>>>>>>>>>>>>>>>>>>> shall send probe req on these channels. If AP send p=
robe
> >>>>>>>>>>>>>>>>>>>> resp, station
> >>>>>>>>>>>>>>>>>>>> shall find the AP.
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> [    6.070282] ath12k_pci 0000:63:00.0: BAR 0 [mem
> >>>>>>>>>>>>>>>>>>>>> 0xdd800000-0xdd9fffff 64bit]: assigned
> >>>>>>>>>>>>>>>>>>>>> [    6.070310] ath12k_pci 0000:63:00.0: enabling de=
vice
> >>>>>>>>>>>>>>>>>>>>> (0000 -> 0002)
> >>>>>>>>>>>>>>>>>>>>> [    6.071249] ath12k_pci 0000:63:00.0: MSI vectors=
: 16
> >>>>>>>>>>>>>>>>>>>>> [    6.071254] ath12k_pci 0000:63:00.0: Hardware na=
me:
> >>>>>>>>>>>>>>>>>>>>> wcn7850 hw2.0
> >>>>>>>>>>>>>>>>>>>>> [    6.596331] ath12k_pci 0000:63:00.0: qmi dma all=
ocation
> >>>>>>>>>>>>>>>>>>>>> failed
> >>>>>>>>>>>>>>>>>>>>> (7077888 B type 1), will try later with sma
> >>>>>>>>>>>>>>>>>>>>> ll size
> >>>>>>>>>>>>>>>>>>>>> [    6.604041] ath12k_pci 0000:63:00.0: chip_id 0x2
> >>>>>>>>>>>>>>>>>>>>> chip_family 0x4
> >>>>>>>>>>>>>>>>>>>>> board_id 0xff soc_id 0x40170200
> >>>>>>>>>>>>>>>>>>>>> [    6.604044] ath12k_pci 0000:63:00.0: fw_version =
0x100301e1
> >>>>>>>>>>>>>>>>>>>>> fw_build_timestamp 2023-12-06 04:05 fw_build_id
> >>>>>>>>>>>>>>>>>>>>> QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-
> >>>>>>>>>>>>>>>>>>>>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> Also, I noticed when looking through the debug logs=
 there
> >>>>>>>>>>>>>>>>>>>>> are the
> >>>>>>>>>>>>>>>>>>>>> occasional WARNING statements from a BUG it appears=
. They
> >>>>>>>>>>>>>>>>>>>>> trace back
> >>>>>>>>>>>>>>>>>>>>> to the mac.c file inside the ath12k code. There sho=
uld be
> >>>>>>>>>>>>>>>>>>>>> some in the
> >>>>>>>>>>>>>>>>>>>>> debug log that's attached. Let me know if I can do =
anything
> >>>>>>>>>>>>>>>>>>>>> else.
> >>>>>>>>>>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> I have never seen this warning on my upstream setup.=
..Not
> >>>>>>>>>>>>>>>>>>>> sure if you
> >>>>>>>>>>>>>>>>>>>> have changed anything or using the correct code base=
.
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Jeff merged this patch-set into ath-202504021602. Ca=
n you
> >>>>>>>>>>>>>>>>>>>> try on this
> >>>>>>>>>>>>>>>>>>>> branch?
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> git clone https://git.kernel.org/pub/scm/linux/kerne=
l/git/
> >>>>>>>>>>>>>>>>>>>> ath/ath.git/
> >>>>>>>>>>>>>>>>>>>> git pull
> >>>>>>>>>>>>>>>>>>>> git reset --hard ath-202504021602
> >>>>>>>>>>>>>>>>>>>> compile and install...
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Also make sure that the firmware you used is from th=
e same
> >>>>>>>>>>>>>>>>>>>> folder, don't
> >>>>>>>>>>>>>>>>>>>> mix with other folders:
> >>>>>>>>>>>>>>>>>>>> linux-firmware/ath12k/WCN7850/hw2.0
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> 1. rmmod/insmod(debug_mask=3D0xffff)
> >>>>>>>>>>>>>>>>>>>> 2. iw reg get
> >>>>>>>>>>>>>>>>>>>> 3. iw reg set US
> >>>>>>>>>>>>>>>>>>>> 4. iw xxx scan
> >>>>>>>>>>>>>>>>>>>> wait and collect logs.
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> don't do anything else.
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Also, can you show me your AP configuration.
> >>>>>>>>>>>>>>>>>>>> If you have another 6 GHz AP, you can have a try(bet=
ter
> >>>>>>>>>>>>>>>>>>>> different brands).
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Thanks for testing.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Could you share your AP configuration?
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> If you have sniffer, could please capture packets du=
ring
> >>>>>>>>>>>>>>>>>>>> testing?
> >>>>>>>>>>>>>>>>>> Can you capture packets during the testing? I need to =
check
> >>>>>>>>>>>>>>>>>> probe req
> >>>>>>>>>>>>>>>>>> and probe resp.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Thanks!
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> -Walt
> >>>>>>>>>>>>>>>>>>> OK, I cloned and built the kernel based on your instr=
uctions
> >>>>>>>>>>>>>>>>>>> in your
> >>>>>>>>>>>>>>>>>>> last email. Originally, the result was identical to m=
y last
> >>>>>>>>>>>>>>>>>>> email,
> >>>>>>>>>>>>>>>>>>> including the WARNINGS. The .config I use is configur=
ed for a
> >>>>>>>>>>>>>>>>>>> fully RT
> >>>>>>>>>>>>>>>>>>> PREEMPT kernel, which I wondered if that was why I wa=
s
> >>>>>>>>>>>>>>>>>>> receiving the
> >>>>>>>>>>>>>>>>>>> WARNING. So I configured it as a Low Latency PREEMPT =
Desktop
> >>>>>>>>>>>>>>>>>>> without
> >>>>>>>>>>>>>>>>>>> the RT_PREEMPT and that eliminated the WARNING. Howev=
er,
> >>>>>>>>>>>>>>>>>>> still no 6Ghz
> >>>>>>>>>>>>>>>>>>> networks. The firmware I'm using is straight from ker=
nel.org
> >>>>>>>>>>>>>>>>>>> GIT and I
> >>>>>>>>>>>>>>>>>>> do a 'make install; make dedup' to install it. I beli=
eve it
> >>>>>>>>>>>>>>>>>>> should be
> >>>>>>>>>>>>>>>>>>> good. Attached is the latest log file.
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> -Walt
> >>>>>>>>>>>>>>> Sorry for the top-post earlier. I can't figure out how to=
 capture
> >>>>>>>>>>>>>>> the
> >>>>>>>>>>>>>>> wireless packets as my chip/driver combo doesn't support =
monitor
> >>>>>>>>>>>>>>> mode.
> >>>>>>>>>>>>>> Your AP also cannot capture wireless packets?
> >>>>>>>>>>>>>> log in AP by usbserial or ssh.
> >>>>>>>>>>>>>> Try to enter command line. use iw command to create monito=
r
> >>>>>>>>>>>>>> interface.
> >>>>>>>>>>>>>> Then use tcpdump to capture packets.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I've attached a tarball that contains the trace data and =
additional
> >>>>>>>>>>>>>>> firmware logs from the kernel.log file. Anything else you=
 need, just
> >>>>>>>>>>>>>>> ask. Thanks for your help,
> >>>>>>>>>>>>>> Your AP mac address?
> >>>>>>>>>>>>>> Need it to help check the fw log.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> -Walt
> >>>>>>>>>>>>> Sorry, the AP doesn't have tcpdump available on it. Also, t=
his is a
> >>>>>>>>>>>>> mesh setup with 3 nodes total. The main AP and 2 mesh nodes=
. I'm
> >>>>>>>>>>>>> within 10 feet of one of the nodes and it's MAC for the wir=
eless 6ghz
> >>>>>>>>>>>>> network is: 10:7C:61:6F:2A:CA
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> -Walt
> >>>>>>>>>>>> The other 2 node 6ghz mac addresses are:
> >>>>>>>>>>>> 10:7C:61:6F:1F:11   - Router
> >>>>>>>>>>>> 10:7C:61:6F:32:92   - Node
> >>>>>>>>>>>>
> >>>>>>>>>>>> The first MAC address I gave you earlier was a node located
> >>>>>>>>>>>> approximately 5 feet from where the laptop is.
> >>>>>>>>>>>>
> >>>>>>>>>>>> -Walt
> >>>>>>>>>>> Well, I'm running into a brick wall it seems trying to get 6G=
hz
> >>>>>>>>>>> enabled on this. I tried the ath-next-20250418 tag just now a=
nd still
> >>>>>>>>>>> don't see or connect to my 6Ghz network. I applied the patche=
s in:
> >>>>>>>>>>> https://lore.kernel.org/linux-wireless/20250418-ath12k-6g-lp-=
vlp-
> >>>>>>>>>>> v1-0-c869c86cad60@quicinc.com/T/#t
> >>>>>>>>>>>
> >>>>>>>>>>> hoping that would help, but alas, no 6Ghz networks. I see tha=
t MLO and
> >>>>>>>>>>> other nice fixes are coming in 6.16, but without 6Ghz, they'l=
l do me
> >>>>>>>>>>> no good. I'm really wondering if it's a firmware issue that e=
xcludes
> >>>>>>>>>>> my chip or something. Again, anything I can do to help, let m=
e know.
> >>>>>>>>>>> Thanks,
> >>>>>>>>>>>
> >>>>>>>>>>> -Walt
> >>>>>>>>>> Well, I used the swiss army tools to look at the firmware, and=
 my chip
> >>>>>>>>>> is listed in the firmware, so it's not excluded or anything. R=
eally
> >>>>>>>>>> puzzlling issue as my other two laptops connect to the 6Ghz ne=
twork
> >>>>>>>>>> just fine, and this laptop does in Windows, just not in Linux.=
 I
> >>>>>>>>>> really don't use Windows at all though, so that does me no goo=
d.
> >>>>>>>>>>
> >>>>>>>>>> This laptop used to connect to the 6Ghz network around the Sep=
. - Oct.
> >>>>>>>>>> 2024 timeframe. Something has changed and now it doesn't. I'm =
going to
> >>>>>>>>>> boot off a live image of Ubuntu 24.10 and see if I can see the
> >>>>>>>>>> network. It was always hit or miss so we'll see.
> >>>>>>>>>> -Walt
> >>>>>>>>>
> >>>>>>>>> Can you find 6 GHz AP now?
> >>>>>>>>>
> >>>>>>>> Our firmware team said you station device sent the probe request=
 but
> >>>>>>>> didn't receive the probe resp or beacon.
> >>>>>>>>
> >>>>>>>> Since your current configuration is single 6 GHz AP. Could you c=
hange
> >>>>>>>> your AP configuration to 6 GHz + 2/5 GHz to have a retry?
> >>>>>>>>
> >>>>>>> I adedd another network with 2.4 / 5 / 6Ghz settings and still on=
ly
> >>>>>>> connect to the 5Ghz network portion. This is verified through wav=
emon
> >>>>>>> and the AP. I saw some patches recently to address 6 Ghz operatoi=
ns in
> >>>>>>> various modes (https://lore.kernel.org/linux-wireless/1692f2f8-c7=
7e-87ce-db70-00b4d9fc7c95@oss.qualcomm.com/),
> >>>>>>> but the patch doesn't apply cleanly to current or ath-pending. Do=
n't
> >>>>>>> know that it would help, but it seemed interesting.
> >>>>>>>
> >>>>>>> When I went back to the older kernel / distro I still could not s=
ee
> >>>>>>> the 6 Ghz band nor connect to it. I think something has changed o=
n the
> >>>>>>> AP as well, as this used to work intermittently. I think I have
> >>>>>>> mentioned this before, but I have a dual-boot setup on this lapto=
p and
> >>>>>>> in Windows 11, it does see and connect to the 6 Ghz band and MLO =
works
> >>>>>>> as well. Also, I have about 5 other devices (phones and laptops) =
that
> >>>>>>> can all connect to the 6 Ghz band. I think it's a combination of =
the
> >>>>>>> AP and the driver / firmware.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Do you have another WCN7850?
> >>>>>> Our monitor mode is now in pending branch, and one fix is coming s=
o that
> >>>>>> you can use WCN7850 to capture 6 GHz management packects. So that =
our
> >>>>>> firmware team can do further research.
> >>>>> I've successfully put the wifi into monitor mode and captured some
> >>>>> traffic. I used freq. 6615, which is the frequency my Holman-6G run=
s
> >>>>> at with a width of 320Mhz. I can see beacons and other wifi related
> >>>>> traffic, however, I did not have an encryption key set, so any traf=
fic
> >>>>> should still be encrypted. Hopefully the beacons and other things
> >>>>> help.
> >>>>> I took a chance that the patches were ready and used the most recen=
t
> >>>>> tag: ath-pending-202505201841 and it appeared to work OK. Let me kn=
ow
> >>>>> if this helps and if you need anything else. Thanks,
> >>>>
> >>>> This is what we needed.
> >>>>
> >>>> But i didn't see probe req in this file.
> >>>> Not sure if you didn't run the test?
> >>>>
> >>>> Can you put this monitor mode device between your test station devic=
e
> >>>> and AP device(Try to ensure that it is on the connection line betwee=
n
> >>>> the two device), then start the full test?
> >>>> Remember run "iw reg set US" before connecting step.
> >>>>
> >>>>
> >>>> Also, please provide us the host/firmware log and the packets.
> >>>> All logs/packets come from the same test, will make it easier for ou=
r
> >>>> firmware team to debug.
> >>>> =F0=9F=99=82
> >>> OK, I think I've got something here and I hope it's useful. I did a
> >>> packet capture of the wifi traffic on Freq. 6615 @ 160Mhz from anothe=
r
> >>> host and then loaded the ath12k module on the problem host and logged
> >>> it all. The wifi adapter for the ath12k is a Quectel model. Also, I
> >>> shut off both mesh nodes so that only the AP was running to ensure we
> >>> were on the same node.
> >> This is great, thanks.
> >>
> >>
> >>> Please let me know if you need anything else. I
> >>> did see some packets from the ath12k module in the source field of th=
e
> >>> capture so hopefully this  helps.
> >> Oh... you missed the firmware log.
> >>
> >> 1. sudo apt install trace-cmd
> >> 2. sudo trace-cmd record -e ath12k_wmi_diag
> >> 3. run test
> >> 4. "ctrl c" to stop recording:
> >> Hit Ctrl^C to stop recording
> >> ^CCPU0 data recorded at offset=3D0xdf5000
> >>       2605056 bytes in size
> >> Then share the trace.dat to us.
> >>
> >> So you need to:
> >> 1. try to capture wireless packets.
> >> 2. capture firmware log(trade.data).
> >>
> >>
> >> Total three files:
> >> trace.dat, kernel.log, wifi-capture.pcapng
> >> =F0=9F=99=82It's a little complicated, but they are necessary, thanks.
> > Sorry about that, was in a hurry for the holiday and forgot about it.
> > Here's the 3 files.
>
>
> Thanks!
>
>
> According to your logs, it is 6G non_transmitted MBSSID and with
> wildcard ssid. Offiline sync with firmware team.
>
> For this kind of AP, station shuold add SSID in scan so that we can
> receive probe resp from this AP.
>
> So can you test again and collect the wpa_supplicant log? Also, remember
> to collect the trace.dat/capture packets.
>
>
> 1.Please add some logs in ath12k_wmi_send_scan_start_cmd().
>
>      if (arg->num_ssids) {
>          ssid =3D ptr;
>          for (i =3D 0; i < arg->num_ssids; ++i) {
>              ssid->ssid_len =3D cpu_to_le32(arg->ssid[i].ssid_len);
>              memcpy(ssid->ssid, arg->ssid[i].ssid,
>                     arg->ssid[i].ssid_len);
>              ssid++;
>          }
>      }
>
>
> Firmware team needs to check the "ssid->ssid"=F0=9F=99=82  thanks!
>
> 2. add network config in wpa_supplicant.conf like:
>
> network=3D{
>          ssid=3D"Holman-6G"
>          psk=3D"1234567890"
>          scan_ssid=3D1
>          key_mgmt=3DSAE
>          disabled=3D0
> }
>
> ideally, you will see wpa_supplicant logs like:
> wls1: nl80211: New scan results available
> nl80211: Scan probed for SSID 'Holman-6G'
> nl80211: Scan probed for SSID ''
>
> Step 2 is necessary because we won't send probe req to these hidden AP
> unless it is configured in wpa_supplicant.
>
> There may be slight differences in the wpa_supplicant configuration,
> please make changes according to your AP's configuration.

Well, I've got some good news to report!  The patch series listed at:
https://lore.kernel.org/linux-wireless/20250530035615.3178480-1-rameshkumar=
.sundaram@oss.qualcomm.com/T/#t

Fixes my issue. I can see the single 6 Ghz network as well as connect
to the 6 Ghz network that is part of the multi-band "Holman" network.
I didn't get an MLO connection using the ath-pending tag from 5/21,
but this is really good progress. Now if we could only get that series
back-ported to stable.

-Walt


Return-Path: <linux-wireless+bounces-23087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321BBABA288
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 20:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A7EA07579
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C224326AA99;
	Fri, 16 May 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFXO3F+S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644BB27703E
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418981; cv=none; b=nIZ2CKYkeppFtlqIiICtLVI9dZOAX3gVrHvU8Cc6ChKP+2f0xptzM56Re66qsjceuqWclBzz7fs3JTsq7yul12dAbiybVr5FmTs0EOEo0p77iVhDwE2fkrLXkqfRU4CnXLUH1PEawhxZgSj5pzYsoETWVI9BfIb6K52Mpr2hNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418981; c=relaxed/simple;
	bh=tCYB5QEBDRZOTMmCcl95BuW6OZJ96iwrQ/HtvaYv+Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HETtRV5ykKOkTX+D4cCsZQSRpyYll4Q9yWO91T3rkOkv48fyMdm0L5bMEirOpVaS8YEVjDnMXYEBTjCY2YVcitbeaO08MGOGcMPB27JTmY0VjHg7pEGqWr6Ft0tmKCab8Nqeog2uL9QdYLI1T1OYJr5k6PLlv6tqufwYiB4VfC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFXO3F+S; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-440685d6afcso24906405e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747418978; x=1748023778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfxBlFzAT+LujjVhFEwNDgs6yFpiz6R9oI+q/9AM+Uw=;
        b=jFXO3F+S/EKQI+AwG79QD7e/MXKH9qNqM8Ua9tAiuJqohVuotXatTjYJWQfJkaxGWH
         0tcj0/XnvyvUheMRKmNh7kAxzUpTyc3LvtJjO2q28w/fhDQOOwa3ya8BZkAqgUOhpyw3
         09Qi1dVfB03Q7+yQLFmcKiIgWmRMoB4MSXpfAz5ghaU+gNPVwS+M/xAjKkyL7eEmMYGM
         aBViFLEIOZaD96K1AMfhzjLmSjAH0Y+Y5ilBtYfLNY+PGvAlyvZUQDMqN3U9ZMBHsauu
         surPRqIWLcxOyvDn9s1+KttdLdm1+FSsAg9IWoxeUMtyxWJeSEQ7SBM2dgHLId8Xg84m
         Vm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747418978; x=1748023778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfxBlFzAT+LujjVhFEwNDgs6yFpiz6R9oI+q/9AM+Uw=;
        b=Gv0oRPVDm0fBh/6bZEKTNv1U8oFlfof70yWVB3BLYlSyHiqRGMu8HPCsaiqAR1c3t/
         EPoMOq0MFPzGX5F9/jIbQ7swfHpM2INJwXD7ReJDA01IN5AcYvE9/loF4YZEu2f0b16P
         qQyD3lowfQXxl50DcMzTMwynd4ScL8+q/2WZVnUKWw4q08KiccQNCgWqNwCOyTAuRIbt
         Uj5KrN480Z7qGTN4rv2lufvsLgFif4hDAR3XfCuzLiL1dswt8xlKrLflK3IciBbcwGP3
         tM80n7gDnnOthYwP9LGBwOgknEnaP2qarx0fzGPBA7z3PIsO+7xtqiOHG92cY3hC75Yx
         BE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgRmoDIJSMHGij03plF8KR1zY17UaJCJ7EAU1UXJJr1ZUIz2zHZ6MB8mqMG0fm9TILYWzzuilOTH1M6FxILQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcCPaTmV0FCpyBxLBo/htpQNya3PVgLUNvRq1A5OKssqXxdYhv
	a6tTLnyNzACzX7Yo3Ns502m/+ARlQms8X17fOf+vvAXnik32VnhYMM3NDHLhk6Fm3vpuLi5KhCs
	yQH43iSAiJQusTZ7LBnGOJfbqiayIdAs=
X-Gm-Gg: ASbGncsqH1Nv6hkNyPlWF/tCZDNmUwsVHsy7/Loixa72sLLpb+VU9yCmytwwQpZ9LZM
	KBj6vlHn+RSzf7ZdxnpLvCkRkbKRi9RWpX7RogNl608OIa6bCivjYy+Yiz6ed0202FpvtfzrNjy
	z3KkaO11OZ4wL+ebOkTGJupTAqoO4+a3s=
X-Google-Smtp-Source: AGHT+IFBAn19SeUtaINrz2pgX25CNrCXYCbl7/6XRcL9NinukM+SA7TUH62MzhUuuPP4VpkV5gnLxPEB07Py9GFs7IY=
X-Received: by 2002:a05:600c:1994:b0:442:f44f:655 with SMTP id
 5b1f17b1804b1-442ff03c60dmr32807135e9.32.1747418977208; Fri, 16 May 2025
 11:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <ef81db9e-99cb-4802-b17f-94eb623a8b32@quicinc.com> <CAMb39_m+4dNBDbkZmn-rDA7T+u84y-dx1jSfmPNWnse=R1=gCw@mail.gmail.com>
 <18788f02-e374-4aa6-ac4a-fd53bc93754c@quicinc.com> <CAMb39_=G_TEL1pbeF_PAZLQh-JOFcncSfqZChPmEj63NjsEOLA@mail.gmail.com>
 <16ccbe02-b315-40d1-8600-232b592d4dd6@quicinc.com> <CAMb39_n4tyrzS=-j0L+ekJVer=KiZyDYFhMqrrcpr9py_itU9w@mail.gmail.com>
 <0933d8d6-5b72-40df-95f8-69f6fbbdfde7@oss.qualcomm.com> <CAMb39_nHO_TbHPQawdLVY8nt3yt4wDuEHyEuzMa-p5Ab1n94sA@mail.gmail.com>
 <CAMb39_nQ-uyKAqCz1HEUDt5qjszbhzf3oikVcvzHcVwt4_qt=A@mail.gmail.com>
 <CAMb39_n89hBL_GvfXb7Jw9h5-h-+Qg-3GyqvpahL7MT5ewpvJw@mail.gmail.com>
 <CAMb39_=YPYg0q7Lf0sMgTx5QwKOqcyJrZR7kTspyXEDa6qz9Bw@mail.gmail.com>
 <e9da4ad5-52cb-416d-991a-259140469e2c@oss.qualcomm.com> <87774003-d0a5-4408-b710-20bd3c194cec@quicinc.com>
 <CAMb39_ntK9Zv3pOuMSza5hRfs_KZBhya=GAPnpBWjN2wZDst9w@mail.gmail.com> <c7c0dfd4-bda9-4a63-84f9-a47b716c6ddd@quicinc.com>
In-Reply-To: <c7c0dfd4-bda9-4a63-84f9-a47b716c6ddd@quicinc.com>
From: Walt Holman <waltholman09@gmail.com>
Date: Fri, 16 May 2025 13:09:25 -0500
X-Gm-Features: AX0GCFvbi7J3GhYsY4Nb8McNum3Z8nqzRF0leXwb_OnUspQJPsUDKBSj3oKS78o
Message-ID: <CAMb39_nxGevnV4rQq1mQ4Tnu8BYxvwdSnRT0B3GNYV+GOn=xEg@mail.gmail.com>
Subject: Re: ath12k: No 6GHz Wireless found
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 10:06=E2=80=AFPM Kang Yang <quic_kangyang@quicinc.c=
om> wrote:
>
>
>
> On 5/16/2025 1:47 AM, Walt Holman wrote:
> > On Thu, May 15, 2025 at 4:22=E2=80=AFAM Kang Yang <quic_kangyang@quicin=
c.com> wrote:
> >>
> >>
> >>
> >> On 5/15/2025 4:12 PM, Kang Yang wrote:
> >>>
> >>> On 4/20/2025 11:18 PM, Walt Holman wrote:
> >>>> On Fri, Apr 18, 2025 at 4:18=E2=80=AFPM Walt Holman <waltholman09@gm=
ail.com>
> >>>> wrote:
> >>>>> On Tue, Apr 15, 2025 at 4:23=E2=80=AFPM Walt Holman <waltholman09@g=
mail.com>
> >>>>> wrote:
> >>>>>> On Thu, Apr 10, 2025 at 10:32=E2=80=AFAM Walt Holman
> >>>>>> <waltholman09@gmail.com> wrote:
> >>>>>>> On Thu, Apr 10, 2025 at 3:26=E2=80=AFAM Kang Yang
> >>>>>>> <kang.yang@oss.qualcomm.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 4/10/2025 3:37 AM, Walt Holman wrote:
> >>>>>>>>> On Tue, Apr 8, 2025 at 4:17=E2=80=AFAM Kang Yang
> >>>>>>>>> <quic_kangyang@quicinc.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 4/8/2025 1:49 AM, Walt Holman wrote:
> >>>>>>>>>>> Attached is a small packet capture where I did an 'iw wlp99s0
> >>>>>>>>>>> scan'
> >>>>>>>>>>> and also deactivated and reactivated wireless while the scan =
was
> >>>>>>>>>>> ongoing. Hopefully there's something interesting for you in t=
here.
> >>>>>>>>>>> Also, I've take 3 screenshots showing the configs of the
> >>>>>>>>>>> wireless AP
> >>>>>>>>>>> for the 6ghz network. The first screen is just the definition
> >>>>>>>>>>> of the
> >>>>>>>>>>> network. No advanced settings are used. The 2nd screen shows =
the
> >>>>>>>>>>> channels and radio enabled. The 3rd screen has the advanced
> >>>>>>>>>>> (professional) settings for the network. I believe I changed
> >>>>>>>>>>> 'Agile
> >>>>>>>>>>> Multiband' to enabled, but other settings are their defaults.=
 Hope
> >>>>>>>>>>> some of this helps. Let me know if you need anything else. Th=
anks,
> >>>>>>>>>>>
> >>>>>>>>>> Your packets are Ethernet packets. I need wireless packets.
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Not sure if you know how to add a seperate monitor interface t=
o
> >>>>>>>>>> capture
> >>>>>>>>>> 6 G channels' packet on your AP(you can google for specific
> >>>>>>>>>> command).
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Also, please capture firmware log:
> >>>>>>>>>>
> >>>>>>>>>> 1. sudo apt install trace-cmd
> >>>>>>>>>> 2. sudo trace-cmd record -e ath12k_wmi_diag
> >>>>>>>>>> 3. run test
> >>>>>>>>>> 4. "ctrl c" to stop recording:
> >>>>>>>>>> Hit Ctrl^C to stop recording
> >>>>>>>>>> ^CCPU0 data recorded at offset=3D0xdf5000
> >>>>>>>>>>         2605056 bytes in size
> >>>>>>>>>> Then share the trace.dat to us.
> >>>>>>>>>>
> >>>>>>>>>> So you need to:
> >>>>>>>>>> 1. try to capture wireless packets.
> >>>>>>>>>> 2. capture firmware log(trade.data).
> >>>>>>>>>> 3. save kernel/wpa_supplicant/iw logs.
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> -Walt
> >>>>>>>>>>>
> >>>>>>>>>>> On Sun, Apr 6, 2025 at 8:58=E2=80=AFPM Kang Yang
> >>>>>>>>>>> <quic_kangyang@quicinc.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 4/4/2025 12:04 AM, Walt Holman wrote:
> >>>>>>>>>>>>> On Thu, Apr 3, 2025 at 3:20=E2=80=AFAM Kang Yang
> >>>>>>>>>>>>> <quic_kangyang@quicinc.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 4/3/2025 1:48 AM, Walt Holman wrote:
> >>>>>>>>>>>>>>> On Tue, Apr 1, 2025 at 9:48=E2=80=AFPM Kang Yang
> >>>>>>>>>>>>>>> <quic_kangyang@quicinc.com> wrote:
> >>>>>>>>>>>>>>>> Test on 6.14.0-rc5-wt-ath+, with the firmware you used.
> >>>>>>>>>>>>>>>> I can get 6 GHz AP and connect to it.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> ath12k_pci 0000:03:00.0: fw_version 0x100301e1
> >>>>>>>>>>>>>>>> fw_build_timestamp
> >>>>>>>>>>>>>>>> 2023-12-06 04:05 fw_build_id
> >>>>>>>>>>>>>>>> QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-
> >>>>>>>>>>>>>>>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> yk@yk-Mayan:~$ sudo iw wls1 scan | tee iw_scan.log:
> >>>>>>>>>>>>>>>> BSS 62:03:7f:12:64:64(on wls1) -- associated
> >>>>>>>>>>>>>>>>                TSF: 606308271476 usec (7d, 00:25:08)
> >>>>>>>>>>>>>>>>                freq: 6275
> >>>>>>>>>>>>>>>>                beacon interval: 100 TUs
> >>>>>>>>>>>>>>>>                capability: ESS Privacy SpectrumMgmt
> >>>>>>>>>>>>>>>> ShortSlotTime (0x0511)
> >>>>>>>>>>>>>>>>                signal: -17.00 dBm
> >>>>>>>>>>>>>>>>                last seen: 52 ms ago
> >>>>>>>>>>>>>>>>                Information elements from Probe Response =
frame:
> >>>>>>>>>>>>>>>>                SSID: MLO-KANG-6G
> >>>>>>>>>>>>>>>> and other 6 GHz APs:
> >>>>>>>>>>>>>>>>               SSID: 6G-gxia
> >>>>>>>>>>>>>>>>               SSID: NETGEAR97-6G
> >>>>>>>>>>>>>>>>               =E2=80=A6=E2=80=A6
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> kernel log:
> >>>>>>>>>>>>>>>> [88158.033218] wls1: Inserted STA 62:03:7f:12:64:64
> >>>>>>>>>>>>>>>> [88158.033232] wls1: authenticate with 62:03:7f:12:64:64
> >>>>>>>>>>>>>>>> (local
> >>>>>>>>>>>>>>>> address=3D00:03:7f:37:12:54)
> >>>>>>>>>>>>>>>> [88158.033242] wls1: send auth to 62:03:7f:12:64:64 (try=
 1/3)
> >>>>>>>>>>>>>>>> [88158.041895] wls1: authenticated
> >>>>>>>>>>>>>>>> [88158.041914] wls1: moving STA 62:03:7f:12:64:64 to sta=
te 2
> >>>>>>>>>>>>>>>> [88158.044291] wls1: determined local STA to be EHT, BW
> >>>>>>>>>>>>>>>> limited to 320 MHz
> >>>>>>>>>>>>>>>> [88158.045719] wls1: associate with 62:03:7f:12:64:64 (t=
ry
> >>>>>>>>>>>>>>>> 1/3)
> >>>>>>>>>>>>>>>> [88158.067045] wls1: RX AssocResp from 62:03:7f:12:64:64
> >>>>>>>>>>>>>>>> (capab=3D0x511
> >>>>>>>>>>>>>>>> status=3D0 aid=3D4)
> >>>>>>>>>>>>>>>> [88158.089090] wls1: associated
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I can even connect to it by Ubuntu GUI.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Can you update to 6.14.0-rc5-wt-ath+ and have a retry?
> >>>>>>>>>>>>>>>> Also please make
> >>>>>>>>>>>>>>>> sure that your wpa_supplicant/iw support 6 GHz(or direct=
ly
> >>>>>>>>>>>>>>>> update to the
> >>>>>>>>>>>>>>>> latest version).
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> If you still cannot find 6 GHz AP, you can set debug_mas=
k
> >>>>>>>>>>>>>>>> to 0xffffffff
> >>>>>>>>>>>>>>>> to get ath12k logs. Then give it to us.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> -Walt
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> OK, I retested with the wt-ath 033125 tagged build. This
> >>>>>>>>>>>>>>> included the
> >>>>>>>>>>>>>>> patch the Jeff suggested I try, but the rest of the tree
> >>>>>>>>>>>>>>> was clean.
> >>>>>>>>>>>>>>> Still no 6ghz Wifi. I'm attaching a log file of the boot
> >>>>>>>>>>>>>>> and first few
> >>>>>>>>>>>>>>> seconds with the debug mask turned on. I noticed that if =
I
> >>>>>>>>>>>>>>> rmmod the
> >>>>>>>>>>>>>>> module and then modprobe it, it complains about not findi=
ng
> >>>>>>>>>>>>>>> firmware-2.bin, however, I thought that was only for the
> >>>>>>>>>>>>>>> qcn based
> >>>>>>>>>>>>>>> chip? The HW info from dmesg looks like this:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I cannot find this tag...
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>       From the log, the 6 GHz channel should work. When sc=
an
> >>>>>>>>>>>>>> is triggered, FW
> >>>>>>>>>>>>>> shall send probe req on these channels. If AP send probe
> >>>>>>>>>>>>>> resp, station
> >>>>>>>>>>>>>> shall find the AP.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> [    6.070282] ath12k_pci 0000:63:00.0: BAR 0 [mem
> >>>>>>>>>>>>>>> 0xdd800000-0xdd9fffff 64bit]: assigned
> >>>>>>>>>>>>>>> [    6.070310] ath12k_pci 0000:63:00.0: enabling device
> >>>>>>>>>>>>>>> (0000 -> 0002)
> >>>>>>>>>>>>>>> [    6.071249] ath12k_pci 0000:63:00.0: MSI vectors: 16
> >>>>>>>>>>>>>>> [    6.071254] ath12k_pci 0000:63:00.0: Hardware name:
> >>>>>>>>>>>>>>> wcn7850 hw2.0
> >>>>>>>>>>>>>>> [    6.596331] ath12k_pci 0000:63:00.0: qmi dma allocatio=
n
> >>>>>>>>>>>>>>> failed
> >>>>>>>>>>>>>>> (7077888 B type 1), will try later with sma
> >>>>>>>>>>>>>>> ll size
> >>>>>>>>>>>>>>> [    6.604041] ath12k_pci 0000:63:00.0: chip_id 0x2
> >>>>>>>>>>>>>>> chip_family 0x4
> >>>>>>>>>>>>>>> board_id 0xff soc_id 0x40170200
> >>>>>>>>>>>>>>> [    6.604044] ath12k_pci 0000:63:00.0: fw_version 0x1003=
01e1
> >>>>>>>>>>>>>>> fw_build_timestamp 2023-12-06 04:05 fw_build_id
> >>>>>>>>>>>>>>> QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-
> >>>>>>>>>>>>>>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Also, I noticed when looking through the debug logs there
> >>>>>>>>>>>>>>> are the
> >>>>>>>>>>>>>>> occasional WARNING statements from a BUG it appears. They
> >>>>>>>>>>>>>>> trace back
> >>>>>>>>>>>>>>> to the mac.c file inside the ath12k code. There should be
> >>>>>>>>>>>>>>> some in the
> >>>>>>>>>>>>>>> debug log that's attached. Let me know if I can do anythi=
ng
> >>>>>>>>>>>>>>> else.
> >>>>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I have never seen this warning on my upstream setup...Not
> >>>>>>>>>>>>>> sure if you
> >>>>>>>>>>>>>> have changed anything or using the correct code base.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Jeff merged this patch-set into ath-202504021602. Can you
> >>>>>>>>>>>>>> try on this
> >>>>>>>>>>>>>> branch?
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> git clone https://git.kernel.org/pub/scm/linux/kernel/git/
> >>>>>>>>>>>>>> ath/ath.git/
> >>>>>>>>>>>>>> git pull
> >>>>>>>>>>>>>> git reset --hard ath-202504021602
> >>>>>>>>>>>>>> compile and install...
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Also make sure that the firmware you used is from the same
> >>>>>>>>>>>>>> folder, don't
> >>>>>>>>>>>>>> mix with other folders:
> >>>>>>>>>>>>>> linux-firmware/ath12k/WCN7850/hw2.0
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> 1. rmmod/insmod(debug_mask=3D0xffff)
> >>>>>>>>>>>>>> 2. iw reg get
> >>>>>>>>>>>>>> 3. iw reg set US
> >>>>>>>>>>>>>> 4. iw xxx scan
> >>>>>>>>>>>>>> wait and collect logs.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> don't do anything else.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Also, can you show me your AP configuration.
> >>>>>>>>>>>>>> If you have another 6 GHz AP, you can have a try(better
> >>>>>>>>>>>>>> different brands).
> >>>>>>>>>>>>>>
> >>>>>>>>>>>> Thanks for testing.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Could you share your AP configuration?
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>>> If you have sniffer, could please capture packets during
> >>>>>>>>>>>>>> testing?
> >>>>>>>>>>>>
> >>>>>>>>>>>> Can you capture packets during the testing? I need to check
> >>>>>>>>>>>> probe req
> >>>>>>>>>>>> and probe resp.
> >>>>>>>>>>>>
> >>>>>>>>>>>>>> Thanks!
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> -Walt
> >>>>>>>>>>>>> OK, I cloned and built the kernel based on your instruction=
s
> >>>>>>>>>>>>> in your
> >>>>>>>>>>>>> last email. Originally, the result was identical to my last
> >>>>>>>>>>>>> email,
> >>>>>>>>>>>>> including the WARNINGS. The .config I use is configured for=
 a
> >>>>>>>>>>>>> fully RT
> >>>>>>>>>>>>> PREEMPT kernel, which I wondered if that was why I was
> >>>>>>>>>>>>> receiving the
> >>>>>>>>>>>>> WARNING. So I configured it as a Low Latency PREEMPT Deskto=
p
> >>>>>>>>>>>>> without
> >>>>>>>>>>>>> the RT_PREEMPT and that eliminated the WARNING. However,
> >>>>>>>>>>>>> still no 6Ghz
> >>>>>>>>>>>>> networks. The firmware I'm using is straight from kernel.or=
g
> >>>>>>>>>>>>> GIT and I
> >>>>>>>>>>>>> do a 'make install; make dedup' to install it. I believe it
> >>>>>>>>>>>>> should be
> >>>>>>>>>>>>> good. Attached is the latest log file.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> -Walt
> >>>>>>>>>
> >>>>>>>>> Sorry for the top-post earlier. I can't figure out how to captu=
re
> >>>>>>>>> the
> >>>>>>>>> wireless packets as my chip/driver combo doesn't support monito=
r
> >>>>>>>>> mode.
> >>>>>>>> Your AP also cannot capture wireless packets?
> >>>>>>>> log in AP by usbserial or ssh.
> >>>>>>>> Try to enter command line. use iw command to create monitor
> >>>>>>>> interface.
> >>>>>>>> Then use tcpdump to capture packets.
> >>>>>>>>
> >>>>>>>>> I've attached a tarball that contains the trace data and additi=
onal
> >>>>>>>>> firmware logs from the kernel.log file. Anything else you need,=
 just
> >>>>>>>>> ask. Thanks for your help,
> >>>>>>>>
> >>>>>>>> Your AP mac address?
> >>>>>>>> Need it to help check the fw log.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> -Walt
> >>>>>>> Sorry, the AP doesn't have tcpdump available on it. Also, this is=
 a
> >>>>>>> mesh setup with 3 nodes total. The main AP and 2 mesh nodes. I'm
> >>>>>>> within 10 feet of one of the nodes and it's MAC for the wireless =
6ghz
> >>>>>>> network is: 10:7C:61:6F:2A:CA
> >>>>>>>
> >>>>>>> -Walt
> >>>>>> The other 2 node 6ghz mac addresses are:
> >>>>>> 10:7C:61:6F:1F:11   - Router
> >>>>>> 10:7C:61:6F:32:92   - Node
> >>>>>>
> >>>>>> The first MAC address I gave you earlier was a node located
> >>>>>> approximately 5 feet from where the laptop is.
> >>>>>>
> >>>>>> -Walt
> >>>>> Well, I'm running into a brick wall it seems trying to get 6Ghz
> >>>>> enabled on this. I tried the ath-next-20250418 tag just now and sti=
ll
> >>>>> don't see or connect to my 6Ghz network. I applied the patches in:
> >>>>> https://lore.kernel.org/linux-wireless/20250418-ath12k-6g-lp-vlp-
> >>>>> v1-0-c869c86cad60@quicinc.com/T/#t
> >>>>>
> >>>>> hoping that would help, but alas, no 6Ghz networks. I see that MLO =
and
> >>>>> other nice fixes are coming in 6.16, but without 6Ghz, they'll do m=
e
> >>>>> no good. I'm really wondering if it's a firmware issue that exclude=
s
> >>>>> my chip or something. Again, anything I can do to help, let me know=
.
> >>>>> Thanks,
> >>>>>
> >>>>> -Walt
> >>>> Well, I used the swiss army tools to look at the firmware, and my ch=
ip
> >>>> is listed in the firmware, so it's not excluded or anything. Really
> >>>> puzzlling issue as my other two laptops connect to the 6Ghz network
> >>>> just fine, and this laptop does in Windows, just not in Linux. I
> >>>> really don't use Windows at all though, so that does me no good.
> >>>>
> >>>> This laptop used to connect to the 6Ghz network around the Sep. - Oc=
t.
> >>>> 2024 timeframe. Something has changed and now it doesn't. I'm going =
to
> >>>> boot off a live image of Ubuntu 24.10 and see if I can see the
> >>>> network. It was always hit or miss so we'll see.
> >>>> -Walt
> >>>
> >>>
> >>> Can you find 6 GHz AP now?
> >>>
> >>
> >> Our firmware team said you station device sent the probe request but
> >> didn't receive the probe resp or beacon.
> >>
> >> Since your current configuration is single 6 GHz AP. Could you change
> >> your AP configuration to 6 GHz + 2/5 GHz to have a retry?
> >>
> > I adedd another network with 2.4 / 5 / 6Ghz settings and still only
> > connect to the 5Ghz network portion. This is verified through wavemon
> > and the AP. I saw some patches recently to address 6 Ghz operatoins in
> > various modes (https://lore.kernel.org/linux-wireless/1692f2f8-c77e-87c=
e-db70-00b4d9fc7c95@oss.qualcomm.com/),
> > but the patch doesn't apply cleanly to current or ath-pending. Don't
> > know that it would help, but it seemed interesting.
> >
> > When I went back to the older kernel / distro I still could not see
> > the 6 Ghz band nor connect to it. I think something has changed on the
> > AP as well, as this used to work intermittently. I think I have
> > mentioned this before, but I have a dual-boot setup on this laptop and
> > in Windows 11, it does see and connect to the 6 Ghz band and MLO works
> > as well. Also, I have about 5 other devices (phones and laptops) that
> > can all connect to the 6 Ghz band. I think it's a combination of the
> > AP and the driver / firmware.
>
>
>
>
> Do you have another WCN7850?
> Our monitor mode is now in pending branch, and one fix is coming so that
> you can use WCN7850 to capture 6 GHz management packects. So that our
> firmware team can do further research.

I do have another m.2 card, however, I purchased the one I've got
installed due to the original card having the same issues.
Think I'll sit tight for a couple days and see how the fix goes in for
the pending tree and try that with monitor mode as well to get a
better look. Thank you for your help,

-Walt


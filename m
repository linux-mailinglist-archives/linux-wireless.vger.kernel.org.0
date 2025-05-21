Return-Path: <linux-wireless+bounces-23198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8706ABEB1A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 07:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B53D4A61DB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 05:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24B4218838;
	Wed, 21 May 2025 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+sSWuQL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D012E5B
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747803918; cv=none; b=ZlPwKRCDSgWi3vUFZAk34pJiSuiwoe9LGYV+MyzvyRz2w85RcRRDPceFkY0Qadjw+DSpTLEk4BU2m+s13Og54wuatiV3YAnHi8e5XcIA0g3LBH1g3X2nd8k1TVwc8o/1kYAa3SZP+qh18nJFKY/LInk/kD0yNm2l10Rhpb4VCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747803918; c=relaxed/simple;
	bh=XClXydFsRjbmE4IVMqGymeeSqCIk/kSgYjlqhS9pEC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwgRsyQ3P12/sziH0rELNhDRpiOzlQ6vV+rUc/BW+FNf+Gj3MivwvPfO/n7WVFh4cqLyfYvCwSQfRaqpeN7YuNy5Mj0Hzo+Hh9Ee7oMeGaeKr3hIc+8viW67bOxnUOA5vkbsvfvyTYyKay2Hg6XkSbKFIY7vSwuITZBWjO+en9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+sSWuQL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a35b7e60cbso4181555f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 22:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747803914; x=1748408714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d9KxuNpzdCNU711+5XPZAyLCb9L2d5qzzUaWBlYAHIQ=;
        b=E+sSWuQLW1ogwzlirR2ET9Jlp/u3bSwKNM/+Lha2rSpsYAR7p14UFssvjWU0NqX2Qo
         jFLsUnnPUUHXqRejVvCmk7qTlWHQuI5SHGu8l/kygtU1QcguLFn5SFmyaC1Xfp+Grujw
         igHc9SslP26ImHd2dp/H2reBmvfDO3wv6dKjuSAcOeXKONH42dK6g85bb8xYpmcEwYu2
         vKKIp972NjVHuQIK/glWJ3h7DPDhLKE+p48PwFHETWJCcYck48E/bInciWq3czTKHi/3
         hzufWEUMtviPEmWBjctoyoV82XToFncuFSTXV6hr+9B52YPZd7QhfF0jI1mq/jAg1SDC
         8sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747803914; x=1748408714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9KxuNpzdCNU711+5XPZAyLCb9L2d5qzzUaWBlYAHIQ=;
        b=oW+m0dwal+VeHIKeBSL9MlANS63RIhLoaJahBPwXswy0Ju+Q/5WLmzIzBGte9wGsy6
         nY1mwz7OSGVp24mztG9s94ddrO4JyaEmfCMVXUnbNFke8ltBfQG2T4Q8ss/lpbaj4e2U
         HpVfSPFZRP2q/XIuKeFpmwAyR+a8M0ju2ZgIWhsBdy0qUzbPS/S541lRX+w6DxNhWOgu
         WJwcHRjMa9e1YItCtCGJpJ+aA6fHQZPbL3UH3CA8m6psAKjBAqAwXWFtW8rmQa9P9MAL
         PKny1aFJQ//WPZ3CJgTuh+J2D/zn8M9hQc5kHA2STWVog7jPqHouwBWBTqazJ0Ipnoz2
         Felg==
X-Forwarded-Encrypted: i=1; AJvYcCX6nBdWWyDm/nKlT/Iy9xXhltgXyg50pYNlG1mT3sxQaBkS/Rw1lsyi20/nhxLka4Uo+Q4NjncCS1jgcU5pew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZgUMfXEib59fLoDi6GWUOFmuiS6SnefJbr0GPTWVZ2sJpRlP
	xQZdtKl2Bs7pT+lTj+sT1AN1NmceeMsGk6Tg8FCISW2fo5XsEWxVXgH0POX44LszYeklgR898ka
	Tc5+IHnkB9yT2mgaxkFYFmz/u3JEf+cw=
X-Gm-Gg: ASbGncto9IdOkX/AG+7dG9H7+1QD0SW7YNniMhFKJU5bfrnm3Heop/CTVjAhZPci4OD
	hTpcECDR7LffmPsjohshDDHrHNVb3SQGKIUzueQFOkE6b84qDPZcfI5h14C/9JI3R7Fm2UZivvB
	F5gdVBszbrjsNBGlyWjGe2KOLG66QifYo=
X-Google-Smtp-Source: AGHT+IFVGhfU3VP5OKO/Fwlv7GLJbiekXNxV1xM3qgg4MpAaIGhtUYdTfxkzfGBwZ1ngzfwNMnhLHU4lhNVDwxgVAlY=
X-Received: by 2002:a05:6000:4010:b0:3a3:6b07:bdcc with SMTP id
 ffacd0b85a97d-3a36b07beebmr9682260f8f.15.1747803913765; Tue, 20 May 2025
 22:05:13 -0700 (PDT)
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
Date: Wed, 21 May 2025 00:05:01 -0500
X-Gm-Features: AX0GCFvHFlrzU5YLXgXwaR2mOAx2BpqflV50YHDBsPTW_SCICvezGZ_g6PAB9Uk
Message-ID: <CAMb39_k6bkaU9ED+iUVFT33e3S1UU+U49bYpp-qyFW-wjSd4RQ@mail.gmail.com>
Subject: Re: ath12k: No 6GHz Wireless found
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Content-Type: multipart/mixed; boundary="0000000000006ae28f06359e4fb1"

--0000000000006ae28f06359e4fb1
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

I've successfully put the wifi into monitor mode and captured some
traffic. I used freq. 6615, which is the frequency my Holman-6G runs
at with a width of 320Mhz. I can see beacons and other wifi related
traffic, however, I did not have an encryption key set, so any traffic
should still be encrypted. Hopefully the beacons and other things
help.
I took a chance that the patches were ready and used the most recent
tag: ath-pending-202505201841 and it appeared to work OK. Let me know
if this helps and if you need anything else. Thanks,

-Walt

--0000000000006ae28f06359e4fb1
Content-Type: application/gzip; 
	name="wifi-packet-capture-20250520.pcapng.gz"
Content-Disposition: attachment; 
	filename="wifi-packet-capture-20250520.pcapng.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_maxhba5b0>
X-Attachment-Id: f_maxhba5b0

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
R/efrv/jf9hJxWekZQYA
--0000000000006ae28f06359e4fb1--


Return-Path: <linux-wireless+bounces-21744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0FBA93F66
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 23:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDFC1B653E7
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 21:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23481F869E;
	Fri, 18 Apr 2025 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt5LHz5y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09815442A
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745011098; cv=none; b=oZipwmZGsRyixDLDYqKsabqqZ/ECn9K6oEe8g4/WhSIdazjirfdOHFErrt5KDdnLGYobN7QOubovyDn8J4QkOAbzf46mKrbIXvyCXe8pKaAC1ddNAsnyK9UTBRsyvJLvblF9vrRWLCnsgYUQplkahxTcq7JvPKmwEhEA30ur+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745011098; c=relaxed/simple;
	bh=L/jmFRJ8t6cbiF5CpQouPzjGsNUM+EAfd589P35nbfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXXmb8FkTQ2awhHNr6AamaFhaWptd7dNxMXNCF0tDzf8S2QpH9/gFD3cw3OnPfJLXYs3iPUl8mqgNSsre+x1crhBWudbAsb+psqyYzD4dm3DtoeMLrqccJsE7s0uWaWyXd1YtJf3imoVba3+RLufZDKUif3NPJ6PupUCp10e64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt5LHz5y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso15584135e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 14:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745011095; x=1745615895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLhknTSKa7QG3Ced6fkSZ5QDkbgf8M9fWFLCJ1iZON4=;
        b=Gt5LHz5yoz3y8EODGEbHFg/uP3UW8YYFrW+tXvwm230D9VnlP7dhiuYf+wRYaH11Bp
         miAFB9tJJzs9Uos/TLWSysO723JUvELnQYexFnmEfWhWQXPxDuiulgXzFg7zjnZzXeXf
         k6df8QXp6IPfU75QmcS0LZS16GhzcTVNmCHC4oec3GNzbtdD3lDceA43bweanYikRewh
         9xLNMQ1b4WhLT+gmY/6oPeWyiBQqAW/uYbE9hM1Fr9FWYYUhj67ZjO6BRAibt9pTEu5m
         mvdEWsLJpictFTM+zZebHOCMCmP0wyoFv3pX/OpENFw+p2jPF8ssBHA3sJfdYIoCjbn4
         nlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745011095; x=1745615895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLhknTSKa7QG3Ced6fkSZ5QDkbgf8M9fWFLCJ1iZON4=;
        b=WTJwy9lZnYD8/6xJOi9/3XUuNeiJ4gJ16jsLW7QWzEoMONmzS8FTh8ZHolbY9trM3i
         8DN7BWOKCS1bHLgJlSNRXzYcrjCyEh/obSLVeCog+xLa7/WwmSwZ83bvZq63sDwOatL5
         I0O44cZSX/2zAESmCUQP1XXhFpVae83kWt+txbiIDqPkA39g9490VqIfPVQDpiCD/sZ7
         PPrHgANOy7Q84EXSMKH4bIv+EKSRL471x2eGjx+/H9xIpkm8JOEt4j9bsCvMrgfCL7sF
         r57SVWchG0HyV4xkkESPAonhXPyA+r9hbpdS7BBOCsnMsvNXbz/zXUusP1xJGks4ciFk
         pLEw==
X-Forwarded-Encrypted: i=1; AJvYcCVbx34xsIF97U25r5vOI8LVm0BpJrQUtzTcqdvdlQQiLP7VoiCJfDbfh1MwkZj6SAIeGv1guwqFMTbMigqXxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybtmLCy9m4mf80KEm5ZeRiLjck8pwlsEimSGucz1hGtWbMHqL4
	ckZlWFnaj3W+OSLwOi8I6Ep+3ejE5zkDW7zMPXaPJ70yfLjz28GJ66oW9vbYwqkgeoFfvIbUaJ1
	RGll5q1yP0iOQEYh/2/ZvosRvO/7X/zp7
X-Gm-Gg: ASbGncvC+kSMc0VjbVNGuvSYQnB6IQUuAAtkEWqi7S3woHoQwu28A8pm8Ufz6W+TQfn
	vyxGIsNw/KGVbYOVrAxrh3PMX/dWrve05B1JYPc+N1uaVfd+SDx9kGKQlG0g+Bqcb1pkpm2kQwh
	eDIPtKLjBqOqJ4jgEmSsiG
X-Google-Smtp-Source: AGHT+IHJj4mKOnrqc4ce2dDda85++mr1menfi+bEQ650HKCnvrCE2nPrC0otQqiR8xaVHyzrN66ZwYIi9pc2etsTa3M=
X-Received: by 2002:a05:600c:54c7:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-440707602a9mr15794895e9.18.1745011094578; Fri, 18 Apr 2025
 14:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <f45323db-ce4d-4374-9c93-0be4d0645fcd@oss.qualcomm.com> <CAMb39_ki7F1XgezyVfb9Tkm9D-FZE0XK3RcSYtFmFf0jP8-M_Q@mail.gmail.com>
 <dc0abf98-862b-47f5-ae71-749c68cffc73@quicinc.com> <CAMb39_kUUv24q6QUq9B9+TEUMrUhu12-8WJadzB53nMPhcAZSQ@mail.gmail.com>
 <ef81db9e-99cb-4802-b17f-94eb623a8b32@quicinc.com> <CAMb39_m+4dNBDbkZmn-rDA7T+u84y-dx1jSfmPNWnse=R1=gCw@mail.gmail.com>
 <18788f02-e374-4aa6-ac4a-fd53bc93754c@quicinc.com> <CAMb39_=G_TEL1pbeF_PAZLQh-JOFcncSfqZChPmEj63NjsEOLA@mail.gmail.com>
 <16ccbe02-b315-40d1-8600-232b592d4dd6@quicinc.com> <CAMb39_n4tyrzS=-j0L+ekJVer=KiZyDYFhMqrrcpr9py_itU9w@mail.gmail.com>
 <0933d8d6-5b72-40df-95f8-69f6fbbdfde7@oss.qualcomm.com> <CAMb39_nHO_TbHPQawdLVY8nt3yt4wDuEHyEuzMa-p5Ab1n94sA@mail.gmail.com>
 <CAMb39_nQ-uyKAqCz1HEUDt5qjszbhzf3oikVcvzHcVwt4_qt=A@mail.gmail.com>
In-Reply-To: <CAMb39_nQ-uyKAqCz1HEUDt5qjszbhzf3oikVcvzHcVwt4_qt=A@mail.gmail.com>
From: Walt Holman <waltholman09@gmail.com>
Date: Fri, 18 Apr 2025 16:18:03 -0500
X-Gm-Features: ATxdqUG_x4FXI5tD2Q2Xf0NBq_I8YGF_FK0S94VQEfuOOiUTqcYZbuYfnSY4FA8
Message-ID: <CAMb39_n89hBL_GvfXb7Jw9h5-h-+Qg-3GyqvpahL7MT5ewpvJw@mail.gmail.com>
Subject: Re: ath12k: No 6GHz Wireless found
To: Kang Yang <kang.yang@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 4:23=E2=80=AFPM Walt Holman <waltholman09@gmail.com=
> wrote:
>
> On Thu, Apr 10, 2025 at 10:32=E2=80=AFAM Walt Holman <waltholman09@gmail.=
com> wrote:
> >
> > On Thu, Apr 10, 2025 at 3:26=E2=80=AFAM Kang Yang <kang.yang@oss.qualco=
mm.com> wrote:
> > >
> > >
> > >
> > > On 4/10/2025 3:37 AM, Walt Holman wrote:
> > > > On Tue, Apr 8, 2025 at 4:17=E2=80=AFAM Kang Yang <quic_kangyang@qui=
cinc.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 4/8/2025 1:49 AM, Walt Holman wrote:
> > > >>> Attached is a small packet capture where I did an 'iw wlp99s0 sca=
n'
> > > >>> and also deactivated and reactivated wireless while the scan was
> > > >>> ongoing. Hopefully there's something interesting for you in there=
.
> > > >>> Also, I've take 3 screenshots showing the configs of the wireless=
 AP
> > > >>> for the 6ghz network. The first screen is just the definition of =
the
> > > >>> network. No advanced settings are used. The 2nd screen shows the
> > > >>> channels and radio enabled. The 3rd screen has the advanced
> > > >>> (professional) settings for the network. I believe I changed 'Agi=
le
> > > >>> Multiband' to enabled, but other settings are their defaults. Hop=
e
> > > >>> some of this helps. Let me know if you need anything else. Thanks=
,
> > > >>>
> > > >>
> > > >> Your packets are Ethernet packets. I need wireless packets.
> > > >>
> > > >>
> > > >> Not sure if you know how to add a seperate monitor interface to ca=
pture
> > > >> 6 G channels' packet on your AP(you can google for specific comman=
d).
> > > >>
> > > >>
> > > >> Also, please capture firmware log:
> > > >>
> > > >> 1. sudo apt install trace-cmd
> > > >> 2. sudo trace-cmd record -e ath12k_wmi_diag
> > > >> 3. run test
> > > >> 4. "ctrl c" to stop recording:
> > > >> Hit Ctrl^C to stop recording
> > > >> ^CCPU0 data recorded at offset=3D0xdf5000
> > > >>       2605056 bytes in size
> > > >> Then share the trace.dat to us.
> > > >>
> > > >> So you need to:
> > > >> 1. try to capture wireless packets.
> > > >> 2. capture firmware log(trade.data).
> > > >> 3. save kernel/wpa_supplicant/iw logs.
> > > >>
> > > >>
> > > >>
> > > >>
> > > >>
> > > >>> -Walt
> > > >>>
> > > >>> On Sun, Apr 6, 2025 at 8:58=E2=80=AFPM Kang Yang <quic_kangyang@q=
uicinc.com> wrote:
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> On 4/4/2025 12:04 AM, Walt Holman wrote:
> > > >>>>> On Thu, Apr 3, 2025 at 3:20=E2=80=AFAM Kang Yang <quic_kangyang=
@quicinc.com> wrote:
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>> On 4/3/2025 1:48 AM, Walt Holman wrote:
> > > >>>>>>> On Tue, Apr 1, 2025 at 9:48=E2=80=AFPM Kang Yang <quic_kangya=
ng@quicinc.com> wrote:
> > > >>>>>>
> > > >>>>>>>>
> > > >>>>>>>> Test on 6.14.0-rc5-wt-ath+, with the firmware you used.
> > > >>>>>>>> I can get 6 GHz AP and connect to it.
> > > >>>>>>>>
> > > >>>>>>>> ath12k_pci 0000:03:00.0: fw_version 0x100301e1 fw_build_time=
stamp
> > > >>>>>>>> 2023-12-06 04:05 fw_build_id
> > > >>>>>>>> QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V=
1.0_V2.0_SILICONZ-3
> > > >>>>>>>>
> > > >>>>>>>> yk@yk-Mayan:~$ sudo iw wls1 scan | tee iw_scan.log:
> > > >>>>>>>> BSS 62:03:7f:12:64:64(on wls1) -- associated
> > > >>>>>>>>              TSF: 606308271476 usec (7d, 00:25:08)
> > > >>>>>>>>              freq: 6275
> > > >>>>>>>>              beacon interval: 100 TUs
> > > >>>>>>>>              capability: ESS Privacy SpectrumMgmt ShortSlotT=
ime (0x0511)
> > > >>>>>>>>              signal: -17.00 dBm
> > > >>>>>>>>              last seen: 52 ms ago
> > > >>>>>>>>              Information elements from Probe Response frame:
> > > >>>>>>>>              SSID: MLO-KANG-6G
> > > >>>>>>>> and other 6 GHz APs:
> > > >>>>>>>>             SSID: 6G-gxia
> > > >>>>>>>>             SSID: NETGEAR97-6G
> > > >>>>>>>>             =E2=80=A6=E2=80=A6
> > > >>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>> kernel log:
> > > >>>>>>>> [88158.033218] wls1: Inserted STA 62:03:7f:12:64:64
> > > >>>>>>>> [88158.033232] wls1: authenticate with 62:03:7f:12:64:64 (lo=
cal
> > > >>>>>>>> address=3D00:03:7f:37:12:54)
> > > >>>>>>>> [88158.033242] wls1: send auth to 62:03:7f:12:64:64 (try 1/3=
)
> > > >>>>>>>> [88158.041895] wls1: authenticated
> > > >>>>>>>> [88158.041914] wls1: moving STA 62:03:7f:12:64:64 to state 2
> > > >>>>>>>> [88158.044291] wls1: determined local STA to be EHT, BW limi=
ted to 320 MHz
> > > >>>>>>>> [88158.045719] wls1: associate with 62:03:7f:12:64:64 (try 1=
/3)
> > > >>>>>>>> [88158.067045] wls1: RX AssocResp from 62:03:7f:12:64:64 (ca=
pab=3D0x511
> > > >>>>>>>> status=3D0 aid=3D4)
> > > >>>>>>>> [88158.089090] wls1: associated
> > > >>>>>>>>
> > > >>>>>>>> I can even connect to it by Ubuntu GUI.
> > > >>>>>>>>
> > > >>>>>>>> Can you update to 6.14.0-rc5-wt-ath+ and have a retry? Also =
please make
> > > >>>>>>>> sure that your wpa_supplicant/iw support 6 GHz(or directly u=
pdate to the
> > > >>>>>>>> latest version).
> > > >>>>>>>>
> > > >>>>>>>> If you still cannot find 6 GHz AP, you can set debug_mask to=
 0xffffffff
> > > >>>>>>>> to get ath12k logs. Then give it to us.
> > > >>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>>> -Walt
> > > >>>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>
> > > >>>>>>> OK, I retested with the wt-ath 033125 tagged build. This incl=
uded the
> > > >>>>>>> patch the Jeff suggested I try, but the rest of the tree was =
clean.
> > > >>>>>>> Still no 6ghz Wifi. I'm attaching a log file of the boot and =
first few
> > > >>>>>>> seconds with the debug mask turned on. I noticed that if I rm=
mod the
> > > >>>>>>> module and then modprobe it, it complains about not finding
> > > >>>>>>> firmware-2.bin, however, I thought that was only for the qcn =
based
> > > >>>>>>> chip? The HW info from dmesg looks like this:
> > > >>>>>>>
> > > >>>>>>
> > > >>>>>> I cannot find this tag...
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>     From the log, the 6 GHz channel should work. When scan is =
triggered, FW
> > > >>>>>> shall send probe req on these channels. If AP send probe resp,=
 station
> > > >>>>>> shall find the AP.
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>> [    6.070282] ath12k_pci 0000:63:00.0: BAR 0 [mem
> > > >>>>>>> 0xdd800000-0xdd9fffff 64bit]: assigned
> > > >>>>>>> [    6.070310] ath12k_pci 0000:63:00.0: enabling device (0000=
 -> 0002)
> > > >>>>>>> [    6.071249] ath12k_pci 0000:63:00.0: MSI vectors: 16
> > > >>>>>>> [    6.071254] ath12k_pci 0000:63:00.0: Hardware name: wcn785=
0 hw2.0
> > > >>>>>>> [    6.596331] ath12k_pci 0000:63:00.0: qmi dma allocation fa=
iled
> > > >>>>>>> (7077888 B type 1), will try later with sma
> > > >>>>>>> ll size
> > > >>>>>>> [    6.604041] ath12k_pci 0000:63:00.0: chip_id 0x2 chip_fami=
ly 0x4
> > > >>>>>>> board_id 0xff soc_id 0x40170200
> > > >>>>>>> [    6.604044] ath12k_pci 0000:63:00.0: fw_version 0x100301e1
> > > >>>>>>> fw_build_timestamp 2023-12-06 04:05 fw_build_id
> > > >>>>>>> QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1=
.0_V2.0_SILICONZ-
> > > >>>>>>>
> > > >>>>>>> Also, I noticed when looking through the debug logs there are=
 the
> > > >>>>>>> occasional WARNING statements from a BUG it appears. They tra=
ce back
> > > >>>>>>> to the mac.c file inside the ath12k code. There should be som=
e in the
> > > >>>>>>> debug log that's attached. Let me know if I can do anything e=
lse.
> > > >>>>>>> Thanks,
> > > >>>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>> I have never seen this warning on my upstream setup...Not sure=
 if you
> > > >>>>>> have changed anything or using the correct code base.
> > > >>>>>>
> > > >>>>>> Jeff merged this patch-set into ath-202504021602. Can you try =
on this
> > > >>>>>> branch?
> > > >>>>>>
> > > >>>>>> git clone https://git.kernel.org/pub/scm/linux/kernel/git/ath/=
ath.git/
> > > >>>>>> git pull
> > > >>>>>> git reset --hard ath-202504021602
> > > >>>>>> compile and install...
> > > >>>>>>
> > > >>>>>> Also make sure that the firmware you used is from the same fol=
der, don't
> > > >>>>>> mix with other folders:
> > > >>>>>> linux-firmware/ath12k/WCN7850/hw2.0
> > > >>>>>>
> > > >>>>>> 1. rmmod/insmod(debug_mask=3D0xffff)
> > > >>>>>> 2. iw reg get
> > > >>>>>> 3. iw reg set US
> > > >>>>>> 4. iw xxx scan
> > > >>>>>> wait and collect logs.
> > > >>>>>>
> > > >>>>>> don't do anything else.
> > > >>>>>>
> > > >>>>>>
> > > >>>>>> Also, can you show me your AP configuration.
> > > >>>>>> If you have another 6 GHz AP, you can have a try(better differ=
ent brands).
> > > >>>>>>
> > > >>>>
> > > >>>> Thanks for testing.
> > > >>>>
> > > >>>> Could you share your AP configuration?
> > > >>>>
> > > >>>>
> > > >>>>>>
> > > >>>>>> If you have sniffer, could please capture packets during testi=
ng?
> > > >>>>
> > > >>>>
> > > >>>> Can you capture packets during the testing? I need to check prob=
e req
> > > >>>> and probe resp.
> > > >>>>
> > > >>>>>>
> > > >>>>>> Thanks!
> > > >>>>>>
> > > >>>>>>> -Walt
> > > >>>>>>
> > > >>>>> OK, I cloned and built the kernel based on your instructions in=
 your
> > > >>>>> last email. Originally, the result was identical to my last ema=
il,
> > > >>>>> including the WARNINGS. The .config I use is configured for a f=
ully RT
> > > >>>>> PREEMPT kernel, which I wondered if that was why I was receivin=
g the
> > > >>>>> WARNING. So I configured it as a Low Latency PREEMPT Desktop wi=
thout
> > > >>>>> the RT_PREEMPT and that eliminated the WARNING. However, still =
no 6Ghz
> > > >>>>> networks. The firmware I'm using is straight from kernel.org GI=
T and I
> > > >>>>> do a 'make install; make dedup' to install it. I believe it sho=
uld be
> > > >>>>> good. Attached is the latest log file.
> > > >>>>>
> > > >>>>> -Walt
> > > >>>>
> > > >>
> > > >
> > > >
> > > > Sorry for the top-post earlier. I can't figure out how to capture t=
he
> > > > wireless packets as my chip/driver combo doesn't support monitor mo=
de.
> > >
> > > Your AP also cannot capture wireless packets?
> > > log in AP by usbserial or ssh.
> > > Try to enter command line. use iw command to create monitor interface=
.
> > > Then use tcpdump to capture packets.
> > >
> > > > I've attached a tarball that contains the trace data and additional
> > > > firmware logs from the kernel.log file. Anything else you need, jus=
t
> > > > ask. Thanks for your help,
> > >
> > >
> > > Your AP mac address?
> > > Need it to help check the fw log.
> > >
> > >
> > > >
> > > > -Walt
> > >
> >
> > Sorry, the AP doesn't have tcpdump available on it. Also, this is a
> > mesh setup with 3 nodes total. The main AP and 2 mesh nodes. I'm
> > within 10 feet of one of the nodes and it's MAC for the wireless 6ghz
> > network is: 10:7C:61:6F:2A:CA
> >
> > -Walt
>
> The other 2 node 6ghz mac addresses are:
> 10:7C:61:6F:1F:11   - Router
> 10:7C:61:6F:32:92   - Node
>
> The first MAC address I gave you earlier was a node located
> approximately 5 feet from where the laptop is.
>
> -Walt

Well, I'm running into a brick wall it seems trying to get 6Ghz
enabled on this. I tried the ath-next-20250418 tag just now and still
don't see or connect to my 6Ghz network. I applied the patches in:
https://lore.kernel.org/linux-wireless/20250418-ath12k-6g-lp-vlp-v1-0-c869c=
86cad60@quicinc.com/T/#t

hoping that would help, but alas, no 6Ghz networks. I see that MLO and
other nice fixes are coming in 6.16, but without 6Ghz, they'll do me
no good. I'm really wondering if it's a firmware issue that excludes
my chip or something. Again, anything I can do to help, let me know.
Thanks,

-Walt


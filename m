Return-Path: <linux-wireless+bounces-21568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8462BA8AA0F
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 23:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD80F189EA18
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D7C257429;
	Tue, 15 Apr 2025 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf0hu0WX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1A23370C
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752255; cv=none; b=Gnt7gt0jOliau+Jw/UqqjpOtu7zbU6VyOqiDfOtTJmgQnBzEh6jcx/zsfXd9luPugDlWH1EoZfP6aeg94jbcz8CxPAOfThtXiABibGo4mNjJZ9pQSF4Y+op7Y66kc17oQUD+vunCxQTN+9d52+7+/9Fr2eSR3LPktrCh5Px3VL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752255; c=relaxed/simple;
	bh=cg/R33/c1Er8cQCoRNCBW5Mi76i1kYVK+vazM+Jj4LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPM8NtuenlX3wcBtCLdj8Fouu6adhzkdFkeBKDaqx8OXe7Mxs44Qx5haiBlF+R195K+UWTB/Yy7EhnO8bGvEp26DXH0WwQhPZGa3HMmOIWRqUuChgM4s0DNjgYW4vqVdS226cxmKvq0TddYkGvjJJq1X7Yj2tlLSB269xbR3XRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf0hu0WX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so3915995f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744752251; x=1745357051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CXbOtSbMgJkE7dP2Dq4m15xQdFII7zc+JyAszjGgak=;
        b=Mf0hu0WX/wA1/7pc2q7SwEG5JcWvvNy3DtQ/BNhVOVGTVOL/yNcbeiUhvN+H8/GIIO
         oFP9lwZet9IWrBbOtk0NIem6jp0iDRYQMboM1Vp58YWsho4DZZGSTYKYQIqLB9KmiybI
         SFx5AuGuLT2ea0s56EGZbE1e8nfOOT5jUBousd5F523TSc0MZew8ANf91yUQ1XBnJTak
         zg9zVi1BuYYtU2g3DJcrONNkJPQSX3k5R/erK71NmrwkpjNOowAWuW8pPwKsBRRLhe3t
         lnrCbgVDBa8SeDuwFX/g1soOB4AuKo5nDWSL7HSbpvZ/c3ksrrBxpwNz5L3DS22NVwaR
         YpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744752251; x=1745357051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CXbOtSbMgJkE7dP2Dq4m15xQdFII7zc+JyAszjGgak=;
        b=bw7b+cucvMfUC1QU03HlwZfMw0vflw5KAmCy1HLgA0SZLw6tbllOhkZZ3/xppVIRaL
         9wk/KMCec9Oi7l1S3lFA169rifyp/DU27qoveCbZBV14w5OKvIzhWpttlQUYKBlUbOvv
         oKLFTnRngg25Me753u1XWElGHI089WJ1bMaPCC1ExIMrFMMOTlLeq+Luo/iBVznOZ7Aw
         PXLbSesNzfq9Ntio1+eBnXy4+s54JxnkFjYfcXzj3649xVzn/l5nd48ZypOHF+7UKytE
         dBRsw870i3yQdI5GbWPPnhidkispFkgyoD0/fRZnWUl68kVPi8rvwZXNrYDvDO+P728a
         lgkw==
X-Forwarded-Encrypted: i=1; AJvYcCXGtrPUNQsoQM5FMhiV9rofpS9aC1sjiNyTn2eDzp+DIBh6y51d/jVgUXA0wr7cFzyU90HUpDIeYbU1XqHA6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq8nX1LKiabaRSdW7FDtNij9ZrMLgHtRgykiPchJ6t0DYtGa3T
	G0rhKkH3+9S29l//LOYTB95IpfQVz0029HObJ+Mav7MqCbjDJpI8AO1NAGD5Uhh0JYakNsfQrI7
	HcJK7qf6MuR1jJjSAYQ1mhL8YvGw=
X-Gm-Gg: ASbGncvNyZENat4oiARNmGoscRZFwL5nSQyvowSCqHyeqBUZVRoXpozcccSFirEwmdm
	cmTwwi2Jp7cd1ft1y4eppuTKkAGV1YQSo3Fn0YbmU0eZUYkUO7XVEkmDITYdygTinMTMAMAR8Lp
	Npe+6rJ1eXcCzDSUgMtDQu
X-Google-Smtp-Source: AGHT+IGjNItEav3xtYgAA6hnTJ1+2SP9QtjGOx+o/ja810ruiy66xTePEDuh26WCCVlNDc4RdAym6tUhkAUKPX/gmoM=
X-Received: by 2002:a5d:59a2:0:b0:39c:310a:f87e with SMTP id
 ffacd0b85a97d-39ee2737483mr701606f8f.16.1744752250422; Tue, 15 Apr 2025
 14:24:10 -0700 (PDT)
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
In-Reply-To: <CAMb39_nHO_TbHPQawdLVY8nt3yt4wDuEHyEuzMa-p5Ab1n94sA@mail.gmail.com>
From: Walt Holman <waltholman09@gmail.com>
Date: Tue, 15 Apr 2025 16:23:59 -0500
X-Gm-Features: ATxdqUGKqHp8G5OSVPp3xgUB9CUBAzarjjF-3Or8Fz0EDZz0I970buBDWXOaCRk
Message-ID: <CAMb39_nQ-uyKAqCz1HEUDt5qjszbhzf3oikVcvzHcVwt4_qt=A@mail.gmail.com>
Subject: Re: ath12k: No 6GHz Wireless found
To: Kang Yang <kang.yang@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:32=E2=80=AFAM Walt Holman <waltholman09@gmail.co=
m> wrote:
>
> On Thu, Apr 10, 2025 at 3:26=E2=80=AFAM Kang Yang <kang.yang@oss.qualcomm=
.com> wrote:
> >
> >
> >
> > On 4/10/2025 3:37 AM, Walt Holman wrote:
> > > On Tue, Apr 8, 2025 at 4:17=E2=80=AFAM Kang Yang <quic_kangyang@quici=
nc.com> wrote:
> > >>
> > >>
> > >>
> > >> On 4/8/2025 1:49 AM, Walt Holman wrote:
> > >>> Attached is a small packet capture where I did an 'iw wlp99s0 scan'
> > >>> and also deactivated and reactivated wireless while the scan was
> > >>> ongoing. Hopefully there's something interesting for you in there.
> > >>> Also, I've take 3 screenshots showing the configs of the wireless A=
P
> > >>> for the 6ghz network. The first screen is just the definition of th=
e
> > >>> network. No advanced settings are used. The 2nd screen shows the
> > >>> channels and radio enabled. The 3rd screen has the advanced
> > >>> (professional) settings for the network. I believe I changed 'Agile
> > >>> Multiband' to enabled, but other settings are their defaults. Hope
> > >>> some of this helps. Let me know if you need anything else. Thanks,
> > >>>
> > >>
> > >> Your packets are Ethernet packets. I need wireless packets.
> > >>
> > >>
> > >> Not sure if you know how to add a seperate monitor interface to capt=
ure
> > >> 6 G channels' packet on your AP(you can google for specific command)=
.
> > >>
> > >>
> > >> Also, please capture firmware log:
> > >>
> > >> 1. sudo apt install trace-cmd
> > >> 2. sudo trace-cmd record -e ath12k_wmi_diag
> > >> 3. run test
> > >> 4. "ctrl c" to stop recording:
> > >> Hit Ctrl^C to stop recording
> > >> ^CCPU0 data recorded at offset=3D0xdf5000
> > >>       2605056 bytes in size
> > >> Then share the trace.dat to us.
> > >>
> > >> So you need to:
> > >> 1. try to capture wireless packets.
> > >> 2. capture firmware log(trade.data).
> > >> 3. save kernel/wpa_supplicant/iw logs.
> > >>
> > >>
> > >>
> > >>
> > >>
> > >>> -Walt
> > >>>
> > >>> On Sun, Apr 6, 2025 at 8:58=E2=80=AFPM Kang Yang <quic_kangyang@qui=
cinc.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 4/4/2025 12:04 AM, Walt Holman wrote:
> > >>>>> On Thu, Apr 3, 2025 at 3:20=E2=80=AFAM Kang Yang <quic_kangyang@q=
uicinc.com> wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> On 4/3/2025 1:48 AM, Walt Holman wrote:
> > >>>>>>> On Tue, Apr 1, 2025 at 9:48=E2=80=AFPM Kang Yang <quic_kangyang=
@quicinc.com> wrote:
> > >>>>>>
> > >>>>>>>>
> > >>>>>>>> Test on 6.14.0-rc5-wt-ath+, with the firmware you used.
> > >>>>>>>> I can get 6 GHz AP and connect to it.
> > >>>>>>>>
> > >>>>>>>> ath12k_pci 0000:03:00.0: fw_version 0x100301e1 fw_build_timest=
amp
> > >>>>>>>> 2023-12-06 04:05 fw_build_id
> > >>>>>>>> QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.=
0_V2.0_SILICONZ-3
> > >>>>>>>>
> > >>>>>>>> yk@yk-Mayan:~$ sudo iw wls1 scan | tee iw_scan.log:
> > >>>>>>>> BSS 62:03:7f:12:64:64(on wls1) -- associated
> > >>>>>>>>              TSF: 606308271476 usec (7d, 00:25:08)
> > >>>>>>>>              freq: 6275
> > >>>>>>>>              beacon interval: 100 TUs
> > >>>>>>>>              capability: ESS Privacy SpectrumMgmt ShortSlotTim=
e (0x0511)
> > >>>>>>>>              signal: -17.00 dBm
> > >>>>>>>>              last seen: 52 ms ago
> > >>>>>>>>              Information elements from Probe Response frame:
> > >>>>>>>>              SSID: MLO-KANG-6G
> > >>>>>>>> and other 6 GHz APs:
> > >>>>>>>>             SSID: 6G-gxia
> > >>>>>>>>             SSID: NETGEAR97-6G
> > >>>>>>>>             =E2=80=A6=E2=80=A6
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> kernel log:
> > >>>>>>>> [88158.033218] wls1: Inserted STA 62:03:7f:12:64:64
> > >>>>>>>> [88158.033232] wls1: authenticate with 62:03:7f:12:64:64 (loca=
l
> > >>>>>>>> address=3D00:03:7f:37:12:54)
> > >>>>>>>> [88158.033242] wls1: send auth to 62:03:7f:12:64:64 (try 1/3)
> > >>>>>>>> [88158.041895] wls1: authenticated
> > >>>>>>>> [88158.041914] wls1: moving STA 62:03:7f:12:64:64 to state 2
> > >>>>>>>> [88158.044291] wls1: determined local STA to be EHT, BW limite=
d to 320 MHz
> > >>>>>>>> [88158.045719] wls1: associate with 62:03:7f:12:64:64 (try 1/3=
)
> > >>>>>>>> [88158.067045] wls1: RX AssocResp from 62:03:7f:12:64:64 (capa=
b=3D0x511
> > >>>>>>>> status=3D0 aid=3D4)
> > >>>>>>>> [88158.089090] wls1: associated
> > >>>>>>>>
> > >>>>>>>> I can even connect to it by Ubuntu GUI.
> > >>>>>>>>
> > >>>>>>>> Can you update to 6.14.0-rc5-wt-ath+ and have a retry? Also pl=
ease make
> > >>>>>>>> sure that your wpa_supplicant/iw support 6 GHz(or directly upd=
ate to the
> > >>>>>>>> latest version).
> > >>>>>>>>
> > >>>>>>>> If you still cannot find 6 GHz AP, you can set debug_mask to 0=
xffffffff
> > >>>>>>>> to get ath12k logs. Then give it to us.
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>> -Walt
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> OK, I retested with the wt-ath 033125 tagged build. This includ=
ed the
> > >>>>>>> patch the Jeff suggested I try, but the rest of the tree was cl=
ean.
> > >>>>>>> Still no 6ghz Wifi. I'm attaching a log file of the boot and fi=
rst few
> > >>>>>>> seconds with the debug mask turned on. I noticed that if I rmmo=
d the
> > >>>>>>> module and then modprobe it, it complains about not finding
> > >>>>>>> firmware-2.bin, however, I thought that was only for the qcn ba=
sed
> > >>>>>>> chip? The HW info from dmesg looks like this:
> > >>>>>>>
> > >>>>>>
> > >>>>>> I cannot find this tag...
> > >>>>>>
> > >>>>>>
> > >>>>>>     From the log, the 6 GHz channel should work. When scan is tr=
iggered, FW
> > >>>>>> shall send probe req on these channels. If AP send probe resp, s=
tation
> > >>>>>> shall find the AP.
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>> [    6.070282] ath12k_pci 0000:63:00.0: BAR 0 [mem
> > >>>>>>> 0xdd800000-0xdd9fffff 64bit]: assigned
> > >>>>>>> [    6.070310] ath12k_pci 0000:63:00.0: enabling device (0000 -=
> 0002)
> > >>>>>>> [    6.071249] ath12k_pci 0000:63:00.0: MSI vectors: 16
> > >>>>>>> [    6.071254] ath12k_pci 0000:63:00.0: Hardware name: wcn7850 =
hw2.0
> > >>>>>>> [    6.596331] ath12k_pci 0000:63:00.0: qmi dma allocation fail=
ed
> > >>>>>>> (7077888 B type 1), will try later with sma
> > >>>>>>> ll size
> > >>>>>>> [    6.604041] ath12k_pci 0000:63:00.0: chip_id 0x2 chip_family=
 0x4
> > >>>>>>> board_id 0xff soc_id 0x40170200
> > >>>>>>> [    6.604044] ath12k_pci 0000:63:00.0: fw_version 0x100301e1
> > >>>>>>> fw_build_timestamp 2023-12-06 04:05 fw_build_id
> > >>>>>>> QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0=
_V2.0_SILICONZ-
> > >>>>>>>
> > >>>>>>> Also, I noticed when looking through the debug logs there are t=
he
> > >>>>>>> occasional WARNING statements from a BUG it appears. They trace=
 back
> > >>>>>>> to the mac.c file inside the ath12k code. There should be some =
in the
> > >>>>>>> debug log that's attached. Let me know if I can do anything els=
e.
> > >>>>>>> Thanks,
> > >>>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> I have never seen this warning on my upstream setup...Not sure i=
f you
> > >>>>>> have changed anything or using the correct code base.
> > >>>>>>
> > >>>>>> Jeff merged this patch-set into ath-202504021602. Can you try on=
 this
> > >>>>>> branch?
> > >>>>>>
> > >>>>>> git clone https://git.kernel.org/pub/scm/linux/kernel/git/ath/at=
h.git/
> > >>>>>> git pull
> > >>>>>> git reset --hard ath-202504021602
> > >>>>>> compile and install...
> > >>>>>>
> > >>>>>> Also make sure that the firmware you used is from the same folde=
r, don't
> > >>>>>> mix with other folders:
> > >>>>>> linux-firmware/ath12k/WCN7850/hw2.0
> > >>>>>>
> > >>>>>> 1. rmmod/insmod(debug_mask=3D0xffff)
> > >>>>>> 2. iw reg get
> > >>>>>> 3. iw reg set US
> > >>>>>> 4. iw xxx scan
> > >>>>>> wait and collect logs.
> > >>>>>>
> > >>>>>> don't do anything else.
> > >>>>>>
> > >>>>>>
> > >>>>>> Also, can you show me your AP configuration.
> > >>>>>> If you have another 6 GHz AP, you can have a try(better differen=
t brands).
> > >>>>>>
> > >>>>
> > >>>> Thanks for testing.
> > >>>>
> > >>>> Could you share your AP configuration?
> > >>>>
> > >>>>
> > >>>>>>
> > >>>>>> If you have sniffer, could please capture packets during testing=
?
> > >>>>
> > >>>>
> > >>>> Can you capture packets during the testing? I need to check probe =
req
> > >>>> and probe resp.
> > >>>>
> > >>>>>>
> > >>>>>> Thanks!
> > >>>>>>
> > >>>>>>> -Walt
> > >>>>>>
> > >>>>> OK, I cloned and built the kernel based on your instructions in y=
our
> > >>>>> last email. Originally, the result was identical to my last email=
,
> > >>>>> including the WARNINGS. The .config I use is configured for a ful=
ly RT
> > >>>>> PREEMPT kernel, which I wondered if that was why I was receiving =
the
> > >>>>> WARNING. So I configured it as a Low Latency PREEMPT Desktop with=
out
> > >>>>> the RT_PREEMPT and that eliminated the WARNING. However, still no=
 6Ghz
> > >>>>> networks. The firmware I'm using is straight from kernel.org GIT =
and I
> > >>>>> do a 'make install; make dedup' to install it. I believe it shoul=
d be
> > >>>>> good. Attached is the latest log file.
> > >>>>>
> > >>>>> -Walt
> > >>>>
> > >>
> > >
> > >
> > > Sorry for the top-post earlier. I can't figure out how to capture the
> > > wireless packets as my chip/driver combo doesn't support monitor mode=
.
> >
> > Your AP also cannot capture wireless packets?
> > log in AP by usbserial or ssh.
> > Try to enter command line. use iw command to create monitor interface.
> > Then use tcpdump to capture packets.
> >
> > > I've attached a tarball that contains the trace data and additional
> > > firmware logs from the kernel.log file. Anything else you need, just
> > > ask. Thanks for your help,
> >
> >
> > Your AP mac address?
> > Need it to help check the fw log.
> >
> >
> > >
> > > -Walt
> >
>
> Sorry, the AP doesn't have tcpdump available on it. Also, this is a
> mesh setup with 3 nodes total. The main AP and 2 mesh nodes. I'm
> within 10 feet of one of the nodes and it's MAC for the wireless 6ghz
> network is: 10:7C:61:6F:2A:CA
>
> -Walt

The other 2 node 6ghz mac addresses are:
10:7C:61:6F:1F:11   - Router
10:7C:61:6F:32:92   - Node

The first MAC address I gave you earlier was a node located
approximately 5 feet from where the laptop is.

-Walt


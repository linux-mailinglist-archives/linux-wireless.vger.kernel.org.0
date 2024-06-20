Return-Path: <linux-wireless+bounces-9332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E48791110A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22A82819C7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674C31BBBC3;
	Thu, 20 Jun 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E44k7ZXE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C81BB6A6
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907968; cv=none; b=LM+CpPolIrP9FbnNvwyP31ZBl4SmDlCq06UAgQL0wSiXmHx3VcdpDnl267GYzAw5A2aknIXGe6JxzjfDIrzSmz49JYq3ElwKyk2rTWiByAs+XPqxmlEnNrhEto6N0LP96Wu6NP6UjE9akjz/oY3mE64Jgii5Cc5pyy+2b4LJlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907968; c=relaxed/simple;
	bh=B4yGC9Yo+91vr+2sAb7apEem1V3ZTgx0STaNt+OoviU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvyQkszhdbFTCc2vJIcgS8zZfYeHaEJ6EykcjzGSzPLZffnjijs6D/ufScQshG+XLnNCLQ6c6ROMw/jfjJg9yOtJ/LmS5ij+JMrWG2QKUtn0KsbeBlYP2s6z5HDmWtPLQJpfPujQqNHz0yn+AMdps9ObH7JCrED5cqrqyoDl0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E44k7ZXE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c7b14bb4a5so927900a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718907963; x=1719512763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcvtmEinxfd4EoQ0+ew3IlE1NCxSiARbhqYRtFV5zQc=;
        b=E44k7ZXEY1KPZ047d7GI+Io4GTEQvKjWiSoIySd9yOATi2xYDa0Apg8R1N2DsfzC7T
         6Cs9nC1miKzOWGh5BUDIOYRAkp9/aE1KU96qAKZzrbWgeVWUEkeUK7OC+K5TT7mXSZbd
         me8bJP0te+jl7L1LXKLdEZz4djRsKCXnP3jyk/aa3nMuHSXah4TAWOAME7ox8jel+8cC
         I8yQ593WQ65b67rrKJbPXXcM+9DsuWrtJXCbgp2L9xsVJH8Ivlmhuj5bATjqtYXbgDys
         WQOI7/uE2icncroNATHw6HUdSp7DE6U6DsawlNH/H9Vr8chCVBjjQ7AFSFwjgzfKqiLF
         jfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907963; x=1719512763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcvtmEinxfd4EoQ0+ew3IlE1NCxSiARbhqYRtFV5zQc=;
        b=s95WKW1xXpeka1MRxrLrFpS9DXQAucuErtk+Nvd3i+t+Zf+wP4Y7cl8f0Zis+fcKfo
         CZ+CsAYIpkgeIbCL5gG+x6VCtZhM4dy9lBwkwpofuxkxDgrdzI9NYwZTvxXn2HuwJFcG
         Whpa9TOv8710XtLhYKQLNM37qg8ksHkjbyh0Lqu6UWMVx/kHQAuxAqym6pdPtrxUuFTp
         8dIwoy0h3i01FiyGgrsvpp6z/ePqqXcq4eX8PfuiK8towUy5u0oABSem0IK8Z+VoOcHN
         8nGw2KvErGYRvmjCSl+CLEYk4/sGbJQ6JKANO5kDwzPDAzSSTx2wBxTZyXWK57f2MvYI
         Z9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUC/qDz8IDM/u/tIYPc2WcTip/a3jF5hnzh+n8rSEqc6BTMBoP8eBf9PXzz9Px5/v1j1YJdcS0g1uP3OPyaeimEVDk+2MI4F/7GkTJhvGs=
X-Gm-Message-State: AOJu0Yxu2qJJkadS8o72ZLqu99LN2TZa4zMcQx8rtjTUoyuDeMObyiWQ
	6y4ofT0S0WPJsZfiXWuJFDrxAsgxfkhDMqpobPVhOjGY0UHUe1kdk4FYaeQROZCDnCypDD8Q09k
	JzdBmvdNBpl6Erq8mmiDdDTCLXEs=
X-Google-Smtp-Source: AGHT+IFMlBwTmuciK0ZSgCiSQTQV9PWuquY5seegVmy7r5pn0RKaQFGE1vbkCd3OmkJg0uHn1+x1+rbNUv8XKXZCLlc=
X-Received: by 2002:a17:90b:23c9:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2c7b3ba80c3mr9430913a91.15.1718907962619; Thu, 20 Jun 2024
 11:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
 <CALeDE9O7DCPhoxdMyHmYFOjwdkPRepiaaC92QorzSTXCduZ+xQ@mail.gmail.com>
 <CAGRGNgWH9U3XeatXA9xpkLz76COuL1xjYcfXQYLTGKBxvy=M-A@mail.gmail.com>
 <CALeDE9M78so=roEFion9GGo4tV7c+M885=ZNZgi9zKyBur+iMQ@mail.gmail.com>
 <190355aedf0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NBO=tTBp9GX=S9C4REbT-Gx634n66+7JERcWbe-KXt-g@mail.gmail.com> <190369b8c10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <190369b8c10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 20 Jun 2024 13:25:51 -0500
Message-ID: <CAG17S_NHC7EqUMtc58eSY9Yoq4K0mvp=C1rcP8PTRzajXW3Csg@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Julian Calaby <julian.calaby@gmail.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:04=E2=80=AFPM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On June 20, 2024 5:44:30 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > On Thu, Jun 20, 2024 at 6:14=E2=80=AFAM Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On June 20, 2024 11:53:12 AM Peter Robinson <pbrobinson@gmail.com> wro=
te:
> >>
> >>> On Thu, 20 Jun 2024 at 10:46, Julian Calaby <julian.calaby@gmail.com>=
 wrote:
> >>>>
> >>>> Hi Peter,
> >>>>
> >>>> On Thu, Jun 20, 2024 at 7:19=E2=80=AFPM Peter Robinson <pbrobinson@g=
mail.com> wrote:
> >>>>>
> >>>>> Hi Arend,
> >>>>>
> >>>>>> After being asked about support for WPA3 for BCM43224 chipset it
> >>>>>> was found that all it takes is setting the MFP_CAPABLE flag and
> >>>>>> mac80211 will take care of all that is needed [1].
> >>>>>
> >>>>> Testing this on a Raspberry Pi 4 [1] against a UniFi U6Pro AP I can=
't
> >>>>> connect to my WPA3 only SSID, it works fine with the SSID that's
> >>>>> WPA2/WPA3 on the same AP. It doesn't connect and I get a whole lot =
of
> >>>>> the following errors while it tries:
> >>>>>
> >>>>> [  155.988865] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fai=
l,
> >>>>> reason -52
> >>>>> [  156.100906] brcmfmac: brcmf_set_channel: set chanspec 0xd034 fai=
l,
> >>>>> reason -52
> >>>>> [  156.108597] brcmfmac: brcmf_set_channel: set chanspec 0xd038 fai=
l,
> >>>>> reason -52
> >>>>> [  156.116317] brcmfmac: brcmf_set_channel: set chanspec 0xd03c fai=
l,
> >>>>> reason -52
> >>>>
> >>>> The Raspberry Pis' WiFi chipsets use the brcmfmac driver and this is=
 a
> >>>> patch to the brcmsmac driver. This driver is for older and simpler
> >>>> WiFi chipsets than the ones on the Raspberry Pis.
> >>>
> >>> Right you are, completely missed that :)
> >>
> >> The devil is in the details ;-) Good that you tested. Maybe we can loo=
k
> >> into the WPA3-only problem. Are you using wpa_supplicant? Can you shar=
e
> >> supplicant log file and kernel log with brcmfmac debug modparam set to=
 0x1416.
> >>
> >> Regards,
> >> Arend
> >
> > The RPis and the brcmfmac cards.
> > The current RPiOS for 32 bit and 64 bit OS have firmware which loads
> > on the 5Ghz capable Pis (3b+, 4, 5, 02W) which advertise WPA3
> > capability (this is a Pi5, but others are similar) This firmware is
> > from 2021:
> > # dmesg | grep brcmfmac
> > [    2.112735] brcmfmac: F1 signature read @0x18000000=3D0x15264345
> > [    2.114202] brcmfmac: brcmf_fw_alloc_request: using
> > brcm/brcmfmac43455-sdio for chip BCM4345/6
> > [    2.117274] usbcore: registered new interface driver brcmfmac
> > [    2.335211] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> > available (err=3D-2)
> > [    2.335581] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> > wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
> > 01-996384e2
> >
> > # iw list
> > Wiphy phy0
> > ...
> >    Supported extended features:
> >        * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
> >        * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in statio=
n mode
> >        * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in stat=
ion mode
> >        * [ DFS_OFFLOAD ]: DFS offload
> >        * [ SAE_OFFLOAD ]: SAE offload support
> >        * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
> >        * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
> >
> > # uname -a
> > Linux pi5 6.6.31+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.31-1+rpt1
> > (2024-05-29) aarch64 GNU/Linux
> >
> > I am pretty sure I am fully up to date.
> >
> > I set up hostapd running an WPA3 SAE config on my desktop with an
> > intel card and can connect to it from my phone.
> > I cannot connect to it from the Pi5:
>
> So let's dive in
>
> > I tried using a config file and connecting with wpa_supplicant and it d=
id not:
> > # cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> > ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> > update_config=3D1
> > network=3D{
> >  ssid=3D"deskSAE"
> >  sae_password=3D"secret123"
> >  proto=3DRSN
> >  key_mgmt=3DSAE
> >  pairwise=3DCCMP
> >  ieee80211w=3D2
> > }
>
> That looks sane to me.
>
> > # ifconfig wlan0 up
> > root@pi5(rw):~# iwlist wlan0 scan | grep deskSAE
> >                    ESSID:"deskSAE"
> > # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.c=
onf
> > Successfully initialized wpa_supplicant
> > wlan0: WPA: Failed to select authenticated key management type
> > wlan0: WPA: Failed to set WPA key management and encryption suites
> > (never returns command prompt)
>
> The supplicant remains running in the foreground so that is normal. Could
> you retry with -ddt on the command line. Also having brcmfmac loaded with
> debug=3D0x1416 while testing. Finally, can you share the hostapd.conf fil=
e?
>
> Regards,
> Arend
>
> >
> > I tried using wpa_cli as well and it also fails:
> > <3>CTRL-EVENT-NETWORK-ADDED 1
> > <3>CTRL-EVENT-SCAN-STARTED
> > <3>CTRL-EVENT-SCAN-RESULTS
> > <3>WPS-AP-AVAILABLE  "deskS
> > <4>Failed to initiate sched scan
> > <3>CTRL-EVENT-NETWORK-NOT-FOUND
> >> set_network 0 ssid "deskSAE"
> > OK
> >> set_network - key_mgmt SAE
> > OK
> >> set_network 0 ieee80211w 2
> > OK
> >> set_network 0 sae_password "secret123"
> > OK
> > <3>CTRL-EVENT-SCAN-STARTED
> > <3>CTRL-EVENT-SCAN-RESULTS
> > <3>WPS-AP-AVAILABLE
> > <4>Failed to initiate sched scan
> > <3>CTRL-EVENT-NETWORK-NOT-FOUND
> > <3>CTRL-EVENT-SCAN-STARTED
> >> enable 0
> > OK
> > <3>CTRL-EVENT-SCAN-RESULTS
> > <3>WPS-AP-AVAILABLE
> > <4>Failed to initiate sched scan
> > <3>CTRL-EVENT-NETWORK-NOT-FOUND
> > <4>WPA: Failed to select authenticated key management type
> > <4>WPA: Failed to set WPA key management and encryption suites
> > <3>CTRL-EVENT-SCAN-STARTED
> > <3>CTRL-EVENT-SCAN-RESULTS
> > <3>WPS-AP-AVAILABLE
> > <4>WPA: Failed to select authenticated key management type
> > <4>WPA: Failed to set WPA key management and encryption suites
> > <3>CTRL-EVENT-SCAN-STARTED
> >
> > Would love it if there were a way to get wpa3 to work with the
> > brcmfmac cards on RPI.
> >
> > Keith
How do I load the debug parameter?

the other stuff you asked is here:

The hostapd on the desktop:
$ cat /etc/hostapd/hostapd.conf
# interface and driver
interface=3Dap0
driver=3Dnl80211

# WIFI-Config
ssid=3DdeskSAE
channel=3D1
hw_mode=3Dg

wpa=3D2
wpa_key_mgmt=3DSAE
wpa_pairwise=3DCCMP
sae_password=3Dsecret123
sae_groups=3D19
ieee80211w=3D2
sae_pwe=3D0

The response
# wpa_supplicant -ddt -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.=
conf
1718907727.479763: wpa_supplicant v2.10
1718907727.480131: random: getrandom() support available
1718907727.480155: Successfully initialized wpa_supplicant
1718907727.480167: Initializing interface 'wlan0' conf
'/etc/wpa_supplicant/wpa_supplicant-wlan0.conf' driver 'default'
ctrl_interface 'N/A' bridge 'N/A'
1718907727.480179: Configuration file
'/etc/wpa_supplicant/wpa_supplicant-wlan0.conf' ->
'/etc/wpa_supplicant/wpa_supplicant-wlan0.conf'
1718907727.480183: Reading configuration file
'/etc/wpa_supplicant/wpa_supplicant-wlan0.conf'
1718907727.480213: ctrl_interface=3D'DIR=3D/run/wpa_supplicant GROUP=3Dnetd=
ev'
1718907727.480218: update_config=3D1
1718907727.480222: Line: 3 - start of a new network block
1718907727.480227: ssid - hexdump_ascii(len=3D7):
     64 65 73 6b 53 41 45                              deskSAE
1718907727.480243: sae_password - hexdump_ascii(len=3D9): [REMOVED]
1718907727.480246: proto: 0x2
1718907727.480249: key_mgmt: 0x400
1718907727.480260: pairwise: 0x10
1718907727.480264: ieee80211w=3D2 (0x2)
1718907727.480271: Priority group 0
1718907727.480273:    id=3D0 ssid=3D'deskSAE'
1718907727.484146: nl80211: Using driver-based roaming
1718907727.484182: nl80211: Supported cipher 00-0f-ac:1
1718907727.484198: nl80211: Supported cipher 00-0f-ac:5
1718907727.484204: nl80211: Supported cipher 00-0f-ac:2
1718907727.484209: nl80211: Supported cipher 00-0f-ac:4
1718907727.484213: nl80211: Supported cipher 00-0f-ac:6
1718907727.484263: nl80211: Using driver-based off-channel TX
1718907727.484278: nl80211: Supported vendor command: vendor_id=3D0x1018 su=
bcmd=3D1
1718907727.484294: nl80211: Use separate P2P group interface (driver
advertised support)
1718907727.484301: nl80211: Enable multi-channel concurrent (driver
advertised support)
1718907727.484311: nl80211: use P2P_DEVICE support
1718907727.484316: nl80211: key_mgmt=3D0xd0f enc=3D0x10f auth=3D0x7
flags=3D0x20000003804facc rrm_flags=3D0x0 probe_resp_offloads=3D0x0
max_stations=3D0 max_remain_on_chan=3D5000 max_scan_ssids=3D10
1718907727.484375: nl80211: interface wlan0 in phy phy0
1718907727.484867: nl80211: Set mode ifindex 3 iftype 2 (STATION)
1718907727.484919: nl80211: Subscribe to mgmt frames with non-AP
handle 0x5556614a4310
1718907727.484935: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0104 multicast=3D=
0
1718907727.484967: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D040a multicast=3D=
0
1718907727.484981: nl80211: kernel reports: Match already configured
1718907727.484993: nl80211: Register frame command failed (type=3D208):
ret=3D-114 (Operation already in progress)
1718907727.485005: nl80211: Register frame match - hexdump(len=3D2): 04 0a
1718907727.485019: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D040b multicast=3D=
0
1718907727.485053: nl80211: kernel reports: Match already configured
1718907727.485077: nl80211: Register frame command failed (type=3D208):
ret=3D-114 (Operation already in progress)
1718907727.485088: nl80211: Register frame match - hexdump(len=3D2): 04 0b
1718907727.485228: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D040c multicast=3D=
0
1718907727.485256: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D040d multicast=3D=
0
1718907727.485301: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D090a multicast=3D=
0
1718907727.485323: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D090b multicast=3D=
0
1718907727.485336: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D090c multicast=3D=
0
1718907727.485349: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D090d multicast=3D=
0
1718907727.485365: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0409506f9a09
multicast=3D0
1718907727.485379: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D7f506f9a09
multicast=3D0
1718907727.485395: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0409506f9a1a
multicast=3D0
1718907727.485408: nl80211: kernel reports: Match already configured
1718907727.485417: nl80211: Register frame command failed (type=3D208):
ret=3D-114 (Operation already in progress)
1718907727.485424: nl80211: Register frame match - hexdump(len=3D6): 04
09 50 6f 9a 1a
1718907727.485430: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0800 multicast=3D=
0
1718907727.485466: nl80211: kernel reports: Match already configured
1718907727.485475: nl80211: Register frame command failed (type=3D208):
ret=3D-114 (Operation already in progress)
1718907727.485481: nl80211: Register frame match - hexdump(len=3D2): 08 00
1718907727.485487: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0801 multicast=3D=
0
1718907727.485498: nl80211: kernel reports: Match already configured
1718907727.485504: nl80211: Register frame command failed (type=3D208):
ret=3D-114 (Operation already in progress)
1718907727.485509: nl80211: Register frame match - hexdump(len=3D2): 08 01
1718907727.485515: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D12 multicast=3D0
1718907727.485527: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D06 multicast=3D0
1718907727.485540: nl80211: kernel reports: Match already configured
1718907727.485547: nl80211: Register frame command failed (type=3D208):
ret=3D-114 (Operation already in progress)
1718907727.485552: nl80211: Register frame match - hexdump(len=3D1): 06
1718907727.485557: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0a07 multicast=3D=
0
1718907727.485568: nl80211: kernel reports: Match already configured
1718907727.485574: nl80211: Register frame command failed (type=3D208):
ret=3D-114 (Operation already in progress)
1718907727.485593: nl80211: Register frame match - hexdump(len=3D2): 0a 07
1718907727.485600: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0a11 multicast=3D=
0
1718907727.485614: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0a0b multicast=3D=
0
1718907727.485628: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0a1a multicast=3D=
0
1718907727.485642: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D1101 multicast=3D=
0
1718907727.485657: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D1102 multicast=3D=
0
1718907727.485672: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0505 multicast=3D=
0
1718907727.485686: nl80211: kernel reports: Match already configured
1718907727.485694: nl80211: Register frame command failed (type=3D208):
ret=3D-114 (Operation already in progress)
1718907727.485699: nl80211: Register frame match - hexdump(len=3D2): 05 05
1718907727.485705: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D0500 multicast=3D=
0
1718907727.485717: nl80211: kernel reports: Match already configured
1718907727.485724: nl80211: Register frame command failed (type=3D208):
ret=3D-114 (Operation already in progress)
1718907727.485730: nl80211: Register frame match - hexdump(len=3D2): 05 00
1718907727.485737: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D1301 multicast=3D=
0
1718907727.485749: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D1305 multicast=3D=
0
1718907727.485762: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x5556614a4310 match=3D7e506f9a1a
multicast=3D0
1718907727.485794: nl80211: Failed to register Action frame processing
- ignore for now
1718907727.485919: rfkill: initial event: idx=3D1 type=3D1 op=3D0 soft=3D0 =
hard=3D0
1718907727.486194: netlink: Operstate: ifindex=3D3 linkmode=3D1
(userspace-control), operstate=3D5 (IF_OPER_DORMANT)
1718907727.486333: Add interface wlan0 to a new radio phy0
1718907727.486491: nl80211: Regulatory information - country=3DUS (DFS-FCC)
1718907727.486502: nl80211: 902-904 @ 2 MHz 30 mBm
1718907727.486509: nl80211: 904-920 @ 16 MHz 30 mBm
1718907727.486514: nl80211: 920-928 @ 8 MHz 30 mBm
1718907727.486519: nl80211: 2400-2472 @ 40 MHz 30 mBm
1718907727.486524: nl80211: 5150-5250 @ 80 MHz 23 mBm
1718907727.486538: nl80211: 5250-5350 @ 80 MHz 24 mBm (DFS)
1718907727.486548: nl80211: 5470-5730 @ 160 MHz 24 mBm (DFS)
1718907727.486554: nl80211: 5730-5850 @ 80 MHz 30 mBm
1718907727.486592: nl80211: 5850-5895 @ 40 MHz 27 mBm (no outdoor) (no IR)
1718907727.486599: nl80211: 5925-7125 @ 320 MHz 12 mBm (no outdoor) (no IR)
1718907727.486609: nl80211: 57240-71000 @ 2160 MHz 40 mBm
1718907727.486658: nl80211: Added 802.11b mode based on 802.11g information
1718907727.486669: nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467[DISABLED] 2472[DISABLED]
2484[DISABLED]
1718907727.486684: nl80211: Mode IEEE 802.11a: 5170 5180 5190 5200
5210 5220 5230 5240 5260[RADAR] 5280[RADAR] 5300[RADAR] 5320[RADAR]
5500[RADAR] 5520[RADAR] 5540[RADAR] 5560[RADAR] 5580[RADAR]
5600[RADAR] 5620[RADAR] 5640[RADAR] 5660[RADAR]
1718907727.486699: nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467[DISABLED] 2472[DISABLED]
2484[DISABLED]
1718907727.516742: wlan0: Own MAC address: d8:3a:dd:d2:ae:3c
1718907727.516807: wpa_driver_nl80211_set_key: ifindex=3D3 (wlan0) alg=3D0
addr=3D(nil) key_idx=3D0 set_tx=3D0 seq_len=3D0 key_len=3D0 key_flag=3D0x10
1718907727.516827: nl80211: DEL_KEY
1718907727.516865:    broadcast key
1718907727.516945: wpa_driver_nl80211_set_key: ifindex=3D3 (wlan0) alg=3D0
addr=3D(nil) key_idx=3D1 set_tx=3D0 seq_len=3D0 key_len=3D0 key_flag=3D0x10
1718907727.516957: nl80211: DEL_KEY
1718907727.516960:    broadcast key
1718907727.516974: wpa_driver_nl80211_set_key: ifindex=3D3 (wlan0) alg=3D0
addr=3D(nil) key_idx=3D2 set_tx=3D0 seq_len=3D0 key_len=3D0 key_flag=3D0x10
1718907727.516979: nl80211: DEL_KEY
1718907727.516981:    broadcast key
1718907727.516998: wpa_driver_nl80211_set_key: ifindex=3D3 (wlan0) alg=3D0
addr=3D(nil) key_idx=3D3 set_tx=3D0 seq_len=3D0 key_len=3D0 key_flag=3D0x10
1718907727.517003: nl80211: DEL_KEY
1718907727.517005:    broadcast key
1718907727.517016: wpa_driver_nl80211_set_key: ifindex=3D3 (wlan0) alg=3D0
addr=3D(nil) key_idx=3D4 set_tx=3D0 seq_len=3D0 key_len=3D0 key_flag=3D0x10
1718907727.517020: nl80211: DEL_KEY
1718907727.517024:    broadcast key
1718907727.517033: wpa_driver_nl80211_set_key: ifindex=3D3 (wlan0) alg=3D0
addr=3D(nil) key_idx=3D5 set_tx=3D0 seq_len=3D0 key_len=3D0 key_flag=3D0x10
1718907727.517036: nl80211: DEL_KEY
1718907727.517038:    broadcast key
1718907727.517046: wlan0: RSN: flushing PMKID list in the driver
1718907727.517049: nl80211: Flush PMKIDs
1718907727.552633: TDLS: TDLS operation not supported by driver
1718907727.552771: TDLS: Driver uses internal link setup
1718907727.552778: TDLS: Driver does not support TDLS channel switching
1718907727.555773: wlan0: WPS: UUID based on MAC address:
cc4476f0-3727-5645-ae42-9b9b5943d9ca
1718907727.560692: ENGINE: Loading builtin engines
1718907727.561972: ENGINE: Loading builtin engines
1718907727.562103: EAPOL: SUPP_PAE entering state DISCONNECTED
1718907727.562119: EAPOL: Supplicant port status: Unauthorized
1718907727.562135: nl80211: Skip set_supp_port(unauthorized) while not
associated
1718907727.562143: EAPOL: KEY_RX entering state NO_KEY_RECEIVE
1718907727.562150: EAPOL: SUPP_BE entering state INITIALIZE
1718907727.562164: EAP: EAP entering state DISABLED
1718907727.562263: Using existing control interface directory.
1718907727.563817: ctrl_interface_group=3D106 (from group name 'netdev')
1718907727.564153: MBO: Update non-preferred channels, non_pref_chan=3DN/A
1718907727.564234: wlan0: Added interface wlan0
1718907727.564251: wlan0: State: DISCONNECTED -> DISCONNECTED
1718907727.564422: nl80211: Set wlan0 operstate 0->0 (DORMANT)
1718907727.564461: netlink: Operstate: ifindex=3D3 linkmode=3D-1 (no
change), operstate=3D5 (IF_OPER_DORMANT)
1718907727.564669: nl80211: Create interface iftype 10 (P2P_DEVICE)
1718907727.570706: nl80211: New P2P Device interface p2p-dev-wlan0 (0x5) cr=
eated
1718907727.570800: Initializing interface 'p2p-dev-wlan0' conf
'/etc/wpa_supplicant/wpa_supplicant-wlan0.conf' driver 'nl80211'
ctrl_interface 'DIR=3D/run/wpa_supplicant GROUP=3Dnetdev' bridge 'N/A'
1718907727.570823: Configuration file
'/etc/wpa_supplicant/wpa_supplicant-wlan0.conf' ->
'/etc/wpa_supplicant/wpa_supplicant-wlan0.conf'
1718907727.570831: Reading configuration file
'/etc/wpa_supplicant/wpa_supplicant-wlan0.conf'
1718907727.570915: ctrl_interface=3D'DIR=3D/run/wpa_supplicant GROUP=3Dnetd=
ev'
1718907727.570939: update_config=3D1
1718907727.570948: Line: 3 - start of a new network block
1718907727.570980: ssid - hexdump_ascii(len=3D7):
     64 65 73 6b 53 41 45                              deskSAE
1718907727.571062: sae_password - hexdump_ascii(len=3D9): [REMOVED]
1718907727.571085: proto: 0x2
1718907727.571102: key_mgmt: 0x400
1718907727.571155: pairwise: 0x10
1718907727.571175: ieee80211w=3D2 (0x2)
1718907727.571224: Priority group 0
1718907727.571237:    id=3D0 ssid=3D'deskSAE'
1718907727.579439: nl80211: Using driver-based roaming
1718907727.579472: nl80211: Supported cipher 00-0f-ac:1
1718907727.579477: nl80211: Supported cipher 00-0f-ac:5
1718907727.579479: nl80211: Supported cipher 00-0f-ac:2
1718907727.579484: nl80211: Supported cipher 00-0f-ac:4
1718907727.579485: nl80211: Supported cipher 00-0f-ac:6
1718907727.579504: nl80211: Using driver-based off-channel TX
1718907727.579512: nl80211: Supported vendor command: vendor_id=3D0x1018 su=
bcmd=3D1
1718907727.579521: nl80211: Use separate P2P group interface (driver
advertised support)
1718907727.579523: nl80211: Enable multi-channel concurrent (driver
advertised support)
1718907727.579525: nl80211: use P2P_DEVICE support
1718907727.579527: nl80211: key_mgmt=3D0xd0f enc=3D0x10f auth=3D0x7
flags=3D0x20000003804facc rrm_flags=3D0x0 probe_resp_offloads=3D0x0
max_stations=3D0 max_remain_on_chan=3D5000 max_scan_ssids=3D10
1718907727.579532: nl80211: interface p2p-dev-wlan0 in phy phy0
1718907727.579615: nl80211: Set mode ifindex 0 iftype 10 (P2P_DEVICE)
1718907727.579639: nl80211: Failed to set interface 0 to mode 10: -22
(Invalid argument)
1718907727.579692: nl80211: Subscribe to mgmt frames with non-AP
handle 0x555661513f30
1718907727.579704: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0104 multicast=3D=
0
1718907727.579738: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D040a multicast=3D=
0
1718907727.579747: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D040b multicast=3D=
0
1718907727.579758: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D040c multicast=3D=
0
1718907727.579772: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D040d multicast=3D=
0
1718907727.579792: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D090a multicast=3D=
0
1718907727.579805: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D090b multicast=3D=
0
1718907727.579817: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D090c multicast=3D=
0
1718907727.579828: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D090d multicast=3D=
0
1718907727.579841: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0409506f9a09
multicast=3D0
1718907727.579852: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D7f506f9a09
multicast=3D0
1718907727.579862: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0409506f9a1a
multicast=3D0
1718907727.579889: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0800 multicast=3D=
0
1718907727.579902: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0801 multicast=3D=
0
1718907727.579924: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D12 multicast=3D0
1718907727.579937: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D06 multicast=3D0
1718907727.579950: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0a07 multicast=3D=
0
1718907727.579962: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0a11 multicast=3D=
0
1718907727.579984: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0a0b multicast=3D=
0
1718907727.580001: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0a1a multicast=3D=
0
1718907727.580016: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D1101 multicast=3D=
0
1718907727.580032: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D1102 multicast=3D=
0
1718907727.580053: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0505 multicast=3D=
0
1718907727.580189: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D0500 multicast=3D=
0
1718907727.580201: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D1301 multicast=3D=
0
1718907727.580212: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D1305 multicast=3D=
0
1718907727.580224: nl80211: Register frame type=3D0xd0
(WLAN_FC_STYPE_ACTION) nl_handle=3D0x555661513f30 match=3D7e506f9a1a
multicast=3D0
1718907727.580343: nl80211: Use (wlan0) to initialize P2P Device rfkill
1718907727.580571: rfkill: initial event: idx=3D1 type=3D1 op=3D0 soft=3D0 =
hard=3D0
1718907727.580618: nl80211: Start P2P Device p2p-dev-wlan0 (0x5): Success
1718907727.580764: Add interface p2p-dev-wlan0 to existing radio phy0
1718907727.580914: nl80211: Regulatory information - country=3DUS (DFS-FCC)
1718907727.580920: nl80211: 902-904 @ 2 MHz 30 mBm
1718907727.580923: nl80211: 904-920 @ 16 MHz 30 mBm
1718907727.580925: nl80211: 920-928 @ 8 MHz 30 mBm
1718907727.580927: nl80211: 2400-2472 @ 40 MHz 30 mBm
1718907727.580930: nl80211: 5150-5250 @ 80 MHz 23 mBm
1718907727.580932: nl80211: 5250-5350 @ 80 MHz 24 mBm (DFS)
1718907727.580934: nl80211: 5470-5730 @ 160 MHz 24 mBm (DFS)
1718907727.580937: nl80211: 5730-5850 @ 80 MHz 30 mBm
1718907727.580938: nl80211: 5850-5895 @ 40 MHz 27 mBm (no outdoor) (no IR)
1718907727.580941: nl80211: 5925-7125 @ 320 MHz 12 mBm (no outdoor) (no IR)
1718907727.580943: nl80211: 57240-71000 @ 2160 MHz 40 mBm
1718907727.580957: nl80211: Added 802.11b mode based on 802.11g information
1718907727.580962: nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467[DISABLED] 2472[DISABLED]
2484[DISABLED]
1718907727.580968: nl80211: Mode IEEE 802.11a: 5170 5180 5190 5200
5210 5220 5230 5240 5260[RADAR] 5280[RADAR] 5300[RADAR] 5320[RADAR]
5500[RADAR] 5520[RADAR] 5540[RADAR] 5560[RADAR] 5580[RADAR]
5600[RADAR] 5620[RADAR] 5640[RADAR] 5660[RADAR]
1718907727.580973: nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467[DISABLED] 2472[DISABLED]
2484[DISABLED]
1718907727.580984: p2p-dev-wlan0: Own MAC address: da:3a:dd:d2:ae:3c
1718907727.580990: p2p-dev-wlan0: RSN: flushing PMKID list in the driver
1718907727.580993: nl80211: Flush PMKIDs
1718907727.581013: p2p-dev-wlan0: State: DISCONNECTED -> INACTIVE
1718907727.581046: p2p-dev-wlan0: WPS: UUID from the first interface:
cc4476f0-3727-5645-ae42-9b9b5943d9ca
1718907727.581770: ENGINE: Loading builtin engines
1718907727.583289: ENGINE: Loading builtin engines
1718907727.583344: EAPOL: SUPP_PAE entering state DISCONNECTED
1718907727.583347: EAPOL: Supplicant port status: Unauthorized
1718907727.583351: nl80211: Skip set_supp_port(unauthorized) while not
associated
1718907727.583353: EAPOL: KEY_RX entering state NO_KEY_RECEIVE
1718907727.583355: EAPOL: SUPP_BE entering state INITIALIZE
1718907727.583358: EAP: EAP entering state DISABLED
1718907727.583390: Using existing control interface directory.
1718907727.583473: ctrl_interface_group=3D106 (from group name 'netdev')
1718907727.583558: P2P: Add operating class 81
1718907727.583562: P2P: Channels - hexdump(len=3D11): 01 02 03 04 05 06
07 08 09 0a 0b
1718907727.583568: P2P: Add operating class 115
1718907727.583569: P2P: Channels - hexdump(len=3D4): 24 28 2c 30
1718907727.583571: P2P: Add operating class 116
1718907727.583572: P2P: Channels - hexdump(len=3D2): 24 2c
1718907727.583574: P2P: Add operating class 117
1718907727.583575: P2P: Channels - hexdump(len=3D2): 28 30
1718907727.583577: P2P: Add operating class 124
1718907727.583579: P2P: Channels - hexdump(len=3D4): 95 99 9d a1
1718907727.583581: P2P: Add operating class 125
1718907727.583583: P2P: Channels - hexdump(len=3D5): 95 99 9d a1 a5
1718907727.583584: P2P: Add operating class 126
1718907727.583586: P2P: Channels - hexdump(len=3D2): 95 9d
1718907727.583587: P2P: Add operating class 127
1718907727.583589: P2P: Channels - hexdump(len=3D2): 99 a1
1718907727.583591: P2P: Add operating class 128
1718907727.583596: P2P: Channels - hexdump(len=3D8): 24 28 2c 30 95 99 9d a=
1
1718907727.583605: P2P: Add operating class 130
1718907727.583609: P2P: Channels - hexdump(len=3D9): 24 28 2c 30 95 99 9d a=
1 a5
1718907727.583677: P2P: Own listen channel: 81:6
1718907727.583706: P2P: Random operating channel: 81:1
1718907727.583761: P2P: initialized
1718907727.583785: P2P: channels: 81:1,2,3,4,5,6,7,8,9,10,11
115:36,40,44,48 116:36,44 117:40,48 124:149,153,157,161
125:149,153,157,161,165 126:149,157 127:153,161
128:36,40,44,48,149,153,157,161 130:36,40,44,48,149,153,157,161,165
1718907727.583791: P2P: cli_channels:
1718907727.583799: MBO: Update non-preferred channels, non_pref_chan=3DN/A
1718907727.583809: p2p-dev-wlan0: Added interface p2p-dev-wlan0
1718907727.583815: p2p-dev-wlan0: State: INACTIVE -> DISCONNECTED
1718907727.583818: nl80211: Set p2p-dev-wlan0 operstate 0->0 (DORMANT)
1718907727.583821: netlink: Operstate: ifindex=3D0 linkmode=3D-1 (no
change), operstate=3D5 (IF_OPER_DORMANT)
1718907727.583908: p2p-dev-wlan0: Determining shared radio frequencies
(max len 2)
1718907727.583918: p2p-dev-wlan0: Shared frequencies (len=3D0):
completed iteration
1718907727.583922: P2P: Add operating class 81
1718907727.583924: P2P: Channels - hexdump(len=3D11): 01 02 03 04 05 06
07 08 09 0a 0b
1718907727.583928: P2P: Add operating class 115
1718907727.583929: P2P: Channels - hexdump(len=3D4): 24 28 2c 30
1718907727.583931: P2P: Add operating class 116
1718907727.583932: P2P: Channels - hexdump(len=3D2): 24 2c
1718907727.583934: P2P: Add operating class 117
1718907727.583935: P2P: Channels - hexdump(len=3D2): 28 30
1718907727.583937: P2P: Add operating class 124
1718907727.583938: P2P: Channels - hexdump(len=3D4): 95 99 9d a1
1718907727.583940: P2P: Add operating class 125
1718907727.583941: P2P: Channels - hexdump(len=3D5): 95 99 9d a1 a5
1718907727.583948: P2P: Add operating class 126
1718907727.583950: P2P: Channels - hexdump(len=3D2): 95 9d
1718907727.583951: P2P: Add operating class 127
1718907727.583953: P2P: Channels - hexdump(len=3D2): 99 a1
1718907727.583955: P2P: Add operating class 128
1718907727.583959: P2P: Channels - hexdump(len=3D8): 24 28 2c 30 95 99 9d a=
1
1718907727.583966: P2P: Add operating class 130
1718907727.583969: P2P: Channels - hexdump(len=3D9): 24 28 2c 30 95 99 9d a=
1 a5
1718907727.583973: P2P: Update channel list
1718907727.583984: P2P: channels: 81:1,2,3,4,5,6,7,8,9,10,11
115:36,40,44,48 116:36,44 117:40,48 124:149,153,157,161
125:149,153,157,161,165 126:149,157 127:153,161
128:36,40,44,48,149,153,157,161 130:36,40,44,48,149,153,157,161,165
1718907727.583987: P2P: cli_channels:
1718907727.620719: wlan0: Starting delayed sched scan
1718907727.620761: wlan0: Use normal scan instead of sched_scan for
initial scans (normal_scans=3D0)
1718907727.620768: wlan0: Setting scan request: 0.000000 sec
1718907727.620782: wlan0: State: DISCONNECTED -> SCANNING
1718907727.620790: wlan0: Determining shared radio frequencies (max len 2)
1718907727.620793: wlan0: Shared frequencies (len=3D0): completed iteration
1718907727.620799: P2P: Add operating class 81
1718907727.620803: P2P: Channels - hexdump(len=3D11): 01 02 03 04 05 06
07 08 09 0a 0b
1718907727.620808: P2P: Add operating class 115
1718907727.620810: P2P: Channels - hexdump(len=3D4): 24 28 2c 30
1718907727.620811: P2P: Add operating class 116
1718907727.620813: P2P: Channels - hexdump(len=3D2): 24 2c
1718907727.620814: P2P: Add operating class 117
1718907727.620816: P2P: Channels - hexdump(len=3D2): 28 30
1718907727.620818: P2P: Add operating class 124
1718907727.620819: P2P: Channels - hexdump(len=3D4): 95 99 9d a1
1718907727.620821: P2P: Add operating class 125
1718907727.620823: P2P: Channels - hexdump(len=3D5): 95 99 9d a1 a5
1718907727.620825: P2P: Add operating class 126
1718907727.620827: P2P: Channels - hexdump(len=3D2): 95 9d
1718907727.620829: P2P: Add operating class 127
1718907727.620830: P2P: Channels - hexdump(len=3D2): 99 a1
1718907727.620832: P2P: Add operating class 128
1718907727.620837: P2P: Channels - hexdump(len=3D8): 24 28 2c 30 95 99 9d a=
1
1718907727.620845: P2P: Add operating class 130
1718907727.620848: P2P: Channels - hexdump(len=3D9): 24 28 2c 30 95 99 9d a=
1 a5
1718907727.620853: P2P: Update channel list
1718907727.620866: P2P: channels: 81:1,2,3,4,5,6,7,8,9,10,11
115:36,40,44,48 116:36,44 117:40,48 124:149,153,157,161
125:149,153,157,161,165 126:149,157 127:153,161
128:36,40,44,48,149,153,157,161 130:36,40,44,48,149,153,157,161,165
1718907727.620871: P2P: cli_channels:
1718907727.620876: wlan0: Starting AP scan for wildcard SSID
1718907727.620882: WPS: Building WPS IE for Probe Request
1718907727.620888: WPS:  * Version (hardcoded 0x10)
1718907727.620890: WPS:  * Request Type
1718907727.620891: WPS:  * Config Methods (3148)
1718907727.620893: WPS:  * UUID-E
1718907727.620894: WPS:  * Primary Device Type
1718907727.620896: WPS:  * RF Bands (3)
1718907727.620897: WPS:  * Association State
1718907727.620899: WPS:  * Configuration Error (0)
1718907727.620901: WPS:  * Device Password ID (0)
1718907727.620902: WPS:  * Manufacturer
1718907727.620904: WPS:  * Model Name
1718907727.620905: WPS:  * Model Number
1718907727.620907: WPS:  * Device Name
1718907727.620908: WPS:  * Version2 (0x20)
1718907727.620913: P2P: * P2P IE header
1718907727.620915: P2P: * Capability dev=3D25 group=3D00
1718907727.620917: P2P: * Listen Channel: Regulatory Class 81 Channel 6
1718907727.620925: wlan0: Add radio work 'scan'@0x5556615211f0
1718907727.620928: wlan0: First radio work item in the queue -
schedule start immediately
1718907727.620935: wlan0: Starting radio work 'scan'@0x5556615211f0
after 0.000007 second wait
1718907727.620940: wlan0: nl80211: scan request
1718907727.620965: nl80211: Scan SSID
1718907727.620969: nl80211: Scan extra IEs - hexdump(len=3D150): 7f 0b
00 00 0a 02 00 40 40 00 00 01 20 dd 69 00 50 f2 04 10 4a 00 01 10 10
3a 00 01 00 10 08 00 02 31 48 10 47 00 10 cc 44 76 f0 37 27 56 45 ae
42 9b 9b 59 43 d9 ca 10 54 00 08 00 00 00 00 00 00 00 00 10 3c 00 01
03 10 02 00 02 00 00 10 09 00 02 00 00 10 12 00 02 00 00 10 21 00 01
20 10 23 00 01 20 10 24 00 01 20 10 11 00 01 20 10 49 00 06 00 37 2a
00 01 20 dd 11 50 6f 9a 09 02 02 00 25 00 06 05 00 58 58 04 51 06 72
00 dd 07 50 6f 9a 16 03 01 03
1718907727.643791: Scan requested (ret=3D0) - scan timeout 10 seconds
1718907727.643856: nl80211: Event message available
1718907727.643874: nl80211: Ignored event 33
(NL80211_CMD_TRIGGER_SCAN) for foreign interface (ifindex 3 wdev 0x0)
1718907727.643882: nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN)
received for wlan0
1718907727.643889: wlan0: nl80211: Scan trigger
1718907727.643902: wlan0: Event SCAN_STARTED (47) received
1718907727.643906: wlan0: Own scan request started a scan in 0.000070 secon=
ds
1718907728.566827: EAPOL: disable timer tick
1718907728.583520: EAPOL: disable timer tick
1718907730.451869: RTM_NEWLINK: ifi_index=3D3 ifname=3Dwlan0 wext
ifi_family=3D0 ifi_flags=3D0x1003 ([UP])
1718907730.451990: nl80211: Event message available
1718907730.452034: nl80211: Ignored event 34
(NL80211_CMD_NEW_SCAN_RESULTS) for foreign interface (ifindex 3 wdev
0x0)
1718907730.452041: nl80211: Drv Event 34
(NL80211_CMD_NEW_SCAN_RESULTS) received for wlan0
1718907730.452048: wlan0: nl80211: New scan results available
1718907730.452063: nl80211: Scan probed for SSID ''
1718907730.452071: nl80211: Scan included frequencies: 2412 2417 2422
2427 2432 2437 2442 2447 2452 2457 2462 5170 5180 5190 5200 5210 5220
5230 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640
5660 5680 5700 5720 5745 5765 5785 5805 5825
1718907730.452078: wlan0: Event SCAN_RESULTS (3) received
1718907730.452082: wlan0: Scan completed in 2.808176 seconds
1718907730.452210: nl80211: Received scan results (15 BSSes)
1718907734.305349: wlan0: BSS: Start scan result update 1
1718907734.305433: wlan0: BSS: Add new id 0 BSSID a6:2e:48:fd:9e:73
SSID 'spg5' freq 5785
1718907734.305447: wlan0: BSS: Add new id 1 BSSID ca:3a:6b:54:31:75
SSID 'DIRECT-roku-753-779A78' freq 5785
1718907734.305457: wlan0: BSS: Add new id 2 BSSID bc:2e:48:fd:9e:70
SSID 'spg5' freq 2427
1718907734.305464: wlan0: BSS: Add new id 3 BSSID 40:ed:00:ad:b9:36
SSID 'mntwins' freq 2442
1718907734.305469: wlan0: BSS: Add new id 4 BSSID 42:ed:00:ad:b9:36
SSID '' freq 2442
1718907734.305476: wlan0: BSS: Add new id 5 BSSID cc:f4:11:43:4b:0f
SSID 'CAR' freq 2462
1718907734.305483: wlan0: BSS: Add new id 6 BSSID d8:3a:dd:60:a3:cf
SSID 'deskSAE' freq 2412
1718907734.305489: wlan0: BSS: Add new id 7 BSSID b0:e4:d5:02:61:2a
SSID 'CAR' freq 2412
1718907734.305497: wlan0: BSS: Add new id 8 BSSID 88:ad:43:6b:cd:68
SSID 'Gonzalez-Rivera Family' freq 2412
1718907734.305505: wlan0: BSS: Add new id 9 BSSID b0:e4:d5:0a:1b:22
SSID 'CAR' freq 2412
1718907734.305514: wlan0: BSS: Add new id 10 BSSID 40:70:09:11:4e:60
SSID 'HOME-4E62' freq 2462
1718907734.305519: wlan0: BSS: Add new id 11 BSSID 9a:ad:43:6b:cd:70
SSID '' freq 5745
1718907734.305525: wlan0: BSS: Add new id 12 BSSID b0:e4:d5:02:61:2d
SSID 'CAR' freq 5745
1718907734.305531: wlan0: BSS: Add new id 13 BSSID a2:ad:43:6b:cd:68
SSID '' freq 2412
1718907734.305537: wlan0: BSS: Add new id 14 BSSID fa:8f:ca:63:b5:06
SSID 'Living Room TV' freq 2437
1718907734.305545: BSS: last_scan_res_used=3D15/32
1718907734.305560: wlan0: New scan results available (own=3D1 ext=3D0)
1718907734.305581: WPS: Unsupported attribute type 0x1058 len=3D24
1718907734.305585: WPS: Unsupported attribute type 0x1058 len=3D24
1718907734.305588: WPS: Unsupported attribute type 0x1058 len=3D24
1718907734.305614: WPS: Unsupported attribute type 0x1058 len=3D24
1718907734.305619: WPS: Unsupported attribute type 0x1058 len=3D24
1718907734.305621: WPS: Unsupported attribute type 0x1058 len=3D24
1718907734.305627: WPS: AP a6:2e:48:fd:9e:73 type 0 added
1718907734.305635: WPS: AP ca:3a:6b:54:31:75 type 0 added
1718907734.305639: WPS: AP bc:2e:48:fd:9e:70 type 0 added
1718907734.305642: WPS: AP 40:ed:00:ad:b9:36 type 0 added
1718907734.305645: WPS: AP 88:ad:43:6b:cd:68 type 0 added
1718907734.305648: WPS: AP 40:70:09:11:4e:60 type 0 added
1718907734.305652: WPS: AP[0] a6:2e:48:fd:9e:73 type=3D0 tries=3D0
last_attempt=3D-1 sec ago bssid_ignore=3D0
1718907734.305659: WPS: AP[1] ca:3a:6b:54:31:75 type=3D0 tries=3D0
last_attempt=3D-1 sec ago bssid_ignore=3D0
1718907734.305662: WPS: AP[2] bc:2e:48:fd:9e:70 type=3D0 tries=3D0
last_attempt=3D-1 sec ago bssid_ignore=3D0
1718907734.305664: WPS: AP[3] 40:ed:00:ad:b9:36 type=3D0 tries=3D0
last_attempt=3D-1 sec ago bssid_ignore=3D0
1718907734.305668: WPS: AP[4] 88:ad:43:6b:cd:68 type=3D0 tries=3D0
last_attempt=3D-1 sec ago bssid_ignore=3D0
1718907734.305670: WPS: AP[5] 40:70:09:11:4e:60 type=3D0 tries=3D0
last_attempt=3D-1 sec ago bssid_ignore=3D0
1718907734.305680: wlan0: Radio work 'scan'@0x5556615211f0 done in
6.684742 seconds
1718907734.305691: wlan0: radio_work_free('scan'@0x5556615211f0):
num_active_works --> 0
1718907734.305701: wlan0: Selecting BSS from priority group 0
1718907734.305714: wlan0: 0: a6:2e:48:fd:9e:73 ssid=3D'spg5'
wpa_ie_len=3D0 rsn_ie_len=3D20 caps=3D0x511 level=3D-59 freq=3D5785  wps
1718907734.305747: wlan0:    skip - SSID mismatch
1718907734.305761: wlan0: 1: ca:3a:6b:54:31:75
ssid=3D'DIRECT-roku-753-779A78' wpa_ie_len=3D0 rsn_ie_len=3D20 caps=3D0x411
level=3D-42 freq=3D5785  wps p2p
1718907734.305769: wlan0:    skip - SSID mismatch
1718907734.305778: wlan0: 2: bc:2e:48:fd:9e:70 ssid=3D'spg5'
wpa_ie_len=3D0 rsn_ie_len=3D20 caps=3D0x511 level=3D-43 freq=3D2427  wps
1718907734.305786: wlan0:    skip - SSID mismatch
1718907734.305792: wlan0: 3: 40:ed:00:ad:b9:36 ssid=3D'mntwins'
wpa_ie_len=3D0 rsn_ie_len=3D20 caps=3D0x1411 level=3D-54 freq=3D2442  wps
1718907734.305798: wlan0:    skip - SSID mismatch
1718907734.305802: wlan0: 4: 42:ed:00:ad:b9:36 ssid=3D'' wpa_ie_len=3D0
rsn_ie_len=3D20 caps=3D0x411 level=3D-54 freq=3D2442
1718907734.305806: wlan0:    skip - SSID not known
1718907734.305813: wlan0: 5: cc:f4:11:43:4b:0f ssid=3D'CAR' wpa_ie_len=3D0
rsn_ie_len=3D20 caps=3D0x1431 level=3D-57 freq=3D2462
1718907734.305816: wlan0:    skip - SSID mismatch
1718907734.305820: wlan0: 6: d8:3a:dd:60:a3:cf ssid=3D'deskSAE'
wpa_ie_len=3D0 rsn_ie_len=3D20 caps=3D0x411 level=3D-52 freq=3D2412
1718907734.305830: wlan0:    selected based on RSN IE
1718907734.305841: wlan0:    selected BSS d8:3a:dd:60:a3:cf ssid=3D'deskSAE=
'
1718907734.306270: wlan0: Considering connect request: reassociate: 0
selected: d8:3a:dd:60:a3:cf  bssid: 00:00:00:00:00:00  pending:
00:00:00:00:00:00  wpa_state: SCANNING  ssid=3D0x5556614a4990
current_ssid=3D(nil)
1718907734.306294: wlan0: Request association with d8:3a:dd:60:a3:cf
1718907734.306312: TDLS: TDLS is allowed in the target BSS
1718907734.306319: TDLS: TDLS channel switch allowed in the target BSS
1718907734.306323: wlan0: No ongoing scan/p2p-scan found to abort
1718907734.306332: wlan0: Add radio work 'connect'@0x5556615211f0
1718907734.306339: wlan0: First radio work item in the queue -
schedule start immediately
1718907734.306357: p2p-dev-wlan0: Updating scan results from sibling
1718907734.307938: nl80211: Received scan results (15 BSSes)
1718907734.308261: p2p-dev-wlan0: BSS: Start scan result update 1
1718907734.308339: p2p-dev-wlan0: BSS: Add new id 0 BSSID
a6:2e:48:fd:9e:73 SSID 'spg5' freq 5785
1718907734.308359: p2p-dev-wlan0: BSS: Add new id 1 BSSID
ca:3a:6b:54:31:75 SSID 'DIRECT-roku-753-779A78' freq 5785
1718907734.308372: p2p-dev-wlan0: BSS: Add new id 2 BSSID
bc:2e:48:fd:9e:70 SSID 'spg5' freq 2427
1718907734.308380: p2p-dev-wlan0: BSS: Add new id 3 BSSID
40:ed:00:ad:b9:36 SSID 'mntwins' freq 2442
1718907734.308391: p2p-dev-wlan0: BSS: Add new id 4 BSSID
42:ed:00:ad:b9:36 SSID '' freq 2442
1718907734.308398: p2p-dev-wlan0: BSS: Add new id 5 BSSID
cc:f4:11:43:4b:0f SSID 'CAR' freq 2462
1718907734.308407: p2p-dev-wlan0: BSS: Add new id 6 BSSID
b0:e4:d5:02:61:2a SSID 'CAR' freq 2412
1718907734.308416: p2p-dev-wlan0: BSS: Add new id 7 BSSID
88:ad:43:6b:cd:68 SSID 'Gonzalez-Rivera Family' freq 2412
1718907734.308424: p2p-dev-wlan0: BSS: Add new id 8 BSSID
d8:3a:dd:60:a3:cf SSID 'deskSAE' freq 2412
1718907734.308429: p2p-dev-wlan0: BSS: Add new id 9 BSSID
9a:ad:43:6b:cd:70 SSID '' freq 5745
1718907734.308434: p2p-dev-wlan0: BSS: Add new id 10 BSSID
b0:e4:d5:0a:1b:22 SSID 'CAR' freq 2412
1718907734.308441: p2p-dev-wlan0: BSS: Add new id 11 BSSID
40:70:09:11:4e:60 SSID 'HOME-4E62' freq 2462
1718907734.308450: p2p-dev-wlan0: BSS: Add new id 12 BSSID
b0:e4:d5:02:61:2d SSID 'CAR' freq 5745
1718907734.308456: p2p-dev-wlan0: BSS: Add new id 13 BSSID
a2:ad:43:6b:cd:68 SSID '' freq 2412
1718907734.308464: p2p-dev-wlan0: BSS: Add new id 14 BSSID
fa:8f:ca:63:b5:06 SSID 'Living Room TV' freq 2437
1718907734.308473: BSS: last_scan_res_used=3D15/32
1718907734.308610: wlan0: Starting radio work 'connect'@0x5556615211f0
after 0.002253 second wait
1718907734.308655: wlan0: WPA: clearing own WPA/RSN IE
1718907734.308665: wlan0: RSN: clearing own RSNXE
1718907734.308680: RSN: PMKSA cache search -
network_ctx=3D0x5556614a4990 try_opportunistic=3D0 akmp=3D0x0
1718907734.308687: RSN: Search for BSSID d8:3a:dd:60:a3:cf
1718907734.308690: RSN: No PMKSA cache entry found
1718907734.308706: wlan0: RSN: using IEEE 802.11i/D9.0
1718907734.308712: wlan0: WPA: Selected cipher suites: group 16
pairwise 16 key_mgmt 1024 proto 2
1718907734.308716: wlan0: WPA: Selected mgmt group cipher 32
1718907734.308720: wlan0: WPA: clearing AP WPA IE
1718907734.308724: WPA: set AP RSN IE - hexdump(len=3D22): 30 14 01 00
00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f ac 08 c0 00
1718907734.308735: wlan0: WPA: clearing AP RSNXE
1718907734.308740: wlan0: WPA: AP group 0x10 network profile group
0x18; available group 0x10
1718907734.308748: wlan0: WPA: using GTK CCMP
1718907734.308758: wlan0: WPA: AP pairwise 0x10 network profile
pairwise 0x10; available pairwise 0x10
1718907734.308767: wlan0: WPA: using PTK CCMP
1718907734.308772: wlan0: WPA: AP key_mgmt 0x400 network profile
key_mgmt 0x400; available key_mgmt 0x0
1718907734.308779: wlan0: WPA: Failed to select authenticated key
management type
1718907734.308787: wlan0: WPA: Failed to set WPA key management and
encryption suites
1718907734.308798: wlan0: Radio work 'connect'@0x5556615211f0 done in
0.000205 seconds
1718907734.308805: wlan0: radio_work_free('connect'@0x5556615211f0):
num_active_works --> 0
1718907771.716726: nl80211: Event message available
1718907771.716807: nl80211: Ignored event 33
(NL80211_CMD_TRIGGER_SCAN) for foreign interface (ifindex 3 wdev 0x0)
1718907771.716813: nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN)
received for wlan0
1718907771.716824: wlan0: nl80211: Scan trigger
1718907771.716838: wlan0: Event SCAN_STARTED (47) received
1718907771.716842: wlan0: External program started a scan
1718907774.517258: RTM_NEWLINK: ifi_index=3D3 ifname=3Dwlan0 wext
ifi_family=3D0 ifi_flags=3D0x1003 ([UP])
1718907774.517518: nl80211: Event message available
1718907774.517560: nl80211: Ignored event 34
(NL80211_CMD_NEW_SCAN_RESULTS) for foreign interface (ifindex 3 wdev
0x0)
1718907774.517571: nl80211: Drv Event 34
(NL80211_CMD_NEW_SCAN_RESULTS) received for wlan0
1718907774.517583: wlan0: nl80211: New scan results available
1718907774.517596: nl80211: Scan probed for SSID ''
1718907774.517606: nl80211: Scan included frequencies: 5180 5200 5210
5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640
5660 5680 5700 5720 5745 5765 5785 5805 5825 2412 2417 2422 2427 2432
2437 2442 2447 2452 2457 2462
1718907774.517614: wlan0: Event SCAN_RESULTS (3) received
1718907774.517730: nl80211: Received scan results (17 BSSes)
1718907778.352778: wlan0: BSS: Start scan result update 2
1718907778.352851: wlan0: BSS: Add new id 15 BSSID ca:3a:6b:54:31:75
SSID '' freq 5785
1718907778.352871: wlan0: BSS: Add new id 16 BSSID bc:2e:48:fd:9e:73
SSID '' freq 5785
1718907778.352883: wlan0: BSS: Add new id 17 BSSID 40:ed:00:ad:b9:35
SSID 'mntwins_5G' freq 5765
1718907778.352891: wlan0: BSS: Add new id 18 BSSID 42:ed:00:dd:b9:36
SSID '' freq 5765
1718907778.352898: wlan0: BSS: Add new id 19 BSSID 88:ad:43:6b:cd:70
SSID 'Gonzalez-Rivera Family' freq 5745
1718907778.352904: wlan0: BSS: Add new id 20 BSSID cc:f4:11:43:4b:0b
SSID 'CAR' freq 5745
1718907778.352910: BSS: last_scan_res_used=3D17/32
1718907778.352919: wlan0: New scan results available (own=3D0 ext=3D1)
1718907778.352932: WPS: Unsupported attribute type 0x1058 len=3D24
1718907778.352935: WPS: Unsupported attribute type 0x1058 len=3D24
1718907778.352938: WPS: Unsupported attribute type 0x1058 len=3D24
1718907778.352954: wlan0: Do not use results from externally requested
scan operation for network selection
1718907778.352960: p2p-dev-wlan0: Updating scan results from sibling
1718907778.353089: nl80211: Received scan results (17 BSSes)
1718907778.353137: p2p-dev-wlan0: BSS: Start scan result update 2
1718907778.353157: p2p-dev-wlan0: BSS: Add new id 15 BSSID
bc:2e:48:fd:9e:73 SSID '' freq 5785
1718907778.353162: p2p-dev-wlan0: BSS: Add new id 16 BSSID
ca:3a:6b:54:31:75 SSID '' freq 5785
1718907778.353174: p2p-dev-wlan0: BSS: Add new id 17 BSSID
40:ed:00:ad:b9:35 SSID 'mntwins_5G' freq 5765
1718907778.353178: p2p-dev-wlan0: BSS: Add new id 18 BSSID
42:ed:00:dd:b9:36 SSID '' freq 5765
1718907778.353183: p2p-dev-wlan0: BSS: Add new id 19 BSSID
88:ad:43:6b:cd:70 SSID 'Gonzalez-Rivera Family' freq 5745
1718907778.353187: p2p-dev-wlan0: BSS: Add new id 20 BSSID
cc:f4:11:43:4b:0b SSID 'CAR' freq 5745
1718907778.353194: BSS: last_scan_res_used=3D17/32
1718907778.353203: p2p-dev-wlan0: New scan results available (own=3D0 ext=
=3D1)
1718907778.353206: p2p-dev-wlan0: Do not use results from externally
requested scan operation for network selection


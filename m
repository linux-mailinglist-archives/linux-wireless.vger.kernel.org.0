Return-Path: <linux-wireless+bounces-9311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634BE910A4D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 17:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE381C22D15
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A011B0116;
	Thu, 20 Jun 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJUEdjtc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9D1B140F
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898271; cv=none; b=Roqm9YnDW1tiJhgTztbhfr0AHrYGmQIUhdoyYXdt5QykKyn9sS2aU0N5DnRc+Gp0KAJb+RS9RDeH0Sw3hVfeU2pIpPjL4+w601vRUMXW94yNqFKkEXWxNO35zrUyrSdnA+49qpaLBYgsoRUHfokhcnG+4Qj/eULFAfib/6/6M2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898271; c=relaxed/simple;
	bh=6+UU2G4fXs0C7wmViFukKDW/j7U4fvuA4rHcIt7Ilh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8yd8qt0stnwFm587dC4so7ht+U60vVo/YTTtg1fW4QamTLo++paYJmo7YRaQgjNpfvacH/N3IRMA4CbuDJNoNg7MJu21FmUVcSi0hg/6Jnav7VxMNtivgOxBnPLv9gz5pKhzWc+NNP5Oli82EEMgj6FK4ITJsnH6ro1SA4qnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJUEdjtc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c7cd714268so799022a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718898270; x=1719503070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ybyZB3Ww76W++YgQ5LhSlKL+gxVyB7Pvadw9m6Lnc4=;
        b=PJUEdjtc+Sb6l8I57LM+Az5k4FBJK3qixZuPj1OEu8QNetlxKFNA/u8MxUIPPO9OdT
         jEgY+f+puDzgqCSwZi7Nmg7QJSyBY/aCCMzu1PexLNdkGEa0lzl1oOSRvt8YJrnjmEEE
         t3+4ds83fmD5NG7vq8NRL5KCvUGLiGfRkyVhiwucYow+zISjzDsZSkGhmtpPGfDALg90
         LNOiHJgxZDfsQNYQmYtNfwC9D0DVeFVoVJwGW8EjaktZkhwiguNiF5pINEJdKMhsie9j
         gBhFJkVk6PNXn9katsZfeHfa3OMVkNE3E8xYulqwvV1m3eDQsRqhIMhcipPCTRBgB7h6
         MSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718898270; x=1719503070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ybyZB3Ww76W++YgQ5LhSlKL+gxVyB7Pvadw9m6Lnc4=;
        b=iLd4GP/KP0FPU+lfLHIAAbZ5xKYm1vEqLObjgj0qSdQfVvKAmeGj85YkrcqzzF9X1D
         RXjHrtod1GnhxRWBK80lHJ+Nq01fh80mKvyGXrkRojAwUOABwdfr5HLKGeqGDywItrhp
         3SMKyLyxz3dX7NBg/aCEN9Q30lAjUXPXorLSUEWKOYSfQtAsIBhqeTl/GIObIrcITp7X
         DkgX1Kx0gooVpx43Nm2eeUg7q71aeFSuK9oNs85cXoWPzgz7CKHXdEG0HGsBhQwOfIU4
         tI7kDvFjd8qchS5vYoRJ1KhxzrbXrafn1D9qMfqoq9oD++Qnxix6jnMq7k0hb9XDdr+s
         qvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRKpFaVxHaqEIS/wqpLCCPc9KpI7bI9IUtU+OuPWo3891DicGrt7ok5A+XA3YCCcYkIO8Irt5KP1CQJjtEx4V1X1ifWLbSfhpSyvdbt50=
X-Gm-Message-State: AOJu0YzWBu+Hz5KiBbfN/sEBS5oRTanliANo4T3f2iESu1uo9GdYyiTl
	rHe5Zx3+FbExVbDwk8I7PTydeAYzgUZCJPLRPTpwBYsXVY7S2vwLIhXxpNz1pfx4KwaXfh1WYdt
	Cq25NL/1njmgfRrQxm5BbJ8I1CZ8=
X-Google-Smtp-Source: AGHT+IEUMz2Wh/QvPff2p9QZtsdBkCMg+zLDRHCkr50ig4HhJ+3Dje9D8Ij1MBCtrKb1dIxsYc/aVzG2TBMZKqb1/rM=
X-Received: by 2002:a17:90b:f82:b0:2c8:631:2f53 with SMTP id
 98e67ed59e1d1-2c806313090mr1401764a91.7.1718898269718; Thu, 20 Jun 2024
 08:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
 <CALeDE9O7DCPhoxdMyHmYFOjwdkPRepiaaC92QorzSTXCduZ+xQ@mail.gmail.com>
 <CAGRGNgWH9U3XeatXA9xpkLz76COuL1xjYcfXQYLTGKBxvy=M-A@mail.gmail.com>
 <CALeDE9M78so=roEFion9GGo4tV7c+M885=ZNZgi9zKyBur+iMQ@mail.gmail.com> <190355aedf0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <190355aedf0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 20 Jun 2024 10:44:18 -0500
Message-ID: <CAG17S_NBO=tTBp9GX=S9C4REbT-Gx634n66+7JERcWbe-KXt-g@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Julian Calaby <julian.calaby@gmail.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 6:14=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On June 20, 2024 11:53:12 AM Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > On Thu, 20 Jun 2024 at 10:46, Julian Calaby <julian.calaby@gmail.com> w=
rote:
> >>
> >> Hi Peter,
> >>
> >> On Thu, Jun 20, 2024 at 7:19=E2=80=AFPM Peter Robinson <pbrobinson@gma=
il.com> wrote:
> >>>
> >>> Hi Arend,
> >>>
> >>>> After being asked about support for WPA3 for BCM43224 chipset it
> >>>> was found that all it takes is setting the MFP_CAPABLE flag and
> >>>> mac80211 will take care of all that is needed [1].
> >>>
> >>> Testing this on a Raspberry Pi 4 [1] against a UniFi U6Pro AP I can't
> >>> connect to my WPA3 only SSID, it works fine with the SSID that's
> >>> WPA2/WPA3 on the same AP. It doesn't connect and I get a whole lot of
> >>> the following errors while it tries:
> >>>
> >>> [  155.988865] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
> >>> reason -52
> >>> [  156.100906] brcmfmac: brcmf_set_channel: set chanspec 0xd034 fail,
> >>> reason -52
> >>> [  156.108597] brcmfmac: brcmf_set_channel: set chanspec 0xd038 fail,
> >>> reason -52
> >>> [  156.116317] brcmfmac: brcmf_set_channel: set chanspec 0xd03c fail,
> >>> reason -52
> >>
> >> The Raspberry Pis' WiFi chipsets use the brcmfmac driver and this is a
> >> patch to the brcmsmac driver. This driver is for older and simpler
> >> WiFi chipsets than the ones on the Raspberry Pis.
> >
> > Right you are, completely missed that :)
>
> The devil is in the details ;-) Good that you tested. Maybe we can look
> into the WPA3-only problem. Are you using wpa_supplicant? Can you share
> supplicant log file and kernel log with brcmfmac debug modparam set to 0x=
1416.
>
> Regards,
> Arend
>

The RPis and the brcmfmac cards.
The current RPiOS for 32 bit and 64 bit OS have firmware which loads
on the 5Ghz capable Pis (3b+, 4, 5, 02W) which advertise WPA3
capability (this is a Pi5, but others are similar) This firmware is
from 2021:
# dmesg | grep brcmfmac
[    2.112735] brcmfmac: F1 signature read @0x18000000=3D0x15264345
[    2.114202] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    2.117274] usbcore: registered new interface driver brcmfmac
[    2.335211] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=3D-2)
[    2.335581] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
01-996384e2

# iw list
Wiphy phy0
...
    Supported extended features:
        * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
        * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station m=
ode
        * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station=
 mode
        * [ DFS_OFFLOAD ]: DFS offload
        * [ SAE_OFFLOAD ]: SAE offload support
        * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
        * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support

# uname -a
Linux pi5 6.6.31+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.31-1+rpt1
(2024-05-29) aarch64 GNU/Linux

I am pretty sure I am fully up to date.

I set up hostapd running an WPA3 SAE config on my desktop with an
intel card and can connect to it from my phone.
I cannot connect to it from the Pi5:
I tried using a config file and connecting with wpa_supplicant and it did n=
ot:
# cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
update_config=3D1
 network=3D{
  ssid=3D"deskSAE"
  sae_password=3D"secret123"
  proto=3DRSN
  key_mgmt=3DSAE
  pairwise=3DCCMP
  ieee80211w=3D2
}
# ifconfig wlan0 up
root@pi5(rw):~# iwlist wlan0 scan | grep deskSAE
                    ESSID:"deskSAE"
# wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
Successfully initialized wpa_supplicant
wlan0: WPA: Failed to select authenticated key management type
wlan0: WPA: Failed to set WPA key management and encryption suites
(never returns command prompt)

I tried using wpa_cli as well and it also fails:
<3>CTRL-EVENT-NETWORK-ADDED 1
<3>CTRL-EVENT-SCAN-STARTED
<3>CTRL-EVENT-SCAN-RESULTS
<3>WPS-AP-AVAILABLE  "deskS
<4>Failed to initiate sched scan
<3>CTRL-EVENT-NETWORK-NOT-FOUND
> set_network 0 ssid "deskSAE"
OK
> set_network - key_mgmt SAE
OK
> set_network 0 ieee80211w 2
OK
> set_network 0 sae_password "secret123"
OK
<3>CTRL-EVENT-SCAN-STARTED
<3>CTRL-EVENT-SCAN-RESULTS
<3>WPS-AP-AVAILABLE
<4>Failed to initiate sched scan
<3>CTRL-EVENT-NETWORK-NOT-FOUND
<3>CTRL-EVENT-SCAN-STARTED
> enable 0
OK
<3>CTRL-EVENT-SCAN-RESULTS
<3>WPS-AP-AVAILABLE
<4>Failed to initiate sched scan
<3>CTRL-EVENT-NETWORK-NOT-FOUND
<4>WPA: Failed to select authenticated key management type
<4>WPA: Failed to set WPA key management and encryption suites
<3>CTRL-EVENT-SCAN-STARTED
<3>CTRL-EVENT-SCAN-RESULTS
<3>WPS-AP-AVAILABLE
<4>WPA: Failed to select authenticated key management type
<4>WPA: Failed to set WPA key management and encryption suites
<3>CTRL-EVENT-SCAN-STARTED

Would love it if there were a way to get wpa3 to work with the
brcmfmac cards on RPI.

Keith


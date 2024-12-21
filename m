Return-Path: <linux-wireless+bounces-16699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056109FA196
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 17:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20191884F6F
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0887113C3CD;
	Sat, 21 Dec 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PntmpVA9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A91311AC
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734797672; cv=none; b=TVFs5FASsf/Yf5n74IABcVUy5N0Kok5SCj76Z5gHCIaFTG7YY+1VKxls1Jvpy9+mJMEmJsXf5rxKvILI9Nq46yLob6j3FgfBfJMnfpQJ6cqzrH3BKtcduJhqF+ZGug8VWsziXNWAouMr1w7V/s6TMUF05pfULeoqjtDIeLMG3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734797672; c=relaxed/simple;
	bh=JolgB4SpTUkHdSfZGSgb/R5PwvnZeV8fNOY8eOX2nF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azwXYXm+Fj1jgmhiOYKXmRWn5WoEQXj274o8grefU+bNSeGv/YXDEhA+VMk1lurGE//XvKU0D001BjRlX58Q8cSeNnFck3J5c7Sp7Yr84l6/P0qIwYtxCBPbBUnEzbrBXv6GVvRKlArRwVlb540jaU2HkkAgHK3Za6aJbxawCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PntmpVA9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so1809773a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 08:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734797670; x=1735402470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvor27yZJIWmWTQZ0dly+/wnMArC6F6C3fghhaSDQvQ=;
        b=PntmpVA9+MlEsvagJZKGiIPiF9vVK5/rURdnFaZH/rr1x4HG+3VcEu+DsH8zQqOIjz
         LAo5ick5pUC3lMgtcvOI01RWEBK1lY2BOQXJiS5wBcyUgN2M2rI7zaTM+6TGWo9muuWG
         yhcPzJ7GiD2Dz38ZfvuASODMN36u3d6MwBWRe8M8bxHyEss0+aTrobwWOaTwytW9IpN4
         1xKYWTxrLlNfWmkalJAh9yI+xyzyQSjAoOLv9vKwjjCgv2yPAQtXDUt6nW6VWNJqzO2R
         7LcW91vfQBZpUwkoaN33wwM4AVeuJT+6CXsrI2FYrC219TqczGETT0nNJj9fZnt7Uh7I
         Be8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734797670; x=1735402470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvor27yZJIWmWTQZ0dly+/wnMArC6F6C3fghhaSDQvQ=;
        b=wuBwwzgyuxR+1Dbc56Qf2yR7iVu+wn3gZjzdF8PC01dh2XB5KhZeoscz81L5yBG9dE
         UkIIhFf1qsYgvyQrGyyRoePMdfd/ZkgEUMtH9kymdFgSQaBVq99BEpQc2EL03cQtpr3T
         FC9W7sKx+WqdK1GUJTQ3BXk/XGJiv9f3VjmzKIQ2LwKLjOfnVbaJ7L7GGTi9WQb2HREy
         miivf8smMXtzUs3SRrhxZtR91PfLaTqYYViZ5yEqbfoH59Cea3mnj15pHyxcnF35SlNq
         Bq+D9Nm7wuDfJIHGRBdaJa9T9E3K8H1+3yyDGQVIJx2odz2uzMjHxJzvhd7yVWO2bviQ
         wLgA==
X-Forwarded-Encrypted: i=1; AJvYcCUr+aPOWn7efsOQQ+KSYvus3RIsMaz3Mu3+B3+YRkPt3e4nTTgvzS2Lkc9JbLF0FXla8QQ8QrTPvWG3wMheZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGUJ4TOuLZBeSjzVYJhFi1UWnLIQ7HaOoSVfzoIyggmINEx7B
	dyZaH/UFoEwy8mmockOOjkzgX6yXz6OVrRm+0Wq0Rib955FC7hyA5kQQlOel/wo6FjFRSHrhp2S
	qA+hNEEefSOeZyEwi6iFBG5OAUjkviM1D
X-Gm-Gg: ASbGncuGHuWTZ5h+iUYgfkc/AlCOTz83RY3xYPtsfTodWMBzrnoEMtb3bq9n/ZF+o7C
	VS83R8qVM7oUsukkm8bF2AYBSJIqCR0GDcGkl2A==
X-Google-Smtp-Source: AGHT+IHDDgNFZ0uM0phGV+VQd7HqCvceFH+hRsJOUwdRhO02F9LUcr3Tg9QrR7qXyazf1qKxasIa4p99g0iAfadTS3E=
X-Received: by 2002:a17:90b:4ec8:b0:2ee:7415:4768 with SMTP id
 98e67ed59e1d1-2f452e3694bmr11391301a91.17.1734797670090; Sat, 21 Dec 2024
 08:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <193cb61e210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_P+cOQMpQda00JTCCKEB6MpPE4X2i8mRrEaM-n5YKdpNg@mail.gmail.com>
 <14ec6009-7b91-4a25-9943-f63da91d8c41@broadcom.com> <caa186d8-1e07-421d-a127-7bb6482ac704@broadcom.com>
 <CAG17S_N0V=_Es0C7wA3fPu2MrBKBM7tEHRXOnVGWiUSxPucaRQ@mail.gmail.com>
 <ec23f0d9-a23c-4684-b0b6-a89141c5ec37@broadcom.com> <CAG17S_PmXNP2bdUU5ErQd-N2jyScqvfKTFsnWgADb3uhqpBsZA@mail.gmail.com>
 <65e4975d-2234-44d6-bdd0-a679df2b1c66@broadcom.com> <CAG17S_OAPEWsr61cBA1qfNhFst-mYK5a2_VrCZVZhdd-KVM9cw@mail.gmail.com>
 <c6e8ab71-d1e3-41a1-925c-9013f5a87f12@broadcom.com> <CAG17S_MoZDbu1vSt+=80xs+Cje_PPFhFwPxmWDUeNPJ9qRZ6bw@mail.gmail.com>
 <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com>
 <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com> <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
 <c586f9fe-e1f8-44dd-a867-ec21c78c7de9@gmail.com> <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
In-Reply-To: <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 21 Dec 2024 10:14:18 -0600
Message-ID: <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: James Prestwood <prestwoj@gmail.com>, connman@lists.linux.dev
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

James,

I was messing with this some more. I was able to pull the latest
iwd-git that already has your patch in it and can confirm that using
iwd and the latest kernel that it will connect.
If I use iwctl, it works fine. If I use connmanctl, it does not unless
I have already connected using iwctl.

What happens, I think, in connmanctl is that it initiates a
connection, then says connected, but does not actually grab the dhcp
address.

connmanctl> agent on
Agent registered
connmanctl> connect wifi_d83addd2ae3c_6465736b534145_managed_psk
Agent RequestInput wifi_d83addd2ae3c_6465736b534145_managed_psk
  Passphrase =3D [ Type=3Dpsk, Requirement=3Dmandatory ]
Passphrase? *******
connmanctl> services
  c deskSAE              wifi_d83addd2ae3c_6465736b534145_managed_psk
Connected wifi_d83addd2ae3c_6465736b534145_managed_psk
connmanctl> services
*AR deskSAE              wifi_d83addd2ae3c_6465736b534145_managed_psk

but no DHCP address:
# ifconfig wlan0
wlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 169.254.182.158  netmask 255.255.0.0  broadcast 169.254.255.25=
5
        inet6 fe80::da3a:ddff:fed2:ae3c  prefixlen 64  scopeid 0x20<link>
        ether d8:3a:dd:d2:ae:3c  txqueuelen 4000  (Ethernet)
        RX packets 1631  bytes 167645 (163.7 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 349  bytes 47812 (46.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

if I initiate the connection using iwctl, it works, connects, gets a
DHCP and I can ping the AP. The problem is something between connman
and iwd, I think.

I have tried this on the Pi3 with a v8 kernel and a pi5 using a 2712
kernel. Both have the latest firmware from infineon.
These are the versions of iwd and connman (I think they are up to date):
iwd-git/now 3.3.r0.g4b535cee-1 arm64 [installed,local]
connman-git/now 1.43.r4.g263e151f-1 arm64 [installed,local]
I thought I saw this behavior on the Pi3b+, but was unable to check it
as in depth as I have here on the Pi5.

Do you need a log or journal to debug what is going on?


On Thu, Dec 19, 2024 at 8:22=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote:
>
> So, how do we get these in the rpi kernel source?
>
> I was testing this using a firmware from Infineon's repository which
> is a rev newer than what is in the RPi image. I will try it again
> tonight, but with the firmware which is shipped in the current,
> Bookworm RPi image. It is a rev back from the version I was using here
> to test this. It still does have external auth, so it may work as
> well. I'll let you know.
>
> Keith
>
> On Thu, Dec 19, 2024 at 7:43=E2=80=AFAM James Prestwood <prestwoj@gmail.c=
om> wrote:
> >
> > Hi Keith,
> >
> > On 12/19/24 5:38 AM, KeithG wrote:
> > > On Thu, Dec 19, 2024 at 6:46=E2=80=AFAM James Prestwood <prestwoj@gma=
il.com> wrote:
> > >> Hi Keith,
> > >>
> > >> On 12/18/24 5:46 PM, KeithG wrote:
> > >>> On Wed, Dec 18, 2024 at 8:10=E2=80=AFAM KeithG <ys3al35l@gmail.com>=
 wrote:
> > >>>> On Wed, Dec 18, 2024 at 4:21=E2=80=AFAM Arend van Spriel
> > >>>> <arend.vanspriel@broadcom.com> wrote:
> > >>>>> On 12/18/2024 1:21 AM, KeithG wrote:
> > >>>>>> On Tue, Dec 17, 2024 at 7:47=E2=80=AFAM Arend van Spriel
> > >>>>>> <arend.vanspriel@broadcom.com> wrote:
> > >>>>>>>
> > >>>>>>> On 12/17/2024 1:13 AM, KeithG wrote:
> > >>>>>>>> On Mon, Dec 16, 2024 at 1:50=E2=80=AFPM Arend van Spriel
> > >>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> > >>>>>>>>> On 12/16/2024 1:21 PM, KeithG wrote:
> > >>>>>>>>>> On Mon, Dec 16, 2024 at 3:47=E2=80=AFAM Arend van Spriel
> > >>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> > >>>>>>>>>>> On 12/16/2024 10:43 AM, Arend van Spriel wrote:
> > >>>>>>>>>>>> On 12/16/2024 1:17 AM, KeithG wrote:
> > >>>>>>>>>>>>> On Sun, Dec 15, 2024 at 11:33=E2=80=AFAM Arend Van Spriel
> > >>>>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> > >>>>>>>>>>>>>> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.c=
om> wrote:
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> On Sun, Dec 15, 2024 at 6:12=E2=80=AFAM Arend van Sprie=
l
> > >>>>>>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> > >>>>>>>>>>>>>>>> On 12/14/2024 2:34 PM, KeithG wrote:
> > >>>>>>>>>>>>>>>>> Arend,
> > >>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>> I looked through the info where I got the latest firm=
ware:
> > >>>>>>>>>>>>>>>>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for=
-Linux/Wi-Fi-
> > >>>>>>>>>>>>>>>>> A-class-Linux-Driver-release-FMAC-2024-11-21-Document=
s/td-p/905045
> > >>>>>>>>>>>>>>>>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-=
Fi-Bluetooth/
> > >>>>>>>>>>>>>>>>> Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-=
p/902888
> > >>>>>>>>>>>>>>>>> and did not find anything, but I really do not know w=
hat I am
> > >>>>>>>>>>>>>>>>> looking for.
> > >>>>>>>>>>>>>>>> I think I had a bit more luck and maybe found the need=
le. I sent out
> > >>>>>>>>>>>>>>>> another RFT patch which hopefully gets rid of the BCME=
_BADLEN error.
> > >>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>> Regards,
> > >>>>>>>>>>>>>>>> Arend
> > >>>>>>>>>>>>>>> Arend,
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> Can you send me a link to that patch? I want to try it.
> > >>>>>>>>>>>>>> Hmm. I explicitly sent it to you, but here is a link to =
patchwork:
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> https://patchwork.kernel.org/project/linux-wireless/
> > >>>>>>>>>>>>>> patch/20241215120401.238320-1-arend.vanspriel@broadcom.c=
om/
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> You can apply it on top of the other 3 patches.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Regards,
> > >>>>>>>>>>>>>> Arend
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>> Thanks! I got it.
> > >>>>>>>>>>>>> I am building now and have tried to apply what I think ar=
e the correct
> > >>>>>>>>>>>>> patches. They do not apply cleanly and I had to hand edit=
 things. My
> > >>>>>>>>>>>>> guess is I messed something up.
> > >>>>>>>>>>>>> I will see what happens when I reboot. It'll take a few h=
ours to build
> > >>>>>>>>>>>>> on my Pi4 then for me to install it on the 3b+ to test.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> I hope I understand which are the '3 other' patches.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> This is the one I got from your link:
> > >>>>>>>>>>>>> RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.dif=
f
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> These are what I understand are the '3 other patches'
> > >>>>>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-call=
backs-and-
> > >>>>>>>>>>>>> firmware-events.patch.diff
> > >>>>>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.=
patch.diff
> > >>>>>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authent=
ication-in-
> > >>>>>>>>>>>>> station-mode.patch.diff
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> If they are not correct could you send me links to them a=
nd I'll try
> > >>>>>>>>>>>>> again.
> > >>>>>>>>>>>> You got it right. Kuddos.
> > >>>>>>>>>>> Ignored my spelling checker, but apparently it should be "k=
udos".
> > >>>>>>>>>>> Another lesson learned today.
> > >>>>>>>>>>>
> > >>>>>>>>>>> Regards,
> > >>>>>>>>>>> Arend
> > >>>>>>>>>> Arend,
> > >>>>>>>>>>
> > >>>>>>>>>> Thanks for the confirmation. My attempt at a hand edit to ap=
ply the
> > >>>>>>>>>> rejected portions resulted in a failed build with the curren=
t RPiOS
> > >>>>>>>>>> kernel in the git repo:
> > >>>>>>>>>> # uname -a
> > >>>>>>>>>> Linux jackrune 6.6.64-v8+ #6 SMP PREEMPT Sun Dec 15 23:55:30=
 CST 2024
> > >>>>>>>>>> aarch64 GNU/Linux
> > >>>>>>>>>>
> > >>>>>>>>>> When I try to apply them, I get this:
> > >>>>>>>>>> $ patch -Np1 -i
> > >>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbac=
ks-and-firmware-events.patch.diff
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/cfg80211.c
> > >>>>>>>>>> Hunk #1 FAILED at 6752.
> > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.=
rej
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/common.c
> > >>>>>>>>>> Hunk #1 succeeded at 524 (offset 33 lines).
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/core.c
> > >>>>>>>>>> Hunk #1 FAILED at 1359.
> > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/fweh.c
> > >>>>>>>>>> Hunk #1 succeeded at 74 (offset -1 lines).
> > >>>>>>>>>> Hunk #2 succeeded at 336 (offset -70 lines).
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/fwvid.h
> > >>>>>>>>>> Hunk #1 FAILED at 15.
> > >>>>>>>>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
> > >>>>>>>>>> 1 out of 2 hunks FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
> > >>>>>>>>>> $ patch -Np1 -i RFT-v2-
> > >>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbac=
ks-and-firmware-events.patch.diff
> > >>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.pat=
ch.diff
> > >>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentica=
tion-in-station-mode.patch.diff
> > >>>>>>>>>> $ patch -Np1 -i
> > >>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.pat=
ch.diff
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/fweh.h
> > >>>>>>>>>> Hunk #1 FAILED at 337.
> > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
> > >>>>>>>>>> $ patch -Np1 -i
> > >>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentica=
tion-in-station-mode.patch.diff
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/cfg80211.c
> > >>>>>>>>>> Hunk #1 succeeded at 75 (offset 1 line).
> > >>>>>>>>>> Hunk #2 FAILED at 1940.
> > >>>>>>>>>> Hunk #3 FAILED at 2158.
> > >>>>>>>>>> Hunk #4 FAILED at 2216.
> > >>>>>>>>>> Hunk #5 succeeded at 5522 (offset 22 lines).
> > >>>>>>>>>> Hunk #6 succeeded at 5697 (offset 90 lines).
> > >>>>>>>>>> Hunk #7 succeeded at 6126 (offset 125 lines).
> > >>>>>>>>>> Hunk #8 succeeded at 7596 with fuzz 1 (offset 255 lines).
> > >>>>>>>>>> Hunk #9 FAILED at 7647.
> > >>>>>>>>>> 4 out of 9 hunks FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.=
rej
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/cfg80211.h
> > >>>>>>>>>> Hunk #3 succeeded at 243 (offset 15 lines).
> > >>>>>>>>>> Hunk #4 FAILED at 244.
> > >>>>>>>>>> Hunk #5 succeeded at 507 (offset 18 lines).
> > >>>>>>>>>> 1 out of 5 hunks FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h.=
rej
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/cyw/core.c
> > >>>>>>>>>> Hunk #1 FAILED at 8.
> > >>>>>>>>>> Hunk #2 FAILED at 39.
> > >>>>>>>>>> Hunk #3 FAILED at 49.
> > >>>>>>>>>> 3 out of 3 hunks FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c.=
rej
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/cyw/fwil_types.h
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/feature.c
> > >>>>>>>>>> Hunk #1 FAILED at 42.
> > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c.r=
ej
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/feature.h
> > >>>>>>>>>> Hunk #1 succeeded at 32 with fuzz 2 (offset 1 line).
> > >>>>>>>>>> Hunk #2 succeeded at 60 with fuzz 1 (offset 2 lines).
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/fweh.c
> > >>>>>>>>>> Hunk #1 FAILED at 450.
> > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c.rej
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/fweh.h
> > >>>>>>>>>> Hunk #1 FAILED at 94.
> > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/fwvid.h
> > >>>>>>>>>> Hunk #1 FAILED at 15.
> > >>>>>>>>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -11 lines).
> > >>>>>>>>>> 1 out of 2 hunks FAILED -- saving rejects to file
> > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.r
> > >>>>>>>>>> $ patch -Np1 -i RFT-brcmfmac-Fix-structure-size-for-WPA3-ext=
ernal-SAE.diff
> > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/cyw/fwil_types.h
> > >>>>>>>>>>
> > >>>>>>>>>> Is there another missing patch?
> > >>>>>>>>>>
> > >>>>>>>>>> The kernel for the RPi is at this commit:
> > >>>>>>>>>> commit 80533a952218696c0ef1b346bab50dc401e6b74c (HEAD -> rpi=
-6.6.y,
> > >>>>>>>>>> origin/rpi-6.6.y, origin/HEAD)
> > >>>>>>> So what repository does origin refer to. Can you share the URL?
> > >>>>>>>
> > >>>>>>> I will check if I posted any patches between 6.6 and 6.10+ Get =
back to
> > >>>>>>> this later o
> > >>>>>>>
> > >>>>>>> Regards,
> > >>>>>>> Arend
> > >>>>>> Arend,
> > >>>>>>
> > >>>>>> I am using the RaspberryPi repo:
> > >>>>>> https://github.com/raspberrypi/linux
> > >>>>> I was afraid you would say that. So we need to determine what brc=
mfmac
> > >>>>> patches are in there compared to upstream kernel. So checking the=
 code I
> > >>>>> think you should apply only the "Fix-structure-size" patch to
> > >>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h. Le=
t me
> > >>>>> know if that works for you.
> > >>>>>
> > >>>>> Gr. AvS
> > >>>> Arend,
> > >>>>
> > >>>> That patch applied to the file in the folder you suggested. I am
> > >>>> building a kernel now and will see any changes this evening. Thank=
s
> > >>>> for the help.
> > >>>>
> > >>>> Regards,
> > >>>>
> > >>>> Keith
> > >>> Arend,
> > >>>
> > >>> Thanks for the guidance and help.
> > >>>
> > >>> I tried with the patched kernel and was unable to connect. The 2
> > >>> attached files are the log with brcmfmac debugging and iwd debuggin=
g
> > >>> turned o. and the other is an iwmon capture of an attempt to connec=
t.
> > >>> This time, though, I get no IP address at all. Just an error out wh=
en
> > >>> I try to connect using iwctl. I get:
> > >>>
> > >>> [iwd]# station wlan0 connect deskSAE
> > >>> Type the network passphrase for deskSAE psk.
> > >>> Passphrase: *********
> > >>> Operation failed
> > >>> NetworkConfigurationEnabled: enabled
> > >>> StateDirectory: /var/lib/iwd
> > >>> Version: 3.1
> > >>> This is with kernel:
> > >>> Linux jackrune 6.6.66-v8+ #7 SMP PREEMPT Wed Dec 18 10:18:01 CST 20=
24
> > >>> aarch64 GNU/Linux
> > >>> and this firmware:
> > >>> Dec 18 19:37:08 jackrune kernel: brcmfmac: brcmf_fw_alloc_request:
> > >>> using brcm/brcmfmac43455-sdio for chip BCM4345/6
> > >>> Dec 18 19:37:08 jackrune kernel: usbcore: registered new interface
> > >>> driver brcmfmac
> > >>> Dec 18 19:37:09 jackrune kernel: brcmfmac: brcmf_c_process_txcap_bl=
ob:
> > >>> no txcap_blob available (err=3D-2)
> > >>> Dec 18 19:37:09 jackrune kernel: brcmfmac: brcmf_c_preinit_dcmds:
> > >>> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
> > >>> (be70ab3 CY) FWID 01-95efe7fa
> > >> Even closer this time. I've just sent a patch to the IWD mailing lis=
t.
> > >> Please try that along with Arend's kernel patch.
> > >>
> > >> Thanks,
> > >>
> > >> James
> > >>
> > >>> Keith
> > > James,
> > >
> > > It worked. I built iwd then tried to connect via iwctl and it
> > > connected to a WPA3 AP. I got an IP and I can ping the AP from the
> > > RPi.! It is a first! Woot Woot!
> > >
> > > [iwd]# station wlan0 connect deskSAE
> > >                                 Available networks
> > > ---------------------------------------------------------------------=
-----------
> > >        Network name                      Security            Signal
> > > ---------------------------------------------------------------------=
-----------
> > >        deskSAE                           psk                 ****
> > >
> > > Type the network passphrase for deskSAE psk.
> > > Passphrase: *********
> > >
> > > When I go to connman, it shows connected and I can ping.
> > >
> > > (clear out configs and reboot)
> > > When I tried from connmanctl it also connects! Seems with this patch
> > > to iwd and Arend's patch to the driver that WPA3 now works with RPis
> > >
> > > I had to apply Arend's patch to the 6.6.y source which has the
> > > brcm80211 structured a bit differently and the file to patch is in a
> > > different folder. the patch, corrected for 6.6.y, is attached.
> >
> > Great! That's good to hear. It took a while but glad its finally
> > working. We'll get that patch to IWD upstreamed, or at least some
> > version of it. And thanks Arend for providing the support on the kernel
> > side of things.
> >
> > Thanks,
> >
> > James
> >
> > >
> > > Keith


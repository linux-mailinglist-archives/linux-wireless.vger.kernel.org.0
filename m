Return-Path: <linux-wireless+bounces-16858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7511A9FDD31
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 05:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23603A15F8
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 04:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED979EEC8;
	Sun, 29 Dec 2024 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5L6U5GT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFE748A
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735445236; cv=none; b=F63sqXGRBKu14t3Igsa6HqzOm4eUIEbEKf0aX7NHhzBwywZ6/xdV+6+DNpzzl9hCVg8QrRRPzz2Tr0embPDNr0BJmXhCZyYv3B92i2Se8eXOOG2qpwxBLjFS6bpUrOsARlqtHYWZZ3tANNucWfP34eeToLEX9RojH2ey0tV0rtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735445236; c=relaxed/simple;
	bh=clW4dpfvMQ1TtoEXX7oF0R5eJug57acqCoZWIPnFuHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfelEFBXiCEYAQkSQoxahrcAiIg6SaSkD6mF8H8s5jRPGau7AiCOdkZ0dhfvFz9BFOrZc3A6GSrUFkYyhSM8TRnNS+3622EuzDJmEvgzNLdV6Guv04ASt5AsvP88j/hF0PKXvU3N0qIPukyoZ6L4roSPyL81KCZRbXMjrp7qsx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5L6U5GT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso8275177a91.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735445233; x=1736050033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yd9L01835cghVyU0ppoQVRW7jcOSVgaa+vY7HcgLw0=;
        b=i5L6U5GT565l9yfupFSHzoHG4DRLVXhq5svpZAa3yP1CMbZeeDM8R7aST2ErYeIPum
         Jw904c5CqjciKG04IKS21xytVHDyyrxoVZTkK12yVPxXylXccvweJH46AObRlVb6Dsde
         VKK5N55nFwVlor0O+WT7u/3DAJcJZC7sKM1jyA06vyrLB4SBIr93MU3bf0K6iP95stGk
         r2RF0ZrpKMQVUfQS76+oo4dowK5Qdfs4fzmV2aFlyEcUGQTtan+8KcSNTf4kCL+jMsHZ
         PFaAliB0dVkH/qSLcKdLXBayUJ1xnJ1SG/b657Zrn4esfVuoHTHAER+QAECTF9PHyl+O
         Pmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735445233; x=1736050033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yd9L01835cghVyU0ppoQVRW7jcOSVgaa+vY7HcgLw0=;
        b=ZS1kCQ5DMWmix8x4wRG7UqKdTtpzhbe7Gjurd6Ojakf1zN4GbfuOuB1xABcJfoKScv
         6Q9sYQvxUY123SyE6XsntzYxheS9fjGjfLkUsNdacqnBF4mJkzfsjqhrVdgArqx9iPAO
         i6EE3v2DrAKu2S+am+shcn0iatk0K8C5OStzZEhcHTxB8tpuCHhZ0Isw2ZuNCBNbvrsX
         3OB3d7kFq6NJOalmAaiD8gxWjaxiVo9vfpd+jZwYuG27UyiJSBCEazULgsbrQ6iodAp2
         XyNKxvv7MoUQMTloRSZdQO3FFf/faZBqbGaP3xi6CsAIgYweaM6w9PpfxINQ3/WVV7ow
         DXEg==
X-Forwarded-Encrypted: i=1; AJvYcCXDYBn7W0Px5Z/FwofTZhi06DxBvQ+mbPbP3QUZcuBM/6II3O3cqvZYmdO1G7q0NEti7pxO37eyoj1XiOJ+cg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysq2wGs9erKuSE3xMjVFExNL3qfueABJlj2hCpXvOwQd1PKFyC
	wQOHNIoXi9Ur9YvbQ4ydOfaCJFO+ZQsb4OkCZ6LgmtkZK0W+uyMWtG8oCq899U5PnNvbpnjFkeF
	ldULyGFe4CNhGbOu1jnJIYwB5r4+xLApc
X-Gm-Gg: ASbGnctBNp12s9g9EcKFrtzggSsBvNQNlQ3Dd3ulzxzF6txi+j2dpdpobts7BK8TRbv
	fwwKxhg9TlNb3gaAp8OVDNaJ2dukrDbpcHPEHYg==
X-Google-Smtp-Source: AGHT+IELO78doryJ0gV3zd6N+PlISgoeZBbfnem9nKn+wiZkD3hlQTcEEJ7OV1wR51Tcy31waXiN1l9MzDJF2s/Ne/A=
X-Received: by 2002:a17:90a:d00b:b0:2ee:9a82:5a93 with SMTP id
 98e67ed59e1d1-2f452e1d13amr47721824a91.14.1735445232955; Sat, 28 Dec 2024
 20:07:12 -0800 (PST)
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
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com> <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
In-Reply-To: <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 28 Dec 2024 22:07:01 -0600
Message-ID: <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: James Prestwood <prestwoj@gmail.com>, connman@lists.linux.dev
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 4:02=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Sat, Dec 21, 2024 at 11:30=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrot=
e:
> >
> > On Sat, Dec 21, 2024 at 10:14=E2=80=AFAM KeithG <ys3al35l@gmail.com> wr=
ote:
> > >
> > > James,
> > >
> > > I was messing with this some more. I was able to pull the latest
> > > iwd-git that already has your patch in it and can confirm that using
> > > iwd and the latest kernel that it will connect.
> > > If I use iwctl, it works fine. If I use connmanctl, it does not unles=
s
> > > I have already connected using iwctl.
> > >
> > > What happens, I think, in connmanctl is that it initiates a
> > > connection, then says connected, but does not actually grab the dhcp
> > > address.
> > >
> > > connmanctl> agent on
> > > Agent registered
> > > connmanctl> connect wifi_d83addd2ae3c_6465736b534145_managed_psk
> > > Agent RequestInput wifi_d83addd2ae3c_6465736b534145_managed_psk
> > >   Passphrase =3D [ Type=3Dpsk, Requirement=3Dmandatory ]
> > > Passphrase? *******
> > > connmanctl> services
> > >   c deskSAE              wifi_d83addd2ae3c_6465736b534145_managed_psk
> > > Connected wifi_d83addd2ae3c_6465736b534145_managed_psk
> > > connmanctl> services
> > > *AR deskSAE              wifi_d83addd2ae3c_6465736b534145_managed_psk
> > >
> > > but no DHCP address:
> > > # ifconfig wlan0
> > > wlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
> > >         inet 169.254.182.158  netmask 255.255.0.0  broadcast 169.254.=
255.255
> > >         inet6 fe80::da3a:ddff:fed2:ae3c  prefixlen 64  scopeid 0x20<l=
ink>
> > >         ether d8:3a:dd:d2:ae:3c  txqueuelen 4000  (Ethernet)
> > >         RX packets 1631  bytes 167645 (163.7 KiB)
> > >         RX errors 0  dropped 0  overruns 0  frame 0
> > >         TX packets 349  bytes 47812 (46.6 KiB)
> > >         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> > >
> > > if I initiate the connection using iwctl, it works, connects, gets a
> > > DHCP and I can ping the AP. The problem is something between connman
> > > and iwd, I think.
> > >
> > > I have tried this on the Pi3 with a v8 kernel and a pi5 using a 2712
> > > kernel. Both have the latest firmware from infineon.
> > > These are the versions of iwd and connman (I think they are up to dat=
e):
> > > iwd-git/now 3.3.r0.g4b535cee-1 arm64 [installed,local]
> > > connman-git/now 1.43.r4.g263e151f-1 arm64 [installed,local]
> > > I thought I saw this behavior on the Pi3b+, but was unable to check i=
t
> > > as in depth as I have here on the Pi5.
> > >
> > > Do you need a log or journal to debug what is going on?
> > >
> > >
> > > On Thu, Dec 19, 2024 at 8:22=E2=80=AFAM KeithG <ys3al35l@gmail.com> w=
rote:
> > > >
> > > > So, how do we get these in the rpi kernel source?
> > > >
> > > > I was testing this using a firmware from Infineon's repository whic=
h
> > > > is a rev newer than what is in the RPi image. I will try it again
> > > > tonight, but with the firmware which is shipped in the current,
> > > > Bookworm RPi image. It is a rev back from the version I was using h=
ere
> > > > to test this. It still does have external auth, so it may work as
> > > > well. I'll let you know.
> > > >
> > > > Keith
> > > >
> > > > On Thu, Dec 19, 2024 at 7:43=E2=80=AFAM James Prestwood <prestwoj@g=
mail.com> wrote:
> > > > >
> > > > > Hi Keith,
> > > > >
> > > > > On 12/19/24 5:38 AM, KeithG wrote:
> > > > > > On Thu, Dec 19, 2024 at 6:46=E2=80=AFAM James Prestwood <prestw=
oj@gmail.com> wrote:
> > > > > >> Hi Keith,
> > > > > >>
> > > > > >> On 12/18/24 5:46 PM, KeithG wrote:
> > > > > >>> On Wed, Dec 18, 2024 at 8:10=E2=80=AFAM KeithG <ys3al35l@gmai=
l.com> wrote:
> > > > > >>>> On Wed, Dec 18, 2024 at 4:21=E2=80=AFAM Arend van Spriel
> > > > > >>>> <arend.vanspriel@broadcom.com> wrote:
> > > > > >>>>> On 12/18/2024 1:21 AM, KeithG wrote:
> > > > > >>>>>> On Tue, Dec 17, 2024 at 7:47=E2=80=AFAM Arend van Spriel
> > > > > >>>>>> <arend.vanspriel@broadcom.com> wrote:
> > > > > >>>>>>>
> > > > > >>>>>>> On 12/17/2024 1:13 AM, KeithG wrote:
> > > > > >>>>>>>> On Mon, Dec 16, 2024 at 1:50=E2=80=AFPM Arend van Spriel
> > > > > >>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> > > > > >>>>>>>>> On 12/16/2024 1:21 PM, KeithG wrote:
> > > > > >>>>>>>>>> On Mon, Dec 16, 2024 at 3:47=E2=80=AFAM Arend van Spri=
el
> > > > > >>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> > > > > >>>>>>>>>>> On 12/16/2024 10:43 AM, Arend van Spriel wrote:
> > > > > >>>>>>>>>>>> On 12/16/2024 1:17 AM, KeithG wrote:
> > > > > >>>>>>>>>>>>> On Sun, Dec 15, 2024 at 11:33=E2=80=AFAM Arend Van =
Spriel
> > > > > >>>>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> > > > > >>>>>>>>>>>>>> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@g=
mail.com> wrote:
> > > > > >>>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>>>> On Sun, Dec 15, 2024 at 6:12=E2=80=AFAM Arend van=
 Spriel
> > > > > >>>>>>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> > > > > >>>>>>>>>>>>>>>> On 12/14/2024 2:34 PM, KeithG wrote:
> > > > > >>>>>>>>>>>>>>>>> Arend,
> > > > > >>>>>>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>>>>>> I looked through the info where I got the lates=
t firmware:
> > > > > >>>>>>>>>>>>>>>>> https://community.infineon.com/t5/Wi-Fi-Bluetoo=
th-for-Linux/Wi-Fi-
> > > > > >>>>>>>>>>>>>>>>> A-class-Linux-Driver-release-FMAC-2024-11-21-Do=
cuments/td-p/905045
> > > > > >>>>>>>>>>>>>>>>> https://community.infineon.com/t5/AIROC-Wi-Fi-a=
nd-Wi-Fi-Bluetooth/
> > > > > >>>>>>>>>>>>>>>>> Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-=
21/td-p/902888
> > > > > >>>>>>>>>>>>>>>>> and did not find anything, but I really do not =
know what I am
> > > > > >>>>>>>>>>>>>>>>> looking for.
> > > > > >>>>>>>>>>>>>>>> I think I had a bit more luck and maybe found th=
e needle. I sent out
> > > > > >>>>>>>>>>>>>>>> another RFT patch which hopefully gets rid of th=
e BCME_BADLEN error.
> > > > > >>>>>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>>>>> Regards,
> > > > > >>>>>>>>>>>>>>>> Arend
> > > > > >>>>>>>>>>>>>>> Arend,
> > > > > >>>>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>>>> Can you send me a link to that patch? I want to t=
ry it.
> > > > > >>>>>>>>>>>>>> Hmm. I explicitly sent it to you, but here is a li=
nk to patchwork:
> > > > > >>>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>>> https://patchwork.kernel.org/project/linux-wireles=
s/
> > > > > >>>>>>>>>>>>>> patch/20241215120401.238320-1-arend.vanspriel@broa=
dcom.com/
> > > > > >>>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>>> You can apply it on top of the other 3 patches.
> > > > > >>>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>>> Regards,
> > > > > >>>>>>>>>>>>>> Arend
> > > > > >>>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>> Thanks! I got it.
> > > > > >>>>>>>>>>>>> I am building now and have tried to apply what I th=
ink are the correct
> > > > > >>>>>>>>>>>>> patches. They do not apply cleanly and I had to han=
d edit things. My
> > > > > >>>>>>>>>>>>> guess is I messed something up.
> > > > > >>>>>>>>>>>>> I will see what happens when I reboot. It'll take a=
 few hours to build
> > > > > >>>>>>>>>>>>> on my Pi4 then for me to install it on the 3b+ to t=
est.
> > > > > >>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>> I hope I understand which are the '3 other' patches=
.
> > > > > >>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>> This is the one I got from your link:
> > > > > >>>>>>>>>>>>> RFT-brcmfmac-Fix-structure-size-for-WPA3-external-S=
AE.diff
> > > > > >>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>> These are what I understand are the '3 other patche=
s'
> > > > > >>>>>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg8021=
1-callbacks-and-
> > > > > >>>>>>>>>>>>> firmware-events.patch.diff
> > > > > >>>>>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-=
const.patch.diff
> > > > > >>>>>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-a=
uthentication-in-
> > > > > >>>>>>>>>>>>> station-mode.patch.diff
> > > > > >>>>>>>>>>>>>
> > > > > >>>>>>>>>>>>> If they are not correct could you send me links to =
them and I'll try
> > > > > >>>>>>>>>>>>> again.
> > > > > >>>>>>>>>>>> You got it right. Kuddos.
> > > > > >>>>>>>>>>> Ignored my spelling checker, but apparently it should=
 be "kudos".
> > > > > >>>>>>>>>>> Another lesson learned today.
> > > > > >>>>>>>>>>>
> > > > > >>>>>>>>>>> Regards,
> > > > > >>>>>>>>>>> Arend
> > > > > >>>>>>>>>> Arend,
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> Thanks for the confirmation. My attempt at a hand edit=
 to apply the
> > > > > >>>>>>>>>> rejected portions resulted in a failed build with the =
current RPiOS
> > > > > >>>>>>>>>> kernel in the git repo:
> > > > > >>>>>>>>>> # uname -a
> > > > > >>>>>>>>>> Linux jackrune 6.6.64-v8+ #6 SMP PREEMPT Sun Dec 15 23=
:55:30 CST 2024
> > > > > >>>>>>>>>> aarch64 GNU/Linux
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> When I try to apply them, I get this:
> > > > > >>>>>>>>>> $ patch -Np1 -i
> > > > > >>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-c=
allbacks-and-firmware-events.patch.diff
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/cfg80211.c
> > > > > >>>>>>>>>> Hunk #1 FAILED at 6752.
> > > > > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80=
211.c.rej
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/common.c
> > > > > >>>>>>>>>> Hunk #1 succeeded at 524 (offset 33 lines).
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/core.c
> > > > > >>>>>>>>>> Hunk #1 FAILED at 1359.
> > > > > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.=
c.rej
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/fweh.c
> > > > > >>>>>>>>>> Hunk #1 succeeded at 74 (offset -1 lines).
> > > > > >>>>>>>>>> Hunk #2 succeeded at 336 (offset -70 lines).
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/fwvid.h
> > > > > >>>>>>>>>> Hunk #1 FAILED at 15.
> > > > > >>>>>>>>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
> > > > > >>>>>>>>>> 1 out of 2 hunks FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid=
.h.rej
> > > > > >>>>>>>>>> $ patch -Np1 -i RFT-v2-
> > > > > >>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-c=
allbacks-and-firmware-events.patch.diff
> > > > > >>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-con=
st.patch.diff
> > > > > >>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-auth=
entication-in-station-mode.patch.diff
> > > > > >>>>>>>>>> $ patch -Np1 -i
> > > > > >>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-con=
st.patch.diff
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/fweh.h
> > > > > >>>>>>>>>> Hunk #1 FAILED at 337.
> > > > > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.=
h.rej
> > > > > >>>>>>>>>> $ patch -Np1 -i
> > > > > >>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-auth=
entication-in-station-mode.patch.diff
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/cfg80211.c
> > > > > >>>>>>>>>> Hunk #1 succeeded at 75 (offset 1 line).
> > > > > >>>>>>>>>> Hunk #2 FAILED at 1940.
> > > > > >>>>>>>>>> Hunk #3 FAILED at 2158.
> > > > > >>>>>>>>>> Hunk #4 FAILED at 2216.
> > > > > >>>>>>>>>> Hunk #5 succeeded at 5522 (offset 22 lines).
> > > > > >>>>>>>>>> Hunk #6 succeeded at 5697 (offset 90 lines).
> > > > > >>>>>>>>>> Hunk #7 succeeded at 6126 (offset 125 lines).
> > > > > >>>>>>>>>> Hunk #8 succeeded at 7596 with fuzz 1 (offset 255 line=
s).
> > > > > >>>>>>>>>> Hunk #9 FAILED at 7647.
> > > > > >>>>>>>>>> 4 out of 9 hunks FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80=
211.c.rej
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/cfg80211.h
> > > > > >>>>>>>>>> Hunk #3 succeeded at 243 (offset 15 lines).
> > > > > >>>>>>>>>> Hunk #4 FAILED at 244.
> > > > > >>>>>>>>>> Hunk #5 succeeded at 507 (offset 18 lines).
> > > > > >>>>>>>>>> 1 out of 5 hunks FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80=
211.h.rej
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/cyw/core.c
> > > > > >>>>>>>>>> Hunk #1 FAILED at 8.
> > > > > >>>>>>>>>> Hunk #2 FAILED at 39.
> > > > > >>>>>>>>>> Hunk #3 FAILED at 49.
> > > > > >>>>>>>>>> 3 out of 3 hunks FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/c=
ore.c.rej
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/cyw/fwil_types.h
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/feature.c
> > > > > >>>>>>>>>> Hunk #1 FAILED at 42.
> > > > > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/featu=
re.c.rej
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/feature.h
> > > > > >>>>>>>>>> Hunk #1 succeeded at 32 with fuzz 2 (offset 1 line).
> > > > > >>>>>>>>>> Hunk #2 succeeded at 60 with fuzz 1 (offset 2 lines).
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/fweh.c
> > > > > >>>>>>>>>> Hunk #1 FAILED at 450.
> > > > > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.=
c.rej
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/fweh.h
> > > > > >>>>>>>>>> Hunk #1 FAILED at 94.
> > > > > >>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.=
h.rej
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/fwvid.h
> > > > > >>>>>>>>>> Hunk #1 FAILED at 15.
> > > > > >>>>>>>>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -11 lines)=
.
> > > > > >>>>>>>>>> 1 out of 2 hunks FAILED -- saving rejects to file
> > > > > >>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid=
.h.r
> > > > > >>>>>>>>>> $ patch -Np1 -i RFT-brcmfmac-Fix-structure-size-for-WP=
A3-external-SAE.diff
> > > > > >>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/=
brcmfmac/cyw/fwil_types.h
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> Is there another missing patch?
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> The kernel for the RPi is at this commit:
> > > > > >>>>>>>>>> commit 80533a952218696c0ef1b346bab50dc401e6b74c (HEAD =
-> rpi-6.6.y,
> > > > > >>>>>>>>>> origin/rpi-6.6.y, origin/HEAD)
> > > > > >>>>>>> So what repository does origin refer to. Can you share th=
e URL?
> > > > > >>>>>>>
> > > > > >>>>>>> I will check if I posted any patches between 6.6 and 6.10=
+ Get back to
> > > > > >>>>>>> this later o
> > > > > >>>>>>>
> > > > > >>>>>>> Regards,
> > > > > >>>>>>> Arend
> > > > > >>>>>> Arend,
> > > > > >>>>>>
> > > > > >>>>>> I am using the RaspberryPi repo:
> > > > > >>>>>> https://github.com/raspberrypi/linux
> > > > > >>>>> I was afraid you would say that. So we need to determine wh=
at brcmfmac
> > > > > >>>>> patches are in there compared to upstream kernel. So checki=
ng the code I
> > > > > >>>>> think you should apply only the "Fix-structure-size" patch =
to
> > > > > >>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types=
.h. Let me
> > > > > >>>>> know if that works for you.
> > > > > >>>>>
> > > > > >>>>> Gr. AvS
> > > > > >>>> Arend,
> > > > > >>>>
> > > > > >>>> That patch applied to the file in the folder you suggested. =
I am
> > > > > >>>> building a kernel now and will see any changes this evening.=
 Thanks
> > > > > >>>> for the help.
> > > > > >>>>
> > > > > >>>> Regards,
> > > > > >>>>
> > > > > >>>> Keith
> > > > > >>> Arend,
> > > > > >>>
> > > > > >>> Thanks for the guidance and help.
> > > > > >>>
> > > > > >>> I tried with the patched kernel and was unable to connect. Th=
e 2
> > > > > >>> attached files are the log with brcmfmac debugging and iwd de=
bugging
> > > > > >>> turned o. and the other is an iwmon capture of an attempt to =
connect.
> > > > > >>> This time, though, I get no IP address at all. Just an error =
out when
> > > > > >>> I try to connect using iwctl. I get:
> > > > > >>>
> > > > > >>> [iwd]# station wlan0 connect deskSAE
> > > > > >>> Type the network passphrase for deskSAE psk.
> > > > > >>> Passphrase: *********
> > > > > >>> Operation failed
> > > > > >>> NetworkConfigurationEnabled: enabled
> > > > > >>> StateDirectory: /var/lib/iwd
> > > > > >>> Version: 3.1
> > > > > >>> This is with kernel:
> > > > > >>> Linux jackrune 6.6.66-v8+ #7 SMP PREEMPT Wed Dec 18 10:18:01 =
CST 2024
> > > > > >>> aarch64 GNU/Linux
> > > > > >>> and this firmware:
> > > > > >>> Dec 18 19:37:08 jackrune kernel: brcmfmac: brcmf_fw_alloc_req=
uest:
> > > > > >>> using brcm/brcmfmac43455-sdio for chip BCM4345/6
> > > > > >>> Dec 18 19:37:08 jackrune kernel: usbcore: registered new inte=
rface
> > > > > >>> driver brcmfmac
> > > > > >>> Dec 18 19:37:09 jackrune kernel: brcmfmac: brcmf_c_process_tx=
cap_blob:
> > > > > >>> no txcap_blob available (err=3D-2)
> > > > > >>> Dec 18 19:37:09 jackrune kernel: brcmfmac: brcmf_c_preinit_dc=
mds:
> > > > > >>> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.28=
6
> > > > > >>> (be70ab3 CY) FWID 01-95efe7fa
> > > > > >> Even closer this time. I've just sent a patch to the IWD maili=
ng list.
> > > > > >> Please try that along with Arend's kernel patch.
> > > > > >>
> > > > > >> Thanks,
> > > > > >>
> > > > > >> James
> > > > > >>
> > > > > >>> Keith
> > > > > > James,
> > > > > >
> > > > > > It worked. I built iwd then tried to connect via iwctl and it
> > > > > > connected to a WPA3 AP. I got an IP and I can ping the AP from =
the
> > > > > > RPi.! It is a first! Woot Woot!
> > > > > >
> > > > > > [iwd]# station wlan0 connect deskSAE
> > > > > >                                 Available networks
> > > > > > ---------------------------------------------------------------=
-----------------
> > > > > >        Network name                      Security            Si=
gnal
> > > > > > ---------------------------------------------------------------=
-----------------
> > > > > >        deskSAE                           psk                 **=
**
> > > > > >
> > > > > > Type the network passphrase for deskSAE psk.
> > > > > > Passphrase: *********
> > > > > >
> > > > > > When I go to connman, it shows connected and I can ping.
> > > > > >
> > > > > > (clear out configs and reboot)
> > > > > > When I tried from connmanctl it also connects! Seems with this =
patch
> > > > > > to iwd and Arend's patch to the driver that WPA3 now works with=
 RPis
> > > > > >
> > > > > > I had to apply Arend's patch to the 6.6.y source which has the
> > > > > > brcm80211 structured a bit differently and the file to patch is=
 in a
> > > > > > different folder. the patch, corrected for 6.6.y, is attached.
> > > > >
> > > > > Great! That's good to hear. It took a while but glad its finally
> > > > > working. We'll get that patch to IWD upstreamed, or at least some
> > > > > version of it. And thanks Arend for providing the support on the =
kernel
> > > > > side of things.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > James
> > > > >
> > > > > >
> > > > > > Keith
> >
> > This is on a Pi4 with this kernel
> > # uname -a
> > Linux runeaudio 6.6.67-v8+ #8 SMP PREEMPT Sat Dec 21 19:52:23 CST 2024
> > aarch64 GNU/Linux
> > It has Arend's patch to allow this latest firmware to function:
> > Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
> > (be70ab3 CY) FWID 01-95efe7fa
> >
> > Something strange is going on. If I make sure there are no saved
> > configs in /var/lib/connman or iwd and restart the processes then try
> > to connect with connman, it errors out and will not connect.
> > If I clear all saved configs then try with iwctl, it will connect. I
> > verified that it gets an IP and I can ping the AP.
> >
> > The iwmon logs are attached. The Pi4_no_connect.txt log is a
> > connection attempt from connmanctl. The other is a connection made
> > from iwctl.
> >
> > Even after it has connected via iwctl. When I go to connmanctl
> > disconnect then try to reconnect, it fails and I get this in the log:
> >
> > Dec 21 18:23:23 runeaudio connmand[22469]: Interface wlan0 [ wifi ]
> > state is association
> > Dec 21 18:23:23 runeaudio iwd[22858]: event: connect-info, FullMAC
> > driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> > Dec 21 18:23:23 runeaudio iwd[22858]: event: connect-info, FullMAC
> > driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> > Dec 21 18:23:23 runeaudio iwd[22858]: event: connect-info, ssid:
> > deskSAE, bss: d8:3a:dd:60:a3:0c, signal: -62, load: 0/255
> > Dec 21 18:23:23 runeaudio iwd[22858]: event: state, old: disconnected,
> > new: connecting
> > Dec 21 18:23:23 runeaudio connmand[22469]: Interface wlan0 [ wifi ]
> > state is configuration
> > Dec 21 18:23:23 runeaudio iwd[22858]: event: connect-info, External
> > Auth to SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
> > Dec 21 18:23:23 runeaudio kernel: ieee80211 phy0:
> > brcmf_cfg80211_external_auth: External authentication failed: status=3D=
1
> > Dec 21 18:24:07 runeaudio avahi-daemon[330]: Joining mDNS multicast
> > group on interface wlan0.IPv4 with address 169.254.160.106.
> > Dec 21 18:24:07 runeaudio avahi-daemon[330]: New relevant interface
> > wlan0.IPv4 for mDNS.
> > Dec 21 18:24:07 runeaudio avahi-daemon[330]: Registering new address
> > record for 169.254.160.106 on wlan0.IPv4.
> > Dec 21 18:24:07 runeaudio connmand[22469]: Interface wlan0 [ wifi ]
> > state is ready
> > Dec 21 18:24:07 runeaudio connmand[22469]: wlan0 {add} address
> > 169.254.160.106/16 label wlan0 family 2
> >
> > As you can see, it never gets a DHCP address and it fails External
> > Auth. I do not know why I did not see this on the 3b+ I was testing on
> > previously. I will try it again and see how far I get. I saw the same
> > result on a Pi5 and will try again to see if it follows this same
> > pattern I saw on the Pi4.
>
> Further digging. This is some sort of intermittent failure. Sometimes
> it connects with iwd 3.3.r0 and sometimes not. Sometimes it connects
> from connmanctl and iwctl and sometimes not.
>
> If I try to connect from connmanctl and I get a failed connection, it
> reports this in the log.
>
> on the Pi5:
> Dec 22 10:22:36 runeaudio iwd[2120]: Error loading /var/lib/iwd//deskSAE.=
psk
> Dec 22 10:22:53 runeaudio connmand[648]: Interface wlan0 [ wifi ]
> state is association
> Dec 22 10:22:53 runeaudio iwd[2120]: src/network.c:network_connect()
> Dec 22 10:22:53 runeaudio iwd[2120]: src/wiphy.c:wiphy_select_akm()
> Network is WPA3-Personal...
> Dec 22 10:22:53 runeaudio iwd[2120]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/network.c:network_connect_psk() ask_passphrase: true
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/agent.c:agent_request_passphrase() agent 0x5555fdb62200 owner :1.8
> path /net/co>
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/agent.c:agent_send_next_request() send request to :1.8
> /net/connman/iwd_agent
> Dec 22 10:22:53 runeaudio iwd[2120]: src/agent.c:agent_receive_reply()
> agent 0x5555fdb62200 request id 520
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/network.c:passphrase_callback() result 0
> Dec 22 10:22:53 runeaudio iwd[2120]: src/wiphy.c:wiphy_select_akm()
> Network is WPA3-Personal...
> Dec 22 10:22:53 runeaudio iwd[2120]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/network.c:network_generate_sae_pt() Generating PT for Group 19
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/network.c:network_generate_sae_pt() Generating PT for Group 20
> Dec 22 10:22:53 runeaudio iwd[2120]: src/wiphy.c:wiphy_select_akm()
> Network is WPA3-Personal...
> Dec 22 10:22:53 runeaudio iwd[2120]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 10:22:53 runeaudio iwd[2120]: src/pmksa.c:pmksa_cache_get()
> Returning entry with PMKID: 8844b6b6dfda8f93a087e9ea6>
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/netdev.c:netdev_connect_common() Skipping SAE by using PMKSA cache
> Dec 22 10:22:53 runeaudio iwd[2120]: src/netdev.c:netdev_cqm_rssi_update(=
)
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 13
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/wiphy.c:wiphy_radio_work_next() Starting work item 13
> Dec 22 10:22:53 runeaudio iwd[2120]: event: connect-info, ssid:
> deskSAE, bss: d8:3a:dd:60:a3:0c, signal: -49, load: 0/255
> Dec 22 10:22:53 runeaudio iwd[2120]: event: state, old: disconnected,
> new: connecting
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/netdev.c:netdev_cmd_set_cqm_cb() CMD_SET_CQM not supported,
> falling back to pol>
> Dec 22 10:22:53 runeaudio connmand[648]: Interface wlan0 [ wifi ]
> state is configuration
> Dec 22 10:22:53 runeaudio iwd[2120]:
> src/netdev.c:netdev_unicast_notify() Unicast notification External
> Auth(127)
> Dec 22 10:22:53 runeaudio iwd[2120]: event: connect-info, External
> Auth to SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
> Dec 22 10:22:53 runeaudio kernel: ieee80211 phy0:
> brcmf_cfg80211_external_auth: External authentication failed: status=3D1
> Dec 22 10:23:38 runeaudio connmand[648]: Interface wlan0 [ wifi ] state i=
s ready
> Dec 22 10:23:38 runeaudio connmand[648]: wlan0 {add} address
> 169.254.193.113/16 label wlan0 family 2
>
> On the Pi4:
> Dec 22 15:43:42 jackrune systemd-networkd[176]: wlan0: Gained IPv6LL
> Dec 22 15:43:59 jackrune iwd[8067]: Error loading /var/lib/iwd//deskSAE.p=
sk
> Dec 22 15:44:10 jackrune connmand[8601]: Interface wlan0 [ wifi ]
> state is association
> Dec 22 15:44:10 jackrune iwd[8067]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 15:44:10 jackrune iwd[8067]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 15:44:10 jackrune iwd[8067]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 15:44:10 jackrune iwd[8067]: event: connect-info, ssid:
> deskSAE, bss: d8:3a:dd:60:a3:0c, signal: -59, load: 0/255
> Dec 22 15:44:10 jackrune iwd[8067]: event: state, old: disconnected,
> new: connecting
> Dec 22 15:44:10 jackrune connmand[8601]: Interface wlan0 [ wifi ]
> state is configuration
> Dec 22 15:44:10 jackrune iwd[8067]: event: connect-info, External Auth
> to SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
> Dec 22 15:44:10 jackrune kernel: ieee80211 phy0:
> brcmf_cfg80211_external_auth: External authentication failed: status=3D1
> Dec 22 15:44:56 jackrune connmand[8601]: Interface wlan0 [ wifi ] state i=
s ready
> Dec 22 15:44:56 jackrune connmand[8601]: wlan0 {add} address
> 169.254.100.21/16 label wlan0 family 2
>
> I think the key line is the "kernel: ieee80211 phy0:
> brcmf_cfg80211_external_auth: External authentication failed:
> status=3D1"
> When It gets this, it gets a 169.x.x.x address and is not connected.
>
> If this error shows up, it will not negotiate a DHCP on any of the 3
> platforms I have tried it on.
>
> If I try again, it will sometimes connect and this error line does not
> appear, I get this which results in a routable address:
>
> Dec 22 10:25:30 runeaudio iwd[2120]: src/agent.c:agent_register()
> agent register called
> Dec 22 10:25:30 runeaudio iwd[2120]: src/agent.c:agent_register()
> agent :1.376 path /agent/12094
> Dec 22 10:25:30 runeaudio iwd[2120]: src/station.c:station_dbus_scan()
> Scan called from DBus
> Dec 22 10:25:30 runeaudio iwd[2120]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 14
> Dec 22 10:25:30 runeaudio iwd[2120]:
> src/wiphy.c:wiphy_radio_work_next() Starting work item 14
> Dec 22 10:25:30 runeaudio iwd[2120]:
> src/station.c:station_dbus_scan_triggered() station_scan_triggered:
> -11
> Dec 22 10:25:30 runeaudio iwd[2120]:
> src/wiphy.c:wiphy_radio_work_done() Work item 14 done
> Dec 22 10:25:30 runeaudio iwd[2120]: Received error during
> CMD_TRIGGER_SCAN: Resource temporarily unavailable (11)
> Dec 22 10:25:30 runeaudio iwd[2120]: src/agent.c:agent_disconnect()
> agent :1.376 disconnected
> Dec 22 10:25:30 runeaudio iwd[2120]: src/agent.c:agent_free() agent
> free 0x5555fdb7f670
> Dec 22 10:25:30 runeaudio kernel: ieee80211 phy0: brcmf_cfg80211_scan:
> Connecting: status (3)
> Dec 22 10:25:37 runeaudio connmand[648]: Interface wlan0 [ wifi ]
> state is association
> Dec 22 10:25:37 runeaudio iwd[2120]: src/network.c:network_connect()
> Dec 22 10:25:37 runeaudio iwd[2120]: src/wiphy.c:wiphy_select_akm()
> Network is WPA3-Personal...
> Dec 22 10:25:37 runeaudio iwd[2120]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/network.c:network_connect_psk() ask_passphrase: true
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/agent.c:agent_request_passphrase() agent 0x5555fdb62200 owner :1.8
> path /net/co>
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/agent.c:agent_send_next_request() send request to :1.8
> /net/connman/iwd_agent
> Dec 22 10:25:37 runeaudio iwd[2120]: src/agent.c:agent_receive_reply()
> agent 0x5555fdb62200 request id 533
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/network.c:passphrase_callback() result 0
> Dec 22 10:25:37 runeaudio iwd[2120]: src/wiphy.c:wiphy_select_akm()
> Network is WPA3-Personal...
> Dec 22 10:25:37 runeaudio iwd[2120]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/network.c:network_generate_sae_pt() Generating PT for Group 19
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/network.c:network_generate_sae_pt() Generating PT for Group 20
> Dec 22 10:25:37 runeaudio iwd[2120]: src/wiphy.c:wiphy_select_akm()
> Network is WPA3-Personal...
> Dec 22 10:25:37 runeaudio iwd[2120]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_cqm_rssi_update(=
)
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 15
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/wiphy.c:wiphy_radio_work_next() Starting work item 15
> Dec 22 10:25:37 runeaudio iwd[2120]: event: connect-info, ssid:
> deskSAE, bss: d8:3a:dd:60:a3:0c, signal: -49, load: 0/255
> Dec 22 10:25:37 runeaudio iwd[2120]: event: state, old: disconnected,
> new: connecting
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_cmd_set_cqm_cb() CMD_SET_CQM not supported,
> falling back to pol>
> Dec 22 10:25:37 runeaudio connmand[648]: Interface wlan0 [ wifi ]
> state is configuration
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_unicast_notify() Unicast notification External
> Auth(127)
> Dec 22 10:25:37 runeaudio iwd[2120]: event: connect-info, External
> Auth to SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_external_auth_sae_tx_authenticate()
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_mlme_notify()
> MLME notification Frame TX Status(60)
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_external_auth_sae_tx_authenticate()
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_mlme_notify()
> MLME notification Frame TX Status(60)
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_external_auth_sae_tx_associate()
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_mlme_notify()
> MLME notification Connect(46)
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_connect_event()
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_connect_event() aborting and ignore_connect_event
> not set, proc>
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_connect_event() expect_connect_failure not set,
> proceed
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:parse_request_ies()
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_connect_event() Request / Response IEs parsed
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_get_oci()
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_get_oci_cb()
> Obtained OCI: freq: 2412, width: 1, center1: 2412,>
> Dec 22 10:25:37 runeaudio iwd[2120]: src/eapol.c:eapol_start()
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/station.c:station_handshake_event() Handshaking
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D3
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D3
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_set_gtk()
> ifindex=3D3 key_idx=3D2
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_set_igtk()
> ifindex=3D3 key_idx=3D5
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/handshake.c:handshake_state_install_ptk() Adding PMKSA expiration
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/station.c:station_handshake_event() Setting keys
> Dec 22 10:25:37 runeaudio iwd[2120]: src/network.c:network_sync_settings(=
)
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_set_tk()
> ifindex=3D3 key_idx=3D0
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_new_group_key_cb() ifindex: 3, err: 0
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_installed:
> 1, igtk_inst>
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:netdev_new_group_management_key_cb() ifindex: 3, err: 0
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_installed:
> 1, igtk_inst>
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_set_station_cb()
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_installed:
> 1, igtk_inst>
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:try_handshake_complete() nhs->complete: 0
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/netdev.c:try_handshake_complete() Invoking handshake_event()
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/handshake.c:handshake_state_cache_pmksa() 0x5555fdb5b6d0
> Dec 22 10:25:37 runeaudio iwd[2120]: src/pmksa.c:pmksa_cache_put()
> Adding entry with PMKID: d109a49b12eabfd6e396947baa7d>
> Dec 22 10:25:37 runeaudio iwd[2120]: src/netdev.c:netdev_connect_ok()
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/station.c:station_connect_cb() 3, result: 0
> Dec 22 10:25:37 runeaudio iwd[2120]: src/station.c:station_connect_ok()
> Dec 22 10:25:37 runeaudio iwd[2120]: event: state, old: connecting,
> new: connecting (netconfig)
> Dec 22 10:25:37 runeaudio iwd[2120]:
> src/wiphy.c:wiphy_radio_work_done() Work item 15 done
> Dec 22 10:25:40 runeaudio iwd[2120]:
> src/netconfig.c:netconfig_event_handler() l_netconfig event 0
> Dec 22 10:25:40 runeaudio iwd[2120]:
> src/netconfig-commit.c:netconfig_commit_print_addrs() installing
> address: 192.168.5>
> Dec 22 10:25:40 runeaudio iwd[2120]:
> src/resolve.c:resolve_systemd_set_dns() ifindex: 3
> Dec 22 10:25:40 runeaudio iwd[2120]:
> src/resolve.c:systemd_builder_add_dns() installing DNS: 192.168.5.1
> Dec 22 10:25:40 runeaudio iwd[2120]: event: state, old: connecting
> (netconfig), new: connected
> Dec 22 10:25:40 runeaudio iwd[2120]:
> src/netconfig-commit.c:netconfig_dhcp_gateway_to_arp() Gateway MAC is
> known, settin>
> Dec 22 10:25:40 runeaudio connmand[648]: wlan0 {add} address
> 192.168.5.177/24 label wlan0 family 2
> Dec 22 10:25:40 runeaudio avahi-daemon[485]: Joining mDNS multicast
> group on interface wlan0.IPv4 with address 192.168.5>
> Dec 22 10:25:40 runeaudio avahi-daemon[485]: New relevant interface
> wlan0.IPv4 for mDNS.
> Dec 22 10:25:40 runeaudio avahi-daemon[485]: Registering new address
> record for 192.168.5.177 on wlan0.IPv4.
> Dec 22 10:25:40 runeaudio systemd-resolved[479]: wlan0: Bus client set
> DNS server list to: 192.168.5.1
> Dec 22 10:25:42 runeaudio connmand[648]: Interface wlan0 [ wifi ] state i=
s ready
>
> When I try from iwctl (on the pi4 for example) to connect and it
> fails, it is slightly different, but I still get that same error
> message:
>
> Dec 22 15:57:29 jackrune iwd[16938]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 15:57:29 jackrune iwd[16938]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 22 15:57:29 jackrune iwd[16938]: event: connect-info, ssid:
> deskSAE, bss: d8:3a:dd:60:a3:0c, signal: -56, load: 0/255
> Dec 22 15:57:29 jackrune iwd[16938]: event: state, old: disconnected,
> new: connecting
> Dec 22 15:57:29 jackrune connmand[16785]: Interface wlan0 [ wifi ]
> state is configuration
> Dec 22 15:57:29 jackrune iwd[16938]: event: connect-info, External
> Auth to SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
> Dec 22 15:57:29 jackrune kernel: ieee80211 phy0:
> brcmf_cfg80211_external_auth: External authentication failed: status=3D1
> Dec 22 15:58:16 jackrune connmand[16785]: Interface wlan0 [ wifi ]
> state is ready
> Dec 22 15:58:16 jackrune connmand[16785]: wlan0 {add} address
> 169.254.94.32/16 label wlan0 family 2
>
> This was duplicated on the Pi3B+, Pi4B and Pi5B.
>
> We are so close.
James,

On a whim, I tried connecting/disconnecting in connman, but with
wpa_supplicant instead of iwd. It works consistently every time I
tried it with wpa_supplicant. I would issue a 'disconnect' and then a
'connect' in connman and it would always grab a DHCP address when it
reconnected. It is when I use iwd that it can fail to make a
connection.

When it does fail, it shows as 'connected' but will not grab a DHCP
address from the AP but not pass any internet traffic.

When it fails to get a DHCP address, in the journal it shows this error:
kernel: ieee80211 phy0: brcmf_cfg80211_external_auth: External
authentication failed: status=3D1
connmand[38061]: Interface wlan0 [ wifi ] state is ready
connmand[38061]: wlan0 {add} address 169.254.4.44/16 label wlan0 family 2

Then it assigns a 169.x.x.x address to wlan0 and then show as
'connected' in connman, but it isn't really connected to anything and
will not pass traffic.

I do not know if it is timing or what. I can send any log or other
info that may be needed to help diagnose.

Regards,

Keith


Return-Path: <linux-wireless+bounces-16514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF239F5B55
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 01:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919BC163538
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 00:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121D6EEAA;
	Wed, 18 Dec 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtmNZ2qk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B229460
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734481294; cv=none; b=L2xp7rPmkrYN2DvM50KHY5nkchNwq4b6HyWkZQT0/FGHI+L0OaFPJnrxosfNsAI9buvqGdFM9gs+HAlpwO8Jzdz/WycmxYPBYCOz96oGGJBMOvkIjuCK6bBI/kB9q3bDGoAZvUjUW5oCEnsMOtzMgIqTKsxl+MLOrtBtMcwXeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734481294; c=relaxed/simple;
	bh=tGF/kctCuV5vS1q0VKcmx76vpJaNIlRlGOPB+DiPvMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtGcqk2/q7RkEGygZ6vU8cgXOh0b+NXBAUZZnh7jOGtGa49ZozfLaQc9ipFsUuJsx9gaWhp6xrIPkmj4mtWORO9N2z4XIVo66Shtr8GiNH4Ig26tqu7XZRyIBO4Uc0eI4L+ZxxaV1L6CEGtFFRNeTmeTS0E3MmVIbStZm9oBxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtmNZ2qk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so3600369a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 16:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734481291; x=1735086091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGF/kctCuV5vS1q0VKcmx76vpJaNIlRlGOPB+DiPvMI=;
        b=KtmNZ2qkF/Y2ZT0lriAuvEVXt2mY8DvuhKKenKVi5hzN8J/PdhfO+26hymKR3cPEIJ
         cIsI9Iz+xPnsNin16NUdI4Z8y0Tl8afXUbfR/cBEIUakjppjllyIZaEhPzPgiYaB6IQK
         LMsnW0jldnQS0Z3n6qjtoAMD6w5WDFZoYo+W/nbKv/ajS1cbT4wDQKt+GbONXSSyqTSV
         wSDcgLxiSRm/PwUcLhNl1eNPuzYGUIFqq+NbGuCqSqDKm5suQI57YqYzfOvNF/mINxDj
         kUKL/2A9u+dvYjda/vkS+0Wsdqnh8EkeNgExAbQFviO6IVTDSGx6FAImnXL3V/R0jafH
         K8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734481291; x=1735086091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGF/kctCuV5vS1q0VKcmx76vpJaNIlRlGOPB+DiPvMI=;
        b=Hxc46FoMHc9DR+zZS+YSiUO93YFbFc8oUGEj9xwq1xUNsRkaHAThJapyqKAGWA1I67
         4pR+t7LUovld4+OAH61jP99iR+bSvNhcvVtv4pG2Ir2zmVRdv3K07sIEqh4LWfiq0OWG
         tb2Cw8nbh/8h+CXugAUIdU7zb8JHBaE9JHLTiGaE7YU1JAcFIa40FTLYcatkvc60BqjS
         7fRO6X8yJ5GrR5DkIkHdXGIA6QWLVkZcZAJF4dEqdPxYNk55SVHTzUw6GbypOgQsHjSd
         7AR+5gujhWUB0lYFBUqCz4YxKnF7xdQkSgbs+Ln39XHb8tqggmPyH6yUcfLDrH6OIda4
         Xa4g==
X-Forwarded-Encrypted: i=1; AJvYcCUWd0YVEsr+GusBuv9qYzl7KdwHhbdlHenxzUYG8O/0BkPPfqUyj3Rs+bg0vqX/aECgJcpD5H7WLvXfKvHDnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfUEqG3+7vrvwfm5CJx3wH/Da2iyBxd6ChM8Enh4Mdnzpyfq4
	zapGrZVrOq0lucPHqo0c1GYAkzTzkgy8qOSeQOj7yfbYfhPITEtvvpj4EWzi9V8uYuFPgJ3wG0H
	4PJrhZ5h9DnMYcLWX4LPkKsdGDc48cYzbtEs=
X-Gm-Gg: ASbGncswK7wXLOI1YS+XaeZjJvcUvQaPPtDTn5hL1fovEJBgitNdhbJD7tln68VwORE
	0nfZ8VW+AYrgWey9IfOmtS7h8hd4qenSG+3fL+WGIThRX0yDNvtrECYcGdqPDxcssk7PeUn8e
X-Google-Smtp-Source: AGHT+IFGtmRzJSQd6Nwzo7/Ksg56FIhZijepVH+lKhFMrN43QqmXlaTCJn3G2Y8g7cMh8hwUnxZlLgxKneUCtKPUliY=
X-Received: by 2002:a17:90a:d00b:b0:2ee:ba84:5cac with SMTP id
 98e67ed59e1d1-2f2e91a9adbmr1217449a91.7.1734481291434; Tue, 17 Dec 2024
 16:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <ff9c1192-42b5-4a28-a8c9-31af9765cbff@broadcom.com> <CAG17S_PrigpkFP=5wcTL9UETwc6aHqXnuTEyeRrZ7Ey1cb-ZLw@mail.gmail.com>
 <193c1173968.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NwSKEJzbk7RNiOKqU_25f6muydbh0DN+ec1Ke6QrR1Qw@mail.gmail.com>
 <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com>
 <21a81894-2e1e-440b-b7ea-27660fa08d9d@broadcom.com> <CAG17S_O5K4Uh2c6xqph5sUZe8gMjhD3z4FDkSSQ0dhCuZA6aug@mail.gmail.com>
 <193cb61e210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_P+cOQMpQda00JTCCKEB6MpPE4X2i8mRrEaM-n5YKdpNg@mail.gmail.com>
 <14ec6009-7b91-4a25-9943-f63da91d8c41@broadcom.com> <caa186d8-1e07-421d-a127-7bb6482ac704@broadcom.com>
 <CAG17S_N0V=_Es0C7wA3fPu2MrBKBM7tEHRXOnVGWiUSxPucaRQ@mail.gmail.com>
 <ec23f0d9-a23c-4684-b0b6-a89141c5ec37@broadcom.com> <CAG17S_PmXNP2bdUU5ErQd-N2jyScqvfKTFsnWgADb3uhqpBsZA@mail.gmail.com>
 <65e4975d-2234-44d6-bdd0-a679df2b1c66@broadcom.com>
In-Reply-To: <65e4975d-2234-44d6-bdd0-a679df2b1c66@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 17 Dec 2024 18:21:20 -0600
Message-ID: <CAG17S_OAPEWsr61cBA1qfNhFst-mYK5a2_VrCZVZhdd-KVM9cw@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org, 
	Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 7:47=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
>
>
> On 12/17/2024 1:13 AM, KeithG wrote:
> > On Mon, Dec 16, 2024 at 1:50=E2=80=AFPM Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On 12/16/2024 1:21 PM, KeithG wrote:
> >>> On Mon, Dec 16, 2024 at 3:47=E2=80=AFAM Arend van Spriel
> >>> <arend.vanspriel@broadcom.com> wrote:
> >>>>
> >>>> On 12/16/2024 10:43 AM, Arend van Spriel wrote:
> >>>>> On 12/16/2024 1:17 AM, KeithG wrote:
> >>>>>> On Sun, Dec 15, 2024 at 11:33=E2=80=AFAM Arend Van Spriel
> >>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>>
> >>>>>>> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.com> wrote=
:
> >>>>>>>
> >>>>>>>> On Sun, Dec 15, 2024 at 6:12=E2=80=AFAM Arend van Spriel
> >>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 12/14/2024 2:34 PM, KeithG wrote:
> >>>>>>>>>> Arend,
> >>>>>>>>>>
> >>>>>>>>>> I looked through the info where I got the latest firmware:
> >>>>>>>>>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi=
-Fi-
> >>>>>>>>>> A-class-Linux-Driver-release-FMAC-2024-11-21-Documents/td-p/90=
5045
> >>>>>>>>>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Blueto=
oth/
> >>>>>>>>>> Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
> >>>>>>>>>> and did not find anything, but I really do not know what I am
> >>>>>>>>>> looking for.
> >>>>>>>>>
> >>>>>>>>> I think I had a bit more luck and maybe found the needle. I sen=
t out
> >>>>>>>>> another RFT patch which hopefully gets rid of the BCME_BADLEN e=
rror.
> >>>>>>>>>
> >>>>>>>>> Regards,
> >>>>>>>>> Arend
> >>>>>>>> Arend,
> >>>>>>>>
> >>>>>>>> Can you send me a link to that patch? I want to try it.
> >>>>>>>
> >>>>>>> Hmm. I explicitly sent it to you, but here is a link to patchwork=
:
> >>>>>>>
> >>>>>>> https://patchwork.kernel.org/project/linux-wireless/
> >>>>>>> patch/20241215120401.238320-1-arend.vanspriel@broadcom.com/
> >>>>>>>
> >>>>>>> You can apply it on top of the other 3 patches.
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>> Arend
> >>>>>>>
> >>>>>> Thanks! I got it.
> >>>>>> I am building now and have tried to apply what I think are the cor=
rect
> >>>>>> patches. They do not apply cleanly and I had to hand edit things. =
My
> >>>>>> guess is I messed something up.
> >>>>>> I will see what happens when I reboot. It'll take a few hours to b=
uild
> >>>>>> on my Pi4 then for me to install it on the 3b+ to test.
> >>>>>>
> >>>>>> I hope I understand which are the '3 other' patches.
> >>>>>>
> >>>>>> This is the one I got from your link:
> >>>>>> RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
> >>>>>>
> >>>>>> These are what I understand are the '3 other patches'
> >>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and=
-
> >>>>>> firmware-events.patch.diff
> >>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.dif=
f
> >>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-i=
n-
> >>>>>> station-mode.patch.diff
> >>>>>>
> >>>>>> If they are not correct could you send me links to them and I'll t=
ry
> >>>>>> again.
> >>>>>
> >>>>> You got it right. Kuddos.
> >>>>
> >>>> Ignored my spelling checker, but apparently it should be "kudos".
> >>>> Another lesson learned today.
> >>>>
> >>>> Regards,
> >>>> Arend
> >>> Arend,
> >>>
> >>> Thanks for the confirmation. My attempt at a hand edit to apply the
> >>> rejected portions resulted in a failed build with the current RPiOS
> >>> kernel in the git repo:
> >>> # uname -a
> >>> Linux jackrune 6.6.64-v8+ #6 SMP PREEMPT Sun Dec 15 23:55:30 CST 2024
> >>> aarch64 GNU/Linux
> >>>
> >>> When I try to apply them, I get this:
> >>> $ patch -Np1 -i
> >>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-fi=
rmware-events.patch.diff
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg802=
11.c
> >>> Hunk #1 FAILED at 6752.
> >>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/common=
.c
> >>> Hunk #1 succeeded at 524 (offset 33 lines).
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> >>> Hunk #1 FAILED at 1359.
> >>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> >>> Hunk #1 succeeded at 74 (offset -1 lines).
> >>> Hunk #2 succeeded at 336 (offset -70 lines).
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.=
h
> >>> Hunk #1 FAILED at 15.
> >>> Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
> >>> 1 out of 2 hunks FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
> >>> $ patch -Np1 -i RFT-v2-
> >>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-fi=
rmware-events.patch.diff
> >>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
> >>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-s=
tation-mode.patch.diff
> >>> $ patch -Np1 -i
> >>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
> >>> Hunk #1 FAILED at 337.
> >>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
> >>> $ patch -Np1 -i
> >>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-s=
tation-mode.patch.diff
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg802=
11.c
> >>> Hunk #1 succeeded at 75 (offset 1 line).
> >>> Hunk #2 FAILED at 1940.
> >>> Hunk #3 FAILED at 2158.
> >>> Hunk #4 FAILED at 2216.
> >>> Hunk #5 succeeded at 5522 (offset 22 lines).
> >>> Hunk #6 succeeded at 5697 (offset 90 lines).
> >>> Hunk #7 succeeded at 6126 (offset 125 lines).
> >>> Hunk #8 succeeded at 7596 with fuzz 1 (offset 255 lines).
> >>> Hunk #9 FAILED at 7647.
> >>> 4 out of 9 hunks FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg802=
11.h
> >>> Hunk #3 succeeded at 243 (offset 15 lines).
> >>> Hunk #4 FAILED at 244.
> >>> Hunk #5 succeeded at 507 (offset 18 lines).
> >>> 1 out of 5 hunks FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h.rej
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/co=
re.c
> >>> Hunk #1 FAILED at 8.
> >>> Hunk #2 FAILED at 39.
> >>> Hunk #3 FAILED at 49.
> >>> 3 out of 3 hunks FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c.rej
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fw=
il_types.h
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/featur=
e.c
> >>> Hunk #1 FAILED at 42.
> >>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c.rej
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/featur=
e.h
> >>> Hunk #1 succeeded at 32 with fuzz 2 (offset 1 line).
> >>> Hunk #2 succeeded at 60 with fuzz 1 (offset 2 lines).
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> >>> Hunk #1 FAILED at 450.
> >>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c.rej
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
> >>> Hunk #1 FAILED at 94.
> >>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.=
h
> >>> Hunk #1 FAILED at 15.
> >>> Hunk #2 succeeded at 47 with fuzz 1 (offset -11 lines).
> >>> 1 out of 2 hunks FAILED -- saving rejects to file
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
> >>> $ patch -Np1 -i RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE=
.diff
> >>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fw=
il_types.h
> >>>
> >>> Is there another missing patch?
> >>>
> >>> The kernel for the RPi is at this commit:
> >>> commit 80533a952218696c0ef1b346bab50dc401e6b74c (HEAD -> rpi-6.6.y,
> >>> origin/rpi-6.6.y, origin/HEAD)
>
> So what repository does origin refer to. Can you share the URL?
>
> I will check if I posted any patches between 6.6 and 6.10+ Get back to
> this later on.
>
> Regards,
> Arend

Arend,

I am using the RaspberryPi repo:
https://github.com/raspberrypi/linux

Thanks!
Keith


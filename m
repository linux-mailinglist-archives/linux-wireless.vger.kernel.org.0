Return-Path: <linux-wireless+bounces-16433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB169F3EB4
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 01:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01DC18831DF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 00:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C00136A;
	Tue, 17 Dec 2024 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd04vIu4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318210E0
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734394421; cv=none; b=Otn9sp/lhoDTuuHBDoobVX8eMQOKR77eQ/QRPlmjllluorDyiHvfYG84+FKwXOiW0ZG2xrTKxDm8HXGL5qaBn3yaPBTZ2SXDfWYiY/JRNhmhtqU+nqUUDuFc8AgZM3H3hxTS/pz396gTeHmverzYVdjBt/Y2fWXcgP2mmdq75Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734394421; c=relaxed/simple;
	bh=Eq6e+Iy+6Y/uUCJtG4zEQrS2FYB7VtBPPclfmv/HM7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSNcqy/XqbnSyUqi6UVoM/bn7kFnn1dTp+uSxSJshnsZZ1JLekGTUu0CvSWYaiMHYD67LAnhXHpNDiiy0OOStOkxU4yOU+Fr63pC2y575Nu+LFbr52+F3dmHABdkdv8WLa3sjf2Np6OpUZ7IsI9buUzuf/eP8UXdVb74NOTU0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd04vIu4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efded08c79so3230526a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 16:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734394418; x=1734999218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq6e+Iy+6Y/uUCJtG4zEQrS2FYB7VtBPPclfmv/HM7Y=;
        b=Qd04vIu4cn6WBpsSwdA1VQ86/xlHZmZbPUURN+sVJ+UBTWtLbE3ZDNwHOSrK0ynlJa
         uVcr2ZwKZYsGrvXdnwMAnnHtL1QNq04gXWs2SOVo2jWYYGEhtBWUplG/gpRSgub5QvDB
         UdFuHSAGOi+ERroP724CNu9r6+SqO/7+mLHrROYKrtNj49ZGJ+HWJi+kyAp3AyfFsJyj
         CWUctva3mdQJGZZ8lOtX8jP29nCxIT7QaUpsnX6qZCE0xlM9VOmsSnxHvwQVK1Nh1+R2
         DVWYnRFm18oEOHUNch4xcgw8agZzyQmBi28xrX/gWTuCiejw1dRZDskrAS62URj0XQYP
         HjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734394418; x=1734999218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eq6e+Iy+6Y/uUCJtG4zEQrS2FYB7VtBPPclfmv/HM7Y=;
        b=bujl/tKAqzn/zd2A9lbEhiXZChCltYL5HsHzVKdryN4MQb+pXqtIcYype7QwH3VaGh
         LQWhIDRA0/Ozg+2tm71ShHnS8o7ypYtYskqGbVb2HRbccMWAj5fkPECSTyVIENL0p6kJ
         MgZBdfSiuJSWIY8NM0wLxrhWox4vGQf7u6m737oy6mHdeeltlrJRxtMTW8nallV3XjM8
         blWD5dhq4eDp1LEolUgBFJVm8pKJDCm6On/nCHxxjXmUzLB/HEc/3fkv2JtnJp25zNk4
         sGnumkhPv2X9DdNe5AXlC/s50pHhDyeTEDRHDHrOQonx7VYHjKnx3d6qb9n6y1g488gg
         CZrg==
X-Forwarded-Encrypted: i=1; AJvYcCWiw+nO1BgbQR6Hk9TtMgOE/U7cW9yqSA94aOiMtZeXFWQjT3HCfaRUNGjCkmLCaju4jtkUIY5Yesc3uyTuSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMnMBTqUhzCUuhblBeglbhkjx6AL1YRK5Ji3nu0RAMnX+I29cf
	4mM9eGGYdEOmw9f75NPDwwZBuVeuP1PQXQh4ZH+315QBU/dQkure9wkwr3TdcuXggqKWuXV7XNf
	jCj6OS79qaEAQeMH9j0sK0h0dpT0=
X-Gm-Gg: ASbGnculLCQVnlN9224p7N3hID/C61DF3/oNkBwJDwasgs09OWMo7vGHJrviyEyZBoJ
	bAuJtsFn94UizyunxQKJsEpo9I6rm+Xpe0O0eO9WqBIQi+xFeiZ2rb2MEsd7PnNbjTcFxS8eA
X-Google-Smtp-Source: AGHT+IECVaH0EpV01FwfEyMg5UJRvQ86VjzOfusekHopJEImmYd9bn+YjYOHpX1K9VONn207fbleSvwGwouahO0awiU=
X-Received: by 2002:a17:90a:ea93:b0:2ee:9a82:5a93 with SMTP id
 98e67ed59e1d1-2f28fb67161mr22525767a91.14.1734394418414; Mon, 16 Dec 2024
 16:13:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_M9wxMsSNyqAQv2oxaCQZ9CAe=GHNjZCbw__2bsAg1hdg@mail.gmail.com>
 <ff9c1192-42b5-4a28-a8c9-31af9765cbff@broadcom.com> <CAG17S_PrigpkFP=5wcTL9UETwc6aHqXnuTEyeRrZ7Ey1cb-ZLw@mail.gmail.com>
 <193c1173968.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NwSKEJzbk7RNiOKqU_25f6muydbh0DN+ec1Ke6QrR1Qw@mail.gmail.com>
 <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com>
 <21a81894-2e1e-440b-b7ea-27660fa08d9d@broadcom.com> <CAG17S_O5K4Uh2c6xqph5sUZe8gMjhD3z4FDkSSQ0dhCuZA6aug@mail.gmail.com>
 <193cb61e210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_P+cOQMpQda00JTCCKEB6MpPE4X2i8mRrEaM-n5YKdpNg@mail.gmail.com>
 <14ec6009-7b91-4a25-9943-f63da91d8c41@broadcom.com> <caa186d8-1e07-421d-a127-7bb6482ac704@broadcom.com>
 <CAG17S_N0V=_Es0C7wA3fPu2MrBKBM7tEHRXOnVGWiUSxPucaRQ@mail.gmail.com> <ec23f0d9-a23c-4684-b0b6-a89141c5ec37@broadcom.com>
In-Reply-To: <ec23f0d9-a23c-4684-b0b6-a89141c5ec37@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 16 Dec 2024 18:13:27 -0600
Message-ID: <CAG17S_PmXNP2bdUU5ErQd-N2jyScqvfKTFsnWgADb3uhqpBsZA@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org, 
	Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:50=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 12/16/2024 1:21 PM, KeithG wrote:
> > On Mon, Dec 16, 2024 at 3:47=E2=80=AFAM Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On 12/16/2024 10:43 AM, Arend van Spriel wrote:
> >>> On 12/16/2024 1:17 AM, KeithG wrote:
> >>>> On Sun, Dec 15, 2024 at 11:33=E2=80=AFAM Arend Van Spriel
> >>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>
> >>>>> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.com> wrote:
> >>>>>
> >>>>>> On Sun, Dec 15, 2024 at 6:12=E2=80=AFAM Arend van Spriel
> >>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>>
> >>>>>>> On 12/14/2024 2:34 PM, KeithG wrote:
> >>>>>>>> Arend,
> >>>>>>>>
> >>>>>>>> I looked through the info where I got the latest firmware:
> >>>>>>>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi-F=
i-
> >>>>>>>> A-class-Linux-Driver-release-FMAC-2024-11-21-Documents/td-p/9050=
45
> >>>>>>>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetoot=
h/
> >>>>>>>> Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
> >>>>>>>> and did not find anything, but I really do not know what I am
> >>>>>>>> looking for.
> >>>>>>>
> >>>>>>> I think I had a bit more luck and maybe found the needle. I sent =
out
> >>>>>>> another RFT patch which hopefully gets rid of the BCME_BADLEN err=
or.
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>> Arend
> >>>>>> Arend,
> >>>>>>
> >>>>>> Can you send me a link to that patch? I want to try it.
> >>>>>
> >>>>> Hmm. I explicitly sent it to you, but here is a link to patchwork:
> >>>>>
> >>>>> https://patchwork.kernel.org/project/linux-wireless/
> >>>>> patch/20241215120401.238320-1-arend.vanspriel@broadcom.com/
> >>>>>
> >>>>> You can apply it on top of the other 3 patches.
> >>>>>
> >>>>> Regards,
> >>>>> Arend
> >>>>>
> >>>> Thanks! I got it.
> >>>> I am building now and have tried to apply what I think are the corre=
ct
> >>>> patches. They do not apply cleanly and I had to hand edit things. My
> >>>> guess is I messed something up.
> >>>> I will see what happens when I reboot. It'll take a few hours to bui=
ld
> >>>> on my Pi4 then for me to install it on the 3b+ to test.
> >>>>
> >>>> I hope I understand which are the '3 other' patches.
> >>>>
> >>>> This is the one I got from your link:
> >>>> RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
> >>>>
> >>>> These are what I understand are the '3 other patches'
> >>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-
> >>>> firmware-events.patch.diff
> >>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
> >>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-
> >>>> station-mode.patch.diff
> >>>>
> >>>> If they are not correct could you send me links to them and I'll try
> >>>> again.
> >>>
> >>> You got it right. Kuddos.
> >>
> >> Ignored my spelling checker, but apparently it should be "kudos".
> >> Another lesson learned today.
> >>
> >> Regards,
> >> Arend
> > Arend,
> >
> > Thanks for the confirmation. My attempt at a hand edit to apply the
> > rejected portions resulted in a failed build with the current RPiOS
> > kernel in the git repo:
> > # uname -a
> > Linux jackrune 6.6.64-v8+ #6 SMP PREEMPT Sun Dec 15 23:55:30 CST 2024
> > aarch64 GNU/Linux
> >
> > When I try to apply them, I get this:
> > $ patch -Np1 -i
> > RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firm=
ware-events.patch.diff
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211=
.c
> > Hunk #1 FAILED at 6752.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> > Hunk #1 succeeded at 524 (offset 33 lines).
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> > Hunk #1 FAILED at 1359.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> > Hunk #1 succeeded at 74 (offset -1 lines).
> > Hunk #2 succeeded at 336 (offset -70 lines).
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
> > Hunk #1 FAILED at 15.
> > Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
> > 1 out of 2 hunks FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
> > $ patch -Np1 -i RFT-v2-
> > RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firm=
ware-events.patch.diff
> > RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
> > RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-sta=
tion-mode.patch.diff
> > $ patch -Np1 -i
> > RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
> > Hunk #1 FAILED at 337.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
> > $ patch -Np1 -i
> > RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-sta=
tion-mode.patch.diff
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211=
.c
> > Hunk #1 succeeded at 75 (offset 1 line).
> > Hunk #2 FAILED at 1940.
> > Hunk #3 FAILED at 2158.
> > Hunk #4 FAILED at 2216.
> > Hunk #5 succeeded at 5522 (offset 22 lines).
> > Hunk #6 succeeded at 5697 (offset 90 lines).
> > Hunk #7 succeeded at 6126 (offset 125 lines).
> > Hunk #8 succeeded at 7596 with fuzz 1 (offset 255 lines).
> > Hunk #9 FAILED at 7647.
> > 4 out of 9 hunks FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211=
.h
> > Hunk #3 succeeded at 243 (offset 15 lines).
> > Hunk #4 FAILED at 244.
> > Hunk #5 succeeded at 507 (offset 18 lines).
> > 1 out of 5 hunks FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h.rej
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core=
.c
> > Hunk #1 FAILED at 8.
> > Hunk #2 FAILED at 39.
> > Hunk #3 FAILED at 49.
> > 3 out of 3 hunks FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c.rej
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil=
_types.h
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.=
c
> > Hunk #1 FAILED at 42.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c.rej
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.=
h
> > Hunk #1 succeeded at 32 with fuzz 2 (offset 1 line).
> > Hunk #2 succeeded at 60 with fuzz 1 (offset 2 lines).
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> > Hunk #1 FAILED at 450.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c.rej
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
> > Hunk #1 FAILED at 94.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
> > Hunk #1 FAILED at 15.
> > Hunk #2 succeeded at 47 with fuzz 1 (offset -11 lines).
> > 1 out of 2 hunks FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
> > $ patch -Np1 -i RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.d=
iff
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil=
_types.h
> >
> > Is there another missing patch?
> >
> > The kernel for the RPi is at this commit:
> > commit 80533a952218696c0ef1b346bab50dc401e6b74c (HEAD -> rpi-6.6.y,
> > origin/rpi-6.6.y, origin/HEAD)
>
> Sorry. I probably missed something, but earlier you had a log where the
> ext_auth exchange between iwd and brcmfmac almost worked, but firmware
> return BCME_BADLEN. What code base was that tested with. I assumed with
> my 3 patches, but now I am confused.
>
> Regards,
> Arend

Arend,

Sorry for the confusion. That was with the Basic/Standard kernel as it
existed at the time. 6.6.63 or so. No patches added.

Keith


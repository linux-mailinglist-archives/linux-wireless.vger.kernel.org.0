Return-Path: <linux-wireless+bounces-16614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E84B9F7C88
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 14:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5825F16ADF4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC2314A630;
	Thu, 19 Dec 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3mUPm7V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A18200A3
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615551; cv=none; b=ePrm4KqSt7xWYMbWeBI8WsAJkA9EIrRE8hc4otYzyHroyxs3Z6MTdNt6hY0cwrEdgt64/htKI2FyXgzxCLEdHkIw2jJPB9bSn2jAy7bV2ojtaIG4dR8Q92SW2wvvPgO2sxD8vhydbBuK2HkCVaWHXiwGMncVDsatcOJdJAFiAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615551; c=relaxed/simple;
	bh=G9J7VCw1gd+EpXTDK0PxOZcC51U5x+ILqRoXqfmeXko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R563Vlz0Hvy/MP6VdpQKkWDTvspMfUAt0geyXpE/Ww7QD4+WhNpORPG9MLOoPzrdN/V/bu86rBCr4u65thPY9aoaekKBFZlUO2ztzXK/gZrmNF1LjB9OpuiqMG2rG463rpLjo8WPpO1iCkz41FMbK8U1ltXj4cS0ZR3iFOO4SAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3mUPm7V; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so494843a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 05:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734615548; x=1735220348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qaL7dTq98ZuCeuGn1uoMAgpyN9pB9SLGevdSFTescHk=;
        b=Q3mUPm7VKNHoGjAe8QDKRalH00uAC2OQZfc8wB9/WzPmEVtxyWwwEICquqqihu1wpU
         YlEvwJbdqalu0tHyWj3/1XJwHjDqScdwvS/F4ouxi0CyhArE9RVCdEFooEigFbs/xVhY
         XNV7qPVwgmnGnMKsWk5vFwPdR8jpR7cU5uY8x4YVb/u0TpMYumM5zuCivG4IN9bb5AC3
         +I9wQ57YQX7yKN0iQ2NnpdvoRc15v6bfrm1biW2SsbI6mXCyCFAkovwx5lk++XF2Kp5C
         Fh+HUU7bX8t+SJlldah1HthhysCw7dyWJfpeoXf0tN4jCXuK4aIbiccQLIkiGXs4lgkK
         6ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734615548; x=1735220348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaL7dTq98ZuCeuGn1uoMAgpyN9pB9SLGevdSFTescHk=;
        b=RLbdXdDGWEKDX0DxkHW9DSJx9jio6Ilp1hwmoXljj1xpj7XTwwysI6nr38CiiHwgU7
         9e+A41Il7yku/1mGKH8OCWXa2OWWDPjxdQTtsJhxaUr7Ru6+4ech/1sdUmph/H+IALJK
         M9/NuUojQUMp39dbXdrFIoNe6h6QVaCQ0WaSQ2MOwUExYEklsO7J8HtzY/V5ZdtOMS14
         d5Y+cvTgtLwsZws+eTrefve6UG0Io/k6n8GgFDBIyA7DJn1rwMff5J8vusF6MuQ0Wuwd
         hyM8ohu/Na7AO4UXKCqbmZZVXZh3gJcOzmmcAgcUl/EDxIVSqSpah+MhKO6QICN+GlkQ
         4mTg==
X-Forwarded-Encrypted: i=1; AJvYcCUK8wrXPuzLwKmMC9aZST6dWByoPBXuPZrpd4gqY7eMxYjpuJoNFx7DecDvl2hoGF0a6Ku1k3qHoAbyiP1rAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwZZyd0z1pez+F4lLXxCef3T4Kvcl30hldL/bywn3XDPX8iDI
	hJi+7n8lDYwCW8b9rzpnmJZJ1mmwfF8YDG4bB5dQw7jSVbhMCWJEj1kIM/c7XVhgKYkJVoROOYZ
	se1P811kZifq0mVk4vF55BXzGJywPGU6SGYE=
X-Gm-Gg: ASbGnct51fvQ9e9dKxf7wm8HdcycZ4qGNawMIZJA68WjXrcNNoC4LlDCKGAVXcBX5/z
	yZ6X7MP2G+Iy/3oTkEFFCHwcxoZx3VcPkLGleHA==
X-Google-Smtp-Source: AGHT+IEpZtf6T2gnPLfW/wpabZWl8TNpbkOT6QMbSFE+VAJVwnQ4g6/Hhfq1V5wdeVsb1qJmBXxFWKmRFsk1A/cpbqY=
X-Received: by 2002:a17:90b:5490:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f2e91efe34mr10622979a91.14.1734615548133; Thu, 19 Dec 2024
 05:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <21a81894-2e1e-440b-b7ea-27660fa08d9d@broadcom.com> <CAG17S_O5K4Uh2c6xqph5sUZe8gMjhD3z4FDkSSQ0dhCuZA6aug@mail.gmail.com>
 <193cb61e210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_P+cOQMpQda00JTCCKEB6MpPE4X2i8mRrEaM-n5YKdpNg@mail.gmail.com>
 <14ec6009-7b91-4a25-9943-f63da91d8c41@broadcom.com> <caa186d8-1e07-421d-a127-7bb6482ac704@broadcom.com>
 <CAG17S_N0V=_Es0C7wA3fPu2MrBKBM7tEHRXOnVGWiUSxPucaRQ@mail.gmail.com>
 <ec23f0d9-a23c-4684-b0b6-a89141c5ec37@broadcom.com> <CAG17S_PmXNP2bdUU5ErQd-N2jyScqvfKTFsnWgADb3uhqpBsZA@mail.gmail.com>
 <65e4975d-2234-44d6-bdd0-a679df2b1c66@broadcom.com> <CAG17S_OAPEWsr61cBA1qfNhFst-mYK5a2_VrCZVZhdd-KVM9cw@mail.gmail.com>
 <c6e8ab71-d1e3-41a1-925c-9013f5a87f12@broadcom.com> <CAG17S_MoZDbu1vSt+=80xs+Cje_PPFhFwPxmWDUeNPJ9qRZ6bw@mail.gmail.com>
 <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com> <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com>
In-Reply-To: <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 19 Dec 2024 07:38:56 -0600
Message-ID: <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: James Prestwood <prestwoj@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000091a35f06299fa757"

--00000000000091a35f06299fa757
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 6:46=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Keith,
>
> On 12/18/24 5:46 PM, KeithG wrote:
> > On Wed, Dec 18, 2024 at 8:10=E2=80=AFAM KeithG <ys3al35l@gmail.com> wro=
te:
> >> On Wed, Dec 18, 2024 at 4:21=E2=80=AFAM Arend van Spriel
> >> <arend.vanspriel@broadcom.com> wrote:
> >>> On 12/18/2024 1:21 AM, KeithG wrote:
> >>>> On Tue, Dec 17, 2024 at 7:47=E2=80=AFAM Arend van Spriel
> >>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>
> >>>>>
> >>>>> On 12/17/2024 1:13 AM, KeithG wrote:
> >>>>>> On Mon, Dec 16, 2024 at 1:50=E2=80=AFPM Arend van Spriel
> >>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>> On 12/16/2024 1:21 PM, KeithG wrote:
> >>>>>>>> On Mon, Dec 16, 2024 at 3:47=E2=80=AFAM Arend van Spriel
> >>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>>>> On 12/16/2024 10:43 AM, Arend van Spriel wrote:
> >>>>>>>>>> On 12/16/2024 1:17 AM, KeithG wrote:
> >>>>>>>>>>> On Sun, Dec 15, 2024 at 11:33=E2=80=AFAM Arend Van Spriel
> >>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>>>>>>> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.com> =
wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>>> On Sun, Dec 15, 2024 at 6:12=E2=80=AFAM Arend van Spriel
> >>>>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>>>>>>>>> On 12/14/2024 2:34 PM, KeithG wrote:
> >>>>>>>>>>>>>>> Arend,
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I looked through the info where I got the latest firmware=
:
> >>>>>>>>>>>>>>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Lin=
ux/Wi-Fi-
> >>>>>>>>>>>>>>> A-class-Linux-Driver-release-FMAC-2024-11-21-Documents/td=
-p/905045
> >>>>>>>>>>>>>>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-B=
luetooth/
> >>>>>>>>>>>>>>> Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/90=
2888
> >>>>>>>>>>>>>>> and did not find anything, but I really do not know what =
I am
> >>>>>>>>>>>>>>> looking for.
> >>>>>>>>>>>>>> I think I had a bit more luck and maybe found the needle. =
I sent out
> >>>>>>>>>>>>>> another RFT patch which hopefully gets rid of the BCME_BAD=
LEN error.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Regards,
> >>>>>>>>>>>>>> Arend
> >>>>>>>>>>>>> Arend,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Can you send me a link to that patch? I want to try it.
> >>>>>>>>>>>> Hmm. I explicitly sent it to you, but here is a link to patc=
hwork:
> >>>>>>>>>>>>
> >>>>>>>>>>>> https://patchwork.kernel.org/project/linux-wireless/
> >>>>>>>>>>>> patch/20241215120401.238320-1-arend.vanspriel@broadcom.com/
> >>>>>>>>>>>>
> >>>>>>>>>>>> You can apply it on top of the other 3 patches.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Regards,
> >>>>>>>>>>>> Arend
> >>>>>>>>>>>>
> >>>>>>>>>>> Thanks! I got it.
> >>>>>>>>>>> I am building now and have tried to apply what I think are th=
e correct
> >>>>>>>>>>> patches. They do not apply cleanly and I had to hand edit thi=
ngs. My
> >>>>>>>>>>> guess is I messed something up.
> >>>>>>>>>>> I will see what happens when I reboot. It'll take a few hours=
 to build
> >>>>>>>>>>> on my Pi4 then for me to install it on the 3b+ to test.
> >>>>>>>>>>>
> >>>>>>>>>>> I hope I understand which are the '3 other' patches.
> >>>>>>>>>>>
> >>>>>>>>>>> This is the one I got from your link:
> >>>>>>>>>>> RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
> >>>>>>>>>>>
> >>>>>>>>>>> These are what I understand are the '3 other patches'
> >>>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callback=
s-and-
> >>>>>>>>>>> firmware-events.patch.diff
> >>>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patc=
h.diff
> >>>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authenticat=
ion-in-
> >>>>>>>>>>> station-mode.patch.diff
> >>>>>>>>>>>
> >>>>>>>>>>> If they are not correct could you send me links to them and I=
'll try
> >>>>>>>>>>> again.
> >>>>>>>>>> You got it right. Kuddos.
> >>>>>>>>> Ignored my spelling checker, but apparently it should be "kudos=
".
> >>>>>>>>> Another lesson learned today.
> >>>>>>>>>
> >>>>>>>>> Regards,
> >>>>>>>>> Arend
> >>>>>>>> Arend,
> >>>>>>>>
> >>>>>>>> Thanks for the confirmation. My attempt at a hand edit to apply =
the
> >>>>>>>> rejected portions resulted in a failed build with the current RP=
iOS
> >>>>>>>> kernel in the git repo:
> >>>>>>>> # uname -a
> >>>>>>>> Linux jackrune 6.6.64-v8+ #6 SMP PREEMPT Sun Dec 15 23:55:30 CST=
 2024
> >>>>>>>> aarch64 GNU/Linux
> >>>>>>>>
> >>>>>>>> When I try to apply them, I get this:
> >>>>>>>> $ patch -Np1 -i
> >>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-a=
nd-firmware-events.patch.diff
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/c=
fg80211.c
> >>>>>>>> Hunk #1 FAILED at 6752.
> >>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/c=
ommon.c
> >>>>>>>> Hunk #1 succeeded at 524 (offset 33 lines).
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/c=
ore.c
> >>>>>>>> Hunk #1 FAILED at 1359.
> >>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/f=
weh.c
> >>>>>>>> Hunk #1 succeeded at 74 (offset -1 lines).
> >>>>>>>> Hunk #2 succeeded at 336 (offset -70 lines).
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/f=
wvid.h
> >>>>>>>> Hunk #1 FAILED at 15.
> >>>>>>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
> >>>>>>>> 1 out of 2 hunks FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
> >>>>>>>> $ patch -Np1 -i RFT-v2-
> >>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-a=
nd-firmware-events.patch.diff
> >>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.d=
iff
> >>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication=
-in-station-mode.patch.diff
> >>>>>>>> $ patch -Np1 -i
> >>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.d=
iff
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/f=
weh.h
> >>>>>>>> Hunk #1 FAILED at 337.
> >>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
> >>>>>>>> $ patch -Np1 -i
> >>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication=
-in-station-mode.patch.diff
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/c=
fg80211.c
> >>>>>>>> Hunk #1 succeeded at 75 (offset 1 line).
> >>>>>>>> Hunk #2 FAILED at 1940.
> >>>>>>>> Hunk #3 FAILED at 2158.
> >>>>>>>> Hunk #4 FAILED at 2216.
> >>>>>>>> Hunk #5 succeeded at 5522 (offset 22 lines).
> >>>>>>>> Hunk #6 succeeded at 5697 (offset 90 lines).
> >>>>>>>> Hunk #7 succeeded at 6126 (offset 125 lines).
> >>>>>>>> Hunk #8 succeeded at 7596 with fuzz 1 (offset 255 lines).
> >>>>>>>> Hunk #9 FAILED at 7647.
> >>>>>>>> 4 out of 9 hunks FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/c=
fg80211.h
> >>>>>>>> Hunk #3 succeeded at 243 (offset 15 lines).
> >>>>>>>> Hunk #4 FAILED at 244.
> >>>>>>>> Hunk #5 succeeded at 507 (offset 18 lines).
> >>>>>>>> 1 out of 5 hunks FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h.rej
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/c=
yw/core.c
> >>>>>>>> Hunk #1 FAILED at 8.
> >>>>>>>> Hunk #2 FAILED at 39.
> >>>>>>>> Hunk #3 FAILED at 49.
> >>>>>>>> 3 out of 3 hunks FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c.rej
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/c=
yw/fwil_types.h
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/f=
eature.c
> >>>>>>>> Hunk #1 FAILED at 42.
> >>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c.rej
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/f=
eature.h
> >>>>>>>> Hunk #1 succeeded at 32 with fuzz 2 (offset 1 line).
> >>>>>>>> Hunk #2 succeeded at 60 with fuzz 1 (offset 2 lines).
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/f=
weh.c
> >>>>>>>> Hunk #1 FAILED at 450.
> >>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c.rej
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/f=
weh.h
> >>>>>>>> Hunk #1 FAILED at 94.
> >>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/f=
wvid.h
> >>>>>>>> Hunk #1 FAILED at 15.
> >>>>>>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -11 lines).
> >>>>>>>> 1 out of 2 hunks FAILED -- saving rejects to file
> >>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.r
> >>>>>>>> $ patch -Np1 -i RFT-brcmfmac-Fix-structure-size-for-WPA3-externa=
l-SAE.diff
> >>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/c=
yw/fwil_types.h
> >>>>>>>>
> >>>>>>>> Is there another missing patch?
> >>>>>>>>
> >>>>>>>> The kernel for the RPi is at this commit:
> >>>>>>>> commit 80533a952218696c0ef1b346bab50dc401e6b74c (HEAD -> rpi-6.6=
.y,
> >>>>>>>> origin/rpi-6.6.y, origin/HEAD)
> >>>>> So what repository does origin refer to. Can you share the URL?
> >>>>>
> >>>>> I will check if I posted any patches between 6.6 and 6.10+ Get back=
 to
> >>>>> this later o
> >>>>>
> >>>>> Regards,
> >>>>> Arend
> >>>> Arend,
> >>>>
> >>>> I am using the RaspberryPi repo:
> >>>> https://github.com/raspberrypi/linux
> >>> I was afraid you would say that. So we need to determine what brcmfma=
c
> >>> patches are in there compared to upstream kernel. So checking the cod=
e I
> >>> think you should apply only the "Fix-structure-size" patch to
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h. Let me
> >>> know if that works for you.
> >>>
> >>> Gr. AvS
> >> Arend,
> >>
> >> That patch applied to the file in the folder you suggested. I am
> >> building a kernel now and will see any changes this evening. Thanks
> >> for the help.
> >>
> >> Regards,
> >>
> >> Keith
> > Arend,
> >
> > Thanks for the guidance and help.
> >
> > I tried with the patched kernel and was unable to connect. The 2
> > attached files are the log with brcmfmac debugging and iwd debugging
> > turned o. and the other is an iwmon capture of an attempt to connect.
> > This time, though, I get no IP address at all. Just an error out when
> > I try to connect using iwctl. I get:
> >
> > [iwd]# station wlan0 connect deskSAE
> > Type the network passphrase for deskSAE psk.
> > Passphrase: *********
> > Operation failed
> > NetworkConfigurationEnabled: enabled
> > StateDirectory: /var/lib/iwd
> > Version: 3.1
> > This is with kernel:
> > Linux jackrune 6.6.66-v8+ #7 SMP PREEMPT Wed Dec 18 10:18:01 CST 2024
> > aarch64 GNU/Linux
> > and this firmware:
> > Dec 18 19:37:08 jackrune kernel: brcmfmac: brcmf_fw_alloc_request:
> > using brcm/brcmfmac43455-sdio for chip BCM4345/6
> > Dec 18 19:37:08 jackrune kernel: usbcore: registered new interface
> > driver brcmfmac
> > Dec 18 19:37:09 jackrune kernel: brcmfmac: brcmf_c_process_txcap_blob:
> > no txcap_blob available (err=3D-2)
> > Dec 18 19:37:09 jackrune kernel: brcmfmac: brcmf_c_preinit_dcmds:
> > Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
> > (be70ab3 CY) FWID 01-95efe7fa
>
> Even closer this time. I've just sent a patch to the IWD mailing list.
> Please try that along with Arend's kernel patch.
>
> Thanks,
>
> James
>
> >
> > Keith
James,

It worked. I built iwd then tried to connect via iwctl and it
connected to a WPA3 AP. I got an IP and I can ping the AP from the
RPi.! It is a first! Woot Woot!

[iwd]# station wlan0 connect deskSAE
                               Available networks
---------------------------------------------------------------------------=
-----
      Network name                      Security            Signal
---------------------------------------------------------------------------=
-----
      deskSAE                           psk                 ****

Type the network passphrase for deskSAE psk.
Passphrase: *********

When I go to connman, it shows connected and I can ping.

(clear out configs and reboot)
When I tried from connmanctl it also connects! Seems with this patch
to iwd and Arend's patch to the driver that WPA3 now works with RPis

I had to apply Arend's patch to the 6.6.y source which has the
brcm80211 structured a bit differently and the file to patch is in a
different folder. the patch, corrected for 6.6.y, is attached.

Keith

--00000000000091a35f06299fa757
Content-Type: text/x-patch; charset="US-ASCII"; name="brcm80211_wpa3.patch"
Content-Disposition: attachment; filename="brcm80211_wpa3.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m4vda3o30>
X-Attachment-Id: f_m4vda3o30

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNt
Zm1hYy9md2lsX3R5cGVzLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAy
MTEvYnJjbWZtYWMvZndpbF90eXBlcy5oCmluZGV4IGE1Zjk2ZWZkYmFjMC4uMDQ0ZmUwYjYyMzk4
IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJj
bWZtYWMvZndpbF90eXBlcy5oCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2Jy
Y204MDIxMS9icmNtZm1hYy9md2lsX3R5cGVzLmgKQEAgLTYxNiw2ICs2MTYsNyBAQCBzdHJ1Y3Qg
YnJjbWZfYXV0aF9yZXFfc3RhdHVzX2xlIHsKIAl1OCBwZWVyX21hY1tFVEhfQUxFTl07CiAJX19s
ZTMyIHNzaWRfbGVuOwogCXU4IHNzaWRbSUVFRTgwMjExX01BWF9TU0lEX0xFTl07CisJdTggcG1r
aWRbV0xBTl9QTUtJRF9MRU5dOwogfTsKIAogLyoqCg==
--00000000000091a35f06299fa757--


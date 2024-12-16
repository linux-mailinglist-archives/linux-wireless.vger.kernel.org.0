Return-Path: <linux-wireless+bounces-16416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89849F3069
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 13:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324F1165C8A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D280204C12;
	Mon, 16 Dec 2024 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNWc+OBF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44C20012C
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351689; cv=none; b=E9lwc/S8Y1/Jn6AYXk8uYOn2hugqwo7HIOqE/fAEAntb5QBU9nnTFC3J1HYnUvh7MLbyBlQ2iSkuPtuvsqLKOXtccrqv1ELinTTJBJ31xh4phTA4crfO2BlH6FeUuu92DL0d4MJY6q5oDOEIr6xNUQLpqxewVA9VhxuxpWK/45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351689; c=relaxed/simple;
	bh=0WyC2IeHZDyDnuMsl52lnXq7+BKsXNMBc4Z+ascTm6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZM4UvXmNf8rOBFOaFLLuU5xSZVtoF6SlgwB1juwGX0+MZUYoFWu3qyS4aubsiYCWLWzwCzmBFETwR9WO1T5md3QeQ3Xfd8kK/7H9lUBKMptA/y5vUgaCJg1jkNVl9ZMD5gsO3cebwi2Y8tDT1PRXAi85yRF36EWLV9LkZOGp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNWc+OBF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so3582082a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 04:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734351685; x=1734956485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WyC2IeHZDyDnuMsl52lnXq7+BKsXNMBc4Z+ascTm6M=;
        b=cNWc+OBFcfXRJTTgLv22GYkApz2uApiy2EYLujXtTNpdDydtowppkHlphXiolSv2lc
         CwniUtZrLY8Z0tUqhl5Chfgu4FplPkXZr9k+VG/Y0W4VdffUqBBKQNT8MozkrfOKMhlW
         Jp1H54WGNJWL2yGa83hY/9GCzLEx0HlxChjbK9YjeLns3C+jqeKgpNVobQU8GL9hBPeO
         c8g+KDhJPPVFXkBpLM1L6zVJa9EOXDovr/TraDLWHOqYIJeF39PwhF/Qg+V/NQggpNkE
         z2aAtnlW4sMJfE2bhzQ/8FXnvqcd7tT103qZq0ZR4mZUIwJoXHJqOxvgjOk+K6+6PMDE
         hF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351685; x=1734956485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WyC2IeHZDyDnuMsl52lnXq7+BKsXNMBc4Z+ascTm6M=;
        b=HCj/9Ei401LIHTJiqm5AJcEOt79T8L8u6x7K0oHlOV6iQ6Hp3al9EO4ddmcdbfcCw2
         rwkDg5GG5MkbZyjzln59uFOsvE6AWdRGiNelgfxvACy7+0kCFztWAhF3h71CGaGhObx2
         +QJtG/pxIw/1Z6qOLfBpEvhnF7zsBdMbwE2Y7tMgg0azwFd3954nAXS2y1YJ17HJYvdD
         BwkytJJPLEux2bPBYXABkNW8a5s0bXAd+TKfunHfN3DNdm6vCA4KPTuEOHD+HuP7bPPm
         THHrBl2y51nDKRLblW0eoX9Dzt7oaBRBvxdtogKZjLNfSIiH4fbLgHd3DKRf8YnLOsQ3
         IA4w==
X-Forwarded-Encrypted: i=1; AJvYcCVlP3a95G+EFNht8v17mS5bW0fKXhQ8R2YcBWFoW87uLVk46G3QLCEe9djAvkK5fC8VbuX5AhlrnoQNvRRRCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KbgwBmU41wRBy50BtNWpdLVOsUtpJPKqGjakSGWlvdaydMbM
	VGIYhj+wtcj34xjKDRvx/j2t1sc3nlYR1TChKWFq5BMusWBUPM1s+DL4lO5UjbUDXhW6pk9nUZg
	PVNyCQMC0cL88D0A63uXJFyppGww=
X-Gm-Gg: ASbGncsUkPsrULALCspEhRTu9TqXGrudYX1wX+5g0LKCgZ+/IxkFzgSEFvVywM6C6T8
	YIkeWqUMpK6ajqQIGGChShTZWuBDds3fO9ayCeQDE1w780ZJbO59kjlDRtMGYWtwtOtmJYh1s
X-Google-Smtp-Source: AGHT+IGR4UMN9R8ahkeZaGBKjWoFtKaVhjC3RwgJn+blQV7phArGzZZatHMcudEESime6WX6n9GN6o1X9UWU08NuL1c=
X-Received: by 2002:a17:90b:2541:b0:2ee:c918:cd42 with SMTP id
 98e67ed59e1d1-2f28fd704c1mr15976471a91.22.1734351684950; Mon, 16 Dec 2024
 04:21:24 -0800 (PST)
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
In-Reply-To: <caa186d8-1e07-421d-a127-7bb6482ac704@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 16 Dec 2024 06:21:13 -0600
Message-ID: <CAG17S_N0V=_Es0C7wA3fPu2MrBKBM7tEHRXOnVGWiUSxPucaRQ@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org, 
	Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 3:47=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 12/16/2024 10:43 AM, Arend van Spriel wrote:
> > On 12/16/2024 1:17 AM, KeithG wrote:
> >> On Sun, Dec 15, 2024 at 11:33=E2=80=AFAM Arend Van Spriel
> >> <arend.vanspriel@broadcom.com> wrote:
> >>>
> >>> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.com> wrote:
> >>>
> >>>> On Sun, Dec 15, 2024 at 6:12=E2=80=AFAM Arend van Spriel
> >>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>
> >>>>> On 12/14/2024 2:34 PM, KeithG wrote:
> >>>>>> Arend,
> >>>>>>
> >>>>>> I looked through the info where I got the latest firmware:
> >>>>>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi-Fi-
> >>>>>> A-class-Linux-Driver-release-FMAC-2024-11-21-Documents/td-p/905045
> >>>>>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/
> >>>>>> Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
> >>>>>> and did not find anything, but I really do not know what I am
> >>>>>> looking for.
> >>>>>
> >>>>> I think I had a bit more luck and maybe found the needle. I sent ou=
t
> >>>>> another RFT patch which hopefully gets rid of the BCME_BADLEN error=
.
> >>>>>
> >>>>> Regards,
> >>>>> Arend
> >>>> Arend,
> >>>>
> >>>> Can you send me a link to that patch? I want to try it.
> >>>
> >>> Hmm. I explicitly sent it to you, but here is a link to patchwork:
> >>>
> >>> https://patchwork.kernel.org/project/linux-wireless/
> >>> patch/20241215120401.238320-1-arend.vanspriel@broadcom.com/
> >>>
> >>> You can apply it on top of the other 3 patches.
> >>>
> >>> Regards,
> >>> Arend
> >>>
> >> Thanks! I got it.
> >> I am building now and have tried to apply what I think are the correct
> >> patches. They do not apply cleanly and I had to hand edit things. My
> >> guess is I messed something up.
> >> I will see what happens when I reboot. It'll take a few hours to build
> >> on my Pi4 then for me to install it on the 3b+ to test.
> >>
> >> I hope I understand which are the '3 other' patches.
> >>
> >> This is the one I got from your link:
> >> RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
> >>
> >> These are what I understand are the '3 other patches'
> >> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-
> >> firmware-events.patch.diff
> >> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
> >> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-
> >> station-mode.patch.diff
> >>
> >> If they are not correct could you send me links to them and I'll try
> >> again.
> >
> > You got it right. Kuddos.
>
> Ignored my spelling checker, but apparently it should be "kudos".
> Another lesson learned today.
>
> Regards,
> Arend
Arend,

Thanks for the confirmation. My attempt at a hand edit to apply the
rejected portions resulted in a failed build with the current RPiOS
kernel in the git repo:
# uname -a
Linux jackrune 6.6.64-v8+ #6 SMP PREEMPT Sun Dec 15 23:55:30 CST 2024
aarch64 GNU/Linux

When I try to apply them, I get this:
$ patch -Np1 -i
RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware=
-events.patch.diff
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
Hunk #1 FAILED at 6752.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
Hunk #1 succeeded at 524 (offset 33 lines).
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
Hunk #1 FAILED at 1359.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
Hunk #1 succeeded at 74 (offset -1 lines).
Hunk #2 succeeded at 336 (offset -70 lines).
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
Hunk #1 FAILED at 15.
Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
1 out of 2 hunks FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
$ patch -Np1 -i RFT-v2-
RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware=
-events.patch.diff
RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-station=
-mode.patch.diff
$ patch -Np1 -i
RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
Hunk #1 FAILED at 337.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
$ patch -Np1 -i
RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-station=
-mode.patch.diff
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
Hunk #1 succeeded at 75 (offset 1 line).
Hunk #2 FAILED at 1940.
Hunk #3 FAILED at 2158.
Hunk #4 FAILED at 2216.
Hunk #5 succeeded at 5522 (offset 22 lines).
Hunk #6 succeeded at 5697 (offset 90 lines).
Hunk #7 succeeded at 6126 (offset 125 lines).
Hunk #8 succeeded at 7596 with fuzz 1 (offset 255 lines).
Hunk #9 FAILED at 7647.
4 out of 9 hunks FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
Hunk #3 succeeded at 243 (offset 15 lines).
Hunk #4 FAILED at 244.
Hunk #5 succeeded at 507 (offset 18 lines).
1 out of 5 hunks FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h.rej
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
Hunk #1 FAILED at 8.
Hunk #2 FAILED at 39.
Hunk #3 FAILED at 49.
3 out of 3 hunks FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c.rej
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_typ=
es.h
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
Hunk #1 FAILED at 42.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c.rej
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
Hunk #1 succeeded at 32 with fuzz 2 (offset 1 line).
Hunk #2 succeeded at 60 with fuzz 1 (offset 2 lines).
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
Hunk #1 FAILED at 450.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c.rej
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
Hunk #1 FAILED at 94.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
Hunk #1 FAILED at 15.
Hunk #2 succeeded at 47 with fuzz 1 (offset -11 lines).
1 out of 2 hunks FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
$ patch -Np1 -i RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_typ=
es.h

Is there another missing patch?

The kernel for the RPi is at this commit:
commit 80533a952218696c0ef1b346bab50dc401e6b74c (HEAD -> rpi-6.6.y,
origin/rpi-6.6.y, origin/HEAD)

Keith


Return-Path: <linux-wireless+bounces-16402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B7E9F2782
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 01:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA0164D8B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 00:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ABB4C7C;
	Mon, 16 Dec 2024 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMLnb69l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB54A1C
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734308242; cv=none; b=h4Hwp861BrerLWdqSUfZJLwjKdljoketeaPGJ7EgcrR1pwGmb/FEl9pgLw/lBaJfdSNSWLe/tqc5sk2ti8GlYFGqvBVCnCpmUM1rWkLVmQDfCgYGVTP+L28dECuuRViuNZFrXWx5Z469eaTBCvT7c+3i6fgC1qG7eKdcIWK71f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734308242; c=relaxed/simple;
	bh=sbekVCmKRocFcPwtHxauAhsfezZSxRGD/3PjkvWhUYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRcaYAjks1mmxxAhtEvsv3XhA4Q48fo83oUlrGXQQy3rTzMSN1UqfngR4nHhDYptkmArf5J3JLVvQIOTVEs0CHerxM7vm8IDnuiRKGhXKlET0sSyVvACjpj9fAE50BN9n8uvsqkH2dBgPEx0BDe/lhDq1Tl/S/eu0S6EbO9dW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMLnb69l; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72764c995e5so2069151b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2024 16:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734308240; x=1734913040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbekVCmKRocFcPwtHxauAhsfezZSxRGD/3PjkvWhUYs=;
        b=OMLnb69lzNOenTfEzx7qpoTJ7SLEUrwJJXn9WaCymlo0/vxb2hMBN7sjUmfygTnQG9
         nFvwJCOu0Qn949ZvKmjXaw9Hu7vVQrru5c5QOr8nbYeyU7DSboHiHjqW2jDswX4amozn
         b5mF7JKqeSJCi/ct+YUeL7vOwyjyOMJVkLaWaDrrsDx+Cjts2EuMCKelm+J1dHQ5VzdJ
         zPKacLIi+4k7SsHAkexM9ztxGcFp6cgggNiZsWeglfBtZg3EX3kAuxm0XEHiAeXYq2Ca
         BJD3Vgx+1DijAdk9rYkaAQo5Ysjdl3WzGSrkXqgeuJXurExuva4IrM/LJpvO8WNhYqVj
         Q68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734308240; x=1734913040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbekVCmKRocFcPwtHxauAhsfezZSxRGD/3PjkvWhUYs=;
        b=gVDkfB7M+DlSmrLpgHf9LSNzXJXfyUjZeLBXysI54GzExsO3MsGIVVbKhBMkgj2kvS
         L8rza7O0WJjM1exWOqX3l6cXwv5Oixe6HmQEMErZKvPnSTPi+TVX89hYdb2Ireo0ZmWc
         AkYmJuOyNsqLvPRRL3SzhtfSyGAzlzkllqM6RaJ9DwjwhibT/v7mqpR9ALF0TESdGXWp
         p3Mjz/JB8tx0v5ql3pQrB0zN3Kc5LOWtU9GrYPqqHFJJRKk0oLU7wNl9weiMsXJxH+RQ
         w+snFdbXPiaguaAjN8qJp30e1XJUazz8/kQAV1/D2GOfpZGStfNxiMudHdazUHlgiCfr
         tSOg==
X-Forwarded-Encrypted: i=1; AJvYcCUrkkhAN9bi7UnVQqipbGnRcam7raO4wxgax2RfXQrghewRklePP/TztCfHvdUosy8Lew4Jpww8Lg9e+e3/HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xxTfFvNqsC/c2xUhtkX+5P9MGcZm3xmPtyzLPEfnUG1OIY8L
	WiDMnCqvdvDsBZXnd606LZz3FlBQsfKFyeQS0Xhqs4lpc/ubCS2KsYgEPGXKnNAURbHWE0CGy22
	FocY2L13isfTLOlqoKpuPwfTD41TNPGafkcM=
X-Gm-Gg: ASbGncuXip0X2l0KYAHHysEw23XwwV8TPOjHUSCl2IrirtnNMmvw3NZV18dHPGndkVl
	Yw9644TP0ScciRxGhU9VGteJh6nFGoElIJ7fVltXC3WcbUgOGnkqwFwgR998AJYjD9NX83DBW
X-Google-Smtp-Source: AGHT+IG8tdIF0EwTFSj1uRNTsF5kCL7xwW7Y1CIdYDP8srAflVc8LeNu2xV952fzm5VmX4Np2R4/veZWwBqw1+e9kIs=
X-Received: by 2002:a17:90b:3e8e:b0:2ea:2a8d:dd2a with SMTP id
 98e67ed59e1d1-2f2900a98b4mr14885871a91.27.1734308240325; Sun, 15 Dec 2024
 16:17:20 -0800 (PST)
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
In-Reply-To: <193cb61e210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 15 Dec 2024 18:17:08 -0600
Message-ID: <CAG17S_P+cOQMpQda00JTCCKEB6MpPE4X2i8mRrEaM-n5YKdpNg@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org, 
	Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 11:33=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > On Sun, Dec 15, 2024 at 6:12=E2=80=AFAM Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On 12/14/2024 2:34 PM, KeithG wrote:
> >>> Arend,
> >>>
> >>> I looked through the info where I got the latest firmware:
> >>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi-Fi-A-c=
lass-Linux-Driver-release-FMAC-2024-11-21-Documents/td-p/905045
> >>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/Cyp=
ress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
> >>> and did not find anything, but I really do not know what I am looking=
 for.
> >>
> >> I think I had a bit more luck and maybe found the needle. I sent out
> >> another RFT patch which hopefully gets rid of the BCME_BADLEN error.
> >>
> >> Regards,
> >> Arend
> > Arend,
> >
> > Can you send me a link to that patch? I want to try it.
>
> Hmm. I explicitly sent it to you, but here is a link to patchwork:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20241215120401.=
238320-1-arend.vanspriel@broadcom.com/
>
> You can apply it on top of the other 3 patches.
>
> Regards,
> Arend
>
Thanks! I got it.
I am building now and have tried to apply what I think are the correct
patches. They do not apply cleanly and I had to hand edit things. My
guess is I messed something up.
I will see what happens when I reboot. It'll take a few hours to build
on my Pi4 then for me to install it on the 3b+ to test.

I hope I understand which are the '3 other' patches.

This is the one I got from your link:
RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff

These are what I understand are the '3 other patches'
RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware=
-events.patch.diff
RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-station=
-mode.patch.diff

If they are not correct could you send me links to them and I'll try again.

Keith


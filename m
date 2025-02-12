Return-Path: <linux-wireless+bounces-18844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3FA32828
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071E67A0817
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050520F06B;
	Wed, 12 Feb 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA4L1bQS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D520E71A
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369626; cv=none; b=W+HeIq+xJEHeOlta41xa8CLGBWDbbi8bRK7n5m0FSojPhd+YYkIWbHbHROLBsmlj9UhyS596+FBnW73v5qvyZVG6dA9WgSUjZlBr7DQ2RjQZbFj01VG2IPaftMHrW9ePax/IQCilfikspt4MNrqrDZ52DK14Tve0O8GSFBZinFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369626; c=relaxed/simple;
	bh=AoDJc0eFSn9Ie4M9/s+34j/oPjJgTPUCXo4qVdKoFzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSE3O+prNrdws1BSY1i8V/Ct3U6fcyhijTqjKrLsw/Z4wGmP4D8lmfwJy1WdsejmUVpLGDJimzruCyNGD/mvUMCLQ0VMZmzwI8c3roDv/6aLeuDaCyKcTsOTc5Sh5RYuTHCBEoKcBvOtxIFL43i/HptsuPZA5FdFjtS7PNBJgA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA4L1bQS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fa7465baceso6498534a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739369624; x=1739974424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/J0ukjrssvswYnWbZg0nxjQDyU78VHg5GA1qLkUFJs=;
        b=dA4L1bQSJ0Gb9KZCAbNy238uxyJ+6fyNTipZbrnnkGCvVqJyTfw+A8U5DmMlS7PMTU
         cHp7Dr1PxkHcdHMgCoXeMRhRRosqsByCh9KqMxVTOS6iRhEleNrZrYSfc9m5/h0vUr/v
         SSV44hmzQ3gIl1WoL4ylJ2c0KhDrwlC/Mv6ik80zAfEzBmcFZ6yX3GM7uYTxR4EzF57k
         N8vV4n/KpqU5T75k4lngkroHllLN5KTX6ezehGB70ps8Wqo1SzOrYkTH0j4Ezb5rA0vj
         GHSwI5H6Agugzx87xKy9Ss23gEuENE8UBBMjbSZMIjUhE4/snzsDSbwLGdz52eOuYLK7
         18Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369624; x=1739974424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/J0ukjrssvswYnWbZg0nxjQDyU78VHg5GA1qLkUFJs=;
        b=DnuqPkGcssrxscBh0jEDkF5mFbKy/K5PFgEKJj2+q6EFwROptFWd0AdUsfVeiu/Pn8
         XHaqatj++IEi/4GQaZWjhY3YWtqCwce0PAw8h/aqmQMtdRB1hHpRAZFLuJ6dxV9hCPog
         SEIg5IiBQhb7BGHYKZ/X+unhTwfF4s33CzxWS6x6CGtWerSxHjcI3B2PmH4scYeuzkDv
         f7PXeOZOHY8PW6B7A/Z4MSr4RsC8u8D/4ZuTly7Km89VpsRmQm4BR55tdNZEvH3Wpkrd
         hgrod46/3U/0OhmRXZS9tsFrMEmmsVrDl1BOnG+FMBzeWtz3qwBYILPfNvW5GBJPNVio
         iTqA==
X-Forwarded-Encrypted: i=1; AJvYcCWfF1xbpO2yOF/HwDnYPcP8aQo9firRSyflNdw2RriFZhKtHlcLS/dfYPlTK1/QJ+d+OAuIkQrZYT8IPXi9Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKzk7F692fvOLifCL7j9yh2d9BzdGDNx5Huee9Zjp3cfkywwb0
	Hkm7tLcpNMxOR//YqAQsFnJPHuddc3+nZXi3e4R7pXqbEgdiz3+ft3Sb/nHx7ZeqpEM1yHQY/HP
	WG7hMouh/Ns/5DuegY+K08lf0XgU=
X-Gm-Gg: ASbGncuj9Nl+GaBnOmHBLTRlf0glqDnFvZ4vD/DMYttuAGkF8yKUR9o7w4IzEo3PlBn
	aQGZn8AI6CrkiLH6N5itSdVsHnzTdJimcltqicIcQpiK1zDKzrvM4dtiECPu8xV9XnxMCIbtjNk
	M=
X-Google-Smtp-Source: AGHT+IGHKWuaIUcnrWZTSCAhYuwgR/nInOGvyQlh+L+51q379WiI0FMRvivcXZnkDttZUotoPjr+43EipFk1ZUULU4g=
X-Received: by 2002:a17:90b:2742:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-2fbf5c6ac92mr6112169a91.33.1739369624396; Wed, 12 Feb 2025
 06:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com>
 <20241215120401.238320-1-arend.vanspriel@broadcom.com> <69874369-495c-4698-af1f-502d21371f7d@gmail.com>
In-Reply-To: <69874369-495c-4698-af1f-502d21371f7d@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 12 Feb 2025 08:13:33 -0600
X-Gm-Features: AWEUYZkzEjccYMYwzzLcO2FBGvhFrX2zYVIui-PZVIvFkrmKhSII9tI3Tz4lvYM
Message-ID: <CAG17S_Oh7mjecrSju=CxfB5eSqTGewY5gUYqK3YC-oW4jW5G7g@mail.gmail.com>
Subject: Re: [RFT] brcmfmac: Fix structure size for WPA3 external SAE
To: James Prestwood <prestwoj@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, Ting-Ying Li <tingying.li@cypress.com>, 
	Ting-Ying Li <tingying.li@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:42=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Arend,
>
> On 12/15/24 4:04 AM, Arend van Spriel wrote:
> > From: Ting-Ying Li <tingying.li@cypress.com>
> >
> > Add pmkid parameter in "brcmf_auth_req_status_le" structure to
> > align the buffer size defined in firmware "wl_auth_req_status"
> > structure.
> >
> > Signed-off-by: Ting-Ying Li <tingying.li@infineon.com>
> > [arend: adapted path to apply to per-vendor variant]
> > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > ---
> >   .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h    | 1 =
+
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_=
types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> > index 18129adb5dc2..1cbe66526d82 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> > @@ -54,6 +54,7 @@ struct brcmf_auth_req_status_le {
> >       u8 peer_mac[ETH_ALEN];
> >       __le32 ssid_len;
> >       u8 ssid[IEEE80211_MAX_SSID_LEN];
> > +     u8 pmkid[WLAN_PMKID_LEN];
> >   };
> >
> >   /**
> >
> > base-commit: 1cac3bd863bef434d43e6b0554ac5d7f7f6350fe
> > prerequisite-patch-id: d5b3eb93d54bd6a0508a91f4627ec3e59a810928
> > prerequisite-patch-id: 653281e1349a038c7f48b3513243f3211fffab9e
> > prerequisite-patch-id: 0e47ab711ef159237e20c860834d3ac269b05eb2
>
> I've tested this and can also confirm it does fix external auth on
> brcmfmac. I adapted it to work with the upstream 6.6 raspi kernel and
> had no issues using IWD + external auth to connect to a WPA3 network. Is
> this something that can be upstreamed?
>
> This is the firmware I'm using (no changes to the default raspi distro):
>
> Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26
> CY) FWID 01-b677b91b
>
> Thanks,
>
> James
>
James,

It is easy to do, but I am starting to get confused. Is this in
addition to or instead of the patch you posted:
[RFC] netdev: avoid PMKSA for fullmac drivers
Does it invalidate the need for using the latest cypress/infineon firmware:
Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
(be70ab3 CY) FWID 01-95efe7fa

If we can go to a default kernel and the 7.45.265 firmware, and still
have wpa3, that would simplify things and make us happier.

Keith


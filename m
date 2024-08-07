Return-Path: <linux-wireless+bounces-11069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81894A269
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC9F1F2580B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116AA1C3F31;
	Wed,  7 Aug 2024 08:10:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215119A28F;
	Wed,  7 Aug 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018223; cv=none; b=XkUh0bVhl/WPjApvObF0v3Gb/zvk8PMsfeUuXcEcmd2Som4WL8UZC1X8bpFI0ZuyN0wf6KMfmxNhIEfFhEtwkgafqM2MxSCobY1q5M3SmK+zE+V5U5/8/hfJ/LukuStBNfHANDzD4RZB/GjAFXUkI8oWA5WbhUs6t0tvXImXmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018223; c=relaxed/simple;
	bh=O65A7S4dv9JLxTrEg15BToKE6ghwYaIYY4QohPP/UKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTLZi8dYZJLvo7+90LvlxxFXOBOehJr+D4tzSB6dWnaauvIZkA+r+DRKVY/C2D8NRlZVgUbNQeAiGir+7pO9OvXm056dnFYCGuzI5pcn/dIZ0jm1CME7UfGReP8rDz9oKhqPFlc9MknmQq6Ow/69IEz7iKwxd8hRsCQ57CeXoPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so1763465a12.3;
        Wed, 07 Aug 2024 01:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723018219; x=1723623019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jjhz96xjWuk/ukU30r31lEvLok4NM+gNuypmgKKc5GQ=;
        b=ehQo1WJkreptcNveEjzjh07sv5itCU5Fr3AZFxLVIXD1EB5GU72maVpzlqBEkdMQKg
         W+Na2XhuVy5G9hFWgjgMzIcXvEc0ut+5/9MPmKygQ0yyu5C3IbxrQQ0+pVMtZMbRy88y
         SdzHylwo05Z1DuKmfUHl3SEU+YbeeXCaTHVdmd2+0n/xi3wvx1wuZiWwsMf+Ri0FQuAV
         airE/7XzUg0ObnQSQX2KRmorK5CSawUrVuxLYZQXUurhWEK5GZqC0CQbkkrbKvjdL/tM
         U1lT56XyK19JxOHm6avSH9LExg9LnynSF3V01Yfvk2RYX3Uy7acCrNUdxJRFZ8mPbbve
         16hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKgUYtcCX8WCNs9kZ9st1H8Y4ocD41bVtMR8ss5pcFZt2CS6Bve/UiVnFPTRhqkHJtKaqlTy5q6zWwXY9zFtacZQ6AqS9gLlie3InaXPAN0wNcN9pJjJbBgwMGo/rBPJMeUdNSIrq8lAfkkgf7kC+k1trnsAJV0VOvomM9BTSiUrgA8PM=
X-Gm-Message-State: AOJu0YzP3dmXfvd7T07pHlhKuYj//Qi2gHptJpqBeyAd1U9WI/K3UY5Z
	GdSUu/JXDxeWqmtTLwpaizAXy04es/eERYONGIyeMmrHwhb0LF5Hq7GNAdfoLwo=
X-Google-Smtp-Source: AGHT+IG8ei4XumhqVfz5AwE+qOvR7fuUjzbuVfdN6DNsemhnSwJdst1izJ9WkeyipEOatn9SLzzYgg==
X-Received: by 2002:aa7:dac1:0:b0:58b:12bd:69c8 with SMTP id 4fb4d7f45d1cf-5b7f56fc0ecmr11215798a12.36.1723018218541;
        Wed, 07 Aug 2024 01:10:18 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83960f348sm6760479a12.18.2024.08.07.01.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 01:10:18 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ba482282d3so1970647a12.2;
        Wed, 07 Aug 2024 01:10:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjiveBSIe/m3sJnoPgK5HiM6a6hY22jKaGIh7Igfv0jT0ETbTPDL5IbdYxZreMG3BO9YDHeUapsjd2EY1VDOCFM789C44cVtNvZHEtbJg7qnhR+hLdC3quYYyR+xzl1P20woV7TWLqqIturYLfM3UGmBOeOnexgZ28eKhg6qbsadZwbEE=
X-Received: by 2002:aa7:d15a:0:b0:5a7:464a:ab9 with SMTP id
 4fb4d7f45d1cf-5b7f40a4cd3mr10589275a12.21.1723018218098; Wed, 07 Aug 2024
 01:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803-brcmfmac_pmksa_del_ssid-v1-1-4e85f19135e1@jannau.net>
In-Reply-To: <20240803-brcmfmac_pmksa_del_ssid-v1-1-4e85f19135e1@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 7 Aug 2024 04:09:41 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_=R_SXXsu6PGT=fBpAO33Usw4YDLEW4EyyyFtsFzdszQ@mail.gmail.com>
Message-ID: <CAEg-Je_=R_SXXsu6PGT=fBpAO33Usw4YDLEW4EyyyFtsFzdszQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion
To: Janne Grunau <j@jannau.net>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 3:53=E2=80=AFPM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> wpa_supplicant 2.11 sends since 1efdba5fdc2c ("Handle PMKSA flush in the
> driver for SAE/OWE offload cases") SSID based PMKSA del commands.
> brcmfmac is not prepared and tries to dereference the NULL bssid and
> pmkid pointers in cfg80211_pmksa. PMKID_V3 operations support SSID based
> updates so copy the SSID.
>
> Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 =
operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 13 +++++++=
+++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 5fe0e671ecb3..826b768196e2 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -4320,9 +4320,16 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg=
80211_pmksa *pmksa,
>                 /* Single PMK operation */
>                 pmk_op->count =3D cpu_to_le16(1);
>                 length +=3D sizeof(struct brcmf_pmksa_v3);
> -               memcpy(pmk_op->pmk[0].bssid, pmksa->bssid, ETH_ALEN);
> -               memcpy(pmk_op->pmk[0].pmkid, pmksa->pmkid, WLAN_PMKID_LEN=
);
> -               pmk_op->pmk[0].pmkid_len =3D WLAN_PMKID_LEN;
> +               if (pmksa->bssid)
> +                       memcpy(pmk_op->pmk[0].bssid, pmksa->bssid, ETH_AL=
EN);
> +               if (pmksa->pmkid) {
> +                       memcpy(pmk_op->pmk[0].pmkid, pmksa->pmkid, WLAN_P=
MKID_LEN);
> +                       pmk_op->pmk[0].pmkid_len =3D WLAN_PMKID_LEN;
> +               }
> +               if (pmksa->ssid && pmksa->ssid_len) {
> +                       memcpy(pmk_op->pmk[0].ssid.SSID, pmksa->ssid, pmk=
sa->ssid_len);
> +                       pmk_op->pmk[0].ssid.SSID_len =3D pmksa->ssid_len;
> +               }
>                 pmk_op->pmk[0].time_left =3D cpu_to_le32(alive ? BRCMF_PM=
KSA_NO_EXPIRY : 0);
>         }
>
>
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240803-brcmfmac_pmksa_del_ssid-3c35efe35330
>

This looks reasonable to me and works on my Macs.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


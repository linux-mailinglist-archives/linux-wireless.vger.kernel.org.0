Return-Path: <linux-wireless+bounces-20861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584ADA71FD2
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 21:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E001899C91
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 20:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A04204874;
	Wed, 26 Mar 2025 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM+IA/+g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863233398B;
	Wed, 26 Mar 2025 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019249; cv=none; b=NoZlix3UVU2eTouv5xWdU4ykt9QzrIvk9eZ9J/ozz3A1aqJ3JD1q6C53DAyczHu9qItdMFML3o8BNZgnfUQR2st4CYNzM6HyzZ1JPXE5XsyLIg2IvDOFjftVNSyHRuxQcA1co9P0xk1/EdhMeG5mnm1ZhtFjthOFk/Ltb1fuP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019249; c=relaxed/simple;
	bh=GukL+UraKZ+n1BNn+9QOCSQZQKtBbmgfKSLUhASOC8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svEjx/I/HoK+3oRcDHTxhdHKu9i4v2d27U7b4plizqNhhJBrOqtNmuG1hqeBl1VlTS/vxDP2E3NOtVsN6UPKkAFY+98NLzPhwrfhFHTaYiW8y6OlwW/UE/oXfvaO8eOutkTtlLQ7hHPP+vQTzTZ97ii/IWvWG/QShUF95JzLFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM+IA/+g; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ff0c9d1761so2787197b3.1;
        Wed, 26 Mar 2025 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743019245; x=1743624045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQmkCV4pOArpog3v30AYwaEiipLIL2lP3oukxnrYMRk=;
        b=RM+IA/+g1UQvSRFsufTXrp0p2PCRLa9ZXoX8nTrIN9eR4RAvwHSkePp/GG/bWmSHwJ
         du9nm2Wf2N1fJStytb5TRydVatKvvhlJL5dnoG+6c7NtWedGSmb+5NLNab4Pffa/nYn4
         2fXWWr+nhEuDjAUSwmYJgoeicMefLHUntzmCUbzgDqAvEmLH6np5E6YEWH8oHXloDD/h
         oUQUylAzr0L7S93sXw5eVCtluNfK6tThq96gfRn5AZMNurDoTlKw2ToD325wEJK+36mg
         Alb16IUgHbZjLwnKquETV6z/X/3lXGJj1ZVABSYNwYG1Nh/t4mvmRsQvwxSvpcxX79EE
         gj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019245; x=1743624045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQmkCV4pOArpog3v30AYwaEiipLIL2lP3oukxnrYMRk=;
        b=YsfXI8C+gALgdFCl5PSjP9yPCQoPwuj84iYkgeYeCMl2GCem6VO105LOJg1a5SMdJ9
         R3C6hzViln/smcopBBKLuyRgEKbAf9TW5+rjuZ3bdTNgnEzGZiHh5vYkDvQzAmw9jhzV
         dWoYVCKpWdFq9Gc/Lhw26LS2hx7/HsLqhT+UiDkoHuDrIgijeda6bTWCJgBQrtiaN//z
         JtmFH5BgCNsqqKc9Rei7w/k0ojChEIZAb2J8ctUaUFGRcqPzhASJp3ePgVCnovJhS3OE
         Kc0l6+PV1lvZJtmRwmiZqpwwD8Y3HjIpyOS1Kv4+Sp207lfQHEvQ/qFyn6DILPgVVMTe
         sKFg==
X-Forwarded-Encrypted: i=1; AJvYcCV8ouENTwgLcdQB7Qq0SQacsnDWy9Od/682rLPAN09iYlb4HnY2HrvNmUrQYgNv7RMU2veT8+peVXwqGWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMMrIaWqFGCrz4aBMTb5EGXs1pTzp3U1r4rxAkzCm5s26oU12
	ptJE+16wZ6B8ovUV1+FTIr/9i/qxDKjGOnXHE748Lc5ctPG/jSeYARB/6idtr/WzjuIAvqqirS0
	/iKonjD2dfeSb7FUYE+23Ki9HlGQ=
X-Gm-Gg: ASbGncs4B5JkqaXwzDa8INCtoiD+3sb1N1tYMwiQix5a+EzeXP5VMy/kRcvFL4Xrzl0
	3WDyw27itcSbRUWONqH5k3clnnqKW40fQ1wTEG0L5u9bftPpCjR6JTW/Xc2P966mtnd58u09gVE
	Q4VmbRk8F/7mui2Prb/tAg2ISfOiuoHgN90/xr6qF/yjqobFpVCk64OqBx52A=
X-Google-Smtp-Source: AGHT+IGUKAVDRgscVLwV1S3/hrowz8PNAxF3UaFDkrqcwcASP9bmwDfRy+W0Dk4yQI0jF2Lr2VerSH6OdhS4rsEF84o=
X-Received: by 2002:a05:690c:6f04:b0:6f9:ac35:4483 with SMTP id
 00721157ae682-70225090207mr12826807b3.25.1743019245285; Wed, 26 Mar 2025
 13:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326155200.39895-1-yury.norov@gmail.com>
In-Reply-To: <20250326155200.39895-1-yury.norov@gmail.com>
From: Christian Lamparter <chunkeey@gmail.com>
Date: Wed, 26 Mar 2025 21:00:33 +0100
X-Gm-Features: AQ5f1Jo_tqO3R6aQhPnx-gGOT2nYWCoDoCfwxKd0V22FJUKiQc_RnJDsoAiGVic
Message-ID: <CAAd0S9BDCqw9XZSe=r5fcJuncUagJoJJ0jOe3fB2=UkyXgjozQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: carl9170: micro-optimize carl9170_tx_shift_bm()
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 26, 2025 at 4:52=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> The function calls bitmap_empty() just before find_first_bit(). Both
> functions are O(N). Because find_first_bit() returns >=3D nbits in case o=
f
> empty bitmap, the bitmap_empty() test may be avoided.
>

I looked up bitmap_empty():
<https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/include/linux/bitmap.h#n423>

apart from the small_const_nbits stuff (which carl9170 likely does not qual=
ify
for since from what I remember it's a 128bits bitmap) the function just doe=
s:

|   return find_first_bit(src, nbits) =3D=3D nbits;

so yes, find_first_bit runs twice with same parameters... Unless the
compiler is smart
enough to detect this and (re-)use the intermediate result later. But
I haven't check
if this is the case with any current, old or future compilers. Has anyone?

Anyway, Sure.

> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Christian Lamparter <chunkeey@gmail.com>

> ---
>  drivers/net/wireless/ath/carl9170/tx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireles=
s/ath/carl9170/tx.c
> index 0226c31a6cae..b7717f9e1e9b 100644
> --- a/drivers/net/wireless/ath/carl9170/tx.c
> +++ b/drivers/net/wireless/ath/carl9170/tx.c
> @@ -366,8 +366,7 @@ static void carl9170_tx_shift_bm(struct ar9170 *ar,
>         if (WARN_ON_ONCE(off >=3D CARL9170_BAW_BITS))
>                 return;
>
> -       if (!bitmap_empty(tid_info->bitmap, off))
> -               off =3D find_first_bit(tid_info->bitmap, off);
> +       off =3D min(off, find_first_bit(tid_info->bitmap, off));
>
>         tid_info->bsn +=3D off;
>         tid_info->bsn &=3D 0x0fff;
> --
> 2.43.0
>


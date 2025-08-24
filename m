Return-Path: <linux-wireless+bounces-26568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85B6B32CBB
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Aug 2025 02:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD4A208561
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Aug 2025 00:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB53D544;
	Sun, 24 Aug 2025 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/kxiQue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11DB640;
	Sun, 24 Aug 2025 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755995954; cv=none; b=XIE5t8RK8IxBeFWLYYfBPWdhKse9oOwNkucni57ASd+W2Dv01xIpjjONpJdlBZJbUQAk51DTFb3gjRUvmebT+rk0vC5uIjPmuQD4gahnVXwuDqplAA7NWU5kvgAhZYE+dNnsXkq+p/Jtrqk5FRKFlQm9e3qbRxh4JctO180NAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755995954; c=relaxed/simple;
	bh=s0McLWvdCDqPd8Y/u1GnS5m0WP0uNIXZ1VLr+nTsM2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sbfi/fkH+j1y+0XknV/y4+LzuRlaxwTIt6eK5a110XxnoGtY0OcnS8e7YPrrOkYZS8OTH8Gjr2p1X90sEbcovNdC14XGNZ6SASjQM3ypAi3wWX+ihT0WjOQntIpftkkG8KrgTe5L2SfkbEcRLHWogNSeovjZqcztXNllxbVA9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/kxiQue; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70d9eb2eb55so8997736d6.2;
        Sat, 23 Aug 2025 17:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755995952; x=1756600752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNY0okVFoLgY416XV42hmNIfwC6IRW0OVeBGVW5QbSw=;
        b=m/kxiQuebwZxFmBM49+i8xuq1lr3ZpPGs1qMnkE3zABf5B0x7gFfM0193+qNwKELLz
         9cq2mB0S4aEATxjMPN0ClAl9bM8UJ0T2pTLbUC0BnQK0i+qqCEWTZ58UDfdPz/mJpaNY
         Bruh5uOJI2G79N/ZyfkV4YdyJ6ZadLC+tqA6Bx/AlU3YPJo4Pv088UC7Kz+m+8CoOiWz
         1k75taCWpz9+c2NjHJt4VUZDbKgURRp/FLtadRS0Ij35MICBJAUT/rp0f67NcXv3LJi5
         jld9yfPHMGdZOoZ6+sleTdQ2ZLXpATWZNuuetXz3IjZrVeiklmM4E/etaQioZvbHrwZR
         JyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755995952; x=1756600752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNY0okVFoLgY416XV42hmNIfwC6IRW0OVeBGVW5QbSw=;
        b=a9SBWTm2k8dImYnGtnt0uf6mm9eDnCog1+TTpSr0eBmHzCtyHcwq3HGwHFNMVgeQrr
         pFjmGibIY97MbkKvp9iKGPNanK7O7CBufnx7MFWbo2tl6ThhoR8zu+HYSwgoJ16i/3ZN
         T7jxI0qbbtyUET2uyjSPPl7G8X+mXAmGljLl2kiRva/I9xCsZY2HwDHNzPIJB1sqvBuy
         6V+E5TBcgM8Ob5o32PLWdxyM8oPL0NDwjEdzSiUv2STaB/pHqLZuzJAakfNcjP7kV8Ss
         R22bGRbGVMxL1rM5kwUPk8TAKB0dBoohDgUjHV0dYDEOxfr/RDbPx/lNVU2DVm+YN1Qc
         QHcw==
X-Forwarded-Encrypted: i=1; AJvYcCV5HPRstxfIfRYsFmlZ2Zv+6BGOqMI2d7koQMftYT0zFLvVOtbq67AhoI11h8FjH1JkZs2FOY4O4/VF3eI=@vger.kernel.org, AJvYcCVzQnbL8ygoWMwdE1CsCrT1GH2Kt/y5/hKbXi1JDFyvSvonjAS2CrEUF4ln/437YWhPfWPFAtbnA++ku4oiooE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLh0yeuWGhoPCX8DGfZtzVjERZG4eIPJFhFfavN1oz1GWHFUPM
	6dq4xUm/uO6u2gViq01KiH5O85j/eIbL5mp49Qnk8mIcfXVRyIj6bQlGfKXUE1lXZCmBtDJEcrA
	7mS5cMpJPSw/7B2US90pi+uysmrCqMHl0fQ==
X-Gm-Gg: ASbGncufL024z0B0PDIINgD29gVJqkbTCy2JtL8FPjT8pGvcBeAzPqLW304M7WMQSCf
	J2hxcKdPciD27eX50HM6R/JNPrNVelJLUudW3ZMKq1uwNNuMxugkToMg0FDzw3pHZs572+6fdyt
	zT9VQKHOI7cnvcMQZjhmJjbS5knGjnsWbtULmKNVe5Snzc21Fgw7qbDRQBOZRRxH0ACgdrmkkiR
	owZkok=
X-Google-Smtp-Source: AGHT+IGJvweRY3TWUs9ZYabzrqlFqNGB8yJrDgWrKt8gjCB06kXkz/Eg19enAOqUFnXtnYwJBFfXomyAC0EIwhNpPNs=
X-Received: by 2002:a05:6214:d6a:b0:70d:b3de:ced3 with SMTP id
 6a1803df08f44-70db3dedb2amr18691696d6.25.1755995952022; Sat, 23 Aug 2025
 17:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818064219.448066-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250818064219.448066-1-liaoyuanhong@vivo.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 24 Aug 2025 10:39:00 +1000
X-Gm-Features: Ac12FXyu98_t-IJGPtHlzpUXh7AxDD1gzGG7IFvp3mKcGlBrc1qVK-4PS5y9upg
Message-ID: <CAGRGNgVzKyyG=Ld_eK60Ry=AQ7KpGx_ZKw908CAXoA3a2CVX4g@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw89: 8852bt: Simplify unnecessary if-else conditions
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"open list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liao,

On Mon, Aug 18, 2025 at 4:44=E2=80=AFPM Liao Yuanhong <liaoyuanhong@vivo.co=
m> wrote:
>
> Some simple if-else logic can be simplified using the ! operator to impro=
ve
> code readability.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers=
/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> index d0e299803225..164ee0fde03b 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> @@ -1803,10 +1803,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev, e=
num rtw89_rf_path path, bool o
>
>         val =3D dpk->is_dpk_enable && !off && dpk->bp[path][kidx].path_ok=
;

Is this line ^^^

>
> -       if (off)
> -               off_reverse =3D false;
> -       else
> -               off_reverse =3D true;
> +       off_reverse =3D !off;
>
>         val =3D dpk->is_dpk_enable & off_reverse & dpk->bp[path][kidx].pa=
th_ok;

The same as this line ^^^

and if so, can we just delete the second one? Also, can we also then
delete the "off_reverse" variable?

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/


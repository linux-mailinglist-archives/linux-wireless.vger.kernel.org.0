Return-Path: <linux-wireless+bounces-20401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1695FA62AAA
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 11:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3617C177313
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9B81E1C1A;
	Sat, 15 Mar 2025 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mydBK9/c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978762E3377;
	Sat, 15 Mar 2025 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033260; cv=none; b=ohVthbZQNJPA4d8CSM+Fc8Lhi0OKOilY5xnsY750rNS2UIURV5vqrAGiRoANSzeyRnUuh7sOV/StJdMP1wSlKgR5r5Xtor3Vp7PJqYEprIplqg8YGikwTji+OpLwlsV1RSBB9rry6GmeigyBvfcMYJBthmcdlGaNJ3ZXIBidLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033260; c=relaxed/simple;
	bh=juLXsmxAuIMjrZyokXas1Nocj4ctjFCg1/6PYJPNqpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3F5JAg4TEP5tySo84xJk6Wo1MbtZ1TD+04ZB3Apc+RWrKyS4wIft3m//hnKnvSlP+iM42w9VKmjpsknzY0FOh11qnPQ8MjTfKUG5d7ZL7N5zME/aGhOQo8qLoNTsYwb9rMhn38VCogj020w+UEFrOw+y8Lsh+fcqdJgxN9NwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mydBK9/c; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e6405b5cd9bso796630276.1;
        Sat, 15 Mar 2025 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742033257; x=1742638057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGlZFvZfm88isKcoulh/KwTKVJVuiJPPYQnuQQ1zfLU=;
        b=mydBK9/cPjok4jVZG+ZSheHM/ryhqqu9uO6htpNAKGKMl2dp0CYyh2/OWswpj0h7yj
         XhGvB5DQK6Ll4JJLX8JATevEtxUC3bLkTvaoXYW4lT8Ake3ji36SzgFaaNnXouVk0o2Z
         g2XeLcqvPZ8k2KYit+A7GbW7eg1QEDi6g8+u+ERyhTDHVpjZjecImoZkOaGbQ2SC/Ff4
         lStYHeaGP7mAspXgzkwi9sgJfKaPLk7T9tiSHXw6Ck3LxmiDauQi36/DA6cFDdGhe3kP
         kUPOO0REalzVPdNbWRK0MN8RaSlFzAwUMLhbj0/TQqZr1E3a29y8kZXHeesYtlTo4V0n
         SN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742033257; x=1742638057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGlZFvZfm88isKcoulh/KwTKVJVuiJPPYQnuQQ1zfLU=;
        b=ZLerfZlSHJSgdIxb2eyvnzMqXHpbnoxDs4ZBIJBNf71zb5Fi3NtDqLUsH195kHSORA
         ng9DNmO8kwHDlWz1RB9wwz16q3O8UeexOwvk06LJNUtDf732WeUPWGIprf20iAIum2ro
         StYry1BS12Sjb36nCEVcMBpeTRJpy+J5ewE8WnP3kYF2KF6O7HZP0aKa9lxeF4uJX7Z/
         QSx/ZMI/cmEk6rMfWgv2No1G56ayG7r9Tez4kaUaxd9Uce5nr4iMJGcIaYQOyF2ShuK7
         yP8lqfjj4/xZ2C7yFrzdoIJ3FgBn+5gpbJxw49ipn5+O5wzKdcGVnytl+B0372Czqg1t
         uZhA==
X-Forwarded-Encrypted: i=1; AJvYcCUtBNRV/VSIQ70F9MlWvgC+GD8i3MQF7MRwsXfxqlTqNwR+G1Df0SkYIihN8oJQ75g4cl/RsiyMNEiz44nKdaU=@vger.kernel.org, AJvYcCWeaxxZxrJNRWH3Q6ouuX6mFnDTLVCsoru2wvSswF2M6NmSoilHsJC/yGR6akwrmSnzhCsw98nf/596uNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQtYATnfX6vCjZji7x7WtedtRnB5qA2NL28JjOvcsH3mrMgD0
	bK2jOUzBEgsNmznSArA83kjjja1unYnBqTbqeO84Z5JhdXV9m7cXvHS2b5eM8I1SRMhZU+nbutV
	y0eSs7FAWFLwgBIRYapJk3ccS4p59CptF
X-Gm-Gg: ASbGncv6CqS4SWksk4Oav+3/bmrMlF/WqLHl3ObJ8Q5LaRcc5beHsTB30MSjdcHbJFd
	JOtgICvZ00t8+TNsrV+qUVjkn/oaZ9ZQEXwhd/Si20GbUjePJddsNid0Ur9PFAHpWat6WE91aHv
	43jFfA2huMgFG8tZFTZsV/kwVH
X-Google-Smtp-Source: AGHT+IE11sQPRIpzZbq2NFHpxQs6H1PqpdulLW628NDgTYC/eVpO7hed27zZ1h3Mq6ubu15nCNX8P+oVzvr1UvGVzVI=
X-Received: by 2002:a05:6902:2193:b0:e5b:4a7b:c518 with SMTP id
 3f1490d57ef6-e63e39c694emr12719812276.1.1742033257413; Sat, 15 Mar 2025
 03:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314233831.2535170-1-robh@kernel.org>
In-Reply-To: <20250314233831.2535170-1-robh@kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 15 Mar 2025 11:07:26 +0100
X-Gm-Features: AQ5f1JooJYPeTJ0YMq4_G1gemn0pgqtGzv9GsP7MiL9KKeUJpi_76QTlFj86bCw
Message-ID: <CAOiHx=mr+MFE_7Krue4BPrtvtyJW0pWUBXCrqbViVH5oOTT2Hw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath10k: Drop of_get_property() call
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 15, 2025 at 12:39=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org=
> wrote:
>
> There's no need to check the property presence and length before calling
> of_property_read_u8_array() as it will return an error if the property
> is missing or the length is too small. The return errno doesn't matter
> to the caller, so no change in behavior there.
>
> Change of_property_read_u8_array() to of_property_read_variable_u8_array(=
)
> as the former allows properties to be longer than the requested length.
> Now the property has to be the exact length requested as the removed
> check required.
>
> This part of a larger effort to remove DT functions like
> of_get_property() and of_find_property() which return raw DT data
> having no reference counting.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>  - Add check that cal_data_len is non-zero
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireles=
s/ath/ath10k/core.c
> index b3294287bce1..47206b171aa5 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -1889,39 +1889,29 @@ static int ath10k_download_cal_file(struct ath10k=
 *ar,
>  static int ath10k_download_cal_dt(struct ath10k *ar, const char *dt_name=
)
>  {
>         struct device_node *node;
> -       int data_len;
> +       int data_len =3D ar->hw_params.cal_data_len;
>         void *data;
>         int ret;
>
>         node =3D ar->dev->of_node;
> -       if (!node)
> +       if (!node || !data_len)
>                 /* Device Tree is optional, don't print any warnings if
>                  * there's no node for ath10k.
>                  */
>                 return -ENOENT;
>
> -       if (!of_get_property(node, dt_name, &data_len)) {
> -               /* The calibration data node is optional */
> -               return -ENOENT;
> -       }
> -
> -       if (data_len !=3D ar->hw_params.cal_data_len) {
> -               ath10k_warn(ar, "invalid calibration data length in DT: %=
d\n",
> -                           data_len);
> -               ret =3D -EMSGSIZE;
> -               goto out;
> -       }
> -
>         data =3D kmalloc(data_len, GFP_KERNEL);
>         if (!data) {
>                 ret =3D -ENOMEM;
>                 goto out;
>         }
>
> -       ret =3D of_property_read_u8_array(node, dt_name, data, data_len);
> +       ret =3D of_property_read_variable_u8_array(node, dt_name, data, d=
ata_len, data_len);
>         if (ret) {

of_property_read_u8_array() returns 0 on success, but
of_property_read_variable_u8_array() returns the number of elements
read on success, so this check needs to be ret < 0 now.

> -               ath10k_warn(ar, "failed to read calibration data from DT:=
 %d\n",
> -                           ret);
> +               /* Don't warn if optional property not found  */
> +               if (ret !=3D -EINVAL)
> +                       ath10k_warn(ar, "failed to read calibration data =
from DT: %d\n",
> +                                   ret);

Best regards,
Jonas


Return-Path: <linux-wireless+bounces-28347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E9C17DC3
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 02:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C114E1AA43D2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3620D28467C;
	Wed, 29 Oct 2025 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="UvTLhMaP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74A2D9EEA
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700800; cv=none; b=b6s+aDZQbuoAH3acEvQNMQ7nOI46674lgB1G0a3ndE4c+Uj2yBIQNsmS+po/ovZf+JYbpfZ4f7+jsOMAFyoo2zKpiyZlqJ4rrsem0OxfYaLoUJLv93Ak64J8iRhZ9VQ+dQC4ZKWzPkr55/CTfEt0cd9KuxxtUdcR89LPK2b1DrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700800; c=relaxed/simple;
	bh=bJT9zDAAtWGTSir9U/0sNV8Qgug0XuRgo5APgD40SMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqTRIg0EolmYDOC44iaNI0Tf7weFNy0ELl9emv17OBH8WjMD9hskAuvX9suhazt7FYfdkvz3dXlC3CGJ9og0/v44FjuVyxYT/9t+96opqH8dmgM6KHdgOI87FhHKkYNtqxRbIiduxw55a//fM1dQCcM1r5t2fEiOxqUBUeMK3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg; spf=pass smtp.mailfrom=ndoo.sg; dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b=UvTLhMaP; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5523366f15cso197975e0c.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 18:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1761700796; x=1762305596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPtSj0fFIMDGLS2SgZPTTrJVOWKnJmdwr1FL7j6l5NA=;
        b=UvTLhMaPfRQaxkSaXQcgfazv7cNfolHxF0qEJKBfuVVrHCD242nyVI1/YtJuPX197j
         9YpTc1jVTFo5PisBmEH5QXWBSY4nbNRQ+W8nbgtVSJiSaL4GqZXFZmG16YaR9gEjRcX0
         31u9rQY1iEv9KYheQF2AFSCasqvM5zLHz94gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761700796; x=1762305596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPtSj0fFIMDGLS2SgZPTTrJVOWKnJmdwr1FL7j6l5NA=;
        b=KxVsF6k7CKS9O8VOpumGsRQ69nFrsfOllH/n1ws6ch6Mm1+xGqCQVmxMJfgsdvPp0q
         htFNhiUBJClDtPDPHyqooSgjOsZ09cu1xFIw5fzZZ7E+UcBspFJHPoNjgOjUx/WjSPdy
         THqEB/Z6hZJHhvur4qflphxzuaxvXohuJAdoGKgWN1WNv6j4Ine5VySut2TptQEAlWro
         H3CNcfPZ7xVcqQ/F1fQx6H+eEreNxvnWALGVifAlgj2Vj5JRr1bYSIXh1B+xlUVhckIa
         WY1wEg8S43nZfb6dj+JrNDO9hjyIYEthuwxi3d6aHbXLWVBp2EC1JLl08XNxuKl5f33Z
         r3TQ==
X-Gm-Message-State: AOJu0YzProEruYo21PZCewjpdy5AX81CVdNycSKIwupspvP9mVQKJ58g
	Wwy4kh8nFKkUTgRylRGLj+UprNFito52wtZdi+BPOvXYDH4UhRZkoR3SRD7LeM9IQaPbeqUhg6D
	GHMf0lq3D5ghSFJI18N631E3r7ILb/zesrf33UwbJFaV3NObECRSF/p61
X-Gm-Gg: ASbGncs7yKu9c8PCdQJVHuXJlXYdQPOFn0OVj/Bk2ihVABHkds0KKhPqh0X5LMTOnfl
	uQOeIzPjpHdjBpPojXtTnMSPp7iHTDrA0YYqK+ndyTWK9ZNRsBKt4NkmmqJVT4LZcbQdLop9hAU
	BJrJgDRAT5UgQtSKcWWvNwAnGG1lhF+wh/MoM/tBToMKKxmhQg8+17GdeCCP6e6qUxsPbpGXuS5
	IqG/XRzYjjx+KSicp6P5uqJFseaYCkgFkieR8IwkrVE8FSrGtf5h/Z3z2xJVjrQMAGp/v3v3Uo+
	FVG78Fzy4q/N1015SLgklQdx1RToaWYsjw8qDOI7i1Ojat8=
X-Google-Smtp-Source: AGHT+IEcdaslXY3XsuAHL1V0660dEzO5GpCdSU7baZ/FcwUTmpsk4TTFsV3icbvkERgoYsCYEUelpyceBhYyUCP1E8U=
X-Received: by 2002:a05:6122:e017:10b0:557:d141:6e63 with SMTP id
 71dfb90a1353d-55813ecb474mr124998e0c.0.1761700796551; Tue, 28 Oct 2025
 18:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028062841.49216-1-me@ndoo.sg> <20251028062841.49216-2-me@ndoo.sg>
In-Reply-To: <20251028062841.49216-2-me@ndoo.sg>
From: Andrew Yong <me@ndoo.sg>
Date: Wed, 29 Oct 2025 09:19:40 +0800
X-Gm-Features: AWmQ_bnrtVb2ugEjs_y9339JYSOl7LErC8e8dRjh8t7Df7Fxt7Ciyfiw_9lQvMg
Message-ID: <CA+yTfBCmq-Xvn4XDPXvQpruUJ4rFbN9LzF3St8-mvnYCgkUm_w@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Malaysia
 (MY) for 2024
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear all,

Kindly DO NOT MERGE as I have found that there is a superseding document.
https://mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment-No-2-of-2=
025.pdf

I will send a new patch series accordingly.

On Tue, Oct 28, 2025 at 2:28=E2=80=AFPM Andrew Yong <me@ndoo.sg> wrote:
>
> Malaysia Communications and Multimedia Commission announced CLASS ASSIGNM=
ENT NO. 1 OF 2024[1].
>
> With reference to class assignments on page 10, and Power Spectral Densit=
y (PSD) limits on page 20, update the following rules:
>
> 2400-2500 MHz: Align previous 2402-2482 MHz rule to class assignment
> 5150-5250 MHz:
>   1. Align previous 5170-5250 MHz rule to class assignment
>   2. Mark as NO-OUTDOOR
> 5250-5350 MHz:
>   1. Align previous 5250-5330 MHz rule to class assignment
>   2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calcula=
ted at 20 MHz channel width
>   3. Mark as NO-OUTDOOR
> 5470-5650 MHz:
>   1. Align previous 5490-5650 MHz rule to class assignment
>   2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calcula=
ted at 20 MHz channel width
> 5725-5875 MHz: Align previous 5735-5835 MHz rule to class assignment
> 5925-6425 MHz: Increase EIRP from 200 mW to 250 mW (remains within PSD li=
mit of 12.5 mW/MHz)
>
> [1] https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment=
-No-1-of-2024.pdf
>
> Signed-off-by: Andrew Yong <me@ndoo.sg>
> ---
>  db.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 1d17271..3df9c41 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1450,14 +1450,16 @@ country MX: DFS-FCC
>         (5925 - 6425 @ 320), (12), NO-OUTDOOR
>
>  # Source:
> -# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signe=
d_19012022.pdf
> +# https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment-=
No-1-of-2024.pdf
>  country MY: DFS-FCC
> -       (2402 - 2482 @ 40), (500 mW)
> -       (5170 - 5250 @ 80), (1000 mW), AUTO-BW
> -       (5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW
> -       (5490 - 5650 @ 160), (1000 mW), DFS
> -       (5735 - 5835 @ 80), (1000 mW)
> -       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
> +       (2400 - 2500 @ 40), (500 mW)
> +       (5150 - 5250 @ 80), (1000 mW), AUTO-BW, NO-OUTDOOR
> +       # 5250 - 5350 MHz regulatory limit is 1000 mW, but 200 mW reaches=
 the PSD limit of 10 mW / MHz at 20 MHz channel width
> +       (5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, NO-OUTDOOR
> +       # 5470 - 5650 MHz regulatory limit is 1000 mW, but 200 mW reaches=
 the PSD limit of 10 mW / MHz at 20 MHz channel width
> +       (5470 - 5650 @ 160), (200 mW), DFS
> +       (5725 - 5875 @ 80), (1000 mW)
> +       (5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
>
>  # Source:
>  # https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
> --
> 2.50.1 (Apple Git-155)
>


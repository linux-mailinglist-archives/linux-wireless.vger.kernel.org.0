Return-Path: <linux-wireless+bounces-17796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B66A182D8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 18:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A4E188BDEA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A491F4E4E;
	Tue, 21 Jan 2025 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="JQXUjQFk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3321BF7E8
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480360; cv=none; b=rB46px1OFMInryU9AOCWPlb66h01UnOc1Am23WjEWVgBS4/nN79gSjsyN+KOdWeUQd7OYO4qXIHI5bqifwtOFt+AXecd1k52L5JbyCQUQGZC4YPi0D2ZdZOaiTgf4Iis1U0EmmcjfAM3ty4UZrgf8kLQZYQRpJID4WEaQ/fxiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480360; c=relaxed/simple;
	bh=Vf5HncB0fBh1bkGXKb+t+TCc7R3JCdU6ONcKn9Ds0bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKt/iqw/LvB+L05UIyoi4DFQ6fJo63uPN11i75tNCM1W8+TI7zdqcKuEGl5ZpaFjOH6wF0sPZHIeuTOD9sj7RBP4Ab+myV2xMBPjvN7nZ3fMorFN176yt0Xh/i1CEXVFxhwLWCMFPbrCdazVlsVqS2TJBKacwugn9tgZiR3Z9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=JQXUjQFk; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e573136107bso9774131276.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1737480358; x=1738085158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZp+12xKP21ZFL3cBiPy0Qk2QS0v25Vmx1pqZJpeMtM=;
        b=JQXUjQFkCiy2ZU29O/yObzK9X42bJM8+cg4zUYRSKpJYyPwIVQ4ZzldtBG1w2oh7La
         oKqC6SaTcGE9marxu19cVWPKh2dC5VLDJA8yI1t24mS6CL80WlByEeqKPhDHr4bbsLF3
         hEp1K2TNnxV5/SCo8ihDbu5k8+1NzUjXIoi6ost/SHt2EG24FZR4g0DyOyuJUPFwjSNn
         gHeA9DVZTG2+uzV5N4OWnaCDRX9jfdJaywL3Ai9Bdo87vk+jR2mPM4O0uU/JUY0VJ7il
         uXQpntH4LdBBbGR+bTK0INWiCC+iaSqQ0IIXmipeHXPSg95l/Zaq/6YdeSvoh0pC1dWX
         cfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737480358; x=1738085158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZp+12xKP21ZFL3cBiPy0Qk2QS0v25Vmx1pqZJpeMtM=;
        b=U6Va6He181KBqz/UPHljJkhk8wD1+gqBlIMHmYkKqXwfC9iB1plybpkhRJuON6LvFd
         0IDnP7oplb8HwldLiRFE54oD7zsdIee5/vMYksfqOhxe06twygRrmstA90cxZF0Tx2NC
         t1T5L7sa7IqA10Pcf2C4/C9bbs33k0ShHxB/MaRggoij13W9CqVKBexmXHC+lzC91uXS
         UqedNdekNswc0/Q3Okg+lL2oi+eqFwHi+dPAWIzzVks9CsnsQUfSteJmbUyMzi7CLY3N
         A//hpAFI11u+ot6G97C31S4othX8u0oWMZFAUdsWXfN7xrsfPsgCvPm/3rwJ1BpoI7IB
         GApA==
X-Forwarded-Encrypted: i=1; AJvYcCU6blzSRRa69g0blDaGbZNw7v3ttyPTXJG703m3atP0F9Pr6oFzssDKCdckbKNBI5D75j07N1Ym2mNlV+H4cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5F77+ZTaNVbXdUW2TNverTL06RE3F6ZQB8IGbO/q3Jqj3yQR
	8CkenbTqPbF6kZ1smJOnvL8aLYLWzjVlyVUqGE0Z0YzlIsDpmvhW7Ol+xKfeO+NvmcrCh6NQv6i
	hd/JlELxVK0eOSLH66TUMcYc228HUlvonD/xChw==
X-Gm-Gg: ASbGncutr4fijk873kaV/NFDIpVTTV7R3A7yUgKYZn4u65VVHR6pPTMRdsTaGAR6mT4
	QuZiJMkVZNWhh0+/h0BQ/fGzkkRPnZ5ZdmA/f/kTbvFdL5Q43ChQ=
X-Google-Smtp-Source: AGHT+IEX1pKh9G84uwoaF3TqQpxgmY7OnnF45ZehTheO7LEqcZCsVe/VzASXMGnKB75TYtJraGnR5I94fz1agsyNSdc=
X-Received: by 2002:a05:690c:4b12:b0:6f6:7ef2:fe6c with SMTP id
 00721157ae682-6f6eb93f6f7mr150917467b3.37.1737480357673; Tue, 21 Jan 2025
 09:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119164219.647059-1-quic_ppranees@quicinc.com> <20250119164219.647059-2-quic_ppranees@quicinc.com>
In-Reply-To: <20250119164219.647059-2-quic_ppranees@quicinc.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 21 Jan 2025 09:25:46 -0800
X-Gm-Features: AbW1kvZt9ZPqjB0BdpQkRL5KgHpWGtbyJj2SAQ_Ua2QqTrkqbigoGJLir67evL4
Message-ID: <CAJ+vNU01rQM8uvZxSDuMP91nLFovtNZXRvCPpunt2MrjK+8uRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: ath11k: Fix DMA buffer allocation to resolve
 SWIOTLB issues
To: P Praneesh <quic_ppranees@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 8:42=E2=80=AFAM P Praneesh <quic_ppranees@quicinc.c=
om> wrote:
>
> Currently, the driver allocates cacheable DMA buffers for rings like
> HAL_REO_DST and HAL_WBM2SW_RELEASE. The buffers for HAL_WBM2SW_RELEASE
> are large (1024 KiB), exceeding the SWIOTLB slot size of 256 KiB. This
> leads to "swiotlb buffer is full" error messages on systems without an
> IOMMU that use SWIOTLB, causing driver initialization failures. The drive=
r
> calls dma_map_single() with these large buffers obtained from kzalloc(),
> resulting in ring initialization errors on systems without an IOMMU that
> use SWIOTLB.
>
> To address these issues, replace the flawed buffer allocation mechanism
> with the appropriate DMA API. Specifically, use dma_alloc_noncoherent()
> for cacheable DMA buffers, ensuring proper freeing of buffers with
> dma_free_noncoherent().
>
> Error log:
> [   10.194343] ath11k_pci 0000:04:00.0: swiotlb buffer is full (sz:104858=
3 bytes), total 32768 (slots), used 2529 (slots)
> [   10.194406] ath11k_pci 0000:04:00.0: failed to set up tcl_comp ring (0=
) :-12
> [   10.194781] ath11k_pci 0000:04:00.0: failed to init DP: -12
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ=
_LITE-3
>
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Closes: https://lore.kernel.org/all/20241210041133.GA17116@lst.de/
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp.c | 35 +++++++++-------------------
>  1 file changed, 11 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/=
ath/ath11k/dp.c
> index fbf666d0ecf1..f124b7329e1a 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.c
> +++ b/drivers/net/wireless/ath/ath11k/dp.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights r=
eserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights r=
eserved.
>   */
>
>  #include <crypto/hash.h>
> @@ -104,14 +104,12 @@ void ath11k_dp_srng_cleanup(struct ath11k_base *ab,=
 struct dp_srng *ring)
>         if (!ring->vaddr_unaligned)
>                 return;
>
> -       if (ring->cached) {
> -               dma_unmap_single(ab->dev, ring->paddr_unaligned, ring->si=
ze,
> -                                DMA_FROM_DEVICE);
> -               kfree(ring->vaddr_unaligned);
> -       } else {
> +       if (ring->cached)
> +               dma_free_noncoherent(ab->dev, ring->size, ring->vaddr_una=
ligned,
> +                                    ring->paddr_unaligned, DMA_FROM_DEVI=
CE);
> +       else
>                 dma_free_coherent(ab->dev, ring->size, ring->vaddr_unalig=
ned,
>                                   ring->paddr_unaligned);
> -       }
>
>         ring->vaddr_unaligned =3D NULL;
>  }
> @@ -249,25 +247,14 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, st=
ruct dp_srng *ring,
>                 default:
>                         cached =3D false;
>                 }
> -
> -               if (cached) {
> -                       ring->vaddr_unaligned =3D kzalloc(ring->size, GFP=
_KERNEL);
> -                       if (!ring->vaddr_unaligned)
> -                               return -ENOMEM;
> -
> -                       ring->paddr_unaligned =3D dma_map_single(ab->dev,
> -                                                              ring->vadd=
r_unaligned,
> -                                                              ring->size=
,
> -                                                              DMA_FROM_D=
EVICE);
> -                       if (dma_mapping_error(ab->dev, ring->paddr_unalig=
ned)) {
> -                               kfree(ring->vaddr_unaligned);
> -                               ring->vaddr_unaligned =3D NULL;
> -                               return -ENOMEM;
> -                       }
> -               }
>         }
>
> -       if (!cached)
> +       if (cached)
> +               ring->vaddr_unaligned =3D dma_alloc_noncoherent(ab->dev, =
ring->size,
> +                                                             &ring->padd=
r_unaligned,
> +                                                             DMA_FROM_DE=
VICE,
> +                                                             GFP_KERNEL)=
;
> +       else
>                 ring->vaddr_unaligned =3D dma_alloc_coherent(ab->dev, rin=
g->size,
>                                                            &ring->paddr_u=
naligned,
>                                                            GFP_KERNEL);
> --
> 2.34.1
>

Thanks, this resolves the issue I reported. I tested this with qcn9074
on an imx8mm (no iommu) with 4GiB DRAM and verified swiotlb was not
being used and infrastructure mode worked fine.

Tested-By: Tim Harvey <tharvey@gateworks.com>

Best regards,

Tim


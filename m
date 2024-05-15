Return-Path: <linux-wireless+bounces-7721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A48C6F29
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 01:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CA51F2121B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED515B0E2;
	Wed, 15 May 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4F8ysOf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8717915B0E1
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715815619; cv=none; b=oimD87/ySrOh7arnyWnA+ll9jnb8FjFHXRT1DvNrlu3VZLLVEMxQmArHNInasT2Mb9JU9f4R3qqvn+fyC3/H5fsGAmBrLBR/qT/Wlh8UWwvUawKCsUnZoJAUmzzge0PJhJrmsP+5HEiPuTsrG1FYu61zuEVhKPfNysQsz/ARFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715815619; c=relaxed/simple;
	bh=Dly9VJssQKlGr4nuNsuWgUhzWU16eHtlmaSmjqzEbtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7E4jBRxJWZhy5MAPUgSVF1EHR5AEV8Wna6nWDinpaFMUEtpTNoHtnDtIMyWghPPri3yTnamEw/VEeFgghJv74au5SmVBn/gVUQpQi1THrYLO44/FeFP7eQ5z+8RucZsJ1PBNDOz6c+ye68X0MgkXoGN1brjXoMw/oTW3ewcQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4F8ysOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21132C116B1
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 23:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715815619;
	bh=Dly9VJssQKlGr4nuNsuWgUhzWU16eHtlmaSmjqzEbtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q4F8ysOfkr92N1KApuAXQfMKIJBEOMG4NHZAuxp3HDd325XnEyrFYls3ZOiQ5mtcF
	 ybv0ZXtaCjkurb9PmrzV9BmEJWb7D9VqIPHBG9GJfGYlz/iJqh7VnDn1pFwT2Z0VXY
	 vZYvjErDad16ZZsuNly4sNQ0LjP4GeTmIVBm4irqZq1NTyr8KKY76+GwPY3v3PyHl8
	 1trFgtQArp2eliFaSbBxolncwiektGIgVoBGlQNEsyOoZSPZHy8O2Qhej5VJicSCHZ
	 +tsfLTbKE9nzDLR2O1qEh1iwHkSwPCGRCXK04UxI/eEr+qNq17uMkCwZBfJ0qqGfaN
	 lnjf7kmSdvSWg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-574fd0306d0so243674a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 16:26:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnW5/wM8Qs2egvvWolqjJt5h58VDtZ1GsYb54KWp8eoxgpKePfmSn93lmLvFi1WNNtNBuDagzXFSKNoz+RmKoJ37y15Rbu1zelNSKc99o=
X-Gm-Message-State: AOJu0Yyqm0YBcGY5MlvOKgwB/BXyieJVHbKVEBoSAfiwCMnfNOnPp0/J
	lQeHR6IRo+sznvG+i/ze3Gu2kOP+WW6oNwCUvtJZgiPom1z17Ep6FMRg4BUuISXzY9v93Iq6u2V
	LaIBNsm0lA0tclkL0WyFZdLQk4rw=
X-Google-Smtp-Source: AGHT+IG9Xw6qhwjkVuZfgDD8lRq6KGIE3S0/7KdscGUUPCpx9YHwTsEyoDV+3UrO5ntqcmGMtzVO+O95aJyPT3TM4ZA=
X-Received: by 2002:a17:906:f591:b0:a5a:5bf2:b889 with SMTP id
 a640c23a62f3a-a5a5bf2b8b4mr1196952966b.0.1715815617724; Wed, 15 May 2024
 16:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515015155.24931-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20240515015155.24931-1-mingyen.hsieh@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 15 May 2024 16:26:45 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzprjai3iyab9WERsEm+Y8o6SgASKmL4tsimhSyjY-nG_Q@mail.gmail.com>
Message-ID: <CAGp9Lzprjai3iyab9WERsEm+Y8o6SgASKmL4tsimhSyjY-nG_Q@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt792x: fix scheduler interference in drv own process
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, deren.wu@mediatek.com, 
	Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, Leon.Yen@mediatek.com, 
	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com, robin.chiu@mediatek.com, 
	ch.yeh@mediatek.com, posh.sun@mediatek.com, Quan.Zhou@mediatek.com, 
	Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Michael Lo <michael.lo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Mingyen

On Tue, May 14, 2024 at 6:52=E2=80=AFPM Mingyen Hsieh
<mingyen.hsieh@mediatek.com> wrote:
>
> From: Michael Lo <michael.lo@mediatek.com>
>
> Add some time to wait for LP engine to complete its operation
> before polling pmctrl register.
>
> Signed-off-by: Michael Lo <michael.lo@mediatek.com>
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 3 +++
>  drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 3 +++
>  drivers/net/wireless/mediatek/mt76/mt792x.h      | 1 +
>  drivers/net/wireless/mediatek/mt76/mt792x_core.c | 6 ++++++
>  4 files changed, 13 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index f768e9389ac6..0f7d5a92f3d0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -339,6 +339,9 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>         bus_ops->rmw =3D mt7921_rmw;
>         dev->mt76.bus =3D bus_ops;
>
> +       if (mt7921_disable_aspm)
> +               dev->disable_aspm =3D true;
> +
>         ret =3D mt792xe_mcu_fw_pmctrl(dev);
>         if (ret)
>                 goto err_free_dev;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/pci.c
> index 07b74d492ce1..e7039e312538 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> @@ -373,6 +373,9 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
>         bus_ops->rmw =3D mt7925_rmw;
>         dev->mt76.bus =3D bus_ops;
>
> +       if (mt7925_disable_aspm)
> +               dev->disable_aspm =3D true;
> +
>         ret =3D __mt792x_mcu_fw_pmctrl(dev);
>         if (ret)
>                 goto err_free_dev;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wi=
reless/mediatek/mt76/mt792x.h
> index 20578497a405..8f913336a668 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
> @@ -190,6 +190,7 @@ struct mt792x_dev {
>         bool fw_assert:1;
>         bool has_eht:1;
>         bool regd_in_progress:1;
> +       bool disable_aspm:1;
>         wait_queue_head_t wait;
>
>         struct work_struct init_work;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/n=
et/wireless/mediatek/mt76/mt792x_core.c
> index a405af8d9052..a11e5438a36e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> @@ -766,6 +766,12 @@ int __mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev)
>
>         for (i =3D 0; i < MT792x_DRV_OWN_RETRY_COUNT; i++) {
>                 mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
> +
> +               if (!dev->disable_aspm) {
> +                       /* wait for LP engine to complete its operation *=
/
> +                       usleep_range(2000, 3000);
> +               }
> +

I think we can reduce the extra delay on platforms that don't support
ASPM. Basically, if the platform doesn't support ASPM, we can get rid
of the wait.

>                 if (mt76_poll_msec_tick(dev, MT_CONN_ON_LPCTL,
>                                         PCIE_LPCR_HOST_OWN_SYNC, 0, 50, 1=
))
>                         break;
> --
> 2.25.1
>
>


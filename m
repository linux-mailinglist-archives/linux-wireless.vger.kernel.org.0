Return-Path: <linux-wireless+bounces-1121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FBA81A8C6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 23:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8DF28231A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 22:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93233495D1;
	Wed, 20 Dec 2023 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6g4PBNU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8B495C4
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 22:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA3DC433CB
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 22:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703110274;
	bh=rxDWW9QQfeURQ6v06XkkImaEoG89S2ehL9UgQ+cUoeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q6g4PBNUcBFw0+BF1CkIsjmz93gG9KLASGiU0cx3T9UwJD885VcTl+H2CEIhgFS03
	 gTLnmGrTAPu8MHyyTzPRfeFD5sIWlljFrz3ChXvmu3zimzpva4dfOrBbO2Ooj2Zz+6
	 nf+Zi24VF4aRzu5dMsLWEBvsFzZFZE39vvfyEHRZ9/pdYZOGEiy1AZttA6VpixtLVF
	 3a14n/LpDnnZSJRmaWT+xER1ZIOwZ3a9GVbUWgKXTxQhFFR7W3eKH/3eKE1pTA4Leb
	 wIHSS8uR/cWLGyxIKxThtqIrVZ7lV/Nv5qN+LuEk0e08XmfXzDNCyHOEtGXHhx6p0y
	 hxWrsNv8XL8iQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso53624e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 14:11:13 -0800 (PST)
X-Gm-Message-State: AOJu0YwAXopoDhBrpGSZx+CtOxDnXtltk3iaer5nEgK1omGz3kGU8Qb8
	zD6RuallBbfpSEYbn9UAziP2T9p5ppGdacxl3WY=
X-Google-Smtp-Source: AGHT+IEjwS9CUhYy5Y14XEyQPAzBrDZRuoUZgOQ5H8WeRazoWY/3VWAE0atf0hicbr0SYACedWqrgT52JeFq/jX9a0Q=
X-Received: by 2002:a05:6512:15a2:b0:50e:3216:ca49 with SMTP id
 bp34-20020a05651215a200b0050e3216ca49mr8560824lfb.3.1703110272104; Wed, 20
 Dec 2023 14:11:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220092138.12830-1-mingyen.hsieh@mediatek.com> <20231220092138.12830-3-mingyen.hsieh@mediatek.com>
In-Reply-To: <20231220092138.12830-3-mingyen.hsieh@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 20 Dec 2023 16:11:00 -0600
X-Gmail-Original-Message-ID: <CAGp9LzoB5FRiectZD4RL2m6twBicSZvk3TvBM9EQgrsPyHG69g@mail.gmail.com>
Message-ID: <CAGp9LzoB5FRiectZD4RL2m6twBicSZvk3TvBM9EQgrsPyHG69g@mail.gmail.com>
Subject: Re: [PATCH 2/4] wifi: mt76: mt7921: fix potential command timeout
 issues when suspend
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, deren.wu@mediatek.com, 
	Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, Leon.Yen@mediatek.com, 
	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com, robin.chiu@mediatek.com, 
	ch.yeh@mediatek.com, posh.sun@mediatek.com, Quan.Zhou@mediatek.com, 
	Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mingyen,

On Wed, Dec 20, 2023 at 3:22=E2=80=AFAM Mingyen Hsieh
<mingyen.hsieh@mediatek.com> wrote:
>
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>
> An ongoing command may be interrupted if suspended, leading to a
> command timeout. Add a lock to the suspend function in order to
> protect the ongoing command from being interrupted.
>
> Signed-off-by: Leon Yen <leon.yen@mediatek.com>
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 57903c6e4f11..e1c53f18abdc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -409,7 +409,9 @@ static int mt7921_pci_suspend(struct device *device)
>         if (err < 0)
>                 goto restore_suspend;
>
> +       mt792x_mutex_acquire(dev);
>         err =3D mt76_connac_mcu_set_hif_suspend(mdev, true);
> +       mt792x_mutex_release(dev);

I had assumed that all commands would finish up before the suspend
handler is called, given that processes are frozen before the
suspension can progress. Could you provide more details on the
specific conflict between these two commands and how it results in the
command timeout?

Moreover, while I understand you've identified some potential issues,
I suggest we work towards a comprehensive solution to address timeouts
caused by potential command conflicts, not just for the specific
command. For instance, we should take into account other MCU commands
during suspension and extend this consideration to similar scenarios
in SDIO suspension.

>         if (err)
>                 goto restore_suspend;
>
> --
> 2.18.0
>
>


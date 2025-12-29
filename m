Return-Path: <linux-wireless+bounces-30167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1060CE85AD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 00:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2CA7301339B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 23:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ABD2D23A4;
	Mon, 29 Dec 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYWSSgMc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD723FC5A
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767051726; cv=none; b=BHUfZZBhxxz1xA/7qpLnvRPdp4hFRFNcQCNNF5Y9KpbpOuwDnNkXzDNx4FsP5oZ3tC+p7HOGn22v+J6sckD5tR/mzMjH3zAMLbNaFQXk65yLh09yvwB6b6gU7QY+4eIV1zcTTe08qh+m/Z4FvqNctIXhO6FpNc5ROFnhhryOEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767051726; c=relaxed/simple;
	bh=M744/O3+s1JL5qiahLA1Uihmyo12jfWHL5kieAH92fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSWkPoi5TGxyAmP4CCFMjfwkunZ/D7SeiMkbGGGgKS5d0DpBJDcChBtO7kdx53jHCUuPKJ5hK/D+aYHixWtLMjE2VIYBhwaQD3qfHiAW4Yi9KtZbT92/Igw5HKA2FbCRMQWgiEP8vm+zIcW3k323ynWk2d+RKKmZ2ucDS8by9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYWSSgMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF77AC4CEF7
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 23:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767051726;
	bh=M744/O3+s1JL5qiahLA1Uihmyo12jfWHL5kieAH92fo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cYWSSgMcPqcEBwcdyurlCbJKqSzS8bAjBjU+7poL8b87075tSxMpUx37FAAUb/8Gr
	 RxHGpfjXK/K/CaB+iI14Tba2s/C0n0vtX1fsWC5xpN6yYWYNSgkIY45WHlPGr6vx+6
	 uQV6QFpbC/5rXdgkOvnCqkzuFFeilLyMoCdXM2O0eZ8vSAzW2C8Q+TDA8E1cquzKpJ
	 ikGJru96vxoAQT5iXp9d1ST45GoTYDlyBHDADSnJKaXbSGCuBflKdXZpVwjZsUC/fl
	 RoW3AYKliHr/YKyjByqpTEmUft8vktEKsEYEbFu2L7cAAQvkLBDGDaWVjJiUuB8/T+
	 VmAU923qmAt+Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5945510fd7aso7697538e87.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 15:42:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoxKGbUntWK47eEodsFUN4+MjgZNtxk9EaIp+ioFqzbHkLKSBVtaKxzsCEpPcLHCbKHuqkBwu4MMMURhmubQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwamVzMp2cm14LVZ89GHkwecpCZmhT2rXPFTnd/WkDrV5mbswW0
	0x29ck6Imr2zAa3ejcp/2KSaF0cETMIfvCCol+rszEoD0eVjtfa70YzoBL7fYMZtkas77HWp4/q
	cXi9ZiOw4rZZCAvveZAiY2sBYEBAkHmA=
X-Google-Smtp-Source: AGHT+IHBu7p/2mmx+FhXyVAuttPCWqOm5TyWz6tjpfh1VSCw7oFlLpS7Z57a7r/KgvwSEW2YM20kkC53mORH9TEqSQU=
X-Received: by 2002:a05:6512:33d0:b0:594:314d:ac53 with SMTP id
 2adb3069b0e04-59a17d9a47emr10254052e87.23.1767051724351; Mon, 29 Dec 2025
 15:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114104325.116471-1-marco.crivellari@suse.com> <CAAofZF51pkOzrg_nO0Mhx6g9b3JPtO3n+0YE=WtSgj_F6wnY4w@mail.gmail.com>
In-Reply-To: <CAAofZF51pkOzrg_nO0Mhx6g9b3JPtO3n+0YE=WtSgj_F6wnY4w@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 29 Dec 2025 17:41:53 -0600
X-Gmail-Original-Message-ID: <CAGp9Lzoj2jeGF+t-UP0gAykCZ96-OkjummeJRGniYfagvY-BPA@mail.gmail.com>
X-Gm-Features: AQt7F2r91KaVUEyIzuYeQQ_55HRYc3_5T1Vv877riVQa3S2VQymK3OUa69R78Y8
Message-ID: <CAGp9Lzoj2jeGF+t-UP0gAykCZ96-OkjummeJRGniYfagvY-BPA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: replace use of system_wq with system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 9:27=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> On Fri, Nov 14, 2025 at 11:43=E2=80=AFAM Marco Crivellari
> <marco.crivellari@suse.com> wrote:
> >[...]
> >  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 2 +-
> >  drivers/net/wireless/mediatek/mt76/mt7925/init.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers=
/net/wireless/mediatek/mt76/mt7921/init.c
> > index b9098a7331b1..95764b82da39 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > @@ -343,7 +343,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
> >         dev->mphy.hw->wiphy->available_antennas_rx =3D dev->mphy.chainm=
ask;
> >         dev->mphy.hw->wiphy->available_antennas_tx =3D dev->mphy.chainm=
ask;
> >
> > -       queue_work(system_wq, &dev->init_work);
> > +       queue_work(system_percpu_wq, &dev->init_work);
> >
> >         return 0;
> >  }
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers=
/net/wireless/mediatek/mt76/mt7925/init.c
> > index d7d5afe365ed..e33ab4849e8a 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
> > @@ -420,7 +420,7 @@ int mt7925_register_device(struct mt792x_dev *dev)
> >         dev->mphy.hw->wiphy->available_antennas_rx =3D dev->mphy.chainm=
ask;
> >         dev->mphy.hw->wiphy->available_antennas_tx =3D dev->mphy.chainm=
ask;
> >
> > -       queue_work(system_wq, &dev->init_work);
> > +       queue_work(system_percpu_wq, &dev->init_work);
> >
> >         return 0;
> >  }
>
>
> Gentle ping.
>
> Thanks!

Hi Marco,

The patch has been queued in the mt76 tree. Thanks for your work on this.
https://github.com/nbd168/wireless/commit/ee518f914cd901c16fa08a6f228b26655=
1f72a6a

            Sean

>
> --
>
> Marco Crivellari
>
> L3 Support Engineer
>


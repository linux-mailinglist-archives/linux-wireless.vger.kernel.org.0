Return-Path: <linux-wireless+bounces-12776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01581974484
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 23:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5841F26EAD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 21:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D517622D;
	Tue, 10 Sep 2024 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2fD7PH+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9B1F951
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002386; cv=none; b=U+z+aF0/P+YJjrWy+Snad0praM4K1y3cCS5gtkddlx7q3OVx63vQ3x8h0an2J5i+0Eo/ye43ITaYBi9+Qxv4XytVzaco5htAFfjWQLyWxbK1LHQXoqfmt9FgMfcju6jF1DZtIwDs8d/jPeS3wkRBvDKpe53SWu7ulybWkO5ITgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002386; c=relaxed/simple;
	bh=sAAUUXopCmPL0PMCAYsW78syDaV3KkSs6EW1eKZ0Pmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD7yMF64AbfLy/gxTdP3NvupaVcNErw7LUj6pJUxgKyC55tldCLCOj3QBN4goNCGY5/vWVcVgQwsNRUG5fvKVwXCxi/laAXwbn+5c7RYwciuVnthNCsjVkyQGBFS1N/014js9QSVoUD191s34YiRFCf+D0EZrbAH7qkhoxFd7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2fD7PH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D184C4CECC
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 21:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726002385;
	bh=sAAUUXopCmPL0PMCAYsW78syDaV3KkSs6EW1eKZ0Pmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X2fD7PH+mHRNrCaO4Z7tCmklng/Ey6lIQHpErGFbCGOaNisXnH6aaFfyEXehoCE4M
	 X05aE7N3jBUfOhLVZUh0ATOXrqmXuVSbPMZxHl1P9+iRTDKfXPHHjczdX0P5Lkp9Cw
	 +ZX5+2uYiMzLvDrYg2gkdu+5CGjmvIklbZzAxaBN0nqlrwsOOnx+RVoC3YtZuzxqVk
	 6Ig3IJ5xQUnRKT/r6WtlMkzLJhvCEkouZpQcX3SugVEaarUeN3utuUUv4eWBiGfpEO
	 pkaL1HLu4AJ+nVUxCrJkTw9fl5aKjuCEFYjXlkBb8YFMpZHWgj7nzDGI6zWWx9LV6e
	 QM2C3N4V2k1zg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d2daa2262so370194866b.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 14:06:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQQlI8UwmRSB5viLF2Ef39Yf7xGgNJtoo94QjlY24V3iaqgakfewgMvJk8lZvqvV3+Gc9E1w3W/5UzVlSe5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbF6gwPsEKAdqi94j0VU+FEejagO1pBKAQtrEAL8JBXEfeeQT
	59TfMGFnWhzLM9BmQs/q3B47NcxdXS3epAjV6o0sa6T5Y/bZ5puQdQwst8Zu40cBEAWfcOT4eD/
	XzEdYOV7XZu+P3qoQsatfD0YZhTM=
X-Google-Smtp-Source: AGHT+IGnLhBkB5leOVLLDMlXbrpQP36pdpkIvt6BFCVPK70qmwiwtXFYMt9UWPjoQzm24KD5Nu1Qlu/SvnqRElM7ENA=
X-Received: by 2002:a17:907:7f8e:b0:a8d:5472:b56c with SMTP id
 a640c23a62f3a-a8ffab2a1a8mr194700366b.22.1726002384095; Tue, 10 Sep 2024
 14:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ac1ae779db86d4012199a24ea2ca74050ed4af6.1721300411.git.quan.zhou@mediatek.com>
In-Reply-To: <1ac1ae779db86d4012199a24ea2ca74050ed4af6.1721300411.git.quan.zhou@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 10 Sep 2024 14:06:11 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzo=gErNFtYiR4a33jbo9LCHmWZf+j7GLAgSGPgFN9xbmA@mail.gmail.com>
Message-ID: <CAGp9Lzo=gErNFtYiR4a33jbo9LCHmWZf+j7GLAgSGPgFN9xbmA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix a potential scan no APs
To: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <Deren.Wu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Leon Yen <Leon.Yen@mediatek.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, KM Lin <km.lin@mediatek.com>, 
	Posh Sun <posh.sun@mediatek.com>, Shengxi Xu <shengxi.xu@mediatek.com>, 
	Eric-SY Chang <Eric-SY.Chang@mediatek.com>, CH Yeh <ch.yeh@mediatek.com>, 
	Robin Chiu <robin.chiu@mediatek.com>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, Quan Zhou <quan.zhou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi nbd,

It seems the patch hasn't been merged into the current tree yet. The
patch is beneficial for improving scan stability since we=E2=80=99ve applie=
d
ROC. If there's any opportunity for further improvement from your
perspective, please let us know.

    Reviewed-by: Sean Wang <sean.wang@mediatek.com>

         Sean



On Thu, Jul 18, 2024 at 6:51=E2=80=AFAM Quan Zhou <quan.zhou@mediatek.com> =
wrote:
>
> In multi-channel scenarios, the granted channel must be aborted before
> station remove. Otherwise, the firmware will be put into a wrong state,
> resulting in have chance to make subsequence scan no APs.
> With this patch, the granted channel will be always aborted before
> station remove.
>
> Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 2e6268cb06c0..84d6881eb4c9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -359,9 +359,9 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
>         del_timer_sync(&phy->roc_timer);
>         cancel_work_sync(&phy->roc_work);
>         if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> -               ieee80211_iterate_active_interfaces(mt76_hw(dev),
> -                                                   IEEE80211_IFACE_ITER_=
RESUME_ALL,
> -                                                   mt7921_roc_iter, (voi=
d *)phy);
> +               ieee80211_iterate_interfaces(mt76_hw(dev),
> +                                            IEEE80211_IFACE_ITER_RESUME_=
ALL,
> +                                            mt7921_roc_iter, (void *)phy=
);
>  }
>  EXPORT_SYMBOL_GPL(mt7921_roc_abort_sync);
>
> @@ -861,6 +861,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, str=
uct ieee80211_vif *vif,
>         struct mt792x_dev *dev =3D container_of(mdev, struct mt792x_dev, =
mt76);
>         struct mt792x_sta *msta =3D (struct mt792x_sta *)sta->drv_priv;
>
> +       mt7921_roc_abort_sync(dev);
>         mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
>         mt76_connac_pm_wake(&dev->mphy, &dev->pm);
>
> --
> 2.18.0
>
>


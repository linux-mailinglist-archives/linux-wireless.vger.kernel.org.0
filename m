Return-Path: <linux-wireless+bounces-6467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF68A8ECD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 00:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0CE1C21150
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 22:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E893770D;
	Wed, 17 Apr 2024 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VezAkQXD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B01E484
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713392475; cv=none; b=a1w9ibR3j04ntn62dLMBGJIAklIcMAaH0Xe38f/S5N0woefgdVNh2qLXjb+Ql8cCRxh/sLiIhunWVWeGWJj+QmUwfu0ZugkzCtix7lbyB/q2+hpaRwYN1sNAv2KH9wp7vXfWY4C5oq+fSj6iD3ynAS9iFqxskP/4W6emdIICjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713392475; c=relaxed/simple;
	bh=+BAMojwjadnSVQR4EfI2pK9waO2X2I20TlzjslDl02U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbZG9Dkm2oosQHQoDq5LiaFfxQIdTnMlJmlplDOeVdjimKSeY20H5FR9LAhsDA1KD//RPxOEVnDO9zsizuAOmvRWw/bzT7o8rmQlzH8exQW1lzEQrvNYQqPOfDXSRkUnb/qtyuAKs9YPVaaPi4VPm3mSUmRysCdkppvL9dPyTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VezAkQXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E16C072AA
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 22:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713392475;
	bh=+BAMojwjadnSVQR4EfI2pK9waO2X2I20TlzjslDl02U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VezAkQXDloa+HDoGyJmUuhFB4eJk1guhNZMNlXGZeZjhhls3vRB8ixK8DkxF7drMj
	 CLTkx5PtKAkWxTRq3E+b6H8VmD3dM4k6t1xP+iiGEXrs1PJuPTuTPIc5ROiDPwqTip
	 KckyD9hvgyYBQgLdX4pD//+V0FbSwS8f/KDrjfUEWay8uYZ/Ec+OHa5MsFIj9HuK/N
	 Ud9XHFznb4t1uXL6L9l0x4DVgwntnIv8BgH3/5jUhrOd1PnY+Jvp+xxlxFvh2zuoqR
	 dSy00kpCeenb4w+142Kt9kWODVb3SZBq1Mqt+4UO+hlU2arknRzOmNF2wIRD0ucjFQ
	 DeRKHlZZdFkhQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516e3103d92so40744e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 15:21:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQltC9IHTS9imgVEvFMGRyu83g0y5YNvohBfVSRTCL18F7B06PGFFv4dwiCtc6bo7i6ltLr3+kXvRDfrGDsH8ubjVQ9nP+MS6xGSa/v0g=
X-Gm-Message-State: AOJu0YxPdwrZw3evVhE2KPiV1aLLnbXXQSGItBQhrA8KTn7jFe0jCiW1
	a+1uCDtbdD+aGC9g0w7tmGb4lssAl+8/ncZT0SAdAbMQNGWfpk5HhvW3T178eLSe+NUIjloRK9i
	rOGqRWbjv895ie+gBaQke/9WCCmQ=
X-Google-Smtp-Source: AGHT+IFkfXf2OCtLVJmfncYG6vCXNIfGAjjXv3XCrX64sLKZnXX8ETGX/eAiHdJpp9kzCx98UTabt4bVZADhqzoE7cE=
X-Received: by 2002:a19:4302:0:b0:513:30fd:2991 with SMTP id
 q2-20020a194302000000b0051330fd2991mr271662lfa.0.1713392473669; Wed, 17 Apr
 2024 15:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307110815.527-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20240307110815.527-1-mingyen.hsieh@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 17 Apr 2024 15:21:01 -0700
X-Gmail-Original-Message-ID: <CAGp9LzqHS5Mdge1V37NGY3MFLwxA8YhRSymB+ijw-5u=Uk-66g@mail.gmail.com>
Message-ID: <CAGp9LzqHS5Mdge1V37NGY3MFLwxA8YhRSymB+ijw-5u=Uk-66g@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7925: ensure 4-byte alignment for suspend &
 wow command
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc: lorenzo@kernel.org, deren.wu@mediatek.com, Sean.Wang@mediatek.com, 
	Soul.Huang@mediatek.com, Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com, 
	km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com, 
	posh.sun@mediatek.com, Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, 
	Shayne.Chen@mediatek.com, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi nbd,

I'm aware that the patch has been merged into the mt76 tree though.
Could you assist in updating the commit message for the patch in the
mt76 tree by including the appropriate "Fixes" tag and CC to the
stable tree? like Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add
Mediatek Wi-Fi7 driver for mt7925 chips")  Otherwise, the mt7925
cannot operate correctly.
      Sean

On Thu, Mar 7, 2024 at 3:08=E2=80=AFAM Mingyen Hsieh <mingyen.hsieh@mediate=
k.com> wrote:
>
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>
> Before sending suspend & wow command to FW, its length should be
> 4-bytes alignd.
>
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 1 +
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h      | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index af0c2b2aacb0..ef29d093f9c3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -2527,6 +2527,7 @@ int mt76_connac_mcu_set_hif_suspend(struct mt76_dev=
 *dev, bool suspend)
>                         __le16 tag;
>                         __le16 len;
>                         u8 suspend;
> +                       u8 pad[7];
>                 } __packed hif_suspend;
>         } req =3D {
>                 .hif_suspend =3D {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mcu.h
> index 2a0bbfe7bfa5..b8315a89f4a9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
> @@ -535,7 +535,7 @@ struct mt7925_wow_pattern_tlv {
>         u8 offset;
>         u8 mask[MT76_CONNAC_WOW_MASK_MAX_LEN];
>         u8 pattern[MT76_CONNAC_WOW_PATTEN_MAX_LEN];
> -       u8 rsv[4];
> +       u8 rsv[7];
>  } __packed;
>
>  static inline enum connac3_mcu_cipher_type
> --
> 2.18.0
>
>


Return-Path: <linux-wireless+bounces-9562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2361191724F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 22:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEBE1F23F22
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4117C228;
	Tue, 25 Jun 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5Johk2/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69817CA16
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346267; cv=none; b=hQtvaHsC/mXTHZnetEIE3CkII4hmv7WxMfLUZSjkhAi04CTNa5MXFx0K3xm+foYv1pC8KLtX8UXrQEdzuOqTDbAk96xEah7NBltvgUQnK1m1x3E2DYyIUvdLgbZe/vqxfa0S9CP2RbsOpKQc11fonPUwnQgisz9mLag8pljlIJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346267; c=relaxed/simple;
	bh=hpr7QzhDFDqCjdlXYJTyKCTQNje35SXe6h5mD0TlRUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qH5mfXgdSWjY7sUuUXBtejQynxdWof1tXvkxrIxmKGgGCBZc8xgNUy64ZJqpRo8/+cobWsEKlXZMtR115/WSM3HdEzxgytNfpTiv5fiLKanmnycm/YUqFOhns4RrHBZrsvNoQ0Dw0D65ql44XDq5Lld2WN1D7LvREl9CW4lwFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5Johk2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B37C4AF09
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719346267;
	bh=hpr7QzhDFDqCjdlXYJTyKCTQNje35SXe6h5mD0TlRUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E5Johk2/nKnm71ar3ioCOyyXdKZdIQ6i28Tr241iD55Ql+1KtStYz0zulw4ULkuxo
	 JqpkeIQC9T5JAO6HklcjJ1EhVhJgMHQ84mampF0dHD3E/01Lvj7+ZihxK0+96ciCNR
	 YWwo1WQXmv/jRWP5x6LYhKjPEFq19zwayqV2nlWAq6HWkPEh/axcXaL0UZjAiaHX0J
	 Oq1ZnhLnZpflfmdyzzJYEiTZqDD9LXDbFXL/IhydrolpLLvKwoU8BqpR7bQtb3ZAKo
	 YUrAqDJJ7FMfoS4d58I3eqjnLOBgG5MNhkQzupcvavPUPuEvVN44aAAmG5EmfSZWX4
	 JQqqJ2wQdX0wQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7243eb43d1so41168866b.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 13:11:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXk/OOtb76J6hJTAYyC60zvcrBDkWUGgNfdW7jRs5jpmv0wNuUeBNvF/Y9GHGwcGXYpz3LoDXrF2NMrvbJZkcVg+xbpUoxmHGX35837WKA=
X-Gm-Message-State: AOJu0Yzwn1c3D0ZX38O5Q9ocNKpQ9MJmBxyLuJ/zKo/n6emou3iGcW+1
	yz2yhA+INyTxhnvgtAxBrZvLOGg8q/Ol3lPRhAo1e41xWSDxvsmuyKRmrw9+dzcKYPIMGbfEpg9
	+4owMCf+b27JXJWvzv+bjfLN35DE=
X-Google-Smtp-Source: AGHT+IEmjg3v4/vkEvS5zJcImLUEJLyeSrZ/RnyJkdkxhuZYb2B63ytqyAtzJHCcXAvevmNJV00Sw43CcjelXa6uXU0=
X-Received: by 2002:a17:906:f8cb:b0:a6f:e105:8ba3 with SMTP id
 a640c23a62f3a-a6fe7801dc5mr619881166b.6.1719346265940; Tue, 25 Jun 2024
 13:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613030241.5771-1-sean.wang@kernel.org> <20240613030241.5771-38-sean.wang@kernel.org>
 <94abc74b-dcd5-47b2-9364-cfd5d3f28846@nbd.name> <4c02983e-2377-4c26-bcd6-3100eea19aeb@nbd.name>
In-Reply-To: <4c02983e-2377-4c26-bcd6-3100eea19aeb@nbd.name>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 25 Jun 2024 13:10:58 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzp7K810+pdrkzhxtzFZkrctY2aQyLObyE9Eq-bngj3s9A@mail.gmail.com>
Message-ID: <CAGp9Lzp7K810+pdrkzhxtzFZkrctY2aQyLObyE9Eq-bngj3s9A@mail.gmail.com>
Subject: Re: [PATCH 37/47] wifi: mt76: mt762x: extend mt76_connac_mcu_sta_basic_tlv
 for per-link STA
To: Felix Fietkau <nbd@nbd.name>
Cc: lorenzo.bianconi@redhat.com, sean.wang@mediatek.com, deren.wu@mediatek.com, 
	mingyen.hsieh@mediatek.com, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

Thank you for making the changes. They look correct to me. I
appreciate your help with this!

      Sean

On Mon, Jun 24, 2024 at 12:03=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote=
:
>
> On 24.06.24 19:44, Felix Fietkau wrote:
> > On 13.06.24 05:02, sean.wang@kernel.org wrote:
> >> From: Sean Wang <sean.wang@mediatek.com>
> >>
> >> Extend mt76_connac_mcu_sta_basic_tlv with the per-link STA configurati=
on.
> >>
> >> The patch we created is a prerequisite to enable the MLO function in t=
he
> >> driver. It is purely a refactoring patch so the functionality should
> >> remain unchanged.
> >>
> >> Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> >> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> >> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> >> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> >> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >
> > This patch is broken on non-mt762x drivers, because the functions that
> > call mt76_connac_mcu_sta_basic_tlv may be called with sta =3D=3D NULL.
> >
> > I've seen it crash on mt7996 because of that, but mt7915 and mt7615 are
> > likely equally affected.
>
> I've pushed a fixed version to my tree. Please check if it looks correct
> to you.
>
> Thanks,
>
> - Felix
>


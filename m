Return-Path: <linux-wireless+bounces-32068-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAAZMa6qmGn5KgMAu9opvQ
	(envelope-from <linux-wireless+bounces-32068-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 19:40:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1785D16A233
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9614A3035AA9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 18:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC923C4F2;
	Fri, 20 Feb 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBGabEWW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B573D76
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612790; cv=none; b=iRxwxGmUfrezKVFskia7e49MRd7URsYn2Z78t6L3m3Sr/OkSIImdt9wS6ByMOWoS0wk87Jt2j06eBSZArejp+Sj7MswwaFktKBdQlwG8lGfIcTbFVIkVWmAsGSq4jw5L2NSe+rwfOM4elAFu9bELyn/VMfZhcpefV2RGoCFxGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612790; c=relaxed/simple;
	bh=5381ncl+i3DeRJNXMHjSIVGfU1Cn20+SK2GkcZCssO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEW8nqnIQoRl45vG42bDkXC4FkVgYUK/6pUV0pXbPKXHC+odOJeSLJOIhWa+a3eLiYfdnYsjnkJsIp8wQjNLCevM9TpgxGr+m1OogpExQFpnR6689X/RMwpLhU34gV5wlTeekiNvIWsXN31gaWUDudLebU7s+52KHuDKY3KoHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBGabEWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E475C116C6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771612790;
	bh=5381ncl+i3DeRJNXMHjSIVGfU1Cn20+SK2GkcZCssO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lBGabEWWsd4EIsekD8MaDuPKqwdyX+HEKywI+7kv+weBVA8spFSUlRTM6SrLqpbRm
	 y0ZaXQ7ms9KM1kiRqOyeby/rQCfKLE1yxQtARi7h4bdNLE4WNSeLIbfOI5JFGb8YZj
	 Xu8b/pnEGXKKvJS4hD+mYOMC2pRVDtxiHSA9aSYM1IMiPjJzrLuh3Kc8+LSemZdWQ6
	 wDuzZE4XskIUyc2EfNp4tiEN69z2968GhDxrzVrwK5RJ6nYvf7Egt9CWbQPRDHAtJV
	 /s+gb/IbLOh7u7Nhxp0P0HOjcAY+VFAMDi0tJtwCqOOgXCDtWB/3FrhToeKqOXEJPc
	 kOsg5xCXdumFQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3871126dcceso19339491fa.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 10:39:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzMMJOoWg28EeZc48DnuvxxgafV3dVgU6Olvn0PC0qHWODGWjzkCjH/qyO0F3NPXQ6wmR8IEogorEO/zP2fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KSg3s9FwhaItg6SXuSKOllv3qh8mVPbks0LqAtlcvyimU7OV
	wyJBoNXt4ej10pUkfifyC1VP6qcmVev0dN139rNYTM21FQU3+ebFU3c0Chb5uGMHzct+hEDPcKW
	30vbMcl8OYisus117Io0a+kVEb12cd5E=
X-Received: by 2002:a2e:be1a:0:b0:37f:b6a4:f5df with SMTP id
 38308e7fff4ca-389a58a072bmr2575741fa.0.1771612788762; Fri, 20 Feb 2026
 10:39:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219004007.19733-1-sean.wang@kernel.org> <20260219004007.19733-3-sean.wang@kernel.org>
 <39e814ff-2ea2-4984-9e8a-2902fef7c4bc@manjaro.org>
In-Reply-To: <39e814ff-2ea2-4984-9e8a-2902fef7c4bc@manjaro.org>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 20 Feb 2026 12:39:37 -0600
X-Gmail-Original-Message-ID: <CAGp9Lzos_u7pQQtvmFMzcnJ3JxyFwf6h=ZH=zGwp5pmrNsbR4A@mail.gmail.com>
X-Gm-Features: AaiRm53lLKBAKXycbad-w8DaS1gdC-crDm_9Fe1tUWIv13Okh2y4_fIeyrE4Y68
Message-ID: <CAGp9Lzos_u7pQQtvmFMzcnJ3JxyFwf6h=ZH=zGwp5pmrNsbR4A@mail.gmail.com>
Subject: Re: [PATCH 03/11] wifi: mt76: mt7921: handle MT7902 irq_map quirk
 with mutable copy
To: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Cc: nbd@nbd.name, lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Sean Wang <sean.wang@mediatek.com>, 
	Xiong Huang <xiong.huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32068-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mediatek.com:email]
X-Rspamd-Queue-Id: 1785D16A233
X-Rspamd-Action: no action

Hi Philip,

On Fri, Feb 20, 2026 at 4:09=E2=80=AFAM Philip M=C3=BCller <philm@manjaro.o=
rg> wrote:
>
> Hi Sean,
>
> on Linus master tree we still have 'mt76_mmio_init(&dev->mt76,
> pcim_iomap_table(pdev)[0]);', hence your patch currently won't apply.

The patchset is based on the latest mt76 tree.
If needed, please apply the following commit first so the series
applies cleanly:
https://github.com/nbd168/wireless/commit/4eefc435c985f4dfdba9afb1c705f0e17=
377c084
That patch will go to Linus=E2=80=99 master first, then this series.

>
> On 2/19/26 01:39, sean.wang@kernel.org wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > MT7902 PCIe requires a different wm2_complete_mask value, so introduce =
a
> > mutable per-device copy of the default irq_map and override the field
> > only for this chip. Other devices continue using the shared const
> > template.
> >
> > This is a prerequisite patch before enabling MT7902 PCIe support.
> >
> > Co-developed-by: Xiong Huang <xiong.huang@mediatek.com>
> > Signed-off-by: Xiong Huang <xiong.huang@mediatek.com>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >   drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/pci.c
> > index 65c7fe671137..5f857a21f362 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > @@ -327,6 +327,20 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
> >       dev->hif_ops =3D &mt7921_pcie_ops;
> >       dev->irq_map =3D &irq_map;
> >       mt76_mmio_init(&dev->mt76, regs);
> > +
> > +     if (id->device =3D=3D 0x7902) {
> > +             struct mt792x_irq_map *map;
> > +
> > +             /* MT7902 needs a mutable copy because wm2_complete_mask =
differs */
> > +             map =3D devm_kmemdup(&pdev->dev, &irq_map,
> > +                                sizeof(irq_map), GFP_KERNEL);
> > +             if (!map)
> > +                     return -ENOMEM;
> > +
> > +             map->rx.wm2_complete_mask =3D 0;
> > +             dev->irq_map =3D map;
> > +     }
> > +
> >       tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned lo=
ng)dev);
> >
> >       dev->phy.dev =3D dev;
>
>
> --
> Best, Philip
>


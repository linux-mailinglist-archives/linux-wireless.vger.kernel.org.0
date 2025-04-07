Return-Path: <linux-wireless+bounces-21178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DAAA7D265
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 05:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABDB7A39F6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 03:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE3F610D;
	Mon,  7 Apr 2025 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxwFlP/w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA6139E;
	Mon,  7 Apr 2025 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743995751; cv=none; b=Vp6YCJNgCYbkMsYJ1MGwr5VIgOoNE49/ShafYb3XLp+X8Zlr2ywzsW8miI5jtX1o44tt6C0XP4HZGmw0j8plfMtaTdtppCXXnuf337dSyOxeXiV/HuyUs1ncuJpqcpcIsmCHHxAYGmr36lykZU2kbvSMHgUC4IHs3vPETDQZmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743995751; c=relaxed/simple;
	bh=sWd+Hr6z4ZGOuTQ5zIXgD2YnXsigspmEtU3bafHQ4AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L99kaV7C431werKh7nIA+rx8WPp2wx/SHrHvH99s6n1kQ0jQzJwQuTXXJTrE1q05LQuyGZxzjT8ZfdPdVTmacoiqTbtgy7ahebjevQPBEv6suEwATT3VHIrYqr0Zx0RhgxnlEJll2OtKq3MnjfPmPENUzGkXeY5o8vWKAhC9mW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxwFlP/w; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-30bf1d48843so34179571fa.2;
        Sun, 06 Apr 2025 20:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743995748; x=1744600548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqDsWVFq6CmNz/0yFdKFX32jFAy7M6dtMt4P6N2Z6wA=;
        b=fxwFlP/wLQbMMKqH8Ab74GINSwixplRNXCDymhJ4UEiaM9tH6r/BkqZRzz2K8CiFbm
         UMiZbbGZEFih0B07w3IIpHCNPvlCbIO118igmNv5mg/wdU/HKmPAW3JEsAxsMHk6YMH0
         VkYvbdmW6Fkdsj176PgmxC1Ek7ZYas7XYSxwvkR0QTwF5u7ZIzFiaRsf+LCNwVYt41c8
         aHDXqZuYbVzqMyCpY1HeX2wNAGdLNEBd8h6zBQEq24KTHkcsd4PXHvAjpCaYKndrQtmq
         ps6EFWIdhu4WGzh12Y2eLmIkhoVIQovB0kbKhtAZRMdTjOEOq6OjOU5H8ZNZF0ypOd69
         cDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743995748; x=1744600548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqDsWVFq6CmNz/0yFdKFX32jFAy7M6dtMt4P6N2Z6wA=;
        b=al2SwKQZt1CCJXIAk75wuJMG3YeEjquNIe+ilaytDH+xt3hoI2raudnVUAqsMYhCr5
         7OMIA8LQwIl33WUvUV0fqMinooz+RcsQHCbuZ3glBP4X/5rSuQYXdrVqUgBIf5exWA2T
         T/dp0CzLCaHAkAEoTj6iq2xjByQndcAUGX5xXp083+ekL/vW17I29PGh4gQTnFo+Rprr
         ockkIGANySv77TdAvQ3viaY8fr7AumlAdKz01WZiXHikzci6pwdRuH46IP43453r81kC
         3sXGTysgtSgyM1sfr0dzieTs9PgjjBZhcKkJZCZiihjRJS0gOg7BRtVPAVEvkiEKhKBI
         CJyw==
X-Forwarded-Encrypted: i=1; AJvYcCXxZo2ruq0HOlbF+DF629V2vy+IEoQpluh0VMjSWZzxfVlmaivdBv0cxVMovgedFxpDjD8zCO+rTr15Tkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8N0cHWwnz644O/r1Iu5hkg61cTzo36B8Tc8Qn3fEkdCw5XlYt
	ZoLCp+HF6BqzyChtYe7h6PYFvFrfKLHugQ6mPh6ocVIxpSkkASHeBjLvKIp6asgkbHP+rq21r75
	uaAKquluqD9/xBEtMWeNB6xY72NA=
X-Gm-Gg: ASbGncvjwLh/qKiQLYQNW1Ahw0LG6yRX+n4RPpCWKQAYuGSrfto7JxLHAoYTeZudQNM
	Eqk4BmBoatHm40Pm++5feyKlRw/1C2I9516hyKpkC7/GOsZqOyx5DramwsHqNA5ksdi4AZY9UaD
	oKzXw3Lo5nHdZp/sTo7eZPte3f37g=
X-Google-Smtp-Source: AGHT+IE1/krWBer5PlXlNstxZmEQ7m52OIfXmOpc5fR3+RwNHJcKV+9HLLyqwwgFSrjQDe5S5gtm8Yxvggz68q1KRMw=
X-Received: by 2002:a05:651c:1987:b0:30b:ecfc:78c6 with SMTP id
 38308e7fff4ca-30f0be0402fmr29433611fa.1.1743995747797; Sun, 06 Apr 2025
 20:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403064344.64253-1-bsdhenrymartin@gmail.com> <db778d8c-0a56-4b01-b5b5-5610a68a4875@web.de>
In-Reply-To: <db778d8c-0a56-4b01-b5b5-5610a68a4875@web.de>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Mon, 7 Apr 2025 11:15:37 +0800
X-Gm-Features: ATxdqUGqt472XmSz_PMOlPioxTI8XhNNFObI4ZwjTYubgdvn8cZdtUxQubfAd08
Message-ID: <CAEnQdOox3XQnKVwefaT6p1rp=xEq1Ki4uD63nvwrjLCnVkZPmQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: Fix null-ptr-deref in mt7996_mmio_wed_init()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Peter Chiu <chui-hao.chiu@mediatek.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Rex Lu <rex.lu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Shengyu Qu <wiagn233@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, I will correct them in V2.

Regards,
Henry

Markus Elfring <Markus.Elfring@web.de> =E4=BA=8E2025=E5=B9=B44=E6=9C=883=E6=
=97=A5=E5=91=A8=E5=9B=9B 18:13=E5=86=99=E9=81=93=EF=BC=9A
>
> =E2=80=A6
> > Add NULL check after devm_ioremap() to prevent this issue.
>
> Can a summary phrase like =E2=80=9CPrevent null pointer dereference in mt=
7996_mmio_wed_init()=E2=80=9D
> be a bit nicer?
>
>
> =E2=80=A6
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
> > @@ -323,6 +323,8 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, vo=
id *pdev_ptr,
> >       wed->wlan.base =3D devm_ioremap(dev->mt76.dev,
> >                                     pci_resource_start(pci_dev, 0),
> >                                     pci_resource_len(pci_dev, 0));
> > +     if (!wed->wlan.base)
> > +             return -ENOMEM;
>
> Can a blank line be desirable after such a statement?
>
> Regards,
> Markus


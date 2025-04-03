Return-Path: <linux-wireless+bounces-21121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9E6A7A080
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 11:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6BD173BC0
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6380F244195;
	Thu,  3 Apr 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Gs6IRBSP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23A243387;
	Thu,  3 Apr 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743673987; cv=none; b=I0lZM9SCBHoFDPn3AHv89WTXiF8mZ0SqXf7GgY0MR0Kd/GFNOaj5TIMqGPGFX/b4tKOnzxESpbzGC1PdGVTl/7cKUO8gR6/oLl1YYlZuvLYpxRUEhFlDZo3ZGVGsQjWfryvFi0wYUPUMYTue8iTeGC6OXZ5O/n8yA5yndQ4LS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743673987; c=relaxed/simple;
	bh=KvtBM0ZRSiwhmzmpnxmIE3L/R2T+8ruIpO53DebI4po=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gENIsIrPsiJnVHeZ1AomR3lJqLV+PIWobLwXRGodTCxnSBFvZyxBq3DMcK/zVvOizAtw/k7JCQyv9NPTa2ZbTttlRTOuY7zDX3b6I8lA29zN78qdwzRqrHl77zX3IR0HtMATqh6Tqj8uEBlNttJqWxWVUYB0ZZ4vM8rE9NDAlDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Gs6IRBSP; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743673965; x=1744278765; i=markus.elfring@web.de;
	bh=73c+mDPTV3enfh00xFQH0rkQ3B7hoaOfs79Gig8ynL4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gs6IRBSP30nqBoVeW2m1+w37RYHjZS/3Xoi7eLsKGvsNN/bFKsw2/1W30XAJ8NG7
	 35iYnymvevIJdmOxl9z/QqsiMSX1XM6G8w9ZXvMGZaeKqANUyIR4BYNpaZ9UCSB/t
	 iHcfV+UpAoQGoCOiAiTZOZudkX1QO3Al3gWZRNxI4EBmSB3GW/B+bHPR33eL7pdrz
	 4KB2nI4KlqIHemmYmsI1yCPjvSXV8XKLhcyVkv/aPzTBVQFzlp1Yauh1S26j+QD/D
	 6R9l+iZSiseYo91FGF7OsGx2ckkT4a3gH8qs6PnPGHnk0QkFbOHvmFZKLn/IaJdfV
	 EvoylHTGYio9O0ZV1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.50]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzeZ-1tSZWq0xRd-00ZikS; Thu, 03
 Apr 2025 11:52:45 +0200
Message-ID: <41f9ad4b-382c-4945-82ac-ec38bee87937@web.de>
Date: Thu, 3 Apr 2025 11:52:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chad Monroe <chad@monroe.io>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Shengyu Qu <wiagn233@outlook.com>
References: <20250403065251.64749-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7915: Fix null-ptr-deref in
 mt7915_mmio_wed_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250403065251.64749-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rMLkyUnskGPkc7CWGHQK0eH2zwgXWMQzE9a9IajwH62GgqYqjvN
 tGX03ua54yJuhNQ3KNuKe4f58fK6oBxHaVa6MKzEKMld2Y1jFlSDVX0epXnx52t3W364gkR
 gpLuVOGXzmiZqoBK50Wmd7cDVqWfCgXtsb+DzO775fp9ap/PNy9wee3eIPMcOfNMUL2CJ0R
 70uZfgZ7z3xr42aY5m8UA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pD0NSjZ9QWw=;/baeS6cvg/lHM2Kyl7abZ4oanhf
 o+3hFID+PCwZrrDLY26nD2hdcwEFUmUrq+z7MtMNKtcchbTSfVyJR2SdFujvBcOnBdqJpwItV
 l6nxkTz3601pODWIPaRYRLAgQRQ1SxietJCd8fRjcNcJXfwrHlh0+xRdfCrXqXK79DMii6rd4
 JzpK7hEgQW46dqrOAHJrjTmmC177feCJVktrA9t3PRxQbKBBZXlcCeiD+1htQi3NjgBxxXBBd
 Pl4LYjdbclzx8HRdTXpanLfHWW3EseVrHr2U2q1DQoOXZblH0tApHhdX+J8gQF9olLb8p2DP4
 qRdD0g3nL3siaQHEz6jWN+sCBjYt/q75VmyJCPDdALV+ZSUZp9J8tI/TNRL5iPauLwcNE9kFB
 wmTf2ukFtILVy3kcULVLWWIZjq0DCmKrj+bc0v1n2z4pDxIjulbGEDBTtKrHoVxH7HLtg4Z70
 kgdD2CJmoglxs2pMmkAz50wDy9RabVbUVllKVfM0Wkcb428cNIu+q0vBIe7L2EdSPWXF0FkXI
 FzGrJbd1chORjvbLAGntd/AEjDsT0J0uQl9Ic+mKxudBP7GVLmBv4+CkpasZIYHDtqYymUTwy
 qUsfwoKDNmOEzhRRqGiZxVpsMhfgCjdebxXeRnNHKgDSXoX1RKgMClBM9riDjvqGCsGKJXcxj
 fKLIlKQ7m+QM2UeGuoKLB9GAzQzUktce7+x61fF0jngx6Gm+kGYNzIL6aJfWFdIPFwSzhSG3Y
 MwRJopsdiBX8JkunzqTyx69jd+hQN9yf5W9xW6hXHX/t9YZvYy2jYzcYYab44bqmFYEwXpbqx
 /wUH+azhxuYEUtySNf+asyfA9OR2C0dJodcIIPEn4YwLjoow9xQBY0dO5Cfxe4OGL74ZCoTM2
 H4tfiD2VMZ4Eps7EF+Q2DlAlw/i+T48V5ROTnYkN0XJGoz+DwyJh/sXsDL9EV4M7bII1Hkezo
 G2WuX04Lkn32+jSzYqHmGhZRgIKiYngquinFFOFSbdxWhOoHJqzdmrS8+0GYtG0sq5UY/2Cjr
 wWk6Z0PjGQ251rh2eDyiCEc+pmIjDjBKtZkfMdamAhOTM7NW+mqxUCqxmRZNIba8U9rqFx8O0
 v+JeW3QBNAZiO6KdV4SB8y+Bi7/Vr65aHE8I9HHOKPfA1hYiZRsQWaDXlyTfHGSqYpM4mUMUz
 CYMj4uZWKKOFzV0ZtQY3VyrhACbVAuKShOO5VYuF9QsfApLxKppxZDRvURE7CZ4GvGwWCjIS0
 HcqO78XXQ/rLAQJJxI1ahmnbMoNFgnmKCwuPY8idCZ5WMpfwZqJmfUOMqO760x290xE9vhuhf
 ilVIAg7of4C18GB138dvksDDgZTQxi6K91vC5ZbUMUsVWABdT6PMYOOyqvE03kcWkbW41Ml+o
 JpDDHeWMZQfcDn44YhkLu6Xe6ZgXS2n7IDkzXo6Yx8tzkE1g4D9dkJqP5uiWPUyRv6ewg2f/I
 AkmhkbJXtI06dD5n6YQ1tOz0fR6OTIaf3nzgKEAu6xfnQhacf

=E2=80=A6
> Add NULL check after devm_ioremap() to prevent this issue.

Can a summary phrase like =E2=80=9CPrevent null pointer dereference in mt7=
915_mmio_wed_init()=E2=80=9D
be a bit nicer?


=E2=80=A6
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> @@ -651,6 +651,8 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, voi=
d *pdev_ptr,
>  		wed->wlan.base =3D devm_ioremap(dev->mt76.dev,
>  					      pci_resource_start(pci_dev, 0),
>  					      pci_resource_len(pci_dev, 0));
> +		if (!wed->wlan.base)
> +			return -ENOMEM;

Can a blank line be desirable after such a statement?


=E2=80=A6
> @@ -678,6 +680,8 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, voi=
d *pdev_ptr,
>  		wed->wlan.bus_type =3D MTK_WED_BUS_AXI;
>  		wed->wlan.base =3D devm_ioremap(dev->mt76.dev, res->start,
>  					      resource_size(res));
> +		if (!wed->wlan.base)
> +			return -ENOMEM;

Would the function =E2=80=9Cdevm_platform_get_and_ioremap_resource=E2=80=
=9D be applicable
in this else branch?
https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/base/platform.c#=
L87

Regards,
Markus


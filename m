Return-Path: <linux-wireless+bounces-21189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BBA7D70D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 10:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830A3188B859
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 08:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7135968;
	Mon,  7 Apr 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Kl+KgrHe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC33145355;
	Mon,  7 Apr 2025 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012842; cv=none; b=dMPrKXJmqZbFbvA+fr5sEFXHHcOFQr1ASegoI5KJPHGUG6aDbD78KnHhOCDeNFsGIaiLz6dFti3pU0VgTnwisXTmEARPJKZJYia7VOzRo6ODOgQSd/eFLEik2350GSfBc0k4Hf28hIcd5lLATdwkr1DmPMEeco2Lt6zWg34XUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012842; c=relaxed/simple;
	bh=czluTlRENttFbngRG8Ww5kqyYIBW8J2Tzsepd3iJifA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qmnQiv7PEvL2lk6Hp04zEitjRIyOfesVIZSzVGV1cwuDjGLc1hNfVmuH/eoxNrf5aCO2zH4bvhktaP5cMCyHvFgMrNdX+g7xi/K2OBUJTQSaXIu0E6tPQCzA46LJvyZy0pIcpa4JV+SZcyz23mqUpFzbAft+AwH5lk5cT8KjnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Kl+KgrHe; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744012825; x=1744617625; i=markus.elfring@web.de;
	bh=0jZmhDZudwbmeQKUZf99XBuFy576VsgeJRC56CQxISU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kl+KgrHeWQp9HhxxSC2q7E0/B3G/WAiO/wMBrnYkUPUmu0YjSHFmco6/V2Okd7VN
	 wJ0RrDJeczZnRtb3ji1hAf5pHdvO93rxu1d8Kq7IxLXunj39ReFo7ik3EBbjTfmJx
	 EkRETrGKbX2c7DQHON6dJ08zVVKMkkq7dvN+2/M5bOjES4XZIUqKoM/x1gXdzPlYa
	 VT+sRbTY/kF0bbR8fLwljfgmL/jTkzAbTbkO9j1PRpO55OW2xCYNuoyrUJgcU1i3P
	 fCFzgqwr26J4yOk9EDpu1iXpObROW50D8vs+jpvsx6ZncFutSDcw6EzHe6fX5Qksp
	 3au2ql1gjpdGcChStQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1tTBbI21VF-00jGQQ; Mon, 07
 Apr 2025 10:00:25 +0200
Message-ID: <946ab07c-47d0-443a-9ece-2ce65d586bef@web.de>
Date: Mon, 7 Apr 2025 10:00:23 +0200
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
References: <20250407061900.85317-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7915: Fix null-ptr-deref in
 mt7915_mmio_wed_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250407061900.85317-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oLbjMncbOULxE9gX3qvqqW9FqKIyHZrKv6CYE+c/GKKRkDElqtj
 GgUW6lLILmh6lGxnqBPfN28dBS1rPRUqjByrgfxFFAyDL8eSLoeWu7p9WKw7yTBKXGaDBtm
 QprydO14pTEfekV/cHFu+G6/2wVefZu8VrJPYWMK0KH4mzgJPSHKfOKRvdOiOZnBr+alMHs
 nKeh54XLeOq9FcJEw8A4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EqVqH2Yl4Hk=;pXLjU/2QG4i6RlQsohpA8k64bMJ
 b/BflAaMnh9FBt8b42gDhJknR8RaiG7KJDpCQE/Ak6Dfo6nQyKrYhbOpA/YU0Fvtawgu725HX
 hPnIeMaAoXPHxZ2hMsObAgg8XX6sjGiG4/ZG2YCWU4Ws2cSEDICGxW1JFJHWDQqs1nkdIWHGw
 pizqWSTOFJfUh36IrPAY4BLEVyP4IffcNND5x7LQDD/6vlIFpfHjdSmTTtPGhqgtqgE8G2q3z
 oQFFzrCbwIievGtgANlwmY/rbNRAt0/gOCTXbX8vxgpj6tCc3K1ltUlzTPO4eKZn+V1G1A2x3
 7hcxVIiR1TA0TCekD8qc65/QPP8r6demyZ5qjV2FTW+AeyAe0KrwHsyzHbYSBp1QstVpA4Kfa
 +9SsPcCPZnbmZkPzrJ4ooniLQW6Lk+E5xhXkz3JbffoW7AJPfyhXI/M73cdkjcTma8sr9lboc
 NhmiGOQCcxoG1YgT2zDZKiFWB+gXSR31Qj9664TjHlBsnQH/ypLXQEUVvvtv8J6kqmy7njOY2
 mHEiG5nywQg1GTlrfqVNIZ4+NtoYiapJKnWHASs+vcQ/C1Fjr8072IUcRA3q3wGGlMTTIBNu3
 5cMtCW5rX5BNbVV22DRiC5Ej/2o5H9j0ONfj6+8SROIYQDSuzuBi2SMp/Fh+3VrNI7x7V0L5U
 vOBtw4/OLHvzDEKSH40pYQCItF2ZPrxSAN93PzcCwA0AWwIfHqk919yFuK7WdGZbzbQIWz/Px
 9AtxT4Supp1k6rr7eYnbaSDSzG6QZZqj5WjVyhOg2l7Z8duCmzwrwpPwLK1Ab6M5AsmdaPyra
 o8eDkwmYENqB0hDu7bd+V274kHSNi1TqPHOmxFnwwXBKVCk1R+uwLrno7pJJJUCVZfgh1vGdB
 9CZNZBNbbtDS+Vkz1bnsGMK71xor2a0eG+gLS9P2zvR2jq90Tocr5c4ulsn/VeFTnRh1D0ZZx
 RNJiKish+PhFGze8yEgQpcDGf3AoQNubfaiYEWby6Fcm6AG0is1/yDKQh8kKKfa0G5nTKB7g5
 PdWO/c3dfLYqUvA0m/ZFl3ShpL+fe880bGOxJmmTkRHUQoOYHH9IsRUm6C1JEjr03dKi365Am
 n/gKFSJS5e91lUIJPiVofO7+cEQm6JG6V7S6DxRq3XGmhYR1OfOJHjBE13QINkXX/KZ39r5vg
 THdrerspw+59R6G1IAGm2knRlnAUZH6iZ+RtTUTzZsFsApSKsIZ1RS/+CYphIwCUXIsAYIOLi
 HfaP5yUvZIYC5sGQYOVVEeufEjqhJgpELGgeV5uf3ydArbO+DgeKYe7v89JHxaAAfcRYO6uVo
 ZAXYABc1A7MfsKgCYGEY9T22x0FgxXb1AZNZM7jv/N7gJmtr7bSoYuERUvB/xpg/Rhww0vcZz
 1jaAP7U8vVFyCRvvtjPZOaGzfOy4SW9WvU5WAxZVq8aIo/sSdDtvWIs6fMcz2IR2dDj0eROgm
 eFFuV2GogkEMq9wu7zVu1YDO4CvoY9vjnuabMHctsd/SrbGWa

=E2=80=A6
> Prevent null pointer dereference in mt7915_mmio_wed_init().

Can any other summary phrase variant become more desirable accordingly?


=E2=80=A6
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
=E2=80=A6
> @@ -678,6 +681,9 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, voi=
d *pdev_ptr,
>  		wed->wlan.bus_type =3D MTK_WED_BUS_AXI;
>  		wed->wlan.base =3D devm_ioremap(dev->mt76.dev, res->start,
>  					      resource_size(res));
> +		if (!wed->wlan.base)
> +			return -ENOMEM;
> +
=E2=80=A6

Would the function =E2=80=9Cdevm_platform_get_and_ioremap_resource=E2=80=
=9D be applicable
in this else branch?
https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/base/platform.c#=
L87

Regards,
Markus


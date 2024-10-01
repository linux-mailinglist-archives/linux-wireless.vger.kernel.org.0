Return-Path: <linux-wireless+bounces-13385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34DF98C5CE
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 21:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4721F22FB0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30941CCB5B;
	Tue,  1 Oct 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="olDNwP65"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453601CC171;
	Tue,  1 Oct 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809738; cv=none; b=Fwrwn3DeblI67CT5trkmBV0opmD2zX2NRVDnYxg6qyG8DOoji+wzm7Uy4yTR6B86PnbTLIndX19T2SlXAOu0xUisGpk5hfEAYygOHbT6f/dPdRHpWyGex/OMbDvRlalxe0ybiN6n2XTGI+6bblVPRtHSXJrGsdn6AzAL2ZRoyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809738; c=relaxed/simple;
	bh=dB4On//ws+f9uBfpQgVACgt7KNNwxeozsBW/1z57Nv4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mApaIc7UwhDRmMqHhcq/P5JUMwyy2saT6OyUioDuQtehI1P1O3jeBwtBxvWDvLn6VU2tb7jFCPJtYB7GKPEusd7h71XEPgbcK8VVGDeL1/LrG5C1OLJ6HkvD9XTnEnKRQgQX94dyKXMYHFaLUZrsH9Un/BdABhbc45lurBp9vFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=olDNwP65; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727809709; x=1728414509; i=markus.elfring@web.de;
	bh=ZT6HLXkmgq+nzP9SCRx/NsEmzXMd1CrD2QiOlaZlfZ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=olDNwP65/FZusddYbtaUBU0+8MUuW6O7d7khSOq2B90rT6LAYS6ZB1BWWXG+UMwa
	 Q91hZAVBTHUHq9UkVXQ74K4fGeuD5vaZ5/HZeEPJJBhrf+9iNAyb8M2sSdzspwrQL
	 Pj4sulk/ktfvfQYCzSb8FlgNkJIdxtsf/1EjmqrM+ks9epoyWzw216Ue4GpgB4ThT
	 UW3NfSqLzvl2jzW0/aKrfnX8vucJGzYRJQtsHrBIHatrYdPO6jnRd2ul5EOJl5nEM
	 1Bivs9OQnBj/i0z/aW8YUnJJWP6bbnE1mgj0+yAw5inKMm8WPITUkZ11y62FDJPid
	 NMT4GNYnMk6Ms9LywQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvspv-1s4iVO33Fn-00rHBS; Tue, 01
 Oct 2024 21:08:29 +0200
Message-ID: <7966ab38-711a-4c46-b3c8-ac8ce34b2949@web.de>
Date: Tue, 1 Oct 2024 21:08:12 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <b9d8fbfc19360bfe60b9cea1cb0f735ab3b4bc26.1727639596.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] wifi: mt76: mt7915: Fix an error handling path in
 mt7915_add_interface()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b9d8fbfc19360bfe60b9cea1cb0f735ab3b4bc26.1727639596.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kRjPILfqORU/QkD6eWvK+eGlmHGidSKMW4n6WRbwxP2AD2MR8iO
 qpj2u2/8ejEcSS5yVoMaskLs4AQ8RyMALHmxbAuS27m9AUcp26kjlw1YO3GWF5AlDWAwuzh
 HBP9YkpG85If3uMzljPcFs3QrZ4StYsGwjpPaiOmtIu5qcZFMzaoUfbBX9VfnlPkV0uJl+I
 BssmxKUFm2OwBOaJYDZNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e62IPgDwXCE=;Pum2sJBK9wwiOEgW3Kak8Cmjhv8
 vqTcy8otb+EI4UDJDOOY/jefVnoCxRO7izxHBx11aE9UI1iijpfBEOfyYuYWj6h025vsB6NoU
 NRFitCZpUYNNN+Yj8ViTI3NR4+skseZsyTnij7wkwRADOeAvWmfgGscjmWf8IzGljAvBpBqUw
 fOuVxolq1QQmIYusFll/TGSpcpPhKSy/EuWmYwNjfGYnQvQk8Bhf6KJOLjLB6FHzuBCVlnccG
 gtvd3iL9oyu978Kxy+K070YflRuTeMZqMj2TRKwt7JlrSuRgJSlpHVZkbkc67Cw5tzu2IKs0z
 wFAm0gvarTsDNxGAFhk08GeVrKBa4Hr8505iCl+FL7uN8rUuXS/WbmjPd6/DQFzZTDhs2J+Pw
 iC3TNRTDvy675/abOOa/fuaWDcVZtTU6LyDXWuHM58NzTn4kc2Bx7jzh0i2M7Cf2xK+ws0Uem
 doZSyuCntUuodte6uF/mbYdg8NEROANMGJgAp+jk1xrt4KxXAuOv1S7FXEQyet6cm6aIGVsgq
 dzAat2B3QXOM1oLFcrkrUcBfbr3zUmwDUfbiZhPd2KrI0GCDjHZgiLrn59d1FCVbE5A4/PKOM
 ibxoMLks3vMyEvY4NDSEm89PO+W6pVTwsYpN3PdMiZBfGAJ8iRENflyuViZ2/gCwxjbhUoTvU
 59mouZe62VNf795O6Y8Gs+b6SQDV4Tg3vBetvztXNa9YqAVv8yrM++PUwOJoxEtW6/OihM2jn
 1fvRQQVQbLwRfOLxm8IJkyArE3xyX6roK9tiEVEXoNh3W0NE57xjJwQ1LoSX8ur5tsjH8pzT5
 /HDbJfbtqz0YZzP7Fj+Udmdg==

> If mt76_wcid_alloc() fails, the "mt76.mutex" mutex needs to be released =
as
> done in the other error handling path of mt7915_add_interface().

                                   paths?


=E2=80=A6
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -246,8 +246,10 @@ static int mt7915_add_interface(struct ieee80211_hw=
 *hw,
>  	phy->omac_mask |=3D BIT_ULL(mvif->mt76.omac_idx);
>
>  	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, mt7915_wtbl_size(dev));
> -	if (idx < 0)
> -		return -ENOSPC;
> +	if (idx < 0) {
> +		ret =3D -ENOSPC;
> +		goto out;
> +	}
=E2=80=A6

Would you dare to support another jump target for this assignment statemen=
t?

Regards,
Markus


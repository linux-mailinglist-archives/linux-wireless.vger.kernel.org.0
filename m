Return-Path: <linux-wireless+bounces-20701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC992A6CB1A
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 16:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F878A561F
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81971DBB2E;
	Sat, 22 Mar 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="V/yAGRGD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41BEB640;
	Sat, 22 Mar 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742655383; cv=none; b=QB6vjXxcSn3GCxocinGqUS8WrsS5ldCs+1qvGDq3g9dfFhTY+72d12QUyoxShWdJYwzfqtLq87rr5yOOaiM79y9BOSUcEgq/NbrRzFw+PMf3f0pwvuRabTAqu28GuV6IH0BroejCGFwI3Ed3Q7qeFH+79F8Oi1rUNJTkt0iSrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742655383; c=relaxed/simple;
	bh=DqbaqiAFjI32cAkVWe/Rd7LM7v2AnsiJh+5WJN5GkCc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=j3TxjNXWFTK7akWdVUJJVFyB5sXc0d71IAEobuOrXuRGAK8B9gGpCt3qRuMWf5aIht8a0mTQYL/zFHmT1Sgcxy18Z/ZPhoypWQTEkk1GZfJe51wupS0qy5AsEow98WDG8jd4tnqnSjr+tM07pIR6or0fAEkAxSrVNbo3Pv/0kdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=V/yAGRGD; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742655351; x=1743260151; i=markus.elfring@web.de;
	bh=KR1XGA5UlrZYB/EE75mcNea8LxdNsuvuyP1JLzY93YI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V/yAGRGDhlKct8VpACB6OwOKrXpExfRBs1IQg81eh5OKGLSyvTZzGq/Tjmjmm/xc
	 aSWwUUFw+g+lJxV2SOEaCKL/ee5egi5HRmGkkzfxH8t5MLuO1qhXY7mtzcwvZczs3
	 kiC1+n3qvhdXykumd1NPIx+7esq4idCz85Dw0PNBXrUuFBHlYIuuqBcRX1Wj2gvrn
	 aQQ/AiW+hJeyXmXcwHqMZfTZD28SNGVUGL1etrS39k26TxnUkvqJ/MiFL+GDZ5+Mf
	 Dp/YG+j/wWpSL/q11JgR4ayuNm40iIm7niFBepqv2k1WVnQABRuHTGvoXAN2pNUZJ
	 /O4bK9eRevpv9iwZJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.73]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1tutnf1ug0-001Qbn; Sat, 22
 Mar 2025 15:55:51 +0100
Message-ID: <d1df5d97-4691-40d4-a6cc-416505f35164@web.de>
Date: Sat, 22 Mar 2025 15:55:49 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qasim Ijaz <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bo Jiao <bo.jiao@mediatek.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes@sipsolutions.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
References: <20250322141910.4461-1-qasdev00@gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid potential null deref in
 mt7996_get_et_stats()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250322141910.4461-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zGgYsMVFMC7gMzLMJMEaOqOzG4KCvD6WdUj5Wr+OkPGAGJatYKZ
 MSyQ3MBAtAciAngF+P2u2paZGglBI3KYJ+Ca7K0VGJCaenqIS9f7Pq7uklBPKxLD1faeh/7
 3RB8qof/kEEvhVQQ/qetSRlrb1Chy9ljJPPLTtnXRoY5ywmKwgwqgVRKN7zyYDPXGy/lZTy
 LI1yB6/ZhSRvt/TSPSPrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6WNxdDY6Ngo=;rgvjXtJMAoHIrEJ2fRmFicKctqo
 nr6njC9l6NX9BsJ/sLJZrR5aB+TGnQsy33Dpy+HDmswmS9/DQ7h/3I7sZTx8LWwQgUBuj53pO
 VzEQeUBFjZREWcp0fJF3QaXVpVHTc4zJ1jNBWN3M4gk1Dav9VekVaBg7GH3gfEIogNUCVdFXm
 jOnhm7OGz7YEAHUSK01/OyQNQoZP/wkXJbWp7KMD98Wuxj1TcP66IiUYBYHUcXGzOBUhTfWpB
 AvN+AKBtg5t6piGCQyJ9M2EZTDo+HAGdi1qOlOUuHLY89NZTOwhSJTWYT1JWqRr7v7QkjZMSs
 dWV3IKlO1yFyIHakpjfySgmxuA6dzICdLpearWp9PcmWYiVdbEN5dfSMVtLzW6Zyr4x6Ls9NV
 B7+ZT3/ehv942+YzTfN0mEIdYeTcEjZhVpAqmkDJ2Kj2NNyf92TgxU+x6VONSP+Uk/sIp/g0v
 NKkCBz/DO4wQjCoSdxt6/jjCD9GCrIsBzcg7KRlcVpS2GHIo21exhqw1cDKyNQatzSe7iZa6y
 CakUlSj0RwPGglZi289WqjrYFMm7bvP7kZ+3cnU7W4TG0cs3TSIIkjzEBpIPKmfq+nCamOOy5
 kCHBi3+NqXEsPpCAnVMSS7qmgKBJtA7CcRUuhvZmhoEYDzCJgL1xSMlcwoHafdb0wJHKLOm0+
 BJ4pydgUfAPzf50FttZozx7KccXgyXpk+1Dv7Fos0hAb861itqtRputaLB0ZdH1hTscJeS49Y
 5rpL50plO0m1GE8VCu7A6zWH/pPD+slwfU+GP5Vc/hS8j7KB8k8+/s+Iu9RUhygrGEkF4tPje
 oqbtKuk0u3SELsGRzE2w1gxDk9rta3v7gt0iski9TC+ErkGM6yDxl6sKrQ1hHbFGShuxRBOWb
 IO8RlyR6Hoyq7LKLvpQrA8SMtlnryUTabxZwM1LoiVCgciWFfc7mbGwnBXR1fFi27ikAaQfl4
 W8y0p8pekQT4j+Rn93WAl+hDLn4c0TiRBsKwaITXW9yuScr0TX8uDy6PaebH401hwVykxM9Qw
 kbSy50jOBFWLfViZ6/r0o+1ENqKIsBfO/kV3OOLlKuOaTpXnCKfBFWn0/MxaCUYqutxZQU+rG
 c4uExsZKQB2am4TdfOKrowgLP01ergXdIR46T7y7w0JZhwdLHb+b2Rux8LB7f1UppfIWVX76g
 duCUcnJUOV1LsPw3xRYkjbCMdIHVsQszN3wZUSQDSA9NrdpcAyXid+gzgPL/L5ABNSL7B37DL
 rQZ862j/QbZPkHs61XwT/RkeTlwT7ETjmqkHazRYrzYMfrF/jPdEaAGLuZWB0BTD6UzNNH4Zb
 ySHc35e3RhtlDbs7B9pG4AV1olV6yDCJDGCXz615i7YV2a+Zr/wnghstWGMbQ4q2QOf8XgJku
 M4ofFROuDhs/3FhtF6gRsdsv9LkIY/pVFa6W2qxKxbkUQ7DaPYjWsjTV0kZUn4FzdY2YvQXfT
 ETgyk8K8863+6+jtF5E433JlDT0di3gWbk0AwWcsHE7S4PN0l

> Ensure phy->mib is only accessed after the null sanity check for phy
> otherwise the code may trigger a potential null deref.

* Would you like to use the term =E2=80=9Cnull pointer dereference=E2=80=
=9D consistently?

* Were any known source code analysis tools involved also for
  this software improvement?


=E2=80=A6
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
=E2=80=A6
> @@ -1886,6 +1886,8 @@ void mt7996_get_et_stats(struct ieee80211_hw *hw,
>  	if (!phy)
>  		return;
>
> +	mib =3D &phy->mib;
> +
>  	mutex_lock(&dev->mt76.mutex);
>
>  	mt7996_mac_update_stats(phy);

I suggest to move such an assignment statement directly before the place
where this variable is used finally.

Regards,
Markus


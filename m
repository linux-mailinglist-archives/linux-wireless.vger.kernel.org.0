Return-Path: <linux-wireless+bounces-3039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F18471AD
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 15:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97372286BA4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCB144608;
	Fri,  2 Feb 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Rsf/IvEP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70271420CB;
	Fri,  2 Feb 2024 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883202; cv=none; b=OEXaUiUJtPsHdu0QARE8X0AShaaNT8dQbE2LTv9IlmxKOSEuDogtL9912YS2DWzDkrxUsqxGvOLJo+dR5qWEzi34wtTZk7WfafkZI/g03KKmlLqlaeZr8EQcrD1iheDLs6LH2i/l8VoueuCcz6djJKx4MyHCz+HVlZrzrj3GhJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883202; c=relaxed/simple;
	bh=S3LedQhBgmTD6R5eN9UjImGBjiKSpLehAWdPt+u/N+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otmdP3sPwX37fy18s145RaihR+nX4E2Zt892T6v0mW6mlqVZ38zefuexEhHCCky7+ajhjXPXHbPaTsOo7tOgbk2IToB7NaOqo64DBo9wD1x/bXj6NSvabEyn9rVr/c7zrZns/jLDtTj/02FEYVAZ1PQYI6PjWQueQzNSMY+7fuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=Rsf/IvEP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706883187; x=1707487987; i=fiona.klute@gmx.de;
	bh=S3LedQhBgmTD6R5eN9UjImGBjiKSpLehAWdPt+u/N+w=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Rsf/IvEP3BI1GfPRaJZuooHHZllX1sJEt68Q/ZI+R+BpmMmfIc//RsuPIo0Xfq4g
	 zVZAPYEspCRxyq5mVaj5BsmWpIUtqYlAox0ndmg6GbwH612Lou7xnFYaKk104fKwe
	 S+mYydd9sHI0zNXbGqsnGI7yKkw0NQU6Jr8XmEpfkUh17y3/ttaGdhTS3nEgMY+1k
	 1gEo7bL/D4Z8wKX1Zc49s/j3elPcyN2/9fKrrxNdHbLt4URB2YbiKpWLBMFOjIjzm
	 XtlVrAKMZxwWCUj688DUBhocewvfZwlnJdwUkNTM8F4Vp3nI4bZXxOzBQ4zRSuPM0
	 z2X0D/tuCRvCPUPLxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.17.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Ux-1rAVsn3NIp-00wGQ7; Fri, 02
 Feb 2024 15:13:06 +0100
Message-ID: <abafac2e-2fc2-44bb-815e-a4aa165f979e@gmx.de>
Date: Fri, 2 Feb 2024 15:13:05 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Content-Language: de-DE, en-US
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
 =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <0a5c896a-6dab-4979-a6a3-344dc71bca98@yandex.ru>
 <b8c1a26e-13d9-405a-bbd5-70a7daf75323@gmx.de>
 <75c29fb8-587e-4b8d-98cc-80c8bdea99a0@yandex.ru>
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <75c29fb8-587e-4b8d-98cc-80c8bdea99a0@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QehIvh6qvrkn2GJn5RC1vr/zjt/8rKGeYIP9Ens5QEJQh3EoSKQ
 NesC0gDt7T8BPhyUoHXPwGBuzyZ8PuLCw04mghiQFdcoQU7C++MFOpuub6dRWlG6ZV0ihNS
 R7/3yugaTagaD/YAXO+hUSo5A/2h6srEyd8RJioZFzb6ONNkz0+afDKVZVq2aj4JCTl+8MS
 4H0yhVE2Zz5zFoyLXP/WQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2uTfB4zJWhI=;mBUZK3p/0pKrSKQQI+dOFd9sVqt
 TkGAN9Ody1SJ9lQee21fvcSKvJazWiNtn/467tijEeUdCLqFtX92qB8TliRyWW9dnLtoph3RO
 OBc7B8aRfDXoWNibxEWGiDAOqgn8/R1sygZTcXuEnhvSYLRKtNBoDKcD642xHvBbCjwqR2Rx0
 d2Pq2mzax6/dkXzEVRKRA0H4lxy2dYbeaXTsz8k3KY985YKU3Z/dyjZ2IM3E6z1iSXthtLhEi
 ojL1i4mxOooJQYv2EgmXkIKy0Jo4joH+WRE+cTNV/xboOENMZAS+0RxZqE5zXSNprVPlLcTGi
 Ni0J3S1WFfnABPtrXvV2+MXa0Bdqqa3JUP7h0KBAenYyziIEbdAa0OWR4q4YwJcHOI6r9CHUy
 uxF/ly9gyF8i0mI+8ThF6Zyl1ObGV4sVtWzZnfjpD82nXr4k0PV+BRF62YwRZYaBCDxtheZX6
 eskOWp99ivzsRpVQ6s0V7mq53SqXWHa7Oly7tCZLpzJdf8cFyoGD7BY0+FyfNKqryj6De9iIj
 Nj1vG8tsBJlCBSyxsgN54+w2Us7QMEhxVW0aCT1Ff0N4vHCKXipsnS4/WCo6vDfnz8LBn6bGR
 n+RTB1gFjeCTUr754QamL0P9eqkkayfhTBMb6mth0JPJhF9DjHIMHTxXaJcUoO3xGt1IU/tgm
 7gUYyRjmIhEvIrAxLussozg5PXqwyKhzDAr1/VSGGfN6Z6qFm81efB8Q5EZkq1r294I/PrOFc
 ol5T3iwUQ5m6WmbziwaF4HGB4ly81A8vpE6uvIi0TJaDQA4x0pFXtqljbuPhYinvYn+9bUaEN
 6BDS65L2UZ0TnTpnC3AKS2QgPQVlIMw2Wkl2rWxSTiogI=

Am 02.02.24 um 14:54 schrieb Dmitry Antipov:
> The only minor issue actually is:
>
> drivers/net/wireless/realtek/rtw88/rtw8723x.c:314:6: warning: no previou=
s
> prototype for function '__rtw8723x_cfg_ldo25' [-Wmissing-prototypes]
>  =C2=A0 314 | void __rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool ena=
ble)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> drivers/net/wireless/realtek/rtw88/rtw8723x.c:314:1: note: declare 'stat=
ic'
> if the function is not intended to be used outside of this translation u=
nit
>  =C2=A0 314 | void __rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool ena=
ble)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | static

Looks like I forgot a static there, will fix that in the next version.
Thank you!

Fiona



Return-Path: <linux-wireless+bounces-13565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3319918D7
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 19:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A53F1C21018
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E73B158D8D;
	Sat,  5 Oct 2024 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="phm8hgJF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8021E489;
	Sat,  5 Oct 2024 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728149384; cv=none; b=GFuVN7dPmOygHUvgzPRcFlPDM6b68arx6nz8ghZiQHZdjxPEtYfMIO96Vxt7jehkuLuMgMlzrXVdYcrJ2bOmhk8eq4/7Nr6byMe3V4dABgXkw2Zb+jECxAevbM8AMJvzxkdWC2AouQtuS04HYYMpXNLmlRt4yeePrESbAG50+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728149384; c=relaxed/simple;
	bh=SG78JVSZrVVi0aRTYOUGA6YP6pYSYVqMrxGPes30xpQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ad86sOAQopcIgh8jLyPca51wntgiiBWTD6jyCmtUkS03HscR/lZ425W2Iz8PTvzZwgTqpfPKHgqhNHqUojfOrmVxJMecvS+1eKTbMnuO05MKAu0Esb7CHQqYQaHiFi5MG0hQ+quKSJeV5VOicJalH5rIEC5QNNQ4VN0KuCeWHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=phm8hgJF; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728149341; x=1728754141; i=markus.elfring@web.de;
	bh=IzK6cJufE3pWKTKByaz9D2Qk/DgyH9a+hucudwqyqr8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=phm8hgJFMp8oP6lu2lyjqQGLlmQ9nnyCb/Cexh9aP8pCWWjfofS3avHJBtcpTErw
	 0S5Ta5ZQAEc2rXPWqIqZHXpQHm4+JPd0ZTysb3EJRC4xP6r6wztO09DzlwvyYfBew
	 u0qEAEcc1RVhWmrngO3XHL/8ibTu2u3bNtUf6h4hdCrpr2XzHxJawy7RwSzhZnq1e
	 bFKwNwq8mmQZObxmAEzpKUmqG95IdRixzzVVqBFeoncTZkhrq1EWrYswlZEXcDaN6
	 QZ6fnaWOU6E0xj1Sqz/q04/La7KHQFoPvI6a6wzbdz6G6fyE/oXDEzhZD1GFOLsPK
	 I7CM77VH5B5JVehdKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODiX-1tKyxQ2RfF-00Juwp; Sat, 05
 Oct 2024 19:29:01 +0200
Message-ID: <48c3da06-fe59-4902-a74f-a4f3e4488160@web.de>
Date: Sat, 5 Oct 2024 19:28:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zichen Xie <zichenxie0106@gmail.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 Aditya Kumar Singh <quic_adisi@quicinc.com>,
 =?UTF-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Benjamin Lin <benjamin-jw.lin@mediatek.com>, Bo Jiao <bo.jiao@mediatek.com>,
 Deren Wu <deren.wu@mediatek.com>,
 =?UTF-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= <Evelyn.Tsai@mediatek.com>,
 Felix Fietkau <nbd@nbd.name>, Howard Hsu <howard-yh.hsu@mediatek.com>,
 Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chenyuan Yang <chenyuan0y@gmail.com>, Zijie Zhao <zzjas98@gmail.com>
References: <20241003180959.12158-1-zichenxie0106@gmail.com>
Subject: Re: [PATCH v5] wifi: mt76: Fix NULL Dereference caused by
 mt76_connac_get_he_phy_cap()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241003180959.12158-1-zichenxie0106@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p37fQHMIknWRyQlsAViVRgAwfb9nMvPuyssNtSLNcobqn2Zs8aY
 zsl3Fz4df5zUsCxZ8E7pRZhVnLQ/9XBNZ7iV08HZqTYcNK+P5ytIm5ZOtjGR7X9exKWFg4U
 fbPOYUG19shEWPwBYBuC4z4+sBTXATXHH4hPhv6xCY1A+TJAt4eVtSMezAIy8IxKmAUV5w8
 u08SqUPgVhk4YKdr+5YcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PWBQM9q2YP4=;rjKb2BvBM8gCnwUjNvR/xB7u0/x
 BInGkKWRWtNxDBYWfXFrI6R8tw89wMRa0BSXoUBLwNUrror86ZhKNiVx9qeKB5iDbpsU7wuT3
 srjnsh1WIRl5pdBA5RnaawqXpeXiD+IrGGWl4BiENd+s3fL9sRtulohuO9kSIK6dAGMQ6rFWW
 u+2VFDQ58bM0R+wpoB5XjXQ2cBGmHUilgSFg0Uzm+vVkGrwnwvgunPwet8DdnWDvqZFbqW5qy
 1dbPPrYnNWvYjvK5X/XCfnQwjYKT3Dh2Va+cUb0QGE/TYazSwsXZuNRQR8jA9OqP//rBzv92K
 XJ9PyAFgTaqvA5/OipJDVYu5JOKd7qgGmQT14o34AwE5smKaht+N8e7QVSEnig3AGjvfKzLV8
 HH3ktd4Wt15TJ9n1ZeVVTUy2JCkSHVjQMUPz/FxVDIvRUb6MzZ4nvsWspGTen5EF30AWoxN60
 GwDkQ2ruH/Br3et7f8ESAFrVaByw5NIkOmTH54pjaErhaHghjVTs3GT7IexzP0b9KJc4F5uC4
 8sjFKmQv34pLvNKS9iQ8bUDIwdZpGmf3Hdm1+HSOVWgFUvLnLSuFSMDhmELOzX5q0DSLU1hIM
 DVg6KlvmER95V6lL4MIKNdy88FOfVhUV8gZ2S3yuG/a2jE/hgi5HIXo47uz+xkcw2Ay+a0jRT
 7WppKGSm52mnGrgIJXOwyyvIFuc9P+yn4NK89aBAdRDl3hPdNhCJaN5e2Ir+GmsRHtZGTszkq
 gHrUWkcd5TQ2VFi87oVp50jyFkOaVSeDqevEiAJVNdAnIp6xNOOd8RiuFiKuJgaqpLmj1dmjE
 HLcUm9OwIhnaTLq19yFtRUHTfQ0RADTXvwAcytynRFq5Y=

> mt76_connac_get_he_phy_cap() may return a NULL pointer,
> leading to NULL Pointer Dereference.
=E2=80=A6

             multiple questionable accesses?

How do you think about to use the term =E2=80=9Cnull pointer dereference=
=E2=80=9D
for the final commit message (including the summary phrase)?


Were any static source code analysis tools involved in the detection
of presented change possibilities?


=E2=80=A6
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 +++++
=E2=80=A6

Did you overlook to add patch version descriptions behind the marker line?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12-rc1#n723

Regards,
Markus


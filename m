Return-Path: <linux-wireless+bounces-12085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3245696146F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98DF283D51
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A09B1D049A;
	Tue, 27 Aug 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Vb5x8y1I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1501CFED9;
	Tue, 27 Aug 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776968; cv=none; b=eEWzNij8quVsnyA35XHdwczSG7y21/auK+HEmqOiMtRkAjYwtPynUygVLvdt5GrUqvDGL106C0/L30nlF+fFu3LNhD1F1MbXx8WHDj4gjrCuH4BjjxtC2TXovWfMnvimMhNKGYVeT8q0wptz9OCfajqJPs7I5hdNqpTPuZVi1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776968; c=relaxed/simple;
	bh=Jj2Oi0duJe2bHJPlHmEiXxPp7AdHFIUvtDymNXBNZBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jg8pVnUB1jFQO4YawIKB40zaetIpUs1LNoUikQp4S5L6yE+FouEPSGGVg5O31cJoCsbkR5gmN+wzvTB1eubTs4Zo/oyzzSCjAJPn4Or85OWeIVdLkaZ9ApuMP+LY5YXBkik/vO52uEEtZfcN3GRVXh7FGbRv0EKrUkfuUVYQl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Vb5x8y1I; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E59F2888C8;
	Tue, 27 Aug 2024 18:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724776965;
	bh=v9UgdaWGS04BSmIse3RKiwzHVfsA2BzZVmOCjBmyT48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vb5x8y1I6Qnu5mTLssyKJm399qGJ0RKpUKm7YhyiZ3r1O+G8nNjxpJuxSe/6c2vND
	 ++O1Ozb1DbuvC/MA7HBZ2Q2IWhfLX60yEnxqwzUQzpYAWOJLLI5Kbq7exEONkuJY/Q
	 s59zgFs37kBeyYlz67N458LJjNVQM0+J00pUfDqOfRiJmZyvWbunn7ixItjNjw1vFk
	 LQiYJcEG0s1a3kv/aXQT0HzYn8aJE6grZQmgedWxpquvhUShaEjYUT+oAY7g+nlLgA
	 WD7RwL9IXgtLWfqcZuNpvL2t+RoDsKi4FPbpoVn0vyjZtfzNDsUrRjgrBJiZ8dKkLv
	 5iH1c2u+j1Gpw==
Message-ID: <b8cf0639-7fe1-4225-9d95-ffd3caef595b@denx.de>
Date: Tue, 27 Aug 2024 18:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] wifi: wilc1000: Add WILC3000 support
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-4-marex@denx.de>
 <9217902b-7d1b-4d67-a148-a28484e8946e@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <9217902b-7d1b-4d67-a148-a28484e8946e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/27/24 10:28 AM, Alexis Lothoré wrote:

Hi,

>> @@ -1467,6 +1604,20 @@ static int init_chip(struct net_device *dev)
>>   		}
>>   	}
>>   
>> +	if (is_wilc3000(wilc->chipid)) {
>> +		ret = wilc->hif_func->hif_read_reg(wilc, 0x207ac, &reg);
> 
> Some defines would be nice here instead of hardcoded addresses. I have asked
> Ajay about those while working on wilc3000, the meaning is roughly the following:
> - 0x000207ac: WILC_3000_BOOTROM_STATUS_REGISTER
> - 0x004f0000: WILC_3000_CORTUS_BOOT_REGISTER_2
> - 0x71: WILC_CORTUS_BOOT_FROM_IRAM

Fixed in V3, thanks.


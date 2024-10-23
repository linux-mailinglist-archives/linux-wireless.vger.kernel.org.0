Return-Path: <linux-wireless+bounces-14416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C19ACDAD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B8928330B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77381FF03D;
	Wed, 23 Oct 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Dr82H/qv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EF1FF035;
	Wed, 23 Oct 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694714; cv=none; b=Tgg65DtoZazfr6hBosyhe1hXGH/PvDHZidCpJOEb9xOLt9zqpXeLjPY/5EIbIjGHHjumjur1bbTOKgg+2y10L+Xtuxl8vB8XZ3IMa7mixocMlcnLl8a11ElryS+GMNLavvbbUsIbSZDy7aKbs1ChdO30r7OrswLWZlAe3Sm7mgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694714; c=relaxed/simple;
	bh=gVRZmGDbSSe3eE9Wa/shHPOp5LGbVJEKYHUbkOttPNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV4HWD4iUtT7YnSoiZqXIjCDVSM3my3uj1wggCE722VZZcEDl03PyOQgr4g5pm3HLc5JeA0d592SX6NXFGxh72/DGthSRHNUR/Xazi5DPTxuYiY3OIE9kUWVRdEpyISuLszBd14qUSB4DiVKxPnmWbRpOupGzZLy9PDPoRI1XHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Dr82H/qv; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2FE0F8926F;
	Wed, 23 Oct 2024 16:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729694711;
	bh=gz9H38d2hsPWIqXhhStTpviHMUHd9U6Jhiq3f7k4l70=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dr82H/qvBgqrQ9fq456Rh+c8cmgK1VSc/0OPUhlC4Ch5k+SasRbJRKfZ9kYAqxuFo
	 +fknygzTdUyhJj5Zz8Z0XmIoSGCSUI1mM6wqvEY+xQI2GarF0ycfhKQMGYnIqqLa64
	 ybzZVhGV2ahsqkYDk8KIfhUUK1BM1fVe7HGtMymCzQZfrBuJx/bWtqHt3mwZphDU95
	 3F6SmHcY/S1qYXedvziK+zFFfyJt2maYGnjplA1rfStvLkNOdgHHf5hJ0GuQDdoJfh
	 Qg6e8VAKVNkY/u9my4jpu2d6SzBdA/UZRm8chKvKQMM0IS830C0/EULyzIJUnRilLU
	 znXKEs8xhX4fQ==
Message-ID: <3b2e85a2-5dd2-4368-9f94-422b7766297a@denx.de>
Date: Wed, 23 Oct 2024 16:26:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Rework bus locking
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241022013855.284783-1-marex@denx.de>
 <c9e98811-15f5-427a-82f7-2e7fff4a9873@bootlin.com>
 <8e28ba76-ecfa-49b6-89b5-1edabb22129d@denx.de>
 <71c93145-f7ed-485a-99f2-fab9529e6bcb@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <71c93145-f7ed-485a-99f2-fab9529e6bcb@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/23/24 9:54 AM, Alexis Lothoré wrote:

Hello Alexis,

>>                                   ksdioirqd() { // option 2
>>                                     claim_bus
>>                                     CMD52 0x0f, lets read SDIO_CCCR_INTx
>>                                     release_bus
>>                                   }
>>
>> That's what this patch implements, to avoid the interference.
>>
>> Maybe I should include the infographics? Or reword this somehow?
> 
> What I may have misunderstood is your first sentence ("sdio_claim_host() cannot
> be done per command, but has to be done per register/data IO which consists of
> multiple commands", especially command VS reg/data io), but your graph clarified
> it for me, thanks, so in the end we agree on this :) That may just be me having
> poorly interpreted, so no need to add the graphs to the commit

You're welcome. As long as we can understand each other with one extra 
round trip, all is good :)

> [...]
> 
>>>>    static int wilc_wlan_cfg_commit(struct wilc_vif *vif, int type,
>>>> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/
>>>> wireless/microchip/wilc1000/wlan.h
>>>> index b9e7f9222eadd..ade2db95e8a0f 100644
>>>> --- a/drivers/net/wireless/microchip/wilc1000/wlan.h
>>>> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
>>>> @@ -403,6 +403,8 @@ struct wilc_hif_func {
>>>>        void (*disable_interrupt)(struct wilc *nic);
>>>>        int (*hif_reset)(struct wilc *wilc);
>>>>        bool (*hif_is_init)(struct wilc *wilc);
>>>> +    void (*hif_claim)(struct wilc *wilc);
>>>> +    void (*hif_release)(struct wilc *wilc);
>>>
>>> So IIUC, your series push the hif_cs lock into each bus layer of the driver,
>>> remove any explicit call to bus-specific locking mechanism from those layers,
>>> and makes the upper layer control the locking. As mentioned above, I don't
>>> understand why those layers can not manage the bus-specific locking by
>>> themselves (which would be a big win for the upper layer).
>>
>> Because of acquire_bus()/release_bus() which I think is an attempt to serialize
>> bus access across multiple complex operations (=commands sent to the card), see
>> above.
> 
> Taking a further look at some examples in the driver, I see that indeed the
> "scope" of acquire_bus/release_bus is larger than simple bus operations. So I
> withdraw my proposal which was wrong.
All right.


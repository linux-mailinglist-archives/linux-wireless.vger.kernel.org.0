Return-Path: <linux-wireless+bounces-14370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24299AC0C1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 09:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDE9284EFD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF956155C8A;
	Wed, 23 Oct 2024 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cqHwpYAl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A350155742;
	Wed, 23 Oct 2024 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670054; cv=none; b=XbaeiNJ8d/oe4wY4QEZGtpgf7rjRvQHmAqMFearIbURwIDWwpZci00I1LLgpAl2ZvrDSE13rW2bWFjRT43ZCN4d9C2qL8DQHY6dfLua+iM4pMmwSePF4MqZfo4svxWFGP1BVabBkuxmz/VmjTcJmmjYpdnSFq8FFPiOCPr3ZxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670054; c=relaxed/simple;
	bh=HkNoZ5FCu3rF5J7aCvuNlnreJOKQyuHkkl7kviNxQik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMCWeq5dE/rHHgNxMWSfvCDOLtCE4OToJGbsboMraOXULJ8wyDrQVTbASjfzjfcIvJZOAI9Z1TRzseRnxol/7xVXXp2MUd6GB0JIm06TIZ8MZbEgozUpXsP55834v56beHBizf8FzbNpC6n86yRPlKBM2IoiUQ3AUO+fBmgrHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cqHwpYAl; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA4D5FF803;
	Wed, 23 Oct 2024 07:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729670049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdvS4VbW0v8hQ6mg/PNYWge1aqhZUl5W/f00dp8iRAc=;
	b=cqHwpYAluT7D6Tlq83Uamt7EsDHI32fcpyhgwQab56fp2y3T5qncv1UwZOrkJ9Iqb8QAcF
	uaNJnUEfLZQZwlcW7sP98e3suvfthQ7kfTFbhLsrPHluV+/79kuhYfWcnQzdE3X+AEiGKD
	IPGf+ewApaLcSH2tQWfuUJlvhnDrXVRV6wQuwV9vC4kACqSrTm44ln5WbDMfJ+T5CAnYPo
	Ji7/2a1TP3btJeC2xFQpysNmLOm3ZCO0X14uZPj70/MlsqHmfjVYDssV7A03baBOlHYwDD
	VnJ6R1yR4tvrAoFOZmzuYlmje8oFfoRiBGMA9vDz0AVgYJAB4wkk5UMg4mN88g==
Message-ID: <71c93145-f7ed-485a-99f2-fab9529e6bcb@bootlin.com>
Date: Wed, 23 Oct 2024 09:54:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Rework bus locking
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
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
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <8e28ba76-ecfa-49b6-89b5-1edabb22129d@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Marek,

On 10/22/24 15:19, Marek Vasut wrote:
> On 10/22/24 12:43 PM, Alexis Lothoré wrote:
>> Hi Marek,
> 
> Hi,
> 
>> On 10/22/24 03:38, Marek Vasut wrote:
>>> The bus locking in this driver is broken and produces subtle race
>>> condition with ksdioirqd and its mmc_claim_host()/mmc_release_host()
>>> usage in case of SDIO bus. Rework the locking to avoid this race
>>> condition.
>>>
>>> The problem is the hif_cs mutex used in acquire_bus()/release_bus(),
>>> which makes it look like calling acquire_bus() results in exclusive
>>> access to the bus, but that is not true for SDIO bus. For SDIO bus,
>>> to obtain exclusive access (any access, really), it is necessary to
>>> call sdio_claim_host(), which is a wrapper around mmc_claim_host(),
>>> which does its own locking. The acquire_bus() does not do that, but
>>> the SDIO interface implementation does call sdio_claim_host() and
>>> sdio_release_host() every single command, which is problematic. To
>>> make things worse, wilc_sdio_interrupt() implementation called from
>>> ksdioirqd first calls sdio_release_host(), then interrupt handling
>>> and finally sdio_claim_host().
>>>
>>> The core problem is that sdio_claim_host() cannot be done per command,
>>> but has to be done per register/data IO which consists of multiple
>>> commands.
>>
>> Is it really true ? What makes you say that we can not perform multiple
>> operations under the same exclusive sdio section ?
> 
> What I am trying to say is this:
> 
> With current code, this can happen, which is not good, because transfers from
> multiple threads can be interleaved and interfere with each other:
> 
> thread 1                         thread2
> do_some_higher_level_op() {
>  ...
>  read_register_0x3b0000() {
>   claim_bus
>   CMD52 0x00
>   release bus                    ksdioirqd() {
>                                    claim_bus
>                                    CMD52 0x0f, lets read SDIO_CCCR_INTx
>                                    release_bus
>   claim bus                      }
>   CMD52 0x00
>   release_bus
>   claim_bus
>   CMD52 0x3b
>   release_bus
>   claim_bus
>   CMD53 lets read data
>   release_bus
>  }
>  ...
> }
> 
> What should happen is either:
> 
> thread 1                         thread2
>                                  ksdioirqd() { // option 1
>                                    claim_bus
>                                    CMD52 0x0f, lets read SDIO_CCCR_INTx
>                                    release_bus
>                                  }
> do_some_higher_level_op() {
>  claim_bus
>  ...
>  read_register_0x3b0000 {
>   CMD52 0x00
>   CMD52 0x00
>   CMD52 0x3b
>   CMD53 lets read data
>  }
>  ...
>  read_another_register()
>  ...
>  release_bus
> }
>                                  ksdioirqd() { // option 2
>                                    claim_bus
>                                    CMD52 0x0f, lets read SDIO_CCCR_INTx
>                                    release_bus
>                                  }
> 
> That's what this patch implements, to avoid the interference.
> 
> Maybe I should include the infographics? Or reword this somehow?

What I may have misunderstood is your first sentence ("sdio_claim_host() cannot
be done per command, but has to be done per register/data IO which consists of
multiple commands", especially command VS reg/data io), but your graph clarified
it for me, thanks, so in the end we agree on this :) That may just be me having
poorly interpreted, so no need to add the graphs to the commit

[...]

>>>   static int wilc_wlan_cfg_commit(struct wilc_vif *vif, int type,
>>> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/
>>> wireless/microchip/wilc1000/wlan.h
>>> index b9e7f9222eadd..ade2db95e8a0f 100644
>>> --- a/drivers/net/wireless/microchip/wilc1000/wlan.h
>>> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
>>> @@ -403,6 +403,8 @@ struct wilc_hif_func {
>>>       void (*disable_interrupt)(struct wilc *nic);
>>>       int (*hif_reset)(struct wilc *wilc);
>>>       bool (*hif_is_init)(struct wilc *wilc);
>>> +    void (*hif_claim)(struct wilc *wilc);
>>> +    void (*hif_release)(struct wilc *wilc);
>>
>> So IIUC, your series push the hif_cs lock into each bus layer of the driver,
>> remove any explicit call to bus-specific locking mechanism from those layers,
>> and makes the upper layer control the locking. As mentioned above, I don't
>> understand why those layers can not manage the bus-specific locking by
>> themselves (which would be a big win for the upper layer).
> 
> Because of acquire_bus()/release_bus() which I think is an attempt to serialize
> bus access across multiple complex operations (=commands sent to the card), see
> above.

Taking a further look at some examples in the driver, I see that indeed the
"scope" of acquire_bus/release_bus is larger than simple bus operations. So I
withdraw my proposal which was wrong.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


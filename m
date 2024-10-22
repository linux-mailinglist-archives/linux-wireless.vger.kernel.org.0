Return-Path: <linux-wireless+bounces-14330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B139AB11C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918C31C2248C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639B1A0BCA;
	Tue, 22 Oct 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LNcgK+wC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485A199248;
	Tue, 22 Oct 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608267; cv=none; b=swmT3UuvfKfDy9wjUZCy9N1dCDmfyF/p82PzMdNK7eTT0i2qBSFAlYtbN5M973bxMaAzN+nujLR5CzNJ9lXrVvhfeDXWtCRYjzQvNs8+F1jsEOLnjSfrC6XaCtDfn3R0/SKD7x5QMQhDkCADdUZ1M+/PYaKtEYtsf2UOtziSpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608267; c=relaxed/simple;
	bh=H01wCGbfRo2lTAkb8lQwyJLxwAsK5zakum0gEVEOOc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfHjaa9fjUCgY7aqfykFGjQi1ZZ+KekYQIE8N+8sIXDpfmFOdiZwCgrme2bDBnUy8jUMSRqWGHtMRSMLoPCeICL6taHaBmpnquGub0UCbLDC0HxGyccp29tLFNh8MdyvCYguWCCxf670zI13alSdMkGQ6HCM+sv/KQS8HIXqmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LNcgK+wC; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3B21D88F8E;
	Tue, 22 Oct 2024 16:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729608263;
	bh=/B9DQ4xeYrB4bgLwglx64xgszV5g159ESZlVY/+Tl0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LNcgK+wC7r7aoBjBGQUoEcR6Pv78UspMk+rn2OVMcr84whnd6lkCFMsD04kQUW2sJ
	 pCTzewq/9ucAmfZoMwRUTryHNDo7+Mfjxcew9gpnv1D0w1jrd26n7Fiy//QGrFNf7C
	 dffUsat1EuQj5/r+bWXL2sk+xCTd4gY77K0M3VrJyg8OOJM2xBxHcTDGl6Qe/bYZx7
	 KpcApPEAM+Nrr+15rBxDFhn+UWZs57cKOMfOdo4l1w7AUqIJfVx2/zpzsd4zYliB9K
	 VVPowzbScHUBoDBG2uas26eK7IPkPb4kcRgMr3HzD63Mubu5PR0YiYVQuj7jaYkaBi
	 8kb4P+NP7UCQg==
Message-ID: <8e28ba76-ecfa-49b6-89b5-1edabb22129d@denx.de>
Date: Tue, 22 Oct 2024 15:19:19 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <c9e98811-15f5-427a-82f7-2e7fff4a9873@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/22/24 12:43 PM, Alexis Lothoré wrote:
> Hi Marek,

Hi,

> On 10/22/24 03:38, Marek Vasut wrote:
>> The bus locking in this driver is broken and produces subtle race
>> condition with ksdioirqd and its mmc_claim_host()/mmc_release_host()
>> usage in case of SDIO bus. Rework the locking to avoid this race
>> condition.
>>
>> The problem is the hif_cs mutex used in acquire_bus()/release_bus(),
>> which makes it look like calling acquire_bus() results in exclusive
>> access to the bus, but that is not true for SDIO bus. For SDIO bus,
>> to obtain exclusive access (any access, really), it is necessary to
>> call sdio_claim_host(), which is a wrapper around mmc_claim_host(),
>> which does its own locking. The acquire_bus() does not do that, but
>> the SDIO interface implementation does call sdio_claim_host() and
>> sdio_release_host() every single command, which is problematic. To
>> make things worse, wilc_sdio_interrupt() implementation called from
>> ksdioirqd first calls sdio_release_host(), then interrupt handling
>> and finally sdio_claim_host().
>>
>> The core problem is that sdio_claim_host() cannot be done per command,
>> but has to be done per register/data IO which consists of multiple
>> commands.
> 
> Is it really true ? What makes you say that we can not perform multiple
> operations under the same exclusive sdio section ?

What I am trying to say is this:

With current code, this can happen, which is not good, because transfers 
from multiple threads can be interleaved and interfere with each other:

thread 1                         thread2
do_some_higher_level_op() {
  ...
  read_register_0x3b0000() {
   claim_bus
   CMD52 0x00
   release bus                    ksdioirqd() {
                                    claim_bus
                                    CMD52 0x0f, lets read SDIO_CCCR_INTx
                                    release_bus
   claim bus                      }
   CMD52 0x00
   release_bus
   claim_bus
   CMD52 0x3b
   release_bus
   claim_bus
   CMD53 lets read data
   release_bus
  }
  ...
}

What should happen is either:

thread 1                         thread2
                                  ksdioirqd() { // option 1
                                    claim_bus
                                    CMD52 0x0f, lets read SDIO_CCCR_INTx
                                    release_bus
                                  }
do_some_higher_level_op() {
  claim_bus
  ...
  read_register_0x3b0000 {
   CMD52 0x00
   CMD52 0x00
   CMD52 0x3b
   CMD53 lets read data
  }
  ...
  read_another_register()
  ...
  release_bus
}
                                  ksdioirqd() { // option 2
                                    claim_bus
                                    CMD52 0x0f, lets read SDIO_CCCR_INTx
                                    release_bus
                                  }

That's what this patch implements, to avoid the interference.

Maybe I should include the infographics? Or reword this somehow?

> Usually the WILC register read/write consists of 3x CMD52
>> to push in CSA pointer address and 1x CMD53 to read/write data to that
>> address. Most other accesses are also composed of multiple commands.
>>
>> Currently, if ksdioirqd wakes up and attempts to read SDIO_CCCR_INTx
>> to get pending SDIO IRQs in sdio_get_pending_irqs(), it can easily
>> perform that transfer between two consecutive CMD52 which are pushing
>> in the CSA pointer address and possibly disrupt the WILC operation.
>> This is undesired behavior.
> 
> I agree about the observation, and then I disagree about the statement above on
> sdio_claim_host/sdio_release_host not meant to be used for multiple commands.

I think we have a misunderstanding here, see above.

> I see plenty of sdio wireless drivers performing multiple sdio operations under
> the same sdio exclusive bus access section, either explicitely in their code, or
> through a sdio dedicated helper (eg: sdio_enable_func, sdio_disable_func).
> 
> But more concerns below
>>
>> Rework the locking.
>>
>> Introduce new .hif_claim/.hif_release callbacks which implement bus
>> specific locking. Lock/unlock SDIO bus access using sdio_claim_host()
>> and sdio_release_host(), lock/unlock SPI bus access using the current
>> hif_cs mutex moved purely into the spi.c interface. Make acquire_bus()
>> and release_bus() call the .hif_claim/.hif_release() callbacks and do
>> not access the hif_cs mutex from there at all.
>>
>> Remove any SDIO bus locking used directly in commands and the broken
>> SDIO bus unlocking in wilc_sdio_interrupt(), this is no longer needed.
>> Fix up SDIO initialization code which newly needs sdio_claim_host()
>> and sdio_release_host(), since it cannot depend on the locking being
>> done per-command anymore.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> [...]
> 
>>   
>> -static void wilc_sdio_interrupt(struct sdio_func *func)
>> +static void wilc_sdio_claim(struct wilc *wilc)
>> +{
>> +	struct sdio_func *func = container_of(wilc->dev, struct sdio_func, dev);
>> +
>> +	sdio_claim_host(func);
>> +}
>> +
>> +static void wilc_sdio_release(struct wilc *wilc)
>>   {
>> +	struct sdio_func *func = container_of(wilc->dev, struct sdio_func, dev);
>> +
>>   	sdio_release_host(func);
>> +}
> 
> So with this series, we end up with some bus-specific operations needing some
> locking, but is now up to the upper layer to control this locking. This feels
> wrong.

It always was the upper layer (wlan.c) that attempted to do bus locking, 
except it was incomplete. The acquire_bus()/release_bus() primitives 
seems to be an attempt at serializing bus access across multiple 
operations (which really boils down to multiple SPI or SDIO commands).

The problem is, acquire_bus()/release_bus() does not really work, 
because it does not prevent e.g. ksdioirqd from inserting a command on 
the SDIO bus. SDIO (or really, mmc framework) has its own way of doing 
bus locking, that's the sdio_claim_host()/sdio_release_host(), SPI does 
have spi_bus_lock()/spi_bus_unlock() which I should use in V2.

Those sdio_claim_host()/sdio_release_host() and 
spi_bus_lock()/spi_bus_unlock() should be called in 
acquire_bus()/release_bus() to correctly serialize bus access across 
multiple operations. That will also eliminate the custom and not really 
functional hif_cs mutex.

> The driver has a dedicated sdio layer, so if we need some locking for
> sdio-specific operations, it should be handled autonomously by the sdio layer,
> right ?

Not quite, I don't think the intention was to let anything communicate 
with the WILC device within block "protected" by 
acquire_bus()/release_bus() pair. That's why I believe this is where bus 
lock and unlock should happen too.

> [...]
> 
>>   static int wilc_wlan_cfg_commit(struct wilc_vif *vif, int type,
>> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
>> index b9e7f9222eadd..ade2db95e8a0f 100644
>> --- a/drivers/net/wireless/microchip/wilc1000/wlan.h
>> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
>> @@ -403,6 +403,8 @@ struct wilc_hif_func {
>>   	void (*disable_interrupt)(struct wilc *nic);
>>   	int (*hif_reset)(struct wilc *wilc);
>>   	bool (*hif_is_init)(struct wilc *wilc);
>> +	void (*hif_claim)(struct wilc *wilc);
>> +	void (*hif_release)(struct wilc *wilc);
> 
> So IIUC, your series push the hif_cs lock into each bus layer of the driver,
> remove any explicit call to bus-specific locking mechanism from those layers,
> and makes the upper layer control the locking. As mentioned above, I don't
> understand why those layers can not manage the bus-specific locking by
> themselves (which would be a big win for the upper layer).

Because of acquire_bus()/release_bus() which I think is an attempt to 
serialize bus access across multiple complex operations (=commands sent 
to the card), see above.

> For SDIO specifically, I feel like letting the layer handle those claim/release
> would even allow to remove this hif_cs mutex (but we may still need a lock for
> SPI side)
> 
> But I may be missing something, so feel free to prove me wrong.
With spi_bus_lock()/unlock() we can actually dispose of the hif_cs mutex 
altogether.


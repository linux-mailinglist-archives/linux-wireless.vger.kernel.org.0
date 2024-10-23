Return-Path: <linux-wireless+bounces-14434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3D9AD46D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 21:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F80A2810E4
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 19:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8E11AA787;
	Wed, 23 Oct 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="iWrCsM8a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0B14A605;
	Wed, 23 Oct 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710160; cv=none; b=uLFnM0b2qVRVIcc/UyeW9xAlVz0RRGuhn8S/GLQfd/GX2l6q89FuXEmOMprawxwWfZ7XhKdv67ovpUuLMqVd2e3E4wXX5f/kKvslf8ZxZLqFTcOBno+6DHtvm/p3C3F7kP/YIEghZowhtRyxo9aTf7Q8hi8usbyUkT6Vl+U1Re8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710160; c=relaxed/simple;
	bh=WjsGLlz7l001+eNvXqf2NhAOBPidkAlE8/VrNMdnX38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipnMUdQX7Wxxgo3bhfxFXZVT6Jr4uJj3+WmborPa7y62N3ZD+O0KsBnF0JHDek5iX9EukzVwSK+4uofJcJWvuo3Y7iUmwOU2g9n+u4akp7tCDeVP2SIIf0+5x0cnhxMJ56IVuM7i1gCGKyO1Rj6NhfwIPtyaxDuSbAbRfQU7K5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=iWrCsM8a; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8A58689391;
	Wed, 23 Oct 2024 21:02:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729710156;
	bh=7Au3ojRpzYBmyEYqy+FrQV9Tx69RCJIAFRmeOWo/ZNM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iWrCsM8a6h3pT5Jzg5Dx+nioZHeuT27HiVr04m9T1fwbB6xJKLDCYLfXw47+UHJUG
	 sRsO3LTaBJWOXTTqeNmBmESjAL2WdwEDAd4/gZuRJXh4e5zDMmIBVO4yR82oHMddM9
	 PlTvW9DHxgWDMc9srkdl1ySJR6217T5AHtHOmuEJwK2MTR36BVZ5nfF5sFeWgLwO+A
	 KpqlCrelQTMgf7S0YbqfPoYJmZvk+6QK10HTrRrewTNTzjvm0P0LONlDYiHDYpc8q8
	 EVYYnH/iivIa8qMGNlDo1KTHFbMTXdOVO5Z76OQ9Yb9ulc3/axPQHVEgBO16LIwNVz
	 BomRJCwvKUcBw==
Message-ID: <9d20b408-72a4-49f0-aca6-108dfdd65f99@denx.de>
Date: Wed, 23 Oct 2024 20:47:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Rework bus locking
To: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com,
 linux-wireless@vger.kernel.org
Cc: davem@davemloft.net, adham.abozaeid@microchip.com,
 claudiu.beznea@tuxon.dev, conor+dt@kernel.org, edumazet@google.com,
 kuba@kernel.org, kvalo@kernel.org, krzk+dt@kernel.org, pabeni@redhat.com,
 robh@kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20241022013855.284783-1-marex@denx.de>
 <c9e98811-15f5-427a-82f7-2e7fff4a9873@bootlin.com>
 <8e28ba76-ecfa-49b6-89b5-1edabb22129d@denx.de>
 <a4c8c489-c6b9-4a38-84ab-f08409baccff@microchip.com>
 <5e2a5056-78ac-4be0-83ca-4aa55f524535@denx.de>
 <880baad9-be3d-41b2-bea3-620f915ca397@microchip.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <880baad9-be3d-41b2-bea3-620f915ca397@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/23/24 7:54 PM, Ajay.Kathat@microchip.com wrote:
> Hello Marek,

Hi,

>>>> What I am trying to say is this:
>>>>
>>>> With current code, this can happen, which is not good, because transfers
>>>> from multiple threads can be interleaved and interfere with each other:
>>>
>>> Did you observe any bus failure in your test setup with SDIO. Is there any
>>> configure to recreate it.
>>
>> I am observing sporadic command and data CRC errors on STM32MP157F
>> system with SDIO WILC3000.
> 
> Does this patch help to resolve the CRC errors?

No

> Do you observe the CRC errors during the bulk data transfer(iPerf) or does it
> even happen during the basic WiFi operation like(scan/connect or basic ping
> operation).

I can trigger them during this test:

$ while true ; ifconfig wlan0 up ; ifconfig wlan0 down ; done

But they happen sporadically and seemingly at random.

I already stuffed the driver with trace_printk()s through and through, 
but the trace log does not indicate anything that would be off in any way.

> Is power-save enabled during the test. With PS enabled, The SDIO commands may
> fail momentarily but it should recover.

It seems it gets enabled after first ifconfig up, that's a good hint, 
I'll try to disable it and see if that makes them errors go away. Thanks!

Do you have any details on WHY would such sporadic errors occur and how 
to make those go away even with PS enabled ?

>>> The SDIO transfer may appear to be split into into multiple transaction but
>>> these calls should not impact each other since most of them are updating the
>>> different registers except WILC_SDIO_FBR_CSA_REG register, which is used for
>>> CSA read/write. If needed, wilc_sdio_set_func0_csa_address() can be modified
>>> to club the 3x CMD52 and 1x CMD53 into a single transfer API.
>>>
>>> In my opinion, If sdio_claim_host() is moved to acquire_bus() API then the
>>> SDIO bus will be claimed longer than required especially in
>>> wilc_wlan_handle_txq() API. Ideally, calling sdio_claim_host() call just
>>> before the transfer is enough but now the SDIO I/O bus would be continuously
>>> blocked for multiple independent SDIO transactions that is not necessary.
>>
>> Why would that pose a problem ?
> 
> wilc_wlan_handle_txq() performs many operations on different registers which
> are not related. It will block the SDIO bux for longer. Otherwise those
> registers are allowed to update separately from the WILC SD side.

And is that blocking of SD bus actually a problem ?

>> I am more concerned that ksdioirqd can insert a command transfer right
>> in the middle of CMD52/CMD53 register read composite transfer, because
>> while ksdioirqd does use proper sdio_claim/release_host, this driver
>> does it per-SDIO-command instead of per the whole e.g. register read
>> "transaction".
>>
> 
> I think, using sdio_claim/release for each-SDIO command should suffice because
> the CMD52/CMD53 modify the specific registers that are unrelated. Each
> CMD52/53 should work properly and independently provided they are protected
> with sdio_claim/release.
> Additionally, there is no WILC SD module limitation requiring a strict order
> for CMD52/CMD53, except for Card Storage Area (CSA) read/write operations.

Can multiple register IO operations like that be interleaved with 
ksdioirqd access to SDIO_CCCR_INTx too ?

Take e.g. wilc_wlan_handle_txq(), is the following order legal?

thread1                                | thread2
ret = func->hif_write_reg(wilc,        |
            WILC_CORTUS_INTERRUPT_BASE, |
            1);                         |
                                        | ksdioirqd {
                                        | ret = mmc_io_rw_direct(card, 0,
                                        | 0, SDIO_CCCR_INTx, 0, pending);
                                        | }
ret = func->hif_read_reg(wilc,         |
            WILC_CORTUS_INTERRUPT_BASE, |
            &reg);                      |

> For CSA read/write operations, which are necessary to read/write any specific
> address from the card, multiple CMD52 commands are used to pass the desired
> address to be read/written using registers (0x10c, 0x10d, 0x10e). Then, CMD53
> is used to read/write to address 0x10f (CSA data window register). This
> complete command sequence is required for a single CSA address read/write.
> Based on this requirement, CSA read/write operations can cause issues if they
> run in parallel with another CSA read/write operation, but not with other
> CMD52 and CMD53 commands.

Unrelated to this, but ... is it possible to send the entire 3-Byte 
register CSA address using a single command instead of 3 separate commands ?

> Therefore, one approach to resolve this issue is to add sdio_claim/release
> around wilc_sdio_set_func0_csa_address(). This way, this function will be
> treated as a single operation and it will only modify the required command flow.

I can do the serialization per-command, but please see above.


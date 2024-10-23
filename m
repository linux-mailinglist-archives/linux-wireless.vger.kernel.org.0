Return-Path: <linux-wireless+bounces-14417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F10B9ACDB2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8A5B24D15
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B61FF61E;
	Wed, 23 Oct 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="iLF1D32t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685821FF03F;
	Wed, 23 Oct 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694716; cv=none; b=Nytt9TObUIF3WFC3Ya4ZwIbeewg/OXvyfF0193YIqTa+OC1/ZB0rTInIPD7pCJGSYtmimhBAkUwUH3RzYfz5s7K4YQmXqg8CJJePQtQUD/jFJv1zF3AeV53WMRqbra6iTAaprjFl7fs1CAVTg/508Mp2LjUBeu0DZPm9qXulDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694716; c=relaxed/simple;
	bh=6yfuYs9FDjhr1rsn439xikumOxfSQGSOzq5tsTvlqr8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A8mBiB8NODgYpZ7QLIO71orEtA6Zl8epn/w/t+nCXu8uVtr59WHLMAZk3FfEMxBqW6hPW9hajRKrdNRKUbM3h19z+q4lazDiNFfvUGf4pHHY3FZfboj3o9UYNwQ9mj1eIBhfDPxyVqpQqUWBNMSzX7YefZWaJAxH7Vxq3aUNGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=iLF1D32t; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BD46B892E7;
	Wed, 23 Oct 2024 16:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729694712;
	bh=iP7R+Xoa/cG1QNMF0ABrkiWzNuGFfXedNXUIzYy86UQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=iLF1D32tRqApL4xq7DAZ/A4kgyKIiriL2vrCzJ+Ka9HgnXrba4eI3PdYTZHgKVoyj
	 XLaJKheLFz980jschA2bqqOaBUsPugzun/RI1l4z1g1F56XdTeydT0ZdAzsZsNf9Ue
	 73lRd/GsarJVx9MMi/fF/woz/xBSsGHXj32O6y+TvUCSOyInTmfUnr30oveK9Gj1rJ
	 /8JCZxPRhfbObestW4RKrU2YXQgHDBGO0EfeBh7+32dlhL9Uv+F599/LMqwLrUjBkA
	 Agm53wM6ElTeNjlLMxcCYYMecgKudOtEh2whkdJUgnKZJLz7A562RnAyz2BQKJbt/T
	 /c7EtJ6wgA15w==
Message-ID: <5e2a5056-78ac-4be0-83ca-4aa55f524535@denx.de>
Date: Wed, 23 Oct 2024 16:44:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
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
Content-Language: en-US
In-Reply-To: <a4c8c489-c6b9-4a38-84ab-f08409baccff@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/23/24 9:17 AM, Ajay.Kathat@microchip.com wrote:

Hello Ajay,

>> What I am trying to say is this:
>>
>> With current code, this can happen, which is not good, because transfers
>> from multiple threads can be interleaved and interfere with each other:
> 
> Did you observe any bus failure in your test setup with SDIO. Is there any
> configure to recreate it.

I am observing sporadic command and data CRC errors on STM32MP157F 
system with SDIO WILC3000.

> The SDIO transfer may appear to be split into into multiple transaction but
> these calls should not impact each other since most of them are updating the
> different registers except WILC_SDIO_FBR_CSA_REG register, which is used for
> CSA read/write. If needed, wilc_sdio_set_func0_csa_address() can be modified
> to club the 3x CMD52 and 1x CMD53 into a single transfer API.
> 
> In my opinion, If sdio_claim_host() is moved to acquire_bus() API then the
> SDIO bus will be claimed longer than required especially in
> wilc_wlan_handle_txq() API. Ideally, calling sdio_claim_host() call just
> before the transfer is enough but now the SDIO I/O bus would be continuously
> blocked for multiple independent SDIO transactions that is not necessary.

Why would that pose a problem ?

I am more concerned that ksdioirqd can insert a command transfer right 
in the middle of CMD52/CMD53 register read composite transfer, because 
while ksdioirqd does use proper sdio_claim/release_host, this driver 
does it per-SDIO-command instead of per the whole e.g. register read 
"transaction".

[...]


Return-Path: <linux-wireless+bounces-12086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC28961472
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DE31C236A0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB161D0DC3;
	Tue, 27 Aug 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="chyUhqSa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB41CFEBF;
	Tue, 27 Aug 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776969; cv=none; b=FiBp2gU5BAF8Z1yRKN4UXg7umEZR9jVKV7oJJ7R6lQzLWKMDmmi1ZOHmR71Vbe/3jPcW7p7K3nU9PDY6kmsw1WxfSDpKD9p0EeV8HihYJT5o/S4b2O9BVfAPD6Oi2YjN7eXIVSLk/SUtnhboypNvXaUxJIte5Nk2YIvFnT3TLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776969; c=relaxed/simple;
	bh=HPy3ALIiO1wCS/D7rT7UzNZ5k1S/ejGlOuVDEfJ77AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c48sw0l+JMqXrQyqtaSVskGpXq5Z69+0XKiPuYAJtHs6+mihWdzHldFMjN3mBMPZaYNM+FRwT4OLgQLlcsGcUYLvzr0jzOEkjXe3R5gFPeIJ7lKTwXlzkiQvSKoOxX85j4GfL2WxoB1QaCPz2LtDzELjJ6afasN3w+Br7DVuT/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=chyUhqSa; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A9FA288800;
	Tue, 27 Aug 2024 18:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724776964;
	bh=2Pru0i9hS0n0Y7bDLs5WE3vUDIpbPXq0ksg4TfCIXS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=chyUhqSav3qnAJ0CeQix5SbGrAHL0/DED1297lUnGHNXZ3mvu2kUN3RCXohFVsO7M
	 nUaHvcxMeSGRh2edyBsTS3R0bI4qgmT6DDvjUv9QzgDj5WKSEtKR8lbjUD/eemaYj5
	 A04YvkcqPIJIMrznb00bRHv1VvqB34Lfro+JbJIn6hjWen85xz1r4aPBaLk5U28tdt
	 FkRtsYhpHG2lCcghKPLfPFirffXWNQGZLDwIFvH90pn3aG8TNNrTgjsmOm14VMqpKo
	 UMANvRG9NMjhrEhpU0g6BtOTaP2/aBTaZ23yUvfHuigtDORC/3LfdKVpFwk1BjTwUt
	 /gmemLo8n2vNQ==
Message-ID: <23f8f3c4-31c8-4971-b914-3b36fc0b446b@denx.de>
Date: Tue, 27 Aug 2024 18:23:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] wifi: wilc1000: Fold
 chip_allow_sleep()/chip_wakeup() into wlan.c
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
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-3-marex@denx.de>
 <9bc68261-9d5a-463c-82e8-c7a630dda79e@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <9bc68261-9d5a-463c-82e8-c7a630dda79e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/27/24 10:14 AM, Alexis Lothoré wrote:
> On 8/23/24 18:08, Marek Vasut wrote:
>> Neither chip_allow_sleep()/chip_wakeup() is used outside of wlan.c .
>> Make both functions static and remove both the exported symbol and
>> entries from wlan.h .
>>
>> Make chip_allow_sleep() return error code in preparation for the
>> follow up patches.
>>
>> Move acquire_bus() and release_bus() to avoid forward declaration
>> of chip_allow_sleep()/chip_wakeup().
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
>> Cc: Ajay Singh <ajay.kathat@microchip.com>
>> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
>> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Kalle Valo <kvalo@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-wireless@vger.kernel.org
>> Cc: netdev@vger.kernel.org
>> ---
>> V2: New patch
>> ---
>>   .../net/wireless/microchip/wilc1000/wlan.c    | 47 +++++++++----------
>>   .../net/wireless/microchip/wilc1000/wlan.h    |  2 -
>>   2 files changed, 23 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
>> index 1aab2f2dc159f..5fbba6876bd07 100644
>> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
>> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
>> @@ -12,20 +12,6 @@
>>   
>>   #define WAKE_UP_TRIAL_RETRY		10000
>>   
>> -static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
>> -{
>> -	mutex_lock(&wilc->hif_cs);
>> -	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP && wilc->power_save_mode)
>> -		chip_wakeup(wilc);
>> -}
>> -
>> -static inline void release_bus(struct wilc *wilc, enum bus_release release)
>> -{
>> -	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP && wilc->power_save_mode)
>> -		chip_allow_sleep(wilc);
>> -	mutex_unlock(&wilc->hif_cs);
>> -}
>> -
>>   static void wilc_wlan_txq_remove(struct wilc *wilc, u8 q_num,
>>   				 struct txq_entry_t *tqe)
>>   {
>> @@ -555,7 +541,7 @@ static struct rxq_entry_t *wilc_wlan_rxq_remove(struct wilc *wilc)
>>   	return rqe;
>>   }
>>   
>> -void chip_allow_sleep(struct wilc *wilc)
>> +static int chip_allow_sleep(struct wilc *wilc)
>>   {
>>   	u32 reg = 0;
>>   	const struct wilc_hif_func *hif_func = wilc->hif_func;
>> @@ -584,7 +570,7 @@ void chip_allow_sleep(struct wilc *wilc)
>>   	while (--trials) {
>>   		ret = hif_func->hif_read_reg(wilc, to_host_from_fw_reg, &reg);
>>   		if (ret)
>> -			return;
>> +			return ret;
> 
> Forwarding error codes sounds like a good idea, but neither this patch nor the
> next one is reading the return value from any chip_allow_sleep[XXX] function, so
> it does not bring much value.

I will add a follow up patch to this one which adds the error handling, 
since there is a lot of it to propagate the errors through. It will be 
in V3.


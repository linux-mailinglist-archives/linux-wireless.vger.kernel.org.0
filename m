Return-Path: <linux-wireless+bounces-21726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A4EA938D4
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 16:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E0A8E0AE1
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B32F24B28;
	Fri, 18 Apr 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgev91ZW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81128F49
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987585; cv=none; b=SdyIL28O/KGCXGrSAOKpyVoTKu43i73yiFt73uVnmd+KV+VKk2OqlSweySGxYE2rOqjRPpqDymffrbIypSS8oVvVVRQPE36fbJe01EE+JrAKMIryXd43lsjlsV9KvJ7wzttOWepdRP3sOiCLKVduEvnuqcI0KxA7FERnSZeylXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987585; c=relaxed/simple;
	bh=DMhxWlU4OUCT64/eWF5kEGSpBMSmZ2loQZ2iZGvC2Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNO6xDYGA1YPAZNDdCoXBVnXRiocQuJW2t6f/utPi8JHu2Y6RXGiQGlOQGiy5x4M1n7xTgMtRJMQrHjWWCyyNsWPWwuSsVYAVtK3uc5Mc6AZ3/LySf+fGmIA9tc/mrVSWWbgoT40NIK3IIVEcdsL24Ej0JLtO57Fo8LgtCxCrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgev91ZW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac29fd22163so301260466b.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744987582; x=1745592382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oN+g8Q0JmpLSwOwlE/+hUqby7PJnBXh92Hpt1hmqLgw=;
        b=hgev91ZWSeG2wkI14DRyWaEOoxEdj3GnmEAfXHitHC8/cpMhSFBWmU8AiON6swA/d/
         acYxwK+Pz56mtwqajVJaCJktiYhIMiQEUxQWVQL1UVaIP9Zhjwc+nTk5cQR+PpGMSKs0
         qPv9wcTbiVN0SAisG/lQkTV8OJqiO9nm5Bf08NhPb0k5J1qoY6SZcGei/li9W0noY6eh
         2+CmW39hXC7aA1um15MR35Q3ju1nDnxqsmO6O4svFE3/CMRIpDmcXpgSs3LeKnhDSoZz
         8/8lN9ENkJ6BRhx2P0K+apEH/+F84djFwQcvP5HAsFRMMA2VlDO//5FuC5colUjiAoHj
         D7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744987582; x=1745592382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oN+g8Q0JmpLSwOwlE/+hUqby7PJnBXh92Hpt1hmqLgw=;
        b=VnGfOtoIGT9aAILMs3Fa08In3nu4Bj9FX7Wz+TZ1eBELgrE7Au0pM7n++B3yJbP+k7
         zhdq+ZjRb6dYbtSzcsuxH1I/g1BFyfiHf59rMxi6cMVSfhf/b8ClQD3uCdAaGvRMH/32
         DVmztpUY9I2zjUStB+cg3v2BHJzpI45QqOmG1NeEsO8k2nbQuWytuAKoaZDvOs+KMaDs
         bD4o+DPQemcEfCqUFJABreFsC+1WxUPlfPlzol8NZCRou+oQ5HVE67H2o/dBXcOtWLv5
         dlYvi+MP3sbQXuwNQvfgK3g3yLYCM3EmqY64LiGkOxD9/3BEryx95QoPbS5LVufyzbzx
         DLBw==
X-Gm-Message-State: AOJu0YxabCWEnYSd7+7YP+PgofsEZJ3J+OmfzAqrGNd4UFaa7CIhGWbA
	qlephAqbyZ6YqIvhJWg7KlQMpt2oPpksmc9tJ7EUYWq7yTyz4ajvnPqblq0B
X-Gm-Gg: ASbGncuq8BVj2cFGEH8JTDEkp4fvL4GlE7L8ociJufzKaOdQEuu003HUxfEedFPAb7X
	D7d8+d4qU6DlQe9ppcK2eDnCjnoKcVDUl7p05H7E7iLuk+dXl7o6spO2QVHIVWmmevlZbbQvMmz
	eJVGiXIRmWIV8ZBlOPrvS7sBREZ6P+q5mreJKtfIqneU6HLuf0+RpInY1yYUZqbv/qfqNGbfcQO
	osjMlIfx63UuM49N8shxhJi+mI5R0ecelGjAaYaLfPHdKRUsbxbovGkolWDF9qbLwDEhUD+zEp4
	k2lstPGHk8gcgmqhgIQrUQxg/M0SdqrvNUssf5g12frEZis8yrNmHFLxYFqpsDMN36CKt4zCSCM
	658Z9Yt8QLbg=
X-Google-Smtp-Source: AGHT+IFPOgIPfQSUys9Zjop6u1uXhoG4M+NT7CaZdzcT2LJHhIk8BED9mVfX7xYP94HPR9x/FHbPSQ==
X-Received: by 2002:a17:906:7315:b0:ac7:d0fe:e9e4 with SMTP id a640c23a62f3a-acb74b2c99bmr284015166b.19.1744987581610;
        Fri, 18 Apr 2025 07:46:21 -0700 (PDT)
Received: from [192.168.1.73] (157-21-254-92.ftth.glasoperator.nl. [92.254.21.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef9e0ccsm125645966b.167.2025.04.18.07.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 07:46:21 -0700 (PDT)
Message-ID: <d9bd19df-c9fa-42f9-97be-f7da21fc2055@gmail.com>
Date: Fri, 18 Apr 2025 16:46:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH v2] wifi: mt76x2: Add support for LiteOn WN4516R
 and WN4519R
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
References: <aAJHqxIcw6J3yWoU@lore-desk>
 <20250418140631.31014-1-henk.vergonet@gmail.com> <aAJfM0vB1X8UgmAM@lore-desk>
Content-Language: en-US
From: Henk Vergonet <henk.vergonet@gmail.com>
In-Reply-To: <aAJfM0vB1X8UgmAM@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lorenzo!

I am getting a little better at this now :)
v3 is on the list.

Thank you for the support!

On 4/18/25 16:18, Lorenzo Bianconi wrote:
>> Ads support for:
>>   - LiteOn WN4516R
>>   - LiteOn WN4519R
>>   Both use:
>>   - A nonstandard USB connector
>>   - Mediatek chipset MT7600U
>>   - ASIC revision: 76320044
>>
>> Disabled VHT support on ASIC revision 76320044:
> Just a couple of nits inline. After fixing them please add my Acked-by
>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
>>   This fixes the 5G connectibity issue on LiteOn WN4519R module
>>   see https://github.com/openwrt/mt76/issues/971
>>
>>   And may also fix the 5G issues on the XBox One Wireless Adapter
>>   see https://github.com/openwrt/mt76/issues/200
>>
>>   I have looked at the FCC info related to the MT7632U chip as mentioned in here:
>>   https://github.com/openwrt/mt76/issues/459
>>   These confirm the chipset does not support 'ac' mode and hence VHT should be turned of.
>>
>> Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt76x2/usb.c      |  2 ++
>>   drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c | 12 +++++++++++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
>> index 84ef80ab4afb..96cecc576a98 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
>> @@ -17,6 +17,8 @@ static const struct usb_device_id mt76x2u_device_table[] = {
>>   	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
>>   	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
>>   	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
>> +	{ USB_DEVICE(0x0471, 0x2126) }, /* LiteOn WN4516R module, nonstandard USB connector */
>> +	{ USB_DEVICE(0x0471, 0x7600) }, /* LiteOn WN4519R module, nonstandard USB connector */
>>   	{ USB_DEVICE(0x2c4e, 0x0103) },	/* Mercury UD13 */
>>   	{ USB_DEVICE(0x0846, 0x9014) },	/* Netgear WNDA3100v3 */
>>   	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
>> index 33a14365ec9b..eb5e957f2f1b 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
>> @@ -191,6 +191,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
>>   {
>>   	struct ieee80211_hw *hw = mt76_hw(dev);
>>   	struct mt76_usb *usb = &dev->mt76.usb;
>> +	bool vht;
>>   	int err;
>>   
>>   	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
>> @@ -217,7 +218,16 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
>>   
>>   	/* check hw sg support in order to enable AMSDU */
>>   	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
>> -	err = mt76_register_device(&dev->mt76, true, mt76x02_rates,
>> +	switch (dev->mt76.rev) {
>> +		/* these ASIC revisions do not support VHT */
> please move this comment in the proper case.
>
>> +	case 0x76320044:
>> +		vht = false;
>> +		break;
>> +	default:
>> +		vht = true;
>> +		break;
>> +	}
> since you are reposting, can you please add a new-line here?
>
>> +	err = mt76_register_device(&dev->mt76, vht, mt76x02_rates,
>>   				   ARRAY_SIZE(mt76x02_rates));
>>   	if (err)
>>   		goto fail;
>> -- 
>> 2.45.2
>>


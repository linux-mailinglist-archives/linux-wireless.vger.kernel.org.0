Return-Path: <linux-wireless+bounces-11079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4010494A6C8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712EC281EC8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F01E3CA2;
	Wed,  7 Aug 2024 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dre6zxsn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F51E287F
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029472; cv=none; b=R68clXCPqkd8zp0+l3yuQm8ls1OmEHjVeN2ly5U7t7fCatffbZUyZjkTZw7djsHXBsoZ7NwGpelA16ulgq/qDB5JLjSUZY23ky1k9YeNgGT/ZHVNTST46XmoC4SkkS7AEf9JYqPgDdMkc2t7UGCC4cXK7qAZHpRZ5KFL/2oMQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029472; c=relaxed/simple;
	bh=8iU/+U9M+gWXkRXjeKe+OIgB/LU4uPnMtIt0B8v/VXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCRfYYsFCFgToq6ejhpeOX7NTwc2c8ZCWG8b9KHHHcK/UHdpsqqnA0wCEYjomPZQjFNmqP1RV2Tm343AT51u/Pq8m1vHYaX5gmGk2DDPpuugB5sqWJmYSoQ9VrW6T/NReX05KYH76SCZzttaf3dbZFOAGA4GnUKgPeF+9f0L2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dre6zxsn; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7093472356dso971979a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 04:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723029469; x=1723634269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g8T58TMUroLjjn23XCwrJps87DMjljqz/cFcV/xQzLE=;
        b=dre6zxsnXFbZRaPrsKme2aIU1KamFGzJHjO7AVnWBnbMZsuYTWUwy4CyOz7rr2L9ju
         YTOQPQV6Zg+ZX21mOGPKSaLtnsmVWx8ur9Nvc6gF2iZy1CsXpF/DAHSR7ECiqL5DEdB0
         wONYxooJ9173LDCua2bKmaxg7cZ9U9F97/nqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723029469; x=1723634269;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8T58TMUroLjjn23XCwrJps87DMjljqz/cFcV/xQzLE=;
        b=V9ShHFH5KReHdxn4xzyyd4TOgGS2EzGUhqa0LntZWMtSTx8CSIA9+RdFJCJFNmkpfz
         rPqUubLMP+BT48+nrTIbmiR4bg8d8KKcNfQJTzNJQMF6aDNDUz0r1oM0WskQhHy4n0PK
         jVkYwAAzzQbEIToc+Q1psFvZK3GvdkOBUv/fLBcOVuIJmbtbhFjgQiOnqCNmGXCg5U3i
         pnqoh/AsVd5mDtMYpFUh9z/Tfyyu9roHS187tMdij68KhD8V4VbX5bwWSQP4HTrvuBpg
         OarUGyOPHke3Ygq7wSU/ccFr+VvdGZod7rGGxVEnV9D/TBcxbYcGbZKkMIjuiQZMamtW
         ak7A==
X-Forwarded-Encrypted: i=1; AJvYcCUoRfHMrp6hE1OfEkXcBNj4KXSnD3hcT6HInEGxHD07pHiGKXykNF0UHQMC2Sso06EaDng1KLlFJgXeCFm5kJSOzzLMGjoREArn7gNActQ=
X-Gm-Message-State: AOJu0Yx46FnUFGYlR/145RI3J09Rlher/r6JZwQVUD2HDP17yDPBvW39
	uPAxDqbepKVyQzgTurk2LvLiZiR+wTthrQ4hGV8u+s4NjT38zom70/nfXlYN9Q==
X-Google-Smtp-Source: AGHT+IF57MpjgiXGHcNN6VTpzeW23YTSDW+7bPvQ8c8TcM/qbxMruA/tL2if1MrdIwPIvEwz72O7hA==
X-Received: by 2002:a05:6830:2654:b0:704:2dd4:362a with SMTP id 46e09a7af769-7099ea40342mr26878825a34.0.1723029469333;
        Wed, 07 Aug 2024 04:17:49 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7a7a53sm55589406d6.58.2024.08.07.04.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 04:17:48 -0700 (PDT)
Message-ID: <b6551bf0-2ee9-4b79-af68-0677e3f0f915@broadcom.com>
Date: Wed, 7 Aug 2024 13:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Alexey Charkov <alchark@gmail.com>, Jacobe Zang <jacobe.zang@wesion.com>,
 robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, conor+dt@kernel.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com,
 minipli@grsecurity.net, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
References: <20240805073425.3492078-1-jacobe.zang@wesion.com>
 <20240805073425.3492078-5-jacobe.zang@wesion.com>
 <2e38c2bd-2cb2-4104-97ad-0355069606c0@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <2e38c2bd-2cb2-4104-97ad-0355069606c0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/2024 1:10 AM, Alexey Charkov wrote:
> Hi Jacobe,
> 
> On 05/08/2024 10:34 am, Jacobe Zang wrote:
>> WiFi modules often require 32kHz clock to function. Add support to
>> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
>> to the top of brcmf_of_probe. Change function prototypes from void
>> to int and add appropriate errno's for return values that will be
>> send to bus when error occurred.
>>
>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> ---
>>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +++
>>   .../broadcom/brcm80211/brcmfmac/common.c      |  6 +++-
>>   .../wireless/broadcom/brcm80211/brcmfmac/of.c | 28 +++++++++++++------
>>   .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +++---
>>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
>>   .../broadcom/brcm80211/brcmfmac/sdio.c        | 18 ++++++++----
>>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>>   7 files changed, 52 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> index 13391c2d82aae..ee3ca85c4a47b 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> @@ -951,6 +951,10 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev 
>> *sdiodev)
>>           ret = -ENODEV;
>>           goto out;
>>       }
>> +    if (IS_ERR(sdiodev->bus)) {
>> +        ret = PTR_ERR(sdiodev->bus);
>> +        goto out;
>> +    }
> 
> Maybe return -ENODEV error pointer instead of NULL from brcmf_sdio_probe 
> as the default for the fail path? Then you can condense these two checks 
> into one

Sound reasonable.

>>       brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
>>   out:
>>       if (ret)
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>> index b24faae35873d..6c5d26f9b7661 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>> @@ -561,8 +561,12 @@ struct brcmf_mp_device 
>> *brcmf_get_module_param(struct device *dev,
>>       if (!found) {
>>           /* No platform data for this device, try OF and DMI data */
>>           brcmf_dmi_probe(settings, chip, chiprev);
>> -        brcmf_of_probe(dev, bus_type, settings);
>>           brcmf_acpi_probe(dev, bus_type, settings);
>> +        i = brcmf_of_probe(dev, bus_type, settings);
>> +        if (i < 0) {
>> +            kfree(settings);
>> +            settings = ERR_PTR(i);
>> +        }
> 
> This looks wrong. First, you're calling brcmf_of_probe twice. Second, if 
> either DMI or ACPI probe successfully but OF doesn't, then you return an 
> error code instead of success, and also overwrite settings with an error 
> pointer thus rendering both brcmf_dmi_probe and brcmf_acpi_probe useless

Twice? it is removed and added few lines below. It does change the order 
so that may not be best thing to do here. We actually only want to 
handle the scenario where the clock resources are not yet available, ie. 
when -EPROBE_DEFER is returned because that error value is taken into 
account by the bus driver and tries to bind the driver again later.

>>       }
>>       return settings;
>>   }
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> index e406e11481a62..5f61363fb5d0e 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_irq.h>
>>   #include <linux/of_net.h>
>> +#include <linux/clk.h>
>>   #include <defs.h>
>>   #include "debug.h"
>> @@ -65,17 +66,21 @@ static int brcmf_of_get_country_codes(struct 
>> device *dev,
>>       return 0;
>>   }
>> -void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>> -            struct brcmf_mp_device *settings)
>> +int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>> +           struct brcmf_mp_device *settings)
>>   {
>>       struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>>       struct device_node *root, *np = dev->of_node;
>> +    struct clk *clk;
>>       const char *prop;
>>       int irq;
>>       int err;
>>       u32 irqf;
>>       u32 val;
>> +    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>> +        return 0;
>> +
> 
> return 0 implies this function has completed successfully, while in this 
> case it's obviously returned early due to not finding the correct device 
> in DT. -ENODEV perhaps?

This was a void function so returning 0 retains the behavior as before, 
which is important to keep in mind here.

This function will be called if the platform has CONFIG_OF enabled. 
However, that does not mean that on every platform there is a node 
defined for the struct device being probed. That is fine if it does not 
require any DT properties to be functional. Hence we bail out here 
without an error.

>>       /* Apple ARM64 platforms have their own idea of board type, 
>> passed in
>>        * via the device tree. They also have an antenna SKU parameter
>>        */
>> @@ -105,7 +110,7 @@ void brcmf_of_probe(struct device *dev, enum 
>> brcmf_bus_type bus_type,
>>           board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
>>           if (!board_type) {
>>               of_node_put(root);
>> -            return;
>> +            return 0;
> 
> -ENOMEM?

Retain behavior.

>>           }
>>           strreplace(board_type, '/', '-');
>>           settings->board_type = board_type;
>> @@ -113,8 +118,13 @@ void brcmf_of_probe(struct device *dev, enum 
>> brcmf_bus_type bus_type,
>>           of_node_put(root);
>>       }
>> -    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>> -        return;
>> +    clk = devm_clk_get_optional_enabled(dev, "lpo");
>> +    if (!IS_ERR_OR_NULL(clk)) {
>> +        brcmf_dbg(INFO, "enabling 32kHz clock\n");
>> +        clk_set_rate(clk, 32768);
>> +    } else if (PTR_ERR_OR_ZERO(clk) == -EPROBE_DEFER) {
> 
> PTR_ERR should be enough, no? Or better yet move this to the bottom of 
> the function as was discussed on your previous submission, then you can 
> return PTR_ERR_OR_ZERO(clk) right away, which would be a bit neater.
> 
>> +        return -EPROBE_DEFER;
>> +    }
>>       err = brcmf_of_get_country_codes(dev, settings);
>>       if (err)
>> @@ -123,23 +133,25 @@ void brcmf_of_probe(struct device *dev, enum 
>> brcmf_bus_type bus_type,
>>       of_get_mac_address(np, settings->mac);
>>       if (bus_type != BRCMF_BUSTYPE_SDIO)
>> -        return;
>> +        return 0;
>>       if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
>>           sdio->drive_strength = val;
>>       /* make sure there are interrupts defined in the node */
>>       if (!of_property_present(np, "interrupts"))
>> -        return;
>> +        return 0;
> 
> -ENOENT?

That property is option in the binding so we return silently here as well.

>>       irq = irq_of_parse_and_map(np, 0);
>>       if (!irq) {
>>           brcmf_err("interrupt could not be mapped\n");
>> -        return;
>> +        return 0;
> 
> -ENXIO?

This is a bit more gray area. The interrupt is optional, but if it is in 
the device tree this is clearly intended to succeed. When it does the 
question is whether the error print is sufficient or should we use 
WARN() instead or fail the probe entirely. This interrupt is optional 
because it is only needed in some sleep scenarios where it can wake the 
host.

>>       }
>>       irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
>>       sdio->oob_irq_supported = true;
>>       sdio->oob_irq_nr = irq;
>>       sdio->oob_irq_flags = irqf;
>> +
>> +    return 0;
>>   }

[...]

>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> index 6b38d9de71af6..7d79e2db201b5 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c

[...]

>> @@ -4446,6 +4448,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct 
>> brcmf_sdio_dev *sdiodev)
>>       struct brcmf_sdio *bus;
>>       struct workqueue_struct *wq;
>>       struct brcmf_fw_request *fwreq;
>> +    int probe_attach_result;
>>       brcmf_dbg(TRACE, "Enter\n");
>> @@ -4474,7 +4477,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct 
>> brcmf_sdio_dev *sdiodev)
>>       bus->brcmf_wq = wq;
>>       /* attempt to attach to the dongle */
>> -    if (!(brcmf_sdio_probe_attach(bus))) {
>> +    probe_attach_result = brcmf_sdio_probe_attach(bus);
>> +    if (probe_attach_result < 0) {
>>           brcmf_err("brcmf_sdio_probe_attach failed\n");
>>           goto fail;
>>       }
>> @@ -4546,6 +4550,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct 
>> brcmf_sdio_dev *sdiodev)
>>   fail:
>>       brcmf_sdio_remove(bus);
>> +    if (probe_attach_result < 0)
>> +        return ERR_PTR(probe_attach_result);
>>       return NULL;
> 
> See my comment on the bcmsdh.c part above - perhaps initialize 
> probe_attach_result to -ENODEV by default and just return 
> ERR_PTR(probe_attach_result) here instead

Yup. Let's do that.

Thanks,
Arend


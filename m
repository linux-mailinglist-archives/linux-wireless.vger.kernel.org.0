Return-Path: <linux-wireless+bounces-11369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965F950C51
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 20:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927F91C218BA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E661A3BA1;
	Tue, 13 Aug 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HSSjIig3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE51CA89
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573919; cv=none; b=uRtq4RpfqZSs17T9gWtCPeMjJyAzz3M2MvA0zOl36spzjHAysHpQWfxmPK+ImZtxLhRbde2oBn3Vr6UrQsyuBwnBzAqPs0U1bFQPs/m3XbmXrjl1l/x0a+il4ZGEiOUHTee80TPHeQAHSXj9T4KhBWNsqOHHPLRrGkJ/B1mqFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573919; c=relaxed/simple;
	bh=/Ph8YIOkwWAw6z9ZcrzuF3BpMIFI5GLR8r34Rec7xAw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XMAP12kyBFQlKanejh2MXaIvkHpDCTaNgRPDEScEcimWAph7S2FWSf2JRE2S6ohRTTKOefztoJZvO+JV64b4kqwxlxCNWx3UuJwKd0p4LRYEXvceN1hmmDYI/aqXjI/hd3VQFxOJrsgc+pyJc9XlLYD69WhiIATOwKdt/TVMRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HSSjIig3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bd1a9bdce4so4040095a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 11:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723573915; x=1724178715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fZjzboO9UmfdwypV/EQ5V8Ua/shR3HQpQR9CVMCsZhQ=;
        b=HSSjIig3hE0ZgnFHXa3fUAo9w7bNhV9u9yCyVN1G5shf1RzcytvWh/c1fI/8j14qW6
         JbmTPmohXbUAogckMuru7g9QNzwxFs6mNIiAam399mwM8tDmMrX+ovff+VCcy2ktyFVl
         LRWs3o3aovJ5Bh+4gixd6zMZKsH+au5e33ZsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573915; x=1724178715;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZjzboO9UmfdwypV/EQ5V8Ua/shR3HQpQR9CVMCsZhQ=;
        b=SGuLHYGZ4SeHzqnkvlUcaWg0j0f0yPu4lUil3dNToabkElkHsZxiACMVhLffvQMffX
         3toSjBRAxB3DWMGBhc5RRmOBGP8WGQFFIm0vxF8RNCm9pSidYDo8X+TkE/On/G/NYZF+
         ZbpiHLFcmrutrzoIFrx5ExpW//yfsVXG1CckDJ+mys+nk4B/gN9Zf2u5rtBGmEKlFhCL
         IMgP6qT4UsThjWHo5Jv/V7yxdMctsjDImcLraTxxCo+1ZNGkImayNYFAAKjb7OwZCUBM
         BAmb1w9qGeRoKTFKBXvT3cjLlHVD84rYtHzB/sf5cjddJkT0icdEsVbBnvC3l/E3xpUI
         q77g==
X-Forwarded-Encrypted: i=1; AJvYcCXR97bMfb+843wqUE0tZ1uWvEkYqVLhpFmjH1xBixDUk3a+QlSTudBaKRTsn+9pZnixMXlnV5Cj9lBm8YazrnUorIq22628sa224DKIxqA=
X-Gm-Message-State: AOJu0YwO1N1aq5bW1GSUKOM7Fs8DC7l5DKU3Nqqbny0DR64H8rsmq+qJ
	+4vISDonfeoPG5VEAMfYTTn0eFXMjN27wpsHKAFd5N2nWAcDJIp/pIMhiRLUbA==
X-Google-Smtp-Source: AGHT+IGj8fhaeyyoAStEAef22eG7BYdK/y4E+CHsJOWxz3g/Onn/4uKnIX70JYlH5u94sT1HVp9LHA==
X-Received: by 2002:a17:907:f183:b0:a7a:8cc7:ca48 with SMTP id a640c23a62f3a-a8366fef3d1mr15748666b.46.1723573914849;
        Tue, 13 Aug 2024 11:31:54 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fed638sm89497466b.92.2024.08.13.11.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 11:31:54 -0700 (PDT)
Message-ID: <de80a665-07d2-4b38-9415-5ee1ed09e690@broadcom.com>
Date: Tue, 13 Aug 2024 20:31:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org,
 krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com,
 minipli@grsecurity.net, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com,
 Sai Krishna <saikrishnag@marvell.com>
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
 <20240813082007.2625841-5-jacobe.zang@wesion.com>
 <721da64c-42ec-4be6-8ad3-e2685a84823a@broadcom.com>
Content-Language: en-US
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <721da64c-42ec-4be6-8ad3-e2685a84823a@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/2024 1:57 PM, Arend van Spriel wrote:
> On 8/13/2024 10:20 AM, Jacobe Zang wrote:
>> WiFi modules often require 32kHz clock to function. Add support to
>> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
>> to the top of brcmf_of_probe. Change function prototypes from void
>> to int and add appropriate errno's for return values that will be
>> send to bus when error occurred.
> 
> I was going to say it looks good to me, but....
> 
>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> ---
>>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
>>   .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
>>   .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++--------
>>   .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
>>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
>>   .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++---
>>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>>   7 files changed, 61 insertions(+), 36 deletions(-)
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> index e406e11481a62..f19dc7355e0e8 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> 
> [...]
> 
>> @@ -113,33 +118,39 @@ void brcmf_of_probe(struct device *dev, enum 
>> brcmf_bus_type bus_type,
>>           of_node_put(root);
>>       }
>> -    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>> -        return;
>> -
>>       err = brcmf_of_get_country_codes(dev, settings);
>>       if (err)
>>           brcmf_err("failed to get OF country code map (err=%d)\n", err);
>>       of_get_mac_address(np, settings->mac);
>> -    if (bus_type != BRCMF_BUSTYPE_SDIO)
>> -        return;
>> +    if (bus_type == BRCMF_BUSTYPE_SDIO) {
> 
> Don't like the fact that this now has an extra indentation level and it 
> offers no extra benefit. Just keep the original if-statement and return 
> 0. Consequently the LPO clock code should move just before the 
> if-statement.
> 
>> +        if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
>> +            sdio->drive_strength = val;
>> -    if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
>> -        sdio->drive_strength = val;
>> +        /* make sure there are interrupts defined in the node */
>> +        if (!of_property_present(np, "interrupts"))
>> +            return 0;
>> -    /* make sure there are interrupts defined in the node */
>> -    if (!of_property_present(np, "interrupts"))
>> -        return;
>> +        irq = irq_of_parse_and_map(np, 0);
>> +        if (!irq) {
>> +            brcmf_err("interrupt could not be mapped\n");
>> +            return 0;
>> +        }
>> +        irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
>> +
>> +        sdio->oob_irq_supported = true;
>> +        sdio->oob_irq_nr = irq;
>> +        sdio->oob_irq_flags = irqf;
>> +    }
>> -    irq = irq_of_parse_and_map(np, 0);
>> -    if (!irq) {
>> -        brcmf_err("interrupt could not be mapped\n");
>> -        return;
>> +    clk = devm_clk_get_optional_enabled(dev, "lpo");
>> +    if (!IS_ERR_OR_NULL(clk)) {
>> +        brcmf_dbg(INFO, "enabling 32kHz clock\n");
>> +        return clk_set_rate(clk, 32768);
>> +    } else {
>> +        return PTR_ERR_OR_ZERO(clk);
>>       }
> 
> Change this to:
> 
>  > +    clk = devm_clk_get_optional_enabled(dev, "lpo");
>  > +    if (IS_ERR_OR_NULL(clk)) {
>  > +        return PTR_ERR_OR_ZERO(clk);
>  > +    }
>  > +    brcmf_dbg(INFO, "enabling 32kHz clock\n");
>  > +    clk_set_rate(clk, 32768);

Do we really need to set the clock rate or could that be defined in the 
devicetree? Just wondering. I have looked at the clock.yaml schema, but 
not really an idea what is needed in the devicetree spec. Any pointers 
from DT devs would be appreciated or a hard no-do-not-do-that is also 
fine ;-)

Regards,
Arend


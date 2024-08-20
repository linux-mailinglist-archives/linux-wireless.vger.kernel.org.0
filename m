Return-Path: <linux-wireless+bounces-11654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87A2958340
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 11:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C981F2372B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271C18C324;
	Tue, 20 Aug 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FXiWg5gW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164818C018
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147631; cv=none; b=p3S7GGLfvmcHpKzTTlkMY1ktJZB1UVodVBkpj+JoFYUZJIeLrl+iWv6/htiaKftg7XKugjx78ANvD5o18pwFDcC4Ad+PXqHzGxuanh23kJjmbOsmEC+SeLbOvMcU8l/yL7vCHG7+q1nejNs7AXfE+VaEcBeu0NjJNYrt7/k8ZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147631; c=relaxed/simple;
	bh=GxrtDuKtTT6pJGqk4JbG235dT4xixJ7axY2q2KnwnpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRL5Uvtxaw0b+ZbgZeOpSgtsDrK32WgrerMuxEMsq0dBNz56pCDWw1vMqk8ZTUiTEOP9XKIZa2HB/khXcE9Ok/j3D5BKGXdUYSxdXtXMS77giftP3t3FEBkhH3gp1cMC2tFza52V+ey2IvcEdrQ+xoYMvk7+bQ72/zoLqGAewow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FXiWg5gW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2021c08b95cso19680425ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724147629; x=1724752429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JrZv66ypySBbkjGBJqR1EJvhupMwP+pmcQpQ47+M+9Y=;
        b=FXiWg5gW/G6UonZeCMGwDuZTKo4uEtKYmrIdfJuZboNsBI7nifKt33VvQokcBfOpyG
         fucMUC0GngsnT6J4YpU4Dft9P3waH9K4FWVliAZhRRkcbpeqNZJFM4z6IXWfY8Z3v9ck
         IHh3ElETgEY6yaLpu9khTs23L+qsJ010gqZ7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147629; x=1724752429;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrZv66ypySBbkjGBJqR1EJvhupMwP+pmcQpQ47+M+9Y=;
        b=ixt6OHMGH8Adla1uT02+hpmbszBnBivJ6g/b/S1+pyigmhi54v+0Ft0KvHEkJnFPs4
         GNFfQKj7xROzGobBnLQ0wM0Qlan7OeG3xKiSsPNT4cRuI1KfOt9KETorI8O+i1XUWBb2
         OOXWdhjmgXStYEYFEJ3ECgL57RPaGVhyvcMSg3jDsl8EKXuCVyMJLCy11xv9F+nUp1Ev
         mbk6hLz6e/0QdtPq2SKT1BiAwPl7lEP8ji6vcuy6qdZVWRNIxUuNRjJkTSJJob4Ywygo
         xrECNs90fvjHRFidoRWFoE9gjwOOzTiVzmBj1y+n68mr2H0f6QZFFOumIaUD8PA+1geG
         A6vA==
X-Forwarded-Encrypted: i=1; AJvYcCUXrIU6W7FVUqX0OXdX4ooJSquz7qeXnevRO1TDekqd9H2plugmA3u6wbF9bBSKGLJmSIKF0mj1qEhbY9lGbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxysxBSILdBCqfjlCdYE2NIlhlVfZCFdC506bPcA9E6JVeuC91X
	mBASS9428ARrDj6vwNvfJgN+OVkmHLie9h4oSNO3Knsl74tmLxqtpM/YiRAw0g==
X-Google-Smtp-Source: AGHT+IF9dVDhLgmVd2fwVFFWmxIJ70NtaZMWP9SUcwSh2q1d0OqobzkgL6YHM4o8P1aQbGHfymYCJA==
X-Received: by 2002:a17:902:f68a:b0:1f9:e2c0:d962 with SMTP id d9443c01a7336-2025f1d09d3mr40897905ad.31.1724147628827;
        Tue, 20 Aug 2024 02:53:48 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b63694a1sm8802517a12.92.2024.08.20.02.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 02:53:48 -0700 (PDT)
Message-ID: <7c2c6d22-399b-42e7-8ac7-098f036e9e81@broadcom.com>
Date: Tue, 20 Aug 2024 11:53:41 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/4] Add AP6275P wireless support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: jacobe.zang@wesion.com, bhelgaas@google.com,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 christophe.jaillet@wanadoo.fr, conor+dt@kernel.org, davem@davemloft.net,
 devicetree@vger.kernel.org, duoming@zju.edu.cn, edumazet@google.com,
 gregkh@linuxfoundation.org, krzk+dt@kernel.org, kuba@kernel.org,
 kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, megi@xff.cz, minipli@grsecurity.net,
 netdev@vger.kernel.org, pabeni@redhat.com, robh@kernel.org,
 saikrishnag@marvell.com, stern@rowland.harvard.edu, yajun.deng@linux.dev
References: <uzmj5w6byisfguatjyy2ibo6zbn7w52bg2abgf7egych7usv6j@ec4xdmaofach>
 <67d67f15-4631-44ba-bc05-c8da6a1af1bf@broadcom.com>
 <xc5226th2sifhop3gnwnziok4lfl5s6yqbxq6wx4vygnuf4via@4475aaonnmaz>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <xc5226th2sifhop3gnwnziok4lfl5s6yqbxq6wx4vygnuf4via@4475aaonnmaz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/2024 10:33 PM, Sebastian Reichel wrote:
> Hello,
> 
> On Mon, Aug 19, 2024 at 09:35:12PM GMT, Arend van Spriel wrote:
>> On 8/19/2024 6:42 PM, Sebastian Reichel wrote:
>>> I tested this on RK3588 EVB1 and the driver is working fine. The DT
>>> bindings are not correct, though:
>>>
>>> linux/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: wifi@0,0:
>>> compatible: 'oneOf' conditional failed, one must be fixed:
>>>
>>> ['pci14e4,449d', 'brcm,bcm4329-fmac'] is too long
>>> 'pci14e4,449d' is not one of ['brcm,bcm43143-fmac', 'brcm,bcm4341b0-fmac',
>>> 'brcm,bcm4341b4-fmac', 'brcm,bcm4341b5-fmac', 'brcm,bcm4329-fmac',
>>> 'brcm,bcm4330-fmac', 'brcm,bcm4334-fmac', 'brcm,bcm43340-fmac',
>>> 'brcm,bcm4335-fmac', 'brcm,bcm43362-fmac', 'brcm,bcm4339-fmac',
>>> 'brcm,bcm43430a0-fmac', 'brcm,bcm43430a1-fmac', 'brcm,bcm43455-fmac',
>>> 'brcm,bcm43456-fmac', 'brcm,bcm4354-fmac', 'brcm,bcm4356-fmac',
>>> 'brcm,bcm4359-fmac', 'brcm,bcm4366-fmac', 'cypress,cyw4373-fmac',
>>> 'cypress,cyw43012-fmac', 'infineon,cyw43439-fmac']
>>> from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
>>>
>>> It's easy to see the problem in the binding. It does not expect a
>>> fallback string after the PCI ID based compatible. Either the
>>> pci14e4,449d entry must be added to the first enum in the binding,
>>> which has the fallback compatible, or the fallback compatible
>>> should not be added to DTS.
>>
>> Never understood why we ended up with such a large list. When the binding
>> was introduced there was one compatible, ie. brcm,bcm4329-fmac. People
>> wanted all the other flavors because it described a specific wifi chip and
>> no other reason whatsoever. The PCI ID based compatible do obfuscate that
>> info so those are even less useful in my opinion.
>>
>>> If the fallback compatible is missing in DTS, the compatible check in
>>> brcmf_of_probe() fails and the lpo clock is not requested resulting
>>> in the firmware startup failing. So that would require further
>>> driver changes.
>>
>> Right. The text based bindings file in 5.12 kernel clearly says:
>>
>> Required properties:
>>
>>   - compatible : Should be "brcm,bcm4329-fmac".
>>
>> In 5.13 kernel this was replaced by the json-schema yaml file. The PCI ID
>> based enum which was added later does also list brcm,bcm4329-fmac so why
>> does that not work for the compatible list ['pci14e4,449d',
>> 'brcm,bcm4329-fmac']? Looking at the compatible property in yaml which I
>> stripped a bit for brevity:
>>
>> properties:
>>    compatible:
>>      oneOf:
>>        - items:
>>            - enum:
>>                - brcm,bcm43143-fmac
>>                - brcm,bcm4329-fmac
>>                - infineon,cyw43439-fmac
>>            - const: brcm,bcm4329-fmac
>>        - enum:
>>            - brcm,bcm4329-fmac
>>            - pci14e4,43dc  # BCM4355
>>            - pci14e4,4464  # BCM4364
>>            - pci14e4,4488  # BCM4377
>>            - pci14e4,4425  # BCM4378
>>            - pci14e4,4433  # BCM4387
>>
>> So how should I read this. Searching for some sort of syntax description I
>> found [1] which has an example schema with description that has a similarly
>> complicated compatible property. From that I think the above should be
>> changed to:
>>
>>   properties:
>>     compatible:
>>       oneOf:
>>         - items:
>>             - enum:
>>                 - brcm,bcm43143-fmac
>> -              - brcm,bcm4329-fmac
>>                 - infineon,cyw43439-fmac
>>             - const: brcm,bcm4329-fmac
>> +      - items:
>>             - enum:
>> -              - brcm,bcm4329-fmac
>>                 - pci14e4,43dc  # BCM4355
>>                 - pci14e4,4464  # BCM4364
>>                 - pci14e4,4488  # BCM4377
>>                 - pci14e4,4425  # BCM4378
>>                 - pci14e4,4433  # BCM4387
>> +          - const: brcm,bcm4329-fmac
>> +      - const: brcm,bcm4329-fmac
>>
>> This poses a constraint in which the last string in the compatible list is
>> always 'brcm,bcm4329-fmac' even if it is the only string. At least that is
>> my understanding so if my understanding is wrong feel free to correct me on
>> this.
>>
>> [1] https://docs.kernel.org/devicetree/bindings/writing-schema.html
> 
> Your proposed change should work as you describe. But it will result
> in DT check errors for some Apple devices, which followed the
> current binding and do not have the "brcm,bcm4329-fmac" fallback
> compatible:
> 
> $ git grep -E "(pci14e4,43dc)|(pci14e4,4464)|(pci14e4,4488)|(pci14e4,4425)|(pci14e4,4433)" arch/
> arch/arm64/boot/dts/apple/t8103-jxxx.dtsi:           compatible = "pci14e4,4425";
> arch/arm64/boot/dts/apple/t8112-j413.dts:            compatible = "pci14e4,4433";
> arch/arm64/boot/dts/apple/t8112-j493.dts:            compatible = "pci14e4,4425";

> I guess patch 3/4 from this series will also introduce some
> regressions for these devices by moving the check. What is the
> purpose of the compatible check in brcmf_of_probe() in the first
> place? Can it just be dropped?
> 
> I see it was introduced 10 years ago in 61f663dfc1a09, probably to
> avoid a spurious error message for systems not having the IRQ
> described in DT? The current code exits quietly when none of the
> optional resources are defined.

It was introduced simply because the compatible property has a meaning 
that goes beyond informational. It is a claim that the properties of the 
node comply to the bindings specification. I would really want to keep 
the sanity check event though all properties are optional. The 
constraint keeps the compatible matching in the driver relatively simple.

Regards,
Arend


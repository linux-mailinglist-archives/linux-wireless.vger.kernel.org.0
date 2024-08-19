Return-Path: <linux-wireless+bounces-11634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11999957486
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 21:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519A5B2109F
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BF81DC48E;
	Mon, 19 Aug 2024 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q/vb/z0w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8865186E56
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096118; cv=none; b=Dme2BN9dTT3LSa/iVEgTr2PujAPxQxRJvTOY7HknZZuZHtunyyawx5gbFLK1OOaO2DjqnPyBw2wWIAZSOpNnPCbowqQEqjBsPc0gwSXoLE1KFgxH3s11ZRbE1mDX0pEpgSFsH0d9CLhxr2WowgkF8zmEB3ebwycwgM44b/FSHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096118; c=relaxed/simple;
	bh=QVO8dQKuFoGTBgkLNEPkI6tkWY3oyBUFbQkqyAFCosI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8l7TWJy8Vix/fAQOh5VTkFaI7AQnJlPlY3RNkkv3t1QtOsggZQFoR796xlIhG99b51ZVBnKTG2dE5kwJ77LBQI6CtPMluDztyCqcsXgfGC/lq2Sb1aT9wAD2EeFsPmTIhzVL8l7UDtf63HZqU6/hOiHAPPVdI8Il2GYJJa5uLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q/vb/z0w; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-371b2e95c34so1257251f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724096115; x=1724700915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q/8oU2DQN2VtroQHSmbqD7g4h/fFT45vHUDpJEOX9KQ=;
        b=Q/vb/z0w+lsfJtgX6woCBXX7pjidQYmCtqNQ/lPmQtIKxZad2ZxPUB9dKSA6gm4IEk
         nZntVmzYsraH/6MosdRba38gmVSDwkjZVUHiNBCHIKva8oz6DlQyeV6FboWTQEyNbqQL
         FXgo5MTP46sTxVZ2LIYLUI32VPx5TaIJNrpcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724096115; x=1724700915;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/8oU2DQN2VtroQHSmbqD7g4h/fFT45vHUDpJEOX9KQ=;
        b=qdMijnf9+GkepDfJW9zSqNJk/8fdBXvlpHGaAsOjlOzQWe7s0lqcmrfym9exRbcVID
         pq8CwVej5bL+8Hj8foKJCYAZPImk0P6tExLzAbfgelYqVGGgchG4j80Co0Z7h9/G8Ixz
         mN1ELqPuKMxeR2LsT1Aj0pKVqAg+gKYTfg5J95aDjhHFeVd29IVxBXa03CXZ1COVqaZb
         eVGWs4NQwXIU+jt6OSccU+NIqp9lFBquNSAebR2ap2yDygU2XaTroUuzBWigocit3vXV
         /YAg7t1KohpkFtxUMcl45rfFGJupty06dycCqju0Zj1j8yAf8dgwWIRdQZ9+FDtlHvL5
         ZSVg==
X-Forwarded-Encrypted: i=1; AJvYcCXEDvRmCcK07heAYhm+Jn+AETWF9iogsH9M5pc7KXMMugkIYBNIsjifykEagcczba9SBuBl7ehLqHoreDw6jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrA57cjUWhm4nQMUCZ48kaHdjGJ+e9cJfenOmZnULIMdHcBIT
	jCMPFMDySZLzIeIhojbKLhE3hSBsM9rTrKxfEdaNu1K3Qt3vg80MQQv29/dYSg==
X-Google-Smtp-Source: AGHT+IFxDHrCxmqP1sMvx6+E1BvkJ9ai7PXpym4xREMRt7wpAQAA5ZQvLnWAv6zgJIz2EMN/kCjUFQ==
X-Received: by 2002:adf:e78b:0:b0:371:885f:73a with SMTP id ffacd0b85a97d-37194695bf8mr7231281f8f.58.1724096114326;
        Mon, 19 Aug 2024 12:35:14 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6af1sm668200566b.45.2024.08.19.12.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 12:35:13 -0700 (PDT)
Message-ID: <67d67f15-4631-44ba-bc05-c8da6a1af1bf@broadcom.com>
Date: Mon, 19 Aug 2024 21:35:12 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/4] Add AP6275P wireless support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 jacobe.zang@wesion.com
Cc: bhelgaas@google.com, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, christophe.jaillet@wanadoo.fr,
 conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org,
 duoming@zju.edu.cn, edumazet@google.com, gregkh@linuxfoundation.org,
 krzk+dt@kernel.org, kuba@kernel.org, kvalo@kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, megi@xff.cz,
 minipli@grsecurity.net, netdev@vger.kernel.org, pabeni@redhat.com,
 robh@kernel.org, saikrishnag@marvell.com, stern@rowland.harvard.edu,
 yajun.deng@linux.dev
References: <uzmj5w6byisfguatjyy2ibo6zbn7w52bg2abgf7egych7usv6j@ec4xdmaofach>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <uzmj5w6byisfguatjyy2ibo6zbn7w52bg2abgf7egych7usv6j@ec4xdmaofach>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/2024 6:42 PM, Sebastian Reichel wrote:
> Hi,
> 
> I tested this on RK3588 EVB1 and the driver is working fine. The DT
> bindings are not correct, though:
> 
> linux/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: wifi@0,0:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 
> ['pci14e4,449d', 'brcm,bcm4329-fmac'] is too long
> 'pci14e4,449d' is not one of ['brcm,bcm43143-fmac', 'brcm,bcm4341b0-fmac',
> 'brcm,bcm4341b4-fmac', 'brcm,bcm4341b5-fmac', 'brcm,bcm4329-fmac',
> 'brcm,bcm4330-fmac', 'brcm,bcm4334-fmac', 'brcm,bcm43340-fmac',
> 'brcm,bcm4335-fmac', 'brcm,bcm43362-fmac', 'brcm,bcm4339-fmac',
> 'brcm,bcm43430a0-fmac', 'brcm,bcm43430a1-fmac', 'brcm,bcm43455-fmac',
> 'brcm,bcm43456-fmac', 'brcm,bcm4354-fmac', 'brcm,bcm4356-fmac',
> 'brcm,bcm4359-fmac', 'brcm,bcm4366-fmac', 'cypress,cyw4373-fmac',
> 'cypress,cyw43012-fmac', 'infineon,cyw43439-fmac']
> from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
> 
> It's easy to see the problem in the binding. It does not expect a
> fallback string after the PCI ID based compatible. Either the
> pci14e4,449d entry must be added to the first enum in the binding,
> which has the fallback compatible, or the fallback compatible
> should not be added to DTS.

Never understood why we ended up with such a large list. When the 
binding was introduced there was one compatible, ie. brcm,bcm4329-fmac. 
People wanted all the other flavors because it described a specific wifi 
chip and no other reason whatsoever. The PCI ID based compatible do 
obfuscate that info so those are even less useful in my opinion.

> If the fallback compatible is missing in DTS, the compatible check in
> brcmf_of_probe() fails and the lpo clock is not requested resulting
> in the firmware startup failing. So that would require further
> driver changes.

Right. The text based bindings file in 5.12 kernel clearly says:

Required properties:

  - compatible : Should be "brcm,bcm4329-fmac".

In 5.13 kernel this was replaced by the json-schema yaml file. The PCI 
ID based enum which was added later does also list brcm,bcm4329-fmac so 
why does that not work for the compatible list ['pci14e4,449d', 
'brcm,bcm4329-fmac']? Looking at the compatible property in yaml which I 
stripped a bit for brevity:

properties:
   compatible:
     oneOf:
       - items:
           - enum:
               - brcm,bcm43143-fmac
               - brcm,bcm4329-fmac
               - infineon,cyw43439-fmac
           - const: brcm,bcm4329-fmac
       - enum:
           - brcm,bcm4329-fmac
           - pci14e4,43dc  # BCM4355
           - pci14e4,4464  # BCM4364
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387

So how should I read this. Searching for some sort of syntax description 
I found [1] which has an example schema with description that has a 
similarly complicated compatible property. From that I think the above 
should be changed to:

  properties:
    compatible:
      oneOf:
        - items:
            - enum:
                - brcm,bcm43143-fmac
-              - brcm,bcm4329-fmac
                - infineon,cyw43439-fmac
            - const: brcm,bcm4329-fmac
+      - items:
            - enum:
-              - brcm,bcm4329-fmac
                - pci14e4,43dc  # BCM4355
                - pci14e4,4464  # BCM4364
                - pci14e4,4488  # BCM4377
                - pci14e4,4425  # BCM4378
                - pci14e4,4433  # BCM4387
+          - const: brcm,bcm4329-fmac
+      - const: brcm,bcm4329-fmac

This poses a constraint in which the last string in the compatible list 
is always 'brcm,bcm4329-fmac' even if it is the only string. At least 
that is my understanding so if my understanding is wrong feel free to 
correct me on this.

[1] https://docs.kernel.org/devicetree/bindings/writing-schema.html
> Greetings,
> 
> -- Sebastian


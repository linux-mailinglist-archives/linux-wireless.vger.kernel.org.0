Return-Path: <linux-wireless+bounces-9151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85B90CA65
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C3B275C2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8C21990DD;
	Tue, 18 Jun 2024 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blHbx35h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25034158A33;
	Tue, 18 Jun 2024 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708956; cv=none; b=WMnZMrZEwZ2qKEjOyZK2bKmfdwAex4cNmbqm8fnYF+JP/UcAYHQJaapQyUrMHaVZAhDBbRqma+4s6SiPTx64SO8rnUtJFO42VhiXKoZYuwXZYZGoEc1BtluYa4jVyWb31pLZ/4OAPDXLEWoxOqPgMME7p9ud/KR0/KdFA/RpYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708956; c=relaxed/simple;
	bh=tyB2je5H5jbXyJKO679uCQvKxGsjbPFrgqR1yhBwIoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0JzLtn0BzFUwyWsnr70D80lubwiIBSjLXbOR5x4GK3o60PuofsxdTO0YzI7ywtxjxivg1OMM1GUDx6vEWdxdne1kwOAS7l2zCYIn7vdZW0jDjxe2SQ43LDky5adgJlRIOGfp4IhHzRDX1s9MhLN+4amM/fRUFhjH2A5u6oJbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blHbx35h; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-705cffc5bcfso4784918b3a.3;
        Tue, 18 Jun 2024 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718708954; x=1719313754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iG1TCVG1MSplKguOPsRkz4XSFyOd0ncEb7510ZBmig8=;
        b=blHbx35hjxVxj2wU2bW82m1aVFniqGGxE08QxyV6sDR6rjJ+GWUmufBnFhGd2qCFmm
         86jUVqTUPlAdaL3LTitjNtPUJIBsOdxEh3T+bgQWixg/oHu3golJiy4qsRUEhxI8LTL7
         Tu8WPC7R+tSR3EnLtD0qj0+9+UwBGUVqDIYmknnjXp8enqQnd4Y3jOYhoblWHIYqEVol
         idnqXvbfoBDf+QrSPO1T5W66diXWIOkcXBb1bjcdKwNxZ54N2y1lErWtfahM3Ox7dC2V
         557gS8VGzZQsmwHs4Vfvus8lKb0wshh6ThIUwzrI2TX/6uz+7zkn5dZJmwO3L3N0Ge0I
         yMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718708954; x=1719313754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iG1TCVG1MSplKguOPsRkz4XSFyOd0ncEb7510ZBmig8=;
        b=bpq3t5J+RUJQ8pzqLOyuS+V/hfc94mJ+hs+k8ULFgWV4Jy3CPJFXhCzkzW7BgT9dzF
         rfkTGVPfwmldyJf805FFyw36lBZi2cQw3lcdm5Fnb/bXZICgLb0rvDCB/d5oQqhA83ec
         vxyRJ51cl1tKt0j356WvY0aprHViQ1oYKKxCW75R4C4EKsoQ6C9vq4RZ2A/G39JbnSTD
         h2pyYPTv2deQKzFYsdy66oJ5oI6XMEMOy8+/JrL/QBbwSIjdNIROSGDCvoXShsMpsX+B
         G/YCRpo9/lgjh/BC5nu9VYC2Q55MRZxGHRzRU+rtDKc68zj0j3vLbJJORRgQxkF54DfU
         5fdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb7wpkHQ72m2dwOgmKcT0XC6fWZo076o0ZibLaucUqsUKkSNEMztGXvLC0MHNkwcLHesOhhn6MAbxw2MmATLw3s+vy8d4zlwF9XiV3dv9n0kVQXC56+iRZSsods0mZslbOWwhnO00h3J8PpY90pmqwG3JNq4phDtxuAiEI1eQQd7H4R1CuJZ3my5QsHkjgaAZL1d/WMZIPa23oC3h1HYuP
X-Gm-Message-State: AOJu0YxmhWEVue3sTjApDg3qVm6W0Z8tT10xYUyZ3cUNvfgpo6I/j74e
	IF3DFXw4tlc/4NOhc/A8lj1bs3Yy9NKxNW+7Mox4pqu7pXGApLLF
X-Google-Smtp-Source: AGHT+IHn570jSC8mLa207ZZVoJ1a8SWyy+Vg9tFXV+t5mTPomgDIdr4p3GNRxtFtvUJjDKmZNzb2Hg==
X-Received: by 2002:a05:6a21:3213:b0:1b7:edc9:be56 with SMTP id adf61e73a8af0-1bae8001f55mr15760048637.40.1718708954298;
        Tue, 18 Jun 2024 04:09:14 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75cdec7sm12969595a91.3.2024.06.18.04.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:09:13 -0700 (PDT)
Message-ID: <b6b06a15-b7de-4351-ab9e-5234d2b91496@gmail.com>
Date: Tue, 18 Jun 2024 13:09:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dt-bindings: net: wireless: BCM4329 binding: add
 pci14e4,449d
To: Jacobe Zang <jacobe.zang@wesion.com>, kvalo@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nick@khadas.com, arend@broadcom.com, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240617024341.3106240-1-jacobe.zang@wesion.com>
Content-Language: en-US
From: Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20240617024341.3106240-1-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/2024 4:43 AM, Jacobe Zang wrote:
> It's a Broadcom Wi-Fi module connected via the PCIe interface and also
> add prefix in vendor-prefix.yaml
> 
> Link:https://lore.kernel.org/linux-devicetree/20240617023517.3104427-1-jacobe.zang@wesion.com/T/#u
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>   .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> index e564f20d8f415..0477566acd72a 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -53,6 +53,7 @@ properties:
>             - pci14e4,4488  # BCM4377
>             - pci14e4,4425  # BCM4378
>             - pci14e4,4433  # BCM4387
> +          - pci14e4,449d  # BCM4329

I can not find that device id. Can you provide more information where 
you came across this device. The BCM4329 as I know it is an 802.11n 
*SDIO* device. Not a PCI device.

Regards,
Arend


Return-Path: <linux-wireless+bounces-10727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D79942BCC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 12:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5402F1F212F2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510171AB517;
	Wed, 31 Jul 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWeGXjCE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71211CF93;
	Wed, 31 Jul 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421023; cv=none; b=qr1QM+3lAuIPvvsgx/YB+daeW6V8ItC4fks8AQurQ4ab3ly5Z9J8rXBS4MJwOpy5wi+m6Y1rcs/hnSWU/9Qnvy1ycNET4jX14ca3B6p26e/k0FPUT/4NzvaxjmrRr0hfd3QMdMHYlexwuoTLHEB43l0Bfs+lo8OY0Xh/JyzEbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421023; c=relaxed/simple;
	bh=6UjJVQFegPDjWvvKUdWh3ajOioWkd2LppLqQBIgw9r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4MJ5AbAQlX9eUlrSBJpHfhxC2urR4fUoH/AnpTV+QWTBSebVXKBvvLKMQFTSW8NYEmrkulaZkEN2ovVq1W81mEDrWrXgLidr3fvBOAK9Uc2qlMOeBgz+esgc+os14C5YfH3G+SkfSCMP85srqLpT0m6gSxFOFIoozioeyWZwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWeGXjCE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so12369873e87.0;
        Wed, 31 Jul 2024 03:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722421019; x=1723025819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0AaaFuIf1xRzlWKEfSWSyC0cUztpO1y/p+yF/M4k91k=;
        b=UWeGXjCENt1hwMRBOGmlJb3HLgSGCT3Wyj+7Kt+n/CZRaZd13tumn2diH5a+t8jAZ5
         AEsYNbTbH0KSaYaFv/XxKsznbEkun0R1SuJx+IG4xmv9Yzm1M4+10AVLrZyeH6xcFEUt
         mHNGNqe6gFScyoZJJYjBGMYZ93QEuJbSlhAzH+nAVT45EN6l7NBh4sT4IvGiFIrsW+4j
         oVuzhWADYj3F4gRNe0yluC5Ivc4ybuCJVnC1a2kZW/MNngya51MNJU3ulSSGBztQmMyN
         hbBbo0Goee6TgSnoPkmVlrEHCj/D4sxDVHVN8RCTlc+HKw4x932tnP1aIlI6KFNPeXuk
         27iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722421019; x=1723025819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AaaFuIf1xRzlWKEfSWSyC0cUztpO1y/p+yF/M4k91k=;
        b=nTWeOmueb8A2NEJ7f+2uEtS/iL1k/a1V6RfH4CuCniLmviQ+tXTlc8yEa/sG9Dtd55
         1u9k/+9mRJawey08Znch6yT6rQVOh8FzE8mVvf50iw3O2DSxjek05AlsHxhf2jUwylf4
         A2VyWLdH1kZEPdHaBF96noaeIVTqCQbSnmfuFgx6XYGlZiNGbgyTuGf4LIrv1+DxSvru
         CXmoYpt3iqlxNSpxtiD+9RhiFyrg2JsGQbBhH2+h0w0oxmwKUJwSTCeNtfp/nQ8pPZl5
         nTi+OSPxoWH8yvrdEKqzS1MwbGD4HbS1M+ZQuJbf743Ye5zzwO8CThONU5eEgq73ZKpe
         J6mA==
X-Forwarded-Encrypted: i=1; AJvYcCU1E/4zWFpUp6fxuQNy+xyhOiu5tWlLD3EMyH/z876HxZw2ciDmNoO/Tp9JrzlY/ipFhD83Rwm5RUMj@vger.kernel.org, AJvYcCUi4FOGR8WP0n3yu2rjshg1IC9zM8XqbLD7tNHCup/07viPT6S4uQuctPeS9gCbDniRzJDa7RaH@vger.kernel.org, AJvYcCXtyIrlT37kl9LeGFic7VRA9P976yytva6KjckoUy3igEwXInyNvXgGixZJT/amcmZCAqhfkdIG7LHpZgZ7@vger.kernel.org, AJvYcCXuVzcl5DzUsa/EJNMxHvbhaWAbaGdeYOQ7qTO/h+kCccUvP0FAdLhUB2XPqGkgepZPSEVSa/PUKni/2B7A7q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRuBGjY4L23IlST2z73Vq5fc+MCj729LiMyyQMZZ7bkAbR9QMl
	acYwAjREQMk4IrdWCL0Dr5SJJ4FPdcaFU8xWNkFp/eRFQBPnCqQC
X-Google-Smtp-Source: AGHT+IF2e1PeQYS2su4wh/SIyoSoRuTA/mOWzxXZEnnmqqjxiriV4Tt63IghqsPDtpogPid6UjTSbQ==
X-Received: by 2002:a19:8c11:0:b0:52c:c9e4:3291 with SMTP id 2adb3069b0e04-5309b2e0b50mr8248953e87.60.1722421018492;
        Wed, 31 Jul 2024 03:16:58 -0700 (PDT)
Received: from [172.30.17.119] ([194.247.191.114])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c0820esm2149509e87.167.2024.07.31.03.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 03:16:57 -0700 (PDT)
Message-ID: <0a78a0fb-0a5e-424f-a801-4a63b9ee1a49@gmail.com>
Date: Wed, 31 Jul 2024 13:16:56 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org,
 krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 conor+dt@kernel.org, arend.vanspriel@broadcom.com
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com,
 minipli@grsecurity.net, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
 <20240731061132.703368-5-jacobe.zang@wesion.com>
Content-Language: en-US
From: Alexey Charkov <alchark@gmail.com>
In-Reply-To: <20240731061132.703368-5-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jacobe,


On 31/07/2024 9:11 am, Jacobe Zang wrote:
 > WiFi modules often require 32kHz clock to function. Add support to
 > enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
 > to the top of brcmf_of_probe
 >
 > Co-developed-by: Ondrej Jirman <megi@xff.cz>
 > Signed-off-by: Ondrej Jirman <megi@xff.cz>
 > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
 > ---
 >  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 +++++++++++-
 >  1 file changed, 11 insertions(+), 1 deletion(-)
 >
 > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c 
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
 > index e406e11481a62..7e0a2ad5c7c8a 100644
 > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
 > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
 > @@ -6,6 +6,7 @@
 >  #include <linux/of.h>
 >  #include <linux/of_irq.h>
 >  #include <linux/of_net.h>
 > +#include <linux/clk.h>
 >
 >  #include <defs.h>
 >  #include "debug.h"
 > @@ -70,12 +71,16 @@ void brcmf_of_probe(struct device *dev, enum 
brcmf_bus_type bus_type,
 >  {
 >      struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 >      struct device_node *root, *np = dev->of_node;
 > +    struct clk *clk;
 >      const char *prop;
 >      int irq;
 >      int err;
 >      u32 irqf;
 >      u32 val;
 >
 > +    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
 > +        return;

Did you test this? The DTS patch you sent as part of this series doesn't 
list "brcm,bcm4329-fmac" in the compatible, so this will probably return 
right here, skipping over the rest of your patch.

Please test before resending, both with and without the driver for the 
Bluetooth part of the chip (since it also touches clocks).

You are also changing the behavior for other systems by putting this 
check further up the probe path, which might break things for no reason. 
Better put your clk-related addition below where this check was 
originally, rather than reorder stuff you don't have to reorder.

 > +
 >      /* Apple ARM64 platforms have their own idea of board type, 
passed in
 >       * via the device tree. They also have an antenna SKU parameter
 >       */
 > @@ -113,8 +118,13 @@ void brcmf_of_probe(struct device *dev, enum 
brcmf_bus_type bus_type,
 >          of_node_put(root);
 >      }
 >
 > -    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
 > +    clk = devm_clk_get_optional_enabled(dev, "lpo");
 > +    if (!IS_ERR_OR_NULL(clk)) {
 > +        brcmf_dbg(INFO, "enabling 32kHz clock\n");
 > +        clk_set_rate(clk, 32768);
 > +    } else {
 >          return;

Why return here? If the clock is optional, a lot of systems will not 
have it - that shouldn't prevent the driver from probing. And you are 
still not handling the -EPROBE_DEFER case which was mentioned on your 
previous submission.

Best regards,
Alexey


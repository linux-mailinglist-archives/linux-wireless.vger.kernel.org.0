Return-Path: <linux-wireless+bounces-11095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50494AE5F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 18:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4D728304F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFE713B290;
	Wed,  7 Aug 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXNvizFR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87C12C530;
	Wed,  7 Aug 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049312; cv=none; b=CggUPXBORTbzBmEU1K9VFGdTEfMEVzLpNWPvEt8hx/jMYTs/pOAR2k96UDR0CXaHSxvb9on/kTnyFvGmoX+4q/i3+E0CbUh/ptjyMMM3ufuBXC5lqDDN3xAYag1Jdb9PmIhBU5a4X3bVyPRHxW7kUdOzcNijr2wghU2mnb6MtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049312; c=relaxed/simple;
	bh=MyGpS8A8yCOgOMFPJGm3nQghuITkLQxuSG1wKxyoEAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kniCSvvnppnto8yWxAbWvFU2MLO/m80Xv+UOnpjkdvTrUDokYFmJj9aP12gYd7lSiH/V5ARtRwn1GEWAGkfAtUGKsW/53MIsuBgOc9z/1PmbnPKS515XUS+IYpOn9iUye3/G+HJ+qyAQJ4QW+cf6UpwNGohdshkRSd4Qmwxukeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXNvizFR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d6f4714bso4064985a.1;
        Wed, 07 Aug 2024 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723049309; x=1723654109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ppEzbuljpxEqS9CSU1lR4GhsTWn9NP9h9n5p+ezkHKg=;
        b=TXNvizFRa8KHc3gIvhAR9tAAZSQtCQfNcXw2ooVVeB7cCunnhpRwdggUTp6+3LXmGc
         Nn6yvp3uAytRuK/FDJXAUnXo2TMLgxs9C13yZzzJBtHnb/nfLfyU9uSrSCzGlsmqJSXH
         +DNWYGCnEUeLRlNC0cUlRQpdNrCpV0PKqr/sATGSuut4LYs4Pc9/x1UrCCKF7+lHrE74
         EQ9Mnmu8v2j0IsEDiUZvyN597HVsYtiT8K7ScjRH4HyDPL1Trqkl0THe+ZxjAjIMXg1s
         J+YxfF7h39v4vSzyv3HdYjeQTpQMAtkJP0crIgOkOTPxuPdUbD+CMJ5cVLOpycQbBwhG
         yjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723049309; x=1723654109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppEzbuljpxEqS9CSU1lR4GhsTWn9NP9h9n5p+ezkHKg=;
        b=pjFNkonJttY1Rk+4gMWs3fF8192sJmV5l7pparzVbQ5r6Ps5Su5NvbemLxot/Da4BN
         KIe62fEhwx7WnxbSo0LRN/Y3QAf4kYJRgRTSUyIJoD2ckl17i6r8clx9Td7HQO+LRZNu
         dtb/q+wOCZB3Vgwv93z1sA2T7XxvqnAhuYSYY07QVzsC4+vr7dhehPEpn2I5Ua4ITJcK
         XgqAkXTk9sJZramYknxEyVTAsk4oZMu8g+Al29LmRTzB35aGlf/ilFhAep6DxK+HsTY4
         8mhnWDOKbft8Kw01CSTQGtIuBUFjAbdPwSegMlMZxynLHEVKzaizCC9bfFvCgoA8p6WT
         QMQA==
X-Forwarded-Encrypted: i=1; AJvYcCWlvYrqp+D7qSfLmolrsSfSLE6/lRZgjjsnD1xuIkyUFDjuwEimAVLgHXSsJyBTu3k5W/kFAcGR1x9XTcKDlen364xAujJzuwstAoJ3nNkwzpocZoJB5Tt7+5o4ZFnn6k3ssQneMxt8Y+Y1Wigyk6N7ha67RoW4Bp4PU9GfSFfU/JkM3O+hUtdLtLaQwsHIm8Si4WoH/l+iPZUxOSE16ABA
X-Gm-Message-State: AOJu0YxfG6lWPvg+JdugWh4tkyfSmJOML739JgMDrLj2PqXPbxs86r6l
	kToJ1efyQyzhAvF4YfsjuXZxHnPtLsa3g2GM4gpbVb+SJRlWLd3sS+PnzgD0kk0VYX9DcS6NiKZ
	cszw0wRIwbisIzJ99JYTsY3Gt8L0=
X-Google-Smtp-Source: AGHT+IGrz1woRCdFcf3AU1cz6WnokARNZ8npr64xqniUVjK159lEQjZ0EsGdSQw2I8QF6WpZIMde7xJ4DnI207ISe+Y=
X-Received: by 2002:a05:620a:2484:b0:7a1:dc64:59db with SMTP id
 af79cd13be357-7a377ba35c1mr531954785a.8.1723049308726; Wed, 07 Aug 2024
 09:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805073425.3492078-1-jacobe.zang@wesion.com>
 <20240805073425.3492078-5-jacobe.zang@wesion.com> <2e38c2bd-2cb2-4104-97ad-0355069606c0@gmail.com>
 <b6551bf0-2ee9-4b79-af68-0677e3f0f915@broadcom.com>
In-Reply-To: <b6551bf0-2ee9-4b79-af68-0677e3f0f915@broadcom.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 7 Aug 2024 19:48:17 +0300
Message-ID: <CABjd4YzEzDW6KhTJ1ZBU1PptHotgDqg8i03Z7VAfdzAgQo8BDw@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] wifi: brcmfmac: Add optional lpo clock enable support
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Jacobe Zang <jacobe.zang@wesion.com>, 
	robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	conor+dt@kernel.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	nick@khadas.com
Content-Type: text/plain; charset="UTF-8"

On 07/08/2024 2:17 pm, Arend van Spriel wrote:
> On 8/7/2024 1:10 AM, Alexey Charkov wrote:
>> Hi Jacobe,
>>
>> On 05/08/2024 10:34 am, Jacobe Zang wrote:
>>> WiFi modules often require 32kHz clock to function. Add support to
>>> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
>>> to the top of brcmf_of_probe. Change function prototypes from void
>>> to int and add appropriate errno's for return values that will be
>>> send to bus when error occurred.
>>>
>>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>>> ---
>>>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +++
>>>   .../broadcom/brcm80211/brcmfmac/common.c      |  6 +++-
>>>   .../wireless/broadcom/brcm80211/brcmfmac/of.c | 28 +++++++++++++------
>>>   .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +++---
>>>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
>>>   .../broadcom/brcm80211/brcmfmac/sdio.c        | 18 ++++++++----
>>>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>>>   7 files changed, 52 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/
>>> bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> index 13391c2d82aae..ee3ca85c4a47b 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> @@ -951,6 +951,10 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev
>>> *sdiodev)
>>>           ret = -ENODEV;
>>>           goto out;
>>>       }
>>> +    if (IS_ERR(sdiodev->bus)) {
>>> +        ret = PTR_ERR(sdiodev->bus);
>>> +        goto out;
>>> +    }
>>
>> Maybe return -ENODEV error pointer instead of NULL from
>> brcmf_sdio_probe as the default for the fail path? Then you can
>> condense these two checks into one
>
> Sound reasonable.
>
>>>       brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
>>>   out:
>>>       if (ret)
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/
>>> common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>>> index b24faae35873d..6c5d26f9b7661 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>>> @@ -561,8 +561,12 @@ struct brcmf_mp_device
>>> *brcmf_get_module_param(struct device *dev,
>>>       if (!found) {
>>>           /* No platform data for this device, try OF and DMI data */
>>>           brcmf_dmi_probe(settings, chip, chiprev);
>>> -        brcmf_of_probe(dev, bus_type, settings);
>>>           brcmf_acpi_probe(dev, bus_type, settings);
>>> +        i = brcmf_of_probe(dev, bus_type, settings);
>>> +        if (i < 0) {
>>> +            kfree(settings);
>>> +            settings = ERR_PTR(i);
>>> +        }
>>
>> This looks wrong. First, you're calling brcmf_of_probe twice. Second,
>> if either DMI or ACPI probe successfully but OF doesn't, then you
>> return an error code instead of success, and also overwrite settings
>> with an error pointer thus rendering both brcmf_dmi_probe and
>> brcmf_acpi_probe useless
>
> Twice? it is removed and added few lines below.

Indeed, time to change glasses :) Didn't see the minus sign

> It does change the order
> so that may not be best thing to do here. We actually only want to
> handle the scenario where the clock resources are not yet available, ie.
> when -EPROBE_DEFER is returned because that error value is taken into
> account by the bus driver and tries to bind the driver again later.

Maybe we then do something like the following, which would retain the
old behavior but pass -EPROBE_DEFER on to the bus:

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873d..6c5d26f9b7661 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -561,8 +561,12 @@ struct brcmf_mp_device
*brcmf_get_module_param(struct device *dev,
        if (!found) {
                /* No platform data for this device, try OF and DMI data */
                brcmf_dmi_probe(settings, chip, chiprev);
-               brcmf_of_probe(dev, bus_type, settings);
+               if (brcmf_of_probe(dev, bus_type, settings) == -EPROBE_DEFER)
+                       return ERR_PTR(-EPROBE_DEFER);
                brcmf_acpi_probe(dev, bus_type, settings);
        }
        return settings;
 }

>>>       }
>>>       return settings;
>>>   }
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> index e406e11481a62..5f61363fb5d0e 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> @@ -6,6 +6,7 @@
>>>   #include <linux/of.h>
>>>   #include <linux/of_irq.h>
>>>   #include <linux/of_net.h>
>>> +#include <linux/clk.h>
>>>   #include <defs.h>
>>>   #include "debug.h"
>>> @@ -65,17 +66,21 @@ static int brcmf_of_get_country_codes(struct
>>> device *dev,
>>>       return 0;
>>>   }
>>> -void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>>> -            struct brcmf_mp_device *settings)
>>> +int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>>> +           struct brcmf_mp_device *settings)
>>>   {
>>>       struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>>>       struct device_node *root, *np = dev->of_node;
>>> +    struct clk *clk;
>>>       const char *prop;
>>>       int irq;
>>>       int err;
>>>       u32 irqf;
>>>       u32 val;
>>> +    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>>> +        return 0;
>>> +
>>
>> return 0 implies this function has completed successfully, while in
>> this case it's obviously returned early due to not finding the correct
>> device in DT. -ENODEV perhaps?
>
> This was a void function so returning 0 retains the behavior as before,
> which is important to keep in mind here.
>
> This function will be called if the platform has CONFIG_OF enabled.
> However, that does not mean that on every platform there is a node
> defined for the struct device being probed. That is fine if it does not
> require any DT properties to be functional. Hence we bail out here
> without an error.

Fair enough, thanks for the explanation!

Best regards,
Alexey


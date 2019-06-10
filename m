Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0743BCB9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfFJTQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 15:16:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39949 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfFJTQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 15:16:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id x24so9406661otp.7
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2019 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7P531d2d0gpB2ASoFjetGciu0ab+IBnMPwAqjsJnS+s=;
        b=DZFHQIRb6wAdfFbjOsdmNQnx2u+r7RXgZGU31J/IjYDN/+T31WuCIR+rr4AptslvsK
         9Ow+tnrbN3zMIds7eS7IvraO5rJz4utAM/QmFa2OE2FXFkVv8CzEleJ21uXtel1D6+QV
         WO0z2lY2RJkzAMP+fWPPS1t2ARTudGJ9awT5bF82jVxzaO3G4bz1zaoJApp1doID52W9
         jvchLkB48+9G6BEiJOWYtte1fn9/s5/cJvR7Q/dtfYiEv/u7KkQRJrLpCim2+4SQDBan
         /sFbu8hquOgHqbXmErIBt0B7VZpNCXE0wQUYei99KSye00k4/Yolhld16/lPfT/Zr0Rg
         D8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7P531d2d0gpB2ASoFjetGciu0ab+IBnMPwAqjsJnS+s=;
        b=k3KnQz4neEKorjkmWQ8KCe9Y8wislvwzNEthcPdO9+bAJA2CSC+XragfHUzvKfDIra
         /RYDEtHHKXNJTXdFopCNlVSFPi2wUdWiNEkNxhNgKRmpZyJbNH0k9jYj2Y+MfAWXCcS4
         JOKvKEsC1SKw47mXMIhRCXBqdxzABcJ/Z9kr+poD+xk6hAO+vbizT0voeogdaY/VMdhy
         KRqamtQ5lHHzJBHznRUegVaKH2MLVV293otwjZwjPo2wHDRsiMdAfIQvaRMGpYWWzhND
         shs6GOITkdyo0042Lgw2N0xsLLWMeMRCIvtxlBgtYJYmt/p1waBTd3LqqkIR2fXzwViZ
         ujuw==
X-Gm-Message-State: APjAAAWUIkkXUvqV8Rx0ZQIBWdfVqV6fnqxeJrSimJhP7HE1/ZWhoL3e
        7oxV4sEQ6Poczpz6Ogth5bY8vivD
X-Google-Smtp-Source: APXvYqz0s3U77LU2HLUXz0eLVTAGokKApo1JndclZJbmkfcbLM2Imw9FWWpHGoR5l4nOvyNUmdI2Hg==
X-Received: by 2002:a9d:5d10:: with SMTP id b16mr985607oti.35.1560194197065;
        Mon, 10 Jun 2019 12:16:37 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id i5sm4279037otf.26.2019.06.10.12.16.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 12:16:36 -0700 (PDT)
Subject: Re: [PATCH] ssb/gpio: Remove unnecessary WARN_ON from driver_gpio
To:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     H Buus <ubuntu@hbuus.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <946c86bf-7e90-a981-b9fc-757adb98adfa@hbuus.com>
 <20190610204927.2de21c9a@wiggum>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <de857b70-fbc2-9c29-b31e-d544a33c8ced@lwfinger.net>
Date:   Mon, 10 Jun 2019 14:16:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610204927.2de21c9a@wiggum>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/10/19 1:49 PM, Michael Büsch wrote:
> The WARN_ON triggers on older BCM4401-B0 100Base-TX ethernet controllers.
> The warning serves no purpose. So let's just remove it.
> 
> Reported-by: H Buus <ubuntu@hbuus.com>
> Signed-off-by: Michael Büsch <m@bues.ch>
> 
> ---

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

> 
> diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
> index e809dae4c470..66a76fd83248 100644
> --- a/drivers/ssb/driver_gpio.c
> +++ b/drivers/ssb/driver_gpio.c
> @@ -460,9 +460,6 @@ int ssb_gpio_init(struct ssb_bus *bus)
>   		return ssb_gpio_chipco_init(bus);
>   	else if (ssb_extif_available(&bus->extif))
>   		return ssb_gpio_extif_init(bus);
> -	else
> -		WARN_ON(1);
> -
>   	return -1;
>   }
>   
> @@ -472,9 +469,6 @@ int ssb_gpio_unregister(struct ssb_bus *bus)
>   	    ssb_extif_available(&bus->extif)) {
>   		gpiochip_remove(&bus->gpio);
>   		return 0;
> -	} else {
> -		WARN_ON(1);
>   	}
> -
>   	return -1;
>   }
> 


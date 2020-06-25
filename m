Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3148520A3B9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406673AbgFYRJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 13:09:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52171 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404794AbgFYRJ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 13:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593104964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5CfCap0F3wZuekOuBaQ6nE/M+wEkk6ovUVrJUS5pGSM=;
        b=ipf6+WdyDvGjXi0vDOqnHkp767cXCwHV0q/KjLSAIO2ra3sRFBx55YscUpmYV1G1CQCV0O
        ljfCwPcxkQcWeCgl8BRWdN5r/MBBh9gxngP6aDjLuC9BJCkJLpgW8cXPFO18v0E1xW5TT7
        PYlDYWVrPgufc8d69pdTPtf3FIwS6rA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-SwBhnyQwOFuppw1Z8SeU9A-1; Thu, 25 Jun 2020 13:09:22 -0400
X-MC-Unique: SwBhnyQwOFuppw1Z8SeU9A-1
Received: by mail-ed1-f72.google.com with SMTP id da18so5324714edb.13
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 10:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5CfCap0F3wZuekOuBaQ6nE/M+wEkk6ovUVrJUS5pGSM=;
        b=I56DhHkYy+5x8Be9BANxlYRR1PQxukLCS0SqNTIySVyBkRiow9TnSnVL5EqKxs2zt+
         Uj/t/dZ4xIMVjCs1Nfiwc+pGeYaAlqcGBMgOrkcqkH4W/PL4xNT4Tyk7cOJMfeJ0qezo
         4ljV7QHFvg6V6A06odEPrC7yJwD1qHM263PvDY8xco9BHrrXlJbYBhmr36uC1/A0Rzex
         d5MKxCMV5Nkuc8ywbOPrRXB8kiu5strQ+Lwfcwx3ysfMgVUCwsqDCakZZ2QYF62js8aq
         TQECoBBATttoft3QFJxZ6IIf1lljdYQHx+w/GpYTSC9NQKGdMWe7QCxJpMrsS1k1B5Xd
         1cpQ==
X-Gm-Message-State: AOAM5338VJZF5T5GoDAie4C91wnvEDZFu4V9JGApyCYoVgDoMNlcNIhG
        RNLFIBRVFCmiwU9KwCkN17GgLwl9ST+UgG8E8dW/07uL7LjA0NusiKn6d1pYiz0tntWmlSx65Tz
        6hKTqeaMg/9y+FcnUY+lvW3pqQ3w=
X-Received: by 2002:a50:9f6a:: with SMTP id b97mr7418231edf.322.1593104961250;
        Thu, 25 Jun 2020 10:09:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZTjd/YE7d5FmBNF9ZnN/QkhB3RzdoBfx/jxbtUHsAmF7gle9idP0YebzTqxtW7V6HeE10/w==
X-Received: by 2002:a50:9f6a:: with SMTP id b97mr7418199edf.322.1593104961004;
        Thu, 25 Jun 2020 10:09:21 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id e20sm17061524ejh.22.2020.06.25.10.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 10:09:20 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: Transform compatible string for FW loading
To:     matthias.bgg@kernel.org, arend.vanspriel@broadcom.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chi-hsien.lin@cypress.com, wright.feng@cypress.com,
        mbrugger@suse.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200625160725.31581-1-matthias.bgg@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <389d35d9-fb94-b5fd-7b87-9511dacad0b2@redhat.com>
Date:   Thu, 25 Jun 2020 19:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625160725.31581-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 6/25/20 6:07 PM, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The driver relies on the compatible string from DT to determine which
> FW configuration file it should load. The DTS spec allows for '/' as
> part of the compatible string. We change this to '-' so that we will
> still be able to load the config file, even when the compatible has a
> '/'. This fixes explicitly the firmware loading for
> "solidrun,cubox-i/q".
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>   .../wireless/broadcom/brcm80211/brcmfmac/of.c  | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index b886b56a5e5a..8a41b7f9cad3 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -17,7 +17,6 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   {
>   	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>   	struct device_node *root, *np = dev->of_node;
> -	struct property *prop;
>   	int irq;
>   	u32 irqf;
>   	u32 val;
> @@ -25,8 +24,21 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   	/* Set board-type to the first string of the machine compatible prop */
>   	root = of_find_node_by_path("/");
>   	if (root) {
> -		prop = of_find_property(root, "compatible", NULL);
> -		settings->board_type = of_prop_next_string(prop, NULL);
> +		int i;
> +		char *board_type;
> +		const char *tmp;
> +
> +		of_property_read_string_index(root, "compatible", 0, &tmp);
> +
> +		/* get rid of '/' in the compatible string to be able to find the FW */
> +		board_type = devm_kzalloc(dev, strlen(tmp), GFP_KERNEL);

strlen() needs to be strlen() + 1 here to make place for the terminating zero.

> +		strncpy(board_type, tmp, strlen(tmp));

Please do not us strncpy, it is THE worst strcpy function
in existence, it does not guarantee 0 termination, so
it sucks, it sucks a lot do not use, thanks.

Instead use strlcpy or snprintf(..., "%s", ...)

> +		for (i = 0; i < strlen(board_type); i++) {

(The strlen here relies on there being a 0 behind the memory you
allocated because of the missing + 1)

> +			if (board_type[i] == '/')
> +				board_type[i] = '-';
> +		}
> +		settings->board_type = board_type;
> +
>   		of_node_put(root);
>   	}
>   
> 

Otherwise this looks good to me.

Regards,

Hans


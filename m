Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F72210AC7
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2020 14:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgGAMMw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jul 2020 08:12:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21836 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730161AbgGAMMv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jul 2020 08:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593605569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XaTa3j8pv7Vv7FPlkaiUQ9sgC3qOTtEDpxvgOBhKsTg=;
        b=DpG3pRor7cYmlHLuW4BGzwHPpOWANYV9NjgYu/qvl7f+LhbfdydzptXwAq3GvMDVPbOCqh
        QV2oFLtpOH+iZTTodmB0vaeeI0MDj7xRUDUEFBPiMnx0oHTu5QcNMPts6YTm35Drx3gkd7
        5Y9ASU4djVI9aDoypnTCLd0raDkLt38=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-KWPipaduPha99ZOxG6Dl9g-1; Wed, 01 Jul 2020 08:12:48 -0400
X-MC-Unique: KWPipaduPha99ZOxG6Dl9g-1
Received: by mail-ed1-f69.google.com with SMTP id b11so10198730edx.10
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2020 05:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XaTa3j8pv7Vv7FPlkaiUQ9sgC3qOTtEDpxvgOBhKsTg=;
        b=J8qwl/Ctg4QpJ36dgX2+rKEGmBopkXRusiJ8hs2G90ViZUwoiqE1TpzQIaVCvMKTYy
         cVCTkWTJZFwlgjlJKsh5eiU2J3Z41Id2WSj3WRbp3FcMzodDJ8fUOAM446kBqJdTZOj8
         iwCwJgCUUAEavopj3PiYZQmciro4s9Qo8HX7KKIGtOVfAgeRiFpLQLWpwTzlrgwTEIom
         nbTdrxae8q5Xb36yDPfshhnwnFZ2535nKbGm1bVmarkM60182W4MpXkZhSPmAUgbBpMm
         9EYK9Cd87leif3kUtC2CrfiOGpEFTv5kZ6NSpgT7zOCIVcZUkayj0f70w1aNxJ/7XZ9R
         xchg==
X-Gm-Message-State: AOAM531anxAn0vDatKt8aT/BC7QQZD9ej0A8yKMXFofAQHU5A6WWM0WU
        zffa8kV6bKHAnDBSZ/uF+4XtsmNM36yQc86SgiSmFYPv+TN0F2XXrN5Ngt+ygCxeAkLtgtepHHh
        lo9N4oCuO1+awsLttMBGI0thPckg=
X-Received: by 2002:aa7:d3c8:: with SMTP id o8mr21964623edr.294.1593605567541;
        Wed, 01 Jul 2020 05:12:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybKmn9TXwxpznNvmXkc/EDdW74VObauZauv68Wmlu4ixsBkY7JPtu25PXyzIRbA9DwPCxw9g==
X-Received: by 2002:aa7:d3c8:: with SMTP id o8mr21964601edr.294.1593605567361;
        Wed, 01 Jul 2020 05:12:47 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id cz2sm5763973edb.82.2020.07.01.05.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 05:12:46 -0700 (PDT)
Subject: Re: [PATCH v3] brcmfmac: Transform compatible string for FW loading
To:     matthias.bgg@kernel.org, arend.vanspriel@broadcom.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     brcm80211-dev-list.pdl@broadcom.com, mbrugger@suse.com,
        netdev@vger.kernel.org, chi-hsien.lin@cypress.com,
        linux-wireless@vger.kernel.org, hante.meuleman@broadcom.com,
        linux-kernel@vger.kernel.org, wright.feng@cypress.com,
        brcm80211-dev-list@cypress.com, franky.lin@broadcom.com
References: <20200701112201.6449-1-matthias.bgg@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eaf0f098-c73c-10b5-2d75-b35a5fc8dbb4@redhat.com>
Date:   Wed, 1 Jul 2020 14:12:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701112201.6449-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 7/1/20 1:22 PM, matthias.bgg@kernel.org wrote:
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
> 
> ---
> 
> Changes in v3:
> - use len variable to store length of string (Hans de Goede)
> - fix for loop to stop on first NULL-byte (Hans de Goede)
> 
> Changes in v2:
> - use strscpy instead of strncpy (Hans de Goede)
> - use strlen(tmp) + 1 for allocation (Hans de Goede, kernel test robot)

v3 looks good to me:

Reviewed-by: Hans deGoede <hdegoede@redhat.com>

Regards,

Hans


> 
>   .../wireless/broadcom/brcm80211/brcmfmac/of.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index b886b56a5e5a..a7554265f95f 100644
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
> @@ -25,8 +24,22 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   	/* Set board-type to the first string of the machine compatible prop */
>   	root = of_find_node_by_path("/");
>   	if (root) {
> -		prop = of_find_property(root, "compatible", NULL);
> -		settings->board_type = of_prop_next_string(prop, NULL);
> +		int i, len;
> +		char *board_type;
> +		const char *tmp;
> +
> +		of_property_read_string_index(root, "compatible", 0, &tmp);
> +
> +		/* get rid of '/' in the compatible string to be able to find the FW */
> +		len = strlen(tmp) + 1;
> +		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> +		strscpy(board_type, tmp, len);
> +		for (i = 0; i < board_type[i]; i++) {
> +			if (board_type[i] == '/')
> +				board_type[i] = '-';
> +		}
> +		settings->board_type = board_type;
> +
>   		of_node_put(root);
>   	}
>   
> 


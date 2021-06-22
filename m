Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEEE3B01B9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 12:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFVKu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 06:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230039AbhFVKuX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 06:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624358887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0buC7lbynvX5/in4z4I52ozFnZpiaDrJ78DyP4/2luc=;
        b=Xqhv6JUOxln5N6IWyeZ8AKXXVwTtSraF3MF5hQtMsVhzUpiMG0MgjjwcsQZnUGYk4ZLiNd
        Gnvvnd9jV8joOsXoNoTjqKfXtFCuXOI3LqUm8yZtaIPYBQHLcF8qyeEphlgaOYVkMV1IXj
        nbujLJHxjHnw096BI9Ml+ajLW2g8F4c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-38hIRUqKOqueWs8SDWTzDg-1; Tue, 22 Jun 2021 06:48:06 -0400
X-MC-Unique: 38hIRUqKOqueWs8SDWTzDg-1
Received: by mail-ej1-f70.google.com with SMTP id o12-20020a17090611ccb02904876d1b5532so4413583eja.11
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 03:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0buC7lbynvX5/in4z4I52ozFnZpiaDrJ78DyP4/2luc=;
        b=nkHa5g6bZTFXOjRBSBEJ4xtzdFXpoKIPvqKDLyUyGu0Wg9gh6J6xDKlfhhG7aQV7oU
         t362Skkoi/qhwfdSTbd+tl4Ha326VJ1fXnPI8q4Ja5F9q5GTHZPlrFJArp3sC0XmD9TR
         oNx8qGGd/GRceToz1nAopeJWltcqVueLOJhTLs9+DOiYQLFhHDDMchlf1lRsxsreMmg3
         epc/1Fu/Ff7x9aQLvdg+8KyD9T2vHUmOpibn1tE5/W/FwFZF80KSyN1Hi4ORk7xlk3ah
         i9cnYP3RfHzDfB3640lEULrg1XCS9TVEvkgI0BboS61bBgy/8fQv6icVM66jsMGDA3FN
         9PxA==
X-Gm-Message-State: AOAM532k4XbUURGr76t/eltwler9BAbox2frIdEPN1yqt7KtrHfjYlbs
        WZ/W9itPI8wEuF9YXYsQVdulJAI3w1OCVkji70aQ7m3X3cRADj9CMelZYjSMSRLGMAq9/FnW77I
        WDDoIAol9J3Z08dXUFFj2NEMQnjA=
X-Received: by 2002:a17:907:9710:: with SMTP id jg16mr3289910ejc.366.1624358885019;
        Tue, 22 Jun 2021 03:48:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5aileWLe99V+/CdAHlgVBA0BpV3jxEyL4HHasBcfoPeDcjOMaX+P4AwPUtgs/eaMc3SkZmg==
X-Received: by 2002:a17:907:9710:: with SMTP id jg16mr3289894ejc.366.1624358884849;
        Tue, 22 Jun 2021 03:48:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i17sm1735415ejo.63.2021.06.22.03.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 03:48:04 -0700 (PDT)
Subject: Re: [PATCH v3] brcmfmac: fix "board_type" in brcmf_of_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, kernel-janitors@vger.kernel.org
References: <YNCHELb14+eNV94n@mwanda>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cb3b73ad-919a-1087-b3a0-c2e02b29eb0a@redhat.com>
Date:   Tue, 22 Jun 2021 12:48:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNCHELb14+eNV94n@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 6/22/21 12:46 PM, Dan Carpenter wrote:
> There are two bugs here:
> 1) devm_kzalloc() needs to be checked for allocation errors.
> 2) The loop was intended to be:
> 
>  Bad:	for (i = 0; i < board_type[i]; i++) {
> Good:	for (i = 0; i < len; i++) {
> 
> Neither of these bugs are likely to cause an issue in practice but
> they're worth fixing.  Also the code could be made simpler by using the
> devm_kstrdup() and strreplace() functions.
> 
> Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reported-by: Hans deGoede <hdegoede@redhat.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> v2: Basically a completely different patch.  :)
> v3: Add missing of_node_put() caught by Hans de Goede
> 
>  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index a7554265f95f..dee3d968e49b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -24,20 +24,18 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>  	/* Set board-type to the first string of the machine compatible prop */
>  	root = of_find_node_by_path("/");
>  	if (root) {
> -		int i, len;
>  		char *board_type;
>  		const char *tmp;
>  
>  		of_property_read_string_index(root, "compatible", 0, &tmp);
>  
>  		/* get rid of '/' in the compatible string to be able to find the FW */
> -		len = strlen(tmp) + 1;
> -		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> -		strscpy(board_type, tmp, len);
> -		for (i = 0; i < board_type[i]; i++) {
> -			if (board_type[i] == '/')
> -				board_type[i] = '-';
> +		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
> +		if (!board_type) {
> +			of_node_put(root);
> +			return;
>  		}
> +		strreplace(board_type, '/', '-');
>  		settings->board_type = board_type;
>  
>  		of_node_put(root);
> 


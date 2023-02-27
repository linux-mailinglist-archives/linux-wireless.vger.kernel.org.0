Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A9A6A4BD9
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 20:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjB0T7i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 14:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjB0T7h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 14:59:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8BD2748E
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 11:59:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i34so30590706eda.7
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCUXuXRGkZYhDuDkwhujplgwxkshtVWtdbwS+60Jyi4=;
        b=XYa06zGERt1jknn6HDKjrIZngdVvGjGQmNZXaY98O4Do070NWxo10EB50D3y8bmNu3
         WbqViVi9Z+9ZaZ0iYeor2gyssBN7DYfno639aybhRpO/nWAO1OZae8inei+SekispSbg
         T6yCjSM/8LVf29WnZeB13UZHgvmIrxXA8925FizylMYmjx+SiKcY9VC83BQLPISnYidg
         NJhedfjfe15h4ot1tdw9SIzApW7hfpvEXM5mRNTLPGpjQNGVItD9ea0fxXojcOi8GVG1
         hRig9MH0GkRu5M8zLtPKVLxTQI3hi1YJf+CLpwkdWXCJSaSm1lpdg73bcREFtv9aEO0+
         aRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCUXuXRGkZYhDuDkwhujplgwxkshtVWtdbwS+60Jyi4=;
        b=fJaAMfCvrPd3hjsgnu/DESaCsUnnDI71fJnRrBmb1i1ALkbXOLe8NOlbMuD4RhzyyC
         RGGUCd1Rkp2eBsKkfU4u+X16UhmmJSji6EU3dg/Aqrdowgtx/gHTybNZZR/xbJod7lCS
         9qSDYGSAoCc4ncYgFg43Pl7SstJ/Umf9RMRsZd0PqRHz3YrH/zgUssDOlyNp6cpnuYQC
         I1mH3l+oxpmkWqWni510S6MtDvnB2+qqlwyeus1o/Dk4Qi5qdKWqFMbZvCoRaBFkFofO
         Vbec3rXYfFvC7GPNIF28pO8maRRuFSd1IGIKCZbLHDeXjacxALDMZCVV8BJK5KFK10YO
         +7+g==
X-Gm-Message-State: AO0yUKXw7+wUHjEJgHuJfvKeK3JofSbFFymjAGlZwGSHfUJ0FGd9i8Ys
        aSFqAutZxkZUaCw4BZd9tpI=
X-Google-Smtp-Source: AK7set8GEI3c09Drwa3E4oxx/22rr3nhu0i6380dAAoUkCSeTAZQ3Khjt47yBwAOxqQMw7ZJA/8WBg==
X-Received: by 2002:a17:906:2446:b0:8af:a53a:189d with SMTP id a6-20020a170906244600b008afa53a189dmr34919696ejb.44.1677527968122;
        Mon, 27 Feb 2023 11:59:28 -0800 (PST)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id r30-20020a50d69e000000b004acc5077026sm3541233edi.79.2023.02.27.11.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 11:59:27 -0800 (PST)
Message-ID: <63f72045-e51d-d9a4-a0ed-c221bcdcee03@gmail.com>
Date:   Mon, 27 Feb 2023 20:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix potential slab-out-of-bounds read
 in brcmf_inform_single_bss()
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
        linux-wireless@vger.kernel.org
Cc:     arend.vanspriel@broadcom.com, dokyungs@yonsei.ac.kr,
        jisoo.jang@yonsei.ac.kr, kernel test robot <lkp@intel.com>
References: <20221116145821.544266-1-linuxlovemin@yonsei.ac.kr>
Content-Language: en-US
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20221116145821.544266-1-linuxlovemin@yonsei.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/16/2022 3:58 PM, Minsuk Kang wrote:
> This patch fixes a slab-out-of-bounds read in brcmfmac that occurs in
> cfg80211_find_elem_match() called from brcmf_inform_single_bss() when
> the offset and length values of information elements provided by the
> device exceed the boundary of the escan buffer that contains information
> elements. The patch adds a check that makes the function return -EINVAL
> if that is the case. Note that the negative return is handled by the
> caller, brcmf_inform_bss().

[...]

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> ---
> v1->v2: Use the correct format for size_t in bphy_err()
> 
>   .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index ae9507dec74a..2148027eb42b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -3298,6 +3298,13 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
>   	notify_ielen = le32_to_cpu(bi->ie_length);
>   	bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
>   
> +	if ((unsigned long)notify_ie + notify_ielen -
> +		(unsigned long)cfg->escan_info.escan_buf > BRCMF_ESCAN_BUF_SIZE) {
> +		bphy_err(drvr, "Invalid information element offset: %u, length: %zu\n",
> +			 le16_to_cpu(bi->ie_offset), notify_ielen);
> +		return -EINVAL;
> +	}
> +

Maybe this works, but it was not immediately obvious to me. Also this 
seems late in processing the scan results. Better catch it early and 
check the ie_offset and ie_length values in 
brcmf_cfg80211_escan_handler() when processing the partial result event. 
It already checks bi->length there so add a check there:

	bss_ie_offset = le16_to_cpu(bi->ie_offset);
	bss_ie_length = le16_to_cpu(bi->ie_length);
	if (bi->ie_offset + bi->ie_length > bi->length) {
		bphy_err(drvr, "Ignoring invalid information element offset: %u, 
length: %zu\n"
			 bss_ie_offset, bss_ie_length);
		goto exit;
	}

Regards,
Arend

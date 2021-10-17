Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38E84305D4
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 03:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbhJQB2M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Oct 2021 21:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhJQB2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Oct 2021 21:28:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F3BC061765
        for <linux-wireless@vger.kernel.org>; Sat, 16 Oct 2021 18:26:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g39so1340503wmp.3
        for <linux-wireless@vger.kernel.org>; Sat, 16 Oct 2021 18:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rr3qZDMIl7pagGIdYlcp6tST/QiEXlZiT685jKY0/+k=;
        b=OaalqhZEoWKxxtK2vLxQOE8a/ldnypSOmIGbuHmwCpFDDPStGgVYZOeZUQuW6OOVgs
         LLjzHUaEEemXt0SyvpgD4r1j1YNULj6IJ0HIFV3yuLDCQT+SAfQMRQZDYaNSkrHb2Tce
         eO+0FNP5a2kiGNbd4SINZybgeacXQ38daeqc/WOo8W7XDWVWTMuzRXYNYohqhL727ASp
         yod/8kU7G9EGfiPt1GDNi4Rbr53+a1TJ7KbCgDNF5XmYaAU9o4WFxdhOAmJCR+jgpPgh
         z5lGi8uoePzM69zMCpzf/nA76S5PIFxNOmnQ1gG+D0C4Z8XWm8lpqQLaKZNM1ukIIeSo
         L5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rr3qZDMIl7pagGIdYlcp6tST/QiEXlZiT685jKY0/+k=;
        b=md8pN0XfUExHu8ycX/8jiIyUhs3Td9TiMzEnmhcnGnGqwHBDdvbWlYI32wVlUb0Qnk
         rvEzCNSX1WSB8x6hwlbkq+1KX2FlXGjSjCKp6rk+7uSlAmUyU8Np3XssV5KXCYkXuPhh
         60rlvd74LaiSq1oy8zc31+XtJyVi0bfX1QiO9iP75ypG1dXu+GrAfPeg8WGRSIvTDyUN
         7jAvB1OieWswCvEtpQXQNCn3+EuSRh6XgPq+zd/vjoxTQ0+VQ+S5+yZGuthd30Xx6yvp
         odJZVB/CKvwCHVLsBZAXXlpq97oK+z1CGowc0vBTP+GESwEWtdf5h3vZ6Lsiaf926tV2
         MOsg==
X-Gm-Message-State: AOAM531cOJDxlXmOrRe4KNzI9JNq0qwO2yNEmXz5CXxcdzCf4ZtjjHMe
        yOdfu3bM86OpV5iPLlkWTJZtRQ==
X-Google-Smtp-Source: ABdhPJy/OwjLXQt1D42GAu1qBOdD08h2UIBxd/0omIDBUwqkENUoiQcHydycMLFWJvGZOVRGz768Nw==
X-Received: by 2002:a1c:1dcb:: with SMTP id d194mr34183303wmd.161.1634433961231;
        Sat, 16 Oct 2021 18:26:01 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g25sm8571871wrc.88.2021.10.16.18.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 18:26:00 -0700 (PDT)
Message-ID: <86d286ad-2790-fa03-d879-a79101bd1ae9@linaro.org>
Date:   Sun, 17 Oct 2021 02:28:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 4/4] wcn36xx: Put DXE block into reset before freeing
 memory
Content-Language: en-US
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org
References: <20211015131741.2455824-1-bryan.odonoghue@linaro.org>
 <20211015131741.2455824-5-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20211015131741.2455824-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 15/10/2021 14:17, Bryan O'Donoghue wrote:
> When deiniting the DXE hardware we should reset the block to ensure there
> is no spurious DMA write transaction from the downstream WCNSS to upstream
> MSM at a skbuff address we will have released.
> 
> This is actually a pretty serious bug. Immediately after the reset we
> release skbs, skbs which are from the perspective of the WCNSS DXE still
> valid addresses for DMA.
> 
> Without first placing the DXE block into reset, it is possible for an
> upstream DMA transaction to write to skbs we have freed.
> 
> We have seen some backtraces from usage in testing on 50k+ devices which
> indicates an invalid RX of an APs beacon to unmapped memory.
> 
> The logical conclusion is that an RX transaction happened to a region of
> memory that was previously valid but was subsequently released.
> 
> The only time such a window of opportunity exists is when we have
> deallocated the skbs attached to the DMA BDs in other words after doing
> wcn36xx_stop().
> 
> If we free the skbs on the DMA channel, we need to make sure we have
> quiesced potential DMA on that channel prior to freeing.
> 
> This patch should eliminate that error.
> 
> Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/net/wireless/ath/wcn36xx/dxe.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
> index e89002502869a..56f605c23f36c 100644
> --- a/drivers/net/wireless/ath/wcn36xx/dxe.c
> +++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
> @@ -1020,6 +1020,8 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
>   
>   void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
>   {
> +	int reg_data = 0;
> +
>   	/* Disable channel interrupts */
>   	wcn36xx_dxe_disable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_H);
>   	wcn36xx_dxe_disable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_L);
> @@ -1035,6 +1037,10 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
>   		wcn->tx_ack_skb = NULL;
>   	}
>   
> +	/* Put the DXE block into reset before freeing memory */
> +	reg_data = WCN36XX_DXE_REG_RESET;
> +	wcn36xx_dxe_write_register(wcn, WCN36XX_DXE_REG_CSR_RESET, reg_data);
> +
>   	wcn36xx_dxe_ch_free_skbs(wcn, &wcn->dxe_rx_l_ch);
>   	wcn36xx_dxe_ch_free_skbs(wcn, &wcn->dxe_rx_h_ch);
>   
> 

Johannes asked me separately if we need to wait for the quiesence to 
complete.

I don't see that downstream but, that doesn't mean we shouldn't do it.

So I'll investigate that.

Also - now that I look at this code, this being the second usage of the 
CSR_RESET like this, also means the reset can be functionally decomposed 
into a routine.

So - I'll look into the first and definitely do the second as a V2

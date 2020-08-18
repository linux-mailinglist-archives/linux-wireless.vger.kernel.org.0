Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16940248CED
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHRR1Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 13:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgHRR1X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 13:27:23 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CDCC061389
        for <linux-wireless@vger.kernel.org>; Tue, 18 Aug 2020 10:27:22 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f24so23054595ejx.6
        for <linux-wireless@vger.kernel.org>; Tue, 18 Aug 2020 10:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6LD9PAOL1f1Dfb178OriVTBmJhiThI8gQx/RZRqDO6g=;
        b=OUFChZeShZykfMjN2taP9zUynyZplFZ7DX5WnIev6Gf04Yy1ExKRg+ZmoLgviooiVb
         Y49TsvVtaVqvcHTldDd7cZXhLXWDbZoHuhK/1RRjH80c376iVD0WeaOqJHHgRgboWFWT
         9pn0C0TRaB4UsaTpdMVQ1uMHzG7UhJEc49oP+fu/5xDktxEbjoGhsxCQj8VSSI+V3O8c
         EiE0fFYi9/LX+HQuTpux02wWkVeEcvCgJ51xveW6gorw1ce8+G853EySAO93xtVwb44N
         cAe5q6xDfoph3PWjnYsmiyZa0d3ZS414csy8WN+HtBSl3ezeq/sP00Z8JthVy+8Z6Y84
         jBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6LD9PAOL1f1Dfb178OriVTBmJhiThI8gQx/RZRqDO6g=;
        b=dGYJKmeMdPRaZt+Hy6t0JpBCxU6UJQmaMkaWxgWnLz10SI8Bn53knBebrGzDl4wcUi
         QAwaSjQU2qgpyv7Z4Rvb7podjDA/vPWbHzBmkEfT7hoLucOGQVJ37ru2soQkE2qnvusQ
         6yfsxLpfkKj9YxdmzC4PWOUzN8R/T2tGE4FPN1IylvzrRNhWNnOKsVAlPURnqDzOa/Gr
         JgYvUa4thcPtOqhfpkQRNmB+2B7WN1PBW1QAhAnRcjMMxU8LwgeWaRmNjupQBxpgm1wm
         ytxOQQ80my+Ks1wWkf1EUAPucPQ5wRNcR5NE+KpRZpiAziti4/6CR9i+e2Aw3K5iFopx
         5Bow==
X-Gm-Message-State: AOAM531ejkoBWxJggGPmu4i5oQoMGRsWJKXQVue8kXFvAmYCxdRP0v3M
        kCARly8X9vx+uvZk+tBj6kZhDV0MzXo=
X-Google-Smtp-Source: ABdhPJwBCShiqoXNXRkQLbd6faYM2vIlf0rhMct4yF7l5p9KxVaRbeJRa56ix4cRGttPfs+zIp5lqQ==
X-Received: by 2002:a17:906:1b04:: with SMTP id o4mr22343766ejg.332.1597771640893;
        Tue, 18 Aug 2020 10:27:20 -0700 (PDT)
Received: from debian64.daheim (pd9e291c8.dip0.t-ipconnect.de. [217.226.145.200])
        by smtp.gmail.com with ESMTPSA id n10sm15999018edo.43.2020.08.18.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 10:27:20 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.94)
        (envelope-from <chunkeey@gmail.com>)
        id 1k85OD-000B8U-AO; Tue, 18 Aug 2020 19:27:13 +0200
Subject: Re: [PATCH] p54: avoid accessing the data mapped to streaming DMA
To:     Jia-Ju Bai <baijiaju@tsinghua.edu.cn>, kvalo@codeaurora.org,
        kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org
References: <20200802132949.26788-1-baijiaju@tsinghua.edu.cn>
From:   Christian Lamparter <chunkeey@gmail.com>
Message-ID: <0b432282-8d52-3004-6648-d97c03cdae28@gmail.com>
Date:   Tue, 18 Aug 2020 19:27:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200802132949.26788-1-baijiaju@tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

sorry. Your mail got flagged by google mail as spam. :(

On 2020-08-02 15:29, Jia-Ju Bai wrote:
> In p54p_tx(), skb->data is mapped to streaming DMA on line 337:
>    mapping = pci_map_single(..., skb->data, ...);
> 
> Then skb->data is accessed on line 349:
>    desc->device_addr = ((struct p54_hdr *)skb->data)->req_id;
> 
> This access may cause data inconsistency between CPU cache and hardware.
> 
> To fix this problem, ((struct p54_hdr *)skb->data)->req_id is stored in
> a local variable before DMA mapping, and then the driver accesses this
> local variable instead of skb->data.

Interesting. Please bear with me here. From my understanding, the 
streaming direction is set to PCI_DMA_TODEVICE. So is it really possible
for the hardware to interfere with the data without the IOMMU catching this?

(That said, patch looks be fine. I'll need to dust off a old PCI PC to 
check this with real hardware, if requested.)

Cheers,
Christian



> 
> Signed-off-by: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
> ---
>   drivers/net/wireless/intersil/p54/p54pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intersil/p54/p54pci.c b/drivers/net/wireless/intersil/p54/p54pci.c
> index 80ad0b7eaef4..f8c6027cab6b 100644
> --- a/drivers/net/wireless/intersil/p54/p54pci.c
> +++ b/drivers/net/wireless/intersil/p54/p54pci.c
> @@ -329,10 +329,12 @@ static void p54p_tx(struct ieee80211_hw *dev, struct sk_buff *skb)
>   	struct p54p_desc *desc;
>   	dma_addr_t mapping;
>   	u32 idx, i;
> +	__le32 device_addr;
>   
>   	spin_lock_irqsave(&priv->lock, flags);
>   	idx = le32_to_cpu(ring_control->host_idx[1]);
>   	i = idx % ARRAY_SIZE(ring_control->tx_data);
> +	device_addr = ((struct p54_hdr *)skb->data)->req_id;
>   
>   	mapping = pci_map_single(priv->pdev, skb->data, skb->len,
>   				 PCI_DMA_TODEVICE);
> @@ -346,7 +348,7 @@ static void p54p_tx(struct ieee80211_hw *dev, struct sk_buff *skb)
>   
>   	desc = &ring_control->tx_data[i];
>   	desc->host_addr = cpu_to_le32(mapping);
> -	desc->device_addr = ((struct p54_hdr *)skb->data)->req_id;
> +	desc->device_addr = device_addr;
>   	desc->len = cpu_to_le16(skb->len);
>   	desc->flags = 0;
>   
> 


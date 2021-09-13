Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740B340A111
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 00:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349934AbhIMWxp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 18:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349980AbhIMWxe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 18:53:34 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D6DC03BFEA
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 15:38:18 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso15583735ota.8
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aOPaxnI6A5tpQcqC0wbRk7yjfq4S2ZS3ZZKpgwCQYUE=;
        b=SBe4NwHKCDPC9icGG5YGMhSLu3SzoKDnqmASyKfuqHsm5DvoIGpoTXds4Rw/IqEkBv
         ZtkRPzkrzxkdV4F1SBbsY72euSNbHMfB95ZH9xUnHXQKYW8CaxmCIXtitpr0R5LX7mwZ
         gvLUpSNdcnS6FIYV7qybQl1WfrSkG3ni36xN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aOPaxnI6A5tpQcqC0wbRk7yjfq4S2ZS3ZZKpgwCQYUE=;
        b=722MnCgG4NtwVlahvIc+rF3EqsElJqL0YhrbDmdg7LZM95fptsxN5S8DGqXp5aPwL4
         t+5dcCAsHwK1WuBF5AKmY/7Yzd5oHMxPlK56SlY8NjRCxBIMplBxFOaUeHRrRcWFS7CO
         gvS9TRVSCuorlhPPQp3GMhlJmF2FK+aTqNyBWzd2akfbDCxPxeBgZxd7auyMLRhbK2wm
         QeR8xbmsqM/Sbv31SVuCk1Pdodd3HbNYXQAZAXZ5W5RF2DueKfOsR7ItIJXuC4olaGug
         176EoS9Djd2As3evF5Ixe1xbQw7s8acrVPU0ziVWKtv7DD3RC3fGp9CA5dyK8RJ/BmG2
         Mvfg==
X-Gm-Message-State: AOAM532uymxRXqMGHdmxz/jE1bpBkTeQr9NNOt5mmI7KHO+5mqOxw7LY
        HoPjUmZFrKeqpWTafSWYhPbxJmM7zPZGqw==
X-Google-Smtp-Source: ABdhPJzDM+jWZqumuY441+jgmfU8S0e0CJ+CcHwwzDZIfwPRjn3Ah9rl0cG53lzl4thRrzt+3P5giA==
X-Received: by 2002:a9d:610d:: with SMTP id i13mr11657871otj.378.1631572696961;
        Mon, 13 Sep 2021 15:38:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:38c5:675f:a482:d150:1965:8294? ([2600:1700:38c5:675f:a482:d150:1965:8294])
        by smtp.gmail.com with ESMTPSA id c24sm2200531otf.71.2021.09.13.15.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 15:38:16 -0700 (PDT)
Subject: Re: [PATCH 1/5] ath11k: Change DMA_FROM_DEVICE to DMA_TO_DEVICE when
 map reinjected packets
To:     Jouni Malinen <jouni@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>
References: <20210913180246.193388-1-jouni@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <e0bae69d-d667-0eba-320a-b40bdfff31bb@eero.com>
Date:   Mon, 13 Sep 2021 15:38:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913180246.193388-1-jouni@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 90da56316e7e..0c27eead3e02 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -3434,7 +3434,7 @@ static int ath11k_dp_rx_h_defrag_reo_reinject(struct ath11k *ar, struct dp_rx_ti
>   
>   	paddr = dma_map_single(ab->dev, defrag_skb->data,
>   			       defrag_skb->len + skb_tailroom(defrag_skb),
> -			       DMA_FROM_DEVICE);
> +			       DMA_TO_DEVICE);
>   	if (dma_mapping_error(ab->dev, paddr))
>   		return -ENOMEM;
>   

Need to update this line too?

err_unmap_dma:
     dma_unmap_single(ab->dev, paddr, defrag_skb->len + 
skb_tailroom(defrag_skb),
              DMA_FROM_DEVICE);


Thanks,

Peter


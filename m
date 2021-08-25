Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78113F7C63
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbhHYSqq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbhHYSqo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 14:46:44 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE18C061757
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 11:45:58 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b64so614560qkg.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MM9TxT9aun9DoTvxLwFQ9t7L9RLMum6d40huNFPUugw=;
        b=YtDBuQZQpIl2+VpA7woAuOMDzBS5iPSCoECtEM+xTD0Bc6+05goxarFy4Z1WMQeKO+
         N62fcGSPe6ibgyLLzBkzw9mJ3bDb5l/V6twafYW1CrtHrUZoSpSrXj386RVxebBdfZ0+
         TXNJekS3TrnOE95UkySThRss6jxiSZIY3lwWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MM9TxT9aun9DoTvxLwFQ9t7L9RLMum6d40huNFPUugw=;
        b=lJc7GOnzN7rvq69wOtBRWt4vgkml1c0wy9OBrT+3BvnHE6MFARwOS+dgWnUybdASQ1
         sFM0Hx4hrnr66rmexQkmBjF358GESg3jhLoCuj/5tlfhzj0ZTTaBQPvvfUn8kBUkJVZf
         8qZoyYDgchxc21AKKPoLW0pOTx9DBKA8YMsem/quJL+M5PH2OsA3b2GOGpAItx0SGn6M
         qDx2zKNRnSZ/TA/8rZGbVughcs5SjcNZZtrxIWHOG5gc6WBvEz82Wwp+kRWiPA9f2bLN
         9LwPTvlgVSljFfC50R9Wk4G49yYiE3+W3ixMj1YA1i/dydsLJaw6bxwBhBJhhkgeiubj
         g3Kg==
X-Gm-Message-State: AOAM5318oJv2aBjSbIQChr8YMCcGHosih2D07QfAwVxIjpl11oRnv22r
        Af9UqxCFV2gMpn/iQmbso9nHDA==
X-Google-Smtp-Source: ABdhPJyyErLt+HKMWABB1TgmTuHzP77uR58/1erwL8HU1rBgU3RHoZMijNY7O9EeUFXtI9oXnpqQ8Q==
X-Received: by 2002:a37:8242:: with SMTP id e63mr32745206qkd.294.1629917157522;
        Wed, 25 Aug 2021 11:45:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:38c5:675f:d171:ff55:3554:62a5? ([2600:1700:38c5:675f:d171:ff55:3554:62a5])
        by smtp.gmail.com with ESMTPSA id s69sm594493qka.102.2021.08.25.11.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 11:45:56 -0700 (PDT)
Subject: Re: [PATCH v2 02/12] ath11k: allocate dst ring descriptors from
 cacheable memory
To:     P Praneesh <ppranees@codeaurora.org>, kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
References: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
 <1629884277-18759-3-git-send-email-ppranees@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <bbd198b3-87b7-a0ce-ada1-2bd723c9d9c9@eero.com>
Date:   Wed, 25 Aug 2021 11:45:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1629884277-18759-3-git-send-email-ppranees@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 8/25/21 2:37 AM, P Praneesh wrote:
> @@ -292,6 +315,11 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
>   		return -EINVAL;
>   	}
>   
> +	if (cached && ab->hw_params.alloc_cacheable_memory) {
> +		params.flags |= HAL_SRNG_FLAGS_CACHED;
> +		ring->cached = 1;
> +	}

"&& ab->hw_params.alloc_cacheable_memory" is redundant check.

Thanks,
Peter


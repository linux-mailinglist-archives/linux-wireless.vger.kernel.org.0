Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C795118AED3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 09:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgCSIzv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 04:55:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52112 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSIzv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 04:55:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id c187so1077817wme.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2020 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eVjeTiEe/+Y3kUb7qbMJcMEcD/Uy3XR+Yh9sVuFlyd4=;
        b=TwPtUfFdBD4KBGsiIuSa1xJI7B8czzFlcPomUaVkeNyOGEFYdJ13CmpFJNUoj8BPaN
         BMWr+MI6eg9MFO+S9qGF/CFZyxkWkhCv/ckmf2Fp872hrbG8Vkrd4+XuGFQdl6v3/Sjd
         /P81OWHtEBf3hs3RE1GLcIcekE/7m1KGB4Ujo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eVjeTiEe/+Y3kUb7qbMJcMEcD/Uy3XR+Yh9sVuFlyd4=;
        b=aFSLXrwkdxuFsM+6Ul9HVdixDORb3ss/L2XSgn/HfHUfvadhyGO/8/HRYb3YUiAna5
         GvnR7d2W6ERxlj8/2m5CENOZUIKHl53eFrf2wSk375ZGna+dXfbkUpT+68FrwhVX9vls
         LfJK2kvp+gSn8V4qD0Dfml5Z6KPbu80NjkbPAmvKqJclspPJetpaOw9/xCz3tFHVAtRb
         5THMjja7f5aYx9owKzjbnZmwXAFIIvRNrR3M/GI9cztRd4/psE+0uDElZ7WXltpJct8w
         09c7sUe1MwFwdykwReF1TIdKKgy48RCvoQZrcjOSlJjKNsw7VoXbHwVhWIc6yVkKHbuv
         UabA==
X-Gm-Message-State: ANhLgQ3WpmjhjmwdyvPVO17DHNhLtAZgXjUiA2qiqXCG+qbuHwjVp5ed
        c7pHFsbXWGPVG05aW8PYoj3HvQ==
X-Google-Smtp-Source: ADFU+vtWpAArYxIef7ZNeYOmbCHwr/+U8iwOyJCyWG+P3lUjml40Em9OYLwqjdR2iUla4Jnx1VP2ow==
X-Received: by 2002:a1c:7ec9:: with SMTP id z192mr2434340wmc.100.1584608149090;
        Thu, 19 Mar 2020 01:55:49 -0700 (PDT)
Received: from [10.230.41.113] ([192.19.215.251])
        by smtp.gmail.com with ESMTPSA id i12sm2598303wro.46.2020.03.19.01.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 01:55:48 -0700 (PDT)
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a
 module parameter
To:     Wright Feng <wright.feng@cypress.com>, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@codeaurora.org,
        chi-hsien.lin@cypress.com
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, tj@kernel.org
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <40e33702-d37f-085d-a5a7-7f09ae9e2629@broadcom.com>
Date:   Thu, 19 Mar 2020 09:55:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Tejun - regarding alloc_workqueue usage

On 3/19/2020 8:53 AM, Wright Feng wrote:
> With setting sdio_wq_highpri=1 in module parameters, tasks submitted to
> SDIO workqueue will put at the head of the queue and run immediately.
> This parameter is for getting higher TX/RX throughput with SDIO bus.
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> ---
>   .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  5 +++++
>   .../wireless/broadcom/brcm80211/brcmfmac/common.h  |  2 ++
>   .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 22 ++++++++++++++--------
>   3 files changed, 21 insertions(+), 8 deletions(-)
> 

[...]

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 3a08252..885e8bd 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -4342,9 +4342,21 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
>   	bus->txminmax = BRCMF_TXMINMAX;
>   	bus->tx_seq = SDPCM_SEQ_WRAP - 1;
>   
> +	/* attempt to attach to the dongle */
> +	if (!(brcmf_sdio_probe_attach(bus))) {
> +		brcmf_err("brcmf_sdio_probe_attach failed\n");
> +		goto fail;
> +	}
> +
>   	/* single-threaded workqueue */
> -	wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM,
> -				     dev_name(&sdiodev->func1->dev));
> +	if (sdiodev->settings->sdio_wq_highpri) {
> +		wq = alloc_workqueue("brcmf_wq/%s",
> +				     WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND,
> +				     1, dev_name(&sdiodev->func1->dev));

So two things changed, 1) WQ_HIGHPRI flag added *and* 2) use 
allow_workqueue basically dropping __WQ_ORDERED. Not sure which one 
contributes to the behavior described in the commit message.

Regards,
Arend

> +	} else {
> +		wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM,
> +					     dev_name(&sdiodev->func1->dev));
> +	}
>   	if (!wq) {
>   		brcmf_err("insufficient memory to create txworkqueue\n");
>   		goto fail;


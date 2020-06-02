Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6AE1EB49B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2020 06:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgFBEe4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jun 2020 00:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgFBEe4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jun 2020 00:34:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C67C061A0E
        for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2020 21:34:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u13so1510436wml.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2020 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WVZJwDasayPFpJIhTjhoij4113zIsq78Hh6BlyHy1uY=;
        b=gYfRAjkBP70ch5RvVEOCQKPnH7tLucTGJIJyV89Kg7kpsRPGzFB6RAUkwJofWjoaly
         dgifVDnr0qGT8Dgjq0VS6pvKP81eDPRIQf54v6x4kumE7AJzoJtysPsOUpfo1950Q/YX
         NCLHqZ/UoLAZ+UIGXsemKRWP1fihG9c1kP1BjoixNlmuwfUnh6YHOZ+3s4Ea4lQ4hQAg
         nCp5US9u1lPfjxNH2OJEKLOdxLkdURz4Gi6TMsO2vGPvLsWd8tDTbI8w02p+6obGBv+v
         KdwK6QZxRir45lKdUiZtgw1oBtmajChKi9RLPuVskOFFY8X9LfVFuvd1zRM+2kxXG13l
         /Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WVZJwDasayPFpJIhTjhoij4113zIsq78Hh6BlyHy1uY=;
        b=n5t4FWscCWC/NrYBqpCUK8UzgGqVWxdPqHEykGtSEMI4W695hWM9tD2IXSgJjUQOY9
         hAJ2QAjsedM0+qLvWYE9awi0kmyfvWq7cVFo3w9BSR7v1zDSOEJA1oZDZhMQhqmtynrv
         hRFt8GYXJdm+d7wx+egV3luO6GA6XAKBieDkG5y+Rjh0OgUIkfqm1ap2iiVNpUH7Jznk
         PcHFipO2YM++Kl1WJhDsFO96lbiNI6Nxqfg2BwqRK5nAaSqVjpuxAuZAPy6smf0Ppg3S
         ziTmnrcqLQdZdbdk08n8sK6C4rAZH3PGvVqyNrmOvfdBt/3TdoOrO2GK6ONjVNlddVqh
         wqrQ==
X-Gm-Message-State: AOAM532CUMiEmconIYkXIGnGKZX22ut5+OpTtJv/C79xk9qDDd0o9zjv
        Y7iptYfH4taa6H9U8BuYX3A=
X-Google-Smtp-Source: ABdhPJx6hcLCF9V5kkszYxdRkqtIN0bg/DftOpSH9yKubxNlFeY62MhskkHHaDyh62JKOI5MgvA89A==
X-Received: by 2002:a1c:2643:: with SMTP id m64mr2242150wmm.158.1591072494141;
        Mon, 01 Jun 2020 21:34:54 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id c65sm1724114wme.8.2020.06.01.21.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 21:34:53 -0700 (PDT)
Subject: Re: [PATCH 1/5] brcmfmac: To fix kernel crash on out of boundary
 access
To:     Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Raveendran Somu <raveendran.somu@cypress.com>
References: <20200601071953.23252-1-wright.feng@cypress.com>
 <20200601071953.23252-2-wright.feng@cypress.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8fe5fdf5-1b26-a127-3567-321017455a49@gmail.com>
Date:   Mon, 1 Jun 2020 21:34:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200601071953.23252-2-wright.feng@cypress.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 6/1/2020 12:19 AM, Wright Feng wrote:
> From: Raveendran Somu <raveendran.somu@cypress.com>
> 
> To trunkcate the addtional bytes, if extra bytes been received.

typo: truncate. Missing "have been received".

> Current code only have a warning and proceed without handling it.
> But in one of the crash reported by DVT, these causes the
> crash intermittently. So the processing is limit to the skb->len.
> 
> Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
> index 09701262330d..531fe9be4025 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
> @@ -1843,6 +1843,9 @@ void brcmf_fws_hdrpull(struct brcmf_if *ifp, s16 siglen, struct sk_buff *skb)
>  
>  	WARN_ON(siglen > skb->len);
>  
> +	if (siglen > skb->len)
> +		siglen = skb->len;

Does it make sense to keep the WARN_ON() one live above then?

> +
>  	if (!siglen)
>  		return;
>  	/* if flow control disabled, skip to packet data and leave */
> 

-- 
Florian

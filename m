Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93D11B8E92
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2020 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDZJrl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Apr 2020 05:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgDZJrl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Apr 2020 05:47:41 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A494EC061A0C
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2020 02:47:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g10so11234683lfj.13
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2020 02:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dHXaExJ1K/JHEMuKTy7X0dhJTSD9RbZ6nCdoldTp0Rw=;
        b=z30p3L2FQt97ywRTrTvKTAd7/21Sgxi2McYChNMJ/pJAJkaZESsXYuFg38L+LmuSnw
         VVvpxpcgTJnVH8JsEpA9f2zRB5MqIFSyUdqcG9b/UQLWt8Wpb0d7MDSyfzK2SguuZJeS
         oUVCadL9uX4NIUwBBBsSitv74qCYoS1qkLxSVduIrNBXw4fM4JXLGI0rBEy0UpHEsD6X
         2HjOS70R+MIOnncFDT0R4Wvi51vTMENmVE5PcqFRZvF5xwBBA391w4IcsCjHqGoYf0sU
         5AB9di8gdvFW0HXGi18i15TQiD0L8o/eGsyGgq1GYRvLRhRLfwbn3HA6h0prOW3ZQDKF
         k8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dHXaExJ1K/JHEMuKTy7X0dhJTSD9RbZ6nCdoldTp0Rw=;
        b=pBoKuyHtsXDy/8BYK6rNK3YV0NDlR2IIiGKI2Q3qfBjfgKAD6cAOsk+SAAsuEUc9kp
         S1adgmDsYzW/+RYVH3sWPMjjb8okFzt5ClLQAG7knmXrV/jGee2egmd78IHzmoaLpkFr
         LP4CfCW6qtgtaH568vOm7MGyEjiNwhBFbfPoJZVYayaU8tAxamtNU7h83dSU96peiJ4y
         Q2q/GpKhdeWc3v+i54ynIpAwqiPI0viaehn+OoKjiDXkouTDZ7NL86L1c767bWkv+gVY
         7wqpbI8RZbBSxQopLiQ7edTCslyyCC+r0ymA3cSZQ/SECVlu3xdspuFe7lV8uhGQ0gCJ
         BIWA==
X-Gm-Message-State: AGi0Pub82CN4VCoNcFQu8XqQqOcqo/FGQ5BFoX6E3971rPeKNnUyWoFP
        lxCuhyf2mWYdaG92/g4Xvz+SkA==
X-Google-Smtp-Source: APiQypK0877+DjKxPN7f7pvQ21NEfBR2KdGm58FPJc0WLHFGf//1VfX7W+0TVD/Tu2TQCRgLQ30DYQ==
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr12188613lfe.163.1587894458999;
        Sun, 26 Apr 2020 02:47:38 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:698:86d:e49c:3858:5aea:e34? ([2a00:1fa0:698:86d:e49c:3858:5aea:e34])
        by smtp.gmail.com with ESMTPSA id s27sm7568437ljo.80.2020.04.26.02.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 02:47:38 -0700 (PDT)
Subject: Re: [PATCH] ray_cs: use true,false for bool variable
To:     Jason Yan <yanaijie@huawei.com>, kvalo@codeaurora.org,
        davem@davemloft.net, adobriyan@gmail.com, tglx@linutronix.de,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200426094103.23213-1-yanaijie@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <9c67aee9-ece6-01f0-895a-e690b967d819@cogentembedded.com>
Date:   Sun, 26 Apr 2020 12:47:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426094103.23213-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

On 26.04.2020 12:41, Jason Yan wrote:

> Fix the following coccicheck warning:
> 
> drivers/net/wireless/ray_cs.c:2797:5-14: WARNING: Comparison of 0/1 to
> bool variable
> drivers/net/wireless/ray_cs.c:2798:2-11: WARNING: Assignment of 0/1 to
> bool variable
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   drivers/net/wireless/ray_cs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
> index c1d542bfa530..f9402424accd 100644
> --- a/drivers/net/wireless/ray_cs.c
> +++ b/drivers/net/wireless/ray_cs.c
> @@ -2794,8 +2794,8 @@ static int __init init_ray_cs(void)
>   	proc_create_data("driver/ray_cs/translate", 0200, NULL, &int_proc_ops,
>   			 &translate);
>   #endif
> -	if (translate != 0)
> -		translate = 1;
> +	if (!translate)

    That inverts the original logic, no?

> +		translate = true;

    Actually, that whole comparison/assignment doesn't make sense, if we use 
bool...

[...]

MBR, Sergei

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC6D402C8E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 18:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhIGQGk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 12:06:40 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47774
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234105AbhIGQGk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 12:06:40 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 03E524018D
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631030728;
        bh=YP2/VludKZxfn7ZssReTEMfvwdfhQuuxVwCMuWtoV0M=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=c71l0eoYBrO8abEIrs8JLOdXxaabnmWKIjlUsW4eXasrmVpuH5y9PMmz4uHMnfrHf
         +i9p5jrra7pr2X76DHjHWAk4/NanrpUUimyTICw8uovb2/+Bv3WKDyF7PooUqOkS4F
         QPpTnxur97AHw6qH5lYHO8HlHlnfn8j0tQAwKpIPqwf/iykR0o3D592S4FXO3I/dDB
         GOQITrjDugbAe7uzLbxYfH9D72D4yUAb90jdy+lMAUGFjkgY/mMi1nYtlkQ3iIOCdt
         3pTVyxMoR5wGKmGb+08dyV3ZpkCIn4Dox5H+kxwFM15ojzFOC5A7VOWgTty1/cmqk+
         Ql6yLwvHmxbog==
Received: by mail-wr1-f71.google.com with SMTP id y13-20020adfe6cd000000b00159694c711dso2277121wrm.17
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 09:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YP2/VludKZxfn7ZssReTEMfvwdfhQuuxVwCMuWtoV0M=;
        b=OCmK8fycGpRlMyow85LEtZMWdaxHjgl3lLHm44jRAD2E9VB4A9shmxiOh+HtgllniZ
         A5YtXzHs/Sw1MZDtjmaB6UEZHOc7/gPcFLRPfBGe+iWRn8roKD/xjg+JMK4eQI7K14q2
         UyGg2bomAINCbpmqD/pmwDCmMwLWKnymdUn23+2gqiUQpeFm96Hgb7h37V65CBSnWGej
         1UPkT+l26lsKKChlSOC4B6gWBoqOIfojFbgxcTc5x6Wwa1U3zhbuhQ8X+4xTw0h0n3l2
         w9HuTF4P3HUwZsutZ/absqTKYG+YjB2+Yxkey7moWTMCOSUjCc8X/5+EPTTAsb5rDQd3
         Rc9g==
X-Gm-Message-State: AOAM531vsxp0rf29jcSmmqL4vxTeCxp8jLc7ozy5hdMiFnnKu2mFWXk2
        /8pLBQpLJr4i04O6rWkvtkvsBbHz3NhY1R/Epg5a5ZrtrgVIFXK1J2bL8K3K2yAKpYo6+zWCnZC
        CCphE5OJGLd+KZpXyRHJAj/7WGsr/zFpt4QfB5pYnND6u
X-Received: by 2002:adf:e606:: with SMTP id p6mr19733176wrm.231.1631030727409;
        Tue, 07 Sep 2021 09:05:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2vXes2sOGaOH/wZ20TblF6w1HjcLY8vGDnXm94khUXSoLOVYKf88pEQi2Y8AMLrFkz7eqTg==
X-Received: by 2002:adf:e606:: with SMTP id p6mr19733161wrm.231.1631030727289;
        Tue, 07 Sep 2021 09:05:27 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.63])
        by smtp.gmail.com with ESMTPSA id u25sm2772784wmj.10.2021.09.07.09.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 09:05:26 -0700 (PDT)
Subject: Re: [PATCH 05/15] nfc: pn533: drop unneeded debug prints
To:     Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
 <20210907121816.37750-6-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <35626061-ff2e-cb01-21ff-87a6f776dc28@canonical.com>
Date:   Tue, 7 Sep 2021 18:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907121816.37750-6-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 07/09/2021 14:18, Krzysztof Kozlowski wrote:
> ftrace is a preferred and standard way to debug entering and exiting
> functions so drop useless debug prints.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/nfc/pn533/i2c.c   | 1 -
>  drivers/nfc/pn533/pn533.c | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
> index e6bf8cfe3aa7..91d4a035eb63 100644
> --- a/drivers/nfc/pn533/i2c.c
> +++ b/drivers/nfc/pn533/i2c.c
> @@ -138,7 +138,6 @@ static irqreturn_t pn533_i2c_irq_thread_fn(int irq, void *data)
>  	}
>  
>  	client = phy->i2c_dev;

This line should also be removed (reported by kbuild robot).

I will send a v2.


Best regards,
Krzysztof

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B8F46C7E4
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 23:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbhLGXC2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 18:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbhLGXC1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 18:02:27 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1434C061746
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 14:58:56 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y16so842300ioc.8
        for <linux-wireless@vger.kernel.org>; Tue, 07 Dec 2021 14:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xoJVffz/EBLfg8RUsf3/oH2B3NCc3grVj9ESSLdCq3o=;
        b=G491kuqnmMDgCzq6gPw3dXp4ko7NOMRnCBQ2Z7mEzL7a/JP10imNSDI2JUSIQFCsv+
         ou+CRKmOxER61wW/kfm9f8fGcyASrZQteJAliI/fODPrqk5LbCNEiDKMC7T5EFTq1cVl
         9AvylVHTlWwo/WA1MQOhq5jgo5PhGDwvaHAiRvkp7GczyYUbOoyXuRhFepygUYRgcmJn
         do1Kuv4/qr32TZyYK2SF+u3BjqNPVI4yZobvw7aWeY4Q8WvJxxZ1HSvgPX9Goa+pfWMQ
         zQAgXgvj2cR9BIiimq72vYbxpisuvgdaRxB5Vs2HWUanCDy6tXRjr80RG9+jtPmCLhZy
         ejVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xoJVffz/EBLfg8RUsf3/oH2B3NCc3grVj9ESSLdCq3o=;
        b=2ax+C7igyKN8m/nX7sTJ8PPps3s2wz2nPsjfWcygIBnLGZIW9Z2AhF0Dk6T+f1i2K1
         JVykfW4zqlYTD19KnMQuNTgEuo1ufuipnPH9ucxcZmmHIhKC1YRf6KUr4pEkSumDoWtO
         INumldN5SnypRhWZBaOIhxPPEKeh6oiend0uXR1xTb5fy6yxt9KaJcVX0ySiQ/rNmerk
         z/+j82TiOaJ9tRm3RpwSnrGoPh4RavuSI4NxT1qOVZH6cimU/ScPKTx4iFPucQ6/Rw5T
         qZUnnfvjE0m2GFgb1SVbAnfwiu10AFiWx1QvXheHzB98l/RazLLkSBmyUPzs/lBHmqFD
         F2IA==
X-Gm-Message-State: AOAM533fAjPfAiR/D4jQ6A9VMqFNH8oDKPBXyFlbpbIWWBCgO4GZ65Dc
        QMEgJ8b05uAdk4GinzJpm2fkRbVXn2/GZhc=
X-Google-Smtp-Source: ABdhPJw41J0k7nJiq0Bk5nISbbtSZf25niGbUgkszqGDzCVtLAM+K/V9aTLiGqOulI83KB7Ogz9XGw==
X-Received: by 2002:a5d:9053:: with SMTP id v19mr2885668ioq.39.1638917936189;
        Tue, 07 Dec 2021 14:58:56 -0800 (PST)
Received: from [10.1.100.16] (c-73-181-115-211.hsd1.co.comcast.net. [73.181.115.211])
        by smtp.gmail.com with ESMTPSA id u4sm789933ilv.66.2021.12.07.14.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 14:58:55 -0800 (PST)
Subject: Re: [PATCH 2/2] wilc1000: Fix missing newline in error message
To:     Joe Perches <joe@perches.com>,
        Ajay Singh <ajay.kathat@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211206232709.3192856-1-davidm@egauge.net>
 <20211206232709.3192856-3-davidm@egauge.net>
 <4687b01640eaaba01b3db455a7951a534572ee31.camel@perches.com>
From:   David Mosberger-Tang <davidm@egauge.net>
Message-ID: <00d44cb3-3b38-7bb6-474f-c819c2403b6a@egauge.net>
Date:   Tue, 7 Dec 2021 15:58:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4687b01640eaaba01b3db455a7951a534572ee31.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/6/21 6:33 PM, Joe Perches wrote:

> On Mon, 2021-12-06 at 23:27 +0000, David Mosberger-Tang wrote:
>> Add missing newline in pr_err() message.
> []
>> diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
> []
>> @@ -27,7 +27,7 @@ static irqreturn_t isr_uh_routine(int irq, void *user_data)
>>   	struct wilc *wilc = user_data;
>>   
>>   	if (wilc->close) {
>> -		pr_err("Can't handle UH interrupt");
>> +		pr_err("Can't handle UH interrupt\n");
> Ideally this would use wiphy_<level>:
>
> 		wiphy_err(wilc->wiphy, "Can't handle UH interrupt\n");

Sure, but that's orthogonal to this bug fix.  I do have a "cleanups" 
branch with various cleanups of this sort.  I'll look into fixing pr_*() 
calls in the cleanups branch (there are several of them, unsurprisingly).


   --david



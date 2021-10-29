Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A441643F445
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 03:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhJ2BMI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 21:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2BMI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 21:12:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D211C061570
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 18:09:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b12so8914612wrh.4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lhYCin2TzRHtxXVH4Iykuf57kXTP5rSqqv5y4zrqtWU=;
        b=Rvu01fsCuwhHv4hl4Sg6odzPQptg+qgHL7NR7EuEegZ69QatECFfTO01hVW3od8qNA
         wpEIllOcottCYc76RTtWueF4qPbIM2t6Il7LUvk0TSSb5WpUHroa5phXjrJZwkDIZeFP
         hss9npea1AW38RPdjyUkMd0lZbcBchkYiFiE4g3CPvd8n80DSwnPbpr4T8oZOAd/Jytn
         xV+GJDRjHQY3NIkJ5oEsTF3qLH4+mF4cuha6xYjYDMmr1HSks6vFwcMAa8nUKpuwefEk
         SpVmFHkEquZZeP8PvMEnrdiXQfKUtvB4ntc4GdzT/rw0FB1AbZFaYF9b7m+ISLDbMyZW
         R1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lhYCin2TzRHtxXVH4Iykuf57kXTP5rSqqv5y4zrqtWU=;
        b=2kv689WQnK+uP5+x4Yu+5swbn/sgWIJ8BOegcGp2wco1AjKLjeaz0CX3P6yhQBMJDx
         3MywNLhVtBstuxzO379LXBOCqjGiL1etroVvVYJc5oVL5v6oVrArgsE4KgRgbAlCRvlj
         5tQ+OmRKxWMQWhVxGAz+sLZ0aDeeTJfPWsrd95TvxdYwYK9PsRfbEJYf4BjV1FQfypYM
         FYsAYEwRiqfPdPyC0RhAgJsa3hycfvWF1PILFrku71vEJymWy68TvFWOQXOW5GQnpDWK
         sga6a2xTfSOgfp6gFk26Y0LueZ2bixqChb9P8+xPZof1u4BdWoKfueTEd7+H+YCoINLq
         vyLQ==
X-Gm-Message-State: AOAM5311d1oyHiFImvXiM9Seo9y1BhrjIAcy232eDn0CJOOIxJjHX7U+
        XzkcxUVDTBjiUX7jg9uSVX2qtg==
X-Google-Smtp-Source: ABdhPJxZsQk0ecSoGT5SZqDT/0Hc0hSGM4cAF81gCKity/kYkRSz1nfDgkLpat4il9Tx89OAgoasIw==
X-Received: by 2002:a5d:59a9:: with SMTP id p9mr10659841wrr.386.1635469778934;
        Thu, 28 Oct 2021 18:09:38 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u10sm5784415wrs.5.2021.10.28.18.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 18:09:37 -0700 (PDT)
Message-ID: <3e915b78-04df-43d4-e406-c129f61a33cf@linaro.org>
Date:   Fri, 29 Oct 2021 02:11:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/2] wcn36xx: fix RX BD rate mapping for 5GHz legacy rates
Content-Language: en-US
To:     Benjamin Li <benl@squareup.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211028223131.897548-1-benl@squareup.com>
 <20211028223131.897548-2-benl@squareup.com>
 <b3473977-5bb6-06df-55c3-85f08a29a964@linaro.org>
 <631a3ab4-56d9-5c1d-be53-c885747e3f7b@squareup.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <631a3ab4-56d9-5c1d-be53-c885747e3f7b@squareup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 29/10/2021 01:39, Benjamin Li wrote:
> On 10/28/21 5:30 PM, Bryan O'Donoghue wrote:
>> On 28/10/2021 23:31, Benjamin Li wrote:
>>> -            status.rate_idx >= sband->n_bitrates) {
>> This fix was applied because we were getting a negative index
>>
>> If you want to remove that, you'll need to do something about this
>>
>> status.rate_idx -= 4;
> 
> Hmm... so you're saying there's a FW bug where sometimes we get
> bd->rate_id = 0-7 (leading to status.rate_idx = 0-3) on a 5GHz
> channel?

My memory is I saw a negative index as a result of the -4 offset but, it 
is quite some time ago and we have made all sorts of changes since.

> static const struct wcn36xx_rate wcn36xx_rate_table[] = {
>      /* 11b rates */
>      {  10, 0, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
>      {  20, 1, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
>      {  55, 2, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
>      { 110, 3, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
> 
>      /* 11b SP (short preamble) */
>      {  10, 0, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
>      {  20, 1, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
>      {  55, 2, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
>      { 110, 3, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
> 
> It sounds like we should WARN and drop the frame in that case. If
> you agree I'll send a v2.

So,

Let me see if I can replicate the previous bug - tomorrow - later this 
morning in fact - in this timezone, and I'll get back to you.

---
bod


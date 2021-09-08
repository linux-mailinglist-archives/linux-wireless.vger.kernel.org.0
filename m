Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8524E403AF4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 15:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhIHNvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 09:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhIHNvi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 09:51:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E19C061575
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 06:50:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso1624088wmc.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Sep 2021 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M8ajzayFEpcCtxwTlzzEQTTLA3VBqHDqvYzs2WL+0pc=;
        b=mhARqrhevGZa5GyfhZKjh9Jqa8i2wbHJcZ08dmdwMLh0n4nnIw/kn7OPWURjCpKGWZ
         6sEyqacFY1vVYm6HLt+LflTYaH0SpGtAoRkUveVhQWOzRDr9eEmUHEXAMTbZ5ciJKEdL
         Sro9nH9xkdnx09o/AcJWWlwrpeWqLR+BNg0PYqTqS8Q7Tyju0om45NtCr8PpeR6r9Cm5
         7jB2h5+Ghb3YBjTY/kgsSs2G+41itifDPo2Vdbi5eUbNmigfNSMRc8LF6qD+Ltbl1MnJ
         7e0emMIuuD38d8U4QPg+OmYff9h27KvvV5H6Ax/D8atrkGMXzsqstWak+W1CBqx+aEiY
         D3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M8ajzayFEpcCtxwTlzzEQTTLA3VBqHDqvYzs2WL+0pc=;
        b=CQxVDY0uJYMeQ+2FhAbuJ6eYAR6n/ICyEIxjZQmpOQAnWVkehr5BHSN67WzIwAipy5
         gj1pjKctr5MTuPqRdonghxHPocHyB/lbIz0flsnWe0iD7pKcH4GacMU+iivumy9nC8zf
         fDbMtK/QHHiMaX4LIITGR0e5+ZcexH9CDv4RSfkActWUzAxQH/sEw40nrGw5gakc0oTZ
         RIinUZKpvCePOkvhQVXx4GySARSgkGWvVgPw2ZI18mZnuL2pPv6MVw9BLnAnNPshXQZa
         S5vY4oQSWV1I/vvIMJ00llSN03a15kcWxPcBVRM956roZtVKjinTXC1j2mAkbuu6BTXo
         xjew==
X-Gm-Message-State: AOAM531cSGiMDyOW66Bo++X3AZ0AHqZwZJZ3PtDJcK4W5Y8oyw+1KQ/q
        mxVefWLi0UlTfImfeDZN89iqRGoJOrkAUQ==
X-Google-Smtp-Source: ABdhPJwXfVMBxmtRQK/6tATWHOHMiKn7oOw2Sq4Ti9EH1VAHMmNTNuBD/06LMDlwujpC7fHh/PClcg==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr3862862wmj.85.1631109029592;
        Wed, 08 Sep 2021 06:50:29 -0700 (PDT)
Received: from [192.168.1.100] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r27sm2261284wrr.70.2021.09.08.06.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 06:50:28 -0700 (PDT)
Subject: Re: [PATCH 2/2] wcn36xx: Add ability for wcn36xx_smd_dump_cmd_req to
 pass two's complement
To:     Johannes Berg <johannes@sipsolutions.net>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com
References: <20210908133019.2408092-1-bryan.odonoghue@linaro.org>
 <20210908133019.2408092-3-bryan.odonoghue@linaro.org>
 <19691c5bc144eb525530974813812a86937a0a91.camel@sipsolutions.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <b98ac262-a1df-4576-eee6-2bb5f175e7fe@linaro.org>
Date:   Wed, 8 Sep 2021 14:52:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <19691c5bc144eb525530974813812a86937a0a91.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08/09/2021 14:33, Johannes Berg wrote:
> On Wed, 2021-09-08 at 14:30 +0100, Bryan O'Donoghue wrote:
>>
>> iwpriv wlan0 dump 71 3 <schedule period> <trigger threshold> <hysteresis>
> 
> Ouch. The last millenium called and wants its technology back ;-)
> 
> johannes
> 

ah we're all about recycling the technology since #climatechange

:)

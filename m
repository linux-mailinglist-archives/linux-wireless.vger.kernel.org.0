Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B329E6DA001
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 20:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbjDFSjb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240265AbjDFSj2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 14:39:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E235BA9
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 11:39:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y7so9185847ljp.2
        for <linux-wireless@vger.kernel.org>; Thu, 06 Apr 2023 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680806358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzdRb6pnkmsus+yIRwXbtWlbX60lc0X5WvMqlzQrDnw=;
        b=X2Gjkg08dhQfvA179XoZ/xMR768GPvfiMhSriliUPS2VW6IF+caRHk3oyvVi7zwceb
         rqYCEXyxbM47uvulQ890YxCwMio7oYiokZU2Q2jZhV26zZNSDHH9/llKN7QMvPHwijoB
         k9EhQm1tsSNbf9P+mHF3sTpNQfqODiLXNa2JNoUVN+pORj0bkoQB9VgOokmYekFC//8T
         ciHran2eaQcJEHjLnY3Gp0WpL++IGG6DSMQSXZ4UvxjGlhCI2gxMgvG+jL166wo+n6ir
         SeM2dr+e68hlv6tP2zTG1o3cIlQ4PJhsocx6ilN9qs9kyYpThk0Qvjf4a8FHQo1RzQiZ
         dm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzdRb6pnkmsus+yIRwXbtWlbX60lc0X5WvMqlzQrDnw=;
        b=RhCHDXNC/CcXibVt2EyBs8N46NlPEGbwRI7IhIAOSp6R8Cb15B1BS8kdmZAhUHJfW0
         euOfT6404sdz/R1IExJZ7X1CNlWxWI+MpJCqeSb5lX5h6Oh24HCYp6AAuiFz79nZYdGZ
         Pol9pTPgF08iMvIMznJoxflUxyTzZs0QRxH3PW8o2vbM1bP/FyUeZpbLWJ3aEbM3CEwe
         cXTTqvOqUnkeWpaBfUgtoGg2rUag2GB9D1abOR055aZPanFGYpA4PaatD9XicBjk9c/o
         KbL3xi3KY76yBntDsdLtMATjOkc6/VDgAavLrBmtdCSKXTx5oMxyv99j7LZjNlC+PWkH
         qPOA==
X-Gm-Message-State: AAQBX9c9ejTWyov/2rd0P0lRRK7AXcBt0wL7Q6EpwVuZNi7MWVrWWu6h
        AvjWVPlHtAAhk7r5j41CtAqecg==
X-Google-Smtp-Source: AKy350a3OD9HVmDgKylvrWyF5U95HSWfUl8N+EQpPalZT/JEENS+L64vmodPR1w4RzfkvCnGXQavIw==
X-Received: by 2002:a2e:3814:0:b0:295:a958:2bca with SMTP id f20-20020a2e3814000000b00295a9582bcamr3199301lja.6.1680806358396;
        Thu, 06 Apr 2023 11:39:18 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651c102c00b0029b32a40934sm385427ljm.113.2023.04.06.11.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:39:17 -0700 (PDT)
Message-ID: <5437085b-706b-2f9a-686e-b95a9a0e6993@linaro.org>
Date:   Thu, 6 Apr 2023 20:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/2] dt-bindings: net: Convert ATH10K to YAML
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230406-topic-ath10k_bindings-v3-0-00895afc7764@linaro.org>
 <20230406-topic-ath10k_bindings-v3-1-00895afc7764@linaro.org>
 <223892d0-9b1b-9459-dec1-574875f7c1c6@linaro.org>
 <8c818f95-b4a4-658f-701d-3151afdd5179@linaro.org>
 <6720f61e-550f-6e16-8860-54233a3ea069@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6720f61e-550f-6e16-8860-54233a3ea069@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 6.04.2023 20:30, Krzysztof Kozlowski wrote:
> On 06/04/2023 20:26, Konrad Dybcio wrote:
> 
>>>> +        interrupts:
>>>> +          items:
>>>> +            - description: CE0
>>>> +            - description: CE1
>>>> +            - description: CE2
>>>> +            - description: CE3
>>>> +            - description: CE4
>>>> +            - description: CE5
>>>> +            - description: CE6
>>>> +            - description: CE7
>>>> +            - description: CE8
>>>> +            - description: CE9
>>>> +            - description: CE10
>>>> +            - description: CE11
>>>
>>> What about interrupt-names here? If they are not expected, then just
>>> interrupt-names: false
>> They obviously wouldn't hurt, but they're unused on the driver side:
>>
>> for (i = 0; i < CE_COUNT; i++) {
>> 		ret = platform_get_irq(ar_snoc->dev, i);
>>
>> So I will forbid them.
> 
> Assuming DTS does not have them.
Tested locally, no warnings, so looks like nobody used them in dt.

Konrad
> 
> Best regards,
> Krzysztof
> 

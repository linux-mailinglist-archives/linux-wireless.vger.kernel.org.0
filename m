Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BC86DE02E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjDKP7T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDKP7S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 11:59:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E174C3D
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 08:59:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-504ea515d6fso47035a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681228746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuLKaVpqWP7mcBL6Va5Q6AmbfGLfH0Ywuo6SlIN5+HI=;
        b=lvxPfM8pF4k7O2Lg3VLCu9K5GPO9jyWxvj4IHAqR/RPyls6W2HA033ataUHE+gqDI9
         DBhU6dQmXT239qaiaKugflHr79gur8BX2toxtbaNIXDNrbhFAIZK+8PDjeT76BcStMYZ
         PrReP3uLUBz8/IOCC9f9XozZOo7bSwyq0qj5eL3oRFB14QtHwRfWvZmvW8gg7HLISRMz
         NO1K021Jbgll+t898NmGvGc1qW76ddjmiYc9tbkLPfjWvlrImk7jPLJX4rlfQWNg3CGK
         73Uxe60eY2kLkIk7nDs3DF/SEcmkLqVDzI1h8kgTRxjLfANGDYzQlBOxjOhZyFqqp4X9
         xdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681228746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuLKaVpqWP7mcBL6Va5Q6AmbfGLfH0Ywuo6SlIN5+HI=;
        b=gkcLPbxtXnBwMGKnDmkYfyyiO0BNTB6KWhCRevApiLYgujHHnO77uMWVWvN/RHp2QJ
         pbKNrPaRMA2SFF1hA5/Qu1j80J2Jj/oFNLdPppnrLQFL9GIP6IdzyCYaxkTJ9UER4P5T
         MH5AC0K4XkJr7Nv00IFvjOkZIQ9JfaL1rBn0QJvE+44EOq0QXMs7ZHhfKM+r/YcH6pv6
         AeZL+8giZNdT5myUqOVRREueHE9AO5Sgjux+uzf81eEqLrZGz3/kvnSJWXxIVUMM6T4F
         i3WrwfKFmfe4Vqf+YI8qFw0xpbgxHnBcKoYaZ+SauXbHDgickZ5c3CttEYT6N3h//93j
         9w+g==
X-Gm-Message-State: AAQBX9fzryB6QxDbbkqR62l4SJGr8qhNbDKldmfPL5Sp51pXuJgv/6iW
        ddSdHV7WE17a8BvskLajefAQnw==
X-Google-Smtp-Source: AKy350Y5CR7tYp8NsWFjkTYbI+F0Ye+qaeSHHHlVAklG30GRD47NiW1USk+vZaeKXZvsOfP0/XQq4g==
X-Received: by 2002:aa7:d60c:0:b0:502:9578:38ed with SMTP id c12-20020aa7d60c000000b00502957838edmr10337957edr.27.1681228746037;
        Tue, 11 Apr 2023 08:59:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f1da:c117:3657:c8a? ([2a02:810d:15c0:828:f1da:c117:3657:c8a])
        by smtp.gmail.com with ESMTPSA id ec20-20020a0564020d5400b00504a1313bafsm2332200edb.95.2023.04.11.08.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 08:59:05 -0700 (PDT)
Message-ID: <e75a5a75-ea42-6c7c-f6ee-b32ef735cd81@linaro.org>
Date:   Tue, 11 Apr 2023 17:59:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/2] dt-bindings: net: Convert ATH10K to YAML
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406-topic-ath10k_bindings-v3-1-00895afc7764@linaro.org>
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

On 06/04/2023 14:55, Konrad Dybcio wrote:
> Convert the ATH10K bindings to YAML.
> 
> Dropped properties that are absent at the current state of mainline:
> - qcom,msi_addr
> - qcom,msi_base
> 
> qcom,coexist-support and qcom,coexist-gpio-pin do very little and should
> be reconsidered on the driver side, especially the latter one.
> 
> Somewhat based on the ath11k bindings.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/net/wireless/qcom,ath10k.txt          | 215 -------------
>  .../bindings/net/wireless/qcom,ath10k.yaml         | 357 +++++++++++++++++++++
>  2 files changed, 357 insertions(+), 215 deletions(-)

You should have received kernel test robot warning. If not, just
confirming here - you need to fix paths (docs, maintainers).

Best regards,
Krzysztof


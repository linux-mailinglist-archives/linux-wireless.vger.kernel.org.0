Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4E6D9FC9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 20:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbjDFS0l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbjDFS0h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 14:26:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF009012
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 11:26:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g19so38853970lfr.9
        for <linux-wireless@vger.kernel.org>; Thu, 06 Apr 2023 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680805588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrPZiBBEPnTeAG4ijDo3nsObeCJTrwIJDTUCNITg5iI=;
        b=CqY6xF+cOM6sbxvjz1Ff7fcQTniOYKz25DBG6qwejTmMEtsmz5R30IcQ4sXU09agqz
         P2PmuH6Zw2bKIlZNN6pfWhu8qqUxSJLAvzstuk0VDd9a90kRfEe2y3Ik22OCGmhp2uHV
         qModnBJcJBhDhgSwuY5jGg+eLZ4iDFenf1vxh/bGXh9z+V8icUiD9i5qAT/VXwbu7flL
         0KZIFha7SMukx/q98vET3mn+TYaju71P93US6xA8xhFUfIfhX8gZPoiCqVs9APcBPung
         hX3ctOJ+/HYMko8xKotKi0hFQXT2S9ekgcGnI/ptduyfF+3ahLqbNXocC5t04IHUe9Me
         q0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrPZiBBEPnTeAG4ijDo3nsObeCJTrwIJDTUCNITg5iI=;
        b=BOxPr4HBQ1AiuVzABbIkRNesAWjzOwmUU2reVEEB1ejhoXvnYXNMD1Vqgnl0TEjRuu
         vUiesuth51MdrX1tDtrGirjepXN0/CRKMlYxk699obcdZ5fy4NLqc5FnV+7t83Hx1Vp1
         E1rCoHlIAeZONr7OlChEWEFnVFW9I+9f07qwwMbYf7E4FdXeEXp6DLQLyogrZBSWaDbT
         D+dkrulILpr2LeykGyYNAPJ3Y9amy2uWFJSXo/4BcfHLPbzgNQVuWXea1vGhkbu2OHor
         0cYbzgveoscmeAs6yxJJ6KOMielHsKD1m16/0Cb+vfQv6FwrdCb9wJJor4oMzCQRcoRb
         e3jg==
X-Gm-Message-State: AAQBX9e+eCHqHiqQSmj/7aKBrISb3jhc6h7zqKp+ljxrZU15b5BlEyvB
        10xFONxX5wJ1+zUrjGRrD4gv2w==
X-Google-Smtp-Source: AKy350Zoz7gSPFtYZOf28QyZRifSrImimrPXqKp3I11ff3EWM5EclgyEAjZIR1qhjTDNBFSIbmszqQ==
X-Received: by 2002:ac2:43d7:0:b0:4eb:3b7c:233 with SMTP id u23-20020ac243d7000000b004eb3b7c0233mr18951lfl.16.1680805587873;
        Thu, 06 Apr 2023 11:26:27 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id w26-20020a05651204da00b004e88a166eb6sm368106lfq.46.2023.04.06.11.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:26:27 -0700 (PDT)
Message-ID: <8c818f95-b4a4-658f-701d-3151afdd5179@linaro.org>
Date:   Thu, 6 Apr 2023 20:26:20 +0200
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <223892d0-9b1b-9459-dec1-574875f7c1c6@linaro.org>
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



On 6.04.2023 19:15, Krzysztof Kozlowski wrote:
> On 06/04/2023 14:55, Konrad Dybcio wrote:
>> Convert the ATH10K bindings to YAML.
>>
>> Dropped properties that are absent at the current state of mainline:
>> - qcom,msi_addr
>> - qcom,msi_base
>>
>> qcom,coexist-support and qcom,coexist-gpio-pin do very little and should
>> be reconsidered on the driver side, especially the latter one.
>>
>> Somewhat based on the ath11k bindings.
> 
> 
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,ipq4019-wifi
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          minItems: 17
>> +          maxItems: 17
>> +
>> +        interrupt-names:
>> +          minItems: 17
> 
> Drop minItems (the number of items is defined by listing them below, as
> you did).
OK

> 
>> +          items:
>> +            - const: msi0
>> +            - const: msi1
>> +            - const: msi2
>> +            - const: msi3
>> +            - const: msi4
>> +            - const: msi5
>> +            - const: msi6
>> +            - const: msi7
>> +            - const: msi8
>> +            - const: msi9
>> +            - const: msi10
>> +            - const: msi11
>> +            - const: msi12
>> +            - const: msi13
>> +            - const: msi14
>> +            - const: msi15
>> +            - const: legacy
>> +
>> +        clocks:
>> +          items:
>> +            - description: Wi-Fi command clock
>> +            - description: Wi-Fi reference clock
>> +            - description: Wi-Fi RTC clock
>> +
>> +        clock-names:
>> +          items:
>> +            - const: wifi_wcss_cmd
>> +            - const: wifi_wcss_ref
>> +            - const: wifi_wcss_rtc
>> +
>> +      required:
>> +        - clocks
>> +        - clock-names
>> +        - interrupts
>> +        - interrupt-names
>> +        - resets
>> +        - reset-names
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,wcn3990-wifi
>> +
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 1
>> +          items:
>> +            - description: XO reference clock
>> +            - description: Qualcomm Debug Subsystem clock
>> +
>> +        clock-names:
>> +          minItems: 1
>> +          items:
>> +            - const: cxo_ref_clk_pin
>> +            - const: qdss
>> +
>> +        interrupts:
>> +          items:
>> +            - description: CE0
>> +            - description: CE1
>> +            - description: CE2
>> +            - description: CE3
>> +            - description: CE4
>> +            - description: CE5
>> +            - description: CE6
>> +            - description: CE7
>> +            - description: CE8
>> +            - description: CE9
>> +            - description: CE10
>> +            - description: CE11
> 
> What about interrupt-names here? If they are not expected, then just
> interrupt-names: false
They obviously wouldn't hurt, but they're unused on the driver side:

for (i = 0; i < CE_COUNT; i++) {
		ret = platform_get_irq(ar_snoc->dev, i);

So I will forbid them.

Konrad
> 
> 
> 
> Best regards,
> Krzysztof
> 

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCD68A448
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Feb 2023 22:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjBCVKW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Feb 2023 16:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjBCVJb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Feb 2023 16:09:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDCCA702A
        for <linux-wireless@vger.kernel.org>; Fri,  3 Feb 2023 13:08:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a2so5483685wrd.6
        for <linux-wireless@vger.kernel.org>; Fri, 03 Feb 2023 13:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2BiUcMD8Gl7xNduYrxgFh6P8/MvqGGdxXMYMad5DGg=;
        b=bAoCPRbAJBt+JF6p7NKN9nUbWJCzl9JgjlWwo4oWw0i1RxjTM5Xyd3hBMM4yK0bc1l
         sY9jd40kD0RQ8Zc9pcOCO63jt9iGEOwdzupNjIcDIjKO0HUTpuJtrF0AS5BMKq6thQjC
         xpJNWW49e1Cn9xfM4deqkZhVxJAcSsc2HaWIIxY54hveHg4XwKYLUU1ZTMkdxb4qWrdU
         +RnduDoAsaACX2CEJZaGjADO2ziICn4ZWlPKpvGSWLZ4BGDo+x4uF6muKL7dPTXzIpLT
         wGQRKyV4B5lNBKZF//ENrSNvuaKUPCfnHIrR51Yox+KHXIZqco/qTahBtFps/LzFulf9
         ooOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2BiUcMD8Gl7xNduYrxgFh6P8/MvqGGdxXMYMad5DGg=;
        b=Ih/nezExqgTdTWReCavBEx3QmcREwVk1jTw4cpiq6SqVr76KuLxDnOvR+MRZUCOS9V
         govp9QygIkJYENYIWJVIoecKO/bIDtEkA5YCsYPxVUT78hU9BOYi6bfi0Ui2DAAX5s0h
         O5Z8gqSzgipPaZxwG3md7w40YUPGJMv/Un7+iwOeo6/i20kzMNbNP/H8/zZkpbz/d7bp
         UYjaG7/Dr4Agr/GebBh5EKY8uhd0nNiunZCfJhMeVrwwLDadpQmYFXzAIzgeEcjsOZIf
         daIsQ6uZDKsKU63uZxCm5eDDBVYtCbKgYeafr5+XwKdmLLxj6l5KWHiPqTN8BgUKc+Dx
         7b+w==
X-Gm-Message-State: AO0yUKWh1lylxMRa1hUpnt/iXh/3jBDRS3I8PVgp+T5wPsbpfsb87YoL
        EeJwRTc4O/K8U8ERPPewj6rcyQ==
X-Google-Smtp-Source: AK7set9LoC2I3Ut0tnBQJCbcQRTGFMaNn+AQqxFQZJnMCPPocj+BKAfYbgUifsaihdzUDgpi6FNoQA==
X-Received: by 2002:a5d:6f15:0:b0:2bc:8130:ccb8 with SMTP id ay21-20020a5d6f15000000b002bc8130ccb8mr10578220wrb.40.1675458520814;
        Fri, 03 Feb 2023 13:08:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bj24-20020a0560001e1800b002bded7da2b8sm2882153wrb.102.2023.02.03.13.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 13:08:40 -0800 (PST)
Message-ID: <5651774d-3f60-ebb1-0613-83917d8c4bd9@linaro.org>
Date:   Fri, 3 Feb 2023 22:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH RFC 1/3] dt-bindings: net: Add network-class schema for
 mac-address properties
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mailing List <devicetree-spec@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>, van Spriel <arend@broadcom.com>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20230203-dt-bindings-network-class-v1-0-452e0375200d@jannau.net>
 <20230203-dt-bindings-network-class-v1-1-452e0375200d@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203-dt-bindings-network-class-v1-1-452e0375200d@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/02/2023 14:56, Janne Grunau wrote:
> The ethernet-controller schema specifies "mac-address" and
> "local-mac-address" but other network devices such as wireless network
> adapters use mac addresses as well.
> The Devicetree Specification, Release v0.3 specifies in section 4.3.1
> a generic "Network Class Binding" with "address-bits", "mac-address",
> "local-mac-address" and "max-frame-size". This schema specifies the
> "address-bits" property and moves "local-mac-address" and "mac-address"
> over from ethernet-controller.yaml.
> The schema currently does not restrict MAC address size based on
> address-bits.

A nit below

>          phy-mode:
> diff --git a/Documentation/devicetree/bindings/net/network-class.yaml b/Documentation/devicetree/bindings/net/network-class.yaml
> new file mode 100644
> index 000000000000..676aec1c458e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/network-class.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/network-class.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Network Class Bindings

s/Bindings/Common Properties/
Best regards,
Krzysztof


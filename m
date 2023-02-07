Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAF668D6A3
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Feb 2023 13:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjBGM02 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Feb 2023 07:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjBGM0X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Feb 2023 07:26:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08137F26
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 04:26:18 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so13349225wrz.12
        for <linux-wireless@vger.kernel.org>; Tue, 07 Feb 2023 04:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xYnHX1Erl5u5KfXsFsM2CCOcYE1hgAFey0pHbtrlGw=;
        b=a0bYF8vFZ81omWoSjjcDJcOsQPx0IJKXO2MNRiT9l9onGXaGU/wJv/i2K99OGIqcp7
         ihdwgekxx34k/NvtSiaofvZjKIRkq1Gr46OJM4n4ysLojX6AZ2xR1xvSjnBut7H/2Mm5
         8fi1YvW7KVgOJ1rXKQn7mg4bC89gcex54BUyX418qwHJ7IdMfDUxIXyFJ1oW3XbTbubd
         /ieHDCdsL1zjj0I/unn0HAHeDghr6unOEfRIAlgeJ2dj8xHT/gk42owOCUPeMedXbbyz
         j+AivNuy9YL3wEAIJ2NKTETQpyVQuPor+n9so2GzpBypaEyYTWGpIOrft7HAPnHDPCTc
         IggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xYnHX1Erl5u5KfXsFsM2CCOcYE1hgAFey0pHbtrlGw=;
        b=DP5MI6qNEss6oQlWGOU1FfSiRESvfVHGNlquepBwXe2ZaSLyGXjWEySXwVi+MJwXul
         opCqPmoW2Ob2aZmnOjAk74INrgESd2kn0tntzSW+EXOlWPhlZ3I4Updwph7GR/+hkfem
         8CjSt9az7DF+1AyRP3NLPfGwlpAf6zPT3L4ve4iB+4t430YRZMgy24j7K2WZaIJAC4b0
         v+R4KXlw2Raaj3zcS91N+cPJAIIMqRTSXvrrREujT4WfNcQQgp8PIjRgTp1qBqURf2Em
         LtnsFmOGqb3BQ+ZC0SZq152uXrHGGhYWjP4qvz4G800l1Vy5/0RUQV1NESdjO5uQ44YZ
         +5sg==
X-Gm-Message-State: AO0yUKUy5me3Ddy/KI0GZPYf2+R8Y+nShzQnUlnY+DX0AvGeCn20qn9H
        Mced8PDHG/k1Qfus2cnZZ86HEQ==
X-Google-Smtp-Source: AK7set88Lxl1qHumI/CfBw3/LLuxkMuEJHa+tXasBGB44CpUVlsBGzjZqivjRlNLNjNxDs0SM2+K5w==
X-Received: by 2002:adf:efcc:0:b0:2c3:e07d:46cc with SMTP id i12-20020adfefcc000000b002c3e07d46ccmr2519530wrp.41.1675772776749;
        Tue, 07 Feb 2023 04:26:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b002bfb8f829eesm11816006wry.71.2023.02.07.04.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 04:26:16 -0800 (PST)
Message-ID: <cd2f7933-6f51-5100-f7c1-cd9900e796e5@linaro.org>
Date:   Tue, 7 Feb 2023 13:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Aw: Re: [PATCH] dt-bindings: mt76: add active-low property to led
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230207102501.11418-1-linux@fw-web.de>
 <fe3673d9-b921-c445-0f5f-a6bc824e8582@linaro.org>
 <trinity-808b2619-4325-4d03-b2f5-1a7bc27d42ea-1675771928390@3c-app-gmx-bap02>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-808b2619-4325-4d03-b2f5-1a7bc27d42ea-1675771928390@3c-app-gmx-bap02>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 07/02/2023 13:12, Frank Wunderlich wrote:
>> Gesendet: Dienstag, 07. Februar 2023 um 11:40 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>> On 07/02/2023 11:25, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> LEDs can be in low-active mode, so add dt property for it.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>> ---
>>>  .../devicetree/bindings/net/wireless/mediatek,mt76.yaml      | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
>>> index f0c78f994491..212508672979 100644
>>> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
>>> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
>>> @@ -112,6 +112,11 @@ properties:
>>>      $ref: /schemas/leds/common.yaml#
>>>      additionalProperties: false
>>>      properties:
>>> +      led-active-low:
>>> +        description:
>>> +          LED is enabled with ground signal.
>>
>> What does it mean? You set voltage of regulator to 0? Or you set GPIO as
>> 0? If the latter, it's not the property of LED...
> 
> basicly it is a gpio-led mapped into the mt76 driver, but not passing gpio itself in this property (like gpio-led does).
> This gpio is set to 0 signal (gnd) to let the led go on ;) so imho it is a led-property, but below the wifi-node as
> the trigger comes from mt76 hardware, not an external (soc) gpio controller.
> 
> mt76 driver supports it already like i post change here:
> 

If the driver supports it already and it was never documented, please
state it. Your commit says you add a new property.

Best regards,
Krzysztof


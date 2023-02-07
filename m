Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE868D483
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Feb 2023 11:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjBGKjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Feb 2023 05:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjBGKij (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Feb 2023 05:38:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F96439BB2
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 02:38:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so9590312wms.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Feb 2023 02:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmtMaBV/sB8u/JUVv89jY+E+OuhfbbO4b2GTm4fpi7s=;
        b=q6j/uTmQf/BYJFJ6NP5V2dATSlkHK843NjxU/LGN5zJnSKO0DeWTWOYyaBoJWUBGAY
         mipjUzQofyKwbAy2aQXIhJ28FrFk+jJzZT7ZrsTrtgftd5kF+OWcd+aiVkZUw1NK488W
         0REJ3M4bHXizt65k3DQIovJ0ECRg6nyLhKDW+cjgbDU/6mRDE82nleA/JRIKrTmaDs5S
         YL50zEfmUAGJLGeATzcON5r6NDsENPeii8eL/UwcVnlqJ8gwFn+fOt5L7J7aFT9Vogqy
         EeP1/Ud/Wxw3hw5G4Aw/+qOx2660fwo4DYPoAm8ITziMOwqmjkGjaMe1cOKFZE59Oxk+
         NV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmtMaBV/sB8u/JUVv89jY+E+OuhfbbO4b2GTm4fpi7s=;
        b=3TYbYKoGmuvNDDWObwsoygeScokOWfqHv/BUrtaXL6bC5Tscv2pXauWpETi2xe5Ivb
         lyiwkGgrcmYamXLocynkayBbGM3M/Rn7ch2sc8ff7exblbbdnafqqPQ34X9wLyDlW41G
         MdddditnZJcMF2x6B/y8QrgidYcGm12E7An037/XtWZj5gBzFZKOz1y9ZleS9GDsImf9
         Vtj+juTIYeGQMEeS0gWJYAF/2yMLasLPFi1+S1elu3eS88z3aokqTWSX87jyvjsIqP+B
         ndlU5qNaK3zZb28//M4IrOIBEQIj7N8oZGOpByoR0gMHmaacP9OX+95+SoPKctUK1Jvn
         XECg==
X-Gm-Message-State: AO0yUKU/hNbj5mpZklX31/fZDtrwQk42FLza/LHXcjhQxNHCBpYkqUwK
        EQoSsDFmI62O1iKKastYu/LwPg==
X-Google-Smtp-Source: AK7set9AmSWcNXpqRqR+0WoOcGLaFXrGOKZhy8ROSChp8LM5JDz15yxOjZvLb4IegJyFlEcbGG65Rg==
X-Received: by 2002:a05:600c:330f:b0:3df:ef18:b0a1 with SMTP id q15-20020a05600c330f00b003dfef18b0a1mr3311962wmp.12.1675766287872;
        Tue, 07 Feb 2023 02:38:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c459000b003da28dfdedcsm14693201wmo.5.2023.02.07.02.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:38:07 -0800 (PST)
Message-ID: <059d7ff1-6ef2-02f4-0df0-bf14ebe33898@linaro.org>
Date:   Tue, 7 Feb 2023 11:38:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/2] dt: bindings: net: ath11k: add dt entry for XO
 calibration support
Content-Language: en-US
To:     Youghandhar Chintala <quic_youghand@quicinc.com>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230207103607.12213-1-quic_youghand@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207103607.12213-1-quic_youghand@quicinc.com>
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

On 07/02/2023 11:36, Youghandhar Chintala wrote:
> Add dt binding to get XO calibration data support for Wi-Fi RF clock.
> 
> Retrieve the XO trim offset via system firmware (e.g., device tree),
> especially in the case where the device doesn't have a useful EEPROM
> on which to store the calibrated XO offset.
> Calibrated XO offset is sent to firmware, which compensate the RF clock
> drift by programing the XO trim register.
> 
> Changes from v2:
>  - Added proper commit text
> 

I received v2 and v3 the same time - it's confusing. You did not fix all
the things I asked for, so maybe you sent exactly the same patch - v2?

In any case, sent v4 implementing entire feedback, not parts.

Best regards,
Krzysztof


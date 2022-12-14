Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC564CE64
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 17:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiLNQxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 11:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbiLNQxi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 11:53:38 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D31D0C9
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 08:53:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b13so11450493lfo.3
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 08:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKyXcYd+K2kl5Bb5coQGpJv+l4xIR6FutEGrVu5FFGY=;
        b=yNR5FYDsaaaKUaPntmJ32Bdj2u9KgiOAPzdSM22cPeX7PhWIMaWlUBsmG5nA3ubabK
         JH7yqFCxzX4h74547NCVMOz6rMsye1fDhzAmKh0tu9aSdSErpxoDDI1IxUBHVXMc1Rxn
         QlViBkxP7N7mmkhMaiTBdT/GnJsrbb6+VbdNU5pQvHcbEd0gYSWh59LHem4W6+sUC4dq
         QtscBqhTEh/H8pfU+OIEH/7ob6zXwIXeTBZF16/tJfTGcMzJF/pn0ZFetBAEp/LmouzE
         jSfv7cV+UdGJZXW4ftDpRM3kKwv+J/Y8YwQTqNOmTbL/uZOsDdJe37CKREvxd/+vv/dV
         x6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKyXcYd+K2kl5Bb5coQGpJv+l4xIR6FutEGrVu5FFGY=;
        b=5sBKEGrr1aZKlU1DNwmZdCpmv0RU9XvQNiC1cEF2MYxeZIqRmAfROeCLWy7oDvj4WA
         QmiBxr3QkKnSV85pLe2YTgMICiFvADQ2eFyBsGsS4vPDUdKhrZe7ZYaFIaEooKOp9/PL
         G/GG2vZutEXp0pXIBqS4DUg+YB3lPTklL0ucvCEcqQDNvx2h3WN2pemeUVqCMj3QaH/Y
         VsO3wP4nRw3yvowKA3JispYzqTNk30s+aRUiujl+0MXgkiCPqJsH5JjOX2InKxEDXFWa
         dnqg+rXicKnq3TVa48FY/PoZzcbArywOXpl48Cd3Xyb0G/rW+DCOMV6LE4s1tFrisRzw
         BaGQ==
X-Gm-Message-State: ANoB5plpu89YVA12hp4kTxFipC1Lvaa+/AqbDjo3giyyiPc5KPVRyFZH
        FVth8IXS2rzjxvrjd7XYS3kRiw==
X-Google-Smtp-Source: AA0mqf4Ed0VR9MqjGauPs6u5N1ZY7AZsD7oyKryCMesbCywvn5yZTG8Uy6EKvk2j2WUaMcUxJq3EoA==
X-Received: by 2002:ac2:4bd5:0:b0:4b4:a460:c995 with SMTP id o21-20020ac24bd5000000b004b4a460c995mr10408240lfq.5.1671036813844;
        Wed, 14 Dec 2022 08:53:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x6-20020a056512046600b00494a603953dsm875359lfd.89.2022.12.14.08.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:53:33 -0800 (PST)
Message-ID: <036c3985-0dcc-c860-4db2-22f0dd4550dc@linaro.org>
Date:   Wed, 14 Dec 2022 17:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] dt-bindings: bcm4329-fmac: Add ingenic,iw8103-fmac
 compatible string
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Kalle Valo <kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arend van Spriel <arend@broadcom.com>
Cc:     list@opendingux.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214155943.15418-1-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214155943.15418-1-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/12/2022 16:59, Paul Cercueil wrote:
> The MIPS CI20 board has a Ingenic IW8103 chip, which is supposedly just
> a rebranded Broadcom BCM4330.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


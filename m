Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548026A9179
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 08:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCCHMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 02:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCCHMQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 02:12:16 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6694634039
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 23:12:15 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id d30so6639905eda.4
        for <linux-wireless@vger.kernel.org>; Thu, 02 Mar 2023 23:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677827534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xi3e3zf8Klpq1iRcEdmcSTKwBOu4pz/Ei0EPeIx1fZY=;
        b=EZLxu7Y+iizjsoeGeUbmzPxbTlnTsVxbNP5WplEQkHBNoOsLzB62obZ9C7HjJdud77
         56/49ai23BGpoS36DG6EcSbmf63qfNq5oJWGrjeCcUiiqcP5s7T2Mro0aZ/J/j8ksgeI
         +bg2Y9ZjHQdv3oumc/D705agQ/kTIHtIJYSd3isGNZ021cdwZsiNraxSgOkprbG1/VSs
         Jy/A3i7jQicgkpkM9EZeoKOzBEgUtXQp/lpjyn7AuUuLTBZDpT2aSxgAtP6jsOAfs7BX
         anizbYYk4ixsFk47zhnqdrNzqaha1yJxtgSvDN8tkCbRbvXSD9EdiLHjOJXucHQh16pa
         x2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677827534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi3e3zf8Klpq1iRcEdmcSTKwBOu4pz/Ei0EPeIx1fZY=;
        b=yMlmOOQ7q2395/9aF1EutDNGxS3mRBNJDafbOFKQ+0ajEJSRG+LWdGGBK3b/q7ex6l
         n74/zOUH7+dcm2PZOep/wu60PHWKbyjL+w8WWNsO7HCZawvVzGjWzwAhiNevObNPDzzH
         KoQCr7HpPXXGja65x2mC6tpCTq5sy7pLR1nsdWhBS9dMnXld1CCJD9QmH8/jUMIegt0S
         0DWvNkmepVjWIEH48uXr4vT5Jk64oAAj2O70lG7RG+uFF2tPNd70z33mNYOxjHguF8xP
         5E/GhKnYEDXAZuUvEUe+wieLcamxl2y2+AUIAr6cjn4RlcP+clUCCHZeO4/x6qLdUaF9
         8IsQ==
X-Gm-Message-State: AO0yUKUEhPGNjpvvR6YfFHsMKlQWaGt15FgU6F4agxXWHxNzGGTx/s9U
        g9bKi7oVXikLedLlK7ZhPVNGFQ==
X-Google-Smtp-Source: AK7set+r+vvJNdv0SgAgspPvo26Cw4Qq2bYappwi6VBNmRDuHd2TtvD3UYnxUh2P0DnOzbQxgvzdAA==
X-Received: by 2002:a17:907:7289:b0:8e3:74ad:94ce with SMTP id dt9-20020a170907728900b008e374ad94cemr866444ejc.8.1677827533823;
        Thu, 02 Mar 2023 23:12:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709060c5a00b008ec793ac3f4sm614812ejf.192.2023.03.02.23.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:12:13 -0800 (PST)
Message-ID: <8e695c64-6abd-3c1e-8d80-de636d950442@linaro.org>
Date:   Fri, 3 Mar 2023 08:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: ath10k: Add vdd-smps supply
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230303024246.2175382-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303024246.2175382-1-konrad.dybcio@linaro.org>
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

On 03/03/2023 03:42, Konrad Dybcio wrote:
> Mention the newly added vdd-smps supply.

There is no explanation here, but looking at your driver change it
suggests name is not correct. You named it based on regulator (so the
provider), not the consumer.

Best regards,
Krzysztof


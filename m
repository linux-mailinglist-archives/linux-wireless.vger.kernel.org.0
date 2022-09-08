Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73155B1E2F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiIHNKx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 09:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiIHNKf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 09:10:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CCB659EC
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 06:10:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so27670946lfr.2
        for <linux-wireless@vger.kernel.org>; Thu, 08 Sep 2022 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=t/JKBcxHSoQ7FDdtMfQrLOO/w2yUY2K7brpbjLCBW3g=;
        b=wB0/xm+BFAcD2XB5PoeFrU35xabxoPH5MY/aClwkqocNit/9ca/fVThTgrVyElDYDx
         eOD9XCNIauq8D3pRD54qwbJ7EB9+M7HzOAs8tV7qYNF+M3xETgkmEBq1YtSHXSW3gZGU
         paDAxzfhGjwILYL8vhwcx0fxGMhulS/bqCPTGwzVm8VboQyhvoAyLvlX2uJuX+ki5ck7
         jlRQZZvX+Cl9isIy9rd6l5b7h2Z8+pZwrA65ssAvQige4qu91GkKKutJQGEpIFziHH/u
         6VvVto0w+yMzgMAHsIKmGlGjODmvMo/8wduU52OAT+zS2l88nZkegXlLgwnzJmkFnIlA
         fHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=t/JKBcxHSoQ7FDdtMfQrLOO/w2yUY2K7brpbjLCBW3g=;
        b=8N0DSp8NQlyKkIZOMttWipCjw9xtyjqSce6JpmVUh7ZaOqNQsv9jVdNcQ8zFUcVtKB
         pyHbNcMMe7+BB1rxCZ5xi4c+eL41wAweGBJ3Co/lQvmctWg0miQ2MfXiPPwQ1ouJjMSR
         pQ/TWppA2PrE6ttUm3eN1VjSlPzcC8fjGwax5hgwu+k5LdL8/aonrPuet9QOZUAMSr+o
         mzsArK3w3HIxNIUo1CicDiQEphzgCd/E3BX79esIBLi6ubZYlXD19bSxSGGy4EA+rv56
         +N0SkQfA0P8hoO3B2M9hmilVuZh23/TeG/PFMc6mPvmVk3C9hDDm1wEg8m8urkDJ2zLy
         NU8w==
X-Gm-Message-State: ACgBeo318IE+DrzG0ICLbeFOiAlZiJT5AqWJZgSouTgMLTfgciqbyRdv
        z1nJp8c76bgCGfrAP3VJM3Mb0g==
X-Google-Smtp-Source: AA6agR7PfVl1wFwXF97fp+T0/Q3Ytb8dUk7/qcr7ZoJskpRSpz89r6EhxlMehGqltA5bMJUI7xQjXQ==
X-Received: by 2002:a05:6512:3f85:b0:492:c17e:d566 with SMTP id x5-20020a0565123f8500b00492c17ed566mr2544577lfa.341.1662642612739;
        Thu, 08 Sep 2022 06:10:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05651c0b9200b00261cc85c32fsm3170324ljb.31.2022.09.08.06.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:10:12 -0700 (PDT)
Message-ID: <72cb0161-2988-b0fd-321d-96bb548ccc47@linaro.org>
Date:   Thu, 8 Sep 2022 15:10:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/2] dt: bindings: net: add bindings to add WoW support
 on WCN6750
Content-Language: en-US
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org, robh@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org
References: <20220902112520.24804-1-quic_mpubbise@quicinc.com>
 <20220902112520.24804-2-quic_mpubbise@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220902112520.24804-2-quic_mpubbise@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 02/09/2022 13:25, Manikanta Pubbisetty wrote:
> Add required bindings to support WoW (Wake on Wireless) on
> WCN6750 which is based on ath11k driver.
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

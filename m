Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B58A6FB6D3
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 21:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjEHTlN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 15:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjEHTlM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 15:41:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A659DA
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 12:41:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-956ff2399c9so938351866b.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 May 2023 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683574868; x=1686166868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6BHb4xVvMEfgN+9lRCelTqOTmzUYyfbAtctnb7HRBw=;
        b=CfsYd66/CQThuWNpAvqHi/MJfVOwNKqnCWFXJeAFfvAiraDwp4Jt5CBun22SMkPabl
         9dRNgNtAykAZuiW4gwbmcz0e/3iJjD34SxhtPshsDAwcYo2rxXe+GO9jALW/IXMeZz+B
         V1AfCxlclLF2SoyC3fQhoHmw9Ec5a0eya/S4PsSIVCb/RT7/e3U7hmpT4F8TvcsHqO40
         AsN+FQg9ezOn1IuuyjmcIx4QvNomc33QMqJ4D/Ucu6d8vRpfLfeulS8ZhB/sbhAwuQLT
         ik2Pzqjuxk7wSTwjyd9TMfq2D/iIPV/kFTKBU0uixzx6PGM6trE/eWWYfdHTjnsqnfhl
         hEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683574868; x=1686166868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6BHb4xVvMEfgN+9lRCelTqOTmzUYyfbAtctnb7HRBw=;
        b=RllFQMlgUuKFrgcOgISWHk7LFMojZ9wzzEwDOY8SfJfYQWARt+QRph4jFxy6g/HFxm
         Pgw8ln4rfc5VW77xvPQRj85WPUT5cO18p8s7a0iy0ewyHBVla2yaLLVHDw4EaAjQ2sk8
         AaX+3qYF6iOFVc7vDKj+uVRGcQZYuB9XjVK4ccBSCEC63M9xWsCQoHKCfX+4c19ME+av
         raKltd21JCWSUgQHbJokv/ZX/lGd87K4NENbk/HcIeMV2Fjk0ag31/HnxuMGldWhTQX5
         an78zMbFBBWufOK+VPk+fmWioWCczo4BQp9TnLL0rJ2+KDUlhynk/OasF6RM4n6D9ev+
         mxkA==
X-Gm-Message-State: AC+VfDw6Oibwbedri0pRXZqGPQRbhYUrjxdEbK+R+TrlwpFcfNnEOANc
        cEsARUs9gjWLsARxDi7y7Jh3AQ==
X-Google-Smtp-Source: ACHHUZ4UJvRAHo3YeIqDhqkX6D0qV+reh/JVVWha2vJ3gODEWTvlXChgbwidS5lcWcdtIEGMboCujA==
X-Received: by 2002:a17:907:7b91:b0:969:bac4:8e22 with SMTP id ne17-20020a1709077b9100b00969bac48e22mr785771ejc.26.1683574868376;
        Mon, 08 May 2023 12:41:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id la26-20020a170906ad9a00b00967a18df1easm352509ejb.117.2023.05.08.12.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 12:41:07 -0700 (PDT)
Message-ID: <5cf04ce7-c60a-51c8-c835-58f24e7c8759@linaro.org>
Date:   Mon, 8 May 2023 21:41:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: mt76: support pointing to EEPROM using NVMEM
 cell
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Christian Marangi <ansuelsmth@gmail.com>
References: <20230508155820.9963-1-zajec5@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508155820.9963-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08/05/2023 17:58, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> All kind of calibration data should be described as NVMEM cells of NVMEM
> devices. That is more generic solution than "mediatek,mtd-eeprom" which
> is MTD specific.
> 
> Add support for EEPROM NVMEM cells and deprecate existing MTD-based
> property.
> 
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


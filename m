Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8417F67327B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 08:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjASHcc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 02:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjASHc2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 02:32:28 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0411552B0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 23:32:26 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n7so937459wrx.5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 23:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOAGtEwwl9ah5X14+fr3xyjQkxYKgtW7wTdmd7LaFEg=;
        b=vRIRpio+Aom4lroZdxIv5dfYLWZdktfYVL3jHgETXcsxRJ2IKyD1BV36YuWKt8r1nQ
         +07wunX4ZC3IPo0SiFKP/4cW4rCUCfgTlN/S3oDPCkSQ31hkzmGIEBxm3gnmd4L6UmKl
         skGsnD6BenqldlGA2OrrmLySBX41OvAjMUQRJ8cUUO+fWk72verQOTsg+UiyW/fjh7X1
         z5zfL1pWRMbdqXu+TUTUh+4KfrCuKlXZ/i2QJReFETSj/UWiGssDGb/4JCGsPml6Njtc
         k+zsV+4nZoM+MsAECNOaZY1mX1Eygrw9Sjwbj8l1hy5tTux8/UmnXFK4RdG5XA8ZJ+a4
         Jxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOAGtEwwl9ah5X14+fr3xyjQkxYKgtW7wTdmd7LaFEg=;
        b=7ZfEbcEcaZHdNBNE+jVcl02H9y9uWiFgveTR9UqrLjHqrAtR3/ToQpgYzdYJbdVqoR
         yj7NxjKwnTTeoLJvwbUybW+UXeyInulmwKJIVyZrJT8IUMrVdg+fAecPXNGdwboPi/Ho
         1qKdgQYmMDnP87iYQtUqHu1BwLKwuOZzgtHq1fUs5OpiX6ERNmVLFLsMMvMRMAArogEf
         1cL8cFKFvFpDs3Tz3ma+pXdSle0lqNYrHVG5vxoawEjQW66V3V9J4CSYcqaJN/uJ01Iw
         cXOyCxpI3E9r4dNOCaspVHXbqf8IyevNYTKrZ7RZXlfF4SJ5j5Tkhthyv6Ma9Wv8Mx1M
         zKwg==
X-Gm-Message-State: AFqh2krGh6G1MfJPZegbiWF9nWZllpvJxSQ69/bi2XU/p1/NSuFQ/1c6
        Uq/nJDN9DIkSN1Hk9GKEsBVxfA==
X-Google-Smtp-Source: AMrXdXsYozDSX5UXzU8eViFCPgDNSOimFqf7m+5mZ3D5VIeY9Dv8lV1BtejtIKH3WhVddwYIOFPnhQ==
X-Received: by 2002:a5d:4dc9:0:b0:2be:21fc:ae3 with SMTP id f9-20020a5d4dc9000000b002be21fc0ae3mr7080130wru.11.1674113545389;
        Wed, 18 Jan 2023 23:32:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d404a000000b00275970a85f4sm32958865wrp.74.2023.01.18.23.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 23:32:24 -0800 (PST)
Message-ID: <0662e292-91b4-0b1a-f012-83cb2f316353@linaro.org>
Date:   Thu, 19 Jan 2023 08:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] dt-bindings: net: wireless: minor whitespace and name
 cleanups
To:     Kalle Valo <kvalo@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        de Goede <hdegoede@redhat.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, ath11k@lists.infradead.org
References: <20230118175413.360153-1-krzysztof.kozlowski@linaro.org>
 <87bkmv85tb.fsf@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87bkmv85tb.fsf@kernel.org>
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

On 19/01/2023 06:13, Kalle Valo wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> Minor cleanups:
>>  - Drop redundant blank lines,
>>  - Correct indentaion in examples,
>>  - Correct node names in examples to drop underscore and use generic
>>    name.
>>
>> No functional impact except adjusting to preferred coding style.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/net/wireless/esp,esp8089.yaml    | 20 +++---
>>  .../bindings/net/wireless/ieee80211.yaml      |  1 -
>>  .../bindings/net/wireless/mediatek,mt76.yaml  |  1 -
>>  .../bindings/net/wireless/qcom,ath11k.yaml    | 11 ++-
>>  .../bindings/net/wireless/silabs,wfx.yaml     |  1 -
>>  .../bindings/net/wireless/ti,wlcore.yaml      | 70 +++++++++----------
>>  6 files changed, 50 insertions(+), 54 deletions(-)
> 
> Thanks for the cleanup. Would you like to me to take this to
> wireless-next or do you have other plans?

Go ahead and grab it for wireless-next, please. Thanks!

Best regards,
Krzysztof


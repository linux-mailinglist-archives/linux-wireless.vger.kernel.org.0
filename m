Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5059F68D97B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Feb 2023 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjBGNgL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Feb 2023 08:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjBGNgK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Feb 2023 08:36:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DDF2528D
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 05:36:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso13176647wms.5
        for <linux-wireless@vger.kernel.org>; Tue, 07 Feb 2023 05:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVI9K8PTnFNIA9pBOwdmxa5ImYWaocXFHnfUICArsyc=;
        b=o//KoGPZUfzC+aaVmqoPmdDF3gEsLKbwWosUMg6bek/AA4Yrd8KHkISWUiJkXmwKNW
         sHMRYnI8ksoYk2iP9kg41StksvoqVcEdy8IV3qeONv9hdlfr3RJYvNb/SRM+NHqWWv9L
         SchKchF+G4Ag4QRlh7ttPW6/5XILWWW3a+S7wRKOKgZKoiAnt7/4gOEct+FIGtkaq6CZ
         5loXQWPNCn+UnHry0EXjVRT8hjV2sey78lctBneVVrW/k2a3bReMNMs2s9QndbQaaaMl
         iJ+H2EjJGe0EclobqFIe/3ynpomFtuRhNF3FsJ2kToT1Yg3Npu9FQwFOXgiaUhAhJdHf
         0z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVI9K8PTnFNIA9pBOwdmxa5ImYWaocXFHnfUICArsyc=;
        b=MOujP31FvSdx0G8Ybj1c0FfBNrr6MTHs58/bgazxWuff+7GICmsAMT65AWEyWxtQxD
         hS4Y9zDfvZWJM84p0PPLI5BPGzeKuo6adOub98lZKvaVPmU2MmDg3c/pZy1MHXMhMWq8
         f2b7wTuGFrwZs/UhIvde6RZYBnhvbyxDCHSe+jZx9a0Wg+aQHFhkv7bC8SUksactcl9h
         dgZLDLJw20U+58U6UQacl+d883tpd+gjs3Jv614i5v+dbQTTBo9N9b58upEDh3g10Hf5
         Fs4sr/8r6Xthgwna+RYwNwUFAbFW+svm5PLwMx8wW1sgWfdytiSbddmQYIQiO/AhV0Cc
         63aw==
X-Gm-Message-State: AO0yUKXxh0KQA8qEyISGLtZ9uUPz2iN3rpuLPn3Mg4y8knTugtA+Ji4N
        P+VUAfincMCfgm2nQzo6+zrkWQ==
X-Google-Smtp-Source: AK7set+XnY7pfbNfFjLHPCUL8D1u9EwDQ3lhz21ktvYLT+GXdOmtMNVGdaRInzpMwcC+w81j3R+1wQ==
X-Received: by 2002:a05:600c:330a:b0:3df:de27:4191 with SMTP id q10-20020a05600c330a00b003dfde274191mr3115551wmp.16.1675776965685;
        Tue, 07 Feb 2023 05:36:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h27-20020a05600c2cbb00b003db12112fcfsm15385748wmc.4.2023.02.07.05.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 05:36:05 -0800 (PST)
Message-ID: <7aa132aa-d2fe-e2a1-a2a7-97321a74165c@linaro.org>
Date:   Tue, 7 Feb 2023 14:36:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: mt76: add active-low property for led
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Felix Fietkau <nbd@nbd.name>,
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
References: <20230207133504.21826-1-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207133504.21826-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 07/02/2023 14:35, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> LEDs can be in low-active mode, driver already supports it, but
> documentation is missing. Add documentation for the dt property.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>\


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


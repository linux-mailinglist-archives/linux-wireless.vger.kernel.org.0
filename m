Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31F167C7EA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 11:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbjAZKBs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 05:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbjAZKBq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 05:01:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8AC1E5E3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 02:01:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d14so1183368wrr.9
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 02:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NsWprYGbD2CwVtouO/ULFCeYkL3Y+haM/y2Caqpemeg=;
        b=Os1KoXQjpreDSiLtuaFezS6DeTwNWR4AfM2jEUgbJZkNEVRksxLtyeQCNovtFebOEh
         wOSKcgPr2DbKeI3tKATnADvslZ1FLjK7d/IFOuvFXJ4A4ves+HMDN03qGrQFA1q/Enk5
         bolq0rD1HKwV+X7Kqo+O0A2cBP7grN+0VQVRwasbM0lweMmEYTe8A7tiEPlEfGr8u4ki
         EvrcIBmP1CjInD4ZOzIelz2N48YF7KacnZgrtozKsl7GEeYLwRw+1qQcEjUNFEfRTmID
         wEXosltCx70IOHfZO0dB6rm8qqQKgq8ULcZ91FmA06uV/aKjQe/Ql2F1Pf4CUvpn2fr5
         dHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsWprYGbD2CwVtouO/ULFCeYkL3Y+haM/y2Caqpemeg=;
        b=uZ2hddJSeSrPfnVtHc4ZUDMoCgANZDL5t+CTLsjzSePxw/HHaiixlZUIhEbiWcvtj5
         7N3Fn2SEtVvtq2wpv2A80zi/3cr9WotijtkgSj+RQaPATh/j0aKoak7IYQO2Zto2XMln
         CcLuSLukQCu+5vYEgilWtdqHUFrRBJlzHiPIfIxn/CAfEro/ckVXrt16uDZc6fMuBkLm
         4v9yKKTg6vCdBSVLy/Li8U30IaFKBb8R3YlcbMR/6r48266/1lT6vW/Z3dUWKQ9TqtyN
         fNuSVCFRqarxzRrEcY7OULVuiVOp8tNke9KprHvWiEN6/gGuIPtaxrlKdIRDeo9YlIBo
         0laQ==
X-Gm-Message-State: AFqh2koqWDjsrP5ZE2ydgm7qMm3pJyfhyu5r3DNU/lq/ZfLTQDygMKeS
        nNNXMXWt9CcZ3uCKwJZWwhrDZw==
X-Google-Smtp-Source: AMrXdXvCvQt1/kQ6w8atcLGXtdqYVKC9LQPXMiFfg0gMdaHu78to3mc/9L7myuVJ8vBjW3N9ZXLifw==
X-Received: by 2002:a5d:4fc8:0:b0:256:ff7d:2347 with SMTP id h8-20020a5d4fc8000000b00256ff7d2347mr38309901wrw.13.1674727304037;
        Thu, 26 Jan 2023 02:01:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm960081wri.34.2023.01.26.02.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:01:43 -0800 (PST)
Message-ID: <60d87ac5-ddd6-706d-e13a-3431024bca88@linaro.org>
Date:   Thu, 26 Jan 2023 11:01:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] dt-bindings: leds: Document Bluetooth and WLAN
 triggers
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Lee Jones <lee@kernel.org>
Cc:     patchwork-bot+bluetooth@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        robh@kernel.org
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
 <167460363944.4058.4676712965831302643.git-patchwork-notify@kernel.org>
 <Y9FG5Wg0PmP4zfV6@google.com>
 <CABBYNZJEU-GD5J6K8_Ur4PWLvP10VNJGP7e_43H0=W3DOS=PNw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABBYNZJEU-GD5J6K8_Ur4PWLvP10VNJGP7e_43H0=W3DOS=PNw@mail.gmail.com>
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

On 25/01/2023 20:23, Luiz Augusto von Dentz wrote:
>>>> While at it, move the mmc pattern comment where it belongs, and restore
>>>> alphabetical sort order.
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>
>>>> [...]
>>>
>>> Here is the summary with links:
>>>   - [v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
>>>     https://git.kernel.org/bluetooth/bluetooth-next/c/ef017002b93b
>>
>> Why are you taking LED patches through the Bluetooth tree?
> 
> I assume there isn't a tree dedicated to dt-bindings/leds, not to

dt-bindings patches are supposed to go via subsystem (with drivers) or
as fallback via Rob's DT tree. The subsystem here is LED, so the patches
should be picked by Pavel and Lee, as maintainers of LED subsystem.

If the subsystem was Bluetooth, then the patch would be for you. I hope
that clarifies.

Best regards,
Krzysztof


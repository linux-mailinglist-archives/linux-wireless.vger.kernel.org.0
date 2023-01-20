Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE65F675A2F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 17:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjATQkA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 11:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjATQj6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 11:39:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FCD423C
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 08:39:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q5so701719wrv.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 08:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGYySup8p6S2QLbw0VKiZbUhVbWmQ+yt84mNVfAu/t0=;
        b=UApWjzlXda6CKOsxYSAekXBHCiPYv6pVkiWHbI7PK6NXlDBf2dZaBDBu3pcMBX4Dvp
         6pVJCoYaf28tSrmY+cQXTcE5NCML/7/aNdhPsd9f1zZGxwjZ8KtIc0zafg1CDt+MmL1t
         ht+1uJ+qps8er08SQIPj8jCpqo9gs3doYVucXRacX8doWIlUzIZI6fYKJoTuT8NrG42t
         MEw5W4JoUE4dXTKy6NU3b03SLyKAPuoCmZGqaBryF9fm76CMUuyzmAcMzhe2Gc9aBSvv
         rVqHAHr0IWrNPbn8V79yED7CryU1Vk3Sen0HSlqKLB5YcHIC9rN/57uXiyLuvli0/Rbt
         Yz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGYySup8p6S2QLbw0VKiZbUhVbWmQ+yt84mNVfAu/t0=;
        b=RWf1V4d2kpQgccG2GU1oOkLu1XR7FRDLNYyDjC54ZTkk5sZq+2ycEmyfnwduxpaN2v
         8a8dbNykMUpOFc6/IvSgNASEoMA/vtiYyeEux81Zq0o7ufy+AZllCuRrWQfsyoojqZ3w
         GK3fsK4U2xTH6khXhlgl2V/VuT27VDU855WrvDc4yPGTEjivGVw4N+tr0+6owNPt0q+U
         AZrbhYq6jwCRFbh0u506jZfrUtxCXDRhAF1l9JWg9l7YGLRPkxVyDbNKbt7+hFSYUXwz
         n1/CyK56ZXGAU5BIe3hnDlYh0a9x4/iEbnavO0PmAQTRwe4Rpe31SmFJJL5hAmAhrscd
         m9wQ==
X-Gm-Message-State: AFqh2koskVPka1ZuidqdtMDWiGGlDvEI0dLVtByHeTIXf83pvY/cHxdm
        bS+CxT+BQAuYWt0eOZTUiezPjw==
X-Google-Smtp-Source: AMrXdXtZ9DWblZSaKSzMSMqI/0YMAXlKAx5MWIAT7Z2mmChtlRMs75VNjLqzEiOVvNoaJZ95nuiIUg==
X-Received: by 2002:a05:6000:98d:b0:25f:8ead:96cc with SMTP id by13-20020a056000098d00b0025f8ead96ccmr14507795wrb.70.1674232794812;
        Fri, 20 Jan 2023 08:39:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z12-20020adfd0cc000000b002bdff778d87sm13385996wrh.34.2023.01.20.08.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 08:39:54 -0800 (PST)
Message-ID: <0bb76233-062c-a1c5-da88-4f04feccd5b2@linaro.org>
Date:   Fri, 20 Jan 2023 17:39:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] dt-bindings: leds: Document Bluetooth and WLAN triggers
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <a85c256af01f64389a078c2b37c3b72a27d97536.1668005062.git.geert+renesas@glider.be>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a85c256af01f64389a078c2b37c3b72a27d97536.1668005062.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09/11/2022 15:46, Geert Uytterhoeven wrote:
> Add the missing trigger patterns for Bluetooth and WLAN activity, which
> are already in active use.
> 
> While at it, move the mmc pattern comment where it belongs, and restore
> alphabetical sort order.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: bt_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> 	'hci0-power' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> 	'hci0-power' does not match '^mmc[0-9]+$'
> 	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
> arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: wlan_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> 	'phy0tx' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> 	'phy0tx' does not match '^mmc[0-9]+$'
> 	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml

This patch got lost... Rob, Lee or Pavel, can you pick it up?

It's with Rob's approval:
https://lore.kernel.org/all/166861772609.231295.14812410099261417331.robh@kernel.org/

> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
> index f5c57a580078ea23..d34bb58c00371402 100644
> --- a/Documentation/devicetree/bindings/leds/common.yaml
> +++ b/Documentation/devicetree/bindings/leds/common.yaml
> @@ -98,9 +98,13 @@ properties:
>              # LED alters the brightness for the specified duration with one software
>              # timer (requires "led-pattern" property)
>            - pattern
> -        # LED is triggered by SD/MMC activity
> -      - pattern: "^mmc[0-9]+$"
>        - pattern: "^cpu[0-9]*$"
> +      - pattern: "^hci[0-9]+-power$"
> +        # LED is triggered by Bluetooth activity
> +      - pattern: "^mmc[0-9]+$"
> +        # LED is triggered by SD/MMC activity
> +      - pattern: "^phy[0-9]+tx$"
> +        # LED is triggered by WLAN activity
>  
>    led-pattern:
>      description: |

Best regards,
Krzysztof


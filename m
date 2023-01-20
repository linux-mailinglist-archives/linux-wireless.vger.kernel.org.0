Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD7675FA7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 22:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjATV2X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 16:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjATV2W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 16:28:22 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7C413525;
        Fri, 20 Jan 2023 13:28:20 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o7so6862567ljj.8;
        Fri, 20 Jan 2023 13:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L6XTbctyjJuiaEzlBOG1ARAyGnfelnTEYPz3b788Q50=;
        b=jkyTlGVIJzztnDFFrJNnHyxRnrtmCbyk3jOf5SUuvDV71gDGIHYAT9gKDThokvojYQ
         NbniCrDCFhv0+oYTu2ExkvtsoHzY3FvjzsfvpVWkV0Admv4yiX/m8RYzbb5MHmpPXk9Z
         fsBG6eTMZ/iAgD66ERU3UO1yx8igBJxhjmpMRlwz0epMLs5VUxBBoH9qu4Fywb90Zzeq
         DoUse+wahv+6vaxle4kT9fXMgqrhp+M+qgqPR2rXIzROY+ZfvP5nJv96dlf3felIrN3d
         /jbB19KXFQj4ErcSKw/MJ/aUG854BdpqBwV87GAXU6Rv/LxIxLTvjT/+Lopa2JOSA1c1
         bM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6XTbctyjJuiaEzlBOG1ARAyGnfelnTEYPz3b788Q50=;
        b=rLGrVfJXjeVrPd8z/OSrXqHxptMXMqvohP8V2VZWi7b4Y96Yk+WWleYAot/9d3ZrEC
         OJUaUabA5KAben+KariJob934zbe94VX/o7Q/6UVnZZT5pC6yFuETppsFCXj+lWOpuwe
         ODNgQYyxHa3O4nwlM3OPp5VkT9TyTuDK3nlGWDSgSHxdJsSzTm8vTurOVvZiHfXWVGvk
         p780etH4+X/j7wh3Sev1tw9TU0X72xVFicibhqlbHNQ0pKeFMOpYoh/wMX0Lvdl4MBgZ
         JwPqTdYJsRMBl47cgTVbKH3hjCAAZuP6YRSrU4KNqxbgQJ5VN0ZMsCCwfn2S8sryjbqB
         /3rg==
X-Gm-Message-State: AFqh2kp5JbcWQBG/DbaOekHw07t+eoayQJkq0gso8NChahidFhnNzYk3
        pK5nT9kkAAWrfAYnG/ihd5g61hUTDNGyb1pCVa8=
X-Google-Smtp-Source: AMrXdXvbYs0GsrXDeFVwrDWcr/ZKXKHi4GXDCr076tjbDWyLo6wIxf7LwFWlW3g3q3cFLgPGCLjJFF/gKeQxPEoEg8M=
X-Received: by 2002:a2e:b94f:0:b0:28b:88b3:2ead with SMTP id
 15-20020a2eb94f000000b0028b88b32eadmr1389772ljs.293.1674250098612; Fri, 20
 Jan 2023 13:28:18 -0800 (PST)
MIME-Version: 1.0
References: <a85c256af01f64389a078c2b37c3b72a27d97536.1668005062.git.geert+renesas@glider.be>
 <0bb76233-062c-a1c5-da88-4f04feccd5b2@linaro.org>
In-Reply-To: <0bb76233-062c-a1c5-da88-4f04feccd5b2@linaro.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 20 Jan 2023 13:28:07 -0800
Message-ID: <CABBYNZJX+9SxW48qSSmyyMa7_bvqzwHafa0BNOz4Kz_Jc+gu9Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: leds: Document Bluetooth and WLAN triggers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Krzysztof,

On Fri, Jan 20, 2023 at 8:42 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/11/2022 15:46, Geert Uytterhoeven wrote:
> > Add the missing trigger patterns for Bluetooth and WLAN activity, which
> > are already in active use.
> >
> > While at it, move the mmc pattern comment where it belongs, and restore
> > alphabetical sort order.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: bt_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> >       'hci0-power' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> >       'hci0-power' does not match '^mmc[0-9]+$'
> >       From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
> > arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: wlan_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> >       'phy0tx' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> >       'phy0tx' does not match '^mmc[0-9]+$'
> >       From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
>
> This patch got lost... Rob, Lee or Pavel, can you pick it up?
>
> It's with Rob's approval:
> https://lore.kernel.org/all/166861772609.231295.14812410099261417331.robh@kernel.org/

If it is going to be applied via bluetooth-next make sure to resend it
since last time our CI was not able to apply it thus why we didn't
apply it in the first place.

>
> > ---
> >  Documentation/devicetree/bindings/leds/common.yaml | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
> > index f5c57a580078ea23..d34bb58c00371402 100644
> > --- a/Documentation/devicetree/bindings/leds/common.yaml
> > +++ b/Documentation/devicetree/bindings/leds/common.yaml
> > @@ -98,9 +98,13 @@ properties:
> >              # LED alters the brightness for the specified duration with one software
> >              # timer (requires "led-pattern" property)
> >            - pattern
> > -        # LED is triggered by SD/MMC activity
> > -      - pattern: "^mmc[0-9]+$"
> >        - pattern: "^cpu[0-9]*$"
> > +      - pattern: "^hci[0-9]+-power$"
> > +        # LED is triggered by Bluetooth activity
> > +      - pattern: "^mmc[0-9]+$"
> > +        # LED is triggered by SD/MMC activity
> > +      - pattern: "^phy[0-9]+tx$"
> > +        # LED is triggered by WLAN activity
> >
> >    led-pattern:
> >      description: |
>
> Best regards,
> Krzysztof
>


-- 
Luiz Augusto von Dentz

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63DA67BAD5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jan 2023 20:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjAYTYQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Jan 2023 14:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjAYTYG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Jan 2023 14:24:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521172696;
        Wed, 25 Jan 2023 11:24:05 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g13so30642112lfv.7;
        Wed, 25 Jan 2023 11:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAJi7cEGTjWV9IwRKrSvkgUo30I57ewaSMmGfmlLHz8=;
        b=ApzBh8gBTYGfEWKkWdM/Y4W/yfXXkI+4ImSbMg90yw+tjGtOcGF7SZotKBxDJbIxAP
         3cdkiQAmacyGU+Hy/NdGgFPMXaxOTSVpXuL6h6Q+TWCDzJ5SG1PU2Jm3Zz3aNb9wf9SC
         dBPf2JxjtQ1+mPgEULT+B8LPFCFLVdtnKZFO5+jHxF1K8YYwPOG9STr6CO4DKn/DuJcx
         l8N8KmQRqQ3QguZy2NHFoU7zhazTHmqXQ/LWTiWuAIbuHQlU75xLQWTIcxdy0iDcJqNb
         uIRp0v07jU67lbeQ90jn0Li/zW4Z5KIBahG4S76OxnNRZalXQiMVx0yATN4iqaCpbUzo
         pCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAJi7cEGTjWV9IwRKrSvkgUo30I57ewaSMmGfmlLHz8=;
        b=mOqyyiQ+tPAe8y9a8UAUBjCcjper7cpATSI9G1Yf6kRS/lOf31vIW1otU/DsNTW+OK
         0b2Lro8qMo1aolKzaxPAp9HgsZpJGZey610IhI5pzoDQlzk/yQ+tCIQ1/TCh8Xord/Zj
         ogeAAvYuk8U866WomuB+/66Pnw/lb1yGGmSC4Zuqyx+wtns88aNhGeLEaw1KcwZSPm55
         Y/QACpKH7kzXnsTe2WGbrUbLd301Kcv6m4bYEFJvJ//USdYjDp0DGEdDEQu00JodvUS5
         H9w3XLcHfG2kJADCFXKaXFB1dmmLjVhHLuiWEj7gHCYup3vKd2O5Vjo4RD1TOgVweY38
         pPAw==
X-Gm-Message-State: AFqh2kpMGc+5LQ7o5cY1moouXuaB3vywDYO9SKnX+73h/jMPA2wxoaeO
        53oR84W8DXPpUvRib1501JXM0mHH9eMQeHkcNDs=
X-Google-Smtp-Source: AMrXdXteIrzvZmGI6O5UtF7QO0OPrziTlpj1+GX6WXGxrIX3DEQLDEJ+bwSCrGld4MObdjle7crCKAp+KMyDP77JqfY=
X-Received: by 2002:a05:6512:3683:b0:4b5:bc2a:8bd9 with SMTP id
 d3-20020a056512368300b004b5bc2a8bd9mr1468674lfs.121.1674674643511; Wed, 25
 Jan 2023 11:24:03 -0800 (PST)
MIME-Version: 1.0
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
 <167460363944.4058.4676712965831302643.git-patchwork-notify@kernel.org> <Y9FG5Wg0PmP4zfV6@google.com>
In-Reply-To: <Y9FG5Wg0PmP4zfV6@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 Jan 2023 11:23:51 -0800
Message-ID: <CABBYNZJEU-GD5J6K8_Ur4PWLvP10VNJGP7e_43H0=W3DOS=PNw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
To:     Lee Jones <lee@kernel.org>
Cc:     patchwork-bot+bluetooth@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lee,

On Wed, Jan 25, 2023 at 7:16 AM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 24 Jan 2023, patchwork-bot+bluetooth@kernel.org wrote:
>
> > Hello:
> >
> > This patch was applied to bluetooth/bluetooth-next.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >
> > On Sun, 22 Jan 2023 11:47:27 +0100 you wrote:
> > > Add the missing trigger patterns for Bluetooth and WLAN activity, whi=
ch
> > > are already in active use.
> > >
> > > While at it, move the mmc pattern comment where it belongs, and resto=
re
> > > alphabetical sort order.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/ef017002b93b
>
> Why are you taking LED patches through the Bluetooth tree?

I assume there isn't a tree dedicated to dt-bindings/leds, not to
mention this was submitted to linux-bluetooth and nobody else other
than Rob reviewed it, anyway I'd be happy if the dt-bindings patches
would be handled elsewhere.

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]



--=20
Luiz Augusto von Dentz

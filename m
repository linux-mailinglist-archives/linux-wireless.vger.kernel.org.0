Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EFE645B2B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 14:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLGNlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 08:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiLGNln (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 08:41:43 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E34F59FDA
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 05:41:37 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3bf4ade3364so186383727b3.3
        for <linux-wireless@vger.kernel.org>; Wed, 07 Dec 2022 05:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kn1p+IVvWqlI637G9jIMKYU716vuO0V62drRjoFhCPM=;
        b=ycRReAt60k7aPQ/oMqIosB80F+w0oxBS0ApL+Wu0BnRGOyhEzd8mq4Bii2fKsR6dUM
         yF4tYWCV5rmYESNrR0s5qJpzoaRrClXz6ukpUyrpf4jdJGFhEdkKfV63q+L7gUWxipHx
         ijkgj8lUl82PQf8GSNnNHNeB1wWbHbyQnbGNmGvvJl4wMot9FaPkgnB2qD+B+gIZjlK6
         GwVR3vdHfI4e2EBDsfVY3HghluaCMfJOLfTRHCqApj/zDbDDFY2/Pfl+sCiLgZnuWH9Q
         zRpobDRSKZGAfb7oeVCKzOJOysmffqNSoIr700LuC/mynGwAxqOZWiRq7xz/ksbUEuQJ
         zZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kn1p+IVvWqlI637G9jIMKYU716vuO0V62drRjoFhCPM=;
        b=EFlsFjmCV84Fo66jeDJwznsq1GBKg3pb/BJ9Q6uR1hdujhu7i8EUnQeQLsg2sILQ5P
         F0Ulu5wjk+WmOxDekrusb3ewJLwx6L/uG9AFXx9y3YN6PDSDq1J/17dPmOcgu5Nrariu
         dPok4z78EjUZW5ZJ11NNF7BpLM/svyP9XXPvy+gPJxQcIFfftBZBPkJVYR8sa9gDsFh4
         9uk51OkjCRpub1M+GU8Wd3JHZ4wzVxzcN0b7yn3sXOAvG9QXILE47kA1gLx74SAeZ/Vz
         G7TGhvT4qe/6BxKr9Et1LwYakbb0NzYzmmjbatz4PKrXc/TfZj9tTSKOWjWa7CVfOY5b
         Xwxg==
X-Gm-Message-State: ANoB5pkY2gKUI2i04uiM1vPHZ+5zZ4aRyjG+gN5zf5kIf30iu743JzuI
        4CfaL25itqrbM9reoYywW28oYVz80numY4OqE9b0Fg==
X-Google-Smtp-Source: AA0mqf6ZRKEbCIfBOSqFVWs/YQc+F3iFX8hpADfuE4QT0Qn6r2GO1O9/5PuSjN4SgDf8hLkvhvYLP7hWkWffLta01c0=
X-Received: by 2002:a0d:d751:0:b0:3e8:76df:4afd with SMTP id
 z78-20020a0dd751000000b003e876df4afdmr16195175ywd.380.1670420496630; Wed, 07
 Dec 2022 05:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20220921001630.56765-1-konrad.dybcio@somainline.org>
 <13b8c67c-399c-d1a6-4929-61aea27aa57d@somainline.org> <0e65a8b2-0827-af1e-602c-76d9450e3d11@marcan.st>
 <7fd077c5-83f8-02e2-03c1-900a47f05dc1@somainline.org> <CACRpkda3uryD6TOEaTi3pPX5No40LBWoyHR4VcEuKw4iYT0dqA@mail.gmail.com>
 <20220922133056.eo26da4npkg6bpf2@bang-olufsen.dk> <87sfke32pc.fsf@kernel.org>
 <4592f87a-bb61-1c28-13f0-d041a6e7d3bf@linaro.org> <CACRpkdax-3VVDd29iH51mfumakqM7jyEc8Pbb=AQwAgp2WsqFQ@mail.gmail.com>
 <d03bd4d4-e4ef-681b-b4a5-02822e1eee75@linaro.org> <87fse76yig.fsf@kernel.org>
 <fc2812b1-db96-caa6-2ecb-c5bb2c33246a@linaro.org> <87bkov6x1q.fsf@kernel.org>
 <CACRpkdbpJ8fw0UsuHXGX43JRyPy6j8P41_5gesXOmitHvyoRwQ@mail.gmail.com>
 <28991d2d-d917-af47-4f5f-4e8183569bb1@linaro.org> <c83d7496-7547-2ab4-571a-60e16aa2aa3d@broadcom.com>
 <6e4f1795-08b5-7644-d1fa-102d6d6b47fb@linaro.org> <af489711-6849-6f87-8ea3-6c8216f0007b@broadcom.com>
 <62566987-6bd2-eed3-7c2f-ec13c5d34d1b@gmail.com> <21fc5c0e-f880-7a14-7007-2d28d5e66c7d@linaro.org>
 <CACRpkdbNssF5c7oJnm-EbjAJnD25kv2V7wp+TCKQZnVHJsni-g@mail.gmail.com> <184eb88b1b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <184eb88b1b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Dec 2022 14:42:53 +0100
Message-ID: <CACRpkdYzRFYMMydtSGiPLWiLywt9jtY89vPz8cdZcvwczo5=dA@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: Add support for BCM43596 PCIe Wi-Fi
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arend Van Spriel <aspriel@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
        Hector Martin <marcan@marcan.st>, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
        "Zhao, Jiaqing" <jiaqing.zhao@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 7, 2022 at 8:42 AM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:

> I am actually preparing series of firmware patches. As most chips are EOL
> those are newer, but not recent.

Excellent, I'll test them on my specimen and see what happens!

Yours,
Linus Walleij

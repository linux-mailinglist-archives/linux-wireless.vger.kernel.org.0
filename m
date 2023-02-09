Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6878269056D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Feb 2023 11:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjBIKok (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Feb 2023 05:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBIKoA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Feb 2023 05:44:00 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB41E68AFC
        for <linux-wireless@vger.kernel.org>; Thu,  9 Feb 2023 02:43:47 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-520dad0a7d2so19600587b3.5
        for <linux-wireless@vger.kernel.org>; Thu, 09 Feb 2023 02:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tNSj88tAbE2c6y06Ms9sAOyNH2UyWm+Nrt13hPQ8iWI=;
        b=HJPsu/Wz/435Gl3W5fT4LJ0iVcWC4lhFzEpUL8YyaR7PHlvhZ83ixgxoByTXAid1J6
         Q5GAhluj0HC3PbE1r/44Y5Po7Dcqxzy82TkQMMXBgK87a8FhdSiUApImVIBuCtr7BiYC
         dQLEBtEZdWctRXxi6/C2opdxP4i1uwAWHCHdDSA/D1SRv93/BupZ5BhMYI4QvWArqCap
         jvLGTJwRxDNHq2E5jYN8fkuP96FlRR3JcB7Y5i9dj53kAAZKJ1YJN62fLu6KRbhOa9LI
         tP08YGlrCMdjGNwfJa+qKCNB8+CEi1mdDPS1pUUWPuKXJEJYoVbW8egTh0v2xuSgaBHI
         mAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNSj88tAbE2c6y06Ms9sAOyNH2UyWm+Nrt13hPQ8iWI=;
        b=RqRZnxk2EuaNr53vaICR82a4bzb9CFCRAx3po+5Q8+f1EjEq9TB38cU1FMCy8uujtG
         3eDaw3/NNNwTtKV6w9aIPhw2zZK7nKFXQy+EDWIMERglg1pXCMB+ji4WniTPrprsIprw
         yzTKCfvN4xB+TtWegtqXg9f5paS07eBu5xR1RyjcxE4j98fVnbOBWfrgvjd5J9j27snI
         Xs1qlQUkaOIylncbvwV3nHf0KBWhuvqvot3cxXjdJr9oL/6pybI7FhvKxxk9y0gxO5fj
         Kjq1uWvLPyneFxzwdVcz/Q6ETwqhvooCdiuUbWOqBIJzvd91CceJLWPw6Jj6u6g5PsCn
         WObg==
X-Gm-Message-State: AO0yUKUwS8skczlE0JMmF1mSkOmSngGBk6K/EtEugVkIWELQispzGeq2
        aBy2oqTzVSM13qG3NT3pIkg0YGHi5pZtAmBYIGn6MA==
X-Google-Smtp-Source: AK7set9ymol3+anqgOuNHLyeYoAoKJBt8lF4LiRuMMBcOpRzV7KXZewKH5NE/Xez2syh1Qjfl7P5JUsj0CNKmumi+ig=
X-Received: by 2002:a0d:ca01:0:b0:52a:ac51:c6d1 with SMTP id
 m1-20020a0dca01000000b0052aac51c6d1mr903762ywd.477.1675939426884; Thu, 09 Feb
 2023 02:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20230208173343.37582-1-andriy.shevchenko@linux.intel.com> <20230208173343.37582-14-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230208173343.37582-14-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Feb 2023 11:43:35 +0100
Message-ID: <CACRpkdYvZyon5hkgbks0dUqY8QsfrKcuU048LHRPg=UwLezE-A@mail.gmail.com>
Subject: Re: [PATCH v4 13/18] gpio: reg: Add missing header(s)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Michael Walle <michael@walle.cc>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Keerthy <j-keerthy@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
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

On Wed, Feb 8, 2023 at 6:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
>
> While at it, split out the GPIO group of headers.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

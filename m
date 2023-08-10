Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70333777770
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjHJLnq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 07:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjHJLnp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 07:43:45 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0613AF5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 04:43:45 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-583fe10bb3cso9985127b3.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691667824; x=1692272624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL36QLiViprzn+D+ZWCkWvBnqNCptB0lN73iKQuirFQ=;
        b=y7kCnI69HxExw+MxsiCIfcA49blmdcjUyl5SS0/8bRbzfkNopPZTw4lvFNhr7Jr9VT
         QIudvkr6xe24/0japmubXLvd4/OmMJuTl1bb9UsZAQHDmrKizjE34aYrbYPXdGGCGllY
         0J6lqmp58uUGSJM9uqiLjO2sr0MWS2M7bdc7VHcdzGTtUYllOvtLCWDUwO+NrXgllXxo
         RaIC8utmFE2Wzzkl0AYpSJjhBa2GveWIUstkLFW/4NWchwSU4bSAzWvCdkggyxEIVDpn
         WhcGue46u/fi1AoMhC1mUVMQ0saQoFncgBSqRSUG5kKsgJPyj15Oda5qM1RkkkaWBT+V
         v4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691667824; x=1692272624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oL36QLiViprzn+D+ZWCkWvBnqNCptB0lN73iKQuirFQ=;
        b=kjZ4LI6sLWtA4NPT4klfVqQQXXYDNYEQjTIeL8/uDjq1tnvfA2hWtrUeDjKKibTKOB
         FERkbIuHFyIJqWTwCqegcNp/SH/nktFMIFiOLIJhzYiBTvY0YuFqTWcZswKSqrO6dzhd
         hcwHo39ngdBwQJX1mEfdVP3TIN+zaFOPc1redL5B14vUxU9w3gVokZFwwnh9f8Nk+roa
         DLXcwyMeDEP5tNlDFVFxErrZFovymmYBmqd4plAfaEmz0yunc56XlRXn/9AoXf6QfgUw
         hgP6WfBK++HAZPmwaxEqyCIHc1nLNsk5rfeBkuR0L3qzIY81tWbektVm1+lQ1Hx79bQY
         3ufQ==
X-Gm-Message-State: AOJu0Yy77MjThmvcbbU+Xo0dbyUaMKYZ8+AqT3r7MCs987kSQnCMpoYb
        MZghhrIE5dD31a0q5CuKabzvbqip5GH3cIBC2iSdpQ==
X-Google-Smtp-Source: AGHT+IGWqccxb4eaBa7viDsBH2qiuOr+FG9TqsbGIftGtcqIE8Z07l9Awkx2SSQ1v2jf3lFLrsuig7uobLg7jc9ceaU=
X-Received: by 2002:a25:3786:0:b0:d1c:77de:cf7a with SMTP id
 e128-20020a253786000000b00d1c77decf7amr2082342yba.64.1691667824245; Thu, 10
 Aug 2023 04:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230810081102.2981505-1-ruanjinjie@huawei.com> <20230810081102.2981505-4-ruanjinjie@huawei.com>
In-Reply-To: <20230810081102.2981505-4-ruanjinjie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 13:43:33 +0200
Message-ID: <CACRpkda_9jKvew2EzqHJa9Bs7cbV4TAZx9s5AoxTdbbV=0g1CQ@mail.gmail.com>
Subject: Re: [patch net-next 3/5] net: gemini: Remove redundant of_match_ptr()
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, clement.leger@bootlin.com,
        ulli.kroll@googlemail.com, kvalo@kernel.org,
        bhupesh.sharma@linaro.org, robh@kernel.org, elder@linaro.org,
        wei.fang@nxp.com, nicolas.ferre@microchip.com,
        simon.horman@corigine.com, romieu@fr.zoreil.com,
        dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 10, 2023 at 10:12=E2=80=AFAM Ruan Jinjie <ruanjinjie@huawei.com=
> wrote:

> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

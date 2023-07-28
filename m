Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ABC7671C6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 18:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjG1QXV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 12:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjG1QXU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 12:23:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B592D60
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 09:23:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992e22c09edso310642666b.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 09:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690561396; x=1691166196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUijDPBpqLO1eo5480diEsMJwuHY/OnKbfOc5VucfMk=;
        b=T3l6Qf3NJ2jmmJMEInQ2/aG72ilw/aPg6lhGGoQVD07zsisCQRmRA4+sqi4QLEf4kM
         fXSmhvHB3+wkgnkxeZ4R6NdeGrfK9HAHr+vCFqnoEfsOwmFM412HHOMCduYTnj6sPCjq
         4VZE5YscacjkFfrEb4pgVcfFVSdXgDPDGc78s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690561396; x=1691166196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUijDPBpqLO1eo5480diEsMJwuHY/OnKbfOc5VucfMk=;
        b=QBBSmSYrHbocBif2bsG1YyFrsMOM40kqbP1zYH+j/6HsUX822F3o+UdVDLZba85Qrh
         RR7dIA/TGWda1RMzcYGKtEytntv9ViLAC63i7/QegWk5POlJVi5DKiL6J/eMDjIDK7sy
         NUFZvuof3Myw2bnXNmotWpz8x9TK4mc2w9lgCydhcVb3QjO1oofojmKkJ1irT1AmhFME
         5704aRVFPIeZkZgGM4mt5wMBPDaWjX+6usEtagb1JUZJLJ+DI1GzoNZ+aaNbkBEU5idm
         u0ArVlrcuSk3LR2KMAfpJgmbP/FFI1GCO3IsHxDRoofTI4/xM1ykvzBTwewJmTSXWLmZ
         u7jQ==
X-Gm-Message-State: ABy/qLZNSK9GS9iXWQzqQf+WyY5Rxf/q1fepR6WqgLyzZCw4bRTjt8T2
        /q3FNIVc5w9GxXGhuZ2ZNxHKRkU2e9Z0kN2wCBw=
X-Google-Smtp-Source: APBJJlFC6bkYLqY8A/LQ1qs9sVCJ5f7iGO0vGpyx7Gqk9RI++EwaEA0tr7d1kVzgQhGAMvSH/TmBHw==
X-Received: by 2002:a17:906:3f1b:b0:993:e94e:7234 with SMTP id c27-20020a1709063f1b00b00993e94e7234mr2206684ejj.77.1690561396021;
        Fri, 28 Jul 2023 09:23:16 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id s13-20020a1709060c0d00b009930042510csm2199621ejf.222.2023.07.28.09.23.15
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:23:15 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9923833737eso311197666b.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 09:23:15 -0700 (PDT)
X-Received: by 2002:a17:906:30c1:b0:98e:16b7:e038 with SMTP id
 b1-20020a17090630c100b0098e16b7e038mr2853607ejb.23.1690561394846; Fri, 28 Jul
 2023 09:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <PA4PR04MB9638100B3F21D083F386C6D9D106A@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB9638100B3F21D083F386C6D9D106A@PA4PR04MB9638.eurprd04.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 28 Jul 2023 09:23:01 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMx46aLztpKHqtS_Ab_yV_0GvRdWinf4C9o=9zqtTGehQ@mail.gmail.com>
Message-ID: <CA+ASDXMx46aLztpKHqtS_Ab_yV_0GvRdWinf4C9o=9zqtTGehQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: added code to support host mlme.
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wait, your company can't afford to have anyone respond to maintainer
mail for years [1], but you can afford to add new features? Crazy.

[1] https://lore.kernel.org/all/87sf9j3wd1.fsf@kernel.org/

On Thu, Jul 27, 2023 at 11:19=E2=80=AFPM David Lin <yu-hao.lin@nxp.com> wro=
te:
>
> 1. For station mode first.
> 2. This feature is a must for WPA3.
> 3. The code is tested with IW416. There is no guarantee for other chips.

^^ That's not a good sign.

> Signed-off-by: David Lin <yu-hao.lin@nxp.com>

>  drivers/net/wireless/marvell/mwifiex/util.c   |  74 ++++
>  14 files changed, 558 insertions(+), 13 deletions(-)

> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -28,6 +28,10 @@ module_param(driver_mode, ushort, 0);
>  MODULE_PARM_DESC(driver_mode,
>                  "station=3D0x1(default), ap-sta=3D0x3, station-p2p=3D0x5=
, ap-sta-p2p=3D0x7");
>
> +bool host_mlme;
> +module_param(host_mlme, bool, 0);
> +MODULE_PARM_DESC(host_mlme, "Host MLME support enable:1, disable:0");
> +

I hear Kalle doesn't like module parameters like this. They're a cop
out on properly supporting features (also, see your own commit
message). I'd have to dig through the archives to find the latest
advice and rules on this.

Overall, I'm not enthusiastic about this change.

Brian

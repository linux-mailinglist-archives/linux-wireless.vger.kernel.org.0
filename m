Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3883E778A04
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjHKJee (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHKJed (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:34:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9037526A6
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:34:32 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d63457dd8b8so1623519276.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691746472; x=1692351272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smN+SCWW2lKTSARYfwTP+xuBJ9NW+4x7+X95r/DL53w=;
        b=K282RvNdEnW7n5QERUHuFNXOJydN1zwNIvZe/Cpivm5a5uRi4o+lZ/cAvgJQ/926R9
         wL+afDgiAQZxh/vPgwU6rwTMvAFg6DBHzj5qpuzWbjGIXBKkV4qI0AdhCNCWLul8GnwV
         Aedm0zoyHDYdb9S96BgdM3G1PV2xoATPSa2EERgQfXN8Dlq5azOYi6nfkj5gMxx484KD
         FCZ4Kh1QlyKbtQWq9EUvsbYhi1D+eYDx4cFNr29YZTlwMDdodUOp0G7qU3Dg+/M/YacN
         DE8t9ZWDGvf2xfctOURuH8+LO+WgLw0+QTaks2WuhljncCsDme/szqTPDdaIQCsi8yjo
         mEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691746472; x=1692351272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smN+SCWW2lKTSARYfwTP+xuBJ9NW+4x7+X95r/DL53w=;
        b=VD6E2fkyKBtw7PaXokHGbvBRGnJ6axVyNGCUzDCWGZ4p9yuVZaQ+ntbxUL3nSYyTSJ
         eIp6PYhvWCJsiW8ixA2fcpOXnpiaBaC3nLpJkoqSE/KWGYHD+yx7NcvViX1euFMdNQG0
         ++MPjdhIlfxmudMVvUGJrE8mGLm+Ec4tJ/+QJMKYv4YHzSwBr1PTf1wbDlTktUZfv9EF
         4ijBq/yK0PcJX7i9SIsWAoq1DsMHiAP6696tBo7J0aeGwXqNmgdzsYdz2rpBZZFsGRLV
         iaGHZJlHK9dQlgTOcdJkCN3LUOd6CiyVTLVLQ0Wnk8qd8RuIpaVwupMJjxOjNY+b/uVg
         KZMg==
X-Gm-Message-State: AOJu0Ywe/3qCO+shHXL0rMeSuPwFS0yYNe71lJA5A0awqR2KC7bv0mvQ
        1y+M+OaydOVqNUpRB/eNfZzcHnSu3r889YYRCWryHg==
X-Google-Smtp-Source: AGHT+IGjowQEzSv7PVwIHlKiu413nF9rlr3/ZMr5eI0rYZsr7D7PvUEmpj08JdXt4Jpa2UlmUQgdfaJzQGcTaYVim0Q=
X-Received: by 2002:a05:6902:565:b0:ce7:919f:38f8 with SMTP id
 a5-20020a056902056500b00ce7919f38f8mr1190723ybt.52.1691746471825; Fri, 11 Aug
 2023 02:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230810081656.2981965-1-ruanjinjie@huawei.com> <20230810081656.2981965-2-ruanjinjie@huawei.com>
In-Reply-To: <20230810081656.2981965-2-ruanjinjie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Aug 2023 11:34:20 +0200
Message-ID: <CACRpkdb+LMN=WRzLXGwWb_U5KhKpUVmcjNsvHk-3eb-PzbLYbQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] net: dsa: realtek: Remove redundant of_match_ptr()
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 10, 2023 at 10:17=E2=80=AFAM Ruan Jinjie <ruanjinjie@huawei.com=
> wrote:

> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

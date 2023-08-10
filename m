Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C8677776B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 13:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjHJLnJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHJLnI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 07:43:08 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171E3121
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 04:43:08 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d465b3d50efso695577276.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691667787; x=1692272587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL36QLiViprzn+D+ZWCkWvBnqNCptB0lN73iKQuirFQ=;
        b=qRFkbYuqL7ggurMP+JBfz/Q97CexZe6yk/1Z2oUlieMSuXYSgWT0X6/WxxflEBXQKw
         7GqGyxVLN2cBVH1mV1HJoectovdstuhGkLbiVv5vbRu1RxQXyf4GcsggOxCQM6gPOZeY
         5463j1hhtGiYyz3rZ/KqBtk7VDLuQ4Ep/NUeOw3ONRxZExPzorr0qX9PDVn4uu2KlRsU
         t9MnGbSiM5aRrHm5gDem/mmbEMMITnqC7SrhxyWzHgnQhRcF3aG9pHC/F3G0U/xvfnoO
         gcEktFIu5kf62bYF535rxJjSYia54CEIGfFwFX0J19CEaFcwZ/GYv4svdmGwi4XHmGR7
         NzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691667787; x=1692272587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oL36QLiViprzn+D+ZWCkWvBnqNCptB0lN73iKQuirFQ=;
        b=OtrkjvFTpXmT/Fix+q0d4lzPqZms8pBevSPmM5fVFCKZ/Qa6OxBwqVL2O48M5dDgqX
         ersnODGWrHw3AvQaQub6PZRptJWs30x5yz51xPQJYpbZ+YRhwc8gDpAGkSHy0h8xbcg5
         qNAdONkfpsvgJRQIvcrnlNqQxRfgLE+rO/LUfUeL3RUIfcNQ7YHVJIoBVEo1mVZRIEq3
         nzYNMsZtG2ncj43kRCp099o0Qkc9TXHaWeW1zfQf2WXjmSxOtRL/eUFANzB13ztOophQ
         ceA+lKdj9ncRgTFmWkwmKCQ+9M3WV8AwzyPourRAygs1eCkzo9Y2RN7i9m6wg3kz+aPq
         8g8Q==
X-Gm-Message-State: AOJu0Ywt7VVIqoG1FA27xGdzu6RTpMm6DM13UAwa1Po59fg7jtNeYjIg
        SqlTdTSNN+3gyWPZJm2fzg/hdUBcjh2GRM/kslrQdQ==
X-Google-Smtp-Source: AGHT+IF33zszTEy6qxiqNv7L7RWHO25feaifS32PLUxt1xLMJx8ywh8Ip+nh/ZGptVv7/qgWjOvPSRff7nYWXVcaYAI=
X-Received: by 2002:a25:2402:0:b0:d0a:fa7f:2fbf with SMTP id
 k2-20020a252402000000b00d0afa7f2fbfmr2136189ybk.48.1691667787296; Thu, 10 Aug
 2023 04:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230810081102.2981505-1-ruanjinjie@huawei.com> <20230810081102.2981505-2-ruanjinjie@huawei.com>
In-Reply-To: <20230810081102.2981505-2-ruanjinjie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 13:42:56 +0200
Message-ID: <CACRpkdafBPVQ80A-qwYjF_ZOBM6vj-cqgZ49FEGB-bL7Z2-gqQ@mail.gmail.com>
Subject: Re: [patch net-next 1/5] net: dsa: realtek: Remove redundant of_match_ptr()
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

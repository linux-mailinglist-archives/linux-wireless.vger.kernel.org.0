Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E945762BB3
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 08:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjGZGlv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjGZGlt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 02:41:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4782132
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 23:41:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe11652b64so328224e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 23:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690353705; x=1690958505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3y/22I2v93+TWa6s1CXf0qTViEqrmWtHnFQP2RiZStM=;
        b=F03SUx2bWrNf/WDpUhqXyukSjU5FCI5ihDn/7rzZohIgM3+ICxFJ4nM7NmsfA/iT8S
         Rep8k9bXe8gXhw7P/Q8L4UYgOzBQ9YuGrNoHrTNfoJGwFpPYXbQx7GCbJl12m9Fc7wkp
         nDfJYhLNz/HqbwkF5DNJXOZop8Kkhz5DBh8CxCywtad+ZwkhFf8aA+M9RM1Rgcd+WOdP
         2F6D1KAwG4xuYVHiH9+MZfg7RKTSk9Dg2DwT7VR5IHMXEFJ8GdHfbhHzrWbg1mZOv1fn
         f38V43iuwVPWaYqHXQdaorL0A0TrDPr+AR1SnfyAadXGNs94XWeYYS+G93bvsyr5ILRs
         QPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690353705; x=1690958505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y/22I2v93+TWa6s1CXf0qTViEqrmWtHnFQP2RiZStM=;
        b=Se/4igxd3lEOp4D7ik1W9RY9uAyVkdVPmclHGbpD4BymfgLQSFYlEqqZuF48ttlGgM
         uczPJ4rdsa+mQA+CahWsNQ0mjUtXZz5j722zxkTU6Por/b3+dDJcK7JVrfp5Flq3SUqZ
         URH8znnSxDwTupkikJD41vsG6gAfwF/wQ8ruHkQ0snrzwJa8JekxuI7zYA1YGH9u+Xe5
         0BtRNBzuV+3UfSREcOojoNJZ3shb5KXYb9PUTbh36fO0KPoanYiHbAQTzrlrFWBfvCfR
         IFMPZtTguaU2BbUUP2jYZc1hmPY0z75Ghh361L4ZQ2s9sVVppL2x2/O7TZWuNfXMV0Wp
         gp+g==
X-Gm-Message-State: ABy/qLbbB1s/aee0yf3AFPHybL3aio3BFRBCP6VYzjs4hxRzl6dEstD9
        0+RA6ilk3MsxDzdFKOLUKCnsQva3B2R8S0kXo3moMw==
X-Google-Smtp-Source: APBJJlGzOjHjb9aiiq9rLMjcCYZohEXYqsGAsfrlAhqhGFGRUC/tHxEDwJrVtT/8u5/kP1c1LDwhAL7CANzQ4WuVjzQ=
X-Received: by 2002:a2e:7a08:0:b0:2b6:d137:b61c with SMTP id
 v8-20020a2e7a08000000b002b6d137b61cmr730329ljc.39.1690353705569; Tue, 25 Jul
 2023 23:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230725131258.31306-1-linyunsheng@huawei.com>
 <ZL/fVF7WetuLgB0l@hera> <20230725141223.19c1c34c@kernel.org>
In-Reply-To: <20230725141223.19c1c34c@kernel.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 26 Jul 2023 09:41:09 +0300
Message-ID: <CAC_iWj+3kDccXSG2ADmu7KDDjN6MuitihwcEjYeyRLqrUbxBjg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations from page_pool.h
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jakub,

On Wed, 26 Jul 2023 at 00:12, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 25 Jul 2023 17:42:28 +0300 Ilias Apalodimas wrote:
> > Apologies for the very late replies, I was on long vacation with limited
> > internet access.
> > Yunsheng, since there's been a few mails and I lost track, this is instead of
> > [0] right? If so, I prefer this approach.  It looks ok on a first quick pass,
> > I'll have a closer look later.
> >
> > [0] https://lore.kernel.org/netdev/20230714170853.866018-2-aleksander.lobakin@intel.com/
>
>
> I prefer the more systematic approach of creating a separate types.h
> file, so I don't have to keep chasing people or cleaning up the include
> hell myself. I think it should be adopted more widely going forward,
> it's not just about the page pool.

Right, my bad. We share the same opinion.  What I meant by "this" is
the split proposed by Yunsheng, but reading my email again that wasn't
very clear ...

Cheers
/Ilias

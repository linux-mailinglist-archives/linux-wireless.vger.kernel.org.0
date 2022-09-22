Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036E55E6313
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 15:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiIVNCi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 09:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiIVNCe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 09:02:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C41E7E30
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 06:02:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lc7so21052391ejb.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Axq7H5qz5D6MI0EvsspJL8ldneb6DxIs8+NccRlNB8M=;
        b=dqSSc6KryNasQyX1LZJMFlF7m/rNJUtAffJyAUoMBDimtf0+3cI7dTvSiTiWKWCN0i
         RlMIMePJSOJfG4D74Nsls8N7Du4yGXGO9bktr8bJSMzNwM83KDdiTFtnYyw6JwPgwQ3/
         myQVeiSvZ50JEQPpDYZsmxH9907qXs2zENRpJ+oFNgTmwqpc5JBOnuKwjibDsXvhfaM+
         w78WRl9he5dNTEH9AZZV0DHDxj2GlxOHlRgZ4ZEZOkl2liwgU2SkXRw3IVC/8w3LtsEj
         /Z0Y4Fd4Xb8HyGDORAO5fm9miCmI2CC71f4AizNxASDwokOQMEyqoaWaLFdhE1Y55xjF
         1Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Axq7H5qz5D6MI0EvsspJL8ldneb6DxIs8+NccRlNB8M=;
        b=loBx4wcmnnXSUTxvGbeXeRrbLRcuQKccBSZb8H895ff/vPH/DBumsB9zAKo6Nkbpb/
         6Jd0aAWP20fF06rD1uPu5uFKiiwI+Ny8cXKUPE1CJgyxc2fZvVDGYOa0YVTvGmA3h9FC
         ytvn2TM6gvn1qbueN3JxwWrJCRdFX6/yui2NbDNjS+mBT8BF7EvkkeAhX+mKQqevvVSR
         RdAtl/VR59Ws87Xzruzz/F9/hF142r0akkNSfBtdoZ1tA9NjrfDRcbZKPBb2sGpTT3O1
         3kjhOBE2+tv6voOv4mmoIaU6MyR/E4HjtMvRrF+K16IRHdATMywcJVmLhvU5k2/94W4C
         OPuQ==
X-Gm-Message-State: ACrzQf00R87ZyXRyangUxld5BPnptGqKeyIxoQdYVizCaCf/ptHCpvt4
        oTligjOK6hmgvSw7d4K7DD+d86EMUt6Rz8tjjlg60Q==
X-Google-Smtp-Source: AMsMyM7RkeIoN5xxevDwjYJX0lGxQvtMfhzR0neHfBytZ84vtKjk+/z8r1Kekesvh6EJiuWsJNac81XrXggbBytFgIs=
X-Received: by 2002:a17:907:7f19:b0:780:375d:61ec with SMTP id
 qf25-20020a1709077f1900b00780375d61ecmr2712125ejc.203.1663851744518; Thu, 22
 Sep 2022 06:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220921001630.56765-1-konrad.dybcio@somainline.org>
 <83b90478-3974-28e6-cf13-35fc4f62e0db@marcan.st> <13b8c67c-399c-d1a6-4929-61aea27aa57d@somainline.org>
 <0e65a8b2-0827-af1e-602c-76d9450e3d11@marcan.st> <7fd077c5-83f8-02e2-03c1-900a47f05dc1@somainline.org>
In-Reply-To: <7fd077c5-83f8-02e2-03c1-900a47f05dc1@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Sep 2022 15:02:12 +0200
Message-ID: <CACRpkda3uryD6TOEaTi3pPX5No40LBWoyHR4VcEuKw4iYT0dqA@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: Add support for BCM43596 PCIe Wi-Fi
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Hector Martin <marcan@marcan.st>,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Marek Vasut <marex@denx.de>,
        "Zhao, Jiaqing" <jiaqing.zhao@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Soontak Lee <soontak.lee@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 22, 2022 at 12:21 PM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:

> Also worth noting is the 'somc' bit, meaning there are probably *some* SONY
> customizations, but that's also just a guess.

What I have seen from BRCM customizations on Samsung phones is that
the per-device customization of firmware seems to involve the set-up of
some GPIO and power management pins. For example if integrated with
an SoC that has autonomous system resume, or if some GPIO line has
to be pulled to enable an external regulator or PA.

To the best of my knowledge that customization is done by consultants
from Broadcom when working with the device manufacturer, and
eventually they roll a unique firmware for the device. Probably because
the firmware can only be signed for execution by Broadcom?

Yours,
Linus Walleij

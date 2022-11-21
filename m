Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CA563247D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 14:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiKUN5U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 08:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiKUN5F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 08:57:05 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32188C6226
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 05:56:43 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-37063f855e5so114204437b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jlH/ifTu/FLTB5L1spq7VRw6rvpie65so4YRzgc4QSI=;
        b=akLiFosYnQJXe9tkoa/OWBXS5ptfSIap3HYVKtyInGNBTYXRzhOzhnKUAPq/b8HSZb
         rOwe/TSon6bjcMKApslR+Sya8nCJIFWezKRMW4OUlHfAe2aspilZLroUh9BLNByI3qyd
         PUzgUYoVOOkuiirFatTo6LKqq+iaB3PnQOOySgtwThKojiGLAduKIuBdZfn/JG3CwFTX
         pdcO5leUF4CzQT9PJhwm1OYXpzIKoFfcZLfNSO1RUdx3by0LRyQtY1u/YFZyX2W1KU7a
         g36W4Aa0kYrCyry39il7ryM4J3m3hRffSh8cMZn4U7gv6qVLyEIqBAGVIqpsy/hhici1
         F2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlH/ifTu/FLTB5L1spq7VRw6rvpie65so4YRzgc4QSI=;
        b=mIjESEBPmemwDD2LsefmXmnFkO/+N+9LWhLrZscbOPm0DZeImygXBma75N3uzlvWFx
         GlQpGUl2R2M4k4Hq9AFaJqqN4HB4apKiBGt3n9i5vYDSjbqFKTkLAO/yjptPweWqYGAj
         RuwrOJAJ731d0INPRQ0bDUUDZvpis+4r7eY2w016m2D/+uWHEMAek4MmJwo8+xhKgeQG
         /qo7xNi+zCP/8XnP9fy44J/p3qwuemuOKONIrEvQW3yL1yLKQ4Fo6mnm4HmhnUjx6FAx
         5iLwtawWUd+8mRobrrnr1F0HWWxb5c2YfgsFIgdwsCK7PGMq+rOIWWL+AQoVvEf6CnPF
         7bHg==
X-Gm-Message-State: ANoB5plB/Bvvog567kaL1CQZRMUVa7x9DyBKthwS9ZxyITLpRRw7IcNX
        ImOMzIGx4/R5FhUBXUDD5+Z9d4QFxthIXWLxU0c0DA==
X-Google-Smtp-Source: AA0mqf7+mR5x25sBj43LTg4uwnKXH3/SDAlxwbcgb2oDbe7MUcFN3rlu/+9aKUPJF6baasbA8XKdSXvF73XwlJLW6CY=
X-Received: by 2002:a81:7909:0:b0:36f:d2d9:cdc4 with SMTP id
 u9-20020a817909000000b0036fd2d9cdc4mr1434125ywc.380.1669039002452; Mon, 21
 Nov 2022 05:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20220921001630.56765-1-konrad.dybcio@somainline.org>
 <83b90478-3974-28e6-cf13-35fc4f62e0db@marcan.st> <13b8c67c-399c-d1a6-4929-61aea27aa57d@somainline.org>
 <0e65a8b2-0827-af1e-602c-76d9450e3d11@marcan.st> <7fd077c5-83f8-02e2-03c1-900a47f05dc1@somainline.org>
 <CACRpkda3uryD6TOEaTi3pPX5No40LBWoyHR4VcEuKw4iYT0dqA@mail.gmail.com>
 <20220922133056.eo26da4npkg6bpf2@bang-olufsen.dk> <87sfke32pc.fsf@kernel.org> <4592f87a-bb61-1c28-13f0-d041a6e7d3bf@linaro.org>
In-Reply-To: <4592f87a-bb61-1c28-13f0-d041a6e7d3bf@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Nov 2022 14:56:31 +0100
Message-ID: <CACRpkdax-3VVDd29iH51mfumakqM7jyEc8Pbb=AQwAgp2WsqFQ@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: Add support for BCM43596 PCIe Wi-Fi
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
        Hector Martin <marcan@marcan.st>,
        "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "martin.botka@somainline.org" <martin.botka@somainline.org>,
        "angelogioacchino.delregno@somainline.org" 
        <angelogioacchino.delregno@somainline.org>,
        "marijn.suijten@somainline.org" <marijn.suijten@somainline.org>,
        "jamipkettunen@somainline.org" <jamipkettunen@somainline.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
        "Zhao, Jiaqing" <jiaqing.zhao@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Soon Tak Lee <soontak.lee@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Nov 18, 2022 at 5:47 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:

> I can think of a couple of hacky ways to force use of 43596 fw, but I
> don't think any would be really upstreamable..

If it is only known to affect the Sony Xperias mentioned then
a thing such as:

if (of_machine_is_compatible("sony,xyz") ||
    of_machine_is_compatible("sony,zzz")... ) {
   // Enforce FW version
}

would be completely acceptable in my book. It hammers the
problem from the top instead of trying to figure out itsy witsy
details about firmware revisions.

Yours,
Linus Walleij

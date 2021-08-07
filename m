Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC63E3785
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Aug 2021 01:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhHGXD3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Aug 2021 19:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHGXD2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Aug 2021 19:03:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A68AC061760
        for <linux-wireless@vger.kernel.org>; Sat,  7 Aug 2021 16:03:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g13so25882453lfj.12
        for <linux-wireless@vger.kernel.org>; Sat, 07 Aug 2021 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAiujPmqeW3PmmspEt40oMN8MqX4NV81C5A1ROIdZ0U=;
        b=q13/JTHNnDdAUQ8FMHMv94aMulxrrbmg8lHOfJ1FtGBaBdf6/Gn1tpXRSt3EBPMfpP
         ynddBI03PBsjuvLxG21Bh7YLafFnN7ciL2YTK1rDPhFughsxqIrlQRDeDR7O9xRIIwpg
         zKpOhIuinSGJY1nnalR1FZHIqad6YHHpaynNIBbkSNYvp+GFRecBenQDV7nWJ5GwJY6e
         RhAVkbZpqkH7cuY4Cxxoass6abWbh4fZwgoviysXaFMjtw740S04Aq6iqFTSdL8irD9z
         yzB2WKT8JgT50rNRp+FoHvmSLkMfMcAIdMfnDZS7U68TeHdaAqdZeQ1yOTYYadAJb4k0
         rmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAiujPmqeW3PmmspEt40oMN8MqX4NV81C5A1ROIdZ0U=;
        b=hK9kQ6zQ0LtxaW5+rcwO8eKdBWnASlhXHUoeoA15gbaccRNWIBp2pzIow+rvQouGWh
         feozGwytQJwUqJCqIrsA1pYYeBYb9IAz5DFQmtcHJ6zh+42UcUo5Tpzq6v4a6+gtW8Y5
         96aIVUz06Ga1ZSdsCUu9ZKpD24/82RrcIHvtEOFntXRyd/Xe8kfOzyQIpMiMbaIoI1Ve
         cH9Q/SR3BEeynI38lpow0GjZZmYjKZ8TbUbVXBakMOTVce6dqs84Qt5M7Dq8SM/6prJt
         pdmuN6U5lqz8zW6+2i1MlmAFAp652FPSI/UU0G5u6iiAcRIK2Jfg5sUt2hetsU6cHOFY
         rOxA==
X-Gm-Message-State: AOAM532XWLO/FKOcVkdJVxYq0NZRReP+EICZdyy9ySS3CYAysS5iREQE
        iSf9yaes+TrAJEhv8QBFaLMLO0KtRJNvgsLyTpQq4w==
X-Google-Smtp-Source: ABdhPJz3G+w3mI4aek6BzRvN50UdpHzPSqVrw7QJX1z7lMdAc71YC6jy6p2L4bIcF3bNKcpY94dE+anLvrHCmioY+tw=
X-Received: by 2002:a19:7b14:: with SMTP id w20mr12406875lfc.29.1628377387496;
 Sat, 07 Aug 2021 16:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210805093023.3465081-1-linus.walleij@linaro.org> <9316a403-e755-3870-6393-62f20792af44@gmail.com>
In-Reply-To: <9316a403-e755-3870-6393-62f20792af44@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Aug 2021 01:02:56 +0200
Message-ID: <CACRpkdZs4Zw5k6Hv0-PDKtrqXpEhTDn9OjwDJDvwJvsXJWDUvQ@mail.gmail.com>
Subject: Re: [PATCH v3] brcmfmac: firmware: Fix firmware loading
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stefan Hansson <newbyte@disroot.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 5, 2021 at 12:31 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> Combining my previous comments together, I rewrote it like this:

I like this, can you fold in your patch on top of mine, add your
Signed-off-by at the end and resend to the list?

That way we get a clean record of the delivery path and also the
patch looks like you want it :)

You can perhaps tag on v4 on the [PATCH] as well so it's clear
for Kalle to apply this version. (Hoping Arnd will be fine with it as
well.)

Yours,
Linus Walleij

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0549D48B920
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 22:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbiAKVFM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 16:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiAKVEc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 16:04:32 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B75C061751
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 13:04:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g11so1115319lfu.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0YuEwCZnEuKRpVHXAiy69Z0RUFspZC8cHSjq2E3Eto=;
        b=qTdZ5dTgpxUc0ZcpidxLsEDi6ERAo8DHppbBJPpYplppIMsdax7ZVx2GfuYIzFUVAF
         +tOQb43S73Rfi+LWRdO6GqUFiE2h+bbbxlz1GZgiPHkf9mKrXq9mbQGbVQjYcaHoJuHR
         zjKucDCVEsS+bhlWpbNRGdhIadDyswENHSVsfF/aA0YxmICNTWyeE97DPl2bXniIluGc
         QMRcF+gyM9f3tcJsd/10oBCG9yaHz6LkVEKNthySqWWZ37KxO3+/qCo5ka3vAc7Ifa2L
         10jO7uyi44Qf/tRw8QyQMaR0qhMT0cICAoWB4iIG/4L6U8KqmgnEIqz+2A6/Jda3r8Uo
         RKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0YuEwCZnEuKRpVHXAiy69Z0RUFspZC8cHSjq2E3Eto=;
        b=u0xno7kFV/DUKZFd5eUlyhCmCGaMUqu/z84cRrMAuOePEjhwJUWiL24hApNfcrHTkn
         0cqFNOk1i+yNVpvYppwq2VXqP6l0LwQwiHM1LtfbeYCoQy/5DGzjTqrPNL6MwJY5ZR53
         1R1UHO5f2/sjLA8CoABXqr9cy6OJnJAcv4TV4kzf1kmct2HHc6PB7nMurD+lmlqgdlS6
         GR1bDgod6eaEa8D8UA96bDo0fY77UpfIK8t5NVkmMnnvQy+kqIBpEW9HYLbGR1YRUe1+
         k6lVK0gJSTdF77Gx6hC6r0XSEtF2LFqFleIzack652iC7RSG4rfILk3k4+aRdDJmCkXt
         3XOA==
X-Gm-Message-State: AOAM530ehPfroA2uoJa6lv+YCnShLvKIDzZnByOkNZa+qdx321kOvsJW
        XsqH4yciH9FovPbSLG9MGKZBPGqy8dS29hCUF+72QQ==
X-Google-Smtp-Source: ABdhPJzeO4rualg1booOzsUS3uAdK5sSssH1EAbNZfANOukwZD7t8d8mIVQd3g6cPIbfo7bMnRfW6rPqpxrPZ15ACFc=
X-Received: by 2002:a2e:a5c9:: with SMTP id n9mr3176921ljp.220.1641935069710;
 Tue, 11 Jan 2022 13:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20211217144119.2538175-1-anders.roxell@linaro.org> <20211217144119.2538175-6-anders.roxell@linaro.org>
In-Reply-To: <20211217144119.2538175-6-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Jan 2022 13:04:18 -0800
Message-ID: <CAKwvOdk0p98ac0yVLwLiJXndvyJw+Ufpxke2WEVrhyUOftN6=Q@mail.gmail.com>
Subject: Re: [PATCH 4.19 5/6] ARM: 8788/1: ftrace: remove old mcount support
To:     Anders Roxell <anders.roxell@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, clang-built-linux@googlegroups.com,
        ulli.kroll@googlemail.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, amitkarwar@gmail.com,
        nishants@marvell.com, gbhat@marvell.com, huxinming820@gmail.com,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, dmitry.torokhov@gmail.com,
        nathan@kernel.org, linux-input@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 On Fri, Dec 17, 2021 at 6:41 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> From: Stefan Agner <stefan@agner.ch>
>
> commit d3c61619568c88d48eccd5e74b4f84faa1440652 upstream.
>
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> raised the minimum GCC version to 4.6. Old mcount is only required for
> GCC versions older than 4.4.0. Hence old mcount support can be dropped
> too.

cafa0010cd51 first landed in v4.19-rc1, so that lgtm.
-- 
Thanks,
~Nick Desaulniers

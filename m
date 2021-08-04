Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46F3E043B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbhHDPdI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbhHDPc5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 11:32:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED89C061799
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 08:32:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e5so3032964ljp.6
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLf04e+Zhw8WzOuyHOsmOkdODLmYUmMx1YbBO54G3Ms=;
        b=EhZgW40m+cqkNcrmILtqoajz2gvAGaADEVvMSIQbDQsakbbeY0hTu+ZSHqsUntaFZk
         vixMoPJYHJoKZ7F7k+11fEaFizEqMZjczlXt67PtyEvJsa87MajvZ5epEc4oHT4Di8L9
         X90uUuWUCzgOhBFf8DgyiRo8iKJvt453mWo6Ikrfc7UOKMlMK/aEPQpm1GgAg8CHeTpO
         is4o0epeoRyLUwbRpj77Zl1KuSKPdshErfthiSWiASproOTpCWnWXAX2fnLsKg1uVyZS
         XdwVrBaJHAqYXaXuqHbtFFNKiJ7HfbJSlill1cZU8PjMsYov50ilXymIYLAobG+bH49K
         HhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLf04e+Zhw8WzOuyHOsmOkdODLmYUmMx1YbBO54G3Ms=;
        b=LmhH+qd1JpqxmgOQ3lcbS2pnvmhkk6LpgSacPBQ3pCSLJnN3ch8ELSOvDzd7yAQlKK
         oiUiWFKMjpjxEXVjtzC1Cv7Xpjl1N4cIkzpwzE4eFJn22vZ0JQG5h5zCX9vPdedDxLVD
         2Hi5d2GURcY1QtgwIxVZchSBvVzu3/JnbqUrc+rWWvinAo2qhDXScZeAsarA7J5WkjB0
         qINjL1eg9rJHCXJSr/tNmzYOSuHhXmwJgBzqxuEzXJxeN6cSeYzDWIhDwJkFbQRfpmaT
         VMFvO465GXFJaeQ9vRJRimnNIrE705h//q4eLOqqt9PIR0tsOG0K9dHSnvJ9xw7sg2IZ
         4Rdw==
X-Gm-Message-State: AOAM5329NvBOBqR6+yae52lxed9tHcK1FnSSg1FykBTVQOSJyGDmDgfF
        RzwvNcFGp37JHAKCW8aQWZRna9OpbEoSZWIvVQFhMA==
X-Google-Smtp-Source: ABdhPJxQhmlG2bRdcKVDdkwqrl423FhmA/8AMOVB9CESPF3E6prmZXntqiWiQTDD+OIgowVVE8lWp3rB7fZ+RlhbOxY=
X-Received: by 2002:a2e:888f:: with SMTP id k15mr43777lji.326.1628091161725;
 Wed, 04 Aug 2021 08:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210803232746.3389570-1-linus.walleij@linaro.org> <242b823b-627d-de3c-596d-0f13e28ccd47@gmail.com>
In-Reply-To: <242b823b-627d-de3c-596d-0f13e28ccd47@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Aug 2021 17:32:30 +0200
Message-ID: <CACRpkdZE2j6zROA+ijdxBhZGfjCicrWXmqnB-FkSXvdxSOFgJQ@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: firmware: Fix firmware loading
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stefan Hansson <newbyte@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 4, 2021 at 4:57 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> Works, thanks!

I record this as Tested-by! :)

Yours,
Linus Walleij

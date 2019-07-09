Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D129B63D5B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 23:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfGIV3v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 17:29:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43123 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbfGIV3v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 17:29:51 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so108476ios.10
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5QQKjGCkPUBJ3N6ztbQJBr6O1cRaWimyf2pTOCKgLk=;
        b=jll6IGtD/1yH8UUSpbpyax3paURWIk58RTSuww3ABCR6BfaRyNeTG43u7r3588IC3L
         EMWHTxrpndJ0BtZ0LGFdmb9xSKg6re5gZfe3TBkXxxtLKbVm8l6s2uHUfnbSgTzMLewA
         B5aEXmlRybYdU7QDBe23q61CUBVt1dVVFQcGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5QQKjGCkPUBJ3N6ztbQJBr6O1cRaWimyf2pTOCKgLk=;
        b=LeW6NeLjiye67wNJdSxjmXZgSjoNf6+CXF125uSCOG+Jue27KLN3iJhjAsWpAy/IbN
         GI6Ygmt6DG3d2r0nIqfUbBokoCeDSD2sjBcm8NOlijDElSZoEGXt1KineuTgbB5eSUHj
         BYqLJr0veH2zPLlhCmXFZl7NUuuZkb6oyQB/M8zt4kGWCl/3M83Mt7ctYWBKbtzzy5+F
         mEVSGRC9uECSevuwTY8prF1eh8QJ1nLLsXouLKDbrWRO7BU+/Z5yOBKRwbAUIRBMHZIL
         QmS6iXP6zjWCNa/r2tQFnQwZnLZj0ixGHw4rDLCGCdShGgJNiJj6f8g9wwrQunAdtLAs
         imbQ==
X-Gm-Message-State: APjAAAVIZIYkNrlv2YANkZ4hldmO/eQfM935JjErRyI89ECtB7RTLMc3
        /4uzwH+KDF+dCh1QVbywgPuhmIf5nIw=
X-Google-Smtp-Source: APXvYqwzIapt6enUF366CmUVrv9KDHAEJ46/x8Ivm9m3Mc4+UaSK5ZPNnp4N/kswccWb8vabidchgQ==
X-Received: by 2002:a05:6638:40c:: with SMTP id q12mr31696379jap.17.1562707790200;
        Tue, 09 Jul 2019 14:29:50 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id t19sm18726660iog.41.2019.07.09.14.29.48
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:29:48 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id f4so152040ioh.6
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 14:29:48 -0700 (PDT)
X-Received: by 2002:a02:ac03:: with SMTP id a3mr31371347jao.132.1562707787910;
 Tue, 09 Jul 2019 14:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-7-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-7-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 14:29:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X49wubSaqp8JQ6_KduE+SdnVh51MGQ1ELgZyZeL7W3Sw@mail.gmail.com>
Message-ID: <CAD=FV=X49wubSaqp8JQ6_KduE+SdnVh51MGQ1ELgZyZeL7W3Sw@mail.gmail.com>
Subject: Re: [PATCH 6/7] mmc: sdio: Drop unused in-parameter to mmc_sdio_reinit_card()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The "powered_resume" in-parameter to mmc_sdio_reinit_card() has now become
> redundant as all callers set it to 0. Therefore let's just drop it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

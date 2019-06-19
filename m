Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A344AEF5
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2019 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFSASD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 20:18:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45542 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFSASD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 20:18:03 -0400
Received: by mail-io1-f66.google.com with SMTP id e3so33959264ioc.12
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2019 17:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahQopYhdhRSibvobb60gYtWRaOOXSFvhlvKBetrMJIQ=;
        b=bPUt6J2RQNeTBWy5o8une+ywojOMMjhpDQ+GtAcvKZpB21mUrjmScuAxxYl/Ou+GCA
         UOwp5v30S43fcuRwM3CdH6VrY6rQzVDgAnP1xnSY60gVo/UpLbOa7erRfUMp/R8DPEBV
         rJavHQd6yb7YmPuF5sUwhPXXOIx5BE4Uw6QLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahQopYhdhRSibvobb60gYtWRaOOXSFvhlvKBetrMJIQ=;
        b=XOLNx3FufVhgCIoj70VXyJJWADD6wyXuW35d/q/65u14vQWQuKOF8GNjT1RBTVT4ng
         bzFzLrGzDcGuW8hChIiD/IML+JEJh+jz4f9eQtqiALJvcIOFXyFqRURTvkan9U3pPspt
         yYrcEcPwJfun2hNLtZPLmbCiZRLnEcQVsrTmXA6eds9JtUGpPPcNBfcThFg+LSnWqr5w
         /6/CjPcV2oKhuTAzUp1QmxK8eIcEUixobgvI5h/69rYQ9t0GGcyG2J3kOa89z+pdB5r6
         egle8sKHRwmEf6NowgzVDKwgnr++D0ToGMnWzMHFe7pBZo1CGCm0+fJ9NO7QBzwL6dkK
         7KQg==
X-Gm-Message-State: APjAAAVC+K0+h5BJcFYQzHQ1uHa9cEl7l+USYjgoB4S24m99O9VJufrZ
        btjNpIz7isTywccnsa76CQpZzolRSWQ=
X-Google-Smtp-Source: APXvYqwqaxO6RsU2o/DCfEGIHUtf/DglgvumedObDSkMpE5fBkyXlWzJOYO9zwzOVcjeQGWwDqb4bw==
X-Received: by 2002:a5d:9d58:: with SMTP id k24mr8199924iok.116.1560903481724;
        Tue, 18 Jun 2019 17:18:01 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id h18sm14547826iob.80.2019.06.18.17.18.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 17:18:00 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id k20so33996236ios.10
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2019 17:18:00 -0700 (PDT)
X-Received: by 2002:a5e:c241:: with SMTP id w1mr9682548iop.58.1560903480285;
 Tue, 18 Jun 2019 17:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-2-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-2-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Jun 2019 17:17:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJ20aabd9bRL0LhvP7rC7MOUhiRhvktnCQ81fe2hHKxw@mail.gmail.com>
Message-ID: <CAD=FV=UJ20aabd9bRL0LhvP7rC7MOUhiRhvktnCQ81fe2hHKxw@mail.gmail.com>
Subject: Re: [PATCH 1/7] mmc: sdio: Turn sdio_run_irqs() into static
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
> All external users of sdio_run_irqs() have converted into using the
> preferred sdio_signal_irq() interface, thus not calling the function
> directly any more. Avoid further new users of it, by turning it into
> static.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 3 +--
>  include/linux/mmc/host.h    | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

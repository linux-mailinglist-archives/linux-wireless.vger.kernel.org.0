Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F4763D5F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 23:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfGIVbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 17:31:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34553 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfGIVbr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 17:31:47 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so220003iot.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+Q6OKHB4bjuA+HKRJoJXplccc4Q4BX/DPB0CSkNBfg=;
        b=jXXNF60XQ/xWIVsNNbZL3eDl1iyRkV2wUimvy/t5P4f2Y9AdAj79hrbkiF4p2XToXh
         PjlMOcdLlv3NklnZFKzraxechJEVrnBSZKUw8/khqATqOYB/uk7uPs4JLCvALCZH+iyO
         tL2y3uBGNmr5ik3mE9cxdMzErpUncIvQQBR0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+Q6OKHB4bjuA+HKRJoJXplccc4Q4BX/DPB0CSkNBfg=;
        b=NyEhMOAGLo2Yv/QW+Lm4KJGtIZFmyyKEqGCNM2nJ2Go7DaPuwkrgmilWKxeFOqNSyw
         GM/LCbcUNLInj3J+JsOLblgs28+5uCZbYhzf2+PgAbFWUGDD0rR5DYGNtme8Ggk2d5+B
         iNgFjMHjbK2YoHmlw6uX1aQCjP83YL8Afw02z6kFmpSAPeFDkaV7HCvVf8ZI1depPaqo
         Fx9aBDo63HPhau1+jBtFN4mXraEukSMERj3h61syowQ63h8LBL+MxnkZhCrRvkXGKqRj
         jyCAYdv3EvvwxeEbyssNq1C4CoNtn8ZaLWdEN/Kb0W5xS7E35tEQpjEQiEHQd4RDutkn
         Pn3g==
X-Gm-Message-State: APjAAAVEuq5ZBtdxjqk3bVANfdf4nNaoDeQs5LdbEh2enoCF4IIRPheh
        lM+lhMNg56u2w5ofUUJs8fls5HRa228=
X-Google-Smtp-Source: APXvYqw7wPOL7nHK/c4DPuE5vUoU4OVui3M0Rbbcrl2mhbZxFu7jGcF7DYlMqjmMM3znj9vXEI4pig==
X-Received: by 2002:a5e:d615:: with SMTP id w21mr5712020iom.0.1562707906189;
        Tue, 09 Jul 2019 14:31:46 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id y20sm19294907iol.34.2019.07.09.14.31.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:31:45 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id j5so141951ioj.8
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 14:31:45 -0700 (PDT)
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr7438751iop.168.1562707904855;
 Tue, 09 Jul 2019 14:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-8-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-8-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 14:31:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VdECYQCLAFd+J6xYBXSJVLMb5_iGs+DYCmeDbW0N-SOQ@mail.gmail.com>
Message-ID: <CAD=FV=VdECYQCLAFd+J6xYBXSJVLMb5_iGs+DYCmeDbW0N-SOQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] mmc: sdio: Drop unused in-parameter from mmc_sdio_init_card()
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
> The "powered_resume" in-parameter to mmc_sdio_init_card() has now become
> redundant as all callers set it to 0. Therefore let's just drop it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

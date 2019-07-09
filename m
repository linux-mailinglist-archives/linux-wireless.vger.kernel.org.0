Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500DD63D42
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfGIVZ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 17:25:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40209 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfGIVZ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 17:25:57 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so120971iom.7
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UIgOQNmfvUJtDiPoIjrW8Kpce1CO869FkZz13pccs8=;
        b=RN/5m5rkbsEOrFNg8rvYWPhdjVYevh1ect0wihamuv5Vk4dpFwAihGpNLRFP+2w9lM
         eEiuNREadfbuccshh/ZnURaZqybWzRpX9hGhBUWPEL22qgRHgNQRBXQLlk8kQJsDY5Nd
         J4Jy0vxYgKyDv4fMWb2kkj8S1YbivRmdmQn18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UIgOQNmfvUJtDiPoIjrW8Kpce1CO869FkZz13pccs8=;
        b=WHkH8QELaVGEUngX8qXWeSXwAgnJ7ugrvm+7ElOk166xwTkKcAb7Z3RSXGzQ1G3lxX
         uvwFowYZEC/jZn7kwNlQnAIlyVtrvcysM21eMbVFUpoycaOhiskt679VGDfLalw5KdXR
         F1IsXZg7UHMmiHg20yM6T7Bu6iOB+SmhAhO/umkYJP7n/Ucwfs775QgPP2ULVpJmm7QZ
         JHR1sF3Wt+hq+KcQ/E9txQeksfMNXc/P1Sg+hRHrhw7ypM/+DM64Bf/jX/hAEHVmhJed
         FiTG/GAmysPTz5fUS84rTE7FYCzUVPpP7oc1KV/V1il/0Q2QjhWxVc1aRWA2sti8k/Tx
         EH4Q==
X-Gm-Message-State: APjAAAXb3hFDcjvl5DmSozBASUtrCyBCYAqOLBxq3rQBwuCwK5/bzLxS
        2EMimIgX/n4EEjFhlARKetOQjFTo5js=
X-Google-Smtp-Source: APXvYqzOVSUzDb4P+Pkpsf8ESrLSi38pyxOyWm/Fn3NeLzmVJEpTLnY4FpXGzqkk5gIrIDwgx6v/Gw==
X-Received: by 2002:a6b:6209:: with SMTP id f9mr1585902iog.236.1562707556317;
        Tue, 09 Jul 2019 14:25:56 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id t14sm20334419ioi.60.2019.07.09.14.25.54
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:25:55 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id s7so77153iob.11
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 14:25:54 -0700 (PDT)
X-Received: by 2002:a5e:c241:: with SMTP id w1mr1702247iop.58.1562707554420;
 Tue, 09 Jul 2019 14:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-3-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-3-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 14:25:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UjXT0UG=JZtvNL4EtHofcuC_HhTe4grWBNJ8+8jVFhYg@mail.gmail.com>
Message-ID: <CAD=FV=UjXT0UG=JZtvNL4EtHofcuC_HhTe4grWBNJ8+8jVFhYg@mail.gmail.com>
Subject: Re: [PATCH 2/7] mmc: sdio: Drop mmc_claim|release_host() in mmc_sdio_power_restore()
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
> The function mmc_sdio_power_restore() is called either from
> mmc_sdio_runtime_resume() or from mmc_sdio_hw_reset(). Both callers either
> claims/releases the host or require its callers to do so. Therefore let's
> drop the redundant calls to mmc_claim|release_host() in
> mmc_sdio_power_restore().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 4 ----
>  1 file changed, 4 deletions(-)

Without being an expert, I looked through the code and as far as I can
tell this is fine.  Specifically:

* I agree there are two calls and mmc_sdio_runtime_resume() clearly claims.

* The only call to mmc_sdio_hw_reset() looks to be mmc_hw_reset();
looking through calls to mmc_hw_reset() I see the claims.  It's super
obvious in the 3 cases in "drivers/net" and I decided that I didn't
need to look at block.c because that shouldn't be a codepath that
affects SDIO.

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


I also don't see this patch causing any problems on the rk3288-veyron
boards I tested it on.  Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BDBF8F9B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 13:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLMXy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 07:23:54 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46524 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfKLMXy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 07:23:54 -0500
Received: by mail-vk1-f193.google.com with SMTP id o2so4366035vkc.13
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 04:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIM1JYaYmTXNvYFXw2x2oQtpX3N982AvyDjEr2K6wSQ=;
        b=W7BiBGbXegPlAof5/GvqohgU9mzIPzyqE0Vwi1d93ALAZcFb+LAeM4o/XloCBw6UhY
         LRfu6zIIl145jOjuWlMIIDgoXLEvdwQPqqRJ8aW+utv7klz1m+aHcvOD8FsyVvA0aGEA
         crFc5CjhlHNWWSTPyrjCBNTqPopi8Ci2xzSupwYACAe+sDz7ZtOY3mcgzj7H5RBBkG0c
         TSSV4nNA0hXelj0NWuEtQgrovyUS2qysADLVy016z3IGr8UlyO0DmglnEftJ4uNPnyVd
         j5BXi7Zv/o8ChKEDVl07pHplfDRzD+usi0hUhyYR+/HMxZRtWtutqmonF4/LzrAsN1O9
         lqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIM1JYaYmTXNvYFXw2x2oQtpX3N982AvyDjEr2K6wSQ=;
        b=NX9TOAmxFjosgHhxmZPlyJIkvbYCfz6kXz1XZ/r4v4a37Nb4OTim4KltqEblSQGSW9
         rJmtEMisYO8ovgmqDSPSmdaHQeo/u/+o6jtAdIyoMJ0qZ5+mLeXhMkt6fgVz2InJfeGX
         WA8f6Y6V6vzD94uOi0oTSWRt6Q70WGbwPRx5DwGrOHjoba9U52NWchsbGfgHavktb34t
         /k98zKRXtIyCfvUanPvWJ5XcUi/Xn5AlObLw7Q/P7XXyz9C5AmowhqvxWZI8jhfkG+E/
         cLdNGeE9mrrAOyM2yDR7VOr2o6ca6BidxaAwHHIUQCMI+7MkKxrYwE2geS+mceXDtmrn
         tqqw==
X-Gm-Message-State: APjAAAWWX+js+quuilS/1HDzTgGnmqda07TxbiyeT++Epdp0IL4ctJ0W
        SvKjihZ/7Uc0DMybGRBVlR2G1QNnVwpI+75b5fHSTg==
X-Google-Smtp-Source: APXvYqxmRKNJNucmzLIbD5BwA2B+dsO9GbZVSTVq4CX1qrwHgFBQdNK6jnahciZ9ga14/Qw/LDrW2yGA059C+29wwwo=
X-Received: by 2002:a1f:fe0a:: with SMTP id l10mr14610359vki.59.1573561433194;
 Tue, 12 Nov 2019 04:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org> <20191111220812.GX43123@atomide.com>
In-Reply-To: <20191111220812.GX43123@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Nov 2019 13:23:17 +0100
Message-ID: <CAPDyKFq03X0hd5B6h6fuNht5OjSEWe6Ap4hH4a+0nVZsS4r3hw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: Fixup HW reset for SDIO cards
To:     Tony Lindgren <tony@atomide.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 11 Nov 2019 at 23:08, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Ulf Hansson <ulf.hansson@linaro.org> [191109 10:31]:
> > Changes in v2:
> >       - Add adaptations to the mwifiex driver.
> >       - Keep existing syncronous reset behaviour if the SDIO card has a single
> >       func driver.
> >
> > It has turned out that it's not a good idea to try to power cycle and to
> > re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
> > because there may be multiple SDIO funcs attached to the same SDIO card and
> > some of the others that didn't execute the call to mmc_hw_reset(), may then
> > simply experience an undefined behaviour.
> >
> > The following patches in this series attempts to address this problem, by
> > reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
> > mwifiex driver to these changes.
> >
> > Note that, I don't have the HW at hand so the the code has only compile tested.
> > Test on HW is greatly appreciated!
>
> Looks good to me. I tried testing this, but looks like at least on duovero
> mwifiex_sdio is broken in v5.4-rc7:
>
> # dmesg | grep mwifi
> mwifiex_sdio mmc1:0001:1: poll card status failed, tries = 100
> mwifiex_sdio mmc1:0001:1: FW download with helper:       poll status timeout @ 0
> mwifiex_sdio mmc1:0001:1: prog_fw failed ret=0xffffffff
> mwifiex_sdio mmc1:0001:1: info: _mwifiex_fw_dpc: unregister device
>
> No idea when it broke and what might be the issue this time around.
> Any ideas?

Sorry, no good idea.

Perhaps something on the mmc host level that has changed?

Kind regards
Uffe

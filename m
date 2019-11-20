Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3899103448
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 07:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfKTG2V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 01:28:21 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:51510
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfKTG2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 01:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574231300;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=2DbCZfizzX83H18NXUU+cijwVZjvJWmnkVQmn16iT30=;
        b=nYUkb0LgkK8fvXpZQnMxqW2wWeXoqFcKRK5REzic3EW1pVAnA6ZsXUdTY+kaDc1M
        XuSc0d44pEnSojbgih7kLtvpyBE9fpztgkAHfO2uD/KqRTqCdPtgYkyAitazjw3DtYJ
        RmsZCOqUJhbZJCRgR7MunFAeuHWO28uh98dD8kkU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574231300;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=2DbCZfizzX83H18NXUU+cijwVZjvJWmnkVQmn16iT30=;
        b=gp8ZAqM3o4Kr8pvf9dTYPAtuDDnWVXPaf7ZEEGSw5txP9/TnHPEhmSoHh40BpPvH
        AdU4hu8VTTUHVfoCkIc5TSCWX1k1JsFV0PupB9E5VNnS1V/K/tbTa3Gcr7XbvNZHx9X
        YJsKUkyrHi4D5mSz0ZPQOaIeV97naRj1mxyph7Ng=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 925BDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Wen Gong <wgong@codeaurora.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        ath10k@lists.infradead.org
Subject: Re: [PATCH v2 3/3] mmc: core: Re-work HW reset for SDIO cards
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
        <20191109103046.26445-4-ulf.hansson@linaro.org>
        <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
        <CAPDyKFrCyJBz2=RzKPxqn0FSEq500=dEDsTUWYZeoFKWvSRAdA@mail.gmail.com>
Date:   Wed, 20 Nov 2019 06:28:19 +0000
In-Reply-To: <CAPDyKFrCyJBz2=RzKPxqn0FSEq500=dEDsTUWYZeoFKWvSRAdA@mail.gmail.com>
        (Ulf Hansson's message of "Tue, 12 Nov 2019 13:19:55 +0100")
Message-ID: <0101016e877f56ce-8c7f312f-49d9-47e5-8473-30657f87bdd2-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.20-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ wen, ath10k

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders@chromium.org> wrote:
>>
>> Hi,
>>
>> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >
>> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> > index 6f8342702c73..abf8f5eb0a1c 100644
>> > --- a/drivers/mmc/core/core.c
>> > +++ b/drivers/mmc/core/core.c
>> > @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>> >         mmc_bus_put(host);
>> >  }
>> >
>> > -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>> > -                               bool cd_irq)
>> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>> >  {
>> >         /*
>> >          * If the device is configured as wakeup, we prevent a new sleep for
>> > @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
>> >         ret = host->bus_ops->hw_reset(host);
>> >         mmc_bus_put(host);
>> >
>> > -       if (ret)
>> > +       if (ret < 0)
>> >                 pr_warn("%s: tried to HW reset card, got error %d\n",
>> >                         mmc_hostname(host), ret);
>>
>> Other callers besides marvell need to be updated?  In theory only SDIO
>> should have positive return values so I guess we don't care about the
>> caller in drivers/mmc/core/block.c, right?
>
> Correct, but maybe I should add some more information about that in a
> function header of mmc_hw_reset(). Let me consider doing that as a
> change on top.
>
>>  What about:
>>
>> drivers/net/wireless/ath/ath10k/sdio.c
>>
>> ...I guess I don't know if there is more than one function probed
>> there.  Maybe there's not and thus we're fine here too?
>
> Well, honestly I don't know.
>
> In any case, that would mean the driver is broken anyways and needs to
> be fixed. At least that's my approach to doing this change.

Wen, does QCA6174 or QCA9377 SDIO devices have other SDIO functions, for
example bluetooth? I'm just wondering how should we handle this in
ath10k.

-- 
Kalle Valo

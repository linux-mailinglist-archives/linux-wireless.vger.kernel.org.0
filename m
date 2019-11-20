Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB38103515
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 08:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfKTHUG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 02:20:06 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:60012
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbfKTHUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 02:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574234405;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=REOd7Vs1wlMJlS39Ft1QjmPJxJV9TOjNK+aSCA7YT2U=;
        b=kyoMN7CMWHXpRooOlrvspQoBC1/PAVBfM3/4bGLUrk0MDDiYdxQIvwe/FZtYZ5Rk
        69iNmPDoCQGIyLrAmgMM0t0J4ocM8DXhLCPbDZTqiHZ+UEnWHFv4Wl7VRhvVz/zthJG
        beR7EaZyHhm5/rYhKDJFOVeneGe9PEmsAeOfMj38=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574234405;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=REOd7Vs1wlMJlS39Ft1QjmPJxJV9TOjNK+aSCA7YT2U=;
        b=SjiNrIYKazBxL0ZW1iEGczSebXm75gfj4MxnYpTLTWrLA67KzLQBVgS1x7+lujJy
        /hGQtHW0zvpg5HgZLl/PK9cmj0dHxxhxJ4Ws94WNy1lNUEmqrp5cpyjtXKIym5OOjsL
        ikjQUI0WFw3Y0rluiRrlBkwqep/Vr+FmIZqUfAxs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F622C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     wgong@codeaurora.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
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
        <87zhgr5af6.fsf@codeaurora.org>
        <6e6b53b28581a8f1a2944ca0bc65311e@codeaurora.org>
Date:   Wed, 20 Nov 2019 07:20:05 +0000
In-Reply-To: <6e6b53b28581a8f1a2944ca0bc65311e@codeaurora.org>
        (wgong@codeaurora.org's message of "Wed, 20 Nov 2019 15:10:13 +0800")
Message-ID: <0101016e87aeb8bc-69ce520c-0611-4c7b-9988-465b993bde9f-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.20-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wgong@codeaurora.org writes:

> On 2019-11-20 14:28, Kalle Valo wrote:
>> + wen, ath10k
>>
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>>> On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders@chromium.org>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson
>>>> <ulf.hansson@linaro.org> wrote:
>>>> >
>>>> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> > index 6f8342702c73..abf8f5eb0a1c 100644
>>>> > --- a/drivers/mmc/core/core.c
>>>> > +++ b/drivers/mmc/core/core.c
>>>> > @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>>>> >         mmc_bus_put(host);
>>>> >  }
>>>> >
>>>> > -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>>>> > -                               bool cd_irq)
>>>> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>>>> >  {
>>>> >         /*
>>>> >          * If the device is configured as wakeup, we prevent a new sleep for
>>>> > @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
>>>> >         ret = host->bus_ops->hw_reset(host);
>>>> >         mmc_bus_put(host);
>>>> >
>>>> > -       if (ret)
>>>> > +       if (ret < 0)
>>>> >                 pr_warn("%s: tried to HW reset card, got error %d\n",
>>>> >                         mmc_hostname(host), ret);
>>>>
>>>> Other callers besides marvell need to be updated?  In theory only
>>>> SDIO
>>>> should have positive return values so I guess we don't care about the
>>>> caller in drivers/mmc/core/block.c, right?
>>>
>>> Correct, but maybe I should add some more information about that in a
>>> function header of mmc_hw_reset(). Let me consider doing that as a
>>> change on top.
>>>
>>>>  What about:
>>>>
>>>> drivers/net/wireless/ath/ath10k/sdio.c
>>>>
>>>> ...I guess I don't know if there is more than one function probed
>>>> there.  Maybe there's not and thus we're fine here too?
>>>
>>> Well, honestly I don't know.
>>>
>>> In any case, that would mean the driver is broken anyways and needs to
>>> be fixed. At least that's my approach to doing this change.
>>
>> Wen, does QCA6174 or QCA9377 SDIO devices have other SDIO functions,
>> for
>> example bluetooth? I'm just wondering how should we handle this in
>> ath10k.
>
> it does not have other SDIO functions for QCA6174 or QCA9377.

Thanks, then I don't think we need to change anything in ath10k.

-- 
Kalle Valo

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4989B104107
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbfKTQlw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 11:41:52 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:50882
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728632AbfKTQlv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 11:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574268110;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=NjjSVG5LUmH7QQy4Vqj8vI+LZUKs5boQ12w8VYjDuGk=;
        b=GJTC5IFCmLTikEwWs0RHAJMrzQC9ZvGnwC9WSqbuFVB+7fd6txIL/YmpQXyZCJm4
        MhNGEuOarThM2JrW9RmD6fIPZcHpxSw2lMRERQ/B3tlnH+ZRfn6Y2Zfpnm/IR9x+ClX
        AsZd+h6HAG+cgW18akbv3iYTRaJGdpKyflUlVlWI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574268110;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=NjjSVG5LUmH7QQy4Vqj8vI+LZUKs5boQ12w8VYjDuGk=;
        b=PDgvJ668pf0QQk8INciTMSKBBdQwQfNoLTMySPtaBsYBlKD592L6h5bIVsVKl/cd
        hjdRZFAxwwoNpcv0Bx9ZAZ9n9SwMbCkII9vPB4Ujw8Og008j+lv5TUu+tJaZ3aji/Pb
        wNJYpbO0x4eleSN25Vi9fyJeB+azjsh9agPEdRRY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AB86C447AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wen Gong <wgong@codeaurora.org>,
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
        <0101016e87aeb8b6-761ad812-5da7-4b0d-8cae-c69633d90de0-000000@us-west-2.amazonses.com>
        <CAPDyKFoWxw9r=GZhvF=TxHxo=zRfKr0hknEeQNPdfwPx4ORxuQ@mail.gmail.com>
Date:   Wed, 20 Nov 2019 16:41:50 +0000
In-Reply-To: <CAPDyKFoWxw9r=GZhvF=TxHxo=zRfKr0hknEeQNPdfwPx4ORxuQ@mail.gmail.com>
        (Ulf Hansson's message of "Wed, 20 Nov 2019 13:10:42 +0100")
Message-ID: <0101016e89b106d8-28f35aff-b772-4856-bc11-cccd5502d948-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.20-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Wed, 20 Nov 2019 at 08:20, Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> wgong@codeaurora.org writes:
>>
>> > On 2019-11-20 14:28, Kalle Valo wrote:
>> >> + wen, ath10k
>> >>
>> >> Ulf Hansson <ulf.hansson@linaro.org> writes:
>> >>
>> >>> On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders@chromium.org>
>> >>> wrote:
>> >>>>
>> >>>> Hi,
>> >>>>
>> >>>> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson
>> >>>> <ulf.hansson@linaro.org> wrote:
>> >>>> >
>> >>>> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> >>>> > index 6f8342702c73..abf8f5eb0a1c 100644
>> >>>> > --- a/drivers/mmc/core/core.c
>> >>>> > +++ b/drivers/mmc/core/core.c
>> >>>> > @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>> >>>> >         mmc_bus_put(host);
>> >>>> >  }
>> >>>> >
>> >>>> > -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>> >>>> > -                               bool cd_irq)
>> >>>> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>> >>>> >  {
>> >>>> >         /*
>> >>>> >          * If the device is configured as wakeup, we prevent a new sleep for
>> >>>> > @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
>> >>>> >         ret = host->bus_ops->hw_reset(host);
>> >>>> >         mmc_bus_put(host);
>> >>>> >
>> >>>> > -       if (ret)
>> >>>> > +       if (ret < 0)
>> >>>> >                 pr_warn("%s: tried to HW reset card, got error %d\n",
>> >>>> >                         mmc_hostname(host), ret);
>> >>>>
>> >>>> Other callers besides marvell need to be updated?  In theory only
>> >>>> SDIO
>> >>>> should have positive return values so I guess we don't care about the
>> >>>> caller in drivers/mmc/core/block.c, right?
>> >>>
>> >>> Correct, but maybe I should add some more information about that in a
>> >>> function header of mmc_hw_reset(). Let me consider doing that as a
>> >>> change on top.
>> >>>
>> >>>>  What about:
>> >>>>
>> >>>> drivers/net/wireless/ath/ath10k/sdio.c
>> >>>>
>> >>>> ...I guess I don't know if there is more than one function probed
>> >>>> there.  Maybe there's not and thus we're fine here too?
>> >>>
>> >>> Well, honestly I don't know.
>> >>>
>> >>> In any case, that would mean the driver is broken anyways and needs to
>> >>> be fixed. At least that's my approach to doing this change.
>> >>
>> >> Wen, does QCA6174 or QCA9377 SDIO devices have other SDIO functions,
>> >> for
>> >> example bluetooth? I'm just wondering how should we handle this in
>> >> ath10k.
>> >
>> > it does not have other SDIO functions for QCA6174 or QCA9377.
>>
>> Thanks, then I don't think we need to change anything in ath10k.
>>
>> --
>> Kalle Valo
>
> Kalle, Wen - thanks for looking into this and for the confirmation.
>
> One thing though, perhaps it's worth to add this as a comment in the
> code for ath10k, where mmc_hw_reset() is called. Just to make it
> clear.

Good point. Wen, can you send a patch, please?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

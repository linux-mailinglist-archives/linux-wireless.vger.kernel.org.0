Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45EA104884
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 03:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKUC3s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 21:29:48 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:47596
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbfKUC3s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 21:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574303387;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=o4LGGG49L2mFI3Z0m3DVLA0OdYWIS2drsZMLKtkysYw=;
        b=iOdbP1OrIgpgHN8l74j4+jDzT6jyiZ07cYNHm8c2+3Sq5GMfBrYV0W3NPvdY5+Eq
        UuZOFCUJa5Fo6+bRKMYdRrcwidctzrTDIaif6W+Ti5nccJ8GmPVG+wG6qlm6o3a0g05
        UlowR0KBxhtbhXJIre43LQ2+WSmqvCAelOiX6cVE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574303386;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=o4LGGG49L2mFI3Z0m3DVLA0OdYWIS2drsZMLKtkysYw=;
        b=bKT0H6GQRPyCODgoCQky9AP4u/o8JfFoSL/X3Hs2lsLtqMwnF3ca13xNIsZW77Ko
        +vDnn3FFn6qzqkL1Iw3zkTg/o25Fo5jFWTqlt3rjLUtICwi2Ms+j863Ga6Uso6j7lNb
        mvyB3/840ZxSWFvvocCK2F7QyKAL+NtngOVEo+oE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Nov 2019 02:29:46 +0000
From:   wgong@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
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
In-Reply-To: <87zhgqmref.fsf@kamboji.qca.qualcomm.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191109103046.26445-4-ulf.hansson@linaro.org>
 <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
 <CAPDyKFrCyJBz2=RzKPxqn0FSEq500=dEDsTUWYZeoFKWvSRAdA@mail.gmail.com>
 <87zhgr5af6.fsf@codeaurora.org>
 <6e6b53b28581a8f1a2944ca0bc65311e@codeaurora.org>
 <0101016e87aeb8b6-761ad812-5da7-4b0d-8cae-c69633d90de0-000000@us-west-2.amazonses.com>
 <CAPDyKFoWxw9r=GZhvF=TxHxo=zRfKr0hknEeQNPdfwPx4ORxuQ@mail.gmail.com>
 <87zhgqmref.fsf@kamboji.qca.qualcomm.com>
Message-ID: <0101016e8bcb4c1c-a1935acc-6142-4dc2-8108-03403ff8b772-000000@us-west-2.amazonses.com>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.11.21-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-21 00:41, Kalle Valo wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
>> On Wed, 20 Nov 2019 at 08:20, Kalle Valo <kvalo@codeaurora.org> wrote:
>>> 
>>> wgong@codeaurora.org writes:
>>> 
>>> > On 2019-11-20 14:28, Kalle Valo wrote:
>>> >> + wen, ath10k
>>> >>
>>> >> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>> >>
>>> >>> On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders@chromium.org>
>>> >>> wrote:
>>> >>>>
>>> >>>> Hi,
>>> >>>>
>>> >>>> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson
>>> >>>> <ulf.hansson@linaro.org> wrote:
>>> >>>> >
>>> >>>> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> >>>> > index 6f8342702c73..abf8f5eb0a1c 100644
>>> >>>> > --- a/drivers/mmc/core/core.c
>>> >>>> > +++ b/drivers/mmc/core/core.c
>>> >>>> > @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>>> >>>> >         mmc_bus_put(host);
>>> >>>> >  }
>>> >>>> >
>>> >>>> > -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>>> >>>> > -                               bool cd_irq)
>>> >>>> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>>> >>>> >  {
>>> >>>> >         /*
>>> >>>> >          * If the device is configured as wakeup, we prevent a new sleep for
>>> >>>> > @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
>>> >>>> >         ret = host->bus_ops->hw_reset(host);
>>> >>>> >         mmc_bus_put(host);
>>> >>>> >
>>> >>>> > -       if (ret)
>>> >>>> > +       if (ret < 0)
>>> >>>> >                 pr_warn("%s: tried to HW reset card, got error %d\n",
>>> >>>> >                         mmc_hostname(host), ret);
>>> >>>>
>>> >>>> Other callers besides marvell need to be updated?  In theory only
>>> >>>> SDIO
>>> >>>> should have positive return values so I guess we don't care about the
>>> >>>> caller in drivers/mmc/core/block.c, right?
>>> >>>
>>> >>> Correct, but maybe I should add some more information about that in a
>>> >>> function header of mmc_hw_reset(). Let me consider doing that as a
>>> >>> change on top.
>>> >>>
>>> >>>>  What about:
>>> >>>>
>>> >>>> drivers/net/wireless/ath/ath10k/sdio.c
>>> >>>>
>>> >>>> ...I guess I don't know if there is more than one function probed
>>> >>>> there.  Maybe there's not and thus we're fine here too?
>>> >>>
>>> >>> Well, honestly I don't know.
>>> >>>
>>> >>> In any case, that would mean the driver is broken anyways and needs to
>>> >>> be fixed. At least that's my approach to doing this change.
>>> >>
>>> >> Wen, does QCA6174 or QCA9377 SDIO devices have other SDIO functions,
>>> >> for
>>> >> example bluetooth? I'm just wondering how should we handle this in
>>> >> ath10k.
>>> >
>>> > it does not have other SDIO functions for QCA6174 or QCA9377.
>>> 
>>> Thanks, then I don't think we need to change anything in ath10k.
>>> 
>>> --
>>> Kalle Valo
>> 
>> Kalle, Wen - thanks for looking into this and for the confirmation.
>> 
>> One thing though, perhaps it's worth to add this as a comment in the
>> code for ath10k, where mmc_hw_reset() is called. Just to make it
>> clear.
> 
> Good point. Wen, can you send a patch, please?
Kalle, sure, I will send the patch.

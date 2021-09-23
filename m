Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA822415A14
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 10:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbhIWIgW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 04:36:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54877 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbhIWIgV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 04:36:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632386090; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RnAXDb/cdy2vNbulmV0mjCa/sumMUiZffdwxvVj6GIc=;
 b=lM4asBQr1SOnpgcq2Tzf1ZymJ+uFN+XVuJN3LdWbVKPgJau/owizezKny7eXsq2S8/lBJU2f
 V8YyArwaP94mFsya8j/1AMQPX8UN+OAzj/gn2zoayJOVOqJXIx1XgFLH8S45tpi1XL0yLDrs
 bnTvV6030faWEs5CXWP0mdsUUg0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 614c3c24ec62f57c9ad4d9d6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 23 Sep 2021 08:34:44
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C962BC43460; Thu, 23 Sep 2021 08:34:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10B7EC4338F;
        Thu, 23 Sep 2021 08:34:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 23 Sep 2021 16:34:43 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        ath11k@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [regression] mhi: ath11k resume fails on some devices
In-Reply-To: <20210916171927.GB9027@thinkpad>
References: <871r5p0x2u.fsf@codeaurora.org>
 <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
 <20210916111218.GA12918@thinkpad>
 <CAMZdPi94607mZorp+Zmkw3seWXak6p9Jr05CQ5hhfgKQoG8n7Q@mail.gmail.com>
 <20210916163529.GA9027@thinkpad> <87k0jgxyjp.fsf@codeaurora.org>
 <20210916171927.GB9027@thinkpad>
Message-ID: <b7c0906041dcafb43be215bd4f55326a@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-17 01:19, Manivannan Sadhasivam wrote:
> On Thu, Sep 16, 2021 at 07:42:02PM +0300, Kalle Valo wrote:
>> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
>> 
>> > On Thu, Sep 16, 2021 at 01:18:22PM +0200, Loic Poulain wrote:
>> >> Le jeu. 16 sept. 2021 à 13:12, Manivannan Sadhasivam <
>> >> manivannan.sadhasivam@linaro.org> a écrit :
>> >>
>> >
>> > [...]
>> >
>> >> > If things seems to work fine without that patch, then it implies that
>> >> > setting M0
>> >> > state works during resume. I think we should just revert that patch.
>> >> >
>> >> > Loic, did that patch fix any issue for you or it was a cosmetic fix only?
>> >>
>> >>
>> >> It fixes sdx modem resuming issue, without that we don’t know modem needs
>> >> to be reinitialized.
>> >>
>> >
>> > Okay. Then in that case, the recovery mechanism has to be added to the ath11k
>> > MHI controller.
>> 
>> What does that mean in practise, do you have any pointers or examples? 
>> I
>> have no clue what you are proposing :)
>> 
> 
> Take a look at the mhi_pci_recovery_work() function below:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi/pci_generic.c#n610
> 
> You need to implement something similar that basically powers up the 
> MHI
> endpoint (QCA6390) in case pm_resume() fails. At minimum, you need to 
> call
> below functions:
> 
> # Check if the device is powered on. If yes, then power it down to 
> bring it back
> mhi_power_down()
> mhi_unprepare_after_power_down()
> 
> # Power up the device
> mhi_prepare_for_power_up()
> mhi_sync_power_up()
> 
> This implies that the WLAN device has been powered off during suspend, 
> so the
> resume fails and we are bringing the device back to working state.
> 
This is fine for platform which doesn't provide power supply during 
suspend.
But NUC has power supply in suspend state.
QCA6390 on NUC works after just reverting this commit also proves NUC 
has power supply in
suspend state.

The reason is MHI-STATUS register can't be read somehow in M3 state on 
NUC.
Does the MHI spec state that MHI-STATUS register can be read in M3 
state?

>> > If that's too much of work for Kalle, then I'll look into it. But I might get
>> > time only after Plumbers.
>> 
>> I'm busy, as always, so not sure when I'm able to do it either. I 
>> think
>> we should seriously consider reverting 020d3b26c07a and adding it back
>> after ath11k is able to handle this new situation.
>> 
> 
> Since Loic said that reverting would cause his modem (SDX device) to 
> fail during
> resume, this is not possible.
> 
> Thanks,
> Mani
> 
>> --
>> https://patchwork.kernel.org/project/linux-wireless/list/
>> 
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1F6415AED
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhIWJ2c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 05:28:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50638 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240111AbhIWJ2c (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 05:28:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632389221; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=nwIqQQTWureI6o4/Gjjs7du07LTdw+L9gBJa3OcDoLM=;
 b=WOOpXyYtLMB8zHUyid7O39ReFWQO0DIdZQJoB9eoz5OHIZq2prLBRcnR7uxVEztUA5H47wJT
 ZOTr7dfWPfCq8GrEYAWx2wWp6xaLip2e9A/6HePLpxU4LyzvF8W6y5M/W2uL5R0tq1615YAM
 RO03NMiGow+FIGFCwuH/H4JQxJ0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 614c4863bd6681d8ed7dd350 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 23 Sep 2021 09:26:59
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EEDB1C43617; Thu, 23 Sep 2021 09:26:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC7C6C4338F;
        Thu, 23 Sep 2021 09:26:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 23 Sep 2021 17:26:56 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        ath11k@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [regression] mhi: ath11k resume fails on some devices
In-Reply-To: <20210923085926.GD6083@thinkpad>
References: <871r5p0x2u.fsf@codeaurora.org>
 <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
 <20210916111218.GA12918@thinkpad>
 <CAMZdPi94607mZorp+Zmkw3seWXak6p9Jr05CQ5hhfgKQoG8n7Q@mail.gmail.com>
 <20210916163529.GA9027@thinkpad> <87k0jgxyjp.fsf@codeaurora.org>
 <20210916171927.GB9027@thinkpad>
 <b7c0906041dcafb43be215bd4f55326a@codeaurora.org>
 <20210923085926.GD6083@thinkpad>
Message-ID: <6912b6840858c0554922c01a0f9c47b8@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-23 16:59, Manivannan Sadhasivam wrote:
> On Thu, Sep 23, 2021 at 04:34:43PM +0800, Carl Huang wrote:
>> On 2021-09-17 01:19, Manivannan Sadhasivam wrote:
>> > On Thu, Sep 16, 2021 at 07:42:02PM +0300, Kalle Valo wrote:
>> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
>> > >
>> > > > On Thu, Sep 16, 2021 at 01:18:22PM +0200, Loic Poulain wrote:
>> > > >> Le jeu. 16 sept. 2021 à 13:12, Manivannan Sadhasivam <
>> > > >> manivannan.sadhasivam@linaro.org> a écrit :
>> > > >>
>> > > >
>> > > > [...]
>> > > >
>> > > >> > If things seems to work fine without that patch, then it implies that
>> > > >> > setting M0
>> > > >> > state works during resume. I think we should just revert that patch.
>> > > >> >
>> > > >> > Loic, did that patch fix any issue for you or it was a cosmetic fix only?
>> > > >>
>> > > >>
>> > > >> It fixes sdx modem resuming issue, without that we don’t know modem needs
>> > > >> to be reinitialized.
>> > > >>
>> > > >
>> > > > Okay. Then in that case, the recovery mechanism has to be added to the ath11k
>> > > > MHI controller.
>> > >
>> > > What does that mean in practise, do you have any pointers or
>> > > examples? I
>> > > have no clue what you are proposing :)
>> > >
>> >
>> > Take a look at the mhi_pci_recovery_work() function below:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi/pci_generic.c#n610
>> >
>> > You need to implement something similar that basically powers up the MHI
>> > endpoint (QCA6390) in case pm_resume() fails. At minimum, you need to
>> > call
>> > below functions:
>> >
>> > # Check if the device is powered on. If yes, then power it down to bring
>> > it back
>> > mhi_power_down()
>> > mhi_unprepare_after_power_down()
>> >
>> > # Power up the device
>> > mhi_prepare_for_power_up()
>> > mhi_sync_power_up()
>> >
>> > This implies that the WLAN device has been powered off during suspend,
>> > so the
>> > resume fails and we are bringing the device back to working state.
>> >
>> This is fine for platform which doesn't provide power supply during 
>> suspend.
>> But NUC has power supply in suspend state.
> 
> If NUC retains power supply during suspend then it should work with 
> that commit.
> During resume, the device is expected to be in M3 state and that's what 
> the
> commit verifies.
> 
> If the device is in a different state, then most likely the device have 
> power
> cycled.
> 
But the tricky thing here is that upstream QCA6390 doesn't have recovery 
mechanism to download
firmware again, so QCA6390 has no way to work after a power cycle.

>> QCA6390 on NUC works after just reverting this commit also proves NUC 
>> has
>> power supply in
>> suspend state.
>> 
> 
> That's because we allowed the device to be in any state during resume 
> and if it
> responds to the M0 transition it worked.
> 
>> The reason is MHI-STATUS register can't be read somehow in M3 state on 
>> NUC.
> 
> No, that's not correct.
> 
>> Does the MHI spec state that MHI-STATUS register can be read in M3 
>> state?
>> 
> 
> Yes, all the MHI registers are accessible in all states. During M3, 
> both MHI
> host and device (if supported) will transition to D3 Cold. Then during 
> resume,
> host will switch to D0 link state and will also notify the device to 
> enter D0.
> 
> For aid debugging, please see the state the device is in during 
> mhi_pm_resume().
> You can use below diff:
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index fb99e3727155..482d55dd209e 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -898,6 +898,9 @@ int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
>         if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
>                 return -EIO;
> 
> +       dev_info(dev, "Device state: %s\n",
> +                TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
> +
>         if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3)
>                 return -EINVAL;
> 
> 
> Thanks,
> Mani

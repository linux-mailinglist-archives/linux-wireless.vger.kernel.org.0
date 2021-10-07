Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9331642507C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Oct 2021 11:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhJGJ5y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 05:57:54 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:35850 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJGJ5y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 05:57:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633600560; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=JPSPpsHMPoMb0VA37Z4j/oJJWZ6PIItI66wnYCMe2qo=; b=kg67rkRz8WYgijpwGcW1/NP8Ex4Fc5kqa3cOpuniWDqJomMv8/346O0dseDNL1s7M7aF7Ij8
 TxTnRJ3pMOFUNC/Y9z8FgNabfJuceY/QFfP/JpAo6u9Tj4hCF4eG92UOUt+aB2b0CRV8gW+1
 sTgUax2K/9dOn7ZjRRFkS1DhtqY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 615ec430ff0285fb0ad22798 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 07 Oct 2021 09:56:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C17CEC43616; Thu,  7 Oct 2021 09:55:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 399CBC4338F;
        Thu,  7 Oct 2021 09:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 399CBC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Carl Huang <cjhuang@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        ath11k@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
        mhi <mhi@lists.linux.dev>
Subject: Re: [regression] mhi: ath11k resume fails on some devices
References: <871r5p0x2u.fsf@codeaurora.org>
        <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
        <20210916111218.GA12918@thinkpad>
        <CAMZdPi94607mZorp+Zmkw3seWXak6p9Jr05CQ5hhfgKQoG8n7Q@mail.gmail.com>
        <20210916163529.GA9027@thinkpad> <87k0jgxyjp.fsf@codeaurora.org>
        <20210916171927.GB9027@thinkpad>
        <b7c0906041dcafb43be215bd4f55326a@codeaurora.org>
        <20210923085926.GD6083@thinkpad> <8735putk82.fsf@codeaurora.org>
        <20210924095755.GB19050@workstation>
Date:   Thu, 07 Oct 2021 12:55:52 +0300
In-Reply-To: <20210924095755.GB19050@workstation> (Manivannan Sadhasivam's
        message of "Fri, 24 Sep 2021 15:27:55 +0530")
Message-ID: <874k9t9n13.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(adding also mhi list)

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> On Fri, Sep 24, 2021 at 12:07:41PM +0300, Kalle Valo wrote:
>> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
>> 
>> > For aid debugging, please see the state the device is in during mhi_pm_resume().
>> > You can use below diff:
>> >
>> > diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
>> > index fb99e3727155..482d55dd209e 100644
>> > --- a/drivers/bus/mhi/core/pm.c
>> > +++ b/drivers/bus/mhi/core/pm.c
>> > @@ -898,6 +898,9 @@ int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
>> >         if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
>> >                 return -EIO;
>> >  
>> > +       dev_info(dev, "Device state: %s\n",
>> > +                TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
>> > +
>> >         if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3)
>> >                 return -EINVAL;
>> 
>> This is what I get with my NUC testbox:
>> 
>> [  970.488202] ACPI: EC: event unblocked
>> [  970.492484] hpet: Lost 1587 RTC interrupts
>> [  970.492749] mhi mhi0: Device state: RESET
>
> Looks like the MHI device went into RESET state! It also looks to be a
> firmware thing. But let's nail this down before adding any workaround in
> the MHI stack.
>
> Can you also rebuild the kernel with MHI debug enabled and capture the
> logs in faliure case?

So what I should exactly do to enable debug messages?

I have this in my Kconfig:

CONFIG_MHI_BUS=m
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_PCI_GENERIC is not set

And AFAICS CONFIG_MHI_BUS_DEBUG only enables the debugfs interface, I
doubt you meant that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

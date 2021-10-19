Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEC0433588
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 14:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhJSMO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 08:14:28 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:30905 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSMO1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 08:14:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634645535; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=oD8yCzrvHNN1ogSZeyYP+BbjUrlIhp1HkijKnjLBoV8=; b=CfAJeqakSepg6LzSL1Kn/Ncq6mKwCWxt2QJ4tqgPCmcgPEOWwINpDmjF30rEShw2gOP8SN/S
 YN3sqYxqzADy1SJ5A/hqMNRUqGz8mbwP3TvMz4HKR4aguCEhDMsrvpzd1t3S8EqxjgYxOsHN
 DlslMMbobjNbbmLjud/dySfNqnM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 616eb61759612e01006269e3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Oct 2021 12:12:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C49DC43616; Tue, 19 Oct 2021 12:12:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1656C43460;
        Tue, 19 Oct 2021 12:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D1656C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        regressions@lists.linux.dev, mhi <mhi@lists.linux.dev>
Subject: Re: [regression] mhi: ath11k resume fails on some devices
References: <871r5p0x2u.fsf@codeaurora.org>
        <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
        <877df6tlnq.fsf@codeaurora.org>
        <CAMZdPi8P7YZPhPir+WfS3cY_a7He1m2Pq2uqBhczPdEeoNRb0Q@mail.gmail.com>
        <87a6jl9ndo.fsf@codeaurora.org>
Date:   Tue, 19 Oct 2021 15:12:01 +0300
In-Reply-To: <87a6jl9ndo.fsf@codeaurora.org> (Kalle Valo's message of "Thu, 07
        Oct 2021 12:48:19 +0300")
Message-ID: <87ee8hgqni.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> (adding the new mhi list, yay)
>
> Hi Loic,
>
> Loic Poulain <loic.poulain@linaro.org> writes:
>
>>> Loic Poulain <loic.poulain@linaro.org> writes:
>>>
>>> > On Thu, 16 Sept 2021 at 10:00, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>
>>> >> At the moment I'm running my tests with commit 020d3b26c07a reverted and
>>> >> everything works without problems. Is there a simple way to fix this? Or
>>> >> maybe we should just revert the commit? Commit log and kernel logs from
>>> >> a failing case below.
>>> >
>>> > Do you have log of success case?
>>>
>>> A log from a successful case in the end of email, using v5.15-rc1 plus
>>> revert of commit 020d3b26c07abe27.
>>>
>>> > To me, the device loses power, that is why MHI resuming is failing.
>>> > Normally the device should be properly recovered/reinitialized. Before
>>> > that patch the power loss was simply not detected (or handled at
>>> > higher stack level).
>>>
>>> Currently in ath11k we always keep the firmware running when in suspend,
>>> this is a workaround due to problems between mac80211 and MHI stack.
>>> IIRC the problem was something related MHI creating struct device during
>>> resume or something like that.
>>
>> Could you give a try with the attached patch? It should solve your
>> issue without breaking modem support.
>
> Sorry for taking so long, but I now tested your patch on top of
> v5.15-rc3 and, as expected, everything works as before with QCA6390 on
> NUC x86 testbox.
>
> Tested-by: Kalle Valo <kvalo@codeaurora.org>

I doubt we will find enough time to fully debug this mhi issue anytime
soon. Can we commit Loic's patch so that this regression is resolved?

At the moment I'm doing all my regression testing with commit
020d3b26c07abe27 reverted. That's a risk, I would prefer to do my
testing without any hacks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

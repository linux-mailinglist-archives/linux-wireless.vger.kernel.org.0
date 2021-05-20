Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0A38B5BB
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhETSFc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 14:05:32 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25055 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhETSFa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 14:05:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621533849; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AFeMf3IUMl/U4pe6K8pI5cxfDW/3X5GMZL/kEyjcntY=;
 b=Iwn5WK+7kr6yAdCzhZ98bsJXDz62ZxvSHTA/aJI9UpeUG3+SrztrzbGwpNP9vt99Aj5ueEUO
 iQfNrboo9lH/EotMUtcu8y4fPZsezy8LQJhSBEp+iTXu/e5dxbm8HkXO7+gpSjrxuYugI7CI
 pk7VvaFWCOr10flBHe5HwqLfChM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60a6a4977b5af81b5cda787b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 May 2021 18:04:07
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9ABC5C4323A; Thu, 20 May 2021 18:04:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8BCFFC4338A;
        Thu, 20 May 2021 18:04:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 May 2021 11:04:05 -0700
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [regressions] ath11k: v5.12.3 mhi regression
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <YKajWVPUSTzNVVm8@kroah.com>
References: <87v97dhh2u.fsf@codeaurora.org> <YKYzwBJNTy4Czd1A@kroah.com>
 <20210520104313.GA128703@thinkpad> <87r1i1h9an.fsf@codeaurora.org>
 <3e8bac3b02e3549a55b7c9b78b699965@codeaurora.org>
 <YKajWVPUSTzNVVm8@kroah.com>
Message-ID: <608474b9b9feae5bd0616ad16d6d6bbd@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-05-20 10:58 AM, Greg KH wrote:
> On Thu, May 20, 2021 at 10:38:12AM -0700, Bhaumik Bhatt wrote:
>> On 2021-05-20 05:36 AM, Kalle Valo wrote:
>> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
>> >
>> > > On Thu, May 20, 2021 at 12:02:40PM +0200, Greg KH wrote:
>> > > > On Thu, May 20, 2021 at 12:47:53PM +0300, Kalle Valo wrote:
>> > > > > Hi,
>> > > > >
>> > > > > I got several reports that this mhi commit broke ath11k in v5.12.3:
>> > > > >
>> > > > > commit 29b9829718c5e9bd68fc1c652f5e0ba9b9a64fed
>> > > > > Author: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> > > > > Date:   Wed Feb 24 15:23:04 2021 -0800
>> > > > >
>> > > > >     bus: mhi: core: Process execution environment changes serially
>> > > > >
>> > > > >     [ Upstream commit ef2126c4e2ea2b92f543fae00a2a0332e4573c48 ]
>> > > > >
>> > > > > Here are the reports:
>> > > > >
>> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=213055
>> > > > >
>> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=212187
>> > > > >
>> > > > > https://bugs.archlinux.org/task/70849?project=1&string=linux
>> > > > >
>> > > > > Interestingly v5.13-rc1 seems to work fine, at least for me, though I
>> > > > > have not tested v5.12.3 myself. Can someone revert this commit in the
>> > > > > stable release so that people get their wifi working again, please?
>> > > >
>> > > > How does the mhi bus code relate to a ath11k driver?  What bus
>> > > > is that
>> > > > on?
>> > > >
>> > >
>> > > MHI is the transport used by the ath11k driver to work with the WLAN
>> > > devices
>> > > over PCIe.
>> > >
>> > > Regarding the bug, I'd suggest to wait for Bhaumik (the author of
>> > > 29b9829718c5)
>> > > to comment on the possible commit which needs backporting from
>> > > mainline.
>> >
>> > Ok, but if a quick fix is not available I think we should just revert
>> > this in the stable releases. I also got a report that v5.11.21 is
>> > broken:
>> >
>> > https://bugzilla.kernel.org/show_bug.cgi?id=213055#c11
>> 
>> Please pick [1] as the dependency to [ Upstream commit
>> ef2126c4e2ea2b92f543fae00a2a0332e4573c48 ].
> 
> what is [1]???
> 
> What commit do I need to backport, a commit id would be nice...
> 
> thanks,
> 
> greg k-h
Sure Greg. Commit id is: 4884362f6977fc05cbec736625665241c0e0732f

Title of patch:
bus: mhi: core: Download AMSS image from appropriate function

It was supposed to be a link but not sure why it's not seen.

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project

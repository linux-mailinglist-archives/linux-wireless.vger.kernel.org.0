Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E072B8353
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 18:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgKRRqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Nov 2020 12:46:08 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:10476 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbgKRRqH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Nov 2020 12:46:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605721567; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=CqQUjWS47OeGeZxznxTVUF9IHKIsAQr1JXT3ZOCJz8Y=;
 b=gX33FjW5pLp9UwBLZmxRQdiCf27MaUJWt/o8Gpr4u2hrtwsJbipPLbirHXx3yBwGybPOLdw8
 PS3W6Z3o2r4/FO4zWjgpgSgogxtJ1ZTaRQKjRdNgKcjMWSBG+0peeA0KPVFqYUgP8VuO8+Jn
 BdWMnQCz5vQjKX/ogq+/n+pf1BE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fb55ddd1dba509aaebd5e94 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Nov 2020 17:46:05
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8040EC43463; Wed, 18 Nov 2020 17:46:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE012C433ED;
        Wed, 18 Nov 2020 17:46:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Nov 2020 09:46:04 -0800
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Carl Huang <cjhuang@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, hemantk@codeaurora.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH] bus: mhi: Remove auto-start option
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <20201118115757.GA5680@thinkpad>
References: <20201118053102.13119-1-manivannan.sadhasivam@linaro.org>
 <877dqjz0bv.fsf@codeaurora.org> <20201118093107.GC3286@work>
 <16c430bbd5117a35496f85f4454095b9@codeaurora.org>
 <20201118115757.GA5680@thinkpad>
Message-ID: <1b5eb02e78b3b68b88dd3d12e3f8c60c@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-18 03:57 AM, Manivannan Sadhasivam wrote:
> On Wed, Nov 18, 2020 at 07:55:19PM +0800, Carl Huang wrote:
>> On 2020-11-18 17:31, Manivannan Sadhasivam wrote:
>> > On Wed, Nov 18, 2020 at 07:43:48AM +0200, Kalle Valo wrote:
>> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
>> > >
>> > > > From: Loic Poulain <loic.poulain@linaro.org>
>> > > >
>> > > > There is really no point having an auto-start for channels.
>> > > > This is confusing for the device drivers, some have to enable the
>> > > > channels, others don't have... and waste resources (e.g. pre allocated
>> > > > buffers) that may never be used.
>> > > >
>> > > > This is really up to the MHI device(channel) driver to manage the state
>> > > > of its channels.
>> > > >
>> > > > While at it, let's also remove the auto-start option from ath11k mhi
>> > > > controller.
>> > > >
>> > > > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> > > > [mani: clubbed ath11k change]
>> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> > >
>> > > Thanks and feel free to take this to the immutable branch:
>> > >
>> > > Acked-by: Kalle Valo <kvalo@codeaurora.org>
>> >
>> > Patch applied to mhi-ath11k-immutable branch and merged into mhi-next.
>> >
>> > Thanks,
>> > Mani
>> >
>> Does net/qrtr/mhi.c need changes? I guess now net/qrtr/mhi.c needs to 
>> call
>> mhi_prepare_for_transfer() before transfer.
>> 
> 
> Yes and the patch is also applied:
> https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?h=mhi-ath11k-immutable&id=a2e2cc0dbb1121dfa875da1c04f3dff966fec162
> 
> Thanks,
> Mani
> 
>> > >
>> > > --
>> > > https://patchwork.kernel.org/project/linux-wireless/list/
>> > >
>> > > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
It looks we forgot to add the mhi_unprepare_from_transfer() equivalent 
in the remove().

Will send a patch for it today.

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project

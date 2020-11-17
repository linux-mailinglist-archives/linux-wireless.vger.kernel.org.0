Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5212B5B99
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Nov 2020 10:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKQJQT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 04:16:19 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:48802 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgKQJQS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 04:16:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605604577; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=JNhM4hrT1K1sbdfbah3onfXovQ1gmk2bbDbUgt68rWk=; b=V9bvI9aSSkAe8cs1iXfH0ncH6SGbdUAwX/FOqsNr2+xhbrL/j0jvzKtmPJG+bh0RYe9twOfX
 ctLdPBsx+/jWJi86JrhG/sFHlpzC2I0mU2QxwGwlQo+nBkdw6xfamaVCvBMSg5qF7NXih/9k
 iCAba48hdk66R0f2DzAijevvJTc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fb394d1d6e6336a4ea7b8ed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Nov 2020 09:16:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8AF5DC433C6; Tue, 17 Nov 2020 09:16:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0DEA7C433C6;
        Tue, 17 Nov 2020 09:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DEA7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the mhi tree
References: <20201117151225.6a50abf8@canb.auug.org.au>
        <20201117042359.GB7787@work> <20201117042841.GC7787@work>
Date:   Tue, 17 Nov 2020 11:15:55 +0200
In-Reply-To: <20201117042841.GC7787@work> (Manivannan Sadhasivam's message of
        "Tue, 17 Nov 2020 09:58:41 +0530")
Message-ID: <87blfwz6lw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> On Tue, Nov 17, 2020 at 09:53:59AM +0530, Manivannan Sadhasivam wrote:
>> +ath11k list, kalle
>> 
>
> Oops... adding now
>
>> On Tue, Nov 17, 2020 at 03:12:25PM +1100, Stephen Rothwell wrote:
>> > Hi all,
>> > 
>> > After merging the mhi tree, today's linux-next build (x86_64 allmodconfig)
>> > failed like this:
>> > 
>> > drivers/net/wireless/ath/ath11k/mhi.c:27:4: error: 'struct
>> > mhi_channel_config' has no member named 'auto_start'
>> >    27 |   .auto_start = false,
>> >       |    ^~~~~~~~~~
>> > drivers/net/wireless/ath/ath11k/mhi.c:42:4: error: 'struct
>> > mhi_channel_config' has no member named 'auto_start'
>> >    42 |   .auto_start = false,
>> >       |    ^~~~~~~~~~
>> > drivers/net/wireless/ath/ath11k/mhi.c:57:4: error: 'struct
>> > mhi_channel_config' has no member named 'auto_start'
>> >    57 |   .auto_start = true,
>> >       |    ^~~~~~~~~~
>> > drivers/net/wireless/ath/ath11k/mhi.c:72:4: error: 'struct
>> > mhi_channel_config' has no member named 'auto_start'
>> >    72 |   .auto_start = true,
>> >       |    ^~~~~~~~~~
>> > 
>> > Caused by commit
>> > 
>> >   0cc1f3a385b2 ("bus: mhi: Remove auto-start option")
>> > 
>> 
>> The fixing patch [1] should've landed in ath-next. Kalle can you please
>> apply the patch on top of immutable branch?
>> 
>> Stephen, feel free to pick it up in the meantime.

I think this fix should be included in commit 0cc1f3a385b2 ("bus: mhi:
Remove auto-start option"), otherwise the build will always fail. I can
then pull this commmit from the MHI immutable branch to my ath.git tree
and from there it will go to wireless-drivers-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

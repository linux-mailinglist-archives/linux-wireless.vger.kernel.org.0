Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4927764D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 18:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgIXQLo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 12:11:44 -0400
Received: from z5.mailgun.us ([104.130.96.5]:55591 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIXQLn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 12:11:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600963903; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=dqHrIvcC6rxUf6oLRzsClpb3qQDa8iRqHSuBWXstTng=; b=Lt+z29JrmZ/D3BFR24K+lLzOsOAln21p5OC3qj6bTxfZQztXoDphbUFKWM3gG8wu8k3vyfN/
 G1BMBhZBjW59n4dkFuwCJx+4jIgTQ1vh4Hs5z4bv+iXZE2mbVghYy+HiVTy+B68jEKKLnLu+
 32Y183s6BddOFH6rR129w27gSfI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f6cc53e971b64f61b74d257 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 16:11:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 225A8C433C8; Thu, 24 Sep 2020 16:11:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1EC1EC433CA;
        Thu, 24 Sep 2020 16:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EC1EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: linux-next: Fixes tag needs some work in the wireless-drivers-next tree
References: <20200819083359.67f45112@canb.auug.org.au>
        <87y2mbi0u8.fsf@codeaurora.org>
        <20200819181351.0cd6f414@canb.auug.org.au>
Date:   Thu, 24 Sep 2020 19:11:36 +0300
In-Reply-To: <20200819181351.0cd6f414@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 19 Aug 2020 18:13:51 +1000")
Message-ID: <87lfgznohz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Stephen,

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> On Wed, 19 Aug 2020 09:52:47 +0300 Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Doh, I have checked carefully the commit ids but of course I missed
>> checking the trailing. I really need to automate this. Stephen, are your
>> scripts checking these available somewhere?
>
> I have attached them to this reply.  

Thanks a lot, these scripts are very helpful. For example with these I
quickly found a problem in one pull request I recently got. I do see
some cosmetic problems, most likely due to my git settings or version,
but should be easy to fix.

> I should put them up in a git repo somewhere.

Yeah, please do. I'm sure people would benefit from these.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

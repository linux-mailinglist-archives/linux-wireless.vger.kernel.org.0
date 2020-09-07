Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1C825FE1E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgIGQH1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 12:07:27 -0400
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:49048
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730315AbgIGQHF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 12:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599494823;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=RBCCVdiS1GRhiR2h+Mq8TkVTmyEzQDdLzluGnF03Xzo=;
        b=pBt1yiiDUkQZeYNaekel/itCCyIR+bEUw6FypbScSaDoLBTa819nsZc8HHjALK+Q
        O9E18ddjfg9iDgsPICwmGfqY28Cmx4vkXPoNkrkkd788By9VzPNKdE3tzGvIrDOpe+f
        oDvMr6CDxpiqi9xvn8d06/mLFL9QAzmTch5Q7lK0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599494823;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=RBCCVdiS1GRhiR2h+Mq8TkVTmyEzQDdLzluGnF03Xzo=;
        b=LToyNfEVjCsZt1pG2my8k5GIInO6FPDpJenwiQqATcEFrA46dGqxcC6HIlUa5uyl
        EGhbxP3DnBzJ3R2PpKt8dHBuK8Xc3NXBJZSRRmhnLGLq2XGq9QGvhyEii2GYfsVm1uP
        J/qDlDquHA8ZcGWKP53FzS4JaNgjKmupezP75YZY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D9ADC6CD07
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when insmod and rmmod for sdio
References: <20200214035555.24762-1-wgong@codeaurora.org>
        <878se9iup3.fsf@codeaurora.org>
        <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
        <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org>
        <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
        <dcc45384935dca14ac6ab31ec1123414@codeaurora.org>
        <CABPxzYLu_81h+aWWeNKRyH=CJ=+waB3zmT41BTZ9Mo733PqErQ@mail.gmail.com>
        <acb2bd58-2f95-e09c-9575-b45c0e2aeb70@candelatech.com>
        <CABPxzY+tPos8ByT76hU1ngoxwYcBHaRpFMCKGQJcc_ssoqGNSw@mail.gmail.com>
        <47c1b1e0-afc4-b9b4-5fc0-4636d8b3b981@candelatech.com>
        <CABPxzYLD-M5wpWF6r=K=8YTosSfjctmaaBPCyBP72q-mY0PTcw@mail.gmail.com>
        <CABPxzYLOZf9Fu5O3Rt_mVcXeFLuuFAsqyvd7jiCVvJ0x2BN-+g@mail.gmail.com>
        <dd8cb5db-f164-c235-1f39-cd78ea97f8be@candelatech.com>
        <CABPxzY+uyy_Yc0mHb7sJGxxUE5__Z8SpywodAv2YCM8D89waHw@mail.gmail.com>
        <c69abe52-ccd1-ac73-8691-d87f5ed8be76@candelatech.com>
Date:   Mon, 7 Sep 2020 16:07:02 +0000
In-Reply-To: <c69abe52-ccd1-ac73-8691-d87f5ed8be76@candelatech.com> (Ben
        Greear's message of "Thu, 20 Aug 2020 13:59:13 -0700")
Message-ID: <0101017469521b96-b069f805-537a-479e-bd91-a53357035e68-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

>>>>>> Here is my original patch to fix this, it is not complex.
>>>>>>
>>>>>> https://patchwork.kernel.org/patch/10249363/
>>>>> Sure, I have shared your patch above :).
>>>> Sent a bit early, any idea why this wasn't upstreamed earlier?
>>>
>>> No, one comment from Michal indicated maybe there were more problems lurking
>>> in this area, but he seemed to be OK with the patch over all.  After that,
>>> it was just ignored.
>>>
>> Now might be a good time to push for it :)
>>
>
> It is generally a waste of time in my experience.  Kalle is the maintainer and should
> be seeing any of this he cares to see.  If he likes the patch, he can apply it or
> something similar.  If you have a reproducible test case, see if the patch fixes
> things, that might help it be accepted.

The problem with yours (Ben's) patches is that you have your own set of
patches for ath10k and your own firmware. So I cannot know at all if
your patches work with upstream ath10k and upstream firmware, and would
need to test the patches myself. But nowadays I just can't find the time
for testing. So if someone else can do the testing and provide a
Tested-on tag it would it increase my confidence level for the patches.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

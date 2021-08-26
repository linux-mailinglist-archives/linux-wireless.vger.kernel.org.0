Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C263F8AA0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbhHZPCa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 11:02:30 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19611 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhHZPC3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 11:02:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629990102; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=cvfqRjapXCxL1Oo9zylXK4vdNZnDzhAgTrYpUpBnjqU=; b=X0696Zt7+5Rm3Q3h9ji16C9XUVaY4Gb6B8312EhVncrkYoIIwOkVUTjAgwOcBvGnuoB2S4iL
 DEKxwdd9mwjlHxl2PS+laDevVG2A7uuYYVeG4kumcTKcRsmj/2pX/KBz8xA3W+HP8f+JRXJd
 Gmpo1/m1Wq2V2tky0kqoCDET0bc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6127aca3d6653df7672fde8b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Aug 2021 15:00:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18A44C43460; Thu, 26 Aug 2021 15:00:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D542C4338F;
        Thu, 26 Aug 2021 15:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1D542C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Wren Turkal <wt@penguintechs.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [regression] Re: 5.14 rc6 broken for QCA6390 on Dell XPS 13 9310
References: <a8cddf24-ecfc-088e-27f4-98cbbb5fb67c@penguintechs.org>
        <87y28sqq4l.fsf@codeaurora.org>
        <843e7689-fa1e-441b-c49a-ed7291046d5f@freebox.fr>
        <87tujgqcth.fsf@codeaurora.org> <87mtp47073.fsf_-_@codeaurora.org>
        <YSenaxWzxRkYkucv@kroah.com>
        <20210826074850.16768dee@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Date:   Thu, 26 Aug 2021 18:00:40 +0300
In-Reply-To: <20210826074850.16768dee@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        (Jakub Kicinski's message of "Thu, 26 Aug 2021 07:48:50 -0700")
Message-ID: <87eeag6yjr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 26 Aug 2021 16:38:35 +0200 Greg Kroah-Hartman wrote:
>> > I did some investiation and I suspect that commit ce78ffa3ef16 ("net:
>> > really fix the build...")[1] is for handling a conflict between net-next
>> > and char-misc-next trees related to Loic's commit 0092a1e3f763 ("bus:
>> > mhi: Add inbound buffers allocation flag"). Greg mentions this in a
>> > commit[2]:
>> > 
>> > commit 813272ed5238b37c81e448b302048e8008570121
>> > Merge: de0534df9347 36a21d51725a
>> > Author:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > 
>> >     Merge 5.14-rc5 into char-misc-next
>> >     
>> >     We need the fixes in here as well, and resolves some merge issues with
>> >     the mhi codebase.
>> > 
>> > If my assumption is correct when I propose that we revert commit
>> > ce78ffa3ef16 for v5.14, AFAICS it's not really needed for v5.14 (commit
>> > 0092a1e3f763 is in -next, not in Linus' tree yet) and commit
>> > ce78ffa3ef16 breaks ath11k. And the conflict between net-next and
>> > char-misc-next can be then later fixed during the merge window.
>> > 
>> > Will this work for everyone? If no objections, I'll submit the revert to
>> > Linus later today. We are getting really close to final v5.14 release so
>> > not much time left to fix this.
>> > 
>> > Just to reiterate why the urgency: commit ce78ffa3ef16 broke ath11k in
>> > v5.14-rc5, users have reported (and I have confirmed) that at least
>> > QCA6390 support is broken but I suspect all Qualcomm Wi-Fi 6 devices
>> > supported by ath11k are currently broken.  
>> 
>> No objection from me for reverting that, if it fixes the problems you
>> are seeing for 5.14-final.
>> 
>> The goal was for the mhi changes to go through the networking tree in
>> the first place, I don't see how this got out of sync.
>> 
>> If this is reverted, some help on how to resolve the merge issues it
>> will cause would be appreciated.
>
> Also no objections here. FWIW I'm about to send the last PR for
> networking, still waiting on BPF. You can send the revert to netdev, 
> or directly to Linus as you prefer. LMK.

I prefer take it via the net tree if possible, so if you can wait ~2h
and I'll send it to you.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

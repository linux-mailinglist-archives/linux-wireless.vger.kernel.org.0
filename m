Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BCE1A9208
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 06:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393102AbgDOEpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 00:45:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:41659 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389526AbgDOEpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 00:45:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586925917; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=q3gCiDnOZN7/IwndjJlLd8ej2L8L2thGpNW3oLnTOB4=; b=MTO4EqKCUFid2R8mMPDLVi1+IWq0sz4d7Dto6Ndu2KQ0xtGhxfufYOOxIHjMZTqhWWJkr4tC
 w7DI+PHD1WsXBhsW+evV0/X3DBc7saBYAmKuiRGVod6cXSq+CiKXrXKrq9W15vm4ztr8rPWB
 a5DRMHf8U89Tvbo2xuE3D27eQWA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e969157.7efdfb48ec38-smtp-out-n03;
 Wed, 15 Apr 2020 04:45:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E65A6C432C2; Wed, 15 Apr 2020 04:45:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C927BC433BA;
        Wed, 15 Apr 2020 04:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C927BC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the wireless-drivers-next tree
References: <20200415080827.30c2c9c1@canb.auug.org.au>
        <5b17fefe-f99d-2e4c-ded2-93fd3554687c@lwfinger.net>
        <20200415110649.39e26be3@canb.auug.org.au>
Date:   Wed, 15 Apr 2020 07:45:06 +0300
In-Reply-To: <20200415110649.39e26be3@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 15 Apr 2020 11:06:49 +1000")
Message-ID: <87tv1ls6gd.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Larry,
>
> On Tue, 14 Apr 2020 19:36:28 -0500 Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>> On 4/14/20 5:08 PM, Stephen Rothwell wrote:
>> > 
>> > In commit
>> > 
>> >    ec4d3e3a0545 ("b43legacy: Fix case where channel status is corrupted")
>> > 
>> > Fixes tag
>> > 
>> >    Fixes: 75388acd0cd8 ("add mac80211-based driver for legacy BCM43xx devices")
>> > 
>> > has these problem(s):
>> > 
>> >    - Subject does not match target commit subject
>> >      Just use
>> > 	git log -1 --format='Fixes: %h ("%s")'
>> 
>> I do not understand what you want here. The subject describes what was fixed. 
>> The error has been in the driver since it was merged. The Fixes: line is a 
>> description of the commit that introduced the driver file with the error.
>
> The subject I was referring to is the subject quoted in the Fixes tag,
> not the subject of the fixing commit.  So:
>
> Fixes: 75388acd0cd8 ("[B43LEGACY]: add mac80211-based driver for
> legacy BCM43xx devices")
>
> Its not very important, just a consistency thing - I wouldn't bother
> rebasing just to fix this, just for the future ...

Yeah, I don't normally rebase wireless-drivers-next so this has to be
like this. But hopefully some time in the future I'll end up adding a
check for this in my patchwork script.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

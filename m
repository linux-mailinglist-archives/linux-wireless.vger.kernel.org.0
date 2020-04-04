Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F0119E460
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2020 12:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDDKFm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Apr 2020 06:05:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:39935 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbgDDKFm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Apr 2020 06:05:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585994742; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=3GAnmkswPjwBSgBCS22g329FoV7EMVAnRPDSd8PlgYE=; b=Kvgy2L+SH1EO0KY3I7jcCvnIQgaoGhL7+4SyWY2hpgGt1fPIpblik1wKFSPk9VilPEWOCtXR
 MbBKWfACy/cQSZkOZLdYQnSd3gPN5vPclCjPLeDmxw7M24P2M/IOYSe2HemrxfMFaQH/gX7P
 Lznbc5eeKl20oLdhmUz5H56aut4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e885bf5.7f509e960458-smtp-out-n02;
 Sat, 04 Apr 2020 10:05:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6946FC433BA; Sat,  4 Apr 2020 10:05:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 628B7C433F2;
        Sat,  4 Apr 2020 10:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 628B7C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, Ajay.Kathat@microchip.com,
        gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        Adham.Abozaeid@microchip.com, johannes@sipsolutions.net
Subject: Re: [PATCH v3] staging: wilc1000: Use crc7 in lib/ rather than a private copy
References: <20200326152251.19094-1-ajay.kathat@microchip.com>
        <20200402082745.GG2001@kadam> <20200402153034.GB2013@SDF.ORG>
        <20200403091029.GC2001@kadam> <20200403234028.GA11944@SDF.ORG>
Date:   Sat, 04 Apr 2020 13:05:36 +0300
In-Reply-To: <20200403234028.GA11944@SDF.ORG> (George Spelvin's message of
        "Fri, 3 Apr 2020 23:40:28 +0000")
Message-ID: <87k12vo9an.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

George Spelvin <lkml@SDF.ORG> writes:

> On Fri, Apr 03, 2020 at 12:10:29PM +0300, Dan Carpenter wrote:
>> On Thu, Apr 02, 2020 at 03:30:34PM +0000, George Spelvin wrote:
>> > On Thu, Apr 02, 2020 at 11:27:45AM +0300, Dan Carpenter wrote:
>> > > I don't know how this patch made it through two versions without anyone
>> > > complaining that this paragraph should be done as a separate patch...
>> > 
>> > I often fold comment (and spacing/formatting) patches in to a main
>> > patch, when touching adjacent code anyway and it doesn't cause
>> > distracting clutter.
>> > 
>> > This seemed like such a case, which is why I submitted it as one.
>> > But it's a bit of style thing.
>> > 
>> 
>> We're super strict in Staging.  :P  Greg is more strict than I am.
>
> Okay, but it's my fault, not his.
>
>>> This should have you Signed-off-by.  The Reviewed-by is kind of assumed
>>>> so you can drop that bit.  But everyone who touches a patch needs to
>>>> add their signed off by.
>>> 
>>> Er... all he did was add "staging: " to the front of the title.
>>> 
>>> That's not a change to the code at all, and as trivial a change
>>> to the commit message as adding "Reviewed-by:" to the end.
>>> We don't need S-o-b for such things or we'd end up in a horrible
>>> infinite recursion.
>> 
>> You've misunderstood.  He sent the email so he has to add his
>> Signed-off-by.  It's not at all related to changing anything in the
>> patch.  That's how sign offs work.
>
> Looking at my commits (just because I remember how they went in),
> you seem to be right, but damn, submitting-patches.rst could be
> clearer on the subject.
>
> I understand that it's addressed more to patch authors than
> maintainers forwarding them, but I've read that thing a dozen times,
> and the description of S-o-b always seemed to be about copyright.
>
> So I had assumed that edits which were below the de minimus standard
> of copyright didn't need a separate S-o-b.
>
> Am I right that there should be an S-o-b from everyone from the
> patch author to the patch committer (as recorded in git)?

Yes, everyone either modifying or distributing (=submitting) the patch
should add their s-o-b.

> And the one exception is that we don't need S-o-b for git pulls after
> that, because the merge commits record the information?

Correct. When you do a git pull you are pulling the commits without any
modification, so technically it's not even possible to add the s-o-b
lines to the commits you are pulling. Modifying the commit logs would
need a rebase and then it not would be a normal git pull anymore.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

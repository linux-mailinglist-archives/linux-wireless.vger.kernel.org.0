Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA303260A69
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 07:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgIHFzD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 01:55:03 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:46232
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728857AbgIHFzC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 01:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599544501;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=CI3Y94LAkRebK+3EmhhUUk9FCWO9OjywXjXF6tKsebM=;
        b=mHDqYcypBOfJjyjhsZ5hSkV+QPoIt/rJVujsyDMhaUmjwC8vgccUD90QaOtpwRKt
        f3kJGs6yDRHX/haZlvWQMtmAaq8K9aXdyhPOgKoKilVpin7++9uKiuAT3twEy8QHwvC
        Ce4U4FtgJy9jMOY6Z45TvDygHwyrWoR4HYr1I764=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599544501;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=CI3Y94LAkRebK+3EmhhUUk9FCWO9OjywXjXF6tKsebM=;
        b=j+j0u5H6tVgooIP5nbSUlO3lAb/c3ey9m6ZCmLCrnbmkMI+Zls04ZGc3QzyWfOxS
        ONVkdWeDuYCb0KsAz24ur+PJc+4yKYS9BExBRSl79OGEdOBtKyvatzxNQTStdO/Am9M
        +Oj8sgZMD/S7a2jUdwUDbptnDwMfRINgkgFuQbHQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5324FC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Brian Norris <briannorris@chromium.org>, Jouni Malinen <j@w1.fi>,
        Pkshih <pkshih@realtek.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Subject: Re: [PATCH 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power limits
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
        <1576684108-30177-2-git-send-email-kvalo@codeaurora.org>
        <1576748692.7758.17.camel@realtek.com> <20191219154828.GA12287@w1.fi>
        <CA+ASDXMTYLGbEkBPHSqtyitMEvY5o_MjU0s+NoWdnN_ORy1gDw@mail.gmail.com>
        <20191219185522.GA16010@w1.fi>
        <CA+ASDXNOxkrZTxL0Jo4ONR2YtL83BVc_w-rBXc6ggBLdwUpDZw@mail.gmail.com>
        <871rpqly6a.fsf@kamboji.qca.qualcomm.com>
        <e8908eafd8e6050eef8782c6a7019e318d14f65f.camel@sipsolutions.net>
        <CA+ASDXMf7iXuE9hQ-XitPPfvXP0EK5FchJLCu2+5Ag=ZC=0H0w@mail.gmail.com>
        <87lfjjx0o7.fsf@codeaurora.org>
        <CA+ASDXOAzPuOn_rMsRj4t56kC-TgoG0p5WhSTPJjB8xTTq5kfg@mail.gmail.com>
        <87y2n9clhj.fsf@codeaurora.org>
        <c3ef60c2263a6840d21f6a797ad3ffb685a728b8.camel@sipsolutions.net>
Date:   Tue, 8 Sep 2020 05:55:01 +0000
In-Reply-To: <c3ef60c2263a6840d21f6a797ad3ffb685a728b8.camel@sipsolutions.net>
        (Johannes Berg's message of "Thu, 30 Jul 2020 15:24:11 +0200")
Message-ID: <010101746c4824a0-4044dcc3-3713-4231-9789-fecff5795c43-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.08-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2020-07-24 at 12:26 +0300, Kalle Valo wrote:
>
>> > > So to me it feels like the best solution forward is to go with the
>> > > vendor API, do you agree? We can, of course, later switch to the common
>> > > API if we manage to create one which is usable for everyone.
>
> But why wouldn't we try that now, while we have it all in our heads (in
> a way ... even if this discussion drags out forever)?
>
> I mean, the range-based approach ought to work, and if we define it as a
> nested attribute list or so, we can even later add more attributes to it
> (chain limits, whatnot) without any backward compatibility concerns.
>
> So what is it that we _cannot_ do in a more common way today?
>
>> > I think we've had some healthy (though very protracted) discussion,
>> > and I don't think I've seen anyone bring up anything I wasn't already
>> > aware of that would prevent eventual consolidation. As long as we
>> > acknowledge those things (item 2 at
>> > https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api),
>> > I'm happy.
>> 
>> Good, I was just checking that we all are on the same page.
>
> But are we? ;-)
>
> I don't really see anything in the new proposal [1] that really explains
> why the common API that we've sort of vaguely outlined in this thread
> couldn't work? It just speaks of technical difficulties ("need a
> reporting API too"), but should we let that stop us?
>
> [1] https://patchwork.kernel.org/patch/11686317/

I misunderstood then, I thought everyone were leaning towards the vendor
API approach. But yeah, of course a common API is much better if people
think it's doable.

So I'll now drop all the vendor API patches from patchwork and
assume/hope that we will get the common API at some point.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

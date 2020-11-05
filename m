Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9C2A7D54
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgKELkB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 06:40:01 -0500
Received: from z5.mailgun.us ([104.130.96.5]:53064 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730339AbgKELiH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 06:38:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604576287; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=npGsiPpZAGWaxEP7FTl12P6BSY0p8t2PtlpAqucdik0=;
 b=Em7ArnjwAO9ViLfaqdhIt4UXHPYltqX46v2fVs7tV86qKpGh2XSgCQ+CqUHhpDtXhe1chH2j
 tuJoUcwe9F8xMWVTexrudY9++A0WCPhJkoFcrR8M20I/G2cakNXJuuFsasXmnTczBBpeKtn8
 7HUPaKPK/w9VNYK5+2yjQXGNccg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fa3e404e7df1eca9bc305fe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 11:37:40
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 50BDBC43387; Thu,  5 Nov 2020 11:37:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80DA9C433C8;
        Thu,  5 Nov 2020 11:37:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 19:37:38 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Abhishek Kumar <kuabhs@google.com>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <CA+ASDXNAXo=p=_MbNXG+Mma37v5b6gAPySsXpNh6CC+L_gLnXQ@mail.gmail.com>
References: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org>
 <6649b0c2ff988c2ae8723ea633f86cc12da43d95.camel@sipsolutions.net>
 <d424aa0e80ac55e511ddb33b41d40fea@codeaurora.org>
 <CA+ASDXNAXo=p=_MbNXG+Mma37v5b6gAPySsXpNh6CC+L_gLnXQ@mail.gmail.com>
Message-ID: <2cd38a14d4ffaebc4d0b422c55397d87@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-05 01:48, Brian Norris wrote:
> On Wed, Nov 4, 2020 at 12:44 AM Carl Huang <cjhuang@codeaurora.org> 
> wrote:
>> On 2020-09-28 20:36, Johannes Berg wrote:
>> > On Tue, 2020-09-22 at 13:49 +0800, Carl Huang wrote:
>> >> +struct cfg80211_sar_freq_ranges {
>> >> +    u8 index;
>> >
>> > Does an index here make sense?
>> >
>> With agreement from Google, it's OK to remove it.
> 
> I'm not sure "Google" is the arbiter of the nl80211 API, even if we
> are the current planned users ;)
> 
> But I think I agree with Johannes, that given the other plans (user
> space must send all bands all the time; dropping the "apply to all
> bands" support), an index isn't really necessary in either the user
> space API or the internal representation handed down to drivers. All
> bands should be specified, in order.
> 
> Brian
> 
The index here will be removed.

But let's keep the explicit index in SET command. I think it adds no
burden to userspace but has flexibility to skip some ranges as we
remove "all or nothing" limitation.


>> >> +    u32 start_freq;
>> >> +    u32 end_freq;
>> >> +};

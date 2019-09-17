Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BE9B487D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 09:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404497AbfIQHq5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 03:46:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404464AbfIQHq5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 03:46:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 15E4B613A3; Tue, 17 Sep 2019 07:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568706416;
        bh=gLn4NneBJAu9e5W1/vUzxFwY7aC3qdPHZlOqgYyEcZc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DZLQb8YK1mhWF0ctf/8opz81QQXtx7I16nV3NCYGXajkqmnfJbJd4+OuOxwsZKe/m
         xWSH6dsIr9Hr4aVzBFbMv+dY/MUkeyKV12usWkdsAG4b/OmKqMqMyaiF1rTgYxB273
         v3nVy/82vcOB+1qiBuP3Leff5AUcq1byXdt+7xnM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 732BD602DB;
        Tue, 17 Sep 2019 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568706415;
        bh=gLn4NneBJAu9e5W1/vUzxFwY7aC3qdPHZlOqgYyEcZc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QVgSfNIF5iC/CN6UvxZNTFv4Fh28iRgNTUrEs1c3Xxu24MwJD6LNCgi3ZzqO44Ny6
         Pat3/TXqI3tjvPyDgY0OObWgoxAMl6jj3Izs097C+9uJBdEDOz8PSx5L43b9hD2VTj
         Vvb0lJ3pdbDtCVw1UnShx6TQRtkoRPURrzqWFyUU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 732BD602DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     James Prestwood <prestwoj@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC 0/4] Allow live MAC address change
References: <20190904191155.28056-1-prestwoj@gmail.com>
        <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
        <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
        <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
        <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
        <87a7b8lciz.fsf@tynnyri.adurom.net>
        <844f1a1dc72ec73df5a86864b410bbc490c4abdd.camel@gmail.com>
Date:   Tue, 17 Sep 2019 10:46:52 +0300
In-Reply-To: <844f1a1dc72ec73df5a86864b410bbc490c4abdd.camel@gmail.com> (James
        Prestwood's message of "Fri, 13 Sep 2019 09:17:37 -0700")
Message-ID: <87imprbc0j.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

James Prestwood <prestwoj@gmail.com> writes:

> On Fri, 2019-09-13 at 13:24 +0300, Kalle Valo wrote:
>> James Prestwood <prestwoj@gmail.com> writes:
>> 
>> > I know 3ms doesn't seems like a lot but everything counts and from
>> > my
>> > testing this is even a further 20% improvement to doing so with
>> > RTNL.
>> > Plus the added simplicity to the userspace code/API. We have taken
>> > a
>> > lot of time to optimize IWD's connection times, and everything
>> > counts.
>> > The connection times are fast already, but when there is room for
>> > improvement we will push for it, especially in situations like this
>> > when the change is quite minimal and does not introduce much
>> > complexity.
>> 
>> So what kind of _total_ connection times you get now?
>> 
>
> This really depends. Most of the optimizations I was referencing are
> due to scanning optimizations and moving DHCP into IWD itself, but both
> of these are kinda irrelevant in this case so I wont consider them.

For user experience scanning and DHCP are also important, what kind of
numbers you get when those are included? No need to have anything
precise, I would like just to get an understanding where we are
nowadays.

> With this change, looking at the time from CMD_CONNECT until EAPoL/key
> setting has finished I calculated 111.4ms on average. This is about a
> 3.5x speed up from the current method (Power down + RTNL) which I
> calculated to be 391.8ms average. Note, this is rough (averaged only 5
> runs just now).

Ok, thanks.

> So the savings are still significant even if you look at the full
> connection times. The difference between doing the MAC change with RTNL
> vs CMD_CONNECT are not as drastic, but from my perspective I would say
> what's the harm? Your gaining further speed ups with really no added
> complexity.

As you only provided one number it's clear that you are only working
with one driver. But for us it's not that simple, we have to support a
myriad of different types of hardware and there can be complications and
additions later on, even for simple features. Like the dynamic power
save support I submitted to mac80211 over 10 years which was supposed to
be simple, and still we talk almost every year how do we get it out of
mac80211 as it makes maintenance difficult.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

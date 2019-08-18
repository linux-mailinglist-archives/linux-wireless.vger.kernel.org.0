Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61249173E
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 16:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfHROGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 10:06:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfHROGN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 10:06:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E9685624B6; Sun, 18 Aug 2019 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566137171;
        bh=3iB5FJ0CuJIPFWd2++bXxfiZj0JORK12CVvbIvi1z0w=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IeHqfvxuDWNwsP40NJpXgVVDLMQVa2J3MKLGBNTZ1/q05IulKbBzxWFDRHpuugXsp
         7xcj1rcnQJJVE0zHPjuPvbKljbboMOkOtlJo4c5aiDfBT06pQ1m4Qp39MjPj9fvBxc
         scKCel/SkB1s9dEtYpIQ1jCV8pd3zs8+812UTL5M=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A987E623A9;
        Sun, 18 Aug 2019 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566137169;
        bh=3iB5FJ0CuJIPFWd2++bXxfiZj0JORK12CVvbIvi1z0w=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=f0HFCpmWjQVFgQWQzRJZHqurlPOEq1tZkqXJp1LDBNOD7pKuf9GxiSw+T9eWSQycz
         3+GkOCmlL+MMXng/5OUvT8BP/qEOjTY+aHOD6D3cxONDNIXN0Qio5Uw7DdjjU6IG/w
         0S2C0f7CK9s4Va8Bi2VpcWM87C1S37FNnsD1N8to=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A987E623A9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>,
        "open list\:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>
Subject: Re: wifi on Motorola Droid 4 in 5.3-rc2
References: <20190818104629.GA27360@amd>
        <CAOf5uwnUx3mtGGHFGqKB30qcb_AMhMEhHLp2pf-4pUdhi7KP7w@mail.gmail.com>
        <20190818114332.GA32205@amd>
Date:   Sun, 18 Aug 2019 17:06:05 +0300
In-Reply-To: <20190818114332.GA32205@amd> (Pavel Machek's message of "Sun, 18
        Aug 2019 13:43:32 +0200")
Message-ID: <87h86elgaa.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> On Sun 2019-08-18 12:53:01, Michael Nazzareno Trimarchi wrote:
>> Hi
>> 
>> On Sun, Aug 18, 2019 at 12:46 PM Pavel Machek <pavel@ucw.cz> wrote:
>> >
>> > Hi!
>> >
>> > First, I guess I should mention that this is first time I'm attempting
>> > to get wifi going on D4.
>> >
>> > I'm getting this:
>> >
>> > user@devuan:~/g/ofono$ sudo ifconfig wlan0 down
>> > user@devuan:~/g/ofono$ sudo ifconfig wlan0 up
>> > user@devuan:~/g/ofono$ sudo iwlist wlan0 scan
>> > wlan0     Interface doesn't support scanning.
>> >
>> 
>> Try to use iw command. iwlist use an obsolete interface that you need
>> to activate in kernel for back compatibility with old command. Can be
>> your problem?
>
> Let me see ... CONFIG_CFG80211_WEXT was not set.
>
> Tried enabling it, and now I got. I remember getting it before,
> too... let me try few more boots, perhaps it is random.

From developers' point of view WEXT is ancient and untested, everybody
should switch to nl80211. So I strongly using iw (which uses nl80211).
Of course this nothing to do with the wlcore warning you saw, just
wanted to make you aware the state of wireless extensions.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

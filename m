Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D406803E3
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2019 03:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390178AbfHCBzQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Aug 2019 21:55:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54856 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbfHCBzQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Aug 2019 21:55:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 46F0C60237; Sat,  3 Aug 2019 01:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564797315;
        bh=LZ1ta87Qax2VkqikccB74yTpa7ZyloFDO1ei/2bubGw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BXUIyNQSnkLOmhq2CF2udSHlGFcMNsYUBFC0HMD6YxzZbROVzlEL17qejQnJa2QZE
         cx0ZxHFhmpcvx81Z6cH2IkteDmHPuo7y74h+PBniVraKrrid2grMty+Q5/oSXAcYNV
         TfAQWrXhIliglBg7sRJzJ7cl8dSM+uavCZRXPs3E=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5D7E60237;
        Sat,  3 Aug 2019 01:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564797314;
        bh=LZ1ta87Qax2VkqikccB74yTpa7ZyloFDO1ei/2bubGw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ucwu/vBdeyEyLr7N8E4e14EfrC5/e2Lk48nl81YJQJlSa6QXcY1gX0nQWKzpeIh7Z
         9lxSGtXLIPKzIl+6FWQeZhMROkzJ+1VAAnxQSp27itg80PoV/PuM6zu0pGQDwEtkXB
         T1OBk+Bdg7QfxwJ6OQd8UUc1To1CqsuFfTv1I478=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5D7E60237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [RFC PATCH] Revert "mwifiex: fix system hang problem after resume"
References: <20170331202136.100342-1-briannorris@chromium.org>
        <20190803010641.GA22848@google.com>
Date:   Sat, 03 Aug 2019 04:55:08 +0300
In-Reply-To: <20190803010641.GA22848@google.com> (Brian Norris's message of
        "Fri, 2 Aug 2019 18:06:42 -0700")
Message-ID: <875znfhv2b.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> + Doug, Matthias, who are seeing problems (or, failure to try to
> recover, as predicted below)
> + Amit's new email
> + new maintainers
>
> Perhaps it's my fault for marking this RFC. But I changed the status
> back to "New" in Patchwork, in case that helps:

But I still see it marked as RFC. So the patch in question is:

https://patchwork.kernel.org/patch/9657277/

Changing the patchwork state to RFC means that it's dropped and out of
my radar. Also, if I see "RFC" in the subject I assume that's a patch
which I should not apply by default.

> On Fri, Mar 31, 2017 at 01:21:36PM -0700, Brian Norris wrote:
>> This reverts commit 437322ea2a36d112e20aa7282c869bf924b3a836.
>> 
>> This above-mentioned "fix" does not actually do anything to prevent a
>> race condition. It simply papers over it so that the issue doesn't
>> appear.
>> 
>> If this is a real problem, it should be explained better than the above
>> commit does, and an alternative, non-racy solution should be found.
>> 
>> For further reason to revert this: there's ot reason we can't try
>
> s/ot/no/
>
> ...oops.
>
>> resetting the card when it's *actually* stuck in host-sleep mode. So
>> instead, this is unnecessarily creating scenarios where we can't recover
>> Wifi.
>> 
>> Cc: Amitkumar Karwar <akarwar@marvell.com>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> ---
>> Amit, please take a look. AIUI, your "fix" is wrong, and quite racy. If you
>> still think it's needed, can you please propose an alternative? Or at least
>> explain more why this is needed? Thanks.
>
> FWIW, I got an Acked-by from Amit when he was still at Marvell. And
> another Reviewed-by from Dmitry. This still applies. Should I resend?
> (I'll do that if I don't hear a response within a few days.)

This patch is from 2017 so better to resend, and without RFC markings.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

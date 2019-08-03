Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B67803E9
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2019 04:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392940AbfHCCIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Aug 2019 22:08:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392893AbfHCCIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Aug 2019 22:08:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 446C8601D4; Sat,  3 Aug 2019 02:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564798133;
        bh=8eCdE5CLse5AxBS9/5Vd4hVuuYRfYTGAjFku21C9NXc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JpGJ6BH6+pVnl6ht9Gt/7ZI7SZfd4O8Pi35PUmDoBNXiByzgLioWh90P9vcUkVsCf
         bjCmSQv9WR0yGNT0C9Dh1Vx1gLbsFHUg/DzrgS6gNDygg40F4UzvYmJb0LyvyCThdN
         /ZEY85HXEbRwrOHPPzpAbaqjYgSW5kkKe2k4aDrs=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0ED096037C;
        Sat,  3 Aug 2019 02:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564798132;
        bh=8eCdE5CLse5AxBS9/5Vd4hVuuYRfYTGAjFku21C9NXc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=d9AzQNld1G0C2ZZahJN7h8RjjSG5nq10wxS2hoXDTxngoDfW7Kpe6jG4GxmRLqc2l
         EiLjz0fF1gOSVlwgTAS2yZoe9yaxHXvJNDSyhja4/eX/+8VW4RFMPMMEQSOZdbxChF
         4HMmoZH1NGWM+VrFPVSzTgQMV6ZhX/RpuENaaGRg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0ED096037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [RFC PATCH] Revert "mwifiex: fix system hang problem after resume"
References: <20170331202136.100342-1-briannorris@chromium.org>
        <20190803010641.GA22848@google.com>
        <875znfhv2b.fsf@kamboji.qca.qualcomm.com>
        <CA+ASDXPCxDQAFPcPu5N6aY9mRDRF2FmsSTWAdgvSNDa2uPsRtQ@mail.gmail.com>
Date:   Sat, 03 Aug 2019 05:08:47 +0300
In-Reply-To: <CA+ASDXPCxDQAFPcPu5N6aY9mRDRF2FmsSTWAdgvSNDa2uPsRtQ@mail.gmail.com>
        (Brian Norris's message of "Fri, 2 Aug 2019 19:02:52 -0700")
Message-ID: <871ry3hufk.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

>> Changing the patchwork state to RFC means that it's dropped and out of
>> my radar. Also, if I see "RFC" in the subject I assume that's a patch
>> which I should not apply by default.
>
> Ack. Well, there were some "RFCs" I sent recently that you *did*
> apply, so I didn't really know what happens normally.

True, I have sometimes applied RFC patches in case they look good enough
and I do not want them to get lost (and this is a good example of RFC
patches getting lost). But by default I drop RFC patches after a quick
glance.

>> > On Fri, Mar 31, 2017 at 01:21:36PM -0700, Brian Norris wrote:
> ...
>> > FWIW, I got an Acked-by from Amit when he was still at Marvell. And
>> > another Reviewed-by from Dmitry. This still applies. Should I resend?
>> > (I'll do that if I don't hear a response within a few days.)
>>
>> This patch is from 2017 so better to resend, and without RFC markings.
>
> Yep, will do.

Thanks.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

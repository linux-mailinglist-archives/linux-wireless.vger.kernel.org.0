Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2722C239
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGXJ0o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 05:26:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11540 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgGXJ0o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 05:26:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595582803; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PWUaY6Sm47TrWhhqY/vQGmgr5aMiRKWAq4V+Ie/iH/U=; b=cYEYFIBap/9vmE9uokecZ30EXFvkLbcPmNNu+BHGFRhQTGDgxiLdunfI7oy0y6mE6LkZbxoV
 VvA3Bx/mOqWhaJzqNFALZZlcmizw0BtmeBy8peTUy5/mbnJTg64I+yenOhjV4rva+xueNMxs
 Bs0D6SjDLLzPtJqCMqRZW90KEeg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f1aa93deef925b694672fae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Jul 2020 09:26:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A478C433C9; Fri, 24 Jul 2020 09:26:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7098C433CB;
        Fri, 24 Jul 2020 09:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7098C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Jouni Malinen <j@w1.fi>, Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>,
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
Date:   Fri, 24 Jul 2020 12:26:16 +0300
In-Reply-To: <CA+ASDXOAzPuOn_rMsRj4t56kC-TgoG0p5WhSTPJjB8xTTq5kfg@mail.gmail.com>
        (Brian Norris's message of "Thu, 16 Jul 2020 11:56:39 -0700")
Message-ID: <87y2n9clhj.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Thu, Jul 16, 2020 at 2:35 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>> Brian Norris <briannorris@chromium.org> writes:
>> > Really, I could live with per-vendor APIs. My primary goal is to get
>> > these upstream in some form, so vendors can stop using things like
>> > this as a reason for shipping us non-upstream code, and so we can
>> > reduce the delta between upstream and Chrome OS kernels.
>> >
>> > I also think that, for the cases that warrant it (i.e., the option 2
>> > -- Realtek and Qualcomm cases, so far), it would be good to have a
>> > common API, but that's a somewhat secondary concern for me.
>>
>> So to me it feels like the best solution forward is to go with the
>> vendor API, do you agree? We can, of course, later switch to the common
>> API if we manage to create one which is usable for everyone.
>
> That's fine with me. That's pretty much what I said in my first email:
>
> "Anyway, I don't really object with starting out with a
> Qualcomm-specific and a Realtek-specific vendor command to implement
> nearly the same feature, but I'd prefer if people did engage in some
> healthy discussion about why they can't share an API, with the hopes
> that maybe they can converge someday."
>
> I think we've had some healthy (though very protracted) discussion,
> and I don't think I've seen anyone bring up anything I wasn't already
> aware of that would prevent eventual consolidation. As long as we
> acknowledge those things (item 2 at
> https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api),
> I'm happy.

Good, I was just checking that we all are on the same page.

>> > Also, Kalle had some concerns about stable ABI questions: shouldn't we
>> > bake in some kind of "check for support" feature to these kinds of
>> > APIs [3]? That would help ease transition, if we do start with a
>> > vendor API and move to a common one in the future.
>>
>> Yeah, that sounds like a good idea but I don't think that should block
>> these patches.
>
> OK, well it was your concern first, IIRC :)

I was commenting about the "check for support" feature :) I think it
would be a good idea to have userspace check what vendor interface
features/commands are supported with that driver/hardware/firmware
combo. But how should that be implemented? Should there be a some kind
of generic mechanism used by all drivers or would each driver have their
own method to check the supported features? I think that needs a
separate discussion.

> So what's next? A v2 that only needs a bit of updated description
> about "why a vendor API"?

I'm busy but hopefully Wen (CCed) can submit v2. Wen?

> And Realtek can feel free to submit this [1] shortly?

> [1] Series: rtw88: Add SAR implementation
> https://patchwork.kernel.org/project/linux-wireless/list/?series=238219&state=*

Yeah, please submit that as well.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

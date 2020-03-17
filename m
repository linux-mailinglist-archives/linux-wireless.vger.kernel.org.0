Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9864188B3C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCQQy3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:54:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58511 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726016AbgCQQy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:54:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584464067; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=B75EPtnjuZ88W0sTU7M6zEPNt8KLHghX4zlsyvi8tfc=; b=b2ShH2D0QGaCbVKCxS3+hZUBx1XGwEW3wpActGr6ZqQv3UOPeKWxGEtjGDkIrIFr3r0AYAu5
 mR7fExymIKfBpyF+/5xH7O2uPc+r2uksNKtI1W1643l77A9v1OBfNGfJAs1E9adBm14i5H7X
 KpVPf3omoylhUcsSOowPGqt3hog=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7100c3.7fdd034d31b8-smtp-out-n02;
 Tue, 17 Mar 2020 16:54:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A155C43637; Tue, 17 Mar 2020 16:54:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8C7AC433CB;
        Tue, 17 Mar 2020 16:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8C7AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Jouni Malinen <j@w1.fi>, Pkshih <pkshih@realtek.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>
Subject: Re: [PATCH 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power limits
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
        <1576684108-30177-2-git-send-email-kvalo@codeaurora.org>
        <1576748692.7758.17.camel@realtek.com> <20191219154828.GA12287@w1.fi>
        <CA+ASDXMTYLGbEkBPHSqtyitMEvY5o_MjU0s+NoWdnN_ORy1gDw@mail.gmail.com>
        <20191219185522.GA16010@w1.fi>
        <CA+ASDXNOxkrZTxL0Jo4ONR2YtL83BVc_w-rBXc6ggBLdwUpDZw@mail.gmail.com>
Date:   Tue, 17 Mar 2020 18:54:21 +0200
In-Reply-To: <CA+ASDXNOxkrZTxL0Jo4ONR2YtL83BVc_w-rBXc6ggBLdwUpDZw@mail.gmail.com>
        (Brian Norris's message of "Thu, 19 Dec 2019 15:40:43 -0800")
Message-ID: <871rpqly6a.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

>> > > This was discussed during the 2019 wireless workshop. The conclusion
>> > > from that discussion was that while there is clear need for SAR power
>> > > limits for various devices and multiple vendors/drivers, it did not look
>> > > clear that a single common interface could be defined cleanly taken into
>> > > account the differences in the ways vendors have designed the mechanism
>> > > in driver and firmware implementations. As such, vendor specific
>> > > commands were identified as the approach.
>> >
>> > [citation needed]
>>
>> I'm not aware of any publicly available meeting minutes that covered the
>> details for that discussion. My personal notes indicate that there were
>> at least two vendors indicating existence of vendor specific commands
>> for configuring SAR parameters, a discussion about the parameters used
>> for this being different, and a conclusion that this would be an example
>> kernel interface where a generic nl80211 interface may not be achievable
>> and a vendor specific interface would be more likely. This discussion
>> resulted in the discussion on how to use vendor specific nl80211
>> commands/attributes in upstream drivers and the eventual documentation
>> of that in the location you noted.
>
> Hmm, I actually think I was only around for the pre-discussion, in
> which y'all suggested you might later meet to decide what eventually
> became [1]. So maybe I missed some specific examples that would
> provide the [citation] I requested.
>
> That being said, I have personally fielded out-of-tree SAR
> implementations from 4 different vendors:
>
> (a) Two of them (this ath10k proposal, roughly; and Realtek's) employ
> exactly the same concept: N frequency ranges, each with associated
> power limits.
> (b) Two of them (Intel/variant-of-iwiwifi and Marvell/mwifiex) utilize
> a platform-specific (BIOS or Device Tree) mechanism for enumerating
> power tables, and the nl80211 API simply takes an index N (e.g., 0 or
> 1), so user space can say "switch to mode N"
>
> Unfortunately, for (b), I think there are enough reasons to think they
> won't share an API similar to (a) (for Marvell, their
> platform-specific tables are large undocumented blobs -- I have a
> feeling if we already had a common API for (a), they *could* have
> implemented some translation in a nicer way in their driver, but they
> haven't chosen to do that work and probably won't be convinced to do
> so).
>
> But that still means there's some hope for (a).
>
> Anyway, I am happy that there's a documented policy for vendor APIs
> [1], and I'm happy to see this proposal out here. I just want to see a
> critical eye put to this particular proposal if possible, to see if we
> can improve its flexibility (either now, or in a later version of a
> QCA vendor command, or even in a common nl80211-proper command).
>
> So to put a little different spin on Pkshih's request: is there any
> value in making this particular ath10k proposal a little more generic
> (e.g., more granularity or flexibility in frequency bands, or more
> precision in power limits), such that other vendors might implement
> the same thing? Or would it be better to let each vendor implement
> their similar-looking APIs (i.e., (a); or maybe even (b)) on their
> own, and only later look at sharing?

The downside of accepting SAR vendor commands to upstream is that (in
theory) that should be supported a long time:

  4. The newly proposed API shall be subject to stable API rules.

  https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api

So if sometime in the future we add a generic command the driver would
need to support both vendor and generic commands. So, IF it makes sense
to implement a generic command, I would rather have a generic command
implemented from the beginning and drop the SAR vendor command patches
altogether.

For me either solutions are good enough, I'm not familiar enough with
all the different SAR user space interfaces to make a good decision.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

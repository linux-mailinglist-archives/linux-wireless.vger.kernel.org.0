Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774D12A7CC8
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 12:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgKELRf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 06:17:35 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:22960 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgKELRd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 06:17:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604575051; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=9iIRkAl1Q4rYAK4JLCAxGzg0D2QQGkuhtPD3BMCg7yk=;
 b=Sz7ArKNj1dEPsXSWur3eBbAwEQJQW7bmRQgRYIFZE0/rjFesO06vlokioYZZzmWWo2XKTXKG
 kVIdet09zsgavxBdNJZtPde3V4QvlDXMipxEcd8HAy9aUYv9gqushrNEwfHveUdQSpWjChoX
 eHU9+6KTzaQUclE21T2pzaRsNIs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fa3df4a02c7ef95a667ad2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 11:17:30
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0D8DC433CB; Thu,  5 Nov 2020 11:17:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A502C433C6;
        Thu,  5 Nov 2020 11:17:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 19:17:29 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k@lists.infradead.org, Doug Anderson <dianders@chromium.org>,
        Abhishek Kumar <kuabhs@google.com>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <CA+ASDXNaLvtJyY9_ds9RVL9VTkiYzChsGJS1czhVt-RKitCk5g@mail.gmail.com>
References: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
 <CA+ASDXM7TcF-zfbktbdSu-fDBuGe0LAgFq3Qt2zaq6efbWJ=sA@mail.gmail.com>
 <f3be456c4c748f21836279eb4dc16e5e@codeaurora.org>
 <CA+ASDXNaLvtJyY9_ds9RVL9VTkiYzChsGJS1czhVt-RKitCk5g@mail.gmail.com>
Message-ID: <aeac9d9e65e6f39c4cc41c3e76b35894@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-05 01:44, Brian Norris wrote:
> + ath10k
> 
> [ I realize I replied to the "wrong" RFC v1; I fell trap to Kalle's 
> note:
> 
> "When you submit a new version mark it as "v2". Otherwise people don't
> know what's the latest version." ]
> 
> On Tue, Nov 3, 2020 at 11:32 PM Carl Huang <cjhuang@codeaurora.org> 
> wrote:
>> On 2020-11-04 10:00, Brian Norris wrote:
>> > What are the ABI guarantees around a given driver/chip's 'sar_capa'?
>> > Do we guarantee that if the driver supports N ranges of certain bands,
>> > that it will always continue to support those bands?
> ...
>> For a given chip(at least a QCOM chip), we don't see that the
>> range will grow or change.
> 
> That's good to know. But that's not quite the same as an ABI guarantee.
> 
>> In addition, with current index-power SET method, it's hard for driver
>> to know what the index mean given your example. Does the index mean
>> [5,5 + x] or [5, 5 + x/2] ?  So it's required for user-space to 
>> specify
>> all the ranges.
> 
> Well, we'd have to change the API (which is why I'm asking now) if we
> wanted the kernel to handle this gracefully. We'd have to retain the
> index (which, it sounds like you might be dropping if things go as
> Johannes suggested), so user space can continue to request the old
> range even if the driver also splits up a new range.
> 
> More explicitly, something like this:
> 
> Linux version A:
> ath10k supports:
> 0: 2G band
> 1: 5G band
> 
> Linux version B:
> ath10k supports:
> 0: 2G band
> 1: 5G band
> 2: 1st half of 5G band
> 3: 2nd half of 5G band
> 
> Indexes 2 and 3 would be overlapping with 1 of course, but it does
> mean that the following SET request will work on both A and B:
> 
> SET
> index 0 -> power X
> index 1 -> power Y
> 
> Notably, that also requires nl80211 allow specifying only a subset of
> bands in a SET request.
> 
> But spelling that out, the proposal sounds more complicated than it's
> worth -- it's probably better to let user space handle the complexity.
> So that goes back to making ABI requirements clear, so we don't have
> kernel/user mixups/regressions down the line.
> 
>> The number of ranges is quite small, so the SET itself is not a
>> problem to specify all.
> 
> Sure, but it does mean that if I (user space) don't trust that driver
> support remains constant, I have to do some negotiation. I would
> already do some verification via the get/dump API of course, but
> negotiation is pretty complex if there is unbounded flexibility. It
> would be nice to spell out what sort of negotiation is reasonable as
> part of the ABI. For example, it might be reasonable to say that bands
> should never be combined; only ever added or split.
> 
> BTW, considering the possibility of "added" bands, how about this
> example: if ath10k were to add 6GHz support (and SAR to go with it),
> user space would have to learn to specify limits for it too, due to
> the "all or nothing" limitation? It'd be good to be up front about
> this, similar to the previous paragraph.
> 
Like what I've replied in another email. Let's remove "all or nothing"
limitation. If certain ranges are not SET, then these ranges just don't
have SAR power limitation.

Just FYI, ath10k will never support 6GHz, it's ath11k to support it.


>> Brian, are you fine that we go with this proposal? I'll send
>> V2 based on the comments from Johannes and Abhishek.
> 
> I think I'm fine with it; my main concerns around ambiguities, so
> maybe it just needs more explicit mentions in the docs (commit
> messages and/or comments). I'd be happy to see v2 and go from there.
> 
> Brian

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352BA2A93C8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKFKL3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:11:29 -0500
Received: from z5.mailgun.us ([104.130.96.5]:46404 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKFKL3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:11:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604657488; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RdKj2779UeYDrAsAtSkiFNE54NCPGul6ABdv+9htfJM=;
 b=VNL7UCeunYnGLLGBPXE+yMl7PpgtNaIa8cl569znIWBShOie6xyATAKbjXhn2SJq0oBDgu1p
 iZBED13G20wpcoVo+O6CSeLfgjTEFYrJH2CMdVFVyY+IY6ZvX04exEIfwieAX4HNJ0bI5Nky
 w3qOw1eYO6A8XM0IfCI28WnbPxc=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fa52150991cc324d41151ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 10:11:28
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C7DFC433F0; Fri,  6 Nov 2020 10:11:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E775C433C8;
        Fri,  6 Nov 2020 10:11:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Nov 2020 18:11:27 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        ath10k <ath10k@lists.infradead.org>, ath11k@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Abhishek Kumar <kuabhs@google.com>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <CA+ASDXNESXqeW32Put_hDMF+16+KTqbd++iWk6DNTfsrEd+UbQ@mail.gmail.com>
References: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
 <CA+ASDXM7TcF-zfbktbdSu-fDBuGe0LAgFq3Qt2zaq6efbWJ=sA@mail.gmail.com>
 <f3be456c4c748f21836279eb4dc16e5e@codeaurora.org>
 <CA+ASDXNaLvtJyY9_ds9RVL9VTkiYzChsGJS1czhVt-RKitCk5g@mail.gmail.com>
 <877dr0nqtv.fsf@codeaurora.org>
 <728196c17b4e70e18c99798a9945d1e6@codeaurora.org>
 <CA+ASDXNESXqeW32Put_hDMF+16+KTqbd++iWk6DNTfsrEd+UbQ@mail.gmail.com>
Message-ID: <bad7a78cf3ca4048b275457cc970faa2@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-06 02:25, Brian Norris wrote:
> On Thu, Nov 5, 2020 at 3:10 AM Carl Huang <cjhuang@codeaurora.org> 
> wrote:
>> On 2020-11-05 16:35, Kalle Valo wrote:
>> > Brian Norris <briannorris@chromium.org> writes:
>> >> On Tue, Nov 3, 2020 at 11:32 PM Carl Huang <cjhuang@codeaurora.org>
>> >> wrote:
>> >>> On 2020-11-04 10:00, Brian Norris wrote:
>> >>> > What are the ABI guarantees around a given driver/chip's 'sar_capa'?
>> >>> > Do we guarantee that if the driver supports N ranges of certain bands,
>> >>> > that it will always continue to support those bands?
> 
> To be clear: the answer here is "no." So we have to map out what the
> user/kernel interaction looks like when they change.
> 
>> >> ...
>> >>> For a given chip(at least a QCOM chip), we don't see that the
>> >>> range will grow or change.
>> >>
>> >> That's good to know. But that's not quite the same as an ABI
>> >> guarantee.
>> >
>> > I'm not sure if I understood Brian's question correctly, but I have
>> > concerns on the assumption that frequency ranges never change. For
>> > example, in ath10k we have a patch[1] under discussion which adds more
>> > channels and in ath11k we added 6 GHz band after initial ath11k support
>> > landed. And I would not be surprised if in some boards/platforms a
>> > certain band is disabled due to cotting costs (no antenna etc).
> 
> Right, I certainly was not taking the "never change bands" claim from
> Carl at face value ;) This is exactly why I was asking.
> 
>> > My
>> > preference is to have a robust interface which would be designed to
>> > handle these kind of changes.
> 
> Sure.
> 
>> > [1] [PATCH] ath10k: enable advertising support for channels 32, 68 and
>> > 98
>> 
>> So the trick here is even if more channels are supported, it doesn't
>> mean
>> that it can support different SAR setting on these new channels. In 
>> this
>> case,
>> it likely falls into 5G range. It's safe for driver to extend the 5G
>> range and
>> doesn't break userspace. (68 and 98 are already in the 5G range, so
>> driver just
>> extends the start edge freq to 32 here.).
> 
> You can't just wave your hands and say it "doesn't break userspace" --
> you have to think about how user space can use this API.
> 
> Specifically, consider that user space is not going to memorize
> indeces, as those are per-driver implementation details; it's going to
> memorize frequency bands. It wants to cross reference those with the
> results of the GET/DUMP API before it translates those into indeces
> for SET. As you're describing it, user space will have to have some
> kind of "fuzziness" to its logic -- today, it thinks the 5G band is
> [X,Y], but tomorrow it might expand to [X-N, Y+M]. So user space
> should just ensure that it configures any band that intersects with
> [X,Y], even though it didn't know about [X-N,X] or [Y,Y+M]? That logic
> covers splits too, I suppose.
> 
> There's still the question of ranges that user space has no knowledge
> of (i.e., no intersection with any known [X,Y]). I think there's two
> approaches that are roughly equivalent:
> 1) require SET operations to specify all bands, and designate a NULL
> or MAX value that user space should use for unknown/unconfigured bands
> [or, user space uses some kind of "extension" from the nearest known
> band, just to be safe?]
> 2) allow SET operations to specify a subset of supported bands [gray
> area: what happens with the unconfigured band(s)? left as-is? use
> max?]
> 
> We're approximately in #1 right now. If we're explicit about how
> that's supposed to work, then I think we can stay with that. Although
> it sounds like Carl is moving toward #2 (allow subsets).
> 
>> But for flexibility, given 6 GHz as example here, let's keep the
>> explicit
>> index for SET command. For sar_capa advertisement, the explicit index 
>> is
>> dropped as Johannes suggested. New ranges can only be appended to
>> existing
>> ones. Like Brian said, only add or split is allowed.
> 
>> The complexity to
>> handle
>> splitted range Vs whole range is left to WLAN driver itself.
> 
> Hmm? I thought we're keeping the driver simple. I'm OK with that (and
> moving a little more complexity into user space) as long as we're
> clear about it.
> 

I've sent  [PATCH 0/3] add common API to configure SAR, please let's 
start
from there again.


> Brian
> 
>> Userspace can SET any ranges which are advertised by WLAN driver. It's
>> not required to set all ranges and userspace can skip any ranges.
> 
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k

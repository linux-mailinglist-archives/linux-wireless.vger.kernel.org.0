Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD07271E98
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 11:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIUJLK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 05:11:10 -0400
Received: from z5.mailgun.us ([104.130.96.5]:59542 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIUJLK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 05:11:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600679469; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=//hbm6pXB8ppholziZ3my2YVN9rdmC3SBW3QFD7VL9o=; b=Lm2KZXrHuUDqTs3ipvCprEun05yAeCDp6SzovDD8i3HgGnhoRaKhS6J/Nl4anFrdKSW1aTtf
 VJjQmGelng/tD2m5s4rmJfV+/xWvaLoi+okV77Ph6FQxPdmqhJ6mvd4QAw0RmyDJDY0cUB5N
 SMsN0sDpTvJ5LdSbgfchtOxLYMA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f686e152131f7663a2183ce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 09:10:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F66CC433F1; Mon, 21 Sep 2020 09:10:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BFCEAC433C8;
        Mon, 21 Sep 2020 09:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFCEAC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC] mac80211: Add radiotap channel flag option for 6GHz band
References: <010101747ee4b985-86863ec8-33e2-4f78-9d9b-93110bfa29fc-000000@us-west-2.amazonses.com>
        <5225561f9f5c104bc84ab6e7f183de0ab5e0ea6d.camel@sipsolutions.net>
        <010101747eea64fa-83d17384-b161-40d6-8b9d-9dd3bbbe89b4-000000@us-west-2.amazonses.com>
        <87zh5v1pv4.fsf@tynnyri.adurom.net>
        <0d0174377e9aa0e7be118a8dca6826eb@codeaurora.org>
Date:   Mon, 21 Sep 2020 12:10:41 +0300
In-Reply-To: <0d0174377e9aa0e7be118a8dca6826eb@codeaurora.org> (Aloka Dixit's
        message of "Sun, 20 Sep 2020 11:59:26 -0700")
Message-ID: <87a6xjbilq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> writes:

> On 2020-09-11 23:16, Kalle Valo wrote:
>> Aloka Dixit <alokad@codeaurora.org> writes:
>>
>>> On 2020-09-11 13:39, Johannes Berg wrote:
>>>> On Fri, 2020-09-11 at 20:39 +0000, Aloka Dixit wrote:
>>>>> Radiotap header needs a new channel flag for 6GHz packets.
>>>>> This change uses value 0x200 for new enum balue for 6GHz which was
>>>>> previously used for passsive scan flag but has since been removed.
>>>>
>>>> You can't just add to radiotap in a kernel patch ...
>>>>
>>>> But also, just today I replied elsewhere saying that we don't really
>>>> need a flag at all?
>>>>
>>>> johannes
>>>
>>> Somehow your reply to other patch didn't show up on the patchwork,
>>> don't know why :-)
>>
>> Oh, this is making me worry. I do see Johannes' reply on the list:
>>
>> https://lore.kernel.org/linux-wireless/1cc7242cd00cd5141a56f17a7f5c80700485aa39.camel@sipsolutions.net/
>>
>> But like you said, there's still nothing on the patchwork (even
>> after 23h):
>>
>> https://patchwork.kernel.org/patch/11769643/
>>
>> I hope this is just a temporary glitch, but if this happens again
>> please
>> do let me know about any patchwork problems. It will create major
>> problems for us if patchwork starts losing mail.
>
> This is still happening, even your reply did not show up on the RFC
> patch here:
> https://patchwork.kernel.org/patch/11771491/

Aloka's original email (with the patch) had the id:

Message-ID: <010101747ee4b989-1d670a2f-a032-4f64-aa65-3847a5951522-000000@us-west-2.amazonses.com>

But Johannes' reply referenced different id:

In-Reply-To: <010101747ee4b985-86863ec8-33e2-4f78-9d9b-93110bfa29fc-000000@us-west-2.amazonses.com>
References: <010101747ee4b985-86863ec8-33e2-4f78-9d9b-93110bfa29fc-000000@us-west-2.amazonses.com>

And this is why patchwork cannot detect that the replies are to Aloka's
patch. I suspect smtp.codeaurora.org is to blame here, I have seen it
messing with message ids before so this would not be the first time this
is happening.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

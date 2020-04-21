Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69E1B217E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 10:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgDUIXS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 04:23:18 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:43055 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUIXS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 04:23:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587457397; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=OF+rxZSRUEHhj7rS5YXyxI45XZMvxFO6Y/YycOj44vs=; b=QkdCAAtCr2qFemXH+BOcqj1paKxpkTXQGHeFkVTyncuIW/bvBRrSn4lfzub8IpIYpoVXTwez
 MXdG3A8Mhr/kdwu5D5rziEOoM6iApFkELSGM6RZ1es7SRVZc+RQ6kb1Gs2TnYYcFDi4Z7bPa
 k4GQspb6ZkCBC6WN4ehtKodC3YU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9ead75.7f17d3046880-smtp-out-n03;
 Tue, 21 Apr 2020 08:23:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0CD02C433D2; Tue, 21 Apr 2020 08:23:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A343C433CB;
        Tue, 21 Apr 2020 08:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A343C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Tony Chuang <yhchuang@realtek.com>, Pkshih <pkshih@realtek.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris\@chromium.org" <briannorris@chromium.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: Re: [PATCH 00/40] rtw88: add support for 802.11n RTL8723DE devices
References: <20200417074653.15591-1-yhchuang@realtek.com>
        <87lfmuplrm.fsf@kamboji.qca.qualcomm.com>
        <87zhbajz6f.fsf@tynnyri.adurom.net>
        <63bfd72cb01041ae8b6f049d49bda880@realtek.com>
        <f90ca68c-c744-836a-dcd9-d7ec4938a513@datenfreihafen.org>
Date:   Tue, 21 Apr 2020 11:23:12 +0300
In-Reply-To: <f90ca68c-c744-836a-dcd9-d7ec4938a513@datenfreihafen.org> (Stefan
        Schmidt's message of "Fri, 17 Apr 2020 16:47:17 +0200")
Message-ID: <87h7xdp7rj.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stefan Schmidt <stefan@datenfreihafen.org> writes:

> Hello Yen-Hsuan
>
> On 17.04.20 11:03, Tony Chuang wrote:
>> Kalle Valo <kvalo@codeaurora.org> writes:
>>>
>>>> <yhchuang@realtek.com> writes:
>>>>
>>>>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>>>>
>>>>> Although RTL8723DE devices are 802.11n devices, while rtw88
>>>>> aimed to support for 802.11ac devices, the 8723DE devices's
>>>>> architecture is relatively close to the 802.11ac devices.
>>>>> So, add support for them on rtw88, with some minor modifications.
>>>>
>>>> There's no way I'm going to review 40 patches in one go :) So I'll just
>>>> to look at around 10 first patches and drop the rest.
>>>>
>>>> If you want your patches reviewed smoothly submit only around 7-12
>>>> patches per patchset. If the patches are bigger don't send more than 7
>>>> patches. But if they smaller, or trivial patches, 12 patches is ok. But
>>>> anything more than 12 patches and I'm sure you will get reviewers
>>>> grumpy.
>>>>
>>>> But you can submit multiple patchsets, just try to throttle it down to
>>>> avoid bufferbloat in patchwork, ie. send a new patchset every other day
>>>> and document the dependencies in the cover letter ("this patchset
>>>> depends on patchset B").
>>>
>>> I added this also to the wiki:
>>>
>>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa
>>> tches#maximum_of_7-12_patches_per_patchset
>>>
>>
>> Actually I can send the 8723DE within 5 patches, but I thought that split
>> them will be easier to review :) If too many patches is a problem, then I
>> can squash them back together, because most of them are hardware
>> settings. I can resend a v2.
>
> Squashing them together to stay below the patch limit would not really
> help reviewers. Its the same amount of code, just in bigger patches.
>
> Most reviewers are way more happy with smaller patches doing one thing
> only (atomic). I would assume that Kalle would prefer to keep the
> patches split up as you already did. Just arrange them in a few sets
> coming in after another. Its really about throttling the amount of
> code coming in that needs review to be manageable for reviewers.

Exactly, thanks Stefan for explaining it so clearly.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

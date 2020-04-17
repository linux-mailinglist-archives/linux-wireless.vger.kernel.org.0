Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6D1AE03F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgDQOxW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDQOxV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 10:53:21 -0400
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Apr 2020 07:53:21 PDT
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF2AC061A0C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2020 07:53:21 -0700 (PDT)
Received: from localhost.localdomain (p200300E9D707C225C4CEFC8DEC753B3C.dip0.t-ipconnect.de [IPv6:2003:e9:d707:c225:c4ce:fc8d:ec75:3b3c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 4B0E3C3243;
        Fri, 17 Apr 2020 16:47:19 +0200 (CEST)
Subject: Re: [PATCH 00/40] rtw88: add support for 802.11n RTL8723DE devices
To:     Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Kevin Yang <kevin_yang@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <87lfmuplrm.fsf@kamboji.qca.qualcomm.com> <87zhbajz6f.fsf@tynnyri.adurom.net>
 <63bfd72cb01041ae8b6f049d49bda880@realtek.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <f90ca68c-c744-836a-dcd9-d7ec4938a513@datenfreihafen.org>
Date:   Fri, 17 Apr 2020 16:47:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <63bfd72cb01041ae8b6f049d49bda880@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Yen-Hsuan

On 17.04.20 11:03, Tony Chuang wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
>>
>>> <yhchuang@realtek.com> writes:
>>>
>>>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>>>
>>>> Although RTL8723DE devices are 802.11n devices, while rtw88
>>>> aimed to support for 802.11ac devices, the 8723DE devices's
>>>> architecture is relatively close to the 802.11ac devices.
>>>> So, add support for them on rtw88, with some minor modifications.
>>>
>>> There's no way I'm going to review 40 patches in one go :) So I'll just
>>> to look at around 10 first patches and drop the rest.
>>>
>>> If you want your patches reviewed smoothly submit only around 7-12
>>> patches per patchset. If the patches are bigger don't send more than 7
>>> patches. But if they smaller, or trivial patches, 12 patches is ok. But
>>> anything more than 12 patches and I'm sure you will get reviewers
>>> grumpy.
>>>
>>> But you can submit multiple patchsets, just try to throttle it down to
>>> avoid bufferbloat in patchwork, ie. send a new patchset every other day
>>> and document the dependencies in the cover letter ("this patchset
>>> depends on patchset B").
>>
>> I added this also to the wiki:
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa
>> tches#maximum_of_7-12_patches_per_patchset
>>
> 
> Actually I can send the 8723DE within 5 patches, but I thought that split
> them will be easier to review :) If too many patches is a problem, then I
> can squash them back together, because most of them are hardware
> settings. I can resend a v2.

Squashing them together to stay below the patch limit would not really 
help reviewers. Its the same amount of code, just in bigger patches.

Most reviewers are way more happy with smaller patches doing one thing 
only (atomic). I would assume that Kalle would prefer to keep the 
patches split up as you already did. Just arrange them in a few sets 
coming in after another. Its really about throttling the amount of code 
coming in that needs review to be manageable for reviewers.

regards
Stefan Schmidt

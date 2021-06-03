Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D9839A466
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhFCPWO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 11:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhFCPWN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 11:22:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16701C06174A;
        Thu,  3 Jun 2021 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=N2VWo8wKw7dopgHVxyfYdau0jmOFUHRM6wN4YMv4xKI=; b=dxttJ+W0F2wEGpLOdBnsncftqU
        378QRkd3zGU6qPRq7ZEn2zXSaGuaWTjr4Iu3BB4VB84Tc0JbhACJWicFbHmjNs9GIEoirpQqCr+0H
        lFdV0pNI8XXltxYdJQGvTYiQCDW7DEW7INM4EEmUwb0vGTcYN6nrj5quXvvdPPx0EidwbJfYsmcyd
        EkIP04P5/QCR7hYcuYL+rNmQkTxNKhKCvZ5z85iOhR50g6rIa53wBMifcAIFYjHKGNTqn1tymNTOe
        +phsZB0dztLLgDh+cwCy9pCViMl617E1ipJ8/fzhSkaZQmGVIpnkEDg7DOmxKdedtuR2aNZUvbBPM
        oYuU6Bkw==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lop91-009LaP-BE; Thu, 03 Jun 2021 15:20:27 +0000
Subject: Re: [PATCH v3] wireless: carl9170: fix LEDS build errors & warnings
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20210530031134.23274-1-rdunlap@infradead.org>
 <8043ff50-d592-7666-f001-7505efa0d4c2@gmail.com>
 <c49c07d5-1d6e-5b99-30b4-bc8f48b0fde3@infradead.org>
 <87czt31dt3.fsf@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e5a50e0-7e42-9fd3-f927-d3b695a21912@infradead.org>
Date:   Thu, 3 Jun 2021 08:20:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87czt31dt3.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/3/21 2:46 AM, Kalle Valo wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> On 5/30/21 2:31 AM, Christian Lamparter wrote:
>>> On 30/05/2021 05:11, Randy Dunlap wrote:
>>>> kernel test robot reports over 200 build errors and warnings
>>>> that are due to this Kconfig problem when CARL9170=m,
>>>> MAC80211=y, and LEDS_CLASS=m.
>>>>
>>>> WARNING: unmet direct dependencies detected for MAC80211_LEDS
>>>>    Depends on [n]: NET [=y] && WIRELESS [=y] && MAC80211 [=y] &&
>>>> (LEDS_CLASS [=m]=y || LEDS_CLASS [=m]=MAC80211 [=y])
>>>>    Selected by [m]:
>>>>    - CARL9170_LEDS [=y] && NETDEVICES [=y] && WLAN [=y] &&
>>>> WLAN_VENDOR_ATH [=y] && CARL9170 [=m]
>>>>
>>>> CARL9170_LEDS selects MAC80211_LEDS even though its kconfig
>>>> dependencies are not met. This happens because 'select' does not follow
>>>> any Kconfig dependency chains.
>>>>
>>>> Fix this by making CARL9170_LEDS depend on MAC80211_LEDS, where
>>>> the latter supplies any needed dependencies on LEDS_CLASS.
>>>
>>> Ok, this is not what I was expecting... I though you would just
>>> add a "depends on / imply MAC80211_LEDS" on your v2. (this was
>>> based on the assumption of what mac80211,  ath9k/_htc and mt76
>>> solutions of the same problem looked like).
>>
>> Do you want the user choice/prompt removed, like MT76 is?
>>
>>> But since (I assuming here) this patch passed the build-bots
>>> testing with flying colors in the different config permutations.
>>
>> It hasn't passed any build-bots testing that I know of.
>> I did 8 combinations of kconfigs (well, 2 of them were invalid),
>> but they all passed my own build testing.
> 
> So is this ok to take now? Or will there be v4?

It's all good AFAIK unless Christian wants something changed.

Christian?

-- 
~Randy


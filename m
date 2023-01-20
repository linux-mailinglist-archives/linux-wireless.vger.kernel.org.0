Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11F76759A5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 17:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjATQPs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 11:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjATQPo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 11:15:44 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B2779EB9
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 08:15:36 -0800 (PST)
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MmkjY-1ossYL0wNi-00jpAB; Fri, 20 Jan 2023 17:10:07 +0100
Message-ID: <17d8494a-ebae-e317-6096-c8621d0f33e3@green-communications.fr>
Date:   Fri, 20 Jan 2023 17:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20221226083328.29051-1-quic_ramess@quicinc.com>
 <20221226083328.29051-2-quic_ramess@quicinc.com>
 <74c57dc34af10537f98f5bb9b6ce80e5676e09b0.camel@sipsolutions.net>
 <1609a645-3e23-7e37-9aa1-94f970e481e2@green-communications.fr>
 <Y8q5Z98S3pODD77W@lore-desk>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: Re: [PATCH 1/2] nl80211: add support to enable/disable bss color
 collision detection
In-Reply-To: <Y8q5Z98S3pODD77W@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ObD765wio49tePRoLNkQoY65FCwoq76N2r4NslnAaTOOEu7KI1U
 WFvZ/6CpT4VOxURHjfWLzWNsbf5Jf6J76c08W5SXmIAl/7pn1Q9UFARbl4UZ/S68/mJIKUi
 uuIdpwhASY6iNHxNG1OZSzwTkUjm3jS++y0201Nfbd6jWQdHs/s3yK48uBqNTzkyReIPomq
 1h1wxZz7CsovK3JoYLUZw==
UI-OutboundReport: notjunk:1;M01:P0:dCs7UqmLsZw=;P4BjHl9s1MP/NlmSePXUU0Fztwz
 ELOrT1JDcWJDXOr6VnqDvR3MwnklLlC12izCo7TONXwS/Yf4GiIHP9vTu7gwxMjAUJBbd6qbP
 Lm4D1ZEsXr/fL0/RwP2EuLmemV3Bb9KMquFWCgmvS4j+yef/ZGcM9f63gF7/NTOFND4DznzTP
 102sQGBOmgGCaGyW/U/hO8zDv2b2uSCXh3TCIHuhRqjh2VXYrR/D9ta5hqAjEPLplpChwTqmJ
 t1/9hiEs9eiMhsotwHpmuvXChAkLGbcjhBz61qmOdzPcXUHSfpqKWKYjYbsM1AAef4g6MAVEs
 PlvYsX9BK9aDyyAQ7SYqVclwYedJVeLeBiWUIcmI9FnOhOAOXCkbaUl4qmqu5448tsrudzcT1
 73IoXIihMYxB+U3S1CjpqlYCBbgIuMxagjV9nc8oWfoY6WlMGfOJ8HnKT7FWw90Th8aaHREBY
 X0ZxZoNpkNY76x9SX5Nzy3tRSXpClYzWmrkslw5lK7i8FaMAkfrnFYMPOll1aHE96yBv5BTFr
 nUUf/kAJn5pu93BTzOE3yMJ/A1t0FQhIGyk6m72qpRXRLzXTlFQPEJeviyH82MC8CUtkp3NJe
 p1b7wN9CAAkYAh3Q1AJAUZahkRpRho9UeAnNlVM09zrv7A+KpgXI1UgFqSvNSOGP3prBkNWjk
 sNsFEVNKvN45L8cPdOxEQHzAfEEbGuTgc9Gd0qW03Q==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20/01/2023 16:55, Lorenzo Bianconi wrote:
>> On 19/01/2023 15:02, Johannes Berg wrote:
>>> On Mon, 2022-12-26 at 14:03 +0530, Rameshkumar Sundaram wrote:
>>>> As per 802.11ax-2021, STAs shall process BSS Color Change Announcement
>>>> (BCCA) from AP and switch to new color, but some STAs aren't processing
>>>> BCCA from AP and not doing color switch, causing them to drop data
>>>> frames from AP post color change.
>>>>
>>>> Provide an option to disable color collision detection and therefore
>>>> not to do BCCA to mitigate the same from AP. If it's required in case
>>>> where STA supports BCCA handling, then it can enabled in AP using this
>>>> option.
>>>>
>>>
>>> You should probably split this into cfg80211 and mac80211.
>>>
>>> Also, this doesn't really seem to make a lot of _sense_ since nothing in
>>> the kernel actually acts on detection of a color collision - hostapd is
>>> acting on that.
>>>
>>> So since you can easily make hostapd ignore the event, why do you even
>>> need this?
>>
>> This may not be related, but the software color collision detection sends a
>> netlink message for every colliding frame and it can hose up the system if
>> the other network is very active.
>>
>> Also, cfg80211_bss_color_notify() complains that the wdev lock isn't held.
> 
> Hi Nicolas,
> 
> I agree, I think we can ratelimit netlink messages sent by the kernel to
> userspace (e.g. to hostapd), I would say every 500ms is ok.
> I guess we can move cfg80211_obss_color_collision_notify() in a dedicated
> delayed_work so we can grab wdev mutex (cfg80211_obss_color_collision_notify is
> currently running in interrupt context).
> To give an idea, what do you think about patch below? (please note it is just
> compiled tested so far).

I think it should fix the problem, I'll try to test it.

Thanks!

> Regards,
> Lorenzo


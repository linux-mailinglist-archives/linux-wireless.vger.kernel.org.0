Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9119B7A8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 23:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbgDAVcv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 17:32:51 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:44668 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732337AbgDAVcv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 17:32:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 3673B4F7AAB;
        Wed,  1 Apr 2020 21:32:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ux6_uZI3X-Pg; Wed,  1 Apr 2020 21:32:47 +0000 (UTC)
Received: from [10.1.15.6] (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 9332A4F7AA5;
        Wed,  1 Apr 2020 21:32:47 +0000 (UTC)
Subject: Re: [RFC 2/7] cfg80211: express channels with a KHz component
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
 <20200401062150.3324-3-thomas@adapt-ip.com>
 <52850c8eb3131ca742eea30a21a7e685a3a3045b.camel@sipsolutions.net>
 <69451a0a-4bca-36f8-4295-9a386585c244@adapt-ip.com>
 <bbc12ff536862a8ca693c20b8721092979c49a36.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <b8068983-f6c8-8f9c-c131-8e8d0c229aa0@adapt-ip.com>
Date:   Wed, 1 Apr 2020 14:32:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bbc12ff536862a8ca693c20b8721092979c49a36.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/1/20 10:53 AM, Johannes Berg wrote:
> On Wed, 2020-04-01 at 10:30 -0700, Thomas Pedersen wrote:
>>>> +static int __ieee80211_frequency_to_channel(u32 freq)
>>>
>>> export the double-underscore helpers like this one instead? That'd still
>>> be less code overall, IMHO.
>>
>> I didn't want to change the interface for
>> ieee80211_frequency_to_channel(). It's a little confusing that one takes
>> MHz, but the __ieee80211_frequency_to_channel() takes KHz? By giving the
>> _khz() hint in the wrapper we were trying to make it explicit. Similar
>> to below.
> 
> Right. I think that's fine. I was just wondering if / thinking that it
> may be better to just export ieee80211_freq_khz_to_channel(), and
> express the other ones as inline function in terms of that?
> 
>>> And maybe here? In fact, how is __ieee80211_get_channel() even different
>>> from ieee80211_get_channel_khz()?
>>
>> It's not. I thought the _khz() hint was helpful for the reader to keep
>> the units straight.
> 
> Agree, but then you don't need the double-underscore version and can
> just express the old one in terms of the _khz one?
> 
>> What do you think about keeping the interfaces in place, but otherwise
>> converting them to inline functions (where it makes sense)?
> 
> Yes, I think that's what I had in mind.

OK I get it. That is a lot cleaner.

-- 
thomas

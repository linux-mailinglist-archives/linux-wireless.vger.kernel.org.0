Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106731E127B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgEYQRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 12:17:02 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:58998 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgEYQRC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 12:17:02 -0400
Received: from [192.168.254.4] (unknown [50.34.197.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 37AF413C2B0;
        Mon, 25 May 2020 09:17:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 37AF413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1590423421;
        bh=ADtXMjpl/LMlesesHmjJbYHMWwxGeMwT8qqoKlGg4aI=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=GjnweCEPMLqJDlOo5WyFVD5PbZocRUIKYfshBvHlrOfZkJT9/7nTlh5+QfpSUeYNn
         KCtHJakd7I4ORyMblAEiLithSB/WjuIgKzEayWZZF3W4+GsogAnoCn0BMBKTVTkNw9
         5SvUUyHCynXeJAaiUSytGnqdKnN7TsrqUAZyz+eE=
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
To:     Johannes Berg <johannes@sipsolutions.net>,
        Brian Norris <briannorris@chromium.org>
References: <20200313065114.23433-1-yhchuang@realtek.com>
 <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
 <2e492e530d744713871f885e324106ef@realtek.com>
 <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
 <ce990869ebf0478d98cd7e8416b36289@realtek.com>
 <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
 <f4e7401c-c86b-8b2f-9e93-865322f71945@candelatech.com>
 <fbab3328d183406c923b30381389841f@realtek.com>
 <d45e2002e97c28acc1f9c7b9c41b5a3ba1d69452.camel@sipsolutions.net>
 <CA+ASDXM5tSmeE72+fn5K2vgR6kPE3OUbHJ_T_DVV63rFrPzv2w@mail.gmail.com>
 <3894907ca6bf4566b8716731492a869b@realtek.com>
 <CA+ASDXMi8BqccHdVXVXb0JOj4y0vcFBGdL6BB0YuzB78qzgQuQ@mail.gmail.com>
 <efa8c2f3-8254-8d36-20ec-9afb8ffb2339@candelatech.com>
 <CA+ASDXNQxea+83+h87OQwDV-n_Sb8ENyEGx=BsJbMa3G9kkEVQ@mail.gmail.com>
 <6488cbbfbaa0f6591fa7b495e9c8d500603ca5e8.camel@sipsolutions.net>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <bdac6a5b-df73-3b8d-5fd2-3a5038563da4@candelatech.com>
Date:   Mon, 25 May 2020 09:16:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <6488cbbfbaa0f6591fa7b495e9c8d500603ca5e8.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 05/25/2020 02:07 AM, Johannes Berg wrote:
> On Wed, 2020-03-25 at 11:14 -0700, Brian Norris wrote:
>> On Wed, Mar 25, 2020 at 8:52 AM Ben Greear <greearb@candelatech.com> wrote:
>>> On 03/24/2020 10:16 PM, Brian Norris wrote:
>>>> Sure, but if you mask out all but 1 bitrate...voila! A fixed rate!
>>>
>>> So, see this thread from a while back.  Has anyone even *tried* to use
>>> this API you are proposing?
>>
>> Yes, in fact, I have! Which is why I noted:
>>
>>>> Now, there are other problems, like the others that Ben mentioned: the
>>>> rest of the mac80211 framework doesn't like it too much if you really
>>>> disable all but 1 rate (arguably a mac80211 bug -- but not a nl80211
>>>> bug)
>>> http://lists.infradead.org/pipermail/ath10k/2017-October/010291.html
>>
>> I hadn't seen that thread. So it sounds like maybe Johannes isn't
>> quite on the same page as Johannes ;)
>
> Hah. Happens all the time, not sure what that other Johannes is thinking
> ;-)
>
> More seriously though, I'm a bit lost now (and a big part of that is
> probably because I'm replying to a 2 months old thread, sorry).
>
>> If we're going to be particular about matching the AP's basic rates,
>> then this API is indeed probably not useful for the "single fixed rate
>> [for debugging/testing]" use case.
>>
>>>      mac80211: Revert some of e8e4f5, fixes setting single rate in ath10k.
>>
>> Commit e8e4f5 was an unfortunate consequence of the stuff I mentioned
>> earlier about how Chrome OS used to use SET_TX_BITRATE_MAX -- we
>> weren't nuanced about it at all, so we might configure a set of
>> bitrates that doesn't intersect at all with the AP's BasicRates. That
>> does make it hard for the driver/framework to decide what to do: do we
>> listen to the user, or to the AP? Incidentally, that's also one reason
>> why Chrome OS no longer uses the API; it was too big of a hammer for
>> what we want (initial-connection reliability), and required us to be
>> more delicate about {Supported,Basic}Rates than we really wanted to.
>
> Right.
>
> But I'm not sure why Ben needs to just do a pr_err()? Shouldn't that
> just not happen?

Try setting a single rate on ath10k.  It will not work unless you add my
patch.

I put a pr_err in there because you (or whoever pushed the regression upstream)
thought it was a problem to set a single rate, so I wanted to warn the user
but also let the action work.

Thanks,
Ben

>
> Hmm.
>
> johannes
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

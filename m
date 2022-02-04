Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B534A96F3
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 10:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347034AbiBDJia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 04:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiBDJia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 04:38:30 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30AFC061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 01:38:29 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nFv2x-00056S-39; Fri, 04 Feb 2022 10:38:27 +0100
Message-ID: <669031f1-d4d4-2227-7da2-d1b5e43f5358@leemhuis.info>
Date:   Fri, 4 Feb 2022 10:38:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for v5.17 1/2] iwlwifi: remove deprecated broadcast
 filtering feature
Content-Language: en-BS
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Luca Coelho <luca@coelho.fi>, linux-wireless@vger.kernel.org
References: <20220128124851.538580-1-luca@coelho.fi>
 <iwlwifi.20220128144623.9241e049f13e.Ia4f282813ca2ddd24c13427823519113f2bbebf2@changeid>
 <b784b942-6346-7005-b71a-5682cf0452b1@leemhuis.info>
 <87a6fccg6j.fsf@tynnyri.adurom.net>
 <260df94d-8cc4-35eb-775c-d42ba57d6f88@leemhuis.info>
 <8735l0cogj.fsf@kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <8735l0cogj.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643967509;0125d2e5;
X-HE-SMSGID: 1nFv2x-00056S-39
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03.02.22 10:02, Kalle Valo wrote:
> Thorsten Leemhuis <regressions@leemhuis.info> writes:
>> On 31.01.22 12:12, Kalle Valo wrote:
>>> Thorsten Leemhuis <regressions@leemhuis.info> writes:
>>>> On 28.01.22 13:48, Luca Coelho wrote:
>>>>> From: Luca Coelho <luciano.coelho@intel.com>
>>>>>
>>>>> This feature has been deprecated and should not be used anymore.  With
>>>>> newer firmwares, namely *-67.ucode and above, trying to use it causes an
>>>>> assertion failure in the FW, similar to this:
>>>>>
>>>>> [Tue Jan 11 20:05:24 2022] iwlwifi 0000:04:00.0: 0x00001062 | ADVANCED_SYSASSERT
>>>>>
>>>>> In order to prevent this feature from being used, remove it entirely
>>>>> and get rid of the Kconfig option that
>>>>> enables it (IWLWIFI_BCAST_FILTERING).
>>>>>
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215488
>>>>
>>>> FWIW there was another report about it afaics:
>>>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215550
>>>
>>> If it's the same issue, it should be marked as a duplicate.
>>
>> Understandable request, but sorry, for now I decided to not do that in
>> such situations for two reasons:
>>
>>  * it can easily go wrong, as I encounter all sorts of kernel bugs and
>> thus often lack detailed knowledge about the areas the bug is about
>>
>>  * I'm doing regression tacking in my spare time, which is hard enough
>> already; taking care of bugs would make it a lot harder -- especially as
>> some maintainers/subsystems seem to (mostly) ignore bugzilla, so I would
>> be starting to do their job. Hence I only look at bugzilla to make sure
>> no regressions reported there falls through the cracks. See also:
>> https://lore.kernel.org/regressions/3ee8c6c9-52d1-9570-f3bf-490365c9f6fe@leemhuis.info/
> 
> I share your pain, I'm also overwhelmed by mail and patches :) To be
> exact, I didn't mean that you Thorsten should mark the bug duplicate and
> I was hoping that someone from Intel would do it. And Golan thankfully
> did that:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=215550#c1

Ahh, good.

> And I also agree about challenges with Bugzilla. I personally have time
> to only follow ath11k bugzilla reports, everything else I'm forced to
> ignore. This is a big disconnect between users and developers which
> worries me as well.

Maybe I can come up with some numbers over the course of the next few
weeks to improve the situation. Or find somebody that would hire me to
work on improving things in that area...

>>>> That makes me hope that this is reviewed and merged to mainline relative
>>>> quickly, otherwise more users will be bothered by this.
>>>>
>>>>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>>>> Fixes: cbaa6aeedee5 ("iwlwifi: bump FW API to 67 for AX devices")
>>>>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>>>
>>>> Shouldn't this also have:
>>>>
>>>> Cc: stable@vger.kernel.org # 5.16.x
>>>
>>> I can add that.
>>
>> thx.
>>
>>> BTW, please trim your quotes. You left a really long (and unnecessary)
>>> quote, which makes use of patchwork much harder for us maintainers.
>>> Unfortunately patchwork is not able to trim them automatically:
>>
>> Argh, sorry, of course, will do that. I normally trim a lot more, but
>> when I'm in "regression tracker mode" I work differently and quote more,
>> as I often have to poke discussions that got stalled -- and there the
>> context might be helpful. But you are obviously right, for patches and
>> quite a few other situations that's obviously unneeded and harmful.
> 
> Yeah, understandable that quoting more is helpful for regression
> reports. I wish patchwork would have a feature to automatically trim
> unnecessary quotes, that would be really helpful for us maintainers.
> 
> BTW, I also have a feature request for regzbot :) I try to follow
> regression emails very carefully, but I find the emails quite hard to
> read as it's not easy to see what part of text is written by a bot and
> which is from a human.

Right now the bot doesn't write any emails except the weekly reports.
The text is thus coming from me, but I obviously have some templates.

> I get so much email that I try to skim the emails
> quickly and ignore all the boilerplate text, but with regzbot emails
> that's difficult. One way to solve this might be to add all boilerplate
> code between "-----[cut]------" lines or something like that.

Hmmm. I was trying to make this easy already. When I'm adding a report
to the tracking I for example these days put this at the top of my mail:

```
[TLDR: I'm adding this regression to regzbot, the Linux kernel
regression tracking bot; most text you find below is compiled from a few
templates paragraphs some of you might have seen already.]
```

And I sometimes even use top-posting.

Anyway, thx for brining this up, I guess there are still some areas
where I can improve things (which likely means to use top-posting even
more often, which kinda feels wrong, but for some of my mails might be
the better approach).

Ciao, Thorsten

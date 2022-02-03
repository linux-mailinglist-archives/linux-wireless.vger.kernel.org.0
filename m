Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE9B4A80D5
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 10:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348022AbiBCJCo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 04:02:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58294 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiBCJCn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 04:02:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA1A8B83378
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 09:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2DFC340E4;
        Thu,  3 Feb 2022 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643878961;
        bh=kzBER/Tgbpr+0JCksoS6L1WIVDL9M9EAARVDtTGTv0U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kmow2QmWuqH3U88U1w5ypDqz0MXxUak4V12RFxJ7UDrHdHcoQs4C7cBN3WkthNbx/
         ZZ/btksCBkbL7tm3Rb1R2RAgFF+Riex8LTiLW/TzzvTxp8J7kHLUviXKVJLKIHBCtX
         QzWSRYc6/txApeZO6oQY+Hm8Yx08sI2c00nw5Tj8ipUsZMO0EBBl34DRtCmxWhXlY7
         TUCkrTvrVPlJ9TZV7eo5I/iwBfZYUiNFX2mifYH3M+qAt1O9CAGzkqDd2Yr7W2RqWm
         Eeq2m5VK2ppNIhQqT2AAv7BsPpwDryOQIM1hJ4D7NofuusS8wZL5AHZZlHT41UqakL
         hrS9qWBmAbHxw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Luca Coelho <luca@coelho.fi>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH for v5.17 1/2] iwlwifi: remove deprecated broadcast filtering feature
References: <20220128124851.538580-1-luca@coelho.fi>
        <iwlwifi.20220128144623.9241e049f13e.Ia4f282813ca2ddd24c13427823519113f2bbebf2@changeid>
        <b784b942-6346-7005-b71a-5682cf0452b1@leemhuis.info>
        <87a6fccg6j.fsf@tynnyri.adurom.net>
        <260df94d-8cc4-35eb-775c-d42ba57d6f88@leemhuis.info>
Date:   Thu, 03 Feb 2022 11:02:36 +0200
In-Reply-To: <260df94d-8cc4-35eb-775c-d42ba57d6f88@leemhuis.info> (Thorsten
        Leemhuis's message of "Mon, 31 Jan 2022 13:45:40 +0100")
Message-ID: <8735l0cogj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> On 31.01.22 12:12, Kalle Valo wrote:
>> Thorsten Leemhuis <regressions@leemhuis.info> writes:
>>> On 28.01.22 13:48, Luca Coelho wrote:
>>>> From: Luca Coelho <luciano.coelho@intel.com>
>>>>
>>>> This feature has been deprecated and should not be used anymore.  With
>>>> newer firmwares, namely *-67.ucode and above, trying to use it causes an
>>>> assertion failure in the FW, similar to this:
>>>>
>>>> [Tue Jan 11 20:05:24 2022] iwlwifi 0000:04:00.0: 0x00001062 | ADVANCED_SYSASSERT
>>>>
>>>> In order to prevent this feature from being used, remove it entirely
>>>> and get rid of the Kconfig option that
>>>> enables it (IWLWIFI_BCAST_FILTERING).
>>>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215488
>>>
>>> FWIW there was another report about it afaics:
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215550
>> 
>> If it's the same issue, it should be marked as a duplicate.
>
> Understandable request, but sorry, for now I decided to not do that in
> such situations for two reasons:
>
>  * it can easily go wrong, as I encounter all sorts of kernel bugs and
> thus often lack detailed knowledge about the areas the bug is about
>
>  * I'm doing regression tacking in my spare time, which is hard enough
> already; taking care of bugs would make it a lot harder -- especially as
> some maintainers/subsystems seem to (mostly) ignore bugzilla, so I would
> be starting to do their job. Hence I only look at bugzilla to make sure
> no regressions reported there falls through the cracks. See also:
> https://lore.kernel.org/regressions/3ee8c6c9-52d1-9570-f3bf-490365c9f6fe@leemhuis.info/

I share your pain, I'm also overwhelmed by mail and patches :) To be
exact, I didn't mean that you Thorsten should mark the bug duplicate and
I was hoping that someone from Intel would do it. And Golan thankfully
did that:

https://bugzilla.kernel.org/show_bug.cgi?id=215550#c1

And I also agree about challenges with Bugzilla. I personally have time
to only follow ath11k bugzilla reports, everything else I'm forced to
ignore. This is a big disconnect between users and developers which
worries me as well.

>>> That makes me hope that this is reviewed and merged to mainline relative
>>> quickly, otherwise more users will be bothered by this.
>>>
>>>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>>> Fixes: cbaa6aeedee5 ("iwlwifi: bump FW API to 67 for AX devices")
>>>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>>
>>> Shouldn't this also have:
>>>
>>> Cc: stable@vger.kernel.org # 5.16.x
>> 
>> I can add that.
>
> thx.
>
>> BTW, please trim your quotes. You left a really long (and unnecessary)
>> quote, which makes use of patchwork much harder for us maintainers.
>> Unfortunately patchwork is not able to trim them automatically:
>
> Argh, sorry, of course, will do that. I normally trim a lot more, but
> when I'm in "regression tracker mode" I work differently and quote more,
> as I often have to poke discussions that got stalled -- and there the
> context might be helpful. But you are obviously right, for patches and
> quite a few other situations that's obviously unneeded and harmful.

Yeah, understandable that quoting more is helpful for regression
reports. I wish patchwork would have a feature to automatically trim
unnecessary quotes, that would be really helpful for us maintainers.

BTW, I also have a feature request for regzbot :) I try to follow
regression emails very carefully, but I find the emails quite hard to
read as it's not easy to see what part of text is written by a bot and
which is from a human. I get so much email that I try to skim the emails
quickly and ignore all the boilerplate text, but with regzbot emails
that's difficult. One way to solve this might be to add all boilerplate
code between "-----[cut]------" lines or something like that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

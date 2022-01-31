Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8735B4A4771
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 13:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358412AbiAaMpp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 07:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351716AbiAaMpo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 07:45:44 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E88C06173D
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 04:45:44 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nEW3w-0003wz-Hh; Mon, 31 Jan 2022 13:45:40 +0100
Message-ID: <260df94d-8cc4-35eb-775c-d42ba57d6f88@leemhuis.info>
Date:   Mon, 31 Jan 2022 13:45:40 +0100
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
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <87a6fccg6j.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643633144;c7b7a3c5;
X-HE-SMSGID: 1nEW3w-0003wz-Hh
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 31.01.22 12:12, Kalle Valo wrote:
> Thorsten Leemhuis <regressions@leemhuis.info> writes:
>> On 28.01.22 13:48, Luca Coelho wrote:
>>> From: Luca Coelho <luciano.coelho@intel.com>
>>>
>>> This feature has been deprecated and should not be used anymore.  With
>>> newer firmwares, namely *-67.ucode and above, trying to use it causes an
>>> assertion failure in the FW, similar to this:
>>>
>>> [Tue Jan 11 20:05:24 2022] iwlwifi 0000:04:00.0: 0x00001062 | ADVANCED_SYSASSERT
>>>
>>> In order to prevent this feature from being used, remove it entirely
>>> and get rid of the Kconfig option that
>>> enables it (IWLWIFI_BCAST_FILTERING).
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215488
>>
>> FWIW there was another report about it afaics:
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215550
> 
> If it's the same issue, it should be marked as a duplicate.

Understandable request, but sorry, for now I decided to not do that in
such situations for two reasons:

 * it can easily go wrong, as I encounter all sorts of kernel bugs and
thus often lack detailed knowledge about the areas the bug is about

 * I'm doing regression tacking in my spare time, which is hard enough
already; taking care of bugs would make it a lot harder -- especially as
some maintainers/subsystems seem to (mostly) ignore bugzilla, so I would
be starting to do their job. Hence I only look at bugzilla to make sure
no regressions reported there falls through the cracks. See also:
https://lore.kernel.org/regressions/3ee8c6c9-52d1-9570-f3bf-490365c9f6fe@leemhuis.info/


>> That makes me hope that this is reviewed and merged to mainline relative
>> quickly, otherwise more users will be bothered by this.
>>
>>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>> Fixes: cbaa6aeedee5 ("iwlwifi: bump FW API to 67 for AX devices")
>>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>
>> Shouldn't this also have:
>>
>> Cc: stable@vger.kernel.org # 5.16.x
> 
> I can add that.

thx.

> BTW, please trim your quotes. You left a really long (and unnecessary)
> quote, which makes use of patchwork much harder for us maintainers.
> Unfortunately patchwork is not able to trim them automatically:

Argh, sorry, of course, will do that. I normally trim a lot more, but
when I'm in "regression tracker mode" I work differently and quote more,
as I often have to poke discussions that got stalled -- and there the
context might be helpful. But you are obviously right, for patches and
quite a few other situations that's obviously unneeded and harmful.

Ciao, Thorsten

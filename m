Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD72662290
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 11:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjAIKJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 05:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbjAIKJf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 05:09:35 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942D1B6F
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 02:09:34 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pEp5w-0001sh-TM; Mon, 09 Jan 2023 11:09:32 +0100
Message-ID: <097cb5d3-2756-ad48-bdc2-fef733776387@leemhuis.info>
Date:   Mon, 9 Jan 2023 11:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH for-6.2] wifi: brcmfmac: fix regression for Broadcom PCIe
 wifi devices
Content-Language: en-US, de-DE
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        chainofflowers <chainofflowers@posteo.net>
References: <20230109095020.412475-1-arend.vanspriel@broadcom.com>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230109095020.412475-1-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673258974;04cc162c;
X-HE-SMSGID: 1pEp5w-0001sh-TM
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09.01.23 10:50, Arend van Spriel wrote:
> A sanity check was introduced by [1] considering maximum flowrings
> above 256 as insane and effectively aborting the device probe. This
> resulted in regression for number of users and it is also tracked
> in bugzilla [2].

Many thx for taking care of this. There is one small thing to improve to
make things easier for future code archaeologists:

> [1] https://lore.kernel.org/all/20220929031001.9962-3-ian.lin@infineon.com/

The following line...

> [2] https://bugzilla.kernel.org/show_bug.cgi?id=216894

...should become...:

> Fixes: 2aca4f3734bd ("brcmfmac: return error when getting invalid max_flowrings from dongle")

...this instead:

Reported-by: Christian Marillat <marillat@debian.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216894 [2]

> Reported-by: chainofflowers <chainofflowers@posteo.net>

Here you afaics want to add something like this:

Link: https://lore.kernel.org/all/4781984.GXAFRqVoOG@luna/

> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> [...]

To explain: Linus[1] and others considered proper link tags important in
cases like this, as they allow anyone to look into the backstory of a
fix weeks or years later. That's nothing new, the documentation[2] for
some time says to place such tags in cases like this. I care personally
(and made it a bit more explicit in the docs a while ago), because these
tags make my regression tracking efforts a whole lot easier, as they
allow my tracking bot 'regzbot' to automatically connect reports with
patches posted or committed to fix tracked regressions.

Apropos regzbot, let me tell regzbot to monitor this thread:

#regzbot ^backmonitor: https://bugzilla.kernel.org/show_bug.cgi?id=216894

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

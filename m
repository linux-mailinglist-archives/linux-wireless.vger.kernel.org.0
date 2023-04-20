Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A26E98F8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjDTP74 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjDTP7z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 11:59:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9CD199
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 08:59:53 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ppWhM-0001Xd-6b; Thu, 20 Apr 2023 17:59:52 +0200
Message-ID: <04d69168-8ead-84fb-a411-fa781502cceb@leemhuis.info>
Date:   Thu, 20 Apr 2023 17:59:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] wifi: ath9k: Don't mark channelmap stack variable
 read-only in ath9k_mci_update_wlan_channels()
Content-Language: en-US, de-DE
To:     Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?= =?UTF-8?Q?sen?= 
        <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-wireless@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20230413214118.153781-1-toke@toke.dk> <87v8hysrzx.fsf@kernel.org>
 <87bkjqzrdm.fsf@toke.dk> <87edom7i6i.fsf@kernel.org> <877cu9wl7r.fsf@toke.dk>
 <87zg74v5cy.fsf@kernel.org>
 <f4939cb3-bc01-c9e1-aac9-2adb554bc3c4@leemhuis.info> <87edoetyve.fsf@toke.dk>
 <20230420075027.6852197a@kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20230420075027.6852197a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1682006394;ada00ebe;
X-HE-SMSGID: 1ppWhM-0001Xd-6b
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20.04.23 16:50, Jakub Kicinski wrote:
> On Thu, 20 Apr 2023 16:24:53 +0200 Toke Høiland-Jørgensen wrote:
>>>> But it is always a question of time :) To save
>>>> time I usually try to send two wireless tree pull requests per cycle,
>>>> one early in the cycle and the second around the middle.  
>>>
>>> Why not ask Linus to pull this directly from the list then?

BTW (to reply to two mails with one): Toke, thx for giving it a shot!

> Out of curiosity, Thorsten, do you have stats on "how long does it take
> fixes to reach Linus" per tree? Stats get people to act much quicker
> than pleas, just sayin' ;)

I know, I know... :-( Nevertheless thx for the reminder. :-D

I really wish that I had some, but right now the data I have in regzbot
is too messy and not a good base to generate such stats, as they would
likely be misleading (that's the long story short).

I once had the rough plan to approach this differently by looking at all
commits that ended up in the first big batches of stable updates (e.g.
releases like 6.0.3 with many hundreds of changes). I wanted to filter
out the regression fixes and then (1)look how long it took from posting
the fix till it was mainlined and (2)backported to stable. But there
afaics is no good way to automate the first part of the job: filtering
out fixes for regressions that actually bothered someone and might or
might not have been tracked by regzbot (the "might not" share might be
the bigger one, which is part of the valid stats problem indicated above).

>>> He doesn't
>>> mind doing that for an occasional regression fix. And then he can decide
>>> himself if the change is worth the risk -- and obviously can take into
>>> account if he'll release and rc8 or not.  
>>
>> I'm OK with doing it that way; I'll do so later tonight unless Kalle or
>> Jakub complains before then...
> 
> Ah, just after our last(?) 6.3 PR was submitted :(
> No objections to you posting this directly to Linus...
> 
> That said it is a 6.2 regression AFAICT so it's not exactly in the
> "must be fixed in 6.3" category.

Out of curiosity (really, it's not meant as a rhetorical device, I'm
trying to understand this point of view):

Why do you think that? And should it really be like that?

Sure, if it was an old problem (say from 5.18) that was only recently
found I'd agree, especially if the fix might have a more than average
risk of causing other trouble. But shouldn't we care about regressions
that were found shortly after a release (e.g. 6.2 in this case) at least
as much (or maybe even more?) as we care about those found during the
weeks preceding it?

FWIW, it's not the first time I hear a statement like that and every
time I wonder how Linus thinks about this. But whatever, not going to CC
him for that.

Ciao, Thorsten

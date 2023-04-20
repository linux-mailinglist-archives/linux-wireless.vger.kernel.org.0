Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42496E9B93
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 20:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjDTS1p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDTS1o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 14:27:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648B630E3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 11:27:42 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ppZ0O-0001vs-0w; Thu, 20 Apr 2023 20:27:40 +0200
Message-ID: <fc39889a-1353-c023-32a7-15bfdbc4176e@leemhuis.info>
Date:   Thu, 20 Apr 2023 20:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] wifi: ath9k: Don't mark channelmap stack variable
 read-only in ath9k_mci_update_wlan_channels()
Content-Language: en-US, de-DE
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-wireless@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230413214118.153781-1-toke@toke.dk> <87v8hysrzx.fsf@kernel.org>
 <87bkjqzrdm.fsf@toke.dk> <87edom7i6i.fsf@kernel.org> <877cu9wl7r.fsf@toke.dk>
 <87zg74v5cy.fsf@kernel.org>
 <f4939cb3-bc01-c9e1-aac9-2adb554bc3c4@leemhuis.info> <87edoetyve.fsf@toke.dk>
 <20230420075027.6852197a@kernel.org>
 <04d69168-8ead-84fb-a411-fa781502cceb@leemhuis.info>
 <20230420095506.671a8e34@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230420095506.671a8e34@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1682015262;fd65deb4;
X-HE-SMSGID: 1ppZ0O-0001vs-0w
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[CCing Linus: there are two things near the end of this mail where we're
wondering how you feel about them]

On 20.04.23 18:55, Jakub Kicinski wrote:
> On Thu, 20 Apr 2023 17:59:49 +0200 Thorsten Leemhuis wrote:
>>> Out of curiosity, Thorsten, do you have stats on "how long does it take
>>> fixes to reach Linus" per tree? Stats get people to act much quicker
>>> than pleas, just sayin' ;)  
>>
>> I know, I know... :-( Nevertheless thx for the reminder. :-D
>>
>> I really wish that I had some, but right now the data I have in regzbot
>> is too messy and not a good base to generate such stats, as they would
>> likely be misleading (that's the long story short).
>>
>> I once had the rough plan to approach this differently by looking at all
>> commits that ended up in the first big batches of stable updates (e.g.
>> releases like 6.0.3 with many hundreds of changes). I wanted to filter
>> out the regression fixes and then (1)look how long it took from posting
>> the fix till it was mainlined and (2)backported to stable. But there
>> afaics is no good way to automate the first part of the job: filtering
>> out fixes for regressions that actually bothered someone and might or
>> might not have been tracked by regzbot (the "might not" share might be
>> the bigger one, which is part of the valid stats problem indicated above).
> 
> I wouldn't bother with the patches you didn't track in regzbot.
> This probably depends on how various people apply / maintain their
> patches (sigh) but for networking (and anything else that's pretty 
> pure git management) author date of the commit should give you the
> time when patch was posted.

Unless the patch went through several revisions during review. But
that's just a detail.

> So we could go regzbot report date -> author date in upstream -> commit
> date in stable potentially without much coding.
>
> Going to Linus's tree vs stable should also be possible. Chris Mason
> has showed me once a git incantation which finds the merge commit in
> Linus's tree at which a given patch has arrived.. but I lost it.

I have something ugly for that (I needed a python variant of this
somewhere in regzbot):

commit=91dcf1e80;
branch=origin/master;
git show $(git rev-list "${commit}".."${branch}" --ancestry-path |
grep -f <(git rev-list "${commit}".."${branch}" --first-parent) |
tail -1)

[note: this will fail for any changes Linus committed directly to mainline]

>>>> I'm OK with doing it that way; I'll do so later tonight unless Kalle or
>>>> Jakub complains before then...  
>>>
>>> Ah, just after our last(?) 6.3 PR was submitted :(
>>> No objections to you posting this directly to Linus...
>>>
>>> That said it is a 6.2 regression AFAICT so it's not exactly in the
>>> "must be fixed in 6.3" category.  
>>
>> Out of curiosity (really, it's not meant as a rhetorical device, I'm
>> trying to understand this point of view):
>>
>> Why do you think that? And should it really be like that?
>>
>> Sure, if it was an old problem (say from 5.18) that was only recently
>> found I'd agree, especially if the fix might have a more than average
>> risk of causing other trouble. But shouldn't we care about regressions
>> that were found shortly after a release (e.g. 6.2 in this case) at least
>> as much (or maybe even more?) as we care about those found during the
>> weeks preceding it?
>>
>> FWIW, it's not the first time I hear a statement like that and every
>> time I wonder how Linus thinks about this. But whatever, not going to CC
>> him for that.
> 
> I'm a but curious what Linus would think, too.

:-)

I CCed Linus now, as another question for him came up below. With a bit
of luck he'll share his view on these matters. And if not I'm pretty
sure we'll all live happily ever after, too. :-D

> Just to be clear the assumption I operate on is that all regressions
> are important to fix within reasonable time frame. The question is
> whether it matters for this regression that we're close to final.
> Whether we should engage extraordinary means to get the fix in before
> final is cut.

Well, the risk obviously is a factor here, especially during a potential
release week (like the one we're in); but I don't think the risk
evaluation for "fixes for regressions introduced in the previous cycle"
and "fixes for regressions introduced this cycle" should be much
different. But that's see what Linus thinks about this.

> If it was a 6.3 regression we should try as hard as we can to fix it
> in final (e.g. the mlx5 regression), if it's in 6.2 already - the extra
> week 

Well, yes, in the ideal case it is just a week. But at this point of the
devel cycle a one week delay in mainlining can easily result in a two
week delay till the fix reaches users through the stable trees. To explain:

* Assume this fix (posted one week ago) is not merged this week and
Linus releases 6.3 on Sunday; assume further the fix then will go to
mainline during the merge window (e.g. the one week delay scenario). If
that happens during the first or second week of the merge window doesn't
even matter much, as Greg apparently often waits till after -rc1 is
released before be starts backporting most fixes. And that's where the
extra week comes from. We of course could avoid this by bothering Greg
to pick up the fix once it reached mainline; but then it might be better
to bother Linus in the first place to merge is this week.

Not to mention that there would have been another week of delay, if (a)
I had not spoken up in this thread and (b) we get a rc8. But we afaics
avoided that scenario already with the plan to merge the fix next week
through the -net tree in case we get a rc8.

> of waiting may not be worth skipping trees and bothering Linus.

Linus, to you feel bothered by an occational additional pull request or
a mail asking you to pick up a patch directly from the list?

> IOW for older regressions there's only the question of whether the fix
> is in upstream in a reasonable time. It doesn't matter as much which
> particular tag it hits.

Ciao, Thorsten

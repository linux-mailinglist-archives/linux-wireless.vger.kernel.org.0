Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34296E9A07
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDTQza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjDTQzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 12:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C21421F
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 09:55:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EDE664AB3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 16:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E0EC433EF;
        Thu, 20 Apr 2023 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682009707;
        bh=Zc3v3VML/m55UwrpbTQFdmQ8FHA8UP6Dc3Ci7NESIEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=slfgxw9Sx1EegcJcd+s7x0mOOuKi3ulhbMxwRjE4/aXqFbE5fGl0L/fxu7Axfrt8E
         F6swk4o202y7HFmuZKiipDctuzYsyAB8/5nbtXQFrR/7+hjL8tSlicOG/gX5cxiyrn
         81bicg6gQcXZodvfX5RVnnOvD4bdK1aGFENxuV6MbmHaqX0a964dL+xsCYQKAEY/wn
         ZWbsVMI6tUe/v4d3NA3j9ZC3PJgTFkoacVcjJN6dVzlNMhcdod2v3sndKwniUGnjzh
         +N+d+E8pOwcm/KI61yPJ3ziqtoKnx9vVFWOoj82PY2/qPXcyJKODYzHlI+nntVU3or
         6o/K078me6kNw==
Date:   Thu, 20 Apr 2023 09:55:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-wireless@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] wifi: ath9k: Don't mark channelmap stack variable
 read-only in ath9k_mci_update_wlan_channels()
Message-ID: <20230420095506.671a8e34@kernel.org>
In-Reply-To: <04d69168-8ead-84fb-a411-fa781502cceb@leemhuis.info>
References: <20230413214118.153781-1-toke@toke.dk>
        <87v8hysrzx.fsf@kernel.org>
        <87bkjqzrdm.fsf@toke.dk>
        <87edom7i6i.fsf@kernel.org>
        <877cu9wl7r.fsf@toke.dk>
        <87zg74v5cy.fsf@kernel.org>
        <f4939cb3-bc01-c9e1-aac9-2adb554bc3c4@leemhuis.info>
        <87edoetyve.fsf@toke.dk>
        <20230420075027.6852197a@kernel.org>
        <04d69168-8ead-84fb-a411-fa781502cceb@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 20 Apr 2023 17:59:49 +0200 Thorsten Leemhuis wrote:
> > Out of curiosity, Thorsten, do you have stats on "how long does it take
> > fixes to reach Linus" per tree? Stats get people to act much quicker
> > than pleas, just sayin' ;)  
> 
> I know, I know... :-( Nevertheless thx for the reminder. :-D
> 
> I really wish that I had some, but right now the data I have in regzbot
> is too messy and not a good base to generate such stats, as they would
> likely be misleading (that's the long story short).
> 
> I once had the rough plan to approach this differently by looking at all
> commits that ended up in the first big batches of stable updates (e.g.
> releases like 6.0.3 with many hundreds of changes). I wanted to filter
> out the regression fixes and then (1)look how long it took from posting
> the fix till it was mainlined and (2)backported to stable. But there
> afaics is no good way to automate the first part of the job: filtering
> out fixes for regressions that actually bothered someone and might or
> might not have been tracked by regzbot (the "might not" share might be
> the bigger one, which is part of the valid stats problem indicated above).

I wouldn't bother with the patches you didn't track in regzbot.
This probably depends on how various people apply / maintain their
patches (sigh) but for networking (and anything else that's pretty 
pure git management) author date of the commit should give you the
time when patch was posted.

So we could go regzbot report date -> author date in upstream -> commit
date in stable potentially without much coding.

Going to Linus's tree vs stable should also be possible. Chris Mason
has showed me once a git incantation which finds the merge commit in
Linus's tree at which a given patch has arrived.. but I lost it.

> >> I'm OK with doing it that way; I'll do so later tonight unless Kalle or
> >> Jakub complains before then...  
> > 
> > Ah, just after our last(?) 6.3 PR was submitted :(
> > No objections to you posting this directly to Linus...
> > 
> > That said it is a 6.2 regression AFAICT so it's not exactly in the
> > "must be fixed in 6.3" category.  
> 
> Out of curiosity (really, it's not meant as a rhetorical device, I'm
> trying to understand this point of view):
> 
> Why do you think that? And should it really be like that?
> 
> Sure, if it was an old problem (say from 5.18) that was only recently
> found I'd agree, especially if the fix might have a more than average
> risk of causing other trouble. But shouldn't we care about regressions
> that were found shortly after a release (e.g. 6.2 in this case) at least
> as much (or maybe even more?) as we care about those found during the
> weeks preceding it?
> 
> FWIW, it's not the first time I hear a statement like that and every
> time I wonder how Linus thinks about this. But whatever, not going to CC
> him for that.

I'm a but curious what Linus would think, too.

Just to be clear the assumption I operate on is that all regressions
are important to fix within reasonable time frame. The question is
whether it matters for this regression that we're close to final.
Whether we should engage extraordinary means to get the fix in before
final is cut.

If it was a 6.3 regression we should try as hard as we can to fix it
in final (e.g. the mlx5 regression), if it's in 6.2 already - the extra
week of waiting may not be worth skipping trees and bothering Linus.

IOW for older regressions there's only the question of whether the fix
is in upstream in a reasonable time. It doesn't matter as much which
particular tag it hits.

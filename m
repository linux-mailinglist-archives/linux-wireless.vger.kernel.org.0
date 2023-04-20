Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6FB6E98D5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 17:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjDTP4c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 11:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDTP4b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 11:56:31 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60161110
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 08:56:29 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1682006187; bh=U+Ha7iX6ggmmBf5zjDVQjSOCPw1VlO3VsjG4iIn8pak=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fOubRk4GK+NxS4BaZgg0A+gIHXx1Fds00lnqfoKAnNY0gn45yhOqqwBuZZ9ZWvDAN
         x9EuhKrAgHbU69dYp2QA+pYHVvLTtSLZHitJbjCFb51LWHCocDqvZVcWvpUIVFq8+o
         N+wjf+lP9CSMbMiUYkwjysmfTvVauB/rThTQJmgFdA4C1HCE67V019RPwv42CrSVcC
         ZOyFtyBwakEZxauVlWy7Eb3CLE3Xb+6jwqW5WibJU8d9MVpQFAlQ5jOUFBu3vTNuL7
         ItPqFKf9F23EqQU+5XJGlSeEve+p+XrZFyxM7S+HAJOBwzftSziZZKvvT0+QQJE45+
         Pr6yFIYHM/33A==
To:     Jakub Kicinski <kuba@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-wireless@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] wifi: ath9k: Don't mark channelmap stack variable
 read-only in ath9k_mci_update_wlan_channels()
In-Reply-To: <20230420075027.6852197a@kernel.org>
References: <20230413214118.153781-1-toke@toke.dk>
 <87v8hysrzx.fsf@kernel.org> <87bkjqzrdm.fsf@toke.dk>
 <87edom7i6i.fsf@kernel.org> <877cu9wl7r.fsf@toke.dk>
 <87zg74v5cy.fsf@kernel.org>
 <f4939cb3-bc01-c9e1-aac9-2adb554bc3c4@leemhuis.info>
 <87edoetyve.fsf@toke.dk> <20230420075027.6852197a@kernel.org>
Date:   Thu, 20 Apr 2023 17:56:26 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87354utumt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

>> > He doesn't
>> > mind doing that for an occasional regression fix. And then he can decide
>> > himself if the change is worth the risk -- and obviously can take into
>> > account if he'll release and rc8 or not.  
>> 
>> I'm OK with doing it that way; I'll do so later tonight unless Kalle or
>> Jakub complains before then...
>
> Ah, just after our last(?) 6.3 PR was submitted :(
> No objections to you posting this directly to Linus...

Heh, yeah :( In retrospect, just asking you to take it directly into
-net might have been the expedient thing to do here.

> That said it is a 6.2 regression AFAICT so it's not exactly in the
> "must be fixed in 6.3" category. Assuming Kalle doesn't want a PR -
> should we take it into net and have it reach Linus either next Tue
> (assuming no -rc8) or Thu (if -rc8)?

How about I ping Linus and if he doesn't want to take it directly, you
can pull it into -net?

-Toke

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD76D5000
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 20:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjDCSHI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 14:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjDCSG5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 14:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B084A358E
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 11:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3895262447
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 18:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A376EC433EF;
        Mon,  3 Apr 2023 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680545211;
        bh=C0jeJzYSg+7BaH8JhWlX6pjE/fzFELNGkqiQ29PPBZo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HsjeXKwa8i47X7mJp2jctTv/2pxF8ualDrv9Mgoj2yp4EXZCaHBW9bRk0emzWsyum
         B9wZqA06UWW2AFvPjzuaE57PqAuqyL9wP5c7sDW57eD/Zhgz76hUjqHVEjqR32/nt8
         4imiLWNlA754pmCiWTl3uyTMAU7dTvluTTtSASZp3NJtSo7okoxRhrStXUkATMY3rC
         ZzGe16aXTj63KDpetsQS9nY3kN3Td2w49RKuVg7Zn7cjSTcikEQJuM5ea3Z5rO+8Bz
         RRUUBL6w8asJBLy5d0YPpLT+aZGgBoqbcOZtezHVbly6AmphjxnPtWQqoEzxY3flJW
         GS1ijf7i54hYg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>,
        "arnd\@arndb.de" <arnd@arndb.de>
Subject: Re: rtw88/rtw89: command/event structure handling
References: <20230310034631.45299-1-pkshih@realtek.com>
        <20230310034631.45299-2-pkshih@realtek.com>
        <87zg8emn4i.fsf@kernel.org>
        <e3670d1075f54c69ba3971067b3d06b7@realtek.com>
        <87a5zpb71j.fsf_-_@kernel.org> <871ql1aym9.fsf@kernel.org>
        <84e5fadd204807a6de84376f76d405a63198e055.camel@realtek.com>
Date:   Mon, 03 Apr 2023 21:06:46 +0300
In-Reply-To: <84e5fadd204807a6de84376f76d405a63198e055.camel@realtek.com>
        (Ping-Ke Shih's message of "Mon, 3 Apr 2023 14:09:51 +0000")
Message-ID: <87ttxwalhl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> > Downside of course is that there's quite a lot of boilerplate code but I
>> > still consider that positives outweight the negatives. Thoughts?
>> > 
>> > And I'll emphasise that this is not a blocker for anything but it would
>> > be nice to clean this up both in rtw88 and rtw89 at some point, if we
>> > can.
>
> Since they will be a lot of works and I have a lot of local patches on
> hand, can I apply these rules to the patches and submit them ahead? 
> Until all things or a bunch of conversion are completed (maybe weeks or
> one or two months later), I can submit patches that only convert
> these H2C/C2H with new rules.
>
> Does it work to you?

Yes, that's totally fine. No rush with this cleanup. Thanks for working
on this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

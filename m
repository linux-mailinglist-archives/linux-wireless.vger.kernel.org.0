Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E141C76D037
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 16:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjHBOiy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 10:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjHBOix (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 10:38:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C6EE0
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 07:38:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2459261935
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 14:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AFFC433C8;
        Wed,  2 Aug 2023 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690987130;
        bh=XMYBUOEpbwsLsmZLwG5qs0o6ce0mwOFiG17qL3HMyHw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UrhyYdOx08wh4LbhILA/pGZAECznf6KIYE0XpihTIybNND5gjzu+SiSZXn1P/e3y3
         JShFIBf4bKiuUS3I54KL3eeb5swqNby65fZK9TtJvbOKO6AJg5RAjlNk8UHv1GZB00
         Hf0CthCpxre8JdhXERTpw05UTciyzm4jKpzh0L6428yCwMKRou82FWs8/1oDdw2Qhs
         rMVo7mXcnX13mIaMvDm43+DHFD6t7peU9DgDPF19vt5kbPZ+utnuSm+/ZNpznM06cY
         leEX2ThCBl1kWynwG5RZSfiCqcYaSt5qlqVK0625BiuMlOhuSVFgtoppr46T2TQfqQ
         jgQNBwxeIhoqQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Hin-Tak Leung <htl10@users.sourceforge.net>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless@vger.kernel.org
Subject: Re: MAINTAINERS: rtl8187 wireless driver
References: <20230608095051.116702-4-dmantipov@yandex.ru>
        <168664510862.24637.10587241603155144086.kvalo@kernel.org>
        <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru>
        <87h6rad3fp.fsf@kernel.org>
        <bccf723a-9f57-73a7-37af-badc6c156daa@yandex.ru>
        <87cz1vbulk.fsf@kernel.org>
        <2e78d1f5-4dc5-9665-e3a1-ee00dcc41630@yandex.ru>
        <fe6b1abc-d529-c20f-3fcb-43d891091080@lwfinger.net>
        <87v8dzxg5l.fsf_-_@kernel.org>
        <92233d7c-9595-9223-39e1-6df68b13d474@lwfinger.net>
        <2131579919.392146.1690979184620@mail.yahoo.com>
Date:   Wed, 02 Aug 2023 17:38:47 +0300
In-Reply-To: <2131579919.392146.1690979184620@mail.yahoo.com> (Hin-Tak Leung's
        message of "Wed, 2 Aug 2023 12:26:24 +0000 (UTC)")
Message-ID: <87msz9v79k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> writes:

> On Tuesday, 1 August 2023 at 18:05:08 BST, Larry Finger <larry.finger@lwfinger.net> wrote: 
>
> <snipped>
>
>> > In the git history the last activity from Herton is from 2010 so I think
>> > we should remove him.
>>.> 
>> > Is Hin-Tak still active? The last activity is from 2020.
>> > 
>> > Also the git tree is outdated so that should be removed.
>
>> Kalle,
>
>> I removed Herton and Hin-Tak as Maintainers for rtl8187 > and updated the tree 
>> entries for rtl8187 and rtl8180. Patches are submitted.
>
> I think I tried to Ack some recent changes a few months ago, but it
> didn't go through - my email server insists on sending html-enabled
> messages, which gets dropped by the kernel mailing lists. I did have
> to jump through some hoops to use git-send-email instead for important
> things.

Yeah, your reply was in HTML so our lists dropped it. I'm sorry to say
but if you are not able to send mails as text/plain you cannot continue
as a maintainer, we require that the mails are visible in the list.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

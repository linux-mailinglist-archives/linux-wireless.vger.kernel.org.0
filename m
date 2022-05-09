Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8B51FB1A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiEILSE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 07:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiEILSD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 07:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39721D737A
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 04:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61CFA61126
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 11:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D51BC385A8;
        Mon,  9 May 2022 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652094848;
        bh=W9XryWWy7zN51m400OZmGHcYJ1ZuaRsz7NhM8mNeJkQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Xpf5P3OOfcsd+kH9cEnSMH+vGHDzeyL8yawjlbrC4VpOC5jYE7ksmIBLOmxumu2e8
         28hwyl1NJuQ6q30IQYAastsbhiV4cZkNilGtLHTPgCrWEKTmNBe+SNiaFNH1IFWc4t
         A3Tz7VWhCGtUaAiS5eUMajJrWtlrTl8z0zA16DJM5Cnvpmltb6vOLmC3RqOpEIHSlW
         Id2g1HxVsCuYVUFQG6lhnO+a8qnbW8MhKi2tz2W8VeB6TsOkTVRb2FVfcfTg2V86em
         NrP8zJGfd1Kq8LM57q2OvWBjzKdgnvVY5JCzDABBPRPPCQE/jpLDtncN6+Pdtn+PDD
         pTBsVe3N+J2LQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] wifi: netif_napi_add() conversions
References: <20220504163316.549648-1-kuba@kernel.org>
        <87a6bwzjvk.fsf@kernel.org> <20220505085418.5384f6c9@kernel.org>
Date:   Mon, 09 May 2022 14:14:02 +0300
In-Reply-To: <20220505085418.5384f6c9@kernel.org> (Jakub Kicinski's message of
        "Thu, 5 May 2022 08:54:18 -0700")
Message-ID: <87pmkn7ybp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 05 May 2022 07:25:03 +0300 Kalle Valo wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> 
>> > Convert wifi callers to the new netif_napi_add() APIs.
>> >
>> > The callers passing 64 or NAPI_POLL_WEIGHT to the non-Tx flavor
>> > are left alone. I'm planning to include wifi drivers in the massive
>> > tree-wide patch/series which will drop the last argument from
>> > netif_napi_add(). Alternatively I can switch all of wifi to
>> > netif_napi_add_tx_weight() and back after the netif_napi_add()
>> > change makes its wait into wireless-next.
>> > Please LMK if you prefer that.
>> >
>> > Jakub Kicinski (3):
>> >   wifi: wil6210: switch to netif_napi_add_tx()
>> >   wifi: mt76: switch to netif_napi_add_tx()
>> >   wifi: qtnfmac: switch to netif_napi_add_weight()  
>> 
>> We don't use that "wifi:" prefix, otherwise looks good. 
>
> I know, my silent effort to make git log --oneline be more
> understandable for folks outside of networking is not really
> being met with much applause :) Ethernet people also don't
> like the "eth:" prefix..
>
> AFAICS drivers tend to use a format consisting of (numbers at 
> the top denoting commonality):
>
> 3    4       1       2
> net: vendor: driver: component: bla bla

To me that's almost like the full path. An example from wireless
drivers:

drivers/net/wireless/ath/ath11k/mac.c

net: wireless: ath: ath11k: mac: blah blah

Only the directory name "drivers" is missing from the path.

Wouldn't it be easier to modify the tools showing logs (like git log or
gitk) to add that to each commit, then people who want to see that can
enable the feature :)

> Driver name is the most common prefix. It is the most meaningful
> and natural for people working on the code. Not everyone is working 
> on the driver code, tho.

Sure, I understand that not everyone are developers. It's always a
balance.

> 1) When I send PRs to Linus I always wonder how much he can 
> make out of the shortlog. And if people throw "net:" into the mix
> whether it's still clear when something is "just" a driver bug vs
> a core bug affecting everyone. So I started using "eth: " for ethernet
> drivers, and "wifi: " for wireless drivers in the text of the PRs.
>
> 2) For people doing backporting the driver names may not be meaningful,
> but if I'm doing backports for a datacenter kernel I know to pay
> attention to "eth:" while "wifi:" I can safely skip.

Is there a specific reason why you use "wifi:" and not "wireless:"? I
admit the term wireless is not great for our 802.11 subsystem but that
has been used as long as I know.

> 3) The case of this set - I have conversions for the entire tree queued
> up on a branch, it's quite useful for me to use a common area-specific
> prefix to see what goes were.
>
> Anyway, that's just me rambling. I hope you don't mind if I send things
> with a wifi prefix from time to time given it's a convenient way for me
> to mark the queued patches.

I don't mind if you submit with "wifi:", it's easy to edit patches with
my patchwork script during commit :) And if there's a strong need I
think we can change our title scheme in wireless patches. This has come
before but I have always resisted due to extra work involved. To me most
important is consistency within wireless subsystem, if different
wireless drivers (and stack) use a different scheme when the logs will
become hard to read. So I would hope everyone can agree to the new
scheme.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

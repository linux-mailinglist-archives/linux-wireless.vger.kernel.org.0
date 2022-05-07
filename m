Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AC951E6A0
	for <lists+linux-wireless@lfdr.de>; Sat,  7 May 2022 13:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiEGLaE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 May 2022 07:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiEGLaD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 May 2022 07:30:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A64992A
        for <linux-wireless@vger.kernel.org>; Sat,  7 May 2022 04:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB4ADB83AC9
        for <linux-wireless@vger.kernel.org>; Sat,  7 May 2022 11:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513C3C385A9;
        Sat,  7 May 2022 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651922774;
        bh=N2L1rVyn7X741mmr4pGhvcJpfLHR2Xc2wFhoHOuHMyE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cBmxIL6fNN8A9EzLQUmNq+5wSEqNWwBRODz7+j1IMIRqFimELhJK3glEGAU74nimT
         DdeGE5atp19wO9TyUxoRNGuBfZzSi4DF4EnkCI21DuIoAWA6p9+tL5KX2z5fLIM0yy
         9nq1Czq8GVKzdlaxoA4ifYvOKHShMFl0d7DiGtB0W2KnyCqr/Kqmyku0SBLIzltU30
         nQ26L6Rx3T+v0/xoL2yyYVR3oaFRPLCMjCLRB7yJw/xc0xYyd13oEW2p+Abag8zygo
         iJ5jkWMouvNbyjtL724PfLUdhb81MA4pgLlyXIRfgQe/fmLLlZYDzxDpoqYlDRcssu
         1yTkMWCQOB7AA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DD4C034D8C9; Sat,  7 May 2022 13:26:11 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>,
        Pierre Asselin <pa@panix.com>
Subject: Re: [PATCH] mac80211: Use full queue selection code for control
 port tx
In-Reply-To: <20220507083706.384513-1-alexander@wetzel-home.de>
References: <20220507083706.384513-1-alexander@wetzel-home.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 07 May 2022 13:26:11 +0200
Message-ID: <87r1551t4c.fsf@toke.dk>
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

Alexander Wetzel <alexander@wetzel-home.de> writes:

> Calling only __ieee80211_select_queue() for control port TX exposes
> drivers which do not support QoS to non-zero values in
> skb->queue_mapping and even can assign not available queues to
> info->hw_queue.
> This can cause issues for drivers like we did e.g. see in
> '746285cf81dc ("rtl818x: Prevent using not initialized queues")'.
>
> This also prevents a redundant call to __ieee80211_select_queue() when
> using control port TX with iTXQ (pull path).
> And it starts to prioritize 802.11 preauthentication frames
> (ETH_P_PREAUTH) on all TX paths.
>
> Pierre Asselin confirmed that this patch indeed prevents crashing his
> system without '746285cf81dc ("rtl818x: Prevent using not initialized
> queues")'.
>
> Tested-by: Pierre Asselin <pa@panix.com>
> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
> ---
>
> Starting to prioritize ETH_P_PREAUTH was just added since I noticed that
> contradictory to at least my expectations control port does accept
> ETH_P_PREAUTH but handles these like a normal frame for the priority.
> That can be broken out or even drop, when needed.
>
> While looking at the code I also tripped over multiple other questions
> and I'll probably propose a much more invasive change how to handle
> the queue assignment. (End2end we seem to do some quite stupid things.)
>
> Additionally I really don't get why we call skb_get_hash() on queue
> assignment:
> I found the commit '180ac48ee62f ("mac80211: calculate skb hash early
> when using itxq")' but don't see why calculating the hash early is
> useful. Any hints here are appreciated. fq_flow_idx() seems to do that
> when needed and I can't find any other usage of the hash...

The commit message of that commit has a hint:

    This avoids flow separation issues when using software encryption.

The idea being that the packet contents can change on encryption, but
skb->hash is preserved, so you want it to run before encryption happens
to keep flows in the same queue.

However, AFAICT ieee80211_tx_h_encrypt() is called after frames are
dequeued from the TXQs, so not actually sure this is needed. Adding
Felix, in the hope that he can explain the reasoning behind that commit :)

-Toke

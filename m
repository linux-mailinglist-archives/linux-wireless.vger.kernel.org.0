Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AFB785F84
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 20:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbjHWSZD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 14:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbjHWSZD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 14:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D977FE57
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 11:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6689E65105
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 18:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF815C433C7;
        Wed, 23 Aug 2023 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692815099;
        bh=h0z3H2lg3GaN2DkTVbuPdtP7v45FoFIEoG4D2VFuY5I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BAr3uDOMmhpKDk2JomqeD5EJcE1fE5mvNmdbgiZ7BAeXdpWVMgxShbqPy6eY3oJQz
         0dFV7ei5n7mGjJg2FlW85aR1yEvd7gY8Im4y9cWd3NAL1XtGpdFf9Mc5SKQFfLgqBC
         1McOpTRYDk7/Ht9TrQB5NwrdPuJWhjwRsPeyQ2Q82T5QudjW6irHvj1+XoGuMzGYc7
         7EaChvAEnNzh/MaT9WoWnMYr4AD88oVa0JUwGAQ/dRP7dORfIzwYqT02JTd+H96biu
         AMsrG8u48jPyDszNjOOL+N4pPD+2QEhuUZTV1/mu6lQVwfg34XGLL6CGd2NjxLN7zy
         CLydWf4hhtAGA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: Re: [PATCH 0/6] wifi: rtw89: preparation of TDMA-based MCC (STA+P2P)
References: <20230816082133.57474-1-pkshih@realtek.com>
        <87o7ixhng5.fsf@kernel.org>
        <22a5d99c4f4be30dd7659400ba9a42c0701f6521.camel@realtek.com>
Date:   Wed, 23 Aug 2023 21:24:56 +0300
In-Reply-To: <22a5d99c4f4be30dd7659400ba9a42c0701f6521.camel@realtek.com>
        (Ping-Ke Shih's message of "Wed, 23 Aug 2023 14:47:12 +0000")
Message-ID: <87fs49hb0n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Wed, 2023-08-23 at 16:56 +0300, Kalle Valo wrote:
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > TDMA-based MCC (STA+P2P) is a kind of multiple interfaces concurrence.
>> > Basically, driver is to calculate timeslot pattern and firmware follows
>> > the pattern to switch channels. Since BT-coexistence is also a TDMA-based
>> > mechanism, also consider BT timeslot into pattern if BT devices present.
>> 
>> What do you mean with TDMA here? It something like that in STA mode the
>> driver enables 802.11 PS mode before going to another channel? Or
>> something else?
>> 
>
> Yes, when it is working as STA mode or GC, using 802.11 PS mode before
> switching channel. When it plays as GO, NoA is used to inform GC absent
> timing. 
>
> For example, STA on channel 1 + GO on channel 11, and preserve some
> time slot for BT
>
>
>                              (1)
>  channel 1   (STA)   +++++++++
>
>                               (2)
>  channel 11  (GO)             +++++++++
>
>  BT                                    ++++++++
>
>                      |<----------------------->|
>                        Period (or cycle time)
>  
> (1) issue null with power bit
> (2) issue beacon with NoA 
>
>
> Though STA and GO are in different channels, they don't operate at
> the same time. This is the reason I point "TDMA" to prevent
> misunderstanding two virtual interfaces can operate two channels
> at the same time, which may be called DBS or DBCC. But, I'm trying
> to explain hardware capability correctly.

Got it, thanks for the great explanation.

Just out of curiosity, how do you create your ascii diagrams? Is there
some nifty tool to help with those? :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

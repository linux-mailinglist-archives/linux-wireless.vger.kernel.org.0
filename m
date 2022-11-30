Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0548263DBCD
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 18:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiK3RTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 12:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK3RS5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 12:18:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22A624B
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 09:18:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B444161D0D
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 17:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5769AC433C1;
        Wed, 30 Nov 2022 17:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669828731;
        bh=xh6HipE9Jb75qlFWvlf55aInyFX0fmqtese0m4gUxyY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=smgNIQC+mExQfP3XN3yjEnkpKTZGwN0HmfDTTSoWjynnlArhTQf8nkqWwSNcsgJ5i
         cgfafBBUOSKZIWzk0JTjyAI4bIC9DjY9g68M11VVxyie0w7omkaie/9C/qkrUhTtfg
         fJnq4d1koVf+afndK1pxoftAN1koA0EreP1hon09ksAA/tIgj+/mjuTYs+o74Pa+td
         FyD8op6Ae17r1yWzORt6qncqwM6AwZhgEscF+yOFTr2LRHLaT5fPHO5Ao3oiz8lI5m
         v98YONYUHsqmyN9JjLtsfGzUZAHA/u/OBI7ZOMDnMu1APjOiFWAJrEY8YiatMm13Oo
         EvMGlDW2arG0g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: ath11k vs ar_qrtr?
References: <20221130122807.GA31720@lst.de> <87o7so4nr2.fsf@kernel.org>
        <20221130125236.GA865@lst.de> <87k03c4mdb.fsf@kernel.org>
        <20221130132244.GB3055@lst.de>
Date:   Wed, 30 Nov 2022 19:18:47 +0200
In-Reply-To: <20221130132244.GB3055@lst.de> (Christoph Hellwig's message of
        "Wed, 30 Nov 2022 14:22:44 +0100")
Message-ID: <875yewnyx4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Wed, Nov 30, 2022 at 03:12:32PM +0200, Kalle Valo wrote:
>> Heh, I'm learning something new here. But I wonder why nobody else has
>> seen this?
>
> Good question.  How common is the ath11k hardware, especially on latptop
> where it is required for installation given that only installers tend
> to split up driver is non-standard ways.

I'm not sure about exact numbers, but not very common. I have seen
something like 4-5 different laptop models with either QCA6390 or
WCN6855 (both ath11k PCI devices). The PCI support was added to ath11k
in v5.10 (released Dec 2020) so maybe installers haven't caught up yet?
Just guessing though.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

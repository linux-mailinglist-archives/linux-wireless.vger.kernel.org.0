Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42BE7F3076
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 15:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjKUOPQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 09:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjKUOPQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 09:15:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A364D10CB
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 06:15:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D5DC433C8;
        Tue, 21 Nov 2023 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700576112;
        bh=VIpOQOGT75q7qTgqrJxcxGIVQak8KPvWT/q4sYulLoA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Od1Dap9EpxuEWwLk15GlQThOiAfQ7ea20ehkuZ6bR/xznRaqzSzNPgvxAXQn9BKqc
         D3CYhPDrDyEEnzcp2Et9SbDtlViZXPJkXbiJ6DFRfzGoFbHzn1UHLm6LIgGgdAQt0W
         WyIewP5aOrFY5/lMfw6WqVLwTBE3ebKEWY/9gC7DWwkxsqQrisJX2ss9pzzs8LPV+g
         dw+yooijLfr6epaxIJAGWqkutlwq9IuWuVZzD+uqMsM1jarhZ9qpQl1E4iYRGZFJts
         zfGQ1YcY0E7okeDCa/n4k37DKA20D4lZRYRUuXTvnnHhzcPrO1F3EOqHFRXZx3pkTd
         glHRa0PR+nBfg==
From:   Kalle Valo <kvalo@kernel.org>
To:     James Prestwood <prestwoj@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: Power save setting while interface is down
References: <304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com>
Date:   Tue, 21 Nov 2023 16:15:09 +0200
In-Reply-To: <304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com> (James
        Prestwood's message of "Mon, 20 Nov 2023 09:15:28 -0800")
Message-ID: <87msv76vma.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

James Prestwood <prestwoj@gmail.com> writes:

> Hi,
>
> I've noticed a somewhat rare behavior (<1% of the time) where bringing
> an interface up fails after disabling power save. This is done by IWD
> when a user-option is enabled, and follows an interface
> removal/creation. The sequence is:
>
> 1. Remove default interface
>
> 2. Create new interface
>
> 3. Disable power save on new interface
>
> 4. Bring up new interface (rarely fails with -110).
>
> iwd[1286641]: src/netdev.c:netdev_disable_ps_cb() Disabled power save
> for ifindex 54
> kernel: ath10k_pci 0000:02:00.0: wmi service ready event not received
> iwd[1286641]: Error bringing interface 54 up: Connection timed out
> kernel: ath10k_pci 0000:02:00.0: Could not init core: -110

So I guess you have a test setup to reproduce this easily? How long does
it take to see this?

What hardware and firmware version are you using?

> I'm thinking maybe there is a race between creating the fresh
> interface and disabling PS, then bringing the interface back up?

Yeah, looks like it. If it's relatively easy for you to reproduce this
you could try adding delays to suitable spots in ath10k. That might be
give more ideas where the race is exactly.

> Setting PS after the interface is up (so far) seems to be 100%
> reliable and have not yet seen this behavior. Regardless of any kernel
> fixes I'll need to reorder the command sequence in IWD to support
> existing kernels, but before I work around this issue I wanted to
> point it out so its not hidden from view.

To me working around this in user space doesn't sound like a good idea.
I would rather have a workaround in the kernel (but obviously I hope we
can find a proper fix).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

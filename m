Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D629B645A22
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 13:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLGMtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 07:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLGMtt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 07:49:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23B04732D
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 04:49:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1121DB80D10
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 12:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F79C433B5;
        Wed,  7 Dec 2022 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670417383;
        bh=AXicRcbMt6Q30lfd1HklcIN6z+8S6e+8Nbh/BfqFBgk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pL0sNtJOp87husA4rUHe1JkHAF5bZpQn6WhCXER45b1lPOOWP2E8Fqy91f2H7rTGz
         7ErSGTb+xM03Wpi7FpRBIgy9Jxgm5LZdVAfKORVVadtJCJk5Fk1MCRAOOd3LgY+YgW
         D7G9fqQVuOYzOvu7qNj3Tr6AYd5w0iW44m4biLt6hozci1WwTu/9VmMG4IajRn8/hp
         QsHDEsQiStayrMlq/yk8OQa4RkwhRxMgr7lptyzAWNBzTPWfaONWQoSALeGKLXbrgQ
         XcmEKKc5B/w5bpqqkrtD0kCqG8RNi2raNKSY17DtwOeKdUFoR7uZyJraecbdHHe1wK
         GCLPzv1eSS7DA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: failed to insert STA entry for the AP (error -2)
In-Reply-To: <20221203155227.GA13254@lst.de> (Christoph Hellwig's message of
        "Sat, 3 Dec 2022 16:52:27 +0100")
References: <20221130122807.GA31720@lst.de> <87o7so4nr2.fsf@kernel.org>
        <20221130125236.GA865@lst.de> <87k03c4mdb.fsf@kernel.org>
        <20221130133016.GC3055@lst.de> <87sfhx3ap6.fsf@kernel.org>
        <20221203155227.GA13254@lst.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 07 Dec 2022 14:49:37 +0200
Message-ID: <87cz8v2xb2.fsf@kernel.org>
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

Hi Christoph,

Sorry for the delay, it was Finland's Independence Day so I was offline
for a long weekend.

Christoph Hellwig <hch@lst.de> writes:

> On Fri, Dec 02, 2022 at 08:46:45PM +0200, Kalle Valo wrote:
>> Haven't seen this before either. Really unfortunate that the warning
>> message message is not printing the error value (missed that during
>> review), but I suspect the error is coming from crypto_alloc_shash()
>> call:
>
>> Any chance you could check that? Also please check that
>> CONFIG_CRYPTO_MICHAEL_MIC is enabled (it should be as CONFIG_ATH11K
>> depends on it).
>
> So, this is the debian-installer case onc again.  CONFIG_CRYPTO_MICHAEL_MIC
> is enabled in the kernel config, but michael_mic.ko is not present on
> the installation media. Once I side-load it, the problem goes away.
>
> I guess I'll respind the MODULE_SOFTDEP patch to include michael_mic,

Thanks. But this makes me wonder is it sensible to randomly install a
set of .ko files and drop the rest, like Debian's installer apparently
does? The dependency for drivers is pretty well documented in Kconfig
files, thanks to build testers testing with random configurations, but
if the installer omits all that there will be problems just like you are
experiencing. So for me MODULE_SOFTDEP() feels just like a band aid and
not a robust solution.

Though I am happy to take your MODULE_SOFTDEP() patch, just wondering if
there is a better way to solve this. For example net/mac80211 (the
802.11 stack) has a lot of crypto dependencies:

	select CRYPTO
	select CRYPTO_LIB_ARC4
	select CRYPTO_AES
	select CRYPTO_CCM
	select CRYPTO_GCM
	select CRYPTO_CMAC
	select CRC32

And it's not using MODULE_SOFTDEP() at all.

> but if you have a good idea to make the error reporting more useful that
> would be appreciated as well.

I'll send a patch to improve the error messages in this case.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

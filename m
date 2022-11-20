Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B72B631688
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 22:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKTVMV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 16:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTVMU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 16:12:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F0C186EF
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 13:12:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA00DB80B88
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 21:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617CCC433C1;
        Sun, 20 Nov 2022 21:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668978734;
        bh=6dfH0tBhzR28FezmXUFQr0JGsDO+h45rNlK1HtoBxIg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RwAwvu2bstoUwlHTKfOxcaBj/ymeDwxQ3UDOqydR4efkF0mB4uvTXz4VaC6Edcnz3
         BjbhiSA53JBJTM7NxirDl7DW6z6lk6Gboi2hJbLDQv3Slj/EteUe/M7hFMt8DgS2it
         s00PDCjPNoHAMIYhuSpgqXb5AB8XB3H/Mc0BtklVgnEbTzLFd8PipDCnOOCyLKpJDA
         TKQIrQwV3Zyw+y0CQ3+jP/3uwFMW5osJ6hJ8a8Fg+i6sHPDMrhRIDRT9mhaas408yr
         DZRdTyzM+KTSv0fKilPjGVK0tngDoBbXgwcE5/c6cxb5LSNwhPUoRdZRiegEXqT9U1
         l33itHmd+CLPw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Missing commit - Sent again with Kalle's correct address
References: <bea5e5c1-77e0-f210-e8bf-922492e50213@lwfinger.net>
Date:   Sun, 20 Nov 2022 23:12:08 +0200
In-Reply-To: <bea5e5c1-77e0-f210-e8bf-922492e50213@lwfinger.net> (Larry
        Finger's message of "Sun, 20 Nov 2022 13:35:23 -0600")
Message-ID: <87pmdhpbyv.fsf@kernel.org>
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

Hi Larry,

Larry Finger <Larry.Finger@lwfinger.net> writes:

> I was answering a query regarding the driver for RTW8852BE, and
> happened to check the configuration for 6.1-rc and discovered that the
> appropriate Kconfig and Makefile are missing the following:
>
> commit b5db4ef38e21dd9b6b95ae96cea5032b00e04f24
> Author: Ping-Ke Shih <pkshih@realtek.com>
> Date:   Fri Oct 14 14:02:37 2022 +0800
>
>     wifi: rtw89: 8852b: add 8852be to Makefile and Kconfig
>
> I expected that this one would have been sent upstream to mainline by
> now. Is my expectation wrong, or is the commit missing?

That commit is in wireless-next and the first release having it should
be v6.2-rc1, if all goes well. So the patch is not lost.

We need to get -next patches ready before the merge window opens, so it
takes quite some time before patches go to an actual release. For
example, the estimation for the v6.2 merge window to start is on
2022-12-11. This means that wireless patches should be submitted by
latest 2022-12-05 to make the deadline, and even that's risky. The
estimation for the final v6.2 release is 2023-02-19:

https://phb-crystal-ball.sipsolutions.net/

So we can easily talk about 3-10 weeks delays before a -next patch is in
an -rc release, depending on what part of the release cycle we are.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

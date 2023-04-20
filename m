Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240FB6E9487
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDTMfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDTMfq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871405BA3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72DD4616CA
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 12:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EC6C433D2;
        Thu, 20 Apr 2023 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681994121;
        bh=RJoqQOH2liZFmyXxh7/NEKOileo83BHrjlGjWMwJ+ws=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=iD/Ze+YzZ8Rcsvr+55bBzO7GRMb9/huy0pDnHSPMmr/Mx/3GUJmV62mhhbozTWQRg
         Nw6aYfUIPgjye4sUWPf2O1nJXFJyUDfjyXhBhYoNdz6JB/C9y61RsfPKxbiCt761SC
         b//5yTkIeK/3qmbhH+SQ/tUrboCd8/a42ZA1kJ7gLV3MDTQl0J9WnfI9wOTUWgHyl3
         ReSLgbRiaNJS73q/TH3/0nxt9EzUydDJ7fV0CfXzlNNtNzFvaoWT678JLFh5L9ajK2
         IVpL+4wp1ApWDeGjrutavEyx+No5cWap0D3hY57Tv4xFn8yNDm7VkPUK8ktVnzWjHd
         5jrgG8BZm5lcg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtw88: Fix memory leak in rtw88_usb
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230417160331.23071-1-Larry.Finger@lwfinger.net>
References: <20230417160331.23071-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168199411851.31131.7739840478967345232.kvalo@kernel.org>
Date:   Thu, 20 Apr 2023 12:35:20 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> Kmemleak shows the following leak arising from routine in the usb
> probe routine:
> 
> unreferenced object 0xffff895cb29bba00 (size 512):
>   comm "(udev-worker)", pid 534, jiffies 4294903932 (age 102751.088s)
>   hex dump (first 32 bytes):
>     77 30 30 30 00 00 00 00 02 2f 2d 2b 30 00 00 00  w000...../-+0...
>     02 00 2a 28 00 00 00 00 ff 55 ff ff ff 00 00 00  ..*(.....U......
>   backtrace:
>     [<ffffffff9265fa36>] kmalloc_trace+0x26/0x90
>     [<ffffffffc17eec41>] rtw_usb_probe+0x2f1/0x680 [rtw_usb]
>     [<ffffffffc03e19fd>] usb_probe_interface+0xdd/0x2e0 [usbcore]
>     [<ffffffff92b4f2fe>] really_probe+0x18e/0x3d0
>     [<ffffffff92b4f5b8>] __driver_probe_device+0x78/0x160
>     [<ffffffff92b4f6bf>] driver_probe_device+0x1f/0x90
>     [<ffffffff92b4f8df>] __driver_attach+0xbf/0x1b0
>     [<ffffffff92b4d350>] bus_for_each_dev+0x70/0xc0
>     [<ffffffff92b4e51e>] bus_add_driver+0x10e/0x210
>     [<ffffffff92b50935>] driver_register+0x55/0xf0
>     [<ffffffffc03e0708>] usb_register_driver+0x88/0x140 [usbcore]
>     [<ffffffff92401153>] do_one_initcall+0x43/0x210
>     [<ffffffff9254f42a>] do_init_module+0x4a/0x200
>     [<ffffffff92551d1c>] __do_sys_finit_module+0xac/0x120
>     [<ffffffff92ee6626>] do_syscall_64+0x56/0x80
>     [<ffffffff9300006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> The leak was verified to be real by unloading the driver, which resulted
> in a dangling pointer to the allocation.
> 
> The allocated memory is freed in rtw_usb_intf_deinit().
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Ping-Ke Shih <pkshih@realtek.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

59a3a3120097 wifi: rtw88: Fix memory leak in rtw88_usb

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230417160331.23071-1-Larry.Finger@lwfinger.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


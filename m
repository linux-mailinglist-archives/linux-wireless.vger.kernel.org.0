Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F9E6F8ECE
	for <lists+linux-wireless@lfdr.de>; Sat,  6 May 2023 07:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjEFFxT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 May 2023 01:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjEFFxP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 May 2023 01:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE26749EC
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 22:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B3616150F
        for <linux-wireless@vger.kernel.org>; Sat,  6 May 2023 05:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13482C433EF;
        Sat,  6 May 2023 05:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683352393;
        bh=W030PvANOzs3nBm12RcWvesd1yXvpGyndBrGOIGjoEo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Uhz/XLFbyJtVOICNgTGKDYGjJWUFAMJoodhe4gpyrZgu4I7KFPp12LnR53QyNxiJS
         a+KP0XgmMf554s9E+3M8+ol1YRJ9/wZAfbbTGEPyrYKAqZ+tmkNqVOD3/IUqTJjZ0g
         erOz9Wf9b1k3/ochwTDypY1FNJkSEeDycUygaK2xJWHOec0YO2z+YTxxknT8S7rV77
         vkC8TwQT6R/gbstdo9FS0lvW61W9DTb98zrEcVgMiTMRADaL42V0OLnObCXn8Z6Ckq
         q3fRhhjvDXxprtet885RsNbms/+61xEn2UP//SoJ5e7FNbgS5RyZH64LY8OriuHVVz
         27xWv7fN0qdVQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Takeshi Misawa <jeantsuru.cumc.mandola@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH] wifi: ath9k: Fix memory leak in htc_connect_service
References: <ZFXk/AIKeapT72Pj@DESKTOP>
Date:   Sat, 06 May 2023 08:53:11 +0300
In-Reply-To: <ZFXk/AIKeapT72Pj@DESKTOP> (Takeshi Misawa's message of "Sat, 6
        May 2023 14:26:20 +0900")
Message-ID: <87o7myngzc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Takeshi Misawa <jeantsuru.cumc.mandola@gmail.com> writes:

> Timeout occurs in htc_connect_service(), then this function returns
> without freeing skb.
>
> Fix this by going to err path.
>
> syzbot report:
> BUG: memory leak
> unreferenced object 0xffff88810a980800 (size 240):
>   comm "kworker/1:1", pid 24, jiffies 4294947427 (age 16.220s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff83b971c6>] __alloc_skb+0x206/0x270 net/core/skbuff.c:552
>     [<ffffffff82eb3731>] alloc_skb include/linux/skbuff.h:1270 [inline]
>     [<ffffffff82eb3731>] htc_connect_service+0x121/0x230 drivers/net/wireless/ath/ath9k/htc_hst.c:259
>     [<ffffffff82ec03a5>] ath9k_htc_connect_svc drivers/net/wireless/ath/ath9k/htc_drv_init.c:137 [inline]
>     [<ffffffff82ec03a5>] ath9k_init_htc_services.constprop.0+0xe5/0x390 drivers/net/wireless/ath/ath9k/htc_drv_init.c:157
>     [<ffffffff82ec0747>] ath9k_htc_probe_device+0xf7/0x8a0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:959
>     [<ffffffff82eb3ef5>] ath9k_htc_hw_init+0x35/0x60 drivers/net/wireless/ath/ath9k/htc_hst.c:521
>     [<ffffffff82eb68dd>] ath9k_hif_usb_firmware_cb+0xcd/0x1f0 drivers/net/wireless/ath/ath9k/hif_usb.c:1243
>     [<ffffffff82aa835b>] request_firmware_work_func+0x4b/0x90 drivers/base/firmware_loader/main.c:1107
>     [<ffffffff8129a35a>] process_one_work+0x2ba/0x5f0 kernel/workqueue.c:2289
>     [<ffffffff8129ac7d>] worker_thread+0x5d/0x5b0 kernel/workqueue.c:2436
>     [<ffffffff812a4fa9>] kthread+0x129/0x170 kernel/kthread.c:376
>     [<ffffffff81002dcf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Link: https://syzkaller.appspot.com/bug?id=fbf138952d6c1115ba7d797cf7d56f6935184e3f
> Reported-and-tested-by: syzbot+b68fbebe56d8362907e8@syzkaller.appspotmail.com
> Signed-off-by: Takeshi Misawa <jeantsuru.cumc.mandola@gmail.com>

Then submitting a new version of the patch you should mark it as v2 and
include a changelog what changed from v1, more info in the wiki link
below. But no need to resubmit the patch because of this, just keep this
in mind for future patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

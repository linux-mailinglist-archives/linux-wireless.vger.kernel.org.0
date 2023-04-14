Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7396E232D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjDNMZp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDNMZo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:25:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA69754
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2877164752
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0990EC433EF;
        Fri, 14 Apr 2023 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475139;
        bh=7IP9G/VtjtScFq/iascdLFMc9DdzOOzrbwMwL6ETfqQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=AWfjUw/WEdJyG7v1MJ+DimkbBaaP2zuLcR8zUTuIJ1pH9+PDUMMpK0ufq4uBTFvWd
         f7jNgj5knLxU4ib7VHLO5bSJ8vdzHtmdveA7CijxyFsrA7kZUuj9uEDa09advDTnM+
         aK1wG+rYIoboyVsoRASDLw4IXXF4cdjW4kfkENadhfGSPK++xEgYCjhvlrND+JLji9
         FB5PWyQN0Z+l461d5uW9rNErmH3R9r8ahrMRoanXBeSxfOgZLfgl7EVikXlsNWI2+8
         xyEBe2CCG2nh083WrM3FA3wONJRKp3Gq5+nHeqoXKSVRdaRocZT5N0tYPuFcu06x1R
         8JtvvFZlSPknw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: fix crash due to null pointer of sta in AP
 mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230406093009.5869-1-pkshih@realtek.com>
References: <20230406093009.5869-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168147513695.16522.10395007780250244989.kvalo@kernel.org>
Date:   Fri, 14 Apr 2023 12:25:38 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> In AP mode, 'sta' could be NULL if sending broadcast/multicast packets,
> so we should check before accessing, or it causes crash:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000004
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP PTI
>   CPU: 2 PID: 92 Comm: kworker/u33:0 Tainted: G           OE
>   Workqueue: rtw89_tx_wq rtw89_core_txq_work [rtw89_core]
>   RIP: 0010:rtw89_core_tx_update_desc_info+0x2cc/0x7d0 [rtw89_core]
>   Code: e2 01 41 be 04 00 00 00 41 8b 84 c4 0c 01 00 00 75 0d 45 31 f6 ...
>   RSP: 0018:ffffb4cf807afce0 EFLAGS: 00010297
>   RAX: 0000000000000001 RBX: ffffb4cf807afd48 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
>   RBP: ffffb4cf807afd30 R08: ffff9b28c1e59808 R09: ffff9b28c0297100
>   R10: 00000000052cf7c4 R11: 00000000052cf7c4 R12: ffff9b28c1602040
>   R13: ffff9b28c07b3000 R14: 0000000000000004 R15: 0000000000000000
>   FS:  0000000000000000(0000) GS:ffff9b2a73280000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000004 CR3: 00000001ca410003 CR4: 00000000000606e0
>   Call Trace:
>    <TASK>
>    rtw89_core_tx_write+0x7c/0x100 [rtw89_core]
>    rtw89_core_txq_work+0x1b4/0x530 [rtw89_core]
>    process_one_work+0x222/0x3f0
>    worker_thread+0x50/0x3f0
>    kthread+0x16b/0x190
>    ? rescuer_thread+0x3a0/0x3a0
>    ? set_kthread_struct+0x50/0x50
>    ret_from_fork+0x22/0x30
>    </TASK>
> 
> Fixes: e5307c9cd7ee ("wifi: rtw89: set data lowest rate according to AP supported rate")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

8551844d2c5b wifi: rtw89: fix crash due to null pointer of sta in AP mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230406093009.5869-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


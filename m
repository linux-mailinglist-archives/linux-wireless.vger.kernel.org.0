Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E4866C7FF
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 17:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjAPQgC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 11:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjAPQfq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 11:35:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C241B30EA4
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 08:23:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F0E9B81063
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 16:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BF8C433EF;
        Mon, 16 Jan 2023 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673886218;
        bh=iTK3uPkHBp3l0r21Fez4dSiqj2YObpdTw89kxpjkb34=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZQ5mzhZyymh2hyX8lBq1HL5OS+yP/7lzZIAWK62WiRFGO0tt0k99xUsq6Mdq3AlsY
         PsU9oz9YPoG/SZpStq2okTbFTY1X9zACHGp8CklfNyl2imj/QE11OdA2PXvGQZTLbh
         ntbxTW4f6wuwnGe6p1+2VqBhN/Dzd0h2vvslg6BNWp/aRQwOYeqnFSIA4zW+OlhDMI
         bsFWR/KjPNmomPU3xcko9up/y8wYU5z4NZu2usgp1klTCK7fwUdkY7g2GuiyGYlyj8
         yIPCQhWR3jm11hdlVvniNclQ0RQYRqRnGkFu0hi53hy6MHKBFtoMhGYLjNs2BIIeUK
         mly3v2LwrTC/A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mt7601u: fix an integer underflow
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221229092906.2328282-1-jisoo.jang@yonsei.ac.kr>
References: <20221229092906.2328282-1-jisoo.jang@yonsei.ac.kr>
To:     Jisoo Jang <jisoo.jang@yonsei.ac.kr>
Cc:     kuba@kernel.org, linux-wireless@vger.kernel.org,
        linuxlovemin@yonsei.ac.kr, dokyungs@yonsei.ac.kr
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167388621444.5321.17829590741874090599.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 16:23:36 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jisoo Jang <jisoo.jang@yonsei.ac.kr> wrote:

> Fix an integer underflow that leads to a null pointer dereference in
> 'mt7601u_rx_skb_from_seg()'. The variable 'dma_len' in the URB packet
> could be manipulated, which could trigger an integer underflow of
> 'seg_len' in 'mt7601u_rx_process_seg()'. This underflow subsequently
> causes the 'bad_frame' checks in 'mt7601u_rx_skb_from_seg()' to be
> bypassed, eventually leading to a dereference of the pointer 'p', which
> is a null pointer.
> 
> Ensure that 'dma_len' is greater than 'min_seg_len'.
> 
> Found by a modified version of syzkaller.
> 
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 12 Comm: ksoftirqd/0 Tainted: G        W  O      5.14.0+
> #139
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> RIP: 0010:skb_add_rx_frag+0x143/0x370
> Code: e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 86 01 00 00 4c 8d 7d 08 44
> 89 68 08 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 <80> 3c 02
> 00 0f 85 cd 01 00 00 48 8b 45 08 a8 01 0f 85 3d 01 00 00
> RSP: 0018:ffffc900000cfc90 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff888115520dc0 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffff8881118430c0 RDI: ffff8881118430f8
> RBP: 0000000000000000 R08: 0000000000000e09 R09: 0000000000000010
> R10: ffff888111843017 R11: ffffed1022308602 R12: 0000000000000000
> R13: 0000000000000e09 R14: 0000000000000010 R15: 0000000000000008
> FS:  0000000000000000(0000) GS:ffff88811a800000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000004035af40 CR3: 00000001157f2000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  mt7601u_rx_tasklet+0xc73/0x1270
>  ? mt7601u_submit_rx_buf.isra.0+0x510/0x510
>  ? tasklet_action_common.isra.0+0x79/0x2f0
>  tasklet_action_common.isra.0+0x206/0x2f0
>  __do_softirq+0x1b5/0x880
>  ? tasklet_unlock+0x30/0x30
>  run_ksoftirqd+0x26/0x50
>  smpboot_thread_fn+0x34f/0x7d0
>  ? smpboot_register_percpu_thread+0x370/0x370
>  kthread+0x3a1/0x480
>  ? set_kthread_struct+0x120/0x120
>  ret_from_fork+0x1f/0x30
> Modules linked in: 88XXau(O) 88x2bu(O)
> ---[ end trace 57f34f93b4da0f9b ]---
> RIP: 0010:skb_add_rx_frag+0x143/0x370
> Code: e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 86 01 00 00 4c 8d 7d 08 44
> 89 68 08 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 <80> 3c 02
> 00 0f 85 cd 01 00 00 48 8b 45 08 a8 01 0f 85 3d 01 00 00
> RSP: 0018:ffffc900000cfc90 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff888115520dc0 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffff8881118430c0 RDI: ffff8881118430f8
> RBP: 0000000000000000 R08: 0000000000000e09 R09: 0000000000000010
> R10: ffff888111843017 R11: ffffed1022308602 R12: 0000000000000000
> R13: 0000000000000e09 R14: 0000000000000010 R15: 0000000000000008
> FS:  0000000000000000(0000) GS:ffff88811a800000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000004035af40 CR3: 00000001157f2000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> 
> Signed-off-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Patch applied to wireless-next.git, thanks.

803f3176c5df wifi: mt7601u: fix an integer underflow

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221229092906.2328282-1-jisoo.jang@yonsei.ac.kr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


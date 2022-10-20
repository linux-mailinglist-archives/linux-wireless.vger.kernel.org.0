Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486CE60552D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 03:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiJTBtQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 21:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJTBtO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 21:49:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA22B1D2985
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 18:49:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y191so18940029pfb.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 18:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5nmHSvHQDMtAL2AOSYcWXUKkW2yXG3QfLswGnstPfn0=;
        b=qNomfsGJ7Dj7yJ8rhDiyoAIsIQ/nc5ZMtypsNaL5tNmiAGYb3/M857R+07zJUjUTdE
         fN731TmYP8y+fOz0nbhWA527/4A5dCCMkgWyFW/rxrTCMWpno+oC30fCx2p9OEfbdpiJ
         B2FGxkp2P1XsVIumx5QLm+Ez1m6JfmU1i6g8yh/fwdveojcR5B3DrhYQ2p1jO2m1jXS3
         1F29wnY8QHyuCoEOTh7PYPLnd2eWztHLIAwKJ+3eySyDBD4movOVlGUg2KQEEGUnPwr8
         brchQsMsFVOUBTi6qxz06UAlySHvUuAH2AU/TowLpF8+o7v4DJjrPh6yDe9Bt8+znAGX
         7LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nmHSvHQDMtAL2AOSYcWXUKkW2yXG3QfLswGnstPfn0=;
        b=AnDjf3btztrSJf6XcYZc7okwKIL6s6hdqyC3PF4NO3gWxS2VTzUBx0IJ6zbVYmzqFk
         bnJMtKApHfL8CM5IAgZiNMGsIyxvOx1z8wV56BbvwskpZUoexBKWmEINcIP+b09vEbmM
         4Z6mHrPbQAbCss5Svcp5sziZY3mEmxllLxNNIU87TNQSOOBxZPXln6p9Rihob7y2Yjvc
         Ye3qd6G6hfYiPNeoCgbWdpuHh2iYOaXR5bwgyYUPQ4/fHFnKP5M2Rywr8S0t+WtuFQuv
         NswkiH6UwMrA/CBGwYjCiiq5GajoCyhxPnth42GonkMCGk63J/B7feYqtDkbXtaghuuZ
         +2vw==
X-Gm-Message-State: ACrzQf20Y7+1rRhgHH4xotGbJOj8XGbL4xXDFQQ5TXwXdyBbz099Fsgs
        SWqLU6nUIgdcrBpVuSHVQ2lxzoIoV3I=
X-Google-Smtp-Source: AMsMyM6kF6mT9mDhvjmeCKr/SJuVqJRaeKsG23+QvT607DZ9/tXkUfPEG2CocumHIJifVYfsX2e5fA==
X-Received: by 2002:a63:8549:0:b0:46e:99b8:4b36 with SMTP id u70-20020a638549000000b0046e99b84b36mr1007232pgd.138.1666230551604;
        Wed, 19 Oct 2022 18:49:11 -0700 (PDT)
Received: from laguna ([165.132.118.110])
        by smtp.gmail.com with ESMTPSA id q15-20020a65684f000000b0044ba7b39c2asm10499653pgt.60.2022.10.19.18.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:49:10 -0700 (PDT)
Date:   Thu, 20 Oct 2022 10:49:07 +0900
From:   Dokyung Song <dokyung.song@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH] brcmfmac: Fixes potential buffer overflow in
 'brcmf_fweh_event_worker'
Message-ID: <20221020014907.GA338234@laguna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch fixes an intra-object buffer overflow in brcmfmac that occurs
when the device provides a 'bsscfgidx' equal to or greater than the
buffer size. The patch adds a check that leads to a safe failure if that
is the case.

Found by a modified version of syzkaller.

UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index 52 is out of range for type 'brcmf_if *[16]'
CPU: 0 PID: 1898 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #132
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: events brcmf_fweh_event_worker
Call Trace:
 dump_stack_lvl+0x57/0x7d
 ubsan_epilogue+0x5/0x40
 __ubsan_handle_out_of_bounds+0x69/0x80
 ? memcpy+0x39/0x60
 brcmf_fweh_event_worker+0xae1/0xc00
 ? brcmf_fweh_call_event_handler.isra.0+0x100/0x100
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? lockdep_hardirqs_on_prepare+0x273/0x3e0
 process_one_work+0x873/0x13e0
 ? lock_release+0x640/0x640
 ? pwq_dec_nr_in_flight+0x320/0x320
 ? rwlock_bug.part.0+0x90/0x90
 worker_thread+0x8b/0xd10
 ? __kthread_parkme+0xd9/0x1d0
 ? process_one_work+0x13e0/0x13e0
 kthread+0x379/0x450
 ? _raw_spin_unlock_irq+0x24/0x30
 ? set_kthread_struct+0x100/0x100
 ret_from_fork+0x1f/0x30
================================================================================
general protection fault, probably for non-canonical address 0xe5601c0020023fff: 0000 [#1] SMP KASAN
KASAN: maybe wild-memory-access in range [0x2b0100010011fff8-0x2b0100010011ffff]
CPU: 0 PID: 1898 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #132
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: events brcmf_fweh_event_worker
RIP: 0010:brcmf_fweh_call_event_handler.isra.0+0x42/0x100
Code: 89 f5 53 48 89 fb 48 83 ec 08 e8 79 0b 38 fe 48 85 ed 74 7e e8 6f 0b 38 fe 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 8b 00 00 00 4c 8b 7d 00 44 89 e0 48 ba 00 00 00
RSP: 0018:ffffc9000259fbd8 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff888115d8cd50 RCX: 0000000000000000
RDX: 0560200020023fff RSI: ffffffff8304bc91 RDI: ffff888115d8cd50
RBP: 2b0100010011ffff R08: ffff888112340050 R09: ffffed1023549809
R10: ffff88811aa4c047 R11: ffffed1023549808 R12: 0000000000000045
R13: ffffc9000259fca0 R14: ffff888112340050 R15: ffff888112340000
FS:  0000000000000000(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000004053ccc0 CR3: 0000000112740000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 brcmf_fweh_event_worker+0x117/0xc00
 ? brcmf_fweh_call_event_handler.isra.0+0x100/0x100
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? lockdep_hardirqs_on_prepare+0x273/0x3e0
 process_one_work+0x873/0x13e0
 ? lock_release+0x640/0x640
 ? pwq_dec_nr_in_flight+0x320/0x320
 ? rwlock_bug.part.0+0x90/0x90
 worker_thread+0x8b/0xd10
 ? __kthread_parkme+0xd9/0x1d0
 ? process_one_work+0x13e0/0x13e0
 kthread+0x379/0x450
 ? _raw_spin_unlock_irq+0x24/0x30
 ? set_kthread_struct+0x100/0x100
 ret_from_fork+0x1f/0x30
Modules linked in: 88XXau(O) 88x2bu(O)
---[ end trace 41d302138f3ff55a ]---
RIP: 0010:brcmf_fweh_call_event_handler.isra.0+0x42/0x100
Code: 89 f5 53 48 89 fb 48 83 ec 08 e8 79 0b 38 fe 48 85 ed 74 7e e8 6f 0b 38 fe 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 8b 00 00 00 4c 8b 7d 00 44 89 e0 48 ba 00 00 00
RSP: 0018:ffffc9000259fbd8 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff888115d8cd50 RCX: 0000000000000000
RDX: 0560200020023fff RSI: ffffffff8304bc91 RDI: ffff888115d8cd50
RBP: 2b0100010011ffff R08: ffff888112340050 R09: ffffed1023549809
R10: ffff88811aa4c047 R11: ffffed1023549808 R12: 0000000000000045
R13: ffffc9000259fca0 R14: ffff888112340050 R15: ffff888112340000
FS:  0000000000000000(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000004053ccc0 CR3: 0000000112740000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Kernel panic - not syncing: Fatal exception

Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Signed-off-by: Dokyung Song <dokyung.song@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index bc3f4e4edcdf..e035e9c5a1fa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -255,10 +255,15 @@ static void brcmf_fweh_event_worker(struct work_struct *work)
 			goto event_free;
 		}
 
-		if (event->code == BRCMF_E_TDLS_PEER_EVENT)
+		if (event->code == BRCMF_E_TDLS_PEER_EVENT) {
 			ifp = drvr->iflist[0];
-		else
+		} else {
+			if (emsg.bsscfgidx >= BRCMF_MAX_IFS) {
+				bphy_err(drvr, "invalid bsscfg index: %u\n", emsg.bsscfgidx);
+				goto event_free;
+			}
 			ifp = drvr->iflist[emsg.bsscfgidx];
+		}
 		err = brcmf_fweh_call_event_handler(drvr, ifp, event->code,
 						    &emsg, event->data);
 		if (err) {
-- 
2.25.1


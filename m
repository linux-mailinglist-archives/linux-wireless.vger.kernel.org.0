Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1F3605E2D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 12:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJTKuE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJTKuB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 06:50:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B158512
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 03:49:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p6so700955plr.7
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKAaogby7khkDAgajEx0ttTFfLYhJzZ3DUWjgFXgPos=;
        b=Y5SNTQDtm+prHxBfmSkI6eIYcW7QFrtJuXszqrB1+tgj/5z4Mp+M2cbULsqcluWvyY
         bFsDmcbACogtngpqiR+mRw6cWgNMu7Bs3VJ8JZ/g802e8R0IIORPOGk7OH5gF08weZb5
         AE0jREnTuYw9zYgUJDYCoiUJP86a4R8ZMFfgDERPa5hMCwJP40vGPGShfZ9xBzOyk+eu
         hXHCaFVTT2DAsaFXc9razppYuuhKI2Jitq8bD3I1FCrC7RIM4ymlp8OuI0sAjpbncF58
         TeQjqNPUlpakJIAXq1CGZDz5BjRfRBYDOfZFwuaLjB7G6LyYs1KaNoFoEtrofR20D/2I
         A5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKAaogby7khkDAgajEx0ttTFfLYhJzZ3DUWjgFXgPos=;
        b=nhzJ5ywswXnJ010utfsvLXt7CZy3IfBUh7htOlMngMj5kXA6WGGUlFKQdiSmAFmkNR
         TIbIja1k0I9NTpZTHBNlGPbLIcR1scPw9rVq+B5z+tXIv0+d99ipOR6Nu67HBJTP8dVK
         NYLg0Dw37OqXnxt6CxrLGsOAjlA8wJ8XxGHaeORUq0OnfCHHKDZPs/KbROl2mDeJDctl
         xpEBWFIpnwsdQX+e0aj2RkWgY9AzrZKnCh+K1lJD2hZ3pAc/gCnHzbujgqUEEGnDaeaJ
         6SkXAONw1kcRxJ2RAfY9/OrezkTQQoGDZT0DC/oGceRg/Jp1xN2cr0tKGB6IjIZqSudf
         9hOw==
X-Gm-Message-State: ACrzQf3uQFJm30kqlQo7SWfgoxG4jjEpe/0tqOLRdy2LJXjlJtWMSZG9
        LWldt9A6/EnyONgBssmi01uQ5cqMs+K/tw==
X-Google-Smtp-Source: AMsMyM60FUtS/4fmStU3t6Sqwzpbe4NySwcRbQt93RGrGCaypDU/ZDBewalp9Lf+Dd8CkBTI88MrUA==
X-Received: by 2002:a17:902:b210:b0:17d:c3ca:4a4f with SMTP id t16-20020a170902b21000b0017dc3ca4a4fmr12954170plr.33.1666262998317;
        Thu, 20 Oct 2022 03:49:58 -0700 (PDT)
Received: from laguna ([165.132.118.110])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b00177f82f0789sm1473292pln.198.2022.10.20.03.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 03:49:57 -0700 (PDT)
Date:   Thu, 20 Oct 2022 19:49:54 +0900
From:   Dokyung Song <dokyung.song@gmail.com>
To:     linux-wireless@vger.kernel.org,
        Arend Van Spriel <aspriel@gmail.com>
Cc:     Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH v2] brcmfmac: Fixes potential buffer overflow in
 'brcmf_fweh_event_worker'
Message-ID: <20221020104954.GA461052@laguna>
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
Reviewed-by: Arend van Spriel <aspriel@gmail.com>
Signed-off-by: Dokyung Song <dokyung.song@gmail.com>
---
v1->v2: Addressed review comments

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index bc3f4e4edcdf..dac7eb77799b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -228,6 +228,10 @@ static void brcmf_fweh_event_worker(struct work_struct *work)
 			  brcmf_fweh_event_name(event->code), event->code,
 			  event->emsg.ifidx, event->emsg.bsscfgidx,
 			  event->emsg.addr);
+		if (event->emsg.bsscfgidx >= BRCMF_MAX_IFS) {
+			bphy_err(drvr, "invalid bsscfg index: %u\n", event->emsg.bsscfgidx);
+			goto event_free;
+		}
 
 		/* convert event message */
 		emsg_be = &event->emsg;
-- 
2.25.1


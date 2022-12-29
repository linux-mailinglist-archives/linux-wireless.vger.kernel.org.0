Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487E6658AF8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Dec 2022 10:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiL2J3S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Dec 2022 04:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiL2J3R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Dec 2022 04:29:17 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD7C2EE
        for <linux-wireless@vger.kernel.org>; Thu, 29 Dec 2022 01:29:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b2so18429035pld.7
        for <linux-wireless@vger.kernel.org>; Thu, 29 Dec 2022 01:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s02EqTuuar1mLxKZFLzBNwSt37MvPzqQUdjnZxhME8o=;
        b=tB6cLkoShZf5r09FgN2oh3KI6TrMQrvxy/BPNgqfHThJoMwIke/whBXeKDc86Vbf+O
         Ca2pggb3toIr4LOjfgEKItuKkmPgCs9HP4rBnm6ZGEmhurgI5ILl08COLt5C0T1tDB6j
         6ukYw44wgYxr12WCcLyFep8/6af0nGcPGshybeCyWq/hfE2EvIACgx/JNyhoNClYkJiF
         bVuiRWbH5MysldQ21a9EDvLrt5FLuKvnO81wbpWWFTcMy8BGNNu4C+AABZ1FBBwrKeB1
         48Sh8PFSs72AUyYaqdPb5MljL8PA9On6G/kn5CG/9a8b6fHrWB9YXj60Jnhma6p4yABe
         NVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s02EqTuuar1mLxKZFLzBNwSt37MvPzqQUdjnZxhME8o=;
        b=ZMEvaeDC4rtP76uB3syTza+AvEoEkyljnRuuwYxWzHozwvg4MCryV2vMJ/GsWmRJf3
         SxngO7V/ZwkS1Jl9lG3zl8NlHgETgFLfXXQwMCWuzqrxC9MK45Dhzl91eE/BTYZbTzv9
         I+qXgcgJFNhQPJR4koCnYcFGdMn0fb3HLI5TqR23ZH7f6/427WyF8gJBrb3rHpSEUTv2
         7+8xt6EiGkPcZgLY3fIM62Wc50nwu8+KM/L5SfEwB/ySEgG3F/DnU+XvAKKsNwHbhn5j
         ij2JInRrVgj6DIMLWOJyLr3MnBy0nHBMTr/Vxix7eWLckF1AMU+vSAtYkYj78UzY9x2/
         14Jg==
X-Gm-Message-State: AFqh2kpr/te9j+HJNfa3SDPVail9Pk8iFbCrTqWWV5KpmL5fBaFBrv/6
        /b28wBvTcRjGcQMo12HlJYKo
X-Google-Smtp-Source: AMrXdXsbG1Zb6j5wOnwtY3Uwu0TlmVEoezcmqMJX/Y7QSl35gR0eZBi19pMbW+eFNC2/y3NAjFzvNg==
X-Received: by 2002:a05:6a20:8414:b0:b3:87f8:8386 with SMTP id c20-20020a056a20841400b000b387f88386mr14200821pzd.24.1672306150613;
        Thu, 29 Dec 2022 01:29:10 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.55])
        by smtp.gmail.com with ESMTPSA id d5-20020a63f245000000b004702eca61fcsm986552pgk.36.2022.12.29.01.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:29:10 -0800 (PST)
From:   Jisoo Jang <jisoo.jang@yonsei.ac.kr>
To:     kuba@kernel.org, linux-wireless@vger.kernel.org
Cc:     linuxlovemin@yonsei.ac.kr, dokyungs@yonsei.ac.kr
Subject: [PATCH] wifi: mt7601u: fix an integer underflow
Date:   Thu, 29 Dec 2022 18:29:06 +0900
Message-Id: <20221229092906.2328282-1-jisoo.jang@yonsei.ac.kr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix an integer underflow that leads to a null pointer dereference in
'mt7601u_rx_skb_from_seg()'. The variable 'dma_len' in the URB packet
could be manipulated, which could trigger an integer underflow of
'seg_len' in 'mt7601u_rx_process_seg()'. This underflow subsequently
causes the 'bad_frame' checks in 'mt7601u_rx_skb_from_seg()' to be
bypassed, eventually leading to a dereference of the pointer 'p', which
is a null pointer.

Ensure that 'dma_len' is greater than 'min_seg_len'.

Found by a modified version of syzkaller.

KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 12 Comm: ksoftirqd/0 Tainted: G        W  O      5.14.0+
#139
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
RIP: 0010:skb_add_rx_frag+0x143/0x370
Code: e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 86 01 00 00 4c 8d 7d 08 44
89 68 08 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 <80> 3c 02
00 0f 85 cd 01 00 00 48 8b 45 08 a8 01 0f 85 3d 01 00 00
RSP: 0018:ffffc900000cfc90 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888115520dc0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff8881118430c0 RDI: ffff8881118430f8
RBP: 0000000000000000 R08: 0000000000000e09 R09: 0000000000000010
R10: ffff888111843017 R11: ffffed1022308602 R12: 0000000000000000
R13: 0000000000000e09 R14: 0000000000000010 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff88811a800000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000004035af40 CR3: 00000001157f2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 mt7601u_rx_tasklet+0xc73/0x1270
 ? mt7601u_submit_rx_buf.isra.0+0x510/0x510
 ? tasklet_action_common.isra.0+0x79/0x2f0
 tasklet_action_common.isra.0+0x206/0x2f0
 __do_softirq+0x1b5/0x880
 ? tasklet_unlock+0x30/0x30
 run_ksoftirqd+0x26/0x50
 smpboot_thread_fn+0x34f/0x7d0
 ? smpboot_register_percpu_thread+0x370/0x370
 kthread+0x3a1/0x480
 ? set_kthread_struct+0x120/0x120
 ret_from_fork+0x1f/0x30
Modules linked in: 88XXau(O) 88x2bu(O)
---[ end trace 57f34f93b4da0f9b ]---
RIP: 0010:skb_add_rx_frag+0x143/0x370
Code: e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 86 01 00 00 4c 8d 7d 08 44
89 68 08 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 <80> 3c 02
00 0f 85 cd 01 00 00 48 8b 45 08 a8 01 0f 85 3d 01 00 00
RSP: 0018:ffffc900000cfc90 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888115520dc0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff8881118430c0 RDI: ffff8881118430f8
RBP: 0000000000000000 R08: 0000000000000e09 R09: 0000000000000010
R10: ffff888111843017 R11: ffffed1022308602 R12: 0000000000000000
R13: 0000000000000e09 R14: 0000000000000010 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff88811a800000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000004035af40 CR3: 00000001157f2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554

Signed-off-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
---
 drivers/net/wireless/mediatek/mt7601u/dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
index 457147394edc..773a1cc2f852 100644
--- a/drivers/net/wireless/mediatek/mt7601u/dma.c
+++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
@@ -123,7 +123,8 @@ static u16 mt7601u_rx_next_seg_len(u8 *data, u32 data_len)
 	if (data_len < min_seg_len ||
 	    WARN_ON_ONCE(!dma_len) ||
 	    WARN_ON_ONCE(dma_len + MT_DMA_HDRS > data_len) ||
-	    WARN_ON_ONCE(dma_len & 0x3))
+	    WARN_ON_ONCE(dma_len & 0x3) ||
+	    WARN_ON_ONCE(dma_len < min_seg_len))
 		return 0;
 
 	return MT_DMA_HDRS + dma_len;
-- 
2.25.1


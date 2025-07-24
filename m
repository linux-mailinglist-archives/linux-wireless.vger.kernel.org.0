Return-Path: <linux-wireless+bounces-25977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94145B1017F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B08BE7B1EE2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 07:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516D229B13;
	Thu, 24 Jul 2025 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSJyqgZ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC63223338;
	Thu, 24 Jul 2025 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341385; cv=none; b=KE8DlSdN2jte/T3oF7/DCfSldcMY36v0CnDXL39WLSUTWiaUbokNnPVBg+YcXmdb/y5OTcXGQLTRDk21PZSnY2Wn1MGowZn4PJgDjikFTa626S7+sl2LCcZHCsTTCTefQKnLFdmQMGD20W98itqxbHc3hh0shufKbP5k7ZJutOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341385; c=relaxed/simple;
	bh=0khS5Od5JNQ5OBlyDOdVMQSefAEDqH4ZMOiV+ASnZQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I32X/yasto3QL1ePmRcQZbOfTRAWrG8GT0beIx3Ryb25igRUVzKCEcYLFchIUI/4vc7x6D3rVCnuT3uR/gmCC1Gfp2jMZlH2Gvsuc6bGEewIEhfr8NSkEp9pUBCVKwSOMGPwMX+07HU1MzSDJ7lIdQZRdS6wu+gkqq4lBKoLcJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSJyqgZ3; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b34a71d9208so561438a12.3;
        Thu, 24 Jul 2025 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753341383; x=1753946183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+pBXaBC4thHCGg8xZLGs4VB3wl45E9HVmRIrCsHy0g=;
        b=JSJyqgZ3HSBzu7GuZtxpHDnLR0cbMM1bhj0kdJvdtcNKg9PTpXq9jczJtuI/HidbWz
         BSKQsXVIi999uBh3BTbtwwYmm++4N2p1migzZh0NOVq7Mf9F/uQr37FCwRgJyehaR3WM
         gYj95uZ3tH/0oCuuKGlwEo/5v9NkuPzp1r1c5Ib37DArUnNUk0htk/IoqDyKqvB6RBdM
         Dkbj6fwg25pVjaY+hPxYBL6Hd4Fa2geqj1GGj+liq0CTfHp2zXPWD6w0QmS75+HVlkuw
         HK+u5vtq7BP/D9qKmD5E/hAYL/9W+rkTkSLS9S5IPT1HWvwDQpvBnd6oeiTgaFQQx5s9
         2e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753341383; x=1753946183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+pBXaBC4thHCGg8xZLGs4VB3wl45E9HVmRIrCsHy0g=;
        b=YoCE3EWcC/OS5NXjzRa3oIPuuG5gkoZu0SnH0OmVm3ZizCOVkAMPJCIPHt0gJ6Fk7x
         nGduSBhu+6LLfGSdgNUzV9wZnYcL3pfhgxfNCLacy3L6uitUkzf2EY1BPqHxknNs82OX
         bRg2pH35ZH9FzisxsoYNJfhNeoNYgQUL5LvJdO5fXgM8FHgBYC5hgSs1KsRmFip0/LIJ
         4FtEkfoyxPR4AxYhWCHb40pjrdECiVZoGjEqkl5P/svxTgWNPwNsnr8mA+px+nfGrsKB
         lpbwackQWYyokIQgj/kW4YfBdiWaXrHlSh7Pmluj4Z2OILqzh/MLkTgkM0VthBYcQFPF
         gWMg==
X-Forwarded-Encrypted: i=1; AJvYcCVHoSakoejy8dLg7el23wgGARIiAy6G2qLPNVSw0xdeBdv8wqVasiyxcet8yeFnH8eTyXWbjp91@vger.kernel.org, AJvYcCXFHJDWTk0PNtQ118EQwBy5c5kM4L/uFhOnnVsG680F54x3bImbvYELhaSkJH/Koygy/uMvbK/c2ex9by7kBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89qJxZQz7/+16/dDntpfZyRsQ9+G1qK5spX7aSmDPE/ZHBGRj
	tvxkfz8Z/A/O80TCR7mGTBYRwZhWZ/H9ZjBW6TCY9Tme0liq9lXorUfBUZiD/TRavYY=
X-Gm-Gg: ASbGncuTUbMNhyKgiffFuP/nVheN+TiG8gVkMSczdSalaYOkvCK5sf9hu0DR+6GaFQW
	JB2xnsW0LxpwNRI4n4F8zruMc0VBcul6EpSAcqyu296ZstJap1eB0QLt0z/6CPyQvb27zZ5LMK3
	akmSk38WPeb0V9pcM5i1e/ARNj+7tQW0M4FMRCF8x0K/EWNs88EC5RrEqOFwjC5PTukNx4Ai4oF
	j1giZXOyAJNr9x13Yjc7LsXah4BR8+DXNI5Ywjlnm8H+Y/0znX+zzff2WD3BVMuxSZiZ9mQaCrt
	bs59huZww2VCj+cK+VTqmovr4+qan2isl5p39cK2xlTW/EQMyju59sEXdry/fOW9v5BPCCrCFrW
	ej2GxrBvIxQnheP7fT91n7nweFLVQ+x5IzNS1+xIAdFiQvlKJ/5LC3+3f5dEDdbfxD2PcgE5pXl
	3zIzdL
X-Google-Smtp-Source: AGHT+IHfRSZUMalLXZzQKyYAAeuiOMRvoADeSlcMHAawhzP/6EKV+0VnEn6NwK+WzvRXXBIOyXe89w==
X-Received: by 2002:a17:90b:35d1:b0:312:26d9:d5b4 with SMTP id 98e67ed59e1d1-31e50818b0emr9852336a91.17.1753341383147;
        Thu, 24 Jul 2025 00:16:23 -0700 (PDT)
Received: from p920.moonheelee.internal (d173-180-147-14.bchsia.telus.net. [173.180.147.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e662f4953sm637253a91.34.2025.07.24.00.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:16:22 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH wireless-next] wifi: mac80211: fix use-after-free risk in sta debugfs removal
Date: Thu, 24 Jul 2025 00:15:56 -0700
Message-ID: <20250724071555.442634-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NULL pointer dereference may occur in ieee80211_sta_debugfs_remove()
when debugfs_remove_recursive() is called on a dentry whose inode has
already been freed. This can happen due to a race between STA teardown
and debugfs cleanup.

Fix this by checking that both sta->debugfs_dir and its d_inode are
valid before invoking debugfs_remove_recursive().

This avoids the crash reported in syzbot bug:

  wlan1: send auth to aa:09:b7:99:c0:d7 (try 2/3)
  wlan1: send auth to aa:09:b7:99:c0:d7 (try 3/3)
  wlan1: authentication with aa:09:b7:99:c0:d7 timed out
  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000029: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000148-0x000000000000014f]
  CPU: 0 UID: 0 PID: 171 Comm: kworker/u4:4 Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
  Workqueue: events_unbound cfg80211_wiphy_work
  RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
  Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f   92 c0 c3 cc cc cc cc cc 66 66 66 66 66 66 2e
  RSP: 0018:ffffc90001977400 EFLAGS: 00010202
  RAX: dffffc0000000000 RBX: ffffffff8b713286 RCX: ca5c1933e35f3700
  RDX: 0000000000000000 RSI: ffffffff8b713286 RDI: 0000000000000029
  RBP: ffffffff824067f0 R08: 0000000000000001 R09: 0000000000000000
  R10: dffffc0000000000 R11: ffffed10085cf24c R12: 0000000000000000
  R13: 0000000000000148 R14: 0000000000000148 R15: 0000000000000001
  FS:  0000000000000000(0000) GS:ffff88808d218000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000001b2f55ffff CR3: 000000005030a000 CR4: 0000000000352ef0
  Call Trace:
   <TASK>
   __kasan_check_byte+0x12/0x40 mm/kasan/common.c:556
   kasan_check_byte include/linux/kasan.h:399 [inline]
   lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5845
   down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
   inode_lock include/linux/fs.h:869 [inline]
   simple_recursive_removal+0x90/0x690 fs/libfs.c:616
   debugfs_remove+0x5b/0x70 fs/debugfs/inode.c:805
   ieee80211_sta_debugfs_remove+0x40/0x70 net/mac80211/debugfs_sta.c:1279
   __sta_info_destroy_part2+0x352/0x450 net/mac80211/sta_info.c:1501
   __sta_info_destroy net/mac80211/sta_info.c:1517 [inline]
   sta_info_destroy_addr+0xf5/0x140 net/mac80211/sta_info.c:1529
   ieee80211_destroy_auth_data+0x12d/0x260 net/mac80211/mlme.c:4597
   ieee80211_sta_work+0x11cf/0x3600 net/mac80211/mlme.c:8310
   cfg80211_wiphy_work+0x2df/0x460 net/wireless/core.c:435
   process_one_work kernel/workqueue.c:3238 [inline]
   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
   kthread+0x70e/0x8a0 kernel/kthread.c:464
   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   </TASK>

Reported-by: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d6ccd49ae046542a0641
Fixes: fc4a25c5b741 ("mac80211: remove sta_info debugfs sub-struct")
Tested-by: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 net/mac80211/debugfs_sta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 49061bd4151b..912b69abab52 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -1276,7 +1276,8 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 
 void ieee80211_sta_debugfs_remove(struct sta_info *sta)
 {
-	debugfs_remove_recursive(sta->debugfs_dir);
+	if (sta->debugfs_dir && sta->debugfs_dir->d_inode)
+		debugfs_remove_recursive(sta->debugfs_dir);
 	sta->debugfs_dir = NULL;
 }
 
-- 
2.43.0



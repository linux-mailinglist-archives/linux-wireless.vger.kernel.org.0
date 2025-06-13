Return-Path: <linux-wireless+bounces-24087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9715AD8201
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 05:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39AA1893923
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 03:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A81227EB9;
	Fri, 13 Jun 2025 03:55:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0C1F9F70
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749786930; cv=none; b=fH+Q2k3PAwc8JjJnrU5BHapeKBHWTQOZCH6n6kCb5/ldBEf4TQU5I3Mb+IUFL0zQSeBVl9uFOvOZMALAVUgow72AJDfo7y9Jm5mqr9+aeCI5PHgVOYZWmzUNt1oR4DqRxCHIgsGCxur2W+PLcCdvrrIaLb21lCfakqe0fQDgiWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749786930; c=relaxed/simple;
	bh=qY03oD9pQAa3IISvj8XLNNgFgADXWwWNPfESJaGE2fI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AH1aDjEMB/JQp17L3ON/eV/6+qNjiqK57GT/DNk0e6CJ3gXOiPZsNhTBSHjNLVYXqqdTrsval+czpzkbhUPg/C1mgv6zWx5uH8ibds/jmEDvNR0ZYZCwUcANeVK2uPC5bSN0JmXWXcDimdPeVEVICblXt8inOsNC8AlXK1u5MpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddc65f95b8so35393165ab.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 20:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749786927; x=1750391727;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yb6avLsT0g3rzbxvD4mRQdkm7OEs0CmFViXGqnZt+8Y=;
        b=KEWiN+GkwMzI+3p4RKRz6qvclpcTTdKnLEil3lF2Rvc1VD+0KaiK3pNTUhHJa9e9at
         k+ATChG/pmpO0/ACCAMIIuCf5yRcuQC2VWMKH38xEItXpsCxfXrOcxdroWqoFqeE91ry
         iWn7ezaL9EtvPr8A1dhaFO80vXh2teZLHPyEzys9AEh0be9CMwtguDeBcuGhPx54qHxU
         qoV8pgBmNaYn9tdyTS4ri4Bqx48XiQxF7uaMEChXbfMNhZUI02w9B+rX5ZxYWDNBeGax
         +VNOdyQxCpkE+T+MXpMid3yMA3V11EzeG40tM7YRMSIg+nZ4QY6FDnlXydJAdddIH6t2
         7utg==
X-Forwarded-Encrypted: i=1; AJvYcCUoK01SZz6ct5w05rAiAa1oTYMpjaKbwskE6YlYOFhzE8mxpTRnOd8KH+W0jMYqnw+jrtsQnH6D0ib7X99PCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIYfA1KQkv4AD09ePzL+t8TcqWhlebyTdLqjHzzetcTMwrxtAC
	TNWhVifgH2L5otP0ZFuYDudkAPun40k6qNFgdum9HxGYr5E2kz5/ntug8kMzAdxFroi3UjmTI4O
	aaw/yY43dxSmVmwwumwMUXNSDjmuQQIXRrDiryxVxTrsbl6Yx2+p4H8jne9A=
X-Google-Smtp-Source: AGHT+IHNPlWbZSAWP23VXzSrk/tytzpAvA08+936W284FJ25YUje6mGEdssB07Y9vzuRXRwdiGS0y0MW8EffxLxNZgO2wBqfceBX
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:3dc:87c7:a5b5 with SMTP id
 e9e14a558f8ab-3de00ad78d0mr16418475ab.3.1749786927736; Thu, 12 Jun 2025
 20:55:27 -0700 (PDT)
Date: Thu, 12 Jun 2025 20:55:27 -0700
In-Reply-To: <000000000000dbcd0f061f911231@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684ba12f.a00a0220.279073.0009.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in cfg80211_scan_done
From: syzbot <syzbot+189dcafc06865d38178d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    19272b37aa4f Linux 6.16-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10e239d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8409c4d4e51ac27
dashboard link: https://syzkaller.appspot.com/bug?extid=189dcafc06865d38178d
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e239d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92d22b0c6493/disk-19272b37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fb0142bb63a/vmlinux-19272b37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d5f3836ae42/Image-19272b37.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+189dcafc06865d38178d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 2225 at net/wireless/scan.c:1182 cfg80211_scan_done+0x2c8/0x4b0 net/wireless/scan.c:1181
Modules linked in:
CPU: 1 UID: 0 PID: 2225 Comm: kworker/u8:12 Not tainted 6.16.0-rc1-syzkaller-g19272b37aa4f #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: events_unbound cfg80211_wiphy_work
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : cfg80211_scan_done+0x2c8/0x4b0 net/wireless/scan.c:1181
lr : cfg80211_scan_done+0x2c8/0x4b0 net/wireless/scan.c:1181
sp : ffff8000a14d77c0
x29: ffff8000a14d7820 x28: ffff0000c7570700 x27: 1fffe00019a1e20c
x26: 1ffff0001429aef8 x25: dfff800000000000 x24: ffff0000c75701b8
x23: ffff0000cd0f1060 x22: ffff0000c75729f0 x21: ffff0000cd0f1070
x20: ffff8000a14d77e0 x19: ffff0000cd0f1000 x18: 1fffe00033807876
x17: ffff80008f55e000 x16: ffff80008ae5617c x15: 0000000000000002
x14: 1ffff0001429aefc x13: 0000000000000000 x12: 0000000000000000
x11: ffff70001429aefe x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000cc293d00 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff8000a14d77f0 x4 : ffff0000cd0f1080 x3 : ffff80008a530eec
x2 : 0000000000000010 x1 : ffff80008b492da0 x0 : 0000000000000001
Call trace:
 cfg80211_scan_done+0x2c8/0x4b0 net/wireless/scan.c:1181 (P)
 __ieee80211_scan_completed+0x4ec/0xae0 net/mac80211/scan.c:501
 ieee80211_scan_work+0x140/0x18c4 net/mac80211/scan.c:1177
 cfg80211_wiphy_work+0x2a8/0x48c net/wireless/core.c:435
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3402
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
irq event stamp: 1301622
hardirqs last  enabled at (1301621): [<ffff8000830764a8>] class_irqsave_destructor include/linux/irqflags.h:266 [inline]
hardirqs last  enabled at (1301621): [<ffff8000830764a8>] __free_object+0x528/0x71c lib/debugobjects.c:524
hardirqs last disabled at (1301622): [<ffff80008ae5160c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:511
softirqs last  enabled at (1301568): [<ffff80008644576c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (1301568): [<ffff80008644576c>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
softirqs last  enabled at (1301568): [<ffff80008644576c>] nsim_dev_trap_report_work+0x67c/0x9fc drivers/net/netdevsim/dev.c:851
softirqs last disabled at (1301566): [<ffff8000864456e4>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (1301566): [<ffff8000864456e4>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:816 [inline]
softirqs last disabled at (1301566): [<ffff8000864456e4>] nsim_dev_trap_report_work+0x5f4/0x9fc drivers/net/netdevsim/dev.c:851
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


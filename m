Return-Path: <linux-wireless+bounces-21271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0C5A80DB6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F46D189F98D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B5D1D5CCD;
	Tue,  8 Apr 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVKwoREK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA551D7E50;
	Tue,  8 Apr 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121902; cv=none; b=jol15ybvVeZ15plirnKY0orqalThbNEuz2BWAD8ugTWSqvnQ4gSmPmuxjrsw5wBNrGIQhHPEFWKMz/7k6CRWNXskjekg/2uQtCR4KlstbxTiUcAYjLFdt13of+gCTQ1SBdHL+KOMxTi7bjYT+GVQIXbQLvIUT0VrSCb4Kyq9PJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121902; c=relaxed/simple;
	bh=VqHdVrhnWxsG2WFRn+D29hxb42dbm8U++BuJbJO/L8Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8sbVZ+Oe0S3/33DbNK2nOGlkVdNgAABauM7QhlkjDE9Li/uvv00KEtUGna9fdvCvwgxzNTBNkO9TiAmTiTLCoqvYWAJ1cZvZ8oCHY7+0xAgwH+fJAvDzM7tSATS3jD7TqQjuOACnedQaKunkP7XVqhwlXusSswZSQ9YxqrsneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVKwoREK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a823036so52283375e9.0;
        Tue, 08 Apr 2025 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744121899; x=1744726699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bq7rxg4Ac1YnglamO5gdlT02ySoE7jAKulc1nQkYOcU=;
        b=YVKwoREKdW8txblIV/eAGchWgsPkLit/8ffT/jZAUOns8BQpfwi42YPrFRK+0uu2L+
         ErgyFJF1bCwSUHlEtsu1tOXT4ThE769aD2GsX+eDJ22yvAIzOiboRCl4s/2L/r0K1Xh2
         HmCtDEKkjD+f1FfRjUyxacyu6lit2xUP4M8QImGqwn4PGu4XV3xS6WwTBqdaz6+ct8I2
         Z5B0+L+WbVE/GlSX2FHgWA9XOVID5JshHkSIPrGxmJ+qj1AUy6NLR5Blp5/9zpNIWngj
         ZhBO5Po046Mf6Ev4XBIIXOCiAITcpFTynA34tbgfPPjncAQkec9oHerf7kD7YV0CqX07
         qSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744121899; x=1744726699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq7rxg4Ac1YnglamO5gdlT02ySoE7jAKulc1nQkYOcU=;
        b=KFfVqNPM3oLZWhrn84GxDwSBuzZxpXOoveP0pvBIXgND3dXOSVUCS2Xhi7ZawWZGyF
         hXChLaNktqYFkNOCMKdmyoq7m1sGp5A+tHUppcunrN/aSwfq4H2Il3RP2OvjyhwDadYc
         2k7gNb2VwBnjexv+sqrkPPdsPgej7p7vwYx/UTJue5TxHEllcvc/LVLC2cInnNZmkESA
         Wi3IKURhhBAdNEE4kBbc7kIGQxylvBz3F0Xhwz7tg+u9B7wyqp5e5PZjkvN1SrErCtwb
         VlGSoher/RLORihLjaSbz1QrzkM0+8+Efo09K4P8iHbfc3Tqmiy/FzUmDznzh7Zfr3UF
         HDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqQpPkN7TkqSwwiV2sYyzQ+02djtUcqBSA+7moVW2HcoXfgZBmarQpXcgnHAw+os9hihHLpmu/@vger.kernel.org, AJvYcCWeXBQK2bC+lkuN/VMpXv48siLmJuyXthR2Lgr5V9sxv5PxVgjpE1XgpAfT4EnNl3sZ5l51+xw5TvEXOaSLIy4=@vger.kernel.org, AJvYcCXbQmFsvO7Qxoy72Q+eQmCYF5a/QH3LeHYLJ/SqhYowzVDyQh6CErh+XS06s2dnPkwM0QI0am6JEEw5Xu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoh5iwdcZtyGuCUsHt2CQfcTgZ1jnItMz7NC6Dj4bNvsDSPSD
	9Dt0Hj46Dxx4kOe2l+XqrptGRYSgZRqJGUOWhWDohfc1raofe3evqkn/Ow==
X-Gm-Gg: ASbGncsp/xke45h6/oFIIPmkdkh5bW1C4A/iiHVX9TTmIlRHNPO9+hcHgqodUsaVCKT
	1tPdsTd7ZUrz73JvHHYX2XtMPAVF5Q1X880eQb+TfbirZiVI0vO83jf07jBgpJfXc2Z74tMtamJ
	tpsgYgLWvcGt8aBxHoAAe/hSuwVxW/fzimTEY6uf469UNjJYXimji0pF2Jf1y7stofuS8ZsypCx
	1bpV7MgCwGn0IKwtlKhRKAaGtH7ODC0Ht37dH777O7ElRZrvxT/lcvKvJP17BJU1jCZcPrgWjVH
	Zqc2/ThKF47nCMFAaie0dIAGxirHaz6B3+x/lQomogsrwQc=
X-Google-Smtp-Source: AGHT+IGQCycoQDBJl+sBBS+lOvlIfmOAX6Au0jmRubX3LfX3aEl8R4I97yekR1uJdSOHb83yz8MAlg==
X-Received: by 2002:a05:600c:4f02:b0:43d:fa59:af98 with SMTP id 5b1f17b1804b1-43ee07807f5mr84941955e9.33.1744121898645;
        Tue, 08 Apr 2025 07:18:18 -0700 (PDT)
Received: from qasdev.system ([2a02:c7c:6696:8300:1609:5a2:140b:e92d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b0a38sm164573735e9.34.2025.04.08.07.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:18:18 -0700 (PDT)
Date: Tue, 8 Apr 2025 15:17:28 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] general protection fault in
 cfg80211_mlme_deauth
Message-ID: <Z_Uv-BhVqaK9HUdx@qasdev.system>
References: <67f50e3e.050a0220.396535.0561.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f50e3e.050a0220.396535.0561.GAE@google.com>

On Tue, Apr 08, 2025 at 04:53:34AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1284523f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=66996a2350ef05e0
> dashboard link: https://syzkaller.appspot.com/bug?extid=00778a9a557a2a5e1a33
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c9eb4c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179bbd98580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0af2f6be.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3fcfb8eefe4d/vmlinux-0af2f6be.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e06a39be2bd8/bzImage-0af2f6be.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+00778a9a557a2a5e1a33@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]

I done some analysis and it looks like during cfg80211_conn_work() the 
wdev->conn->params.bssid is NULL, this gets passed to cfg80211_conn_do_work() 
which hits the CFG80211_CONN_ASSOC_FAILED label of the switch statement where 
ether_addr_equal() compares the NULL bssid via ether_addr_equal().

Regards,
Qasim

> CPU: 0 UID: 0 PID: 4854 Comm: kworker/0:3 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: events cfg80211_conn_work
> RIP: 0010:ether_addr_equal include/linux/etherdevice.h:355 [inline]
> RIP: 0010:cfg80211_mlme_deauth+0x35a/0x940 net/wireless/mlme.c:514
> Code: 8d 9c 24 b0 00 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0 4c 8b 7c 24 28 0f 85 25 03 00 00 44 8b 23 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 2b 03 00 00 45 8b 37 48 8b 44 24 20 48
> RSP: 0018:ffffc90002cdf180 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff888045820e40 RCX: ffff888000b5c880
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc90002cdf268 R08: ffffffff8b8395d8 R09: 0000000000000003
> R10: 0000000000000009 R11: ffff888000b5c880 R12: 0000000000000000
> R13: dffffc0000000000 R14: 0000000000000003 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f25d8438198 CR3: 000000001f4b4000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  cfg80211_conn_do_work+0x369/0xed0 net/wireless/sme.c:229
>  cfg80211_conn_work+0x2c2/0x530 net/wireless/sme.c:273
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
>  worker_thread+0x870/0xd50 kernel/workqueue.c:3400
>  kthread+0x7b7/0x940 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:ether_addr_equal include/linux/etherdevice.h:355 [inline]
> RIP: 0010:cfg80211_mlme_deauth+0x35a/0x940 net/wireless/mlme.c:514
> Code: 8d 9c 24 b0 00 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0 4c 8b 7c 24 28 0f 85 25 03 00 00 44 8b 23 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 2b 03 00 00 45 8b 37 48 8b 44 24 20 48
> RSP: 0018:ffffc90002cdf180 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff888045820e40 RCX: ffff888000b5c880
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc90002cdf268 R08: ffffffff8b8395d8 R09: 0000000000000003
> R10: 0000000000000009 R11: ffff888000b5c880 R12: 0000000000000000
> R13: dffffc0000000000 R14: 0000000000000003 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f25d8438198 CR3: 000000001f4b4000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	8d 9c 24 b0 00 00 00 	lea    0xb0(%rsp),%ebx
>    7:	48 89 d8             	mov    %rbx,%rax
>    a:	48 c1 e8 03          	shr    $0x3,%rax
>    e:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
>   13:	84 c0                	test   %al,%al
>   15:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
>   1a:	0f 85 25 03 00 00    	jne    0x345
>   20:	44 8b 23             	mov    (%rbx),%r12d
>   23:	4c 89 f8             	mov    %r15,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
>   2f:	84 c0                	test   %al,%al
>   31:	0f 85 2b 03 00 00    	jne    0x362
>   37:	45 8b 37             	mov    (%r15),%r14d
>   3a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
>   3f:	48                   	rex.W
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 


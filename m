Return-Path: <linux-wireless+bounces-16454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EFB9F47A5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 10:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D721B188DDFF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742731DF257;
	Tue, 17 Dec 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuTAXuHR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02101DF251;
	Tue, 17 Dec 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428024; cv=none; b=sF5yu4GM+QvF4/eN5d10SnRydriYqjUlWasfnSIUHZuX+a6oFc9UMBgTq/Pub/7vZ9aHwEvuNKh0wCoEBANmUV4WjWR48i9WBPzFPihHVd/iEULJVTaKzuxV4wTsJO+JQWorvnStsi7Na48YnGIttOtdQGFjIjlm0ftlS8VRLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428024; c=relaxed/simple;
	bh=qE+xVnShXsuN1IYUq+mVsNxYaNDjw3pHeAwjId7Zp1o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=D4+kbMRFf4v5U4pKVjAD4orsTei9Q8tiA4Eg0b/y2AKi4kT/OTqBGQ8upJwqxeYhz1zBqcx1K5cINxHaqKbzuwifbNSadxgK/SpZfoCmc4ioy5PsV5SO3S+M6oYOAokZfgcz4Lgfk/e+cvNO+HkoNM20sZ6yS8fNnMR0mYSTWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuTAXuHR; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8adbda583so61494136d6.0;
        Tue, 17 Dec 2024 01:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734428021; x=1735032821; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FjLYGtAd7Kt/lnzbVLGzHe2jlgP0GaLlEmc2lza8lmk=;
        b=WuTAXuHRhHwMEER2qShfoOTIbdhnD6jMekFFmGtlHRzqp+3TZ19/UqdbF/GFdzUNfg
         LKAPTsgRjng9IgS39kZTWMuekmLsBQTYfXJNjQEx5j+osHSx8aIDnWPnIXJBcZHqGLBB
         G/G3lCLq2DRRdfgFnAxPwBnvHZh4QmrlPP+r9hhwKbqSMEL2ej9ZNBglHW6Y2brT91EQ
         PrcUjZBpQzKcnrlxaFx/hEMOOxP+a25txyeRZwf90078NRirTUy2oNhLAGzP1boGYnqQ
         7EVJjrl/BmJjEEoYaB0GoGKvorcuUa0v24Guh2VNkrpW9e1+1PLmYrIe4wLJir5NIJZc
         wTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734428021; x=1735032821;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FjLYGtAd7Kt/lnzbVLGzHe2jlgP0GaLlEmc2lza8lmk=;
        b=w4ux1LRrLTRN1VkJtzrQDfLllH8UpFkve7kJYHI9U2z3RhAKObbujmSA+znh+zvgTp
         DqMqRAtlnWqwKybxAqD7FOb67HQ8zT72vK9VbT6T4af0AaXH+V6jXeH6mZm1Du+3fOFe
         HryH1B3Xq38JoJoyB8i2NRF6v+BrCPiQLeMEkEMa03ffePffK9iF8/1L3PrUsh+M/6s5
         Ni3LW6kqr3mlApUlYV6ru8bKlfrYpiNoFe5yqWLLz7XmAFv6b+XpILI5Gb3DDOFE/7T9
         mWvup9Q1DOwMGSWTWrH1mB/1wYtI282ZTJuiT2Bl99sVsKivZtBWkljl5IBHQNiss6RR
         77mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCVCexoXeRrNDH4Cv0ykf9idbrZNZYu6wF8FKHWd8JFJ/mk2DGVXiNFI7N2/Zun8Y9GoMOG4819PDCjOJcgw==@vger.kernel.org, AJvYcCX6+Wa8krw5uHeA2qlB2iVSQ7URI71pVLEbdJS6CN5qDabpoUPdXx2wqni5XwLaKzUM/wiQtSRH@vger.kernel.org
X-Gm-Message-State: AOJu0YzVERMTvQOirS1UPr4kXV9Ma5GzzZgkSpxqEoX2HnbbIZxIj13C
	skzWjLW9cbxW2pcFocAmumQz5kNqFEg7MugtFmEYuCZp5hfHD24lKv3561IcgDkrUMZSqFm3jLj
	1SWqOZcgD4X0bW75f4LtgYtWj1mOspDAl9zc1Ri2h
X-Gm-Gg: ASbGnctviPbrTsxZNOBlP4WxB0++yXlnkiX9gNPWFOKlxlYmiS1TkNHIQMwQ0fUmujo
	UPUClmXoePZhUERPoY2jgCAx7I8hmHgu0ahSsIbU=
X-Google-Smtp-Source: AGHT+IFy6M1DgQfN6+cuy7s4O8RiPQ3+Q+TTIWV0zZ6KFsplcKEe/Em4YTijQ7QGm2ygp+4wx6vU+yGpVq51ruvRBb0=
X-Received: by 2002:a05:6214:21a9:b0:6d4:18ce:117f with SMTP id
 6a1803df08f44-6dc8ca93ac0mr224815036d6.20.1734428020980; Tue, 17 Dec 2024
 01:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 17 Dec 2024 17:33:29 +0800
Message-ID: <CAEkJfYOyWgJW-WAd+GhT07zd2Y3vUWz81+pjbZT9nUAsCc7FGQ@mail.gmail.com>
Subject: [Bug] Deadlock between rfkill_fop_write() and nfc_unregister_device()
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	johannes@sipsolutions.net, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, pabeni@redhat.com, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, davem@davemloft.net, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear developers and maintainers,

We originally encountered a task hung while using our modified
syzkaller. It was tested against the latest upstream kernel. We
analyzed the root cause and pinpoint the kernel crash log to the
following two tasks.

```
INFO: task systemd-rfkill:49424 blocked for more than 143 seconds.
      Tainted: G     U             6.12.0-09435-g2c22dc1ee3a1 #11
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-rfkill  state:D stack:25264 pid:49424 tgid:49424 ppid:1
   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xe3b/0x5ac0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0x59e/0xa50 kernel/locking/mutex.c:735
 device_lock include/linux/device.h:1014 [inline]
 nfc_dev_down+0x2d/0x2e0 net/nfc/core.c:143
 nfc_rfkill_set_block+0x39/0xe0 net/nfc/core.c:179
 rfkill_set_block+0x211/0x560 net/rfkill/core.c:346
 rfkill_fop_write+0x47b/0x570 net/rfkill/core.c:1309
 vfs_write+0x2b6/0x10d0 fs/read_write.c:677
 ksys_write+0x1fe/0x240 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa86ef8b473
RSP: 002b:00007fff7ad75778 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fff7ad757a0 RCX: 00007fa86ef8b473
RDX: 0000000000000008 RSI: 00007fff7ad757a8 RDI: 0000000000000003
RBP: 000055ce3e070c20 R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000004 R11: 0000000000000246 R12: 00007fff7ad757a8
R13: 0000000000000001 R14: 0000000000000001 R15: 000055ce3e06f072
 </TASK>

INFO: task syz-executor.3:50072 blocked for more than 143 seconds.
      Tainted: G     U             6.12.0-09435-g2c22dc1ee3a1 #11
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:26808 pid:50072 tgid:50072
ppid:45742  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xe3b/0x5ac0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0x59e/0xa50 kernel/locking/mutex.c:735
 rfkill_unregister+0xde/0x2c0 net/rfkill/core.c:1145
 nfc_unregister_device+0x96/0x330 net/nfc/core.c:1167
 virtual_ncidev_close+0x4c/0xa0 drivers/nfc/virtual_ncidev.c:172
 __fput+0x3fb/0xb40 fs/file_table.c:450
 __fput_sync+0xa6/0xc0 fs/file_table.c:535
 __do_sys_close fs/open.c:1554 [inline]
 __se_sys_close fs/open.c:1539 [inline]
 __x64_sys_close+0x8a/0x120 fs/open.c:1539
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2ce729134b
RSP: 002b:00007ffcf599f720 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f2ce729134b
RDX: 0000000000000000 RSI: 000000000000c56e RDI: 0000000000000004
RBP: 00007f2ce73dd980 R08: 0000000000000000 R09: 000000008b1393d5
R10: 0000000000000001 R11: 0000000000000293 R12: 00000000000bde95
R13: 00007ffcf599f820 R14: 00007f2ce6e01e30 R15: 00007f2ce6e01e28
 </TASK>
```
After analyzing the log, we found that it was actually a deadlock
between nfc_unregister_device() and rfkill_fop_write():
CPU0                                             CPU1
-------------------------------------------------------
rfkill_fop_write                             nfc_unregister_device
      mutex_lock(rfkill_global_mutex)    device_lock
      rfkill_set_block                               rfkill_unregister
             nfc_rfkill_ser_block
mutex_lock(rfkill_global_mutex)
                  nfc_device_down
                        device_lock
------------------------------------------------------
If you have any questions, please contact us.

Best Regards,
Yue


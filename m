Return-Path: <linux-wireless+bounces-11349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2C2950317
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 12:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CDE1F2359B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 10:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B7219AD70;
	Tue, 13 Aug 2024 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="DEVs+VR7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA319A2AE;
	Tue, 13 Aug 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546609; cv=none; b=AT3Gd9PciyjFMB/L7BCp07Vo1DPZFL10dpn9rcjAu4t72eV3NuftyfW+oS8Crc/CQCmsoWHL3Rte/FbwKP3qzZRyHFueqB5o7/HPUJga4GpvjbhNnuuBKhNd2dQU2UNPdeLSFWIdpLF5jcW3whASn890f0Ge0cmAVREGnFSNunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546609; c=relaxed/simple;
	bh=bHCjmMI6O9YGP1vUBVvoqCp53yxzYEyBqJwhJxoO/gc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SJ3dtSfyQTpWH5iA8Wd9gEmLKDnA5gSAiAXtiPourVmTDAre+ijTdOllknkOdnumTI0DIl694oO8ZutHC8jsIWYKtzc9AlWb5Wiypt3VXMQ1x3oxlbrlIEtgE3WSGW5Zokdg4zJc95qowU8Lvv7N1YWY4vwsNCd5SABQ+nCR7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=DEVs+VR7; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1723546600; bh=bHCjmMI6O9YGP1vUBVvoqCp53yxzYEyBqJwhJxoO/gc=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=DEVs+VR7n39oTVLwnz3/2l6GzacQMYmwNc1DLFF8mQAwCYJDEwZevhMXoQspbFqtg
	 LR5ffiyeXizo884AFf0hvnia2TJ0M2n79EKaJTeTWJwsYGv9b54VqNTm/vrtjBVzKp
	 adgI3cQvLy/AGVWjQeuujcByMNZUJm0x2GeMyVTb5bSKg8szT8uSV/YpZLJdaYVx91
	 kO84m90k2NTN/Qb6u7aIEdJOcKbgF2rvR9k8zi2ulbGeJCccjMRc8MPxxcbG5+xQ85
	 eG2VzNn2Ia0Hpd/UgL3l0u6ve/NUGthp7mXn47FFM0qSWDlv39URTIR9Z9j+4/OUW7
	 B1XQDWakBSHOw==
To: syzbot <syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com>,
 kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Felix Fietkau <nbd@nbd.name>
Subject: Re: [syzbot] [wireless?] INFO: task hung in
 ath9k_hif_usb_firmware_cb (3)
In-Reply-To: <000000000000877f44061f892ace@google.com>
References: <000000000000877f44061f892ace@google.com>
Date: Tue, 13 Aug 2024 12:56:40 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ikw4wv13.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    eb5e56d14912 Merge tag 'platform-drivers-x86-v6.11-2' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=137edff9980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
> dashboard link: https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a6552acb8476/disk-eb5e56d1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5c0963cd33df/vmlinux-eb5e56d1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7ba7283f6380/bzImage-eb5e56d1.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com
>
> INFO: task kworker/0:7:5284 blocked for more than 143 seconds.
>       Not tainted 6.11.0-rc2-syzkaller-00011-geb5e56d14912 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:7     state:D stack:13232 pid:5284  tgid:5284  ppid:2      flags:0x00004000
> Workqueue: events request_firmware_work_func
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  device_lock include/linux/device.h:1009 [inline]
>  ath9k_hif_usb_firmware_fail drivers/net/wireless/ath/ath9k/hif_usb.c:1163 [inline]
>  ath9k_hif_usb_firmware_cb+0x34a/0x4b0
> drivers/net/wireless/ath/ath9k/hif_usb.c:1296

Ugh. Okay, so ath9k_hif_usb_firmware_cb can recursively call another
firmware request, and if that fails (because it runs out of firmware
names to try), it will do a device_release_driver() from within the
firmware callback. Which takes a lock, and seems to deadlock.

It does seem odd to try to do an asynchronous driver release from within
a callback like this, so I'm not surprised that it deadlocks, really.
The question is whether this has ever worked - does anyone know?

Also, ath9k_htc_probe_device() has wait_for_target logic that depends on
speaking to the firmware; and it seems to tear everything down if that
fails. So my immediate thought is that we could just get rid of the
device_release_driver() from the firmware callback entirely, and just
rely on that timeout to tear things down. However, I am not well-versed
enough in the USB probe and device setup logic, so I am not sure if
there is any reason that wouldn't be enough. Anyone with a better grip
on these things care to chime in? :)

-Toke


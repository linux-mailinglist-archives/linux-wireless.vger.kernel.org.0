Return-Path: <linux-wireless+bounces-25307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35972B02930
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 05:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE8D3A64F6
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 03:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7E31E51EB;
	Sat, 12 Jul 2025 03:45:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97D440C
	for <linux-wireless@vger.kernel.org>; Sat, 12 Jul 2025 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752291935; cv=none; b=prgxsrsGadSg3lmWNFyhRnUXKjZrYrP46ZMvwfxl8C/64J4/+Kq5+Em7eMdJBmLfJ2vYXZuRAuj1oA9j8xLP65VT2AVZX/4MC3bl6g/RNVX3ZnlDUtbsGQ05uKT3p/zCQrR1PSR1s4AF+shpgsFQgRvaUugKQxnP0XQjWhd7KfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752291935; c=relaxed/simple;
	bh=3H00AmbBO3nqlxyKAjYAz8hiY2Ebejs1YAQyLRB6kVQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LQoVci0srtXvub66j4d70DrSeJAzzEYR3Q++KFOFyy6olIZ3ta+Jsubh6UYJGBxUQ240KNNvSN/xG42jBIhBUSD2T31Qp1w1VKmgKUL3B9tKtg6RdHF4vvQcGbvgWbrKYdr6/hDCZMJ/TmdUtS+ogXMlgT+PGPwYf36aBTv/0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86cf753423cso244176039f.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 20:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752291933; x=1752896733;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CAc8THJhnd+F+AmPMsjA4UJS8W5Ilovs6mltzRCcT8=;
        b=DoMo+azbfJwO7ID8SwvuyBg4GgbV1D4pQ+JLCRMDgSKh41VQUN6d3AtKykJlzpA5U3
         IkLxmAVGz4ktGeRBBzY7hwLJuatjjUxnM0uhlRFDL6lXTCFFq4IubafbeCcvIN0qOOSh
         xEZkcE3YsrjROGVR0bzvvKMDIetwOPhpwTwWahagUof5Q+ph7fYBTMqM6Fn0gX2Vz+hS
         OHqwLTATM2IdmkvYdH0wXjoX9x8FpvwAboBLGbUOcERusZc15RY16neDZTr2knoV41Ry
         3VFitS1pgu9MErahc8IEeS8VQ3sJq6ruKHc10n+jzA/qkTv0Sh05FB2JthOfmGxdYjWl
         5VAw==
X-Forwarded-Encrypted: i=1; AJvYcCWGsjadxmKF5NEUnvI5MzdCsl1R/U+r3IOtjEWc72SJJECQiY1nD6D3P97+j/mxvdv3L6ZMQFQ8Kcaap7Ogog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjic1xNcYx4tV++96clMTXLltVQZ5E18/1MPPHBuL9CiVTpbXs
	gfJyg50+TPskRkDtp5udGzsN2v2hTDFzpFGaE6awiI4Yxf+XDr19V097D3wWkDSrOMKyC7fP47v
	il00TWd39MmwW1e5L7eto4I+D3jgCzfPudV5u4wkJRz+JVnIc7UN884DFetE=
X-Google-Smtp-Source: AGHT+IGbBJ6q81mzWM1CwB6OMZG4kFC4W8hjq0dwZ43gTDPnlQnsR7C/TBMLWrEG0on8MxnvqmxJV4/MCWMWOXG7fbRDdx4m5Lae
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4802:b0:86d:9ec4:effe with SMTP id
 ca18e2360f4ac-879787e7038mr666135739f.8.1752291932753; Fri, 11 Jul 2025
 20:45:32 -0700 (PDT)
Date: Fri, 11 Jul 2025 20:45:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6871da5c.a00a0220.26a83e.006e.GAE@google.com>
Subject: [syzbot] [wireless?] UBSAN: array-index-out-of-bounds in
 ieee80211_request_ibss_scan (2)
From: syzbot <syzbot+e834e757bd9b3d3e1251@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    47c84997c686 selftests: net: lib: fix shift count out of r..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16ef60f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=e834e757bd9b3d3e1251
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/10b34cf37026/disk-47c84997.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/953c1fdde5ac/vmlinux-47c84997.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f870a400c55/bzImage-47c84997.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e834e757bd9b3d3e1251@syzkaller.appspotmail.com

wlan0: No active IBSS STAs - trying to scan for other IBSS networks with same SSID (merge)
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:1223:5
index 11 is out of range for type 'struct ieee80211_channel *[] __counted_by(n_channels)' (aka 'struct ieee80211_channel *[]')
CPU: 1 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted 6.16.0-rc5-syzkaller-00159-g47c84997c686 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:455
 ieee80211_request_ibss_scan+0x600/0x8b0 net/mac80211/scan.c:1223
 ieee80211_sta_merge_ibss net/mac80211/ibss.c:1283 [inline]
 ieee80211_ibss_work+0xd85/0x1060 net/mac80211/ibss.c:1665
 cfg80211_wiphy_work+0x2df/0x460 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
---[ end trace ]---
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 1 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted 6.16.0-rc5-syzkaller-00159-g47c84997c686 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x99/0x250 lib/dump_stack.c:120
 panic+0x2db/0x790 kernel/panic.c:382
 check_panic_on_warn+0x89/0xb0 kernel/panic.c:273
 __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:455
 ieee80211_request_ibss_scan+0x600/0x8b0 net/mac80211/scan.c:1223
 ieee80211_sta_merge_ibss net/mac80211/ibss.c:1283 [inline]
 ieee80211_ibss_work+0xd85/0x1060 net/mac80211/ibss.c:1665
 cfg80211_wiphy_work+0x2df/0x460 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


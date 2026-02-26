Return-Path: <linux-wireless+bounces-32193-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM3LNn28n2ktdgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32193-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 04:22:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 568841A079A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 04:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4279D3007650
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 03:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767B38552D;
	Thu, 26 Feb 2026 03:22:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224B2727E0
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076155; cv=none; b=tbkeDPdFNGAizp7jC18gBLlzWEo2bKF+xK14L04Ws57J8fk6RnfdIbpH+hz7o4ulpMQ/Te6HmNUursMSwSnVgudjbqagNksDiTn/a98H+oPNPyq0XtDSPJYW5UTPyr6VEf1fuB7a27NZtbYZwmT18pZkcFwCIuLeuezuFkxRUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076155; c=relaxed/simple;
	bh=dv+ojd9XtianMSO8mOIwCAVvuh8pa62GgRDVtGhAdRk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GF6a1+jab25Ezr22o21kndTHbKDdiMUZcLqgFWUd+to0V4hR6CN8scWOEhz/uCsyl61ALP+1cBeuTfn8JLqjEJGyhAjNBGTcM25nMV25Y2DL7WrnXA7UQ+1y5d+k633pS3qE/MBKWPrUz8QUvBkm+fSM0hsVAFV/1wb2uc8hU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679dcff168dso4830043eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 19:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772076153; x=1772680953;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcj5cPdy6weuO+6wPMEFZwTGe6ZlpjEUbfd7D2wcnRM=;
        b=JdkSEdmGdEDRvqHeZBLTZvAAfwnengq67ZvPVd9WUQK3I6SYOFSCpMp3fGm51435H3
         oN5CPDXKuGUKs2FHMmJrxYGouyK5hA+vrX4zGgtMXKDj3/aNWXqjFEJjycwkjKoBG9na
         Uoyfu45BWl5mmNzg4Qe9zNYqZUplpCK9223VCpfg4y6Hm7b8S+UpGVaiWdwmwRVqB2ke
         1r/BnW+8vo924JakiCWHza6N+0dfXZ+iA4EQjFiyytLk2aKTPUPA0c/Pyzw4DkgWOMVu
         3+pxV8HQy90yvABIqrPk7bbD/IVBhjP3ZhMbrZKwBK8l9lyM8hRL8ZZ1rAsdogXsQb/S
         egnA==
X-Forwarded-Encrypted: i=1; AJvYcCVesYBsv/LCovBz9N/bYpfcR0NMKxA+EaGTG9V4RZCy9WTf2vRStGiYt/z/BEpAlQWBb9yvM0iZEBtZJ1MVHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nRGnJrkxYLBPyz78W6FSqoo4QIx5TfzJnHg+YtkvYx4G96T4
	nLRrxv+W12bp+Z5/cupJowNMTavVMKjJmZUKBUZ/IxU4M6CJZf37IXlwUeoiaWoxnUlo6JW6Lso
	PZgdOnS99wfpOOQFwm9HJrG5LSxQNi/2FaQ3PXV/9yR0DeQSOnkTQ/tADrOo=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1793:b0:677:18e5:e5a5 with SMTP id
 006d021491bc7-679ef7ff38amr1220624eaf.5.1772076152824; Wed, 25 Feb 2026
 19:22:32 -0800 (PST)
Date: Wed, 25 Feb 2026 19:22:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699fbc78.050a0220.1cd54b.000b.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_set_active_links (3)
From: syzbot <syzbot+582469b3a9ef5f13606b@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=af6ed0125ed44356];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32193-lists,linux-wireless=lfdr.de,582469b3a9ef5f13606b];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 568841A079A
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    7dff99b35460 Remove WARN_ALL_UNSEEDED_RANDOM kernel config..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113428d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af6ed0125ed44356
dashboard link: https://syzkaller.appspot.com/bug?extid=582469b3a9ef5f13606b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/45c7b6686727/disk-7dff99b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36fcc9cd6296/vmlinux-7dff99b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe952fd2745b/bzImage-7dff99b3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+582469b3a9ef5f13606b@syzkaller.appspotmail.com

wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
------------[ cut here ]------------
wlan0: Failed check-sdata-in-driver check, flags: 0x0
WARNING: net/mac80211/driver-ops.h:1723 at drv_can_activate_links net/mac80211/driver-ops.h:1723 [inline], CPU#0: kworker/u10:3/11668
WARNING: net/mac80211/driver-ops.h:1723 at ieee80211_set_active_links+0x2d0/0x9d0 net/mac80211/link.c:595, CPU#0: kworker/u10:3/11668
Modules linked in:
CPU: 0 UID: 0 PID: 11668 Comm: kworker/u10:3 Tainted: G     U       L      syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:drv_can_activate_links net/mac80211/driver-ops.h:1723 [inline]
RIP: 0010:ieee80211_set_active_links+0x2d7/0x9d0 net/mac80211/link.c:595
Code: 06 00 00 e8 fb 8e 05 f7 48 8b 34 24 48 81 c6 20 01 00 00 48 89 34 24 e8 e7 8e 05 f7 48 8d 3d 20 ef e7 05 48 8b 34 24 44 89 fa <67> 48 0f b9 3a e9 e0 fe ff ff e8 ca 8e 05 f7 0f b7 c5 4c 8d bb 30
RSP: 0018:ffffc90004947af0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888029d2aa90 RCX: ffffffff8b026bfe
RDX: 0000000000000000 RSI: ffff888029d28120 RDI: ffffffff90ea5b80
RBP: 000000000000000a R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888029d297f8
R13: 0000000000000000 R14: ffff8881446c8e80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124351000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005641c1b014d8 CR3: 000000002d732000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_if_parse_active_links+0xbb/0x120 net/mac80211/debugfs_netdev.c:732
 wiphy_locked_debugfs_write_work+0xe6/0x1c0 net/wireless/debugfs.c:248
 cfg80211_wiphy_work+0x446/0x5c0 net/wireless/core.c:440
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	e8 fb 8e 05 f7       	call   0xf7058f02
   7:	48 8b 34 24          	mov    (%rsp),%rsi
   b:	48 81 c6 20 01 00 00 	add    $0x120,%rsi
  12:	48 89 34 24          	mov    %rsi,(%rsp)
  16:	e8 e7 8e 05 f7       	call   0xf7058f02
  1b:	48 8d 3d 20 ef e7 05 	lea    0x5e7ef20(%rip),%rdi        # 0x5e7ef42
  22:	48 8b 34 24          	mov    (%rsp),%rsi
  26:	44 89 fa             	mov    %r15d,%edx
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	e9 e0 fe ff ff       	jmp    0xffffff13
  33:	e8 ca 8e 05 f7       	call   0xf7058f02
  38:	0f b7 c5             	movzwl %bp,%eax
  3b:	4c                   	rex.WR
  3c:	8d                   	.byte 0x8d
  3d:	bb                   	.byte 0xbb
  3e:	30                   	.byte 0x30


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


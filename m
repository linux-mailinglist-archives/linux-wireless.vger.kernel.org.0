Return-Path: <linux-wireless+bounces-38193-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qKgdIPHtPmpZNAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38193-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 23:24:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 153546D03AD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 23:24:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Jcxo0kSF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38193-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38193-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 713BC301C2E9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6843BED46;
	Fri, 26 Jun 2026 21:23:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51F3BB123
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 21:23:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509038; cv=none; b=jYGsFH0VITKURAX9sLJHqzb/MOsN+Gp6TuEjqdraTfVMw/WkxubEYXCdQnInHT3B6/Jy6gFxVNE9pO88x9U7Ex0ymznamB+FH0z3VYENmrSMZYMDWYaRfJVyrPeDrzpGSWjJcijuOzckMZSBxTAX0uzdZTg4oSOWndou3yxbhA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509038; c=relaxed/simple;
	bh=hgAYpxuY7k8UBXXuFP8STp8Vq5a9D2vgYK7ggh+Fl0s=;
	h=Message-ID:Date:Subject:To:Cc:Content-Type:MIME-Version:From; b=Wu7A9vsxlcm5INvhFK/9Ml7Uff4EV9ucAZJlyEgHbAyq0E48rjIc7Gczd99Udmi8PyNLZ0ZFrhLyPcZLk6IwROEqL1voDBJMo3hm80w4vLulTL2L8w0buKl4eafSJCjYpK00u4u9CVm2dgouesNxI4jhncpCyEzepdaxNow2ips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcxo0kSF; arc=none smtp.client-ip=209.85.222.41
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-968f67499deso29457241.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782509036; x=1783113836; darn=vger.kernel.org;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYD2nkO5yO0H/hkft5/6wEQAqgHy2trdmVTQ8fmB0e8=;
        b=Jcxo0kSFapQgheSrwqI61kSZqvuplFa6LA97Gi3i7b0TBOCpSMQAIqZQeYJce/HX3z
         2yvz+OzHUvxRy/1EAq+WSNAlDgEsf2xL263OB0j3KFuze+/4ItTGURSqb4M3qfAvBfgZ
         R+Ir45nNrEngq5ZLgVHAAziZmrByhs2iqAfLd52q1B4xteAWYyoCzKpmtYHR81MXVK88
         VtvJxJOJfSGYnLwVzBDqQZAuwT8xrudINEDctq6h2vRJ/WFDiuLcHkzLwdYhBvjWt2zu
         t/m+Oi6FrHyld/pRjv8cku7g0JOv1wGa2w2uId0a6f0ey3DnyszLLkOeyoG2Kimrjvhe
         e3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509036; x=1783113836;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DYD2nkO5yO0H/hkft5/6wEQAqgHy2trdmVTQ8fmB0e8=;
        b=ULMSb4kpUl6RXorCyUQr8vr2ujp6571Ik7Ydp7iRoVocnLIatKyuYVUcZQURVKpY5V
         IiCtYFItdoN1xgPqcbx81HpfCuiFyBo2nESekeyCt7a5HQWtmeAs33R06po1HT79Ywa6
         BSlwEaQWer21B2/ln+MyM5wQv9KNyPap586An0HMRd9XGaMJXEWWfXoYCcN5wSiAj560
         xS1/k6IymjtV8gkGpYv+z1/C+G0TGKmeQiUDtq7z3vIo9sZLJMpaRtA/ItiLA7CL6PE8
         fP8VwTQVRdaRI1fuhhNr3afzVRPivAXB9uN0vEiwm3Hz8fX6nxZ4DSIqvKz0tEyT+cD/
         mgHA==
X-Forwarded-Encrypted: i=1; AHgh+Rr61fsUfy2mIlvFyferXxSebJomdN5oXpiMuys4tFlr2sSmNdgTMPpBTwxfrQEkOKbTUW+RTq1ffWIWBd4LJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhyY0Q/pUSZDYZ7SwmYK35fKTtqWB9Qvjgj7yqmCrVatEq5IlU
	iPCmqvVMvEJk/O1d6SGCs9Yuubry0DzFq/nzo9/SRCRxeJTQmpjjdALd
X-Gm-Gg: AfdE7ckfqhui77abrChSJeev/YrqNGZ68x0dLFtd5KG/7Rimja1IZlUAbPfgPHwD7wU
	bxaH+FETshna+0aQyMgg21IiYO90YdgZYBvZBEbG5kppoPH9/LJQYJKUYJOPpkmSXOCYQzlrmhE
	B0XeCBVuO2o14QKjb8iE4jzJI9uQrl+SNTkay5SSvGquGnoVQWsg8xnKmVB5pY3XQCArEu/J+Mv
	37tgBiFESHs8nIkQkoeBxOP9gYgiFBy2y993Z1/4WxLdw8mvr0liDFdKwLrM6AQETMzJDpj3Qkh
	4Ge+1j9yY3iHl2y3NlvyiusvRROb7HHqnLBuxcGGSgSsWkVSB9p4wDAawEx12pNAXSCbNg/82+l
	w6LsV7Su6sm5wdLa5XFVQgr5I+tc4QeUdvUH/v4/cCZW+TLBGO9PaZYvhaMyeyqgFvdRMenPmFd
	KZX+JSw7UyLokEoesmDfNh/pbe2N/Hp/aiOxbwk1Ee+FebYdcX0FOny67l9q8LONVqerLIwNEn6
	NC0b48IThwu
X-Received: by 2002:a05:6102:50aa:b0:634:11ac:12ca with SMTP id ada2fe7eead31-734362a85b9mr1518937137.5.1782509035878;
        Fri, 26 Jun 2026 14:23:55 -0700 (PDT)
Received: from [192.168.10.115] ([132.170.207.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96916e88e59sm1895811241.6.2026.06.26.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:23:55 -0700 (PDT)
Message-ID: <6a3eedeb.87857ece.10923b.5b31@mx.google.com>
Date: Fri, 26 Jun 2026 14:23:55 -0700 (PDT)
Subject: WARNING: at rate_control_rate_init, CPU: syz.NUM.NUM/NUM
To: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sanan.hasanou@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38193-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sananhasanou@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,m:contact@pgazz.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sananhasanou@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 153546D03AD

Good day, dear maintainers,

We found a bug using a modified version of syzkaller.

Kernel Branch: 7.0-rc1
Kernel Config: <https://drive.google.com/open?id=173DLEAEPKPhhR1TcqofdnkLpdoK7PMFl>
Unfortunately, we don't have any reproducer for this bug yet.
Thank you!

Best regards,
Sanan Hasanov

------------[ cut here ]------------
WARNING: at rate_control_rate_init+0x3a4/0x420 net/mac80211/rate.c:53, CPU#0: syz.7.23087/97240
Modules linked in:
CPU: 0 UID: 0 PID: 97240 Comm: syz.7.23087 Tainted: G             L      7.0.0-rc1 #1 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:rate_control_rate_init+0x3a4/0x420 net/mac80211/rate.c:53
Code: 25 f7 f0 80 8b 0a 01 00 00 20 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 f8 ad b9 f6 90 0f 0b 90 eb e6 e8 ed ad b9 f6 90 <0f> 0b 90 e9 f3 fe ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c 80 fd ff
RSP: 0018:ffffc9000238efb8 EFLAGS: 00010283
RAX: ffffffff8b08a3e3 RBX: ffff888046d9c050 RCX: 0000000000080000
RDX: ffffc9001071a000 RSI: 00000000000015af RDI: 00000000000015b0
RBP: 0000000000000000 R08: ffff888046d9c10f R09: 1ffff11008db3821
R10: dffffc0000000000 R11: ffffed1008db3822 R12: 0000000000000000
R13: ffff888041e30a00 R14: ffff88804121e660 R15: ffff888037ebe7e0
FS:  00007f10205186c0(0000) GS:ffff8880d98df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f101f78beb8 CR3: 000000001d065000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 rate_control_rate_init_all_links+0x52/0x380 net/mac80211/rate.c:86
 sta_apply_auth_flags+0x1c7/0x400 net/mac80211/cfg.c:1967
 sta_apply_parameters+0xe9a/0x1600 net/mac80211/cfg.c:2354
 ieee80211_add_station+0x38e/0x5d0 net/mac80211/cfg.c:2420
 rdev_add_station+0xa7/0x170 net/wireless/rdev-ops.h:201
 nl80211_new_station+0x1878/0x1cb0 net/wireless/nl80211.c:8904
 genl_family_rcv_msg_doit+0x20d/0x2f0 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x607/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x206/0x460 net/netlink/af_netlink.c:2550
 genl_rcv+0x2d/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x930/0xae0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x7e0/0xb10 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x603/0xa20 net/socket.c:2592
 ___sys_sendmsg+0x224/0x2a0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1a0/0x260 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x19a/0x7b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f101f5a3b6d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1020518018 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f101f815fa0 RCX: 00007f101f5a3b6d
RDX: 0000000000000000 RSI: 0000200000001080 RDI: 0000000000000005
RBP: 00007f101f647c3e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f101f816038 R14: 00007f101f815fa0 R15: 00007ffcdf1409d0
 </TASK>

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>


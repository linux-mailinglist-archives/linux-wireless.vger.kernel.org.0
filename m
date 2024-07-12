Return-Path: <linux-wireless+bounces-10207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE7C92F8AC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 12:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEBF1C21E12
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156B15B0F4;
	Fri, 12 Jul 2024 10:05:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16331157E8B
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778723; cv=none; b=mm6423aVxOnFYpCOAeGbc4r9aY8cVJ/6r2j1GIVxcMIQCzSaMp3XMjLMXjOZoCRg7+waDDNHwW+xpFqHYDandMggivtKhHi7XihUsHyQP5OMblGHj5txsTJjxd+OxfX9kXIdyIfdTwAcdaBH7yJmLA/4EC+pIiLD+6zjl4pPxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778723; c=relaxed/simple;
	bh=H5hvUUZnnhkIagL+5ouebBqnH8nfRt+MjD3u0w4kG+o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dZvITJ167i9VyH8cmQ5LiXiioZP38QHlp0IC21wdv/gxU6qEax7XYEv9G9ABlgc1gRqIBTye5zl6F+2BvAucZNb/EtvYXDsJuW70diMGYlPBS6+Q6D3WCCzn54QnjhJLQFmB1C9r219WxMUNXIPwSOm/1/dgRxlnOnK0PNZ5My0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f12ee1959cso207858439f.1
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720778721; x=1721383521;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BNPueG2xNKE2bHt9i3oEOq35MviFRHZw36CwFEMpwU=;
        b=QMbi+QR+r8RnoCKMWAcuSCEqxfBLDb/UjJKlyjBdflJwo4FtoCw/UNBC3GH3NaL4KO
         vW12WkEJlHNSQXhWgOpkYujBqfPq/VVJN5NdLcnjbuz2VBqkh2cwNTNb/aXNfCI4jASv
         ssO7UiTufsNdrp/HO2K66d7Gu82Fq9+HLXtoLQUm19O54DT2jCOeFM9muuHgsFBWDEU+
         EHu/sZQr66D6WChBNjfBkwlwuqHJb3nDhlUM78Qh+D6M7Ax8y7P5qwQR1t5Nkz41KEij
         YqsizVJT29D1HPtlCmhcUImlWoIv6Q8sVFnwK6+6rI8PIf//EpbyEYq9gulLAWdZTgE3
         yL9w==
X-Forwarded-Encrypted: i=1; AJvYcCV/Lp6FzCNjJ+dl5i9JalM0sE0LdKcr1KfP0b/WKQuih1wZgTB6Ctr4JLf2/z0DjHJDgbOo8MdlLtDeqeP6mxJXylOSnfiPsbH425lOmWA=
X-Gm-Message-State: AOJu0YwbQQDzKRWnx+GlF6bNiz49N56/bZIAQqRuhnsUaAkQsE25St3f
	KAF4U1NCA1SZ+tqX53mP2cupRTU20APzOutc1Qh7rAShLSPxolo2h8ElgEbZCz+gOGF9UHHaVsV
	OAi8yuLW5uXyPrF1y06VEHq+fm4T4QyEyyekAp2mtT4kgWptIHu3/bBI=
X-Google-Smtp-Source: AGHT+IF3woUspVQwnqcAgv9lOUWwCpgqFPDPmAEczN1F1IJQqcZGwsRpEdWZ2CMzo+AkFY9TislhPJ/7nbdl1D4rIRNr/ACqZWpW
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2416:b0:4c0:8165:c395 with SMTP id
 8926c6da1cb9f-4c0b2a93c4dmr1100964173.3.1720778721318; Fri, 12 Jul 2024
 03:05:21 -0700 (PDT)
Date: Fri, 12 Jul 2024 03:05:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006be44a061d0a04d9@google.com>
Subject: [syzbot] Monthly wireless report (Jul 2024)
From: syzbot <syzbot+list0abfba96ee1d82542925@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 4 new issues were detected and 7 were fixed.
In total, 30 issues are still open and 136 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  15869   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  5038    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  970     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<4>  562     Yes   WARNING in __rate_control_send_low (2)
                   https://syzkaller.appspot.com/bug?extid=8dd98a9e98ee28dc484a
<5>  186     Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<6>  157     No    INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<7>  85      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<8>  58      No    INFO: task hung in wiphy_unregister (2)
                   https://syzkaller.appspot.com/bug?extid=abba31ed4fc4178349e9
<9>  44      Yes   possible deadlock in zd_chip_disable_rxtx
                   https://syzkaller.appspot.com/bug?extid=0ec3d1a6cf1fbe79c153
<10> 42      Yes   WARNING in cfg80211_bss_color_notify
                   https://syzkaller.appspot.com/bug?extid=d073f255508305ccb3fd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


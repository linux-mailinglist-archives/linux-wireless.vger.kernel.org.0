Return-Path: <linux-wireless+bounces-19025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3726A377E4
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 22:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1BE188E76B
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F561922E1;
	Sun, 16 Feb 2025 21:53:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C8155A2F
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742801; cv=none; b=qCMZdiBndxMh2OIaB5FTdJ2NeUyjnsXVem44X/Ez4zv9n/rQtNufh0rSQsXNNNsJlgThs0N3RfZQaEH65M/mHvjAWDXIPLEQNyKplH0w8MK++LhZOnOyIcp0qp3bTJKbX12xETxvVblJGREWBEOKFUQo10FdPIwxt5Kk31lDSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742801; c=relaxed/simple;
	bh=2HdV9K1090TNcWMgtBDZ/CrmvyVDjRkPYrKYHVxxQiI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CMseJNyD4GczOhjf9tPdkJv0TRcbSwnzY3ztFFjWIn5mUWDRerexoMQRiRVoxQJuP3PBmfUdFg8tka6Ab/qzgBu49NawRVJpwyilR7JMdXSvsPD+8ApggfVLeCZ/udepsxyvNwCPtju4S+heBehLG6wW/SyT5xzENBGMPDzbtE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d14950ac9fso65868965ab.2
        for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 13:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739742799; x=1740347599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8j34y60xPQfNM3NuVW72lMLYLLNzfF/77lksqY3ZGos=;
        b=kOcGRi9uIiHTlBV7LJGW9h0NNF/b/X9TjrDD/z7ItOU3LsNxEFqrmWHcyTuNbXmky4
         ssi3LK8dF4pwvWb7z7UcYs5gUinwbf4BQtcS8vJgJxdI6yWx1vNLreMIl4jXlOYMwDuk
         NiLHy2lrQlKcV9HZMTgsk4hbUmyfCgouShQUhnPEbOKNH1jPuOsE0X7Mzqrps5RBQvOg
         pmHtSzT2YDrqhNW5dPj82nTPQB5qKYkTuA4qMOm2TAJ+2FBXj8XQI3UVMt606fiGmt40
         LKR2vI9HeDaFZOc5KufCkfpTHGZTChXaxxUV6YRMW3dkxr2D20exPRNFiSbD6Ur6nzv3
         sxnA==
X-Forwarded-Encrypted: i=1; AJvYcCVMYLlnzbuBkGP9LGEnAEANmEZhQCH/AJpC40Q0DhRfR+hpQCPY/nxAAjjX/a64/xyV4zSVlCnnkP1W8MYBCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfpS9qSlNuLK/kyfRwcxrsSgnu9QKC1uLOr7PJLyPs8tRhtSU8
	959Mxg34H4ErAlPNNA3W1K2UF31Xjb+TPj1WgtQTcdhLdxAZ+98XF2Z53ainSYwsKFslnVACmir
	oxrD16L0+S2apKetsPUWQUt4Klu3F9RLCfxp2/5kD4YD+iJGdJhkwrfM=
X-Google-Smtp-Source: AGHT+IG2MFvfRLzbqLO5UDabd4n/3XziSxoOym4jvpO3IAILNVCNMeyyKALPLOteFzRAcBMFVvdmIKPnvREtlY67sjtjOWmYBeEq
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:b0:3cf:b626:66c2 with SMTP id
 e9e14a558f8ab-3d280921393mr50007475ab.19.1739742799584; Sun, 16 Feb 2025
 13:53:19 -0800 (PST)
Date: Sun, 16 Feb 2025 13:53:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b25e4f.050a0220.173698.0016.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Feb 2025)
From: syzbot <syzbot+list8ccdbcb0368002fe97e4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 5 new issues were detected and 7 were fixed.
In total, 58 issues are still open and 155 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  88473   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  7039    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<3>  6511    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  6323    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  4563    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<6>  2622    Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  1200    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<8>  809     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<9>  550     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 388     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


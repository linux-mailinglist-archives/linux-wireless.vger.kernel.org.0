Return-Path: <linux-wireless+bounces-13935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A999C0E7
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 09:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E47EB22D3B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 07:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279013D612;
	Mon, 14 Oct 2024 07:15:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695413698E
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890133; cv=none; b=KYV1vCRx9HH2Yp8MDK3LVEb9f1hkuHz5DiuOEz7rjCAPs9pc6ae+Xrf/+zm1zqdx22iIwljSPsP1u27umr7UvKKy/UAwohin1oKounZ/6QYz33rl5qxOp22sox3z81Ke78jHJAB7RL/kooxYNv9CfEWPkkmEb00vn4MsNOVcRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890133; c=relaxed/simple;
	bh=rmqTKNE3CQ2Qgo8lS0qL8MYGdLeq9a0JDaea/S64Nto=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=liuop9VXRDhL1kGQoW3x1Huzgz/zqiH/kMO+CLa1N2/wxpKZF1022z2gO57HgkVXzfUTHdB4TSvvuItYzdXuV34+V/y5Lb0cxraGejPEMqsDJOYdVh8f9HijNsbOr5xH53mU0/WclQMFM3aR5Gf/covm8sVNzBvrPgt0vf6lXm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b4395dedso30134815ab.1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 00:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728890131; x=1729494931;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrAUuRqPsMn2YVWLeSUiBzZkrw+Pm6gR5I3+M7Woy/g=;
        b=taez8qNTuxEo8WXd7jGdFTUra9xMRA7qYi0ps9OQJjmyK0IKJ/VupAxFkLs5EuFJWn
         mVMQC18Sykneks7K6ir7txaQm0OhJQ/dlCi+gS8k115Ihg3rr852STSGeoTqblNczdTJ
         TmoH/n/s/0Az52T0DbCuCmgsuOh+z6kf34X1pYJoYyiUlFsV0PrHgMXuVqMSpAJetlxG
         ipKE2LkdFL6SUjd3n0Jvl9nzFpApI+Mw0xS+nJ181of8DDTxOwjzEmwZu/d00ZciIn7P
         aPW2/jlHpphHEjDwz83DAzD5cTqmtELM3gHpfQbWdXpfyQnZ/km5rpfM8rb5vls7Ho+c
         pibw==
X-Forwarded-Encrypted: i=1; AJvYcCX7p9pQ4AxvkImBeCSMZW/RlDpD60994M1I6TJdA0nzEJbl1pWySOC3D+hIq5nfAiorKTzH0Yrz60Z6ebdfKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kUEs47MZhaMO65/rjjbpEazz5qFXE2mMf7n9RX7JEQHZrMNT
	b1LdEKvqzXVdIcXgrhxIZ7zMBvs8awNXUUBKFpVF2SHuSiL6VN/FKplZFZr5fwyF8hVxusxZpRX
	ovBGYU5vm70T30NJIEXl0iKJ8Mq9WdA0gACFFkSIynxbo/AX2q74RTyc=
X-Google-Smtp-Source: AGHT+IF9A6QjWA23L9s/ioWJStNI8SjP8VOHWp0B3A+U9f9u2ynjRhrmA0ymijDb9J0hP3hQDjuKzUGz9UhROlcuPHQnedBxxRjI
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:3a3:6045:f8bd with SMTP id
 e9e14a558f8ab-3a3b5f7845dmr96684315ab.5.1728890130818; Mon, 14 Oct 2024
 00:15:30 -0700 (PDT)
Date: Mon, 14 Oct 2024 00:15:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cc512.050a0220.4cbc0.0047.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Oct 2024)
From: syzbot <syzbot+listafa8479e7289edf8e367@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 5 new issues were detected and 0 were fixed.
In total, 40 issues are still open and 144 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  31987   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  5861    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  2734    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  1468    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<5>  1144    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  905     Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  383     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<8>  253     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<9>  233     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<10> 209     Yes   INFO: task hung in reg_check_chans_work (7)
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


Return-Path: <linux-wireless+bounces-20499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF54FA676CE
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 15:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFE51632A0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA720E021;
	Tue, 18 Mar 2025 14:49:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E3C20C488
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309393; cv=none; b=h8c++MS3Y40acRjGH+Eanu5KATmy9ufssF1DNqi1BStxP5sG1+PmuPfeQ5kUn48gZB6/leEAF43nrQIu/PW7rTcCewPoa/O7PmNJMJaY1u/1rNkKmtcEAvoEhyjV48MaYXxm2o/57/JhIh1NvgnC8Rq1RBcW5tDPwv7tZzLdOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309393; c=relaxed/simple;
	bh=6odYDy/WzoLJB1dmBWgEDOpufGqtMVPdGIhz8jVMsEw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GXGBKOk3eEj/45msAMhnBZYpQNH6k0sWYPHRDnTE1axluWuJPk/NPTynrQqvPzOPXRE4lHDxYqW1WxHJ/kJ/3Y3AHjPfQDg1vUgXPVFSoY1KDuR405hsbVzKcn4/TPqVbBtw15KfNaJLQATYQpFCItdIraCwnNLzmySNAvgcXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d43d1df18bso55530725ab.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309391; x=1742914191;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Svpb8PP6bZBAtbgaSvAJuXTALbR5zT82p2qdsD8Izlk=;
        b=JlkIzIKxtcmJa4VWJOHIL3+Rn9imJ2bCAFJIM2/u5WodAkqfZ2ysDnjSOhdcLY2tfr
         7xcKhhW1zF+KgIPi+jKL1AYE5kUut0dVvraCGbLIj8pg7tW5YPJd0DJsPuP41Ioeuexl
         NswhNvO/FxXyjXjxTURfApWw4zjwgMtzoi0FDLW2IaGRX+inG/3NaQROxKl8HXKHx+2A
         qguo1rPH/jdcjxwe6a1GlIHxAFPfJOTKPsx6gFPFVfN3lIt3mJmKzc1V9jP8d1X21BY7
         PwQEowUPI8Vr0kffQdj7nNf0PtZsYxs5d1AzypzrWZIafU84at581B67coiwbgAnqACk
         OkJw==
X-Forwarded-Encrypted: i=1; AJvYcCUg1cBtVw1pdDBnzZdJWgjEOMQE0KLXmLvu37sw2S52Rq61Gv+Oy1K6Gd0Ci1bhL7TNWP7C3c7n4Xtpwk4NsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XBUIduWXpWa0a9FuheGqpLFRpVN2SaxWQSoSyfzIA+9mp7aG
	l/Worr6vOsSmQWjMR6WxFkq12piICXqEjPkGa7n8cQ9r4jZ31xFMvlz+NwP9Z+X1cD3rLbRCl9/
	XfMxv4qBgmYmv4EXkTb71LzGXkGETDJso4heb0NlT8e6fIMG461VSOvE=
X-Google-Smtp-Source: AGHT+IFDs/o3eedmzhMw6Yzzrqxh3GBYltN/cYObP4ptRO7nE4JJcEBYePc11P3ivmib9uw7EuNw2I5rm4LmA7fqY6U6BjJvn8OJ
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1648:b0:3d3:f19c:77c7 with SMTP id
 e9e14a558f8ab-3d483a79cc6mr169890705ab.16.1742309391155; Tue, 18 Mar 2025
 07:49:51 -0700 (PDT)
Date: Tue, 18 Mar 2025 07:49:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d9880f.050a0220.2ca2c6.018b.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Mar 2025)
From: syzbot <syzbot+list454c6e9dbba22fe541cf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 4 new issues were detected and 1 were fixed.
In total, 58 issues are still open and 156 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  101957  Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  8431    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<3>  7317    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  6350    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  5147    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<6>  2991    Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  1205    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<8>  899     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<9>  558     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 428     Yes   INFO: task hung in reg_check_chans_work (7)
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


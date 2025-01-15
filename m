Return-Path: <linux-wireless+bounces-17553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D8BA1257F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 14:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2621884F71
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B423F294;
	Wed, 15 Jan 2025 13:48:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1137A24A7E6
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948909; cv=none; b=ewv21jaqAO0FDnqIcSGBxBOIJSVfGPB2pnWo9Qw3Z6s3xyhx1gfLiNMIP+xAnEL6PCL4xvXe1tQIs7/UmjT0Tl3UAUxKDbK3Oy2va/D0N7Du34liq2po/TBmG7aRZfEnht+EZ8rlMJZwTdfgjgrEAYmEpI63SwlAz3/oaLiolGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948909; c=relaxed/simple;
	bh=rEAPHA1abP0sujPJONmG9VSZxci9i71qDCn7ZtGof0Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ulb9puRhOncn2qeCGZAt+uXKkKBRdm1+ARoVNSEpsAhJGZpJd3+yxVpU6CErSHrLjpG6y5ZhBkTt5/kjR30kQFc5Cr/sNNMZHdL7+uCxmGCOVJ+VjsimHlDYe4x2QhNW0tyk+Q9N31fuD8Gxguh0HsgVQGwZrfvbbgaY8tStC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso121164775ab.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 05:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948907; x=1737553707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NDK5DLIh1fZyrKWvILXfndimZCQbg5cpXOPK/22uk0=;
        b=OO6Bz5hWUBVImK/pP6jQQ5SrPtLF9nODSHNaQuHCiL7F094tguubEm9hwMRGK8s27J
         RxzfcdHwq0/h1gAB+xg+oNUJoDNO/TU8dWCAHBHOr8v5hpezHU26rKX1x/Jbkkv0ah+M
         mvPbVR8JUXUjunvFqO+nzHA55Q9sWUTZ7b0qnY0bG1RwtU+dMY2YZOBnzzeixKnzuvbV
         OekRrchhGMJkphg5NpYdFkZJ224sBMnUrcK4CxdgRFHsN0j6OP5jld7k4iT6K1MxEbsk
         UfZZtAzxowRA4adpMxmhkP6O9jMIgrANAglUKWkdCkb22S09iCOqXLdRMqzzpcBrLW7P
         uh2g==
X-Forwarded-Encrypted: i=1; AJvYcCUak1YIAglg6KEVx/C3j+r6D1ux4CknjbQg+B23e2c60rKyBZiRT+cnUCD1moPzEgUjWxlJ5sytZxXgC87VAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzX9r5haLIPyWkcWJEYqvbN+1R9WidbUsb3uDDRqvsmMpWYzrq
	MjMGY5bFkR1hqR/5ibAhM8Er8NqTw2rX9+L91aT/YxySAelhWMoinebvp0rVtTv8OnPD5XHNDjr
	nq8J4xWfQrK1lVRUYygAFxC1nn7iJl3uBpZkedfj5fZGzkZnjpSOlwic=
X-Google-Smtp-Source: AGHT+IGEJ90l3vPxFfDM1H+9IFajPIQeWKsRHU8XoSqebmq/RfqTf+MjiT4lrbL8LKAzJamxgt+VH/ULcmuDOVGSQJZkU6FlBQKX
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f89:b0:3a7:dd62:e954 with SMTP id
 e9e14a558f8ab-3ce3a7a8ab7mr238896135ab.0.1736948907275; Wed, 15 Jan 2025
 05:48:27 -0800 (PST)
Date: Wed, 15 Jan 2025 05:48:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6787bcab.050a0220.20d369.0018.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Jan 2025)
From: syzbot <syzbot+lista7b682df404894299f40@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 8 new issues were detected and 0 were fixed.
In total, 60 issues are still open and 147 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  70405   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  6211    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  5866    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<4>  5673    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<5>  3627    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<6>  2248    Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  1194    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<8>  740     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<9>  397     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 335     Yes   INFO: task hung in reg_check_chans_work (7)
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


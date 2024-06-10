Return-Path: <linux-wireless+bounces-8751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3134C9021C4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 14:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408991C20D76
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF08060A;
	Mon, 10 Jun 2024 12:42:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DFC80034
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023344; cv=none; b=VDUBZ86L6JCQKYGb4WpRPg07RlACGN5cG7BBX0L3SBjWQiVgl2BBkQSKwsr1O5NPDU5bUyv5D4/MORS4unCPpoOBpvkQoBGseNdjXsg5uoaEyJ3Z1uI31Sjvqkok77MJpiywG79AMf1aAAYKd4DzWT5tVVchJiXr33cz+g1nCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023344; c=relaxed/simple;
	bh=9pEEsEtWPWEZhGfiUREMEIGd4bWdWZ/t/bAlfEEtMyI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JpDERkjilosaAWBkHVs/XFwKYmPRPxDOZmmtGcaE4o7k+VoD2sI2rP4ypV4kI26sDk+XYzzstVovGiHw8Akec0LWN9L/o6Nz22XqO8pv2Z6vWvB/WyfgKzPpMkjPrO5rzTANCV+1Ki2n8E4KwFWO/wUDqgb/1+/dCdpW0ePHatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb7c3b8cf8so155939839f.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 05:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023342; x=1718628142;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heicVqTlBApA6TI6EbgMnMbZ4hjAwK975v9ad8FTkmQ=;
        b=Cw5S85z2PQ+ZcJ/4wASoAlP5rZM2b7emZdSvEAZpn7N6TvMVk48RFl+9qMtABBWyE+
         ZBCABR9TD5OnQO36TWZUM05+3W0UD+JGCSAo6TxGxBhcfmdzhXJmSbbnoJxivZ1z3eMx
         LGBwC9pOXPEZ/nvAlEqvfXnEaATmhaQPV8oyqmIbHeLnFeoLdzumST/vMWbcg3Dajhiw
         CW26sQrbu+YqLQvsSehwNN1rXIGp2F7m1pH2xSLQJQY+PGlJIB6JnavpBQBytnjKVh2K
         i4laBbPnstahQRxD4pQMDRs8YMT0T8e8gVZsJ2Gx+HEE6tX3515LclQZkA3RjTM/lETj
         yJtg==
X-Forwarded-Encrypted: i=1; AJvYcCWoLXM8IX9zkj3NeqRxvm4de/iGIzAhNvPklVsKepW2E+RZgnBofROXm/02Fv9NJl0ab/g2tTzODYqmDBp2oBlJ0tlsDx2KHag7TWj7ZhI=
X-Gm-Message-State: AOJu0YyLslqeRu7kwVfzNMTK+AUR3duH9123K9rFFMgBM/e7jqfxwgor
	bKT8tkOsQGD/lRrLfoPMfRcAiXVrdudLaQM341O8vR23zocj3msRjeapBBPgb5SrNusaGDNK4tM
	xuini9G2KW+hyF4LDWc3DT33G96VNn3vqzqWGCKlr1VXdnWGeyBAG+9g=
X-Google-Smtp-Source: AGHT+IEyT9p7QIQnNyVpJrU0YYdOPI3ODjNeVogYq48fPpzX9uJ7qFz2vhUWpnZi7onh2qxhPpYl62XjU2EGJHYQi49NozbacFbk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0d:b0:374:9a34:a16 with SMTP id
 e9e14a558f8ab-375803c115amr6908875ab.5.1718023342579; Mon, 10 Jun 2024
 05:42:22 -0700 (PDT)
Date: Mon, 10 Jun 2024 05:42:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ceaf8061a887b5e@google.com>
Subject: [syzbot] Monthly wireless report (Jun 2024)
From: syzbot <syzbot+listaafa45acbbfb240a1e5c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 10 new issues were detected and 2 were fixed.
In total, 35 issues are still open and 128 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  9438    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  4499    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  792     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<4>  578     No    INFO: task hung in crda_timeout_work (7)
                   https://syzkaller.appspot.com/bug?extid=ef89ef34c36478f35fab
<5>  312     No    INFO: task hung in regdb_fw_cb
                   https://syzkaller.appspot.com/bug?extid=9d8f809bfaab2e794297
<6>  161     Yes   WARNING in __rate_control_send_low (2)
                   https://syzkaller.appspot.com/bug?extid=8dd98a9e98ee28dc484a
<7>  141     Yes   INFO: rcu detected stall in ieee80211_tasklet_handler (2)
                   https://syzkaller.appspot.com/bug?extid=f05226202eb082367495
<8>  83      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<9>  76      Yes   INFO: task hung in reg_check_chans_work (6)
                   https://syzkaller.appspot.com/bug?extid=b87c222546179f4513a7
<10> 44      Yes   possible deadlock in zd_chip_disable_rxtx
                   https://syzkaller.appspot.com/bug?extid=0ec3d1a6cf1fbe79c153

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


Return-Path: <linux-wireless+bounces-30161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8762CCE6364
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 09:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 655AC301F262
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9CA27F736;
	Mon, 29 Dec 2025 08:12:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE451258EE1
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766995952; cv=none; b=q4tmsPRAgZQUesORQ+ifUSu7Q31J+nGSHZmdsGVmpFyT/X5vb9i+8hOQ/8q4TsFfvdglSDNkhYPgYEqgf6cFna6Ju98RJPNHBWPmA5QqbFIYDONcd6OyFpXG/t9D4y96mStiCtm5WWA+Ufata19mq8XNgRUJqMWqR7mUD9XlhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766995952; c=relaxed/simple;
	bh=caSHQVM0m370hsO+rhdbAuVnvf6gad9yFxMTvReJcVc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d6iaJUo3qfdbGJRCILoo/CkjFjJRRh02+Cuton2mkuM7F0OjYfCF94Pabo4M+jkZ5I2O16J/Lk/ez9LEjUi0HjYpCcE0luYLed8Uq4+PMXxBtsDYFKir7i3b2q0AW/PAoTNbLakW7iCz8FXp85sFWC+EWibgjwGuhwhuR1K6/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65d0318e02eso17209766eaf.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 00:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766995949; x=1767600749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrnf/idZpb6+gkxe5C5ynJACdIpKJh9ambqgJ3NgmPQ=;
        b=hQnqY9UJdhMc0lJBvia9RKXqxl8gJutNOsL37O/Ncxn/UEtV4DHUt6cBHZZ6h3nCDG
         VAacnN0kZcPKH9lbr9paZEXbZZhRNSsDzZepnvlvYL2Zs8nOT2pX8Wwi/IX7YsU9Eg4J
         xGUsLYuKqowS6Gay3sp/52I9s0acPv5cV2nQHjNQLxenCAZELweAFUt5pTWzpOjruzNf
         gaYmzSXiN2RD7tFo2C6CJweLHAcz5CFs9Ut7EYuoijHMwmSFX6deQeew8ESQ+yI5yu8m
         p+cWWO3fh33gknIjuPRnL215xNzb3xvQhnf/mLo9FwOx26ePmi7cdjBxgItxcMPfHKuD
         6P4g==
X-Forwarded-Encrypted: i=1; AJvYcCWn88cC+4KfEOHPHgrHNTaDTyFTsPs5Ets57I3wKDscehmOqJNWZD3Ex54fQK8q7Rwc1opb0020DSndxP/4aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzFT0un7pW19HCxjfDLxVjQ1uAsw7Vj8Sd4w+Wa+nJmT2fi08A
	tHkY4tZ+1COkB/AL+utgeFFjzZL00AwFJWBWB+LdurijvH+zdc7wCPD8+iN9lddT199BD8OcotT
	V+ViXI5uiNvwtEWKhaKy1TbahR6jenZeyc6DBM0TmUjWIJpClGBjnRAGOEHc=
X-Google-Smtp-Source: AGHT+IEmeFOTtcKFlHjcQ/kTw1US19ZSVepOmwjNuslfNCdJ+rkVK8SINosbZqjc6mIfQt89gJOueOAqIIQvZgOTHT33GolxDpXZ
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:169f:b0:65b:3d3a:c1da with SMTP id
 006d021491bc7-65d0e99c590mr10848147eaf.22.1766995949671; Mon, 29 Dec 2025
 00:12:29 -0800 (PST)
Date: Mon, 29 Dec 2025 00:12:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695237ed.a70a0220.c527.0024.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Dec 2025)
From: syzbot <syzbot+list219945b321610cab0aaa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 0 were fixed.
In total, 55 issues are still open and 168 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  22817   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  10456   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  6904    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  5297    No    WARNING in kcov_remote_start (6)
                   https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
<5>  1226    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  1085    Yes   WARNING in __alloc_workqueue
                   https://syzkaller.appspot.com/bug?extid=392a2c3f461094707435
<7>  949     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<8>  804     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<9>  706     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<10> 502     No    WARNING in ieee80211_request_ibss_scan
                   https://syzkaller.appspot.com/bug?extid=1634c5399e29d8b66789

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


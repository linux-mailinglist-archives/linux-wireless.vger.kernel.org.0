Return-Path: <linux-wireless+bounces-26584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900FDB34086
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 15:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067E43A12D0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C618F271454;
	Mon, 25 Aug 2025 13:19:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405E523E359
	for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127983; cv=none; b=BoadSmYZM5TJ/FWzgyRpLnTy09RRaEY9Mj9mVwgMoiA6KFaLmod8p62vBafthDw/tj4XDm5pi3zDc05yTGPiwUTCOTP2BQfaK6BGznJ6vFbFkt4bWgh99CLUGXUL6oG1B2GwoYP2LPOwiNTou9QAdFXCdsZhCPq9AjDft/Zc26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127983; c=relaxed/simple;
	bh=+9IB9WziszMKDIpC2OrkuBMYVVkRAN680M6KTOqjsuw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QWwcOVCB/JfhfHVtPcJM45g/gc31jTAV0+canrfDwYhTQCplF9zfnrqbr+nlL63BaRASQ98piiGqqoHAlp2pvkwtfC0NMLxLhxXDNa9NTYuvY99774JKgxX/jmts48cbWVIA+XivaPBBmh8+rRbCInCSRzNHZihZl6shwySuhtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e683419b91so45906255ab.2
        for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 06:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756127981; x=1756732781;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juYOjYCxHRD5LRE5tU3Vx6b+gmDnhYoMj3EW77dRvbE=;
        b=JyW1PegNzWxMfeHaVoe32n+OYgS0VwPoTz3/2ADQ6yehqb7HbrBwdnzWJCf1a9roil
         8sUFfTZ/7a0+n1z0yevaF0lAyAdntXlpPKW4e3w5msyGDFwNZcjTCqB2bpph1DoqtSXt
         g/tdCMNkxSAZ8Vf6C8vhjqZ1pKGWY9K6Eja47FdL6Hc8Ya//Zr4hhtWmOSoJFavxYZkF
         K622PXYOQ1W3bSLti2MOTXAIzPUrFUvkMIqvJ2jgCqayhaoWl/P+fX3r5c3Y7y7alQBx
         AqFx4IY9ZMiCMo9p+jKUHyZiVaRs1s7/cVefaPMO9oMwxFClnhDQT3hBbqBMiKv/QzAL
         NL/g==
X-Forwarded-Encrypted: i=1; AJvYcCVq6Al6CZZreyAihIzzZveiCVxrZUn4incmZ0AgwJt0cZJ5T+oByu/HKqir7Wu61MWo09bEWDmMfcmlbA9a7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZZ5u8LeI/dnKbEcAbMNGWXuLlhBRoKnhfKPdYoTPW96s8bNF
	D2qtZWKAuAj/EJr+uDup0f85jTrz5GhGQ3cBqrJzeI3fVMK9YfQxe5U0HabYRKEhuCwb4RPsTY1
	T3KwKbu4d2eAJSrGDYKJh5HmGDWSXoCvTgT06AoDgt2JVJes6DInlbxuCWlA=
X-Google-Smtp-Source: AGHT+IH+Fa1YLqlDmckXgD92mtNS9aAA1CQSVem4GQWbw6iXFjFQp8bGQoXl/3rO44yA9+ecsSqbxxDcj7w/Giu58rq+v8/u0hpK
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c03:b0:3e6:7b31:bd71 with SMTP id
 e9e14a558f8ab-3e9223163cdmr198612905ab.19.1756127981125; Mon, 25 Aug 2025
 06:19:41 -0700 (PDT)
Date: Mon, 25 Aug 2025 06:19:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac62ed.050a0220.37038e.0090.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Aug 2025)
From: syzbot <syzbot+list2bc72db5b39b8844199b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 11 new issues were detected and 0 were fixed.
In total, 60 issues are still open and 167 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13761   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  10125   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  6847    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  1216    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<5>  836     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<6>  703     No    WARNING in drv_unassign_vif_chanctx (3)
                   https://syzkaller.appspot.com/bug?extid=6506f7abde798179ecc4
<7>  679     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<8>  583     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<9>  519     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<10> 470     No    WARNING in ieee80211_request_ibss_scan
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


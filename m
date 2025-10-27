Return-Path: <linux-wireless+bounces-28296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 232AAC0C5EE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 09:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BB018A325A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130C52F0C67;
	Mon, 27 Oct 2025 08:42:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625532EDD4D
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554544; cv=none; b=MZ/O0gopFWbKVrMRYrbJnPIhU/hHbyYIqGFTChAjWNoXj/KKigymPenYIXlKq5OLzqwF7iR3Fjvr6nbePqF1ZWoQaImxK2XuKJxgOi4V1i8W0FUIePNs/j9R//Nwyk01DImXFspS1lLXim75wqDVa4cL5L3m4eZJig2PCqvgMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554544; c=relaxed/simple;
	bh=uw6SuKPEw9ILyDhG15sYXFLunD4TsxnKEIFs3HWKFYw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g63H9cnleF2V50p8Lxx5c/o5MaJqjoEYG5H92jWWO76xsTkAXElLKSpjo0JBLzcPonXO8SvcAzJ6p3/FU3cVnN7oqJyiZ6TLcyVBuzSWJpkEmpSnfttF3Q60j9RLPGhFy3FGR4qcHnWoO07MvjZ1H0wKQi2cZNV5HsZ8jAQNJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-945a5690cb4so439707639f.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 01:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554541; x=1762159341;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNrT0X/VmxwDKtQarc0omjL6KzdSddilOyB81dzZzsI=;
        b=ESP9j+g3LjYlaqFwVVb5rPvZswY8Onbkx58ITJHtw6d8dxoE4NDg5gxXtwKC+LGynS
         4d/P4signy51lyzdHVnK97CSxeyUfgYgf/0ksNyfUHiLTffXpGbhuzZqpzzQnq7n3xpc
         AG3+Ext6LrSYmCC0hGQY04EE4joNZNEQzB32pdH78y6rO1ftAZvM+UzKZEluNf8vHC05
         Sk0Z7AQM2bbXNCqjATWo/sVwjsFYDrCLpoD6xCbNOpARJhRy+iLVZOu+cjree8i9xbOx
         nXm0a6rw5xjefPGJq94akUk6ZPooAy6FU0Hd5oE+LEmInVe9vjNVOvN1Ne4sPyU4GFiq
         duBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBDBgseyCvBN8AyHfVp+KJr7nkxEodsrX6rQq0dtMuZdwanEIlrMA5HGqwjY+f5658CjqG9qoaYn4aD5p5Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgRIL2ftRf78+CTR/1LpXkBugkpynituXw5pAjY5yuKIDOapA
	x4JI0a8mm7eHZjVF13qzQTxEX3112U0OswAqlCJksRKorRSCW5BwQYJyU1Sama7FFTrfOI6OobT
	hntSgtUSOK/TbB0Fp+g0bq2dEgra6G6VExGc8/P3daPEo8w2BQlRqYZ62rOo=
X-Google-Smtp-Source: AGHT+IG++kRyzF4oUbz/cWZZzqub111RjqBwcOHY2xI+WnSx7+MeU5kEIOHXV1wYL7SxDjkbXhDFnNzeBqcnAT/HOHMFsUkFaSWg
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6425:b0:940:d37b:8957 with SMTP id
 ca18e2360f4ac-94281994459mr1343513939f.11.1761554541490; Mon, 27 Oct 2025
 01:42:21 -0700 (PDT)
Date: Mon, 27 Oct 2025 01:42:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff306d.050a0220.32483.0014.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Oct 2025)
From: syzbot <syzbot+list7b82037e64efa8c01de6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 0 were fixed.
In total, 56 issues are still open and 168 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  18147   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  10351   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  6869    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  2043    No    WARNING in drv_unassign_vif_chanctx (3)
                   https://syzkaller.appspot.com/bug?extid=6506f7abde798179ecc4
<5>  1546    No    WARNING in kcov_remote_start (6)
                   https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
<6>  1225    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  864     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<8>  760     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<9>  602     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<10> 599     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


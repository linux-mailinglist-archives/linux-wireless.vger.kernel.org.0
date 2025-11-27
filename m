Return-Path: <linux-wireless+bounces-29371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F55C8D289
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 08:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4211D3AF7DC
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 07:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBCA3203AA;
	Thu, 27 Nov 2025 07:44:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58531D735
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229471; cv=none; b=Ahpw2l2qUqHgVdnrEGzPBJBwiQ/9v+SSbMy32g5Kj/UkWQJIScVBra+CJxhKj+h6CjGH9/o7/Ua5H9rOBOU2XPhC94NtIj2PQmf3+WojX0EkVb7W677idBUA+WjNP9qdvGWmV0AExCwHW627ltDC/xEMbJjcOYqaQEhtj6QndIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229471; c=relaxed/simple;
	bh=IxMWzc3tX4oZvzc9kbMDyFaHzWf7WcpZddgUzdnoHns=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BoGtoPpeZuKvkB8s4tl/O+e3PfmCz9jxzWg6afLFg/CYnbZjxtZQ2G4gbSSrvAzi6Zh4jLVRUwv3aEsy3e7vVha1Mc7B8zcGJw0GGqQmaLP6/m+yZQhwEJfJa5ZKFZXROa+dkYz7QB49vvdGDC+F72LOW3A8THTwFU8MP8U1fMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9489bfaef15so36315039f.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 23:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229469; x=1764834269;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFrlScuPKAMX9Kds0z3rklBxPhhPHkr6vMqn2nAcZqY=;
        b=IptxP1bJ4OGcPHOQOFzl5mwXtf2sMMQJjVNj1j4PhsFa85eG0F+UuUlKg42oz2S1Jz
         AYK2Kt38EHdAWEGNxulBEW96OGBHFUF8Vy7LjUh9BtBUWbfa1aYr7Lx1AxP8QjuNGAfA
         oDYnu/5iBRthBrLQJDOJQrXvwgYOksVLbS9guBFG4WjOBIzLR4amNdYHS2mpKYu6CBqG
         FdbyeNZkx9mw1Vasv84WE7hW44qDAOWfDYBPsS6OVfIfyzDw+YR7UU74HDnAamBPtDze
         PEELcOfWRgmTEPCNyz7h+io3K8X42kxuUef2yAePl/8eL/AiAabRROxknoacXuo/vDYD
         zD4w==
X-Forwarded-Encrypted: i=1; AJvYcCV/gcGn8zQswBhl31qJKklt3DIzVmtCnxb0GpBi8+d/KkH05HAH5QtLq8wg44rCKqFeMVDnJFLmIVL4NiFLJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycDi3ao3+699clchaCqYKemG08TXtZ+/eQoVsUNTNtsyu5+DUK
	MIu1umJEhKBBYTnyOL3bxpbPMI26C1ta6TqhcGFRMdGbyKqDL2C0aMzWevNn+eyKFJpLJdx52nv
	HRiY8KZPpFfR06hMINfBBSJBoV+NDimBiM2bukaHr6c8+UAeWRPs3t/eatHM=
X-Google-Smtp-Source: AGHT+IFXAllXbFe5/g0Uxt0e8wcJugknX6XuPgzmtGOPf4LrPeVhXYWz63o2gVbl5RyOyMhWNfoKBWNdHBaebMEMHx/Doq4fg/Ys
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2e:b0:434:7d59:cb28 with SMTP id
 e9e14a558f8ab-435dd099317mr76864995ab.17.1764229469223; Wed, 26 Nov 2025
 23:44:29 -0800 (PST)
Date: Wed, 26 Nov 2025 23:44:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6928015d.a70a0220.d98e3.00f6.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Nov 2025)
From: syzbot <syzbot+listc2c5a1a76da717aa6f55@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 9 new issues were detected and 0 were fixed.
In total, 59 issues are still open and 168 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  20722   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  10413   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  6888    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  3179    No    WARNING in kcov_remote_start (6)
                   https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
<5>  2772    No    WARNING in drv_unassign_vif_chanctx (3)
                   https://syzkaller.appspot.com/bug?extid=6506f7abde798179ecc4
<6>  1226    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  892     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<8>  775     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<9>  652     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
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


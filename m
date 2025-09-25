Return-Path: <linux-wireless+bounces-27651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A013CBA0872
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 18:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06721560096
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC6303C87;
	Thu, 25 Sep 2025 16:01:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365F2EC08C
	for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816086; cv=none; b=LUKTZrdk0dVFiXyucuG/FjhZMi0jGMlahDbDQTQdxRBO3AukjwGA3P5zEI13jXT/iLxM1D89JAuv0PO/4fmCMnz9DMEs2pAUOUjaFj/L32937dTosW4H2SlkV4h4f0YzJbMztk4hO4OwcGelcbDc0xL9vSTVjIK9U6bkevAIsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816086; c=relaxed/simple;
	bh=vDNDhXb51t11ecjweGcxO6tZH7hRi/SsZUkwnb+CTOo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C2r4idiBS5xAdOGBB6qVz+cc2xT/jnvq50b06u+yGrtp2wkg7V1EDUEyihy6njJ0Vhra5CXcO1FSzoPxXKI7QzUFwi3//V9Wity9fXZHyHgvQY6Wl9WVbNfw4aN4hjtnbFNWuS+qWVb6T9zLwTCAw1zp+I4srgZt5MKICSiePOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4247661a0c9so15191435ab.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 09:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816084; x=1759420884;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wC9eoNmxGFzwBPKZvnASVvExWPvQq7FONJl+BGjmkSM=;
        b=rrGSIlDTsnsLRB5B9Qo/UoMSLcuWp/L5R3a8+BvTW/tE/Vk/YsktnQVKFCtM/Lfkh3
         i1NYK5bm/+NXTs9SxRfbeeuu38s3TGgE4f+aMXu9QaPbldTqcuq0g7JO3ier4E5aYQT2
         LmfD+UIVjsIcfeZ5KDCQNx9aWxPlo2ZN4UdbBZ0lLqem6orodRX1hGiDD16sGFwoihSN
         bO5AWxa1vys9LfFS7y9moLxAjqTCKM446aKQlykjhYVYgzDKk2BqFGtVz33eAUIpgEOm
         Bew2KWfrWFkE8qk70ruuL49x4CpKThn/FjN86iBZRdbdpnEdBUoozslvnAfuVf6ScMUF
         cGfg==
X-Forwarded-Encrypted: i=1; AJvYcCUY7zwdCXIlXaKYCpqo6MOmB7Gq7sqTAY4C1Fw5xBAwN1TUUJm806e+PrW4331TyJXtUzrwllUTuXCN6Vy2rw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4ge6Y9ypPg+ixlcI8MFCtGcFxkmz8y7rbyxLZRPTZfKf2Frq
	36+WqMXVQ6eXGVp8bkHXrKRhAzKcbkgTIJ3PeHSjL/3xoa+v4dPc9bgxh84O5J7WC+oUrxbuoht
	k0uJMq2mgVr0V25pJJSM7eWc8QUpfL5mMpkcUJYeXrrKiaMoTbQxFlEOxuqg=
X-Google-Smtp-Source: AGHT+IFqidjahOsPHralLRd7agu4VD0AO4qJ7WVMC7UNgEJhzK16ZgAQFMxVKpXj9sskRWloeV0Mr+kSq5E0JX/l2uo03MoXq8KU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c91:b0:424:8b66:fbdc with SMTP id
 e9e14a558f8ab-425956509d3mr46700845ab.28.1758816083860; Thu, 25 Sep 2025
 09:01:23 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:01:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d56753.050a0220.3a612a.000d.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Sep 2025)
From: syzbot <syzbot+list7a42d00aaa51d0121b8c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 1 new issues were detected and 0 were fixed.
In total, 56 issues are still open and 168 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  15578   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  10293   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  6859    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  1291    No    WARNING in drv_unassign_vif_chanctx (3)
                   https://syzkaller.appspot.com/bug?extid=6506f7abde798179ecc4
<5>  1221    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  842     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<7>  734     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<8>  595     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<9>  564     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<10> 477     No    WARNING in ieee80211_request_ibss_scan
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


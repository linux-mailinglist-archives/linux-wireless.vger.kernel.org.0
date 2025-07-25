Return-Path: <linux-wireless+bounces-26016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B8B11ED4
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08685A463C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D32ECD2E;
	Fri, 25 Jul 2025 12:39:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511772EBBB5
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447173; cv=none; b=VcPnE2axd4Sb3qIBTMaNssfPs1zaBzQY5QrS5ktCa5QQLPN9YG43atKuRubjFlEXHxjQpgjhlSNMe+bmrwbn/QOtg7D8bLuBkanI87ApXAgPBObTJkms0k4mRGA1qNisHhQXSOKqzRV5io4BTV200jYgVWYrrlUCEltxw/wxpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447173; c=relaxed/simple;
	bh=j+a4W2shNO3E2WvLnM7Gg4ZUOiPasmfuQFrkEvfwDws=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LrRf/js1vtqTl1iuSeUcNc7K9uhi3Lu9plUxOG5IP5O0aSbjKC0wlUR6JJFffs63rNgCKgRqii2Ja5mjPC7hQg+cAheDVDEUvyOWmkX7bidYbe9io3/mwzZVCa7LYNQfTENuDtDXUX+W2RfzDNQsvJtCnYyEY2+ndyOUQCrhUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c2b11be82so233180239f.3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 05:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447171; x=1754051971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DsRRqNHku6ZeTrZx42NT9gZz/zhlyjxw4E67HoXW6+Q=;
        b=kCZ4lceYrJbUADC8HACrXMTqivmjMHO+w9V9DZxkB0VcL5cYe8U1HSCwtkuA660F+v
         mjW4PePBOFxbRBrypekn4D8GFssAxkGQnYNCJDIePtSwYtHWnnJiDmb0cdEo4S8deq4r
         LCo+OQLkPyemZz7H78WoorE7Aln7/8Wa3ZVbsBtoK+vQRYpx2Ca2B+NLWlj+WHi2dvma
         EJcpzPGZzPk3EbNMiVEtGzRBMKeH85+NU3zMBsFgcHYXUt7I0Wv2Vdq58OkUP4RZ9sr6
         LWGCymlSKzGV2WO4DKD7ZJOei8xuj62q3rQj0grcJB9ItbZ5MOXt69ckReeZEl6L7GmL
         dHyA==
X-Forwarded-Encrypted: i=1; AJvYcCXa2I3HO9PnvEOlI3yQA6izSBZQJJ69JWG3zuhsfbRVXuBq4LeQB0BMeOx7K7COfoSXJcxdhHW77ChRM9t9BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vwSMEcDCvPjeYWLT/a/647DomZN7AeqFdv5nKjKoqZKtQbyu
	9SmKm/3jGQiO8eQGTPwjDdS7potYxIJtAgh8DhDTN4PoYS2xT6y+ch6Cx4IP4u4r41zOcSJbVen
	vMxEYdo6jeNcHUUcp0TqnNpOuPADgMIDn5u1qayxZo4JuCgm/ps8SR47pl4I=
X-Google-Smtp-Source: AGHT+IH0F8Z8GN8WXxDT8Boy8j2mXmuu58wAX84J/uXKvxSVcDkuLOBTc4CxdIJ60uw1BF3KmlAN3kg/hAkEeiOghmrHB83fYO1a
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6016:b0:876:c5ff:24d4 with SMTP id
 ca18e2360f4ac-8800f114ff2mr296894639f.4.1753447171528; Fri, 25 Jul 2025
 05:39:31 -0700 (PDT)
Date: Fri, 25 Jul 2025 05:39:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68837b03.a00a0220.2f88df.0051.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Jul 2025)
From: syzbot <syzbot+list7eb4325eb2535c41d4b1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 4 new issues were detected and 2 were fixed.
In total, 49 issues are still open and 165 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  12509   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  9621    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  6819    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  1216    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<5>  764     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<6>  623     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<7>  577     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<8>  492     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<9>  438     No    WARNING in ieee80211_request_ibss_scan
                   https://syzkaller.appspot.com/bug?extid=1634c5399e29d8b66789
<10> 208     Yes   INFO: task hung in ath9k_hif_usb_firmware_cb (3)
                   https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


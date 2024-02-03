Return-Path: <linux-wireless+bounces-3077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D6848481
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 09:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B648E28A270
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 08:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02885C90B;
	Sat,  3 Feb 2024 08:34:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BFE5C901
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706949280; cv=none; b=SONg8e6k1agFKDD2QkGy3caZuJDQyCH5575s+RIhT1Ql4F0GsjfNg0t1tWG2WBH2ZxEEUEzBl0wciTO05X23yJj1+vk04H3LdWLS8VTtGRiUwBy5lMImXVnJZVwJuehzhOi4xb90Ev68cDqhSa+VCtAvibaQZXjxht8ZnmGYhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706949280; c=relaxed/simple;
	bh=dREloSxjsQd3Dm2TwTvLLgS4yjeB2A4QST2I21fOKPI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jwWGcWTIivBwkW1fCg/LaRjbkOZoxdrf0RuCYTJyAKm6oPKvP80ttqvYOq0dkiRk26u3jEExrLUZMvkMhdfWLn5AHV2m37JC8E3yTgrc1YQvK35Tdk219EerFlrL4rXIdrjSCIIp/NKBxjyYUWKrEjLnOJPE/kilwcTRPqKdDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363bc80467bso1782925ab.1
        for <linux-wireless@vger.kernel.org>; Sat, 03 Feb 2024 00:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706949278; x=1707554078;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fET0Mp30kk4vbeHTvxgVRyoa35Y2AW8JHcb4p/vnIZs=;
        b=LjuRUR9U5zioDVJ4YRGrlSGMhq9UrhJ2Og9k10IAOdqH/iCSB7IZFKi1MBL72lO+zL
         /2WefSCan1ed+K9wvEeOh9Ly+592QTDWISFORHMFvZKmj5e0d9gM66XtvB9FvKyvWU7+
         OlvNb7wNLgwiLQxo5hVfgzLig0gSAF7+jT/SSXBpUhhDKqcxqyGvswvbuoRmYzoVau+1
         kuFxkQb3FrWnhkmVWpEJVE4VXsfYXvpsvVHYcEyAogvi9EJaLqu7PjpAZ2JHEuk+LScO
         KUUTcWhbR7KYMOgwyRZvPMiDjqdU/goMz3MD/gw27ZrICgaV49BUixyHjlBiE5tURAZC
         L87A==
X-Gm-Message-State: AOJu0YydbG6zjTQolFI93eYvdYCxRSeoPCD3L48nqf2zcyNo5OLjpcoD
	aoWfvV4G2I5GRbZm6bmTzBso4vFYbbtYeXKQ91yh1aBDj+gkavEsGDZKMEXko7NHrwoJV3Jw17u
	tN66arIXbTkXRd8E1wSl9qtiuuoMUSd21OWq++UPFZAWew/ydo/QjtUQ=
X-Google-Smtp-Source: AGHT+IFCSqaViRTl7MXK4bNIJv6w5IfZz0CUOIsCDXUztj9Lhe7QGIjPGGhRjUSlcdy2uM0cIfvFU0WMYzqMXfwCCvFSZP34dMZv
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:363:8b04:6df7 with SMTP id
 s6-20020a056e02216600b003638b046df7mr68726ilv.0.1706949278191; Sat, 03 Feb
 2024 00:34:38 -0800 (PST)
Date: Sat, 03 Feb 2024 00:34:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006057050610761986@google.com>
Subject: [syzbot] Monthly wireless report (Feb 2024)
From: syzbot <syzbot+listce8d4b19585dfc84b816@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 1 new issues were detected and 1 were fixed.
In total, 28 issues are still open and 120 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6696    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  4569    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<3>  4395    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  2892    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<5>  851     Yes   WARNING in ieee80211_bss_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
<6>  844     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<7>  747     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<8>  717     No    INFO: task hung in ath9k_hif_usb_firmware_cb (2)
                   https://syzkaller.appspot.com/bug?extid=d5635158fb0281b27bff
<9>  66      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<10> 46      Yes   WARNING in carl9170_usb_submit_cmd_urb/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


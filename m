Return-Path: <linux-wireless+bounces-7218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D38BCED6
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 15:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBB9280CEE
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841979DDB;
	Mon,  6 May 2024 13:18:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2957603A
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001516; cv=none; b=TX2z2esxLlMH44NhXbC8jwc6e8G0wPr9/d6BCoX5FLuS9RHgNS+zJfNyOmBBbe799rn1Hpys/IW0PFNDx4IWqCR0V9222qBP8pYlz5ujsV7QtU5WGG80QllbPwpgKAmo1cJORx3419ibxGJC3BHEgMXmCn4Z7knhbQ/v2hUSouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001516; c=relaxed/simple;
	bh=c0Vge8iTB4Lpbpsuu3+m+8p+N7McCY3fFZYh0TSFI1k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qlnIkOXUN3WIimzicDAaSq2DvtsD1F5hf2d6Mks5FB8fo03no9I8n2MBbVpfOMiVnoTqiHf3WgLNDSTqAu3uW2MLVVpSvO8HzX9UmaFlIani2QAJJuDqjIoE+z9OCy/PEsFF0Nx9NbAVYe3JTFGc0BPNbswlPJm9HzyVKmFljkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so153148539f.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 May 2024 06:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001514; x=1715606314;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDXohloZ5MfuZXfB1DDbljelq8gj5pZm9laaAT/1VtU=;
        b=iHoSAHni/zgz7TYV6xp2oC3QcKRjLxdvrqvTUMZmtqkuwwM72Ahy7BlQV9Aak7EAiA
         7Keo/SlGf6LeI10VrcgdPxI96bHtK7vW7Yfk+AL9AUXhlzUWXuSCZMTt4ZeZIpCBmbhX
         g0q0dgsKMYV3cRDv8EkpZxPIf5jPfnLE0AjjnocLh4dd9ZC0KORRjSm/oNXlQG/BDAkz
         ktHQ9xnQ7wuB1c1RzX4bOkIXdZkqQU8NK9XHp1FvdqwA6jOWknUjZfypj60/t+fznzD+
         MLl/pTHvI0gzHENNREYi0n7c9nEabplJo/boh2iMBuihyN6z++6KG+x7Gg7MatJUuHTp
         2waQ==
X-Forwarded-Encrypted: i=1; AJvYcCVswm7zMFrMJJEoOdfUie2LQ2171RaiGMppfnkCdJz2zztFj+xCkyVTMx3oTbnM36V4FXbsn36mZmX1HbsJichMVesOzPwtujMwn+eKHK4=
X-Gm-Message-State: AOJu0YytwuLYpKBRTwsPqcTfDSUN7PAJXL8MchtLahAnzSy5Ha04Jjk+
	ti4HoarEzFJE6JTXNwYna3XZnfEVYhwWMS8yMpgO1NfI+Ngm2sm6hIc7nDbdTIvpQUh6Xkb0OBh
	sBy179H5bNp/r9lzwrrNn0lhvVC4jn4sGlmJXyI0rW6j9smHKGw1hMtk=
X-Google-Smtp-Source: AGHT+IG8fqvQzKK0Ndvb55M8AEuR45mSb8N9eJk1/kfk+AJ8UD/zRmP3RQCdND34lbZorwZshYw4n9A2jtESUdb4TIuax8CXRf67
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8426:b0:488:6017:abb6 with SMTP id
 iq38-20020a056638842600b004886017abb6mr450659jab.2.1715001514173; Mon, 06 May
 2024 06:18:34 -0700 (PDT)
Date: Mon, 06 May 2024 06:18:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ab1040617c8e8da@google.com>
Subject: [syzbot] Monthly wireless report (May 2024)
From: syzbot <syzbot+list0eee01f891cd031c3139@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 0 were fixed.
In total, 28 issues are still open and 124 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8381    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<2>  7730    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<3>  4438    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  3478    Yes   WARNING in ieee80211_rx_list
                   https://syzkaller.appspot.com/bug?extid=8830db5d3593b5546d2e
<5>  879     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<6>  774     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  79      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<8>  10      Yes   INFO: task hung in reg_check_chans_work (6)
                   https://syzkaller.appspot.com/bug?extid=b87c222546179f4513a7
<9>  7       Yes   WARNING in drv_remove_interface
                   https://syzkaller.appspot.com/bug?extid=2e5c1e55b9e5c28a3da7
<10> 5       Yes   UBSAN: array-index-out-of-bounds in htc_issue_send
                   https://syzkaller.appspot.com/bug?extid=93cbd5fbb85814306ba1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


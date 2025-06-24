Return-Path: <linux-wireless+bounces-24410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71CAE5E1A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 09:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13BE1B61FA6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0A72571DC;
	Tue, 24 Jun 2025 07:38:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A904255F56
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750710; cv=none; b=nYiCGynk6oCQ6m9FpDeaoEhggmi9Yeco5Q6j1chFs+T73rUcCH/pAkihDHRFQNceyY9tYi5zMbs8PCKS8XdwLF6++b9hpvdWauapNUhxq63CZldsRPu6vuYgDHr60Jh8jMLC/uy/kVUTeVHBc+PYoKvDw7ZHk4yppRxGVH1gkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750710; c=relaxed/simple;
	bh=bu7lf+8eNZa6HkeLexi/tLJzh61KugG0RPEB9GwynZc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E9fEfmz6//v5k+ynZijvVPFlZvcLgMw7Jv4ZVK5UgDPPOigY9gfSVE28HEHyoF5YAQRUNkkQwvjTTdXhwBWA9Js9dTDcvpbC483ZQVzpcK2ZiTFslf4etMreBBinDgregzjy6dGs37Kz5dAHr7ugP4Iw+7PJlWJdrSCExVQ3xLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddd90ca184so841295ab.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 00:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750750708; x=1751355508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dD1pfGKpIHd7EJHi4GSso/Jg7ueKo2Dyr930wdR6pvs=;
        b=l6IhCUsMG6s3yw+Apzd3+duKSzrCraewU+LV9e8jKxjY3uG/Je9vq87C96OA7K9sYo
         vfHX1vcEqbpZ8NXA9iNG/hVHEdGgVPRFFsvZ6lLWefhGkpaqEi5KcXNclWwc+PFVXnbt
         9edtASPMjAb3eyT8Bv84b4cA0auBDyz9spBWjbYa24FSBzGumLp4s2nIdNjBNr9o5d7e
         lFOtVJLIaIpt+YxuaMYJ+kZyhvuf8rPHGZc6KKFI4cTkCwborno97zoWlt7jenDtugJZ
         7gC7Ak8oq3eKmYRDQV3QgZ5Q2od+qRtuKumVTcE9g8HszUZm2OlGd/sz2yF2feFqQDVc
         vZnA==
X-Forwarded-Encrypted: i=1; AJvYcCWkw36AzN4vFs6cVz+80a4KBlPxsyI5ZY8szOrr6ck5xJjq2ccUtZdvzk9c0jdllJXR2OgEDyhAfm0+yJsbiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIXUZZOziYbzB4zTdqXDqagWQCSKTkl3av9Dl1BEOgNrcbb3L
	om2mbfJ3CEDa6+equmW+jh/DwkYTtp7rNKN5OKcph51X80EhkcBitI0yVXvvIUmuHl0BoKLf+zB
	wWwbnjesbcWPlQzAfaxRzef+z+qDxezk0gNpSf1BMRPLXRXJscEx1i1Kt1CQ=
X-Google-Smtp-Source: AGHT+IGFvan+sLVICasUV9mrknNLM93SyV2I3nVI8xj82yoT87rTsXmrftSXQU1UlH9ARBM7yizP6NW2nEvbn0f3fQybPgAqy8c8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8a:0:b0:3dd:d98c:cca9 with SMTP id
 e9e14a558f8ab-3de38c15abemr181040565ab.3.1750750707815; Tue, 24 Jun 2025
 00:38:27 -0700 (PDT)
Date: Tue, 24 Jun 2025 00:38:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685a55f3.050a0220.2303ee.0007.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Jun 2025)
From: syzbot <syzbot+list0a0103c65a978177d9c8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 3 new issues were detected and 4 were fixed.
In total, 52 issues are still open and 163 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11683   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  8852    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  6771    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  1213    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<5>  654     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<6>  571     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<7>  559     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<8>  431     No    WARNING in ieee80211_request_ibss_scan
                   https://syzkaller.appspot.com/bug?extid=1634c5399e29d8b66789
<9>  430     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<10> 201     Yes   INFO: task hung in ath9k_hif_usb_firmware_cb (3)
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


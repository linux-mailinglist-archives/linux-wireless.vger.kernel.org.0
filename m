Return-Path: <linux-wireless+bounces-23372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1269AC2EB4
	for <lists+linux-wireless@lfdr.de>; Sat, 24 May 2025 12:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AA24A68D2
	for <lists+linux-wireless@lfdr.de>; Sat, 24 May 2025 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3F119DF8D;
	Sat, 24 May 2025 10:04:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1E19AD8B
	for <linux-wireless@vger.kernel.org>; Sat, 24 May 2025 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748081076; cv=none; b=tzBuZZMNSKjSiEMX6uZ3vdoYO0h4FCAS4f5HU+uO11LcwFnFKimiDnsq+HM2n46npMOGabVmM42RdAkOXs35vgpZTQTHZHRq+TgsJZsJA1dZS89nxYH+FeRPIe+pZxtND3HIAj/miE/ipx8l9yCyLo8OTJKNSdhQozqx8onDEPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748081076; c=relaxed/simple;
	bh=e5FAItjOUVgu208JXZ6Q6IRZJFER/+U3nwpQKrSjQls=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T5D22EdKgUxt3dLggTiQ73N484e6zyHyF98pa9MfCbNQL4WUNfDmHR2qaRvN8upoRKfPsiYI5HLQ3XqtXhn5ee/EnscqdDrmMUbHsS6OPpPCHcrwiF3xkDCF/ozImbNJyk3HxeFCrehOMzGqdFe8TisQ7v+nKnPt2VgVhX37PyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85dcaf42b61so132285739f.3
        for <linux-wireless@vger.kernel.org>; Sat, 24 May 2025 03:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748081074; x=1748685874;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/oazIG9eIkKX1kLYtUBakGdZ2zpECZekm+C1pvoXJs=;
        b=bwQbUzyKb5ho0uXVymbpZIWDFnEG40BLAIggB9EuBeu6jeFJQcY053RIUAY38Y2m8b
         0g5nEkan75lYwNRr6MHXzSE4oW77WfSDQbdtkPaotGZFDDgZFdnB1zO/R0UjzFxMOPib
         eXM7VGlmULkAK9B3eKhKc/Z4IJixo2auoTbu14FS/wPZh79+lfBGRD9/WUcd/6D8kdTy
         hGIrT9bF2uEblzl5bu1nkygVn7cOV3Wpw8ZAPL8KZORjFeW6Oah1tWcQj373WQ4JJTHs
         IrCBMNH5wmx+AtFjrKnpLD+Nw1ZcA7UyM8uudKx7p5+hbMj3dlCuGV/1irfwk9vEut7G
         ziEg==
X-Forwarded-Encrypted: i=1; AJvYcCUkLwGSerWDTLbeSaqCkWWvk/30ZAecy3RgTI4hN4ZMif/ENBih7Vyrl5i0DWBcnUOn06LKswMTfvA+M59+Iw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+iPnbrmtf0R6w5N5UiZIgTjYrPX277SR2Wlju4lkmCNDrgyb
	UJlitAyJ/spUEInlVPTMXdUIf8IaObm+XB1t4lxaJlSctIytzcpsQ6G6JfZw3ZROB2kiZ3aVk/7
	NigvthOPztU/QbTa8NXcua2Zx4Mn0CKJeC23ebWM81U3fXzAMPmS8YNAotEY=
X-Google-Smtp-Source: AGHT+IHOMdPgdyMGDK6iaWwUFwI9jfCGRXgY/C/cohoWm3k23D8JclT3N2bpn6wT+HcDRh7YFR1xqy4KhpuGz/LeBypl8a9wzlnr
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:389a:b0:85d:b7a3:b84d with SMTP id
 ca18e2360f4ac-86cbb8bee3emr210592539f.13.1748081074230; Sat, 24 May 2025
 03:04:34 -0700 (PDT)
Date: Sat, 24 May 2025 03:04:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683199b2.a70a0220.29d4a0.07f5.GAE@google.com>
Subject: [syzbot] Monthly wireless report (May 2025)
From: syzbot <syzbot+list1fcea8bbcf300c57bf70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 4 new issues were detected and 1 were fixed.
In total, 55 issues are still open and 158 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  127535  Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  10768   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<3>  8142    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<4>  6632    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1208    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  1129    Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<7>  567     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<8>  511     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<9>  500     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<10> 427     No    WARNING in ieee80211_request_ibss_scan
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


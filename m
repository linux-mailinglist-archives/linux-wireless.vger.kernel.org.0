Return-Path: <linux-wireless+bounces-306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC27801317
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 19:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160C8281E26
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 18:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D682554E;
	Fri,  1 Dec 2023 18:49:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43624B2
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 10:49:22 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6cdf90d609aso1920827b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Dec 2023 10:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701456562; x=1702061362;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7uf/nKmgeB4s8AOYp5odSuJMyINXnSr8QWYtuxIBzY=;
        b=s0q/xjcQMNiMml81lNmC3y+qu1AQIBuQfNGVn/kMBurhvRKDXsfErncN7ZjFcCIMX5
         ZUN3PuCPFYRFopxPnz/TcsryBSUBZleRK2CKJU76FDvHR0K+63umoKqmrBpGirMGmVL0
         39t8PcdSGrnmetytvFmQ8A6i4GCGMWBKw37hQONkZ193RUVTcZGi1rjTcs7Md7OBeTQv
         X3Lvwj/mppkJn97M7sLN1aKy3IZiDuRPYwABiEitKIo11CdWA6du8RTQZ813Z1gbHbkd
         XOdoLsmgNtKJ2ADPmhx5LayFKlvoVvkEwpAhbRXCmYstCMnnRexVryMdxx/ZFJ4TXOI5
         dDaQ==
X-Gm-Message-State: AOJu0Yy56PVvwWU8EUYffBQvvjBa0JZQ+I+YqdKNELPG4s2OvvX1abJR
	WzLT/fWKrI3RttQP0/d60VeHLXp/Uqo60PfUezNsM4VTE5ak
X-Google-Smtp-Source: AGHT+IGUlw4/hagoD6X3KinajDD/07g+mo7vw/4QKPKJaydC8FYQx5YjjtYPkMk1e4oyqU+KF7hBYuo2j8nElT2I5fPFt+RJv8tj
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:b4c:b0:6ce:d0:118c with SMTP id
 p12-20020a056a000b4c00b006ce00d0118cmr381472pfo.6.1701456561791; Fri, 01 Dec
 2023 10:49:21 -0800 (PST)
Date: Fri, 01 Dec 2023 10:49:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f76a65060b7739da@google.com>
Subject: [syzbot] Monthly wireless report (Nov 2023)
From: syzbot <syzbot+listd3e5fd84a00bcad8b79e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 1 new issues were detected and 0 were fixed.
In total, 32 issues are still open and 117 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5951    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  4366    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  3474    Yes   WARNING in ieee80211_rx_list
                   https://syzkaller.appspot.com/bug?extid=8830db5d3593b5546d2e
<4>  3175    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<5>  2663    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<6>  984     Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<7>  829     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<8>  734     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<9>  357     Yes   WARNING in ieee80211_bss_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
<10> 61      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


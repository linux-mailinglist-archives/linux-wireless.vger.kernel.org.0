Return-Path: <linux-wireless+bounces-12814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA9976BE8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 16:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD47BB21D39
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9461F1AD9CB;
	Thu, 12 Sep 2024 14:24:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06F190482
	for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151071; cv=none; b=E9aCvReIDz72KTQMM/e29Y5jNAjR+ySlV5DA7ZXYPdZry4k9Od4LNaHPLrwBErhJvI7jp5Y+Ocn8ljsAO32ctmFG5cCRhVM9FLGercaPu83OQkP5eLHs/CJH8j3vnSGAxXEkc34Npj4XmH4aHbeKkePoIkA3QAVthmnd02ghMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151071; c=relaxed/simple;
	bh=K7rEH5qYX0Elm7IC8BbIy1pVnj+AeI1J+4BNBcJrNQA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BmluZgH67U3MZWOGlymsRfM/qhUmOYg/jlZWhTGjsOOgNrw+UfaOobdZ23ZJPRJcsArFONrOFUxl3FPPZhfSNSWJUVJvQY9CKbYxfl4YSW5BeDNpgooZyGqJoY7qzSHLxZ790BRM+fGUBDS+1vSk/KwbVOPR6570fWGf9LVEaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0629ed658so14527905ab.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2024 07:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151069; x=1726755869;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcodMDARtg5q8rY7YVLhjjqRo/SOtRdhBndQsSIEwVo=;
        b=qV/4zaH5Pz/Nyj+4Uf6LxusvMiWQCsDhfNPv5/xXdVk/yukp0p5IamKTMzkFgpbbcA
         KfaY/m9uLst7KnLFYU7BflN8mmT/JnkmIJo7F8vWw7HhszRHFhVu//VFHZ09X7+qXPjY
         UF6Qh0SnAWO6U6bt11hxXe/pXVQ2x7NMZZ+U83f34Ae05n0XajsqeCw4QIDM0BHcvwsU
         w/1nqGSOMvxZHjZuIvgLqsNuzsiJvgTuOa1jSfxGaUcTnTkQSKgjI9iz7aaBRPQ3HEnZ
         95NIldhMVcEY0k6AUQhsPXwx+ghi+sIt5x6vHg0YiKQJT/ez7rvGu2ImS51+3DCP6LQy
         vo6w==
X-Forwarded-Encrypted: i=1; AJvYcCVfr7Q7TiR3tuPcDCnxJYNkudDFRpSwS2oH+Spa3jIoJ+Y6ILLKb+98lGWG+gRR9BI1GjF4M1McwlLnC/bzJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywta1jVjNhOykjj9qqXzd3yiBPC41pStgmO60ceI4NRxLn5epW8
	eRxr8tftAHk10dOiyXEmb7FZMeZ5CVg1Afw2RXTwiG+j7An6WRqgTyYsrEgi0qskeKUW2PGwuG3
	e+Kw5Q6QP7gfGZC2zBHFhnTEUCwCf8C/yn5fDoeB0OUVUuxnWmqSGdyE=
X-Google-Smtp-Source: AGHT+IEdL7uhb4g4phrP2I0ij5S1wqHsFVilkFydHnWkzAqWblt2ZYsam8xuhJ9OdpS14Hgoe9VH3UGfouYwBsD/wcEdxSKkDzJ3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1747:b0:39f:58f9:8d7c with SMTP id
 e9e14a558f8ab-3a084958fadmr24310285ab.26.1726151069178; Thu, 12 Sep 2024
 07:24:29 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:24:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004eac7a0621ecdda7@google.com>
Subject: [syzbot] Monthly wireless report (Sep 2024)
From: syzbot <syzbot+listdf434a578949274ad9b5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 3 new issues were detected and 0 were fixed.
In total, 34 issues are still open and 140 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  27179   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  5657    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  1724    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  1132    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<5>  1129    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<6>  568     Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  285     No    INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<8>  109     Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<9>  75      No    INFO: task hung in ath9k_hif_usb_firmware_cb (3)
                   https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
<10> 52      Yes   WARNING in minstrel_ht_update_caps
                   https://syzkaller.appspot.com/bug?extid=d805aca692aded25f888

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


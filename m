Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F4A1040A
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 04:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEACrC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 22:47:02 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:46334 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEACrC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 22:47:02 -0400
Received: by mail-vs1-f48.google.com with SMTP id e2so9205158vsc.13
        for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2019 19:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pX8e1uaSAA4ErzhFRH7yzsQJlW/zCaTmh6y+0TbR2MY=;
        b=naLsYv+cPaMlirxwkT6sINHC/HhSJtsclKbMBmfscT9ifjD0d1rXH2blp0520eZ/Nm
         Cpb1GpoDLH92GqW20NroZKcnYCrQhj4Y6I09q1rS1a7saHFnagR9Oi2w9xOA8vwD92F9
         eCw73vIb/Q9tKneTJh9A4iz/tzVa/VHP5GN6VW3owTekA0I4gySu6PRzxmCV20GnQKmg
         K+1zRD7DgIp6KgkNB8V5+aMIM6sHP+PY9vWfibJhnI0xR+yI7kpyeLifvm2DHJ3W//Fc
         Aj27mj3Q+u6G1fn2J2uIVocoLS5tW3mnWgmov3VD8Phc0Ap26DrZzJ6d1OSO7pEmXf+f
         ImTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pX8e1uaSAA4ErzhFRH7yzsQJlW/zCaTmh6y+0TbR2MY=;
        b=LVzPsRGA2v+4BKKIHxlOGlHOTY6U673RAzIMA4jwgmBlJ18XOtzhHoWtShjzdsfnci
         QxLiwRrZ4z0hy8l/3ZemTQuHfuMpxCA8yOVWsMtjInEfilIQ6kCgT5f0vpucg2EdukHK
         gL6d/i901dogailshh3iGsB17N9np/nlZQcsCI8zifebE///pcnFOXzU7YfFlN2TG5kj
         1mgrzDFt89Z3bnRr9Huk13Lew6GjPfDSLsYbm1JoFgNE77H+lGiESYXYc+1lKkrhA/Gb
         Dm6FSxLvUMHUpi748kNrcTyWfiFD0uiQC+62mqoURp+Q3gAMhiaCuI0yOal3U796tEx+
         iSlg==
X-Gm-Message-State: APjAAAVd0Lidm0ODDPChP/AXTmtVx4nxyeCVUni8PMrZ0xSdwlpKlZCB
        eqvwJiaOHHfzRvfhSvntUMAdEPuj63rfOvfx2A==
X-Google-Smtp-Source: APXvYqwNVV3DZ79paFVFDTCLOUTUUNjsE+4ec9xfVjbNY5wqGroM0muYEr/80uHaUSNWCggppjU7j0xPDBJGW7VgClc=
X-Received: by 2002:a67:c903:: with SMTP id w3mr548865vsk.62.1556678820854;
 Tue, 30 Apr 2019 19:47:00 -0700 (PDT)
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Tue, 30 Apr 2019 22:46:49 -0400
Message-ID: <CAP8WD_bTvWWTeh6BP_qgByiuWLbSN==CTBY1KD-v8XpWZkf_Rw@mail.gmail.com>
Subject: carl9170 crash
To:     Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian,
  I am getting this crash for the carl9170 in recent kernels, though I
have not yet bisected it. It hangs the networking system completely
(ifconfig -a never returns) and it prevents a reboot. I have to use
sysrq-b to 'cleanly' reboot the system.

I can apply and test any patches.

usbcore: registered new interface driver carl9170
usb 1-1: driver   API: 1.9.9 2016-02-15 [1-1]
usb 1-1: firmware API: 1.9.6 2012-07-07
ath: EEPROM regdomain: 0x3a
ath: EEPROM indicates we should expect a direct regpair map
ath: Country alpha2 being used: BM
ath: Regpair used: 0x3a
PREEMPT
CPU: 0 PID: 44 Comm: kworker/0:2 Not tainted 5.1.0-rc7.pentiumii-laptop #1446
Workqueue: events request_firmware_work_func
EIP: nl80211_send_wiphy+0x558/0x1a58 [cfg80211]
Code: 0f 85 73 02 00 00 80 7f 16 00 75 0c 80 7f 2c 00 0f 84 a4 00 00
00 eb 6a 8d 47 19 ba 03 00 00 00 50 b9 10 00 00 00 8b 75 bc c9 <f0> e8
2a ae 81 f8 5a cd c0 0f 85 5d 14 00 00 4d b7 4f 14 ba 04 00
EAX: c891205d EBX: c4a76000 ECX: 00000010 EDX: 00000003
ESI: c76fa5a0 EDI: c8912044 EBP: c036de14 ESP: c036ddd4
DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
CR0: 80050033 CR2: b716c540 CR3: 07618000 CR4: 00000290
Call Trace:
 ? nl80211_notify_wiphy+0x52/0x84 [cfg80211]
 wiphy_register+0x303/0x624 [cfg80211]
 ? ieee80211_register_hw+0x325/0x94a [mac80211]
 ? __kmalloc+0x8c/0x9c
 ? ieee80211_cs_list_valid+0xb/0x31 [mac80211]
 ieee80211_register_hw+0x68f/0x94a [mac80211]
 ? ath_reg_apply_radar_flags.isra.4+0xb/0x62 [ath]
 ? ath_reg_apply_world_flags+0xa/0xba [ath]
 ? ath_regd_init+0xd8/0xec [ath]
 ? carl9170_op_bss_info_changed+0x16a/0x16a [carl9170]
 carl9170_register+0x1f5/0x36d [carl9170]
 ? carl9170_register+0x1f5/0x36d [carl9170]
 carl9170_usb_firmware_step2+0x226/0x251 [carl9170]
 request_firmware_work_func+0x2a/0x51
 process_one_work+0x134/0x260
 worker_thread+0x18b/0x24a
 kthread+0xcd/0xcf
 ? cancel_delayed_work_sync+0x14/0x14
 ? kthread_create_worker_on_cpu+0x1c/0x1c
 ret_from_fork+0x19/0x24
Modules linked in: carl9170 mac80211 ath cfg80211 r8169 realtek libphy
rfkill uhci_hcd ehci_pci ehci_hcd pcmcia usbcore i2c_piix4 i2c_core
usb_common yenta_socket pcmcia_rsrc pcmcia_core autofs4
---[ end trace dbf0bc816dabbb51 ]---
EIP: nl80211_send_wiphy+0x558/0x1a58 [cfg80211]
Code: 0f 85 73 02 00 00 80 7f 16 00 75 0c 80 7f 2c 00 0f 84 a4 00 00
00 eb 6a 8d 47 19 ba 03 00 00 00 50 b9 10 00 00 00 8b 75 bc c9 <f0> e8
2a ae 81 f8 5a cd c0 0f 85 5d 14 00 00 4d b7 4f 14 ba 04 00
EAX: c891205d EBX: c4a76000 ECX: 00000010 EDX: 00000003
ESI: c76fa5a0 EDI: c8912044 EBP: c036de14 ESP: c15b02b8
DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
CR0: 80050033 CR2: b7271500 CR3: 0770f000 CR4: 00000290
r8169 0000:06:00.0 enp6s0: Link is Up - 1Gbps/Full - flow control rx/tx

- Matthew Whitehead

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCF1108CF
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfEAOKS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 10:10:18 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:35617 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfEAOKS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 10:10:18 -0400
Received: by mail-vk1-f172.google.com with SMTP id t74so3848369vke.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 May 2019 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=umggwxbAxxu2zVtlVq+/YKOdaiZG34hEkkLQk2Yd1pE=;
        b=lD6EMk8d41p10X5X7KsYsxcR2PH7fXiiixnlzsewJnjh1l7dcI0T3gro9Kc/zIzH0x
         pkG8ut8j07iIW1DwGHJBT9R33YHRyGiabqIcWu7D4AgtLIDh+DiHdZH62dwKxSNkbP7w
         SoCR5DWDGr6obLp+PB5zS9ZAAAskTxZk11b0v6NzD63fZg1FRb6gQuyQoFfkJmHxmtVf
         7a4fJ5mFv0i1E4DWT5fcyiqYpvv4ET4w/6JJeUxNKavxXSfei0WhFn5Z+FCl7DOrAevE
         AVktdTHr1lE1InqO+9bmz7FAQoq+6aaf4/+cCGKg5MrNV0Ih/Xd7sARy4DCGyMQyF0zk
         PufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=umggwxbAxxu2zVtlVq+/YKOdaiZG34hEkkLQk2Yd1pE=;
        b=ZYS2vY0PHY1kXha2SVX09DXqcpmzAoMMpeXIW1ERmKESW3fLX79Z0F4D9/UeZr3K/F
         c7JY/ZRU7P9PRnnXkiTzzUPUcBVvrwJAKHV/v2bNePs2++LXFdQGSJthHGSB74XRUoLK
         FohcdMMHGZqX7x5djAlyAZ8R0gaCzDhxbsQbOuIwJOSQo2+mzePzQfp54A+tvlK+PzF7
         XRvryRGMiFJQJJVz7uriHFjcezMuJ3/FYdItoXwkZBgMY57pFUvmPWto6d9GkZxL/EKA
         O+uEUwh/nREhDXAK3rv54VVok2vZXIUt3ql2i0Di+Y/aDC9y5P2pJtVHJibKgpBbXaUs
         lVCQ==
X-Gm-Message-State: APjAAAVt8JqJCUJp+NLqh+44WMXeGBpWmfzwTsQg/HeANaleYuMwNt7L
        Qyk5xnTcLPXCXLAscIUVjsBLMOuP+I5oJFm2AQ==
X-Google-Smtp-Source: APXvYqxv8zCcrxH39ML0L8g98nJyNalINc3hdtckETR9UShQUOfNayKG3QWukOEB4q1ShxsdG41sPs5V8UiiAN4q9nU=
X-Received: by 2002:a1f:d884:: with SMTP id p126mr507991vkg.70.1556719816362;
 Wed, 01 May 2019 07:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8WD_bTvWWTeh6BP_qgByiuWLbSN==CTBY1KD-v8XpWZkf_Rw@mail.gmail.com>
 <87k1fawsio.fsf@purkki.adurom.net>
In-Reply-To: <87k1fawsio.fsf@purkki.adurom.net>
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Wed, 1 May 2019 10:10:05 -0400
Message-ID: <CAP8WD_Y7-9=kM-AN1WuWkJywLzTPRB_6hQ3eQixZun_743BZfQ@mail.gmail.com>
Subject: Re: carl9170 crash
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Matthew Whitehead <whiteheadm@acm.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle,

On Wed, May 1, 2019 at 3:20 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> What was the last working version?

It worked perfectly in 4.14.110.

The next version I have to test is 4.18.20 where I first noticed
problems with loading regulatory.db, but the driver still worked. The
same for 4.19.33, 4.20.17, and 5.0.6:

# journalctl -b | egrep "cfg80211|regulatory|firmware"
May 01 09:38:15 pentiumii-laptop kernel: platform regulatory.0: Direct
firmware load for regulatory.db failed with error -2
May 01 09:38:15 pentiumii-laptop kernel: platform regulatory.0:
Falling back to syfs fallback for: regulatory.db
May 01 09:38:15 pentiumii-laptop kernel: usb 1-1: firmware API: 1.9.6 2012-07-07
May 01 09:39:23 pentiumii-laptop kernel: cfg80211: failed to load regulatory.db
May 01 09:39:23 pentiumii-laptop kernel: cfg80211: failed to load regulatory.db

It looks like the problems arose in the 5.1-rc series. Here is 5.1-rc7
(console messages are slightly garbled):

[   25.561373] usb 1-1: reset full-speed USB device number 2 using uhci_hcd
[  OK  ] Started Create Volatile Files and Directories.
         Starting Network Time Synchronization...
[   25.818199] usbcore: registered new interface driver carl9170
[   25.878181] usb 1-1: driver   API: 1.9.9 2016-02-15 [1-1]
[   25.909356] usb 1-1: firmware API: 1.9.6 2012-07-07
         Starting Update UTMP about System Boot/Shutdown...
[   26.163471] r8169 0000:06:00.0 enp6s0: Link is Up - 1Gbps/Full -
flow control rx/tx
[   26.583723] ath: EEPROM regdomain: 0x3a
[   26.589376] ath: EEPROM indicates we should expect a direct regpair map
[   26.613791] ath: Country alpha2 being used: BM
[  OK     26.633397] ath: Regpair used: 0x3a
m] Started Wait for Network to be Configured.

[   26.662129] invalid opcode: 0000 [#1] PREEMPT
[   26.665496] CPU: 0 PID: 104 Comm: kworker/0:3 Not tainted
5.1.0-rc7.pentiumii-laptop #1446
[   26.665496] Workqueue: events request_firmware_work_func
[   26.665496] EIP: nl80211_send_wiphy+0x558/0x1a58 [cfg80211]
[   26.665496] Code: 0f 85 73 02 00 00 80 7f 16 00 75 0c 80 7f 2c 00
0f 84 a4 00 00 00 eb 6a 8d 47 19 ba 03 00 00 00 50 b9 10 00 00 00 8b
75 bc c9 <f0> e8 2a 4e 83 f8 5a cd c0 0f 85 5d 14 00 00 4d b7 4f 14 ba
04 00
[   26.665496] EAX: c89fa05d EBX: c41ea000 ECX: 00000010 EDX: 00000003
[   26.665496] ESI: c775a720 EDI: c89fa044 EBP: c2cd5e14 ESP: c2cd5dd4
[   26.665496] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
[   26.665496] CR0: 80050033 CR2: b607b390 CR3: 0766f000 CR4: 00000290
[   26.665496] Call Trace:
[   26.665496]  ? nl80211_notify_wiphy+0x52/0x84 [cfg80211]
[   26.665496]  wiphy_register+0x303/0x624 [cfg80211]
[   26.665496]  ? ieee80211_register_hw+0x325/0x94a [mac80211]
[   26.665496]  ? __kmalloc+0x8c/0x9c
[   26.665496]  ? ieee80211_cs_list_valid+0xb/0x31 [mac80211]
[   26.665496]  ieee80211_register_hw+0x68f/0x94a [mac80211]
[   26.665496]  ? ath_reg_apply_radar_flags.isra.4+0xb/0x62 [ath]
[   26.665496]  ? ath_reg_apply_world_flags+0xa/0xba [ath]
[   26.665496]  ? ath_regd_init+0xd8/0xec [ath]
[   26.665496]  ? carl9170_op_bss_info_changed+0x16a/0x16a [carl9170]
[   26.665496]  carl9170_register+0x1f5/0x36d [carl9170]
[   26.665496]  ? carl9170_register+0x1f5/0x36d [carl9170]
[   26.665496]  carl9170_usb_firmware_step2+0x226/0x251 [carl9170]
[   26.665496]  request_firmware_work_func+0x2a/0x51
[   26.665496]  process_one_work+0x134/0x260
[   26.665496]  worker_thread+0x18b/0x24a
[   26.665496]  kthread+0xcd/0xcf
[   26.665496]  ? cancel_delayed_work_sync+0x14/0x14
[   26.665496]  ? kthread_create_worker_on_cpu+0x1c/0x1c
[   26.665496]  ret_from_fork+0x19/0x24
[   26.665496] Modules linked in: carl9170 mac80211 ath cfg80211 r8169
realtek libphy rfkill uhci_hcd ehci_pci ehci_hcd pcmcia usbcore
i2c_piix4 i2c_core usb_common yenta_socket pcmcia_rsrc pcmcia_core
autofs4
[   26.693414] ---[ end trace 21daf0caa557a17d ]---
[   26.735231] EIP: nl80211_send_wiphy+0x558/0x1a58 [cfg80211]
[  OK     26.761620] Code: 0f 85 73 02 00 00 80 7f 16 00 75 0c 80 7f
2c 00 0f 84 a4 00 00 00 eb 6a 8d 47 19 ba 03 00 00 00 50 b9 10 00 00
00 8b 75 bc c9 <f0> e8 2a 4e 83 f8 5a cd c0 0f 85 5d 14 00 00 4d b7 4f
14 ba 04 00
m]
Started Update UTMP about System Boot/Shutdown.
[   26.777652] EAX: c89fa05d EBX: c41ea000 ECX: 00000010 EDX: 00000003
[   26.793423] ESI: c775a720 EDI: c89fa044 EBP: c2cd5e14 ESP: c15b02b8
[   26.817190] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
[   26.817582] CR0: 80050033 CR2: b6224dd0 CR3: 00399000 CR4: 00000290
[   45.950502] random: crng init done
[   84.628925] cfg80211: failed to load regulatory.db

- Matthew

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8C77DC3F
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHPI1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242906AbjHPI1O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:27:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0749F1BDA
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=VUwIDuEg76K4MmHsBJMN4x4fyRM12VzHaj/LgAN75ho=;
        t=1692174433; x=1693384033; b=CzxU7V2jxnNHoFgmS8IUbeqbhSKnvv80yr7aFloVqXrThQL
        MsOzSAIfiA8atS6QLdlFqC8AjCQ/ONksBoDlZIlnB4+PrX79PBkKefzAu9wF5vbtz5TbU6c3M6l4r
        P4wLTJCLJJbh3O8wSM7davJ64e4/C/DHEWKzzlMYgovDQhHoDLUgvQVwDjbNXWwbMiICmgcl2m57D
        qNC7T12emmmBbu6pJb7+WyHQX9nHtwRUSVmJRkvvpVALFsq9xh3G0V7fHqtRW5m2fGrGshgMj5vSy
        FF/oKvjrl9qz1Z7IoyKlnu9xfKrj1fFqdvzfaQ0r5NeL4TXwVifY1tyeETuUb6zA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWBry-00AdEL-2y;
        Wed, 16 Aug 2023 10:27:11 +0200
Message-ID: <4f9e3fc62c2e364add91eecafd620246ab760595.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] INFO: task hung in cfg80211_event_work (2)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     syzbot <syzbot+85f0eb24e10cec9b8a10@syzkaller.appspotmail.com>,
        linux-wireless@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Date:   Wed, 16 Aug 2023 10:27:08 +0200
In-Reply-To: <000000000000997319060049b1e4@google.com>
References: <000000000000997319060049b1e4@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

So this is interesting. In the report in the email, we can't really see
all that much. But, in the sample report shown on the dashboard:

> dashboard link: https://syzkaller.appspot.com/bug?extid=3D85f0eb24e10cec9=
b8a10

we see:

> INFO: task kworker/u4:4:57 blocked for more than 143 seconds.
>       Not tainted 6.5.0-rc3-next-20230728-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u4:4    state:D
>  stack:24336 pid:57    ppid:2      flags:0x00004000
> Workqueue: cfg80211 cfg80211_event_work
>=20
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5382 [inline]
>  __schedule+0xee1/0x59f0 kernel/sched/core.c:6711
>  schedule+0xe7/0x1b0 kernel/sched/core.c:6787
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6846
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0x967/0x1340 kernel/locking/mutex.c:747
>  wiphy_lock include/net/cfg80211.h:5773 [inline]
>  cfg80211_event_work+0x1f/0x40 net/wireless/core.c:332

which OK, we're blocked on the lock - but not clear why. However we get
shown the other CPUs, and one of them is:

> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 3155 Comm: kworker/1:2 Not tainted 6.5.0-rc3-next-20230728-sy=
zkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/12/2023
> Workqueue: events cfg80211_wiphy_work
> RIP: 0010:io_serial_in+0x87/0xa0 drivers/tty/serial/8250/8250_port.c:410
> Code: ad ee fc 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 f=
a d3 e3 48 c1 ea 03 80 3c 02 00 75 16 66 03 5d 40 89 da ec <5b> 0f b6 c0 5d=
 41 5c c3 e8 2c 7b 43 fd eb a6 e8 85 7b 43 fd eb e3
> RSP: 0018:ffffc9000cdb7128 EFLAGS: 00000002
> RAX: dffffc0000000000 RBX: 00000000000003fd RCX: 0000000000000000
> RDX: 00000000000003fd RSI: ffffffff849856d0 RDI: ffffffff92318020
> RBP: ffffffff92317fe0 R08: 0000000000000001 R09: 000000000000001f
> R10: 0000000000000000 R11: 205d383254202020 R12: 0000000000000000
> R13: 0000000000000020 R14: fffffbfff2463055 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f608b73d868 CR3: 000000002bdaf000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  serial_in drivers/tty/serial/8250/8250.h:117 [inline]
>  serial_lsr_in drivers/tty/serial/8250/8250.h:139 [inline]
>  wait_for_lsr+0xd7/0x180 drivers/tty/serial/8250/8250_port.c:2081
>  serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3365 [=
inline]
>  serial8250_console_write+0xce5/0x1060 drivers/tty/serial/8250/8250_port.=
c:3443
>  console_emit_next_record kernel/printk/printk.c:2910 [inline]
>  console_flush_all+0x4e8/0xf70 kernel/printk/printk.c:2966
>  console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
>  vprintk_emit+0x189/0x630 kernel/printk/printk.c:2307
>  vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
>  _printk+0xc8/0x100 kernel/printk/printk.c:2332
>  ieee80211_parse_ch_switch_ie+0xeb0/0x1030 net/mac80211/spectmgmt.c:88
>  ieee80211_ibss_process_chanswitch.constprop.0+0x274/0xfd0 net/mac80211/i=
bss.c:803
>  ieee80211_rx_mgmt_spectrum_mgmt net/mac80211/ibss.c:931 [inline]
>  ieee80211_ibss_rx_queued_mgmt+0x23cf/0x2ee0 net/mac80211/ibss.c:1666
>  ieee80211_iface_process_skb net/mac80211/iface.c:1604 [inline]
>  ieee80211_iface_work+0xa1f/0xd40 net/mac80211/iface.c:1658
>  cfg80211_wiphy_work+0x24e/0x330 net/wireless/core.c:435

So indeed another worker is holding the mutex it's waiting for, but some
log message is taking _forever_ to get out there.

Not sure we can do anything about that, seems more like a syzbot
artifact? I'm not even sure why serial would take forever in a VM :)

johannes

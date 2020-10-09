Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8936428917E
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbgJISzu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 14:55:50 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36871 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388186AbgJISzt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 14:55:49 -0400
Received: (qmail 547642 invoked by uid 1000); 9 Oct 2020 14:55:48 -0400
Date:   Fri, 9 Oct 2020 14:55:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc:     andreyknvl@google.com, eli.billauer@gmail.com,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
        linux-wireless@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tiwai@suse.de
Subject: Re: WARNING in hif_usb_send/usb_submit_urb
Message-ID: <20201009185548.GA546075@rowland.harvard.edu>
References: <000000000000021e6b05b0ea60bd@google.com>
 <00000000000069707b05b13da267@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000069707b05b13da267@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To the ath9k_htc maintainers:

This is an attempt to fix a bug detected by the syzbot fuzzer.  The bug 
arises when a USB device claims to be an ATH9K but doesn't have the 
expected endpoints.  (In this case there was a bulk endpoint where the 
driver expected an interrupt endpoint.)  The kernel needs to be able to 
handle such devices without getting an internal error.

On Fri, Oct 09, 2020 at 07:19:19AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    6c8cf369 usb: typec: Add QCOM PMIC typec detection driver

Andrey, why doesn't syzbot put a 12-digit commit ID here?

> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ea791b900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df3bb4023c36d114
> dashboard link: https://syzkaller.appspot.com/bug?extid=f5378bcf0f0cab45c1c6
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1087bfe7900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1327b010500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com
> 
> usb 1-1: Manufacturer: syz
> usb 1-1: SerialNumber: syz
> usb 1-1: ath9k_htc: Firmware ath9k_htc/htc_9271-1.4.0.fw requested
> usb 1-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> WARNING: CPU: 1 PID: 72 at drivers/usb/core/urb.c:493 usb_submit_urb+0xce2/0x14e0 drivers/usb/core/urb.c:493
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 72 Comm: kworker/1:2 Not tainted 5.9.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events request_firmware_work_func
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x16e lib/dump_stack.c:118
>  panic+0x2cb/0x702 kernel/panic.c:231
>  __warn.cold+0x20/0x44 kernel/panic.c:600
>  report_bug+0x1bd/0x210 lib/bug.c:198
>  handle_bug+0x41/0x80 arch/x86/kernel/traps.c:234
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> RIP: 0010:usb_submit_urb+0xce2/0x14e0 drivers/usb/core/urb.c:493
> Code: 84 04 03 00 00 e8 3e 98 c6 fd 4c 89 ef e8 66 b6 12 ff 41 89 d8 44 89 e1 4c 89 f2 48 89 c6 48 c7 c7 20 b3 5d 86 e8 d0 ba 9a fd <0f> 0b e9 c6 f8 ff ff e8 12 98 c6 fd 48 81 c5 40 06 00 00 e9 f2 f7
> RSP: 0018:ffff8881d4757808 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> RDX: ffff8881d4ffe500 RSI: ffffffff8129efa3 RDI: ffffed103a8eaef3
> RBP: ffff8881cde7d800 R08: 0000000000000001 R09: ffff8881db32f50f
> R10: 0000000000000000 R11: 0000000000003754 R12: 0000000000000001
> R13: ffff8881d1edd0a0 R14: ffff8881d9bc9320 R15: ffff8881d9ba8600
>  hif_usb_send_regout drivers/net/wireless/ath/ath9k/hif_usb.c:127 [inline]
>  hif_usb_send+0x4c1/0xcf0 drivers/net/wireless/ath/ath9k/hif_usb.c:470
>  htc_issue_send drivers/net/wireless/ath/ath9k/htc_hst.c:34 [inline]
>  htc_connect_service+0x705/0xa00 drivers/net/wireless/ath/ath9k/htc_hst.c:275
>  ath9k_wmi_connect+0xc9/0x190 drivers/net/wireless/ath/ath9k/wmi.c:268
>  ath9k_init_htc_services.constprop.0+0xb3/0x640 drivers/net/wireless/ath/ath9k/htc_drv_init.c:146
>  ath9k_htc_probe_device+0x25f/0x1e10 drivers/net/wireless/ath/ath9k/htc_drv_init.c:962
>  ath9k_htc_hw_init+0x31/0x60 drivers/net/wireless/ath/ath9k/htc_hst.c:501
>  ath9k_hif_usb_firmware_cb+0x274/0x530 drivers/net/wireless/ath/ath9k/hif_usb.c:1220
>  request_firmware_work_func+0x126/0x250 drivers/base/firmware_loader/main.c:1006
>  process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>  kthread+0x392/0x470 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

I don't know if all the devices used by the ath9k_htc driver are 
expected to have all of these endpoints and no others.  I just added 
checks for the ones listed in the hif_usb.h file.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 6c8cf369

Index: usb-devel/drivers/net/wireless/ath/ath9k/hif_usb.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ usb-devel/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1307,6 +1307,20 @@ static int ath9k_hif_usb_probe(struct us
 	struct usb_device *udev = interface_to_usbdev(interface);
 	struct hif_device_usb *hif_dev;
 	int ret = 0;
+	struct usb_host_interface *alt;
+	struct usb_endpoint_descriptor *epd;
+
+	/* Verify the expected endpoints are present */
+	alt = interface->cur_altsetting;
+	if (!usb_find_int_in_endpoint(alt, &epd) ||
+			usb_endpoint_num(epd) != USB_REG_IN_PIPE ||
+	    !usb_find_int_out_endpoint(alt, &epd) ||
+			usb_endpoint_num(epd) != USB_REG_OUT_PIPE ||
+	    !usb_find_bulk_in(endpoint(alt, &epd) ||
+			usb_endpoint_num(epd) != USB_WLAN_RX_PIPE ||
+	    !usb_find_bulk_out(endpoint(alt, &epd) ||
+			usb_endpoint_num(epd) != USB_WLAN_TX_PIPE)
+		return -ENODEV;
 
 	if (id->driver_info == STORAGE_DEVICE)
 		return send_eject_command(interface);



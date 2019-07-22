Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47033706AC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfGVRWy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 13:22:54 -0400
Received: from mail.sig21.net ([80.244.240.74]:47772 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfGVRWy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 13:22:54 -0400
X-Greylist: delayed 2541 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 13:22:53 EDT
Received: from p5b206fe4.dip0.t-ipconnect.de ([91.32.111.228] helo=abc.local)
        by mail.sig21.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <js@sig21.net>)
        id 1hpbMM-0003Bf-Vj; Mon, 22 Jul 2019 18:40:28 +0200
Received: from js by abc.local with local (Exim 4.92)
        (envelope-from <js@sig21.net>)
        id 1hpbMK-0001Yh-4D; Mon, 22 Jul 2019 18:40:20 +0200
Date:   Mon, 22 Jul 2019 18:40:20 +0200
From:   Johannes Stezenbach <js@sig21.net>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: mt76x0u blocks resume from suspend
Message-ID: <20190722164020.GA5850@sig21.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-21-Score: -2.9 (--)
X-Spam-21-Report: No, score=-2.9 required=8.0 tests=ALL_TRUSTED=-1,BAYES_00=-1.9 autolearn=ham autolearn_force=no
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I met failure to resume from suspend to RAM with v5.1.19
and TP-Link Archer T2UH connected to my PC (Asus P8H77-V).
I tried about a dozen times while trying to figure out the reason,
the issue happened every time.
Eventually I connected a serial console and captured this:

[   87.803576][ T4640] mt76x0u 2-1.6:1.0: vendor request req:06 off:ac80 failed:-110
[   91.030328][ T4640] mt76x0u 2-1.6:1.0: vendor request req:07 off:b000 failed:-110
[   94.256950][ T4640] mt76x0u 2-1.6:1.0: vendor request req:06 off:b000 failed:-110
[   97.483579][ T4640] mt76x0u 2-1.6:1.0: vendor request req:06 off:aca0 failed:-110
(repeats)

[  100.211748][    C0] sysrq: Show Blocked State
[  107.479820][    C0] kworker/u8:51   D    0  4640      2 0x80000000
[  107.486060][    C0] Workqueue: events_unbound async_run_entry_fn
[  107.492106][    C0] Call Trace:
[  107.495293][    C0]  ? __schedule+0x381/0xa30
[  107.499706][    C0]  schedule+0x36/0x90
[  107.503575][    C0]  schedule_timeout+0x1e8/0x4c0
[  107.508310][    C0]  ? collect_expired_timers+0xb0/0xb0
[  107.513593][    C0]  wait_for_common+0x15f/0x190
[  107.518249][    C0]  ? wake_up_q+0x80/0x80
[  107.522412][    C0]  usb_start_wait_urb+0x82/0x160
[  107.527222][    C0]  ? wait_for_common+0x38/0x190
[  107.531961][    C0]  usb_control_msg+0xdc/0x140
[  107.536542][    C0]  __mt76u_vendor_request+0xc4/0x100 [mt76_usb]
[  107.542687][    C0]  mt76u_copy+0x8b/0xb0 [mt76_usb]
[  107.547721][    C0]  mt76x02_mac_shared_key_setup+0xdf/0x130 [mt76x02_lib]
[  107.554653][    C0]  mt76x0_init_hardware+0x2b5/0x3a0 [mt76x0_common]
[  107.561141][    C0]  ? usb_dev_thaw+0x10/0x10
[  107.565533][    C0]  mt76x0u_init_hardware+0x134/0x1b0 [mt76x0u]
[  107.571609][    C0]  mt76x0_resume+0x33/0x60 [mt76x0u]
[  107.576791][    C0]  usb_resume_interface.isra.1+0x81/0xd0
[  107.582310][    C0]  usb_resume_both+0xe8/0x130
[  107.586888][    C0]  usb_resume+0x16/0x60
[  107.590936][    C0]  dpm_run_callback+0x6e/0x190
[  107.595599][    C0]  device_resume+0x99/0x190
[  107.599982][    C0]  async_resume+0x19/0x30
[  107.604204][    C0]  async_run_entry_fn+0x37/0x140

Any ideas about it?  FWIW, I've used a TL-WN722N so far without problems,
just switched to the T2UH today.

The whole machine is hanging at this point. without serial console
my only choice was to press the reset button.  At least mt76x0u should
bail out with an error and not block the resume completely.
Unplugging the hardware also didn't cause it to bail.


Thanks,
Johannes

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA16752255
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 06:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfFYEyG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 00:54:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfFYEyF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 00:54:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D1636085C; Tue, 25 Jun 2019 04:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561438444;
        bh=E95aPL1oEyduFBGj775X0IOe4443KPsMPWc6Qsm7UY8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JsuMI3Ak6uOjn6s4V2sIMM5q1X5C5CuSxiPafJ314vLliTlm3LLLJeMYjawWHrZEO
         1X86ZXW4yzFRdluLtobuk5Q93gEeNNFQiio1SRY+O2hUV1ZGxHHy2iRTChPf0EnFkm
         6H+nT3XNTXdPTM4TF7Eh++06s62u06AWeMAw/jhc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A5C6C606DC;
        Tue, 25 Jun 2019 04:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561438443;
        bh=E95aPL1oEyduFBGj775X0IOe4443KPsMPWc6Qsm7UY8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=SDLkYXvbHCOW0LDN+wTQ6egDkIH3NKXHgJJDpNvUQ0xKYNo+1+ZAcgJ39m7jFHVZv
         AinMhyJpVSar1pUyHKcJCynUIl15PkCQ9EnHBlL/Akss9dIUXPzHVmGq1qQkYNwXRp
         gvSVWe73ZqGsGrNZaXP/3TRMVppAt8Ll+HSLzkds=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5C6C606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8192cu: fix error handle when usb probe failed
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190529065730.25951-1-pkshih@realtek.com>
References: <20190529065730.25951-1-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <andreyknvl@google.com>,
        <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625045404.9D1636085C@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 04:54:04 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> rtl_usb_probe() must do error handle rtl_deinit_core() only if
> rtl_init_core() is done, otherwise goto error_out2.
> 
> | usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> | rtl_usb: reg 0xf0, usbctrl_vendorreq TimeOut! status:0xffffffb9 value=0x0
> | rtl8192cu: Chip version 0x10
> | rtl_usb: reg 0xa, usbctrl_vendorreq TimeOut! status:0xffffffb9 value=0x0
> | rtl_usb: Too few input end points found
> | INFO: trying to register non-static key.
> | the code is fine but needs lockdep annotation.
> | turning off the locking correctness validator.
> | CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
> | Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> | Google 01/01/2011
> | Workqueue: usb_hub_wq hub_event
> | Call Trace:
> |   __dump_stack lib/dump_stack.c:77 [inline]
> |   dump_stack+0xe8/0x16e lib/dump_stack.c:113
> |   assign_lock_key kernel/locking/lockdep.c:786 [inline]
> |   register_lock_class+0x11b8/0x1250 kernel/locking/lockdep.c:1095
> |   __lock_acquire+0xfb/0x37c0 kernel/locking/lockdep.c:3582
> |   lock_acquire+0x10d/0x2f0 kernel/locking/lockdep.c:4211
> |   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> |   _raw_spin_lock_irqsave+0x44/0x60 kernel/locking/spinlock.c:152
> |   rtl_c2hcmd_launcher+0xd1/0x390
> | drivers/net/wireless/realtek/rtlwifi/base.c:2344
> |   rtl_deinit_core+0x25/0x2d0 drivers/net/wireless/realtek/rtlwifi/base.c:574
> |   rtl_usb_probe.cold+0x861/0xa70
> | drivers/net/wireless/realtek/rtlwifi/usb.c:1093
> |   usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
> |   really_probe+0x2da/0xb10 drivers/base/dd.c:509
> |   driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
> |   __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
> |   bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
> |   __device_attach+0x223/0x3a0 drivers/base/dd.c:844
> |   bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
> |   device_add+0xad2/0x16e0 drivers/base/core.c:2106
> |   usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
> |   generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
> |   usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
> |   really_probe+0x2da/0xb10 drivers/base/dd.c:509
> |   driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
> |   __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
> |   bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
> |   __device_attach+0x223/0x3a0 drivers/base/dd.c:844
> |   bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
> |   device_add+0xad2/0x16e0 drivers/base/core.c:2106
> |   usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
> |   hub_port_connect drivers/usb/core/hub.c:5089 [inline]
> |   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
> |   port_event drivers/usb/core/hub.c:5350 [inline]
> |   hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
> |   process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
> |   worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
> |   kthread+0x313/0x420 kernel/kthread.c:253
> |   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> 
> Reported-by: syzbot+1fcc5ef45175fc774231@syzkaller.appspotmail.com
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-drivers-next.git, thanks.

6c0ed66f1a5b rtlwifi: rtl8192cu: fix error handle when usb probe failed

-- 
https://patchwork.kernel.org/patch/10966133/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


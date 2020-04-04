Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF45819E2A9
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2020 06:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDDETD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Apr 2020 00:19:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34031 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgDDETD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Apr 2020 00:19:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id v23so1740778pfm.1;
        Fri, 03 Apr 2020 21:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=euDpQFiZ1RAaW/+LlG7KHJEwy5w9kMD7b+KEHHzS6hw=;
        b=P4t01GSBwBuF6wK8/X25kGN/AWhm+HsIKuNw4nDZTRgGJNNlIuy934CghpHqlckPL2
         j36+dZox0Ut/GmRGTptevh4kVmU0HCAHd1qaWvkTVA8uWAVnA+jI4mK7HVXhey6DK8Xp
         ludLlIOCgtWnCkYws80YipnRHctpKFGT609uoqwyZJZU20bTMfme7xYnXbuvNY0UQXEO
         W5zgf/OFHQI1EcUVh6Voojqlhkt7ZDJDdfZlMNjcfEa0oKV3PR01OY3P0lZuj83/N6Vp
         EeCTcyVam/Dt+hv+eMfwnPg5joi6dDKHLAVsuFI2OKnlQTQy3bL/fvXDuN21g7adY15k
         +s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=euDpQFiZ1RAaW/+LlG7KHJEwy5w9kMD7b+KEHHzS6hw=;
        b=NfdbsQXRlOOVPSpJv3NFXNW5HztgikfLPtJYZb7zu6iC196OlBhH2KQ0HTg61mkQrD
         mIEQo+IFsSnT2ZA0PHlVKa7gSUoD/aIgnIGg74etgoqahv3maDOetCWNrSLM20sk4Alv
         Uh00CjxLmhI8/tAS8zrCUnfZLooiJcC1n/92XOhizRF0y0HK4TnqzHO4OtsaIUmUqB17
         laazEZFvdjeZIXX4iDff1UgkOLrW8Tfp4w0UZYbSybA0rP0FwB3v09omkMjwN7D9mniK
         dOKccnMHQtI4yGM6iHZcqXb7Fn50z2+iWA/ilCDQXB7QqosDg/pofJQAI06uP7b7u0pr
         XONw==
X-Gm-Message-State: AGi0PubUanVqjtk7S5WD72qZ2Bo4/Xsa7wr7GFMo5ZjHpMB6/DOBh7m4
        owcsHWOQk8mFvJerkgyMTgHP6k5v
X-Google-Smtp-Source: APiQypKa/6upTr/pEi2tecWTrshow8t42Rqlg3aIj8kBNZz4tDfa4MCBAsOw4Tu0Ep9vOO92TkT1jw==
X-Received: by 2002:a62:7b4c:: with SMTP id w73mr11798690pfc.115.1585973940895;
        Fri, 03 Apr 2020 21:19:00 -0700 (PDT)
Received: from localhost (n112120135125.netvigator.com. [112.120.135.125])
        by smtp.gmail.com with ESMTPSA id r7sm6918175pfg.38.2020.04.03.21.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 21:19:00 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     kvalo@codeaurora.org, ath9k-devel@qca.qualcomm.com
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        anenbupt@gmail.com, syzkaller-bugs@googlegroups.com,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH 1/5] ath9k: Fix use-after-free Read in htc_connect_service
Date:   Sat,  4 Apr 2020 12:18:34 +0800
Message-Id: <20200404041838.10426-2-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200404041838.10426-1-hqjagain@gmail.com>
References: <20200404041838.10426-1-hqjagain@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The skb is consumed by htc_send_epid, so it needn't release again.

The case reported by syzbot:

https://lore.kernel.org/linux-usb/000000000000590f6b05a1c05d15@google.com
usb 1-1: ath9k_htc: Firmware ath9k_htc/htc_9271-1.4.0.fw requested
usb 1-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size:
51008
usb 1-1: Service connection timeout for: 256
==================================================================
BUG: KASAN: use-after-free in atomic_read
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in refcount_read include/linux/refcount.h:134
[inline]
BUG: KASAN: use-after-free in skb_unref include/linux/skbuff.h:1042
[inline]
BUG: KASAN: use-after-free in kfree_skb+0x32/0x3d0 net/core/skbuff.c:692
Read of size 4 at addr ffff8881d0957994 by task kworker/1:2/83

Call Trace:
kfree_skb+0x32/0x3d0 net/core/skbuff.c:692
htc_connect_service.cold+0xa9/0x109
drivers/net/wireless/ath/ath9k/htc_hst.c:282
ath9k_wmi_connect+0xd2/0x1a0 drivers/net/wireless/ath/ath9k/wmi.c:265
ath9k_init_htc_services.constprop.0+0xb4/0x650
drivers/net/wireless/ath/ath9k/htc_drv_init.c:146
ath9k_htc_probe_device+0x25a/0x1d80
drivers/net/wireless/ath/ath9k/htc_drv_init.c:959
ath9k_htc_hw_init+0x31/0x60
drivers/net/wireless/ath/ath9k/htc_hst.c:501
ath9k_hif_usb_firmware_cb+0x26b/0x500
drivers/net/wireless/ath/ath9k/hif_usb.c:1187
request_firmware_work_func+0x126/0x242
drivers/base/firmware_loader/main.c:976
process_one_work+0x94b/0x1620 kernel/workqueue.c:2264
worker_thread+0x96/0xe20 kernel/workqueue.c:2410
kthread+0x318/0x420 kernel/kthread.c:255
ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 83:
kmem_cache_alloc_node+0xdc/0x330 mm/slub.c:2814
__alloc_skb+0xba/0x5a0 net/core/skbuff.c:198
alloc_skb include/linux/skbuff.h:1081 [inline]
htc_connect_service+0x2cc/0x840
drivers/net/wireless/ath/ath9k/htc_hst.c:257
ath9k_wmi_connect+0xd2/0x1a0 drivers/net/wireless/ath/ath9k/wmi.c:265
ath9k_init_htc_services.constprop.0+0xb4/0x650
drivers/net/wireless/ath/ath9k/htc_drv_init.c:146
ath9k_htc_probe_device+0x25a/0x1d80
drivers/net/wireless/ath/ath9k/htc_drv_init.c:959
ath9k_htc_hw_init+0x31/0x60
drivers/net/wireless/ath/ath9k/htc_hst.c:501
ath9k_hif_usb_firmware_cb+0x26b/0x500
drivers/net/wireless/ath/ath9k/hif_usb.c:1187
request_firmware_work_func+0x126/0x242
drivers/base/firmware_loader/main.c:976
process_one_work+0x94b/0x1620 kernel/workqueue.c:2264
worker_thread+0x96/0xe20 kernel/workqueue.c:2410
kthread+0x318/0x420 kernel/kthread.c:255
ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 0:
kfree_skb+0x102/0x3d0 net/core/skbuff.c:690
ath9k_htc_txcompletion_cb+0x1f8/0x2b0
drivers/net/wireless/ath/ath9k/htc_hst.c:356
hif_usb_regout_cb+0x10b/0x1b0
drivers/net/wireless/ath/ath9k/hif_usb.c:90
__usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966
call_timer_fn+0x195/0x6f0 kernel/time/timer.c:1404
expire_timers kernel/time/timer.c:1449 [inline]
__run_timers kernel/time/timer.c:1773 [inline]
__run_timers kernel/time/timer.c:1740 [inline]
run_timer_softirq+0x5f9/0x1500 kernel/time/timer.c:1786
__do_softirq+0x21e/0x950 kernel/softirq.c:292

Reported-and-tested-by: syzbot+9505af1ae303dabdc646@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 3 ---
 drivers/net/wireless/ath/ath9k/wmi.c     | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index d091c8ebdcf0..1bf63a4efb4c 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -170,7 +170,6 @@ static int htc_config_pipe_credits(struct htc_target *target)
 	time_left = wait_for_completion_timeout(&target->cmd_wait, HZ);
 	if (!time_left) {
 		dev_err(target->dev, "HTC credit config timeout\n");
-		kfree_skb(skb);
 		return -ETIMEDOUT;
 	}
 
@@ -206,7 +205,6 @@ static int htc_setup_complete(struct htc_target *target)
 	time_left = wait_for_completion_timeout(&target->cmd_wait, HZ);
 	if (!time_left) {
 		dev_err(target->dev, "HTC start timeout\n");
-		kfree_skb(skb);
 		return -ETIMEDOUT;
 	}
 
@@ -279,7 +277,6 @@ int htc_connect_service(struct htc_target *target,
 	if (!time_left) {
 		dev_err(target->dev, "Service connection timeout for: %d\n",
 			service_connreq->service_id);
-		kfree_skb(skb);
 		return -ETIMEDOUT;
 	}
 
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index cdc146091194..d1f6710ca63b 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -336,7 +336,6 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 		ath_dbg(common, WMI, "Timeout waiting for WMI command: %s\n",
 			wmi_cmd_to_name(cmd_id));
 		mutex_unlock(&wmi->op_mutex);
-		kfree_skb(skb);
 		return -ETIMEDOUT;
 	}
 
-- 
2.17.1


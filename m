Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75C5629135
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 05:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiKOEfJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 23:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiKOEfH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 23:35:07 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7249C1AB
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 20:35:02 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 6so12195295pgm.6
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 20:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aayuwqnlJo6798erqbGme/3jUfWMFXftS+3pA5qdAfE=;
        b=Iwc9sl7AF0D5Bm2eKgiAlzMhxx2CFZIFyr9zmyIftluyHLLeE4E2K7g7u6LctQEKL1
         sM/86rrVzG9veRYSvowzgLI5bOv1+caqJ/kS61TO0juTKELwARPjDwoFVgN09N/B4IVE
         fV12oy/7d+VdWeZZyUYqSr3tCevXDfWA/YtGZcapSqQ51UDxJUsM75Kget1yH67ZLJZ6
         hcon8xecmygNuZgm2B2xj+ORQLGEdTz/zb476wcXyzRu9UN34bd/VOJSlExDYsGldMmD
         bMOp+CyQSkeNWntMN5KTHRSEd8ogw9b5QRKir5qjNjPRa+gjle+gOVR3EJpIQgC3Ozs8
         7+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aayuwqnlJo6798erqbGme/3jUfWMFXftS+3pA5qdAfE=;
        b=ZrpDlFNuPcYq6iEgU99y53cg8P3WgbMUYdZJuxF00FGxXMNf5heAGWZOhZgzE+kOuV
         B5DRX0idhvLHc4uJvX3c0KZZfy7T+3fJ/Xl6LuDMDuNUdzSKWnSkxxVrpHeYAPFsy0rR
         qprAsW0e4T//rnvZNB1c4fNx6Upg8UmyLx93u0KND1IW2t9A9jsl4EMOl58O3eq0/3zK
         wg2aPZz/8RcdQwH3bE1UVbPI4Pl2xLRAlJTwG/VxDCo3wG68F0dS7h6GYTBLiYdft9uf
         Z/4FhgKHfT3RQ7TtnnBRLROmPp/l9z7DkumYjLe26Y5BAqZMb2IwttBYY4gSR1/gVB3I
         HuYg==
X-Gm-Message-State: ANoB5pmeRg1hBtaxsvm069UTA2mgmn0W0P2QIZ3ImMp1207MUhqRHj2x
        nkBJ73MCIIRK73tVUmQqO2bmCET8kBiUi1s=
X-Google-Smtp-Source: AA0mqf5JCYjCUyltFCVbBhaVyQTtpzRvhGrTJ84IeLTq2I6otS9/W/qTFYz/0ohScUVeBxzGThGmig==
X-Received: by 2002:a65:6a0f:0:b0:470:537c:1091 with SMTP id m15-20020a656a0f000000b00470537c1091mr14375315pgu.282.1668486901960;
        Mon, 14 Nov 2022 20:35:01 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.55])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b00176b3c9693esm8481890plf.299.2022.11.14.20.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 20:35:01 -0800 (PST)
From:   Jisoo Jang <jisoo.jang@yonsei.ac.kr>
To:     aspriel@gmail.com, linux-wireless@vger.kernel.org
Cc:     Dokyung Song <dokyungs@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH] wifi: brcmfmac: Fix potential stack-out-of-bounds in brcmf_c_preinit_dcmds()
Date:   Tue, 15 Nov 2022 13:34:58 +0900
Message-Id: <20221115043458.37562-1-jisoo.jang@yonsei.ac.kr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch fixes a stack-out-of-bounds read in brcmfmac that occurs
when 'buf' that is not null-terminated is passed as an argument of 
strsep() in brcmf_c_preinit_dcmds(). This buffer is filled with a firmware 
version string by memcpy() in brcmf_fil_iovar_data_get().
The patch ensures buf is null-terminated.

Found by a modified version of syzkaller.

[   47.569679][ T1897] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43236b for chip BCM43236/3
[   47.582839][ T1897] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
[   47.601565][ T1897] ==================================================================
[   47.602574][ T1897] BUG: KASAN: stack-out-of-bounds in strsep+0x1b2/0x1f0
[   47.603447][ T1897] Read of size 1 at addr ffffc90001f6f000 by task kworker/0:2/1897
[   47.604336][ T1897] 
[   47.604621][ T1897] CPU: 0 PID: 1897 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #131
[   47.605617][ T1897] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   47.606907][ T1897] Workqueue: usb_hub_wq hub_event
[   47.607453][ T1897] Call Trace:
[   47.607801][ T1897]  dump_stack_lvl+0x8e/0xd1
[   47.608295][ T1897]  print_address_description.constprop.0.cold+0xf/0x334
[   47.609009][ T1897]  ? strsep+0x1b2/0x1f0
[   47.609434][ T1897]  ? strsep+0x1b2/0x1f0
[   47.609863][ T1897]  kasan_report.cold+0x83/0xdf
[   47.610366][ T1897]  ? strsep+0x1b2/0x1f0
[   47.610882][ T1897]  strsep+0x1b2/0x1f0
[   47.611300][ T1897]  ? brcmf_fil_iovar_data_get+0x3a/0xf0
[   47.611883][ T1897]  brcmf_c_preinit_dcmds+0x995/0xc40
[   47.612434][ T1897]  ? brcmf_c_set_joinpref_default+0x100/0x100
[   47.613078][ T1897]  ? rcu_read_lock_sched_held+0xa1/0xd0
[   47.613662][ T1897]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   47.614208][ T1897]  ? lock_acquire+0x19d/0x4e0
[   47.614704][ T1897]  ? find_held_lock+0x2d/0x110
[   47.615236][ T1897]  ? brcmf_usb_deq+0x1a7/0x260
[   47.615741][ T1897]  ? brcmf_usb_rx_fill_all+0x5a/0xf0
[   47.616288][ T1897]  brcmf_attach+0x246/0xd40
[   47.616758][ T1897]  ? wiphy_new_nm+0x1703/0x1dd0
[   47.617280][ T1897]  ? kmemdup+0x43/0x50
[   47.617720][ T1897]  brcmf_usb_probe+0x12de/0x1690
[   47.618244][ T1897]  ? brcmf_usbdev_qinit.constprop.0+0x470/0x470
[   47.618901][ T1897]  usb_probe_interface+0x2aa/0x760
[   47.619429][ T1897]  ? usb_probe_device+0x250/0x250
[   47.619950][ T1897]  really_probe+0x205/0xb70
[   47.620435][ T1897]  ? driver_allows_async_probing+0x130/0x130
[   47.621048][ T1897]  __driver_probe_device+0x311/0x4b0
[   47.621595][ T1897]  ? driver_allows_async_probing+0x130/0x130
[   47.622209][ T1897]  driver_probe_device+0x4e/0x150
[   47.622739][ T1897]  __device_attach_driver+0x1cc/0x2a0
[   47.623287][ T1897]  bus_for_each_drv+0x156/0x1d0
[   47.623796][ T1897]  ? bus_rescan_devices+0x30/0x30
[   47.624309][ T1897]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   47.624907][ T1897]  ? trace_hardirqs_on+0x46/0x160
[   47.625437][ T1897]  __device_attach+0x23f/0x3a0
[   47.625924][ T1897]  ? device_bind_driver+0xd0/0xd0
[   47.626433][ T1897]  ? kobject_uevent_env+0x287/0x14b0
[   47.627057][ T1897]  bus_probe_device+0x1da/0x290
[   47.627557][ T1897]  device_add+0xb7b/0x1eb0
[   47.628027][ T1897]  ? wait_for_completion+0x290/0x290
[   47.628593][ T1897]  ? __fw_devlink_link_to_suppliers+0x5a0/0x5a0
[   47.629249][ T1897]  usb_set_configuration+0xf59/0x16f0
[   47.629829][ T1897]  usb_generic_driver_probe+0x82/0xa0
[   47.630385][ T1897]  usb_probe_device+0xbb/0x250
[   47.630927][ T1897]  ? usb_suspend+0x590/0x590
[   47.631397][ T1897]  really_probe+0x205/0xb70
[   47.631855][ T1897]  ? driver_allows_async_probing+0x130/0x130
[   47.632469][ T1897]  __driver_probe_device+0x311/0x4b0
[   47.633002][ T1897]  ? usb_generic_driver_match+0x75/0x90
[   47.633573][ T1897]  ? driver_allows_async_probing+0x130/0x130
[   47.634170][ T1897]  driver_probe_device+0x4e/0x150
[   47.634703][ T1897]  __device_attach_driver+0x1cc/0x2a0
[   47.635248][ T1897]  bus_for_each_drv+0x156/0x1d0
[   47.635748][ T1897]  ? bus_rescan_devices+0x30/0x30
[   47.636271][ T1897]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   47.636881][ T1897]  ? trace_hardirqs_on+0x46/0x160
[   47.637396][ T1897]  __device_attach+0x23f/0x3a0
[   47.637904][ T1897]  ? device_bind_driver+0xd0/0xd0
[   47.638426][ T1897]  ? kobject_uevent_env+0x287/0x14b0
[   47.638985][ T1897]  bus_probe_device+0x1da/0x290
[   47.639512][ T1897]  device_add+0xb7b/0x1eb0
[   47.639977][ T1897]  ? __fw_devlink_link_to_suppliers+0x5a0/0x5a0
[   47.640612][ T1897]  ? kfree+0x14a/0x6b0
[   47.641055][ T1897]  ? __usb_get_extra_descriptor+0x116/0x160
[   47.641679][ T1897]  usb_new_device.cold+0x49c/0x1029
[   47.642245][ T1897]  ? hub_disconnect+0x450/0x450
[   47.642756][ T1897]  ? rwlock_bug.part.0+0x90/0x90
[   47.643273][ T1897]  ? _raw_spin_unlock_irq+0x24/0x30
[   47.643822][ T1897]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   47.644445][ T1897]  hub_event+0x1c98/0x3950
[   47.644939][ T1897]  ? hub_port_debounce+0x2e0/0x2e0
[   47.645467][ T1897]  ? check_irq_usage+0x861/0xf20
[   47.645975][ T1897]  ? drain_workqueue+0x280/0x360
[   47.646506][ T1897]  ? lock_release+0x640/0x640
[   47.646994][ T1897]  ? rcu_read_lock_sched_held+0xa1/0xd0
[   47.647572][ T1897]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   47.648111][ T1897]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   47.648735][ T1897]  process_one_work+0x92b/0x1460
[   47.649262][ T1897]  ? pwq_dec_nr_in_flight+0x330/0x330
[   47.649816][ T1897]  ? rwlock_bug.part.0+0x90/0x90
[   47.650336][ T1897]  worker_thread+0x95/0xe00
[   47.650830][ T1897]  ? __kthread_parkme+0x115/0x1e0
[   47.651361][ T1897]  ? process_one_work+0x1460/0x1460
[   47.651904][ T1897]  kthread+0x3a1/0x480
[   47.652329][ T1897]  ? set_kthread_struct+0x120/0x120
[   47.652878][ T1897]  ret_from_fork+0x1f/0x30
[   47.653370][ T1897] 
[   47.653608][ T1897] 
[   47.653848][ T1897] addr ffffc90001f6f000 is located in stack of task kworker/0:2/1897 at offset 512 in frame:
[   47.654891][ T1897]  brcmf_c_preinit_dcmds+0x0/0xc40
[   47.655442][ T1897] 
[   47.655690][ T1897] this frame has 4 objects:
[   47.656151][ T1897]  [48, 56) 'ptr'
[   47.656159][ T1897]  [80, 148) 'revinfo'
[   47.656534][ T1897]  [192, 210) 'eventmask'
[   47.656953][ T1897]  [256, 512) 'buf'
[   47.657410][ T1897] 
[   47.658035][ T1897] Memory state around the buggy address:
[   47.658743][ T1897]  ffffc90001f6ef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   47.659577][ T1897]  ffffc90001f6ef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   47.660394][ T1897] >ffffc90001f6f000: f3 f3 f3 f3 f3 f3 f3 f3 00 00 00 00 00 00 00 00
[   47.661199][ T1897]                    ^
[   47.661625][ T1897]  ffffc90001f6f080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   47.662455][ T1897]  ffffc90001f6f100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
[   47.663318][ T1897] ==================================================================
[   47.664147][ T1897] Disabling lock debugging due to kernel taint

Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Signed-off-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index 74020fa10065..d2209e11b40c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -298,6 +298,7 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 			 err);
 		goto done;
 	}
+	buf[sizeof(buf) - 1] = '\0';
 	ptr = (char *)buf;
 	strsep(&ptr, "\n");
 
-- 
2.25.1


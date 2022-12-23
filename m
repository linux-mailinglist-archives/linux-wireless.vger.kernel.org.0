Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5ED654D7C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Dec 2022 09:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiLWIaF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Dec 2022 03:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiLWIaE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Dec 2022 03:30:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759FA33CF9
        for <linux-wireless@vger.kernel.org>; Fri, 23 Dec 2022 00:29:59 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so8190581pjr.3
        for <linux-wireless@vger.kernel.org>; Fri, 23 Dec 2022 00:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SurKB4pqQ1YtMXnnuq7ru1OkXsl9CH+hrj4d7ncN/K8=;
        b=U2KEJXfP4rGyGBVGLp3Q2cU2NMohQ65fs5PqRNB8G9rhP79LM9ZYf0+eohmEyfPzAM
         XEW7A+zCcpMPgXQp89hpZSw12mXqKSVAZ0OMyj96oyrYmeNZxA89dn+Ix6albJxYLCYY
         QHtNKaxg0M5t7iu6lQazUbzHZjlc8d/idrPEgfjHMpRSQOVQxxvmZF+p38d5fleRSUeH
         4SaeXc0JvCWZaF6Db0AP5O+hE8OC1kvaIFvoxk03YpOO1++7mo9/p1uz+l3RT9y8AdFF
         iMUlw23J9oQGiNGPxsjzG8jNAcZjGwcY+ULjZV26RZ5idC9a6cr1TAqQGyddPETIcpGQ
         A1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SurKB4pqQ1YtMXnnuq7ru1OkXsl9CH+hrj4d7ncN/K8=;
        b=VmBUlvOyLRKCrz6AyvjyYGjRvSo9J4z3n0RiSZ9ETptl17rtISnTsW0p5RwYazVlN+
         HCGN7O7AAxAdUzb+tWhyMsXl2PP661U8i8HFNpKMtpmyDUG3tsbUboWnjVXw8go2awwm
         55uV63QUNXr5Zio5cwLLf4OCZiF4x8Sb9mrzIaG9ig2soeCARCBMPibblSP/SFsThTvx
         M26BoZ67tFeQK7D40RWhZoKASHBTP5RKiBwauBIiBtPbKHIDlSntkJbjIuY+vEI9SCN9
         xNJZa/4qlaQsKbv9cnABsIKTtOW4hRb8u2WoTHuwfDSsPc3GPU2C2WUW9J8iA62L0fyl
         GiWg==
X-Gm-Message-State: AFqh2kqj8JjehDym0Ozp+DklzM9umbY/Ozx05G3/vQYxCppuVsD81UeD
        sYNJrCbfdTC1Et1S0iXBRePZvRDnJ+Ib3dBrev6S
X-Google-Smtp-Source: AMrXdXuoV39Yfn1DLutclkPDDg8hkqwT0toZRlozVHDRMh9VKcgrpp+vWgk6RpluWJFQfAyiRsm0lg==
X-Received: by 2002:a05:6300:8181:b0:a5:6ed:669f with SMTP id bt1-20020a056300818100b000a506ed669fmr27747232pzc.2.1671784198628;
        Fri, 23 Dec 2022 00:29:58 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.55])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b001895b2c4cf6sm1738454pln.297.2022.12.23.00.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 00:29:58 -0800 (PST)
From:   Jisoo Jang <jisoo.jang@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org, arend.vanspriel@broadcom.com
Cc:     dokyungs@yonsei.ac.kr, linuxlovemin@yonsei.ac.kr
Subject: [PATCH] wifi: brcmfmac: ensure CLM version is null-terminated to prevent stack-out-of-bounds
Date:   Fri, 23 Dec 2022 17:29:55 +0900
Message-Id: <20221223082955.687191-1-jisoo.jang@yonsei.ac.kr>
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

Fix a stack-out-of-bounds read in brcmfmac that occurs
when 'buf' that is not null-terminated is passed as an argument of
strreplace() in brcmf_c_preinit_dcmds(). This buffer is filled with
a CLM version string by memcpy() in brcmf_fil_iovar_data_get().
Ensure buf is null-terminated.

Found by a modified version of syzkaller.

[   33.004414][ T1896] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
[   33.013486][ T1896] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43236/3 wl0: Nov 30 2011 17:33:42 version 5.90.188.22
[   33.021554][ T1896] ==================================================================
[   33.022379][ T1896] BUG: KASAN: stack-out-of-bounds in strreplace+0xf2/0x110
[   33.023122][ T1896] Read of size 1 at addr ffffc90001d6efc8 by task kworker/0:2/1896
[   33.023852][ T1896] 
[   33.024096][ T1896] CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #132
[   33.024927][ T1896] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   33.026065][ T1896] Workqueue: usb_hub_wq hub_event
[   33.026581][ T1896] Call Trace:
[   33.026896][ T1896]  dump_stack_lvl+0x57/0x7d
[   33.027372][ T1896]  print_address_description.constprop.0.cold+0xf/0x334
[   33.028037][ T1896]  ? strreplace+0xf2/0x110
[   33.028403][ T1896]  ? strreplace+0xf2/0x110
[   33.028807][ T1896]  kasan_report.cold+0x83/0xdf
[   33.029283][ T1896]  ? strreplace+0xf2/0x110
[   33.029666][ T1896]  strreplace+0xf2/0x110
[   33.029966][ T1896]  brcmf_c_preinit_dcmds+0xab1/0xc40
[   33.030351][ T1896]  ? brcmf_c_set_joinpref_default+0x100/0x100
[   33.030787][ T1896]  ? rcu_read_lock_sched_held+0xa1/0xd0
[   33.031223][ T1896]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   33.031661][ T1896]  ? lock_acquire+0x19d/0x4e0
[   33.032091][ T1896]  ? find_held_lock+0x2d/0x110
[   33.032605][ T1896]  ? brcmf_usb_deq+0x1a7/0x260
[   33.033087][ T1896]  ? brcmf_usb_rx_fill_all+0x5a/0xf0
[   33.033582][ T1896]  brcmf_attach+0x246/0xd40
[   33.034022][ T1896]  ? wiphy_new_nm+0x1476/0x1d50
[   33.034383][ T1896]  ? kmemdup+0x30/0x40
[   33.034722][ T1896]  brcmf_usb_probe+0x12de/0x1690
[   33.035223][ T1896]  ? brcmf_usbdev_qinit.constprop.0+0x470/0x470
[   33.035833][ T1896]  usb_probe_interface+0x25f/0x710
[   33.036315][ T1896]  really_probe+0x1be/0xa90
[   33.036656][ T1896]  __driver_probe_device+0x2ab/0x460
[   33.037026][ T1896]  ? usb_match_id.part.0+0x88/0xc0
[   33.037383][ T1896]  driver_probe_device+0x49/0x120
[   33.037790][ T1896]  __device_attach_driver+0x18a/0x250
[   33.038300][ T1896]  ? driver_allows_async_probing+0x120/0x120
[   33.038986][ T1896]  bus_for_each_drv+0x123/0x1a0
[   33.039906][ T1896]  ? bus_rescan_devices+0x20/0x20
[   33.041412][ T1896]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   33.041861][ T1896]  ? trace_hardirqs_on+0x1c/0x120
[   33.042330][ T1896]  __device_attach+0x207/0x330
[   33.042664][ T1896]  ? device_bind_driver+0xb0/0xb0
[   33.043026][ T1896]  ? kobject_uevent_env+0x230/0x12c0
[   33.043515][ T1896]  bus_probe_device+0x1a2/0x260
[   33.043914][ T1896]  device_add+0xa61/0x1ce0
[   33.044227][ T1896]  ? __mutex_unlock_slowpath+0xe7/0x660
[   33.044891][ T1896]  ? __fw_devlink_link_to_suppliers+0x550/0x550
[   33.045531][ T1896]  usb_set_configuration+0x984/0x1770
[   33.046051][ T1896]  ? kernfs_create_link+0x175/0x230
[   33.046548][ T1896]  usb_generic_driver_probe+0x69/0x90
[   33.046931][ T1896]  usb_probe_device+0x9c/0x220
[   33.047434][ T1896]  really_probe+0x1be/0xa90
[   33.047760][ T1896]  __driver_probe_device+0x2ab/0x460
[   33.048134][ T1896]  driver_probe_device+0x49/0x120
[   33.048516][ T1896]  __device_attach_driver+0x18a/0x250
[   33.048910][ T1896]  ? driver_allows_async_probing+0x120/0x120
[   33.049437][ T1896]  bus_for_each_drv+0x123/0x1a0
[   33.049814][ T1896]  ? bus_rescan_devices+0x20/0x20
[   33.050164][ T1896]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   33.050579][ T1896]  ? trace_hardirqs_on+0x1c/0x120
[   33.050936][ T1896]  __device_attach+0x207/0x330
[   33.051399][ T1896]  ? device_bind_driver+0xb0/0xb0
[   33.051888][ T1896]  ? kobject_uevent_env+0x230/0x12c0
[   33.052314][ T1896]  bus_probe_device+0x1a2/0x260
[   33.052688][ T1896]  device_add+0xa61/0x1ce0
[   33.053121][ T1896]  ? __fw_devlink_link_to_suppliers+0x550/0x550
[   33.053568][ T1896]  usb_new_device.cold+0x463/0xf66
[   33.053953][ T1896]  ? hub_disconnect+0x400/0x400
[   33.054313][ T1896]  ? rwlock_bug.part.0+0x90/0x90
[   33.054661][ T1896]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   33.055094][ T1896]  hub_event+0x10d5/0x3330
[   33.055530][ T1896]  ? hub_port_debounce+0x280/0x280
[   33.055934][ T1896]  ? __lock_acquire+0x1671/0x5790
[   33.056387][ T1896]  ? wq_calc_node_cpumask+0x170/0x2a0
[   33.056924][ T1896]  ? lock_release+0x640/0x640
[   33.057383][ T1896]  ? rcu_read_lock_sched_held+0xa1/0xd0
[   33.057916][ T1896]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   33.058402][ T1896]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   33.059019][ T1896]  process_one_work+0x873/0x13e0
[   33.059488][ T1896]  ? lock_release+0x640/0x640
[   33.059932][ T1896]  ? pwq_dec_nr_in_flight+0x320/0x320
[   33.060446][ T1896]  ? rwlock_bug.part.0+0x90/0x90
[   33.060898][ T1896]  worker_thread+0x8b/0xd10
[   33.061348][ T1896]  ? __kthread_parkme+0xd9/0x1d0
[   33.061810][ T1896]  ? process_one_work+0x13e0/0x13e0
[   33.062288][ T1896]  kthread+0x379/0x450
[   33.062660][ T1896]  ? _raw_spin_unlock_irq+0x24/0x30
[   33.063148][ T1896]  ? set_kthread_struct+0x100/0x100
[   33.063606][ T1896]  ret_from_fork+0x1f/0x30
[   33.064070][ T1896] 
[   33.064313][ T1896] 
[   33.064545][ T1896] addr ffffc90001d6efc8 is located in stack of task kworker/0:2/1896 at offset 512 in frame:
[   33.065478][ T1896]  brcmf_c_preinit_dcmds+0x0/0xc40
[   33.065973][ T1896] 
[   33.066191][ T1896] this frame has 4 objects:
[   33.066614][ T1896]  [48, 56) 'ptr'
[   33.066618][ T1896]  [80, 148) 'revinfo'
[   33.066957][ T1896]  [192, 210) 'eventmask'
[   33.067338][ T1896]  [256, 512) 'buf'
[   33.067742][ T1896] 
[   33.068304][ T1896] Memory state around the buggy address:
[   33.068838][ T1896]  ffffc90001d6ee80: f2 00 00 02 f2 f2 f2 f2 f2 00 00 00 00 00 00 00
[   33.069545][ T1896]  ffffc90001d6ef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   33.070626][ T1896] >ffffc90001d6ef80: 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3
[   33.072052][ T1896]                                               ^
[   33.073043][ T1896]  ffffc90001d6f000: f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   33.074230][ T1896]  ffffc90001d6f080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   33.074914][ T1896] ==================================================================
[   33.075713][ T1896] Disabling lock debugging due to kernel taint


Signed-off-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>

---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index 4a309e5a5707..4b6adb6ce5e3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -319,6 +319,7 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 	if (err) {
 		brcmf_dbg(TRACE, "retrieving clmver failed, %d\n", err);
 	} else {
+		buf[sizeof(buf) - 1] = '\0';
 		clmver = (char *)buf;
 		/* store CLM version for adding it to revinfo debugfs file */
 		memcpy(ifp->drvr->clmver, clmver, sizeof(ifp->drvr->clmver));
-- 
2.25.1


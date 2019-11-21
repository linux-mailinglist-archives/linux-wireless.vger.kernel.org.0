Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A78105240
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 13:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfKUM05 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 07:26:57 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33704 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfKUM05 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 07:26:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id o14so1414059pjr.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 04:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l4zxaX3dCTmnygo5S9CarIvrQkRw+UBri7v/F60fCec=;
        b=hcl0q7x5X1qA35RxcWfoWFvLi9heSUGL+7alt8/6XjJVA6MdDthG8g2d4uPFSbikZA
         7YVlbVpP3Z194jpdtJosDIYuDF714KvlkvE1bEWlWp5lKKZ1ZhXcY59LgjBETsXQ8tsW
         IOTsMzktGlremmz4bWJP0z0ijz7V1bnbJ7Sav3bvRJuNep39iPjtLiEm/JYPBOWeuMk7
         bWfMAnLbyEFRMS3MQN1Xcg1qw1T0ZP6i9EFDgJIRo4LbQKmuNkMqpbH0wfnQig8Rde85
         jZFvhgXtGvb3rvqtxjR8Zwh0M+Em589eJPagPy0vC+4fpuyfDsp4fdhVnfXilmXCSOeG
         ZGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l4zxaX3dCTmnygo5S9CarIvrQkRw+UBri7v/F60fCec=;
        b=sQhxNbrVWD8UKo6DaJl1DMJqZsBtRoFIDLE2ruzvnW5N3g1TtFrnJoNKG7JLEsPbjD
         GQUCdrAXkDa2jE96brfRNFdwaPKyqD663nWAP2FVoil2hTVEr9EFX+scEqcLeltUmnZt
         L5mWBX6Y6GoLBGGaEoSgvC4dPUJFQL/hWfI8ckQL5PK1DwxsjMDUFkkZ9rHvfoXYNsXY
         UBAgOl8l0Kzvdo5nJ5ChUWTJM3Nz4c60+RP13w8V5z7AERIAxERySWK1tvmfReVe0/iH
         j+bR83LzoORbs98iGGy5LxgmweRnlm7gzqBHTi0YxRj6ycBN9FvbI+L4/+sNqLFgjSgZ
         FNpg==
X-Gm-Message-State: APjAAAVrzW5BDK9kP7Ok1aA/uWf5IVPkW7PBg2sFxluW7n/mVSFPTxxT
        ybVps/vmFQxNdpindaGg+KLM9fWM
X-Google-Smtp-Source: APXvYqxPxvc9L5XrQQhaq7b9Ec5JwbrZ3RDz5fZ5xS9b+7FNeZv/ImlIHtvtRiVWsx9hR9tGDMiC3Q==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr11225847pjq.52.1574339216458;
        Thu, 21 Nov 2019 04:26:56 -0800 (PST)
Received: from localhost.localdomain ([110.35.161.54])
        by smtp.gmail.com with ESMTPSA id t27sm3518671pfq.169.2019.11.21.04.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 04:26:55 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH mac80211] virt_wifi: fix use-after-free in virt_wifi_newlink()
Date:   Thu, 21 Nov 2019 12:26:45 +0000
Message-Id: <20191121122645.9355-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When virt_wifi interface is created, virt_wifi_newlink() is called and
it calls register_netdevice().
if register_netdevice() fails, it internally would call
->priv_destructor(), which is virt_wifi_net_device_destructor() and
it frees netdev. but virt_wifi_newlink() still use netdev.
So, use-after-free would occur in virt_wifi_newlink().

Test commands:
    ip link add dummy0 type dummy
    modprobe bonding
    ip link add bonding_masters link dummy0 type virt_wifi

Splat looks like:
[  202.220554] BUG: KASAN: use-after-free in virt_wifi_newlink+0x88b/0x9a0 [virt_wifi]
[  202.221659] Read of size 8 at addr ffff888061629cb8 by task ip/852

[  202.222896] CPU: 1 PID: 852 Comm: ip Not tainted 5.4.0-rc5 #3
[  202.223765] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  202.225073] Call Trace:
[  202.225532]  dump_stack+0x7c/0xbb
[  202.226073]  ? virt_wifi_newlink+0x88b/0x9a0 [virt_wifi]
[  202.226869]  print_address_description.constprop.5+0x1be/0x360
[  202.227759]  ? virt_wifi_newlink+0x88b/0x9a0 [virt_wifi]
[  202.228550]  ? virt_wifi_newlink+0x88b/0x9a0 [virt_wifi]
[  202.229362]  __kasan_report+0x12a/0x16f
[  202.229980]  ? virt_wifi_newlink+0x88b/0x9a0 [virt_wifi]
[  202.230714]  kasan_report+0xe/0x20
[  202.232595]  virt_wifi_newlink+0x88b/0x9a0 [virt_wifi]
[  202.233370]  __rtnl_newlink+0xb9f/0x11b0
[  202.233929]  ? rtnl_link_unregister+0x220/0x220
[  202.234668]  ? lock_acquire+0x164/0x3b0
[  202.235344]  ? rtnl_newlink+0x4c/0x90
[  202.235923]  ? is_bpf_text_address+0x86/0xf0
[  202.236588]  ? kernel_text_address+0x111/0x120
[  202.237291]  ? __lock_acquire+0xdfe/0x3de0
[  202.237834]  ? __kernel_text_address+0xe/0x30
[  202.238414]  ? unwind_get_return_address+0x5f/0xa0
[  202.239207]  ? create_prof_cpu_mask+0x20/0x20
[  202.240163]  ? arch_stack_walk+0x83/0xb0
[  202.240916]  ? stack_trace_save+0x82/0xb0
[  202.241640]  ? stack_trace_consume_entry+0x160/0x160
[  202.242595]  ? rtnl_newlink+0x4c/0x90
[  202.243499]  ? kasan_unpoison_shadow+0x30/0x40
[  202.244192]  ? kmem_cache_alloc_trace+0x12c/0x320
[  202.244909]  rtnl_newlink+0x65/0x90
[ ... ]

Fixes: c7cdba31ed8b ("mac80211-next: rtnetlink wifi simulation device")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/wireless/virt_wifi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index 7997cc6de334..01305ba2d3aa 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -450,7 +450,6 @@ static void virt_wifi_net_device_destructor(struct net_device *dev)
 	 */
 	kfree(dev->ieee80211_ptr);
 	dev->ieee80211_ptr = NULL;
-	free_netdev(dev);
 }
 
 /* No lock interaction. */
@@ -458,7 +457,7 @@ static void virt_wifi_setup(struct net_device *dev)
 {
 	ether_setup(dev);
 	dev->netdev_ops = &virt_wifi_ops;
-	dev->priv_destructor = virt_wifi_net_device_destructor;
+	dev->needs_free_netdev  = true;
 }
 
 /* Called in a RCU read critical section from netif_receive_skb */
@@ -544,6 +543,7 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 		goto unregister_netdev;
 	}
 
+	dev->priv_destructor = virt_wifi_net_device_destructor;
 	priv->being_deleted = false;
 	priv->is_connected = false;
 	priv->is_up = false;
-- 
2.17.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093E051BBC0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 11:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352286AbiEEJWE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiEEJWD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 05:22:03 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0055D4D63D
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 02:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651742304; x=1683278304;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U8fYG9j5kxrUnCx0J9kuynQZRue+acjxFZqNNHG4Nwc=;
  b=SgkWjScwCBWwSYuUghrAD50VDl25Aqut2Py/kQcBzq0jrmrDGAjT5TGd
   5xe4jhVBfk9GGm7PYRCDzVdp7nSblB+tgAEmTDZsu2Qq93Z5SU3JqwMca
   +CaN+YYtDPlwaie0w8njhxQvKix/7DfXeP5Zi013d3LEY7OgsnX8SlV/Q
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 May 2022 02:18:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 02:18:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 02:18:24 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 02:18:23 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath10k: reset pointer after memory free to avoid kernel crash by multi-free
Date:   Thu, 5 May 2022 05:18:04 -0400
Message-ID: <20220505091804.665-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When WMI command timed out happened in ath10k_wmi_cmd_send(), recovery
started, then ath10k_core_restart()->ath10k_halt()->ath10k_core_stop()->
ath10k_htt_rx_free() called for the 1st time, then ath10k_core_restart()->
ieee80211_restart_hw()->queue_work() called, then ieee80211_restart_work()
is queued in worker at the moment. Then suspend operation arrived and
wiphy_suspend called and it acquired rtnl_lock, and then called into
ath10k_stop()->ath10k_halt()->ath10k_core_stop()->ath10k_htt_rx_free(),
meanwhile ieee80211_restart_work() is waiting the rtnl_lock, so
ath10k_htt_rx_alloc() can not be called by ieee80211_restart_work()->
ieee80211_reconfig()->drv_start()->ath10k_start()->ath10k_core_start(),
then the memory freed for the 2nd time in ath10k_htt_rx_free() at this
moment, and kernel crash happened as below call stack.

Rest pointer to NULL for free memory to avoid multi-free.

[  428.469167] ------------[ cut here ]------------
[  428.469180] kernel BUG at mm/slub.c:4150!
[  428.469193] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  428.469203] CPU: 1 PID: 147 Comm: kworker/u4:4 Tainted: G        W         5.10.91-14222-ga1c4b1c83299 #1 620a72c7194de0370fd0a984a6f7032a6ed43d6c
[  428.469208] Hardware name: HP Grunt/Grunt, BIOS Google_Grunt.11031.169.0 06/24/2021
[  428.469219] Workqueue: events_unbound async_run_entry_fn
[  428.469230] RIP: 0010:kfree+0x319/0x31b
[  428.469235] Code: f9 fb ff 48 89 df 44 89 f6 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d e9 96 01 ff ff e8 6d 43 d5 ff e9 59 fd ff ff 0f 0b 0f 0b <0f> 0b 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 54 53 48 83 e4 f0
[  428.469241] RSP: 0018:ffffa1fac015fc30 EFLAGS: 00010246
[  428.469247] RAX: ffffedb10419d108 RBX: ffff8c05262b0000 RCX: ffffedb10498ac00
[  428.469252] RDX: ffff8c04a8c07000 RSI: 0000000000000000 RDI: ffff8c05262b0000
[  428.469256] RBP: ffffa1fac015fc78 R08: 0000000000000000 R09: ffffffffc04eed71
[  428.469260] R10: ffffedb10498ac00 R11: 0000000000000000 R12: ffff8c0508600f80
[  428.469265] R13: ffff8c0508603ca8 R14: 0000000000000000 R15: ffff8c0508602380
[  428.469271] FS:  0000000000000000(0000) GS:ffff8c052ad00000(0000) knlGS:0000000000000000
[  428.469276] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  428.469280] CR2: 00005c940ab31a48 CR3: 000000011c764000 CR4: 00000000001506e0
[  428.469285] Call Trace:
[  428.469295]  ? dma_free_attrs+0x5f/0x7d
[  428.469320]  ath10k_core_stop+0x5b/0x6f [ath10k_core 806151abc028dad4ca5e05ccf91f5120f8babc6b]
[  428.469336]  ath10k_halt+0x126/0x177 [ath10k_core 806151abc028dad4ca5e05ccf91f5120f8babc6b]
[  428.469352]  ath10k_stop+0x41/0x7e [ath10k_core 806151abc028dad4ca5e05ccf91f5120f8babc6b]
[  428.469387]  drv_stop+0x88/0x10e [mac80211 c248faf7eea878afb2c5aad3740bc0315b08197b]
[  428.469410]  __ieee80211_suspend+0x297/0x411 [mac80211 c248faf7eea878afb2c5aad3740bc0315b08197b]
[  428.469441]  rdev_suspend+0x6e/0xd0 [cfg80211 b5e6ab05f100fefb9c12e1210da0d62f6254b594]
[  428.469462]  wiphy_suspend+0xb1/0x105 [cfg80211 b5e6ab05f100fefb9c12e1210da0d62f6254b594]
[  428.469483]  ? name_show+0x2d/0x2d [cfg80211 b5e6ab05f100fefb9c12e1210da0d62f6254b594]
[  428.469490]  dpm_run_callback+0x8c/0x126
[  428.469511]  ? name_show+0x2d/0x2d [cfg80211 b5e6ab05f100fefb9c12e1210da0d62f6254b594]
[  428.469517]  __device_suspend+0x2e7/0x41b
[  428.469523]  async_suspend+0x1f/0x93
[  428.469529]  async_run_entry_fn+0x3d/0xd1
[  428.469535]  process_one_work+0x1b1/0x329
[  428.469541]  worker_thread+0x213/0x372
[  428.469547]  kthread+0x150/0x15f
[  428.469552]  ? pr_cont_work+0x58/0x58
[  428.469558]  ? kthread_blkcg+0x31/0x31

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 771252dd6d4e..f6645c7c55c2 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -301,12 +301,16 @@ void ath10k_htt_rx_free(struct ath10k_htt *htt)
 			  ath10k_htt_get_vaddr_ring(htt),
 			  htt->rx_ring.base_paddr);
 
+	ath10k_htt_config_paddrs_ring(htt, NULL);
+
 	dma_free_coherent(htt->ar->dev,
 			  sizeof(*htt->rx_ring.alloc_idx.vaddr),
 			  htt->rx_ring.alloc_idx.vaddr,
 			  htt->rx_ring.alloc_idx.paddr);
+	htt->rx_ring.alloc_idx.vaddr = NULL;
 
 	kfree(htt->rx_ring.netbufs_ring);
+	htt->rx_ring.netbufs_ring = NULL;
 }
 
 static inline struct sk_buff *ath10k_htt_rx_netbuf_pop(struct ath10k_htt *htt)
@@ -846,8 +850,10 @@ int ath10k_htt_rx_alloc(struct ath10k_htt *htt)
 			  ath10k_htt_get_rx_ring_size(htt),
 			  vaddr_ring,
 			  htt->rx_ring.base_paddr);
+	ath10k_htt_config_paddrs_ring(htt, NULL);
 err_dma_ring:
 	kfree(htt->rx_ring.netbufs_ring);
+	htt->rx_ring.netbufs_ring = NULL;
 err_netbuf:
 	return -ENOMEM;
 }

base-commit: 3637b73b8e805d011202e2bf10947f2d206695d4
-- 
2.31.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8646E0DF
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 03:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhLICbm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 21:31:42 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:33592 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229909AbhLICbm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 21:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639016890; x=1670552890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=09onxPkSZAaCFE4w/GyZ/nAYG3mvk8lmmMTCNn5pGOM=;
  b=cbWF3aH38XDaqM96AxFGahxKz1ptTAeWbndCzYXjt1m55t4cQKnJRckM
   r4d85J3oL1OMR8A0T4455GZzKSedh2/lPLsvT+MJUtn2bu05EZ/CCnhsk
   zi1HAgd6pbzp9zsXTHCfHFMXZ3QBCiFPYSugsXLEYx9mMedrGBhaDliEZ
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Dec 2021 18:28:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 18:28:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 8 Dec 2021 18:28:08 -0800
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 8 Dec 2021 18:28:07 -0800
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] ath11k: Avoid false DEADLOCK warning reported by lockdep
Date:   Thu, 9 Dec 2021 09:19:49 +0800
Message-ID: <20211209011949.151472-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With CONFIG_LOCKDEP=y and CONFIG_DEBUG_SPINLOCK=y, lockdep reports
below warning:

[  166.059415] ============================================
[  166.059416] WARNING: possible recursive locking detected
[  166.059418] 5.15.0-wt-ath+ #10 Tainted: G        W  O
[  166.059420] --------------------------------------------
[  166.059421] kworker/0:2/116 is trying to acquire lock:
[  166.059423] ffff9905f2083160 (&srng->lock){+.-.}-{2:2}, at: ath11k_hal_reo_cmd_send+0x20/0x490 [ath11k]
[  166.059440]
               but task is already holding lock:
[  166.059442] ffff9905f2083230 (&srng->lock){+.-.}-{2:2}, at: ath11k_dp_process_reo_status+0x95/0x2d0 [ath11k]
[  166.059491]
               other info that might help us debug this:
[  166.059492]  Possible unsafe locking scenario:

[  166.059493]        CPU0
[  166.059494]        ----
[  166.059495]   lock(&srng->lock);
[  166.059498]   lock(&srng->lock);
[  166.059500]
                *** DEADLOCK ***

[  166.059501]  May be due to missing lock nesting notation

[  166.059502] 3 locks held by kworker/0:2/116:
[  166.059504]  #0: ffff9905c0081548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1f6/0x660
[  166.059511]  #1: ffff9d2400a5fe68 ((debug_obj_work).work){+.+.}-{0:0}, at: process_one_work+0x1f6/0x660
[  166.059517]  #2: ffff9905f2083230 (&srng->lock){+.-.}-{2:2}, at: ath11k_dp_process_reo_status+0x95/0x2d0 [ath11k]
[  166.059532]
               stack backtrace:
[  166.059534] CPU: 0 PID: 116 Comm: kworker/0:2 Kdump: loaded Tainted: G        W  O      5.15.0-wt-ath+ #10
[  166.059537] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0059.2019.1112.1124 11/12/2019
[  166.059539] Workqueue: events free_obj_work
[  166.059543] Call Trace:
[  166.059545]  <IRQ>
[  166.059547]  dump_stack_lvl+0x56/0x7b
[  166.059552]  __lock_acquire+0xb9a/0x1a50
[  166.059556]  lock_acquire+0x1e2/0x330
[  166.059560]  ? ath11k_hal_reo_cmd_send+0x20/0x490 [ath11k]
[  166.059571]  _raw_spin_lock_bh+0x33/0x70
[  166.059574]  ? ath11k_hal_reo_cmd_send+0x20/0x490 [ath11k]
[  166.059584]  ath11k_hal_reo_cmd_send+0x20/0x490 [ath11k]
[  166.059594]  ath11k_dp_tx_send_reo_cmd+0x3f/0x130 [ath11k]
[  166.059605]  ath11k_dp_rx_tid_del_func+0x221/0x370 [ath11k]
[  166.059618]  ath11k_dp_process_reo_status+0x22f/0x2d0 [ath11k]
[  166.059632]  ? ath11k_dp_service_srng+0x2ea/0x2f0 [ath11k]
[  166.059643]  ath11k_dp_service_srng+0x2ea/0x2f0 [ath11k]
[  166.059655]  ath11k_pci_ext_grp_napi_poll+0x1c/0x70 [ath11k_pci]
[  166.059659]  __napi_poll+0x28/0x230
[  166.059664]  net_rx_action+0x285/0x310
[  166.059668]  __do_softirq+0xe6/0x4d2
[  166.059672]  irq_exit_rcu+0xd2/0xf0
[  166.059675]  common_interrupt+0xa5/0xc0
[  166.059678]  </IRQ>
[  166.059679]  <TASK>
[  166.059680]  asm_common_interrupt+0x1e/0x40
[  166.059683] RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70
[  166.059686] Code: 83 c7 18 e8 2a 95 43 ff 48 89 ef e8 22 d2 43 ff 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 63 2e 40 ff 65 8b 05 8c 59 97 5c 85 c0 74 0a 5b 5d c3 e8 00 6a
[  166.059689] RSP: 0018:ffff9d2400a5fca0 EFLAGS: 00000206
[  166.059692] RAX: 0000000000000002 RBX: 0000000000000200 RCX: 0000000000000006
[  166.059694] RDX: 0000000000000000 RSI: ffffffffa404879b RDI: 0000000000000001
[  166.059696] RBP: ffff9905c0053000 R08: 0000000000000001 R09: 0000000000000001
[  166.059698] R10: ffff9d2400a5fc50 R11: 0000000000000001 R12: ffffe186c41e2840
[  166.059700] R13: 0000000000000001 R14: ffff9905c78a1c68 R15: 0000000000000001
[  166.059704]  free_debug_processing+0x257/0x3d0
[  166.059708]  ? free_obj_work+0x1f5/0x250
[  166.059712]  __slab_free+0x374/0x5a0
[  166.059718]  ? kmem_cache_free+0x2e1/0x370
[  166.059721]  ? free_obj_work+0x1f5/0x250
[  166.059724]  kmem_cache_free+0x2e1/0x370
[  166.059727]  free_obj_work+0x1f5/0x250
[  166.059731]  process_one_work+0x28b/0x660
[  166.059735]  ? process_one_work+0x660/0x660
[  166.059738]  worker_thread+0x37/0x390
[  166.059741]  ? process_one_work+0x660/0x660
[  166.059743]  kthread+0x176/0x1a0
[  166.059746]  ? set_kthread_struct+0x40/0x40
[  166.059749]  ret_from_fork+0x22/0x30
[  166.059754]  </TASK>

Since these two lockes are both initialized in ath11k_hal_srng_setup,
they are assigned with the same key. As a result lockdep suspects that
the task is trying to acquire the same lock (due to same key) while
already holding it, and thus reports the DEADLOCK warning. However as
they are different spinlock instances, the warning is false positive.

On the other hand, even no dead lock indeed, this is a major issue for
upstream regression testing as it disables lockdep functionality.

Fix it by assigning separate lock class key for each srng->lock.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal.c | 22 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hal.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 7cf9e23cb922..2ec09ae90080 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -974,6 +974,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 	srng->msi_data = params->msi_data;
 	srng->initialized = 1;
 	spin_lock_init(&srng->lock);
+	lockdep_set_class(&srng->lock, hal->srng_key + ring_id);
 
 	for (i = 0; i < HAL_SRNG_NUM_REG_GRP; i++) {
 		srng->hwreg_base[i] = srng_config->reg_start[i] +
@@ -1260,6 +1261,24 @@ static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
 	return 0;
 }
 
+static void ath11k_hal_register_srng_key(struct ath11k_base *ab)
+{
+	struct ath11k_hal *hal = &ab->hal;
+	u32 ring_id;
+
+	for (ring_id = 0; ring_id < HAL_SRNG_RING_ID_MAX; ring_id++)
+		lockdep_register_key(hal->srng_key + ring_id);
+}
+
+static void ath11k_hal_unregister_srng_key(struct ath11k_base *ab)
+{
+	struct ath11k_hal *hal = &ab->hal;
+	u32 ring_id;
+
+	for (ring_id = 0; ring_id < HAL_SRNG_RING_ID_MAX; ring_id++)
+		lockdep_unregister_key(hal->srng_key + ring_id);
+}
+
 int ath11k_hal_srng_init(struct ath11k_base *ab)
 {
 	struct ath11k_hal *hal = &ab->hal;
@@ -1279,6 +1298,8 @@ int ath11k_hal_srng_init(struct ath11k_base *ab)
 	if (ret)
 		goto err_free_cont_rdp;
 
+	ath11k_hal_register_srng_key(ab);
+
 	return 0;
 
 err_free_cont_rdp:
@@ -1293,6 +1314,7 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 {
 	struct ath11k_hal *hal = &ab->hal;
 
+	ath11k_hal_unregister_srng_key(ab);
 	ath11k_hal_free_cont_rdp(ab);
 	ath11k_hal_free_cont_wrp(ab);
 	kfree(hal->srng_config);
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 0f4f9ce74354..a7d9b4c551ad 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -902,6 +902,8 @@ struct ath11k_hal {
 	/* shadow register configuration */
 	u32 shadow_reg_addr[HAL_SHADOW_NUM_REGS];
 	int num_shadow_reg_configured;
+
+	struct lock_class_key srng_key[HAL_SRNG_RING_ID_MAX];
 };
 
 u32 ath11k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
-- 
2.25.1


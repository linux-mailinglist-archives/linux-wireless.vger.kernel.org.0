Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC3E52B0D7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 05:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiERDgW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 23:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiERDgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 23:36:16 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5601913EB7
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 20:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652844973; x=1684380973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JAN1AcjY3hwelJ274B19kXggAPIB+oZlQ0MrbCEdYIQ=;
  b=UoociU7FXYt+HCJ/E8RTGcAtgYu8krjvFeD+zf4XOERFvPDqyaP+YU0l
   HE+5sVCn2nSNHlxc7O1bj7xKHJEOK5HrIwdrnYgk8lE77uWYlZDY3RY0X
   xBFHy1SS4sneBlO2Kz5AGs0dLoW1/0Dpi2Bs5NnfSYqPo4waXylt1kHNz
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 17 May 2022 20:36:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 20:36:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 20:36:11 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 20:36:09 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: fix failed to find the peer with peer_id 0 when disconnected
Date:   Tue, 17 May 2022 23:35:56 -0400
Message-ID: <20220518033556.31940-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It has a fail log which is ath11k_dbg in ath11k_dp_rx_process_mon_status(),
as below, it will not print when debug_mask is not set ATH11K_DBG_DATA.
	ath11k_dbg(ab, ATH11K_DBG_DATA,
		  "failed to find the peer with peer_id %d\n",
		   ppdu_info.peer_id);

When run scan with station disconnected, the peer_id is 0 for case
HAL_RX_MPDU_START in ath11k_hal_rx_parse_mon_status_tlv() which called
from ath11k_dp_rx_process_mon_status(), and the peer_id of ppdu_info is
reset to 0 in the while loop, so it does not match condition of the
check "if (ppdu_info->peer_id == HAL_INVALID_PEERID" in the loop, and
then the log "failed to find the peer with peer_id 0" print after the
check in the loop, it is below call stack when debug_mask is set
ATH11K_DBG_DATA.

The reason is this commit 01d2f285e3e5 ("ath11k: decode HE status tlv")
add "memset(ppdu_info, 0, sizeof(struct hal_rx_mon_ppdu_info))" in
ath11k_dp_rx_process_mon_status(), but the commit does not initialize
the peer_id to HAL_INVALID_PEERID, then lead the check mis-match.

Callstack of the failed log:
[12335.689072] RIP: 0010:ath11k_dp_rx_process_mon_status+0x9ea/0x1020 [ath11k]
[12335.689157] Code: 89 ff e8 f9 10 00 00 be 01 00 00 00 4c 89 f7 e8 dc 4b 4e de 48 8b 85 38 ff ff ff c7 80 e4 07 00 00 01 00 00 00 e9 20 f8 ff ff <0f> 0b 41 0f b7 96 be 06 00 00 48 c7 c6 b8 50 44 c1 4c 89 ff e8 fd
[12335.689180] RSP: 0018:ffffb874001a4ca0 EFLAGS: 00010246
[12335.689210] RAX: 0000000000000000 RBX: ffff995642cbd100 RCX: 0000000000000000
[12335.689229] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff99564212cd18
[12335.689248] RBP: ffffb874001a4dc0 R08: 0000000000000001 R09: 0000000000000000
[12335.689268] R10: 0000000000000220 R11: ffffb874001a48e8 R12: ffff995642473d40
[12335.689286] R13: ffff99564212c5b8 R14: ffff9956424736a0 R15: ffff995642120000
[12335.689303] FS:  0000000000000000(0000) GS:ffff995739000000(0000) knlGS:0000000000000000
[12335.689323] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12335.689341] CR2: 00007f43c5d5e039 CR3: 000000011c012005 CR4: 00000000000606e0
[12335.689360] Call Trace:
[12335.689377]  <IRQ>
[12335.689418]  ? rcu_read_lock_held_common+0x12/0x50
[12335.689447]  ? rcu_read_lock_sched_held+0x25/0x80
[12335.689471]  ? rcu_read_lock_held_common+0x12/0x50
[12335.689504]  ath11k_dp_rx_process_mon_rings+0x8d/0x4f0 [ath11k]
[12335.689578]  ? ath11k_dp_rx_process_mon_rings+0x8d/0x4f0 [ath11k]
[12335.689653]  ? lock_acquire+0xef/0x360
[12335.689681]  ? rcu_read_lock_sched_held+0x25/0x80
[12335.689713]  ath11k_dp_service_mon_ring+0x38/0x60 [ath11k]
[12335.689784]  ? ath11k_dp_rx_process_mon_rings+0x4f0/0x4f0 [ath11k]
[12335.689860]  call_timer_fn+0xb2/0x2f0
[12335.689897]  ? ath11k_dp_rx_process_mon_rings+0x4f0/0x4f0 [ath11k]
[12335.689970]  run_timer_softirq+0x21f/0x540
[12335.689999]  ? ktime_get+0xad/0x160
[12335.690025]  ? lapic_next_deadline+0x2c/0x40
[12335.690053]  ? clockevents_program_event+0x82/0x100
[12335.690093]  __do_softirq+0x151/0x4a8
[12335.690135]  irq_exit_rcu+0xc9/0x100
[12335.690165]  sysvec_apic_timer_interrupt+0xa8/0xd0
[12335.690189]  </IRQ>
[12335.690204]  <TASK>
[12335.690225]  asm_sysvec_apic_timer_interrupt+0x12/0x20

Reset the default value to HAL_INVALID_PEERID each time after memset
of ppdu_info as well as others memset which existed in function
ath11k_dp_rx_process_mon_status(), then the failed log disappeared.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Fixes: 01d2f285e3e5 ("ath11k: decode HE status tlv")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 049774cc158c..09c4cb631e09 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5193,7 +5193,8 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		if (log_type != ATH11K_PKTLOG_TYPE_INVALID)
 			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
 
-		memset(ppdu_info, 0, sizeof(struct hal_rx_mon_ppdu_info));
+		memset(ppdu_info, 0, sizeof(*ppdu_info));
+		ppdu_info->peer_id = HAL_INVALID_PEERID;
 		hal_status = ath11k_hal_rx_parse_mon_status(ab, ppdu_info, skb);
 
 		if (test_bit(ATH11K_FLAG_MONITOR_STARTED, &ar->monitor_flags) &&

base-commit: 3637b73b8e805d011202e2bf10947f2d206695d4
-- 
2.31.1


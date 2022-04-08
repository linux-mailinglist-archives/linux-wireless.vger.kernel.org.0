Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8054F8D8D
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 08:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiDHFlc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Apr 2022 01:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiDHFl1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Apr 2022 01:41:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1908B194FE1
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 22:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649396365; x=1680932365;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=EJ7JvQfWiDrfbRN90dV4tzCosbN9ZPlKcby+pY0UAAc=;
  b=m7CaC0gGfBIHVwl6CRmWwzqybxNtile1baHrH/+vse+wF2392rWPowY0
   fGawbtc3Bw3SKryEiIZ7MYuFCW9ckogVOrE5Na2B9tEUSJvrjJX1n3LSM
   /K2KonNHPgtKUgBwuAGQHpC6ggMfMaaw7GkBDHtHTkC9zszCyYVHAgjfD
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Apr 2022 22:39:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 22:39:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 22:39:23 -0700
Received: from haric-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 22:39:20 -0700
From:   <quic_haric@quicinc.com>
To:     <quic_kvalo@quicinc.com>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Hari Chandrakanthan" <quic_haric@quicinc.com>
Subject: [PATCH] ath11k: disable spectral scan during spectral deinit
Date:   Fri, 8 Apr 2022 11:09:05 +0530
Message-ID: <1649396345-349-1-git-send-email-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Hari Chandrakanthan <quic_haric@quicinc.com>

When ath11k modules are removed using rmmod with spectral scan enabled,
crash is observed. Different crash trace is observed for each crash.

Send spectral scan disable WMI command to firmware before cleaning
the spectral dbring in the spectral_deinit API to avoid this crash.

call trace from one of the crash observed:
[ 1252.880802] Unable to handle kernel NULL pointer dereference at virtual address 00000008
[ 1252.882722] pgd = 0f42e886
[ 1252.890955] [00000008] *pgd=00000000
[ 1252.893478] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[ 1253.093035] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.89 #0
[ 1253.115261] Hardware name: Generic DT based system
[ 1253.121149] PC is at ath11k_spectral_process_data+0x434/0x574 [ath11k]
[ 1253.125940] LR is at 0x88e31017
[ 1253.132448] pc : [<7f9387b8>]    lr : [<88e31017>]    psr: a0000193
[ 1253.135488] sp : 80d01bc8  ip : 00000001  fp : 970e0000
[ 1253.141737] r10: 88e31000  r9 : 970ec000  r8 : 00000080
[ 1253.146946] r7 : 94734040  r6 : a0000113  r5 : 00000057  r4 : 00000000
[ 1253.152159] r3 : e18cb694  r2 : 00000217  r1 : 1df1f000  r0 : 00000001
[ 1253.158755] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[ 1253.165266] Control: 10c0383d  Table: 5e71006a  DAC: 00000055
[ 1253.172472] Process swapper/0 (pid: 0, stack limit = 0x60870141)
[ 1253.458055] [<7f9387b8>] (ath11k_spectral_process_data [ath11k]) from [<7f917fdc>] (ath11k_dbring_buffer_release_event+0x214/0x2e4 [ath11k])
[ 1253.466139] [<7f917fdc>] (ath11k_dbring_buffer_release_event [ath11k]) from [<7f8ea3c4>] (ath11k_wmi_tlv_op_rx+0x1840/0x29cc [ath11k])
[ 1253.478807] [<7f8ea3c4>] (ath11k_wmi_tlv_op_rx [ath11k]) from [<7f8fe868>] (ath11k_htc_rx_completion_handler+0x180/0x4e0 [ath11k])
[ 1253.490699] [<7f8fe868>] (ath11k_htc_rx_completion_handler [ath11k]) from [<7f91308c>] (ath11k_ce_per_engine_service+0x2c4/0x3b4 [ath11k])
[ 1253.502386] [<7f91308c>] (ath11k_ce_per_engine_service [ath11k]) from [<7f9a4198>] (ath11k_pci_ce_tasklet+0x28/0x80 [ath11k_pci])
[ 1253.514811] [<7f9a4198>] (ath11k_pci_ce_tasklet [ath11k_pci]) from [<8032227c>] (tasklet_action_common.constprop.2+0x64/0xe8)
[ 1253.526476] [<8032227c>] (tasklet_action_common.constprop.2) from [<803021e8>] (__do_softirq+0x130/0x2d0)
[ 1253.537756] [<803021e8>] (__do_softirq) from [<80322610>] (irq_exit+0xcc/0xe8)
[ 1253.547304] [<80322610>] (irq_exit) from [<8036a4a4>] (__handle_domain_irq+0x60/0xb4)
[ 1253.554428] [<8036a4a4>] (__handle_domain_irq) from [<805eb348>] (gic_handle_irq+0x4c/0x90)
[ 1253.562321] [<805eb348>] (gic_handle_irq) from [<80301a78>] (__irq_svc+0x58/0x8c)

Tested on : WLAN.HK.2.6.0.1-00851-QCAHKSWPL_SILICONZ-1

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/spectral.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 2b18871..516a7b4 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -212,7 +212,10 @@ static int ath11k_spectral_scan_config(struct ath11k *ar,
 		return -ENODEV;
 
 	arvif->spectral_enabled = (mode != ATH11K_SPECTRAL_DISABLED);
+
+	spin_lock_bh(&ar->spectral.lock);
 	ar->spectral.mode = mode;
+	spin_unlock_bh(&ar->spectral.lock);
 
 	ret = ath11k_wmi_vdev_spectral_enable(ar, arvif->vdev_id,
 					      ATH11K_WMI_SPECTRAL_TRIGGER_CMD_CLEAR,
@@ -843,9 +846,6 @@ static inline void ath11k_spectral_ring_free(struct ath11k *ar)
 {
 	struct ath11k_spectral *sp = &ar->spectral;
 
-	if (!sp->enabled)
-		return;
-
 	ath11k_dbring_srng_cleanup(ar, &sp->rx_ring);
 	ath11k_dbring_buf_cleanup(ar, &sp->rx_ring);
 }
@@ -897,15 +897,16 @@ void ath11k_spectral_deinit(struct ath11k_base *ab)
 		if (!sp->enabled)
 			continue;
 
-		ath11k_spectral_debug_unregister(ar);
-		ath11k_spectral_ring_free(ar);
+		mutex_lock(&ar->conf_mutex);
+		ath11k_spectral_scan_config(ar, ATH11K_SPECTRAL_DISABLED);
+		mutex_unlock(&ar->conf_mutex);
 
 		spin_lock_bh(&sp->lock);
-
-		sp->mode = ATH11K_SPECTRAL_DISABLED;
 		sp->enabled = false;
-
 		spin_unlock_bh(&sp->lock);
+
+		ath11k_spectral_debug_unregister(ar);
+		ath11k_spectral_ring_free(ar);
 	}
 }
 
-- 
2.7.4


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6639C49C068
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 02:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiAZBCF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 20:02:05 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:61961 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235472AbiAZBCE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 20:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643158924; x=1674694924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=slw7T6DrfxeJnlmauv2H+QvKpnfaacNtgIaPN0nLako=;
  b=GPUYgcrJZpCAAs4YKUncIBUYIz+Q28x7JCJIWUikHTjBYVJ1+GcQ72+C
   3q9trtVCDsTvFZpJKYMTzRnjnniRjvufaAMjWL/n7Nq55JIBHBoRJ0a48
   nBastskgDEscrIO6mcqIdae5l2fVcg62AZ4kcaVpSkygaJaOFt12fXErk
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Jan 2022 17:02:04 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:02:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 17:02:04 -0800
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 17:02:03 -0800
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] ath11k: Fix missing rx_desc_get_ldpc_support in wcn6855_ops
Date:   Wed, 26 Jan 2022 09:01:44 +0800
Message-ID: <20220126010144.2090-1-quic_bqiang@quicinc.com>
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

rx_desc_get_ldpc_support is missing in wcn6855_ops, resulting in
kernel crash. Fix it by implementing WCN6855's version of this
field and adding it to wcn6855_ops.

Crash stack:
[  184.862605] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  184.862615] #PF: supervisor instruction fetch in kernel mode
[  184.862620] #PF: error_code(0x0010) - not-present page
[  184.862626] PGD 0 P4D 0
[  184.862634] Oops: 0010 [#1] PREEMPT SMP PTI
[  184.862642] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Not tainted 5.16.0-wt-ath+ #1
[  184.862651] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0059.2019.1112.1124 11/12/2019
[  184.862656] RIP: 0010:0x0
[  184.862669] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[  184.862673] RSP: 0018:ffff9eedc003cca8 EFLAGS: 00010202
[  184.862680] RAX: 0000000000000000 RBX: ffff9eedc003cd30 RCX: 0000000000000002
[  184.862686] RDX: 0000000000000002 RSI: ffffffffc1773458 RDI: ffff8eb5843de240
[  184.862692] RBP: ffff8eb59685a0e0 R08: 0000000000000001 R09: ffff8eb6fef2b000
[  184.862700] R10: ffff9eedc003cd70 R11: ffff8eb5880a9ff0 R12: ffff8eb5843de240
[  184.862707] R13: 0000000000000000 R14: 0000000000000008 R15: 0000000000000003
[  184.862714] FS:  0000000000000000(0000) GS:ffff8eb6f6c40000(0000) knlGS:0000000000000000
[  184.862723] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  184.862733] CR2: ffffffffffffffd6 CR3: 000000002f60a001 CR4: 00000000003706e0
[  184.862743] Call Trace:
[  184.862751]  <IRQ>
[  184.862759]  ath11k_dp_rx_h_ppdu+0x210/0x350 [ath11k]
[  184.862841]  ath11k_dp_rx_process_received_packets+0x1e6/0x6b0 [ath11k]
[  184.862891]  ath11k_dp_process_rx+0x32d/0x3e0 [ath11k]

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Fixes: b3febdccde3e ("ath11k: add LDPC FEC type in 802.11 radiotap header")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index b7e3b668a9c0..d1b0e76d9ec2 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -813,6 +813,12 @@ static u16 ath11k_hw_wcn6855_mpdu_info_get_peerid(u8 *tlv_data)
 	return peer_id;
 }
 
+static bool ath11k_hw_wcn6855_rx_desc_get_ldpc_support(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_LDPC,
+			 __le32_to_cpu(desc->u.wcn6855.msdu_start.info2));
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
@@ -983,6 +989,7 @@ const struct ath11k_hw_ops wcn6855_ops = {
 	.rx_desc_get_encrypt_type = ath11k_hw_wcn6855_rx_desc_get_encrypt_type,
 	.rx_desc_get_decap_type = ath11k_hw_wcn6855_rx_desc_get_decap_type,
 	.rx_desc_get_mesh_ctl = ath11k_hw_wcn6855_rx_desc_get_mesh_ctl,
+	.rx_desc_get_ldpc_support = ath11k_hw_wcn6855_rx_desc_get_ldpc_support,
 	.rx_desc_get_mpdu_seq_ctl_vld = ath11k_hw_wcn6855_rx_desc_get_mpdu_seq_ctl_vld,
 	.rx_desc_get_mpdu_fc_valid = ath11k_hw_wcn6855_rx_desc_get_mpdu_fc_valid,
 	.rx_desc_get_mpdu_start_seq_no = ath11k_hw_wcn6855_rx_desc_get_mpdu_start_seq_no,
-- 
2.25.1


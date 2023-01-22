Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E371E676A97
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jan 2023 02:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjAVBtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Jan 2023 20:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAVBtu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Jan 2023 20:49:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D696C1F908
        for <linux-wireless@vger.kernel.org>; Sat, 21 Jan 2023 17:49:49 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30M1nhxs023022;
        Sun, 22 Jan 2023 01:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=BTa5aTS5wPqLRBjFrqk6qKhpWB3VG58KH2NHA7ttiE8=;
 b=b4VojyWIZbAF9YuoGz2YI+ok3vVoL4Y/94WD5psNngIStWqkiYuH4nx1JJuu+cSQcgn4
 hGV5in/ScXUxhyB0/3r/vhP+iJUanhJ0VP43bUDNr3zWCg7fqVrEKxpGy5q5xldjq3+4
 t0jSP6LTcGUUelQq1P7iJloIkeD6z4IzjZmy2zjKiMKqkFS4sw32peht8PpRdfg1PHwW
 gw7OKXz9ULoDM87KY1IgMyvAIbqjsY7/TGbroImuED0p3mgsWU+GXTDWq/BxbP62KUDl
 szeMOB1zQPck/KcvUoGx37crYHsAB+yF9UrR4/DgC7kBwTFbshG2hdyFjXmf380RVTjv YA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89fm11rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Jan 2023 01:49:42 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 30M1nc37027993;
        Sun, 22 Jan 2023 01:49:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3n894k9t8m-1;
        Sun, 22 Jan 2023 01:49:38 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30M1ncS7027988;
        Sun, 22 Jan 2023 01:49:38 GMT
Received: from rgnanase-linux.qualcomm.com (rgnanase-linux.qualcomm.com [10.201.162.135])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 30M1ncQC027987;
        Sun, 22 Jan 2023 01:49:38 +0000
Received: by rgnanase-linux.qualcomm.com (Postfix, from userid 2378837)
        id CF84C110200D; Sun, 22 Jan 2023 07:19:37 +0530 (IST)
From:   Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH] wifi: ath12k: Handle lock during peer_id find
Date:   Sun, 22 Jan 2023 07:19:36 +0530
Message-Id: <20230122014936.3594-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AcMF6wBdrzhmvwpLCOEjIWv-uwv2ZFbT
X-Proofpoint-GUID: AcMF6wBdrzhmvwpLCOEjIWv-uwv2ZFbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_17,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=554
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301220014
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath12k_peer_find_by_id() requires that the caller hold the
ab->base_lock. Currently the WBM error path does not hold
the lock and calling that function, leads to the
following lockdep_assert()in QCN9274:

[105162.160893] ------------[ cut here ]------------
[105162.160916] WARNING: CPU: 3 PID: 0 at drivers/net/wireless/ath/ath12k/peer.c:71 ath12k_peer_find_by_id+0x52/0x60 [ath12k]
[105162.160933] Modules linked in: ath12k(O) qrtr_mhi qrtr mac80211 cfg80211 mhi qmi_helpers libarc4 nvme nvme_core [last unloaded: ath12k(O)]
[105162.160967] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W  O       6.1.0-rc2+ #3
[105162.160972] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0056.2019.0506.1527 05/06/2019
[105162.160977] RIP: 0010:ath12k_peer_find_by_id+0x52/0x60 [ath12k]
[105162.160990] Code: 07 eb 0f 39 68 24 74 0a 48 8b 00 48 39 f8 75 f3 31 c0 5b 5d c3 48 8d bf b0 f2 00 00 be ff ff ff ff e8 22 20 c4 e2 85 c0 75 bf <0f> 0b eb bb 66 2e 0f 1f 84 00 00 00 00 00 41 54 4c 8d a7 98 f2 00
[105162.160996] RSP: 0018:ffffa223001acc60 EFLAGS: 00010246
[105162.161003] RAX: 0000000000000000 RBX: ffff9f0573940000 RCX: 0000000000000000
[105162.161008] RDX: 0000000000000001 RSI: ffffffffa3951c8e RDI: ffffffffa39a96d7
[105162.161013] RBP: 000000000000000a R08: 0000000000000000 R09: 0000000000000000
[105162.161017] R10: ffffa223001acb40 R11: ffffffffa3d57c60 R12: ffff9f057394f2e0
[105162.161022] R13: ffff9f0573940000 R14: ffff9f04ecd659c0 R15: ffff9f04d5a9b040
[105162.161026] FS:  0000000000000000(0000) GS:ffff9f0575600000(0000) knlGS:0000000000000000
[105162.161031] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[105162.161036] CR2: 00001d5c8277a008 CR3: 00000001e6224006 CR4: 00000000003706e0
[105162.161041] Call Trace:
[105162.161046]  <IRQ>
[105162.161051]  ath12k_dp_rx_process_wbm_err+0x6da/0xaf0 [ath12k]
[105162.161072]  ? ath12k_dp_rx_process_err+0x80e/0x15a0 [ath12k]
[105162.161084]  ? __lock_acquire+0x4ca/0x1a60
[105162.161104]  ath12k_dp_service_srng+0x263/0x310 [ath12k]
[105162.161120]  ath12k_pci_ext_grp_napi_poll+0x1c/0x70 [ath12k]
[105162.161133]  __napi_poll+0x22/0x260
[105162.161141]  net_rx_action+0x2f8/0x380
[105162.161153]  __do_softirq+0xd0/0x4c9
[105162.161162]  irq_exit_rcu+0x88/0xe0
[105162.161169]  common_interrupt+0xa5/0xc0
[105162.161174]  </IRQ>
[105162.161179]  <TASK>
[105162.161184]  asm_common_interrupt+0x22/0x40

Handle spin lock/unlock in WBM error path to hold the necessary lock
expected by ath12k_peer_find_by_id().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-03171-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index d6835d13f7ec..c0efdd76d291 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3495,11 +3495,14 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
 	peer_id = ath12k_dp_rx_h_peer_id(ab, desc);
 
+	spin_lock(&ab->base_lock);
 	if (!ath12k_peer_find_by_id(ab, peer_id)) {
+		spin_unlock(&ab->base_lock);
 		ath12k_dbg(ab, ATH12K_DBG_DATA, "invalid peer id received in wbm err pkt%d\n",
 			   peer_id);
 		return -EINVAL;
 	}
+	spin_unlock(&ab->base_lock);
 
 	if (!rxcb->is_frag && ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE)) {
 		/* First buffer will be freed by the caller, so deduct it's length */
-- 
2.17.1


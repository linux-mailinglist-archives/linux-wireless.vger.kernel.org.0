Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AE37829DC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjHUND5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjHUND4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 09:03:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02167CD
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 06:03:55 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LC1WrB032758;
        Mon, 21 Aug 2023 13:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=rhEBeMdZ21PdwS1/40g7cdCMcEX3QPTEjgRZxs125ZU=;
 b=gsrQzu357zW5vfJ0eLcAr1zotgD0DM/8aODsFq1RsM4STRS0bN0QHs8N/XT9ZdTev+XU
 q5r5DcBbVfaJUQM6SxmGhH39yTYD83AGQ2LI8aZUv2iQMjgLrrAFimQGH9TutWiC4QGY
 RXc4L+/9OVP2RFA6XbRao/IYNtqUXiB+v5OmqIwEfHJruybTHhm+h6E52Uzma2q/Oo9F
 c8zZ8KPxjAsNGbKWv4IbTLTR+/d9lEaEUMI3XX8eGLQ9jycH3ccarFoIYPc2nEI/ZJoC
 b2U0xOlvNFKqSM+bJOGI7D4HgVnyhPyOcMtatwcNrOltS9UBktcQ2YK8ECAw21IxqRLN 0w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm7jdg3wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 13:03:48 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37LCfvoM016034;
        Mon, 21 Aug 2023 13:03:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3sm27pc08s-1;
        Mon, 21 Aug 2023 13:03:48 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LD3mgX015039;
        Mon, 21 Aug 2023 13:03:48 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 37LD3lbb015033;
        Mon, 21 Aug 2023 13:03:48 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id 20AC7B003A8; Mon, 21 Aug 2023 18:33:46 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v2 1/2] wifi: ath12k: Ignore fragments from uninitialized peer in  dp
Date:   Mon, 21 Aug 2023 18:33:42 +0530
Message-Id: <20230821130343.29495-2-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821130343.29495-1-quic_hprem@quicinc.com>
References: <20230821130343.29495-1-quic_hprem@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m2fabhvWVMoxg3I7nhu81l2nTqFPqlH1
X-Proofpoint-ORIG-GUID: m2fabhvWVMoxg3I7nhu81l2nTqFPqlH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=993
 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210120
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When max virtual ap interfaces are configured in all the bands with
ACS and hostapd restart is done every 60s, a crash is observed at 
random times.

In the above scenario, a fragmented packet is received for self peer,
for which rx_tid and rx_frags are not initialized in datapath.
While handling this fragment, crash is observed as the rx_frag list
is uninitialized and when we walk in ath12k_dp_rx_h_sort_frags,
skb null leads to exception.

To address this, before processing received fragments we check
dp_setup_done flag is set to ensure that peer has completed its
dp peer setup for fragment queue, else ignore processing the
fragments.

Call trace:
    PC points to "ath12k_dp_process_rx_err+0x4e8/0xfcc [ath12k]"
    LR points to "ath12k_dp_process_rx_err+0x480/0xfcc [ath12k]".
    The Backtrace obtained is as follows:
    ath12k_dp_process_rx_err+0x4e8/0xfcc [ath12k]
    ath12k_dp_service_srng+0x78/0x260 [ath12k]
    ath12k_pci_write32+0x990/0xb0c [ath12k]
    __napi_poll+0x30/0xa4
    net_rx_action+0x118/0x270
    __do_softirq+0x10c/0x244
    irq_exit+0x64/0xb4
    __handle_domain_irq+0x88/0xac
    gic_handle_irq+0x74/0xbc
    el1_irq+0xf0/0x1c0
    arch_cpu_idle+0x10/0x18
    do_idle+0x104/0x248
    cpu_startup_entry+0x20/0x64
    rest_init+0xd0/0xdc
    arch_call_rest_init+0xc/0x14

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    | 1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c | 9 +++++++++
 drivers/net/wireless/ath/ath12k/peer.h  | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index ae1645d0f42a..d825e08d820a 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -38,6 +38,7 @@ void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr)
 
 	ath12k_dp_rx_peer_tid_cleanup(ar, peer);
 	crypto_free_shash(peer->tfm_mmic);
+	peer->dp_setup_done = false;
 	spin_unlock_bh(&ab->base_lock);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 67f8c140840f..5923c7c9eaff 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2748,6 +2748,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 	}
 
 	peer->tfm_mmic = tfm;
+	peer->dp_setup_done = true;
 	spin_unlock_bh(&ab->base_lock);
 
 	return 0;
@@ -3214,6 +3215,14 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 		ret = -ENOENT;
 		goto out_unlock;
 	}
+
+	if (!peer->dp_setup_done) {
+		ath12k_warn(ab, "The peer %pM [%d] has uninitialized datapath\n",
+			    peer->addr, peer_id);
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
 	rx_tid = &peer->rx_tid[tid];
 
 	if ((!skb_queue_empty(&rx_tid->rx_frags) && seqno != rx_tid->cur_sn) ||
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index b296dc0e2f67..c6edb24cbedd 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -44,6 +44,9 @@ struct ath12k_peer {
 	struct ppdu_user_delayba ppdu_stats_delayba;
 	bool delayba_flag;
 	bool is_authorized;
+
+	/* protected by ab->data_lock */
+	bool dp_setup_done;
 };
 
 void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
-- 
2.17.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022EB6D503D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 20:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjDCSZC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 14:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjDCSYz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 14:24:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE0358E
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 11:24:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333EUOmv031934;
        Mon, 3 Apr 2023 18:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ckZrq16xKW3fx0AS0GjNzN1sRUHB0juy48gpxnS61S8=;
 b=WdP/B5NPkA+jaFzw7TMLIF/nLmO7z4V/SUfHRQ0pF87/idjBvnMJXmiSwz5zcLUkvuLv
 1o6o1t4ZtAgsmkz4Qc9ODDMpUI3I/lZ5h60OOKVyjI+OHg9lssrDNWR2D2c13HJiEyNR
 urlsD4WSArXpLZcRKRWp7wXWDNen6cRtEmJfC0XZnE8KbPfjtRuAojEefk6/Syamwj5f
 040IuiaSZxaQilIcscA47AoKP/7moo4yYgAEbsoHEBKdZpvW6NoNXIpyacZzdy44SlY4
 0uGWE1ETet7yUihwmjKKa6fdOJM7xuz6HkL8g0+QLqgZVuujnbMbRL9zqx8EKWEtBTIJ UA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pquxthadd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 18:24:30 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 333IJBds026653;
        Mon, 3 Apr 2023 18:24:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3pr09uajnb-1;
        Mon, 03 Apr 2023 18:24:29 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 333INHIo000475;
        Mon, 3 Apr 2023 18:24:29 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 333IORl6002480;
        Mon, 03 Apr 2023 18:24:29 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id D6CB8B003D5; Mon,  3 Apr 2023 23:54:27 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Subject: [PATCH 3/3] wifi: ath11k: add peer mac information in failure cases
Date:   Mon,  3 Apr 2023 23:54:20 +0530
Message-Id: <20230403182420.23375-4-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230403182420.23375-1-quic_hprem@quicinc.com>
References: <20230403182420.23375-1-quic_hprem@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JVzxAmyq8IcIy9lLSJoTz-31UXH1y3xE
X-Proofpoint-ORIG-GUID: JVzxAmyq8IcIy9lLSJoTz-31UXH1y3xE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=801 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030141
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During reo command failure, the peer mac detail for which the reo
command was not successful is unknown. Hence, to improve the
debuggability, add the peer mac information in the failure cases
which would be useful during multi client cases.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index e2320109dac0..25b1d5646b28 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1009,7 +1009,8 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 
 	peer = ath11k_peer_find(ab, vdev_id, peer_mac);
 	if (!peer) {
-		ath11k_warn(ab, "failed to find the peer to set up rx tid\n");
+		ath11k_warn(ab, "failed to find the peer %pM to set up rx tid\n",
+			    peer_mac);
 		spin_unlock_bh(&ab->base_lock);
 		return -ENOENT;
 	}
@@ -1022,7 +1023,8 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 						    ba_win_sz, ssn, true);
 		spin_unlock_bh(&ab->base_lock);
 		if (ret) {
-			ath11k_warn(ab, "failed to update reo for rx tid %d\n", tid);
+			ath11k_warn(ab, "failed to update reo for peer %pM rx tid %d\n",
+				    peer_mac, tid);
 			return ret;
 		}
 
@@ -1030,8 +1032,8 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 							     peer_mac, paddr,
 							     tid, 1, ba_win_sz);
 		if (ret)
-			ath11k_warn(ab, "failed to send wmi command to update rx reorder queue, tid :%d (%d)\n",
-				    tid, ret);
+			ath11k_warn(ab, "failed to send wmi rx reorder queue, peer %pM tid :%d (%d)\n",
+				    peer_mac, tid, ret);
 		return ret;
 	}
 
@@ -1064,6 +1066,8 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 	ret = dma_mapping_error(ab->dev, paddr);
 	if (ret) {
 		spin_unlock_bh(&ab->base_lock);
+		ath11k_warn(ab, "failed to dma map for peer %pM rx tid :%d setup\n",
+			    peer_mac, tid);
 		goto err_mem_free;
 	}
 
@@ -1077,8 +1081,8 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 	ret = ath11k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id, peer_mac,
 						     paddr, tid, 1, ba_win_sz);
 	if (ret) {
-		ath11k_warn(ar->ab, "failed to setup rx reorder queue, tid :%d (%d)\n",
-			    tid, ret);
+		ath11k_warn(ar->ab, "failed to setup rx reorder queue, peer %pM tid :%d (%d)\n",
+			    peer_mac, tid, ret);
 		ath11k_dp_rx_tid_mem_free(ab, peer_mac, vdev_id, tid);
 	}
 
-- 
2.17.1


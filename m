Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309786D503F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 20:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjDCSZF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 14:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjDCSY6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 14:24:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349BF268A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 11:24:42 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333EU9K7030391;
        Mon, 3 Apr 2023 18:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=WTxloVtJSuo68AvdkK57svUPFnbPyzZUe2dJm++3DMM=;
 b=MdB9HO+zdn1hoWSgZcOEtHztlRbGTLUSYt5HpdaDBd6S/LxO7MlNEvFdH0f6m/HL8f/T
 zVBhhU9xgiNQTOudLG9LNXGF8qPz2Yg9eQiK1EYbuWdj54PMPSXGNp2vr/2vAihX9Au6
 WMWwdCvXviTCWKY6O1uRquYTNKZgdk79qVsmrWPqiYNO76IrXlWeIGgh0yp4ou8CYV/x
 8rfgsBrtdxf29UQZXx2tlELO/Ga7I1FbOJ5vfO7p+jaqMTWjURXr1zr/p8MG4moFLIzB
 +WCSuw672BMOYAkXY/6PiogFtjf10lJPPfWZDoeQHlbVrs/FPgpo14lDBo8Tmp49thSi tA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pr0kx0km9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 18:24:28 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 333IKaCT011014;
        Mon, 3 Apr 2023 18:24:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3pr0shtc1m-1;
        Mon, 03 Apr 2023 18:24:27 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 333IORen016690;
        Mon, 3 Apr 2023 18:24:27 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 333IOQTL016683;
        Mon, 03 Apr 2023 18:24:27 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id 1D5B3B003D5; Mon,  3 Apr 2023 23:54:25 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Subject: [PATCH 1/3] wifi: ath11k: fix double free of peer rx_tid during reo cmd failure
Date:   Mon,  3 Apr 2023 23:54:18 +0530
Message-Id: <20230403182420.23375-2-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230403182420.23375-1-quic_hprem@quicinc.com>
References: <20230403182420.23375-1-quic_hprem@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YygWbmqlrgPBYxhA78jSeJp8F9LQ3ljp
X-Proofpoint-ORIG-GUID: YygWbmqlrgPBYxhA78jSeJp8F9LQ3ljp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=650 clxscore=1011 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030140
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peer rx_tid is locally copied thrice during peer_rx_tid_cleanup to
send REO_CMD_UPDATE_RX_QUEUE followed by REO_CMD_FLUSH_CACHE to flush
all aged REO descriptors from HW cache.

When sending REO_CMD_FLUSH_CACHE fails, we do dma unmap of already
mapped rx_tid->vaddr and free it. This is not checked during
reo_cmd_list_cleanup() and dp_reo_cmd_free() before trying to free and
unmap again.

Fix this by setting rx_tid->vaddr NULL in rx tid delete and also
wherever freeing it to check in reo_cmd_list_cleanup() and
reo_cmd_free() before trying to free again.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 43 ++++++++++++++++++-------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 99859b59138e..e2320109dac0 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -668,13 +668,18 @@ void ath11k_dp_reo_cmd_list_cleanup(struct ath11k_base *ab)
 	struct ath11k_dp *dp = &ab->dp;
 	struct dp_reo_cmd *cmd, *tmp;
 	struct dp_reo_cache_flush_elem *cmd_cache, *tmp_cache;
+	struct dp_rx_tid *rx_tid;
 
 	spin_lock_bh(&dp->reo_cmd_lock);
 	list_for_each_entry_safe(cmd, tmp, &dp->reo_cmd_list, list) {
 		list_del(&cmd->list);
-		dma_unmap_single(ab->dev, cmd->data.paddr,
-				 cmd->data.size, DMA_BIDIRECTIONAL);
-		kfree(cmd->data.vaddr);
+		rx_tid = &cmd->data;
+		if (rx_tid->vaddr) {
+			dma_unmap_single(ab->dev, rx_tid->paddr,
+					 rx_tid->size, DMA_BIDIRECTIONAL);
+			kfree(rx_tid->vaddr);
+			rx_tid->vaddr = NULL;
+		}
 		kfree(cmd);
 	}
 
@@ -682,9 +687,13 @@ void ath11k_dp_reo_cmd_list_cleanup(struct ath11k_base *ab)
 				 &dp->reo_cmd_cache_flush_list, list) {
 		list_del(&cmd_cache->list);
 		dp->reo_cmd_cache_flush_count--;
-		dma_unmap_single(ab->dev, cmd_cache->data.paddr,
-				 cmd_cache->data.size, DMA_BIDIRECTIONAL);
-		kfree(cmd_cache->data.vaddr);
+		rx_tid = &cmd_cache->data;
+		if (rx_tid->vaddr) {
+			dma_unmap_single(ab->dev, rx_tid->paddr,
+					 rx_tid->size, DMA_BIDIRECTIONAL);
+			kfree(rx_tid->vaddr);
+			rx_tid->vaddr = NULL;
+		}
 		kfree(cmd_cache);
 	}
 	spin_unlock_bh(&dp->reo_cmd_lock);
@@ -698,10 +707,12 @@ static void ath11k_dp_reo_cmd_free(struct ath11k_dp *dp, void *ctx,
 	if (status != HAL_REO_CMD_SUCCESS)
 		ath11k_warn(dp->ab, "failed to flush rx tid hw desc, tid %d status %d\n",
 			    rx_tid->tid, status);
-
-	dma_unmap_single(dp->ab->dev, rx_tid->paddr, rx_tid->size,
-			 DMA_BIDIRECTIONAL);
-	kfree(rx_tid->vaddr);
+	if (rx_tid->vaddr) {
+		dma_unmap_single(dp->ab->dev, rx_tid->paddr, rx_tid->size,
+				 DMA_BIDIRECTIONAL);
+		kfree(rx_tid->vaddr);
+		rx_tid->vaddr = NULL;
+	}
 }
 
 static void ath11k_dp_reo_cache_flush(struct ath11k_base *ab,
@@ -740,6 +751,7 @@ static void ath11k_dp_reo_cache_flush(struct ath11k_base *ab,
 		dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
 				 DMA_BIDIRECTIONAL);
 		kfree(rx_tid->vaddr);
+		rx_tid->vaddr = NULL;
 	}
 }
 
@@ -792,6 +804,7 @@ static void ath11k_dp_rx_tid_del_func(struct ath11k_dp *dp, void *ctx,
 	dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
 			 DMA_BIDIRECTIONAL);
 	kfree(rx_tid->vaddr);
+	rx_tid->vaddr = NULL;
 }
 
 void ath11k_peer_rx_tid_delete(struct ath11k *ar,
@@ -804,6 +817,8 @@ void ath11k_peer_rx_tid_delete(struct ath11k *ar,
 	if (!rx_tid->active)
 		return;
 
+	rx_tid->active = false;
+
 	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
 	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
 	cmd.addr_hi = upper_32_bits(rx_tid->paddr);
@@ -818,9 +833,11 @@ void ath11k_peer_rx_tid_delete(struct ath11k *ar,
 		dma_unmap_single(ar->ab->dev, rx_tid->paddr, rx_tid->size,
 				 DMA_BIDIRECTIONAL);
 		kfree(rx_tid->vaddr);
+		rx_tid->vaddr = NULL;
 	}
 
-	rx_tid->active = false;
+	rx_tid->paddr = 0;
+	rx_tid->size = 0;
 }
 
 static int ath11k_dp_rx_link_desc_return(struct ath11k_base *ab,
@@ -967,6 +984,7 @@ static void ath11k_dp_rx_tid_mem_free(struct ath11k_base *ab,
 	dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
 			 DMA_BIDIRECTIONAL);
 	kfree(rx_tid->vaddr);
+	rx_tid->vaddr = NULL;
 
 	rx_tid->active = false;
 
@@ -1067,7 +1085,8 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 	return ret;
 
 err_mem_free:
-	kfree(vaddr);
+	kfree(rx_tid->vaddr);
+	rx_tid->vaddr = NULL;
 
 	return ret;
 }
-- 
2.17.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03F65ED68B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiI1Hmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiI1Hkt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 03:40:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED3C100A86
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 00:39:02 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S5vP9O000334;
        Wed, 28 Sep 2022 07:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Qw0ExAyOqgB2wXKbdS9tUqRigcHEgNtkuL1vmjUCCQM=;
 b=SIzoLE5nHiWKofRYk4F5+mtzYEjsl5NfgHHGfjQl/8QbXCqlMKWceBN8f5o9iLqGP/Bf
 DLujLQ6jWcAb2656+9fPESFYnXQPBS/W6GEuGd8o0d2cEYkDvvTMDnjHZrP4ap3TQ4Xc
 SadgL4phfMJJcq30UJIFNBSnpiR7/mpY48oy6cGnCoTsUpP/Tvg3llOs98BOKKIl7X0R
 pBYjYVhKcfXD1zYXOCNyk+KxMhyyPCWiKvzvOgwukxGWf/5b0Jq9mtLX0lcFfubcPW2R
 IhKIXKHcYg8WMNMlfv2bsHezRSYL7q2hzavHSAYn7w5wHpjWlffHgxGXYHqnsYCKsvfz 2g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juw2631u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 07:38:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28S7ckbo016141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 07:38:46 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 00:38:44 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix warning in dma_free_coherent() of memory chunks while recovery
Date:   Wed, 28 Sep 2022 03:38:32 -0400
Message-ID: <20220928073832.16251-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a99cZ2d0cscXzZ9XV19LhtZcz3dmfmaa
X-Proofpoint-ORIG-GUID: a99cZ2d0cscXzZ9XV19LhtZcz3dmfmaa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280045
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 26f3a021b37c ("ath11k: allocate smaller chunks of memory for
firmware") and commit f6f92968e1e5 ("ath11k: qmi: try to allocate a
big block of DMA memory first") change ath11k to allocate the memory
chunks for target twice while wlan load. It fails for the 1st time
because of large memory and then changed to allocate many small chunks
for the 2nd time sometimes as below log.

1st time failed:
[10411.640620] ath11k_pci 0000:05:00.0: qmi firmware request memory request
[10411.640625] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 6881280
[10411.640630] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 3784704
[10411.640658] ath11k_pci 0000:05:00.0: qmi dma allocation failed (6881280 B type 1), will try later with small size
[10411.640671] ath11k_pci 0000:05:00.0: qmi delays mem_request 2
[10411.640677] ath11k_pci 0000:05:00.0: qmi respond memory request delayed 1
2nd time success:
[10411.642004] ath11k_pci 0000:05:00.0: qmi firmware request memory request
[10411.642008] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
[10411.642012] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
[10411.642014] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
[10411.642016] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
[10411.642018] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
[10411.642020] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
[10411.642022] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
[10411.642024] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
[10411.642027] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
[10411.642029] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288
[10411.642031] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 458752
[10411.642033] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 131072
[10411.642035] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
[10411.642037] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
[10411.642039] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
[10411.642041] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
[10411.642043] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
[10411.642045] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 524288
[10411.642047] ath11k_pci 0000:05:00.0: qmi mem seg type 4 size 491520
[10411.642049] ath11k_pci 0000:05:00.0: qmi mem seg type 1 size 524288

And then commit 5962f370ce41 ("ath11k: Reuse the available memory after
firmware reload") skip the ath11k_qmi_free_resource() which frees the
memory chunks while recovery, after that, when run recovery test on
WCN6855, a warning happened every time as below and finally leads fail
for recovery.

[  159.570318] BUG: Bad page state in process kworker/u16:5  pfn:33300
[  159.570320] page:0000000096ffdbb9 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x33300
[  159.570324] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[  159.570329] raw: 000fffffc0000000 0000000000000000 dead000000000122 0000000000000000
[  159.570332] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[  159.570334] page dumped because: nonzero _refcount
[  159.570440]  firewire_ohci syscopyarea sysfillrect psmouse sdhci_pci ahci sysimgblt firewire_core fb_sys_fops libahci crc_itu_t cqhci drm sdhci e1000e wmi video
[  159.570460] CPU: 2 PID: 217 Comm: kworker/u16:5 Kdump: loaded Tainted: G    B             5.19.0-rc1-wt-ath+ #3
[  159.570465] Hardware name: LENOVO 418065C/418065C, BIOS 83ET63WW (1.33 ) 07/29/2011
[  159.570467] Workqueue: qmi_msg_handler qmi_data_ready_work [qmi_helpers]
[  159.570475] Call Trace:
[  159.570476]  <TASK>
[  159.570478]  dump_stack_lvl+0x49/0x5f
[  159.570486]  dump_stack+0x10/0x12
[  159.570493]  bad_page+0xab/0xf0
[  159.570502]  check_free_page_bad+0x66/0x70
[  159.570511]  __free_pages_ok+0x530/0x9a0
[  159.570517]  ? __dev_printk+0x58/0x6b
[  159.570525]  ? _dev_printk+0x56/0x72
[  159.570534]  ? qmi_decode+0x119/0x470 [qmi_helpers]
[  159.570543]  __free_pages+0x91/0xd0
[  159.570548]  dma_free_contiguous+0x50/0x60
[  159.570556]  dma_direct_free+0xe5/0x140
[  159.570564]  dma_free_attrs+0x35/0x50
[  159.570570]  ath11k_qmi_msg_mem_request_cb+0x2ae/0x3c0 [ath11k]
[  159.570620]  qmi_invoke_handler+0xac/0xe0 [qmi_helpers]
[  159.570630]  qmi_handle_message+0x6d/0x180 [qmi_helpers]
[  159.570643]  qmi_data_ready_work+0x2ca/0x440 [qmi_helpers]
[  159.570656]  process_one_work+0x227/0x440
[  159.570667]  worker_thread+0x31/0x3d0
[  159.570676]  ? process_one_work+0x440/0x440
[  159.570685]  kthread+0xfe/0x130
[  159.570692]  ? kthread_complete_and_exit+0x20/0x20
[  159.570701]  ret_from_fork+0x22/0x30
[  159.570712]  </TASK>

The reason is because when wlan start to recovery, the type, size and
count is not same for the 1st and 2nd QMI_WLFW_REQUEST_MEM_IND message,
Then it leads the parameter size is not correct for the dma_free_coherent().
For the chunk[1], the actual dma size is 524288 which allocate in the
2nd time of the initial wlan load phase, and the size which pass to
dma_free_coherent() is 3784704 which is got in the 1st time of recovery
phase, then warning above happened.

Change to use prev_size of struct target_mem_chunk for the paramter of
dma_free_coherent() since prev_size is the real size of last load/recovery.
Also change to check both type and size of struct target_mem_chunk to
reuse the memory to avoid mismatch buffer size for target. Then the
warning disappear and recovery success. When the 1st QMI_WLFW_REQUEST_MEM_IND
for recovery arrived, the trunk[0] is freed in ath11k_qmi_alloc_target_mem_chunk()
and then dma_alloc_coherent() failed caused by large size, and then
trunk[1] is freed in ath11k_qmi_free_target_mem_chunk(), the left 18
trunks will be reuse for the 2nd QMI_WLFW_REQUEST_MEM_IND message.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Fixes: 5962f370ce41 ("ath11k: Reuse the available memory after firmware reload")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 51de2208b789..1a2c05419379 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1961,7 +1961,7 @@ static void ath11k_qmi_free_target_mem_chunk(struct ath11k_base *ab)
 			continue;
 
 		dma_free_coherent(ab->dev,
-				  ab->qmi.target_mem[i].size,
+				  ab->qmi.target_mem[i].prev_size,
 				  ab->qmi.target_mem[i].vaddr,
 				  ab->qmi.target_mem[i].paddr);
 		ab->qmi.target_mem[i].vaddr = NULL;
@@ -1982,12 +1982,12 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 		 * in such case, no need to allocate memory for FW again.
 		 */
 		if (chunk->vaddr) {
-			if (chunk->prev_type == chunk->type ||
+			if (chunk->prev_type == chunk->type &&
 			    chunk->prev_size == chunk->size)
 				continue;
 
 			/* cannot reuse the existing chunk */
-			dma_free_coherent(ab->dev, chunk->size,
+			dma_free_coherent(ab->dev, chunk->prev_size,
 					  chunk->vaddr, chunk->paddr);
 			chunk->vaddr = NULL;
 		}

base-commit: c6d18be90f9b0c7fb64c6138b51c49151140fb57
-- 
2.31.1


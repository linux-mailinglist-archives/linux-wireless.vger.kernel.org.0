Return-Path: <linux-wireless+bounces-6553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822908AA74D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 05:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0CE281158
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 03:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2B5664;
	Fri, 19 Apr 2024 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="chLpQ3lF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799A1FB4
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498063; cv=none; b=ktKE7SoRR9jxU/7t7HLNuXhSmGv3DNqo8Dia9pDD91MzV7PY7uJDf2mf7mmTf2EUyrEggajnOlOZvAi+Yi8/DqjrsV9+kgAQhTxRXCGyJ1iYMlm5/TLrSbZ15rWlRGzuMJud+O+Yf6WiGc1/n5c4pSMmxkwTDKeevQrevU1JKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498063; c=relaxed/simple;
	bh=FHSaMiEobrnWbGd26zaItzG8EDqF3P5jDLw3tUmn27Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3QaQwrykbP5GoiTsKnm6gFwRXxCEkyuxzJRQ3so+irJvzFqyXCEdqT480J88ZoaljGPDkNANvZfBMuZtav73MDMDGSBfNLkzUAl3/dLx8U2HQ5zFzBt0FFuZxJ2ajjRbToyZRbgUYVkVbeoj8aZf2PsCKDGvBKs61P0IbcISBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=chLpQ3lF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43J301eX003855;
	Fri, 19 Apr 2024 03:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=kk9/uT8
	K26AAxoU+YzxyRy/6n3pp9NuV6fNXqAz461A=; b=chLpQ3lFpXNiPOouSyINDE7
	/zfyb4KSeav76L0ZWc8JCPt0P2qOXqHPbqotMNJ9gP2Od0fxdZfoQ1pzaPzZ+dDT
	01HoZSs9x1HLfFJ99CaEWKP4SSoGH6PVFIPvl5wjpeiMD2C9KRuP74wzNIVLw+pH
	PQHImSo4iHR0vG3CcKZ8dITTyZeWXmKfHFCg/Ym0VIO1EmlVJXlKXguCLaxtg7tV
	n9gjgyDY6ZCLnNFrl/plj+YXu9VZlenpWQaSW+u3sDDOkyR4b8mzThkZ6hJgExYG
	sDfxn1Nk9nqUsHAoa90vkJ448c55ibuEHnPpBz0/Lk2sPKe7zW1qF06JmgQrCcw=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjuphtwr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 03:40:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43J3etD4032423
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 03:40:55 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 20:40:53 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix kernel crash during resume
Date: Fri, 19 Apr 2024 11:40:34 +0800
Message-ID: <20240419034034.2842-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YGfYlpwWZRpC40oslrbNFmTIA-490r67
X-Proofpoint-ORIG-GUID: YGfYlpwWZRpC40oslrbNFmTIA-490r67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_22,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190025

Currently during resume, QMI target memory is not properly handled, resulting
in kernel crash in case DMA remap is not supported:

BUG: Bad page state in process kworker/u16:54  pfn:36e80
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36e80
page dumped because: nonzero _refcount
Call Trace:
 bad_page
 free_page_is_bad_report
 __free_pages_ok
 __free_pages
 dma_direct_free
 dma_free_attrs
 ath12k_qmi_free_target_mem_chunk
 ath12k_qmi_msg_mem_request_cb

The reason is:
Once ath12k module is loaded, firmware sends memory request to host. In case
DMA remap not supported, ath12k refuses the first request due to failure in
allocating with large segment size:

ath12k_pci 0000:04:00.0: qmi firmware request memory request
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 7077888
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 8454144
ath12k_pci 0000:04:00.0: qmi dma allocation failed (7077888 B type 1), will try later with small size
ath12k_pci 0000:04:00.0: qmi delays mem_request 2
ath12k_pci 0000:04:00.0: qmi firmware request memory request

Later firmware comes back with more but small segments and allocation
succeeds:

ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 262144
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 65536
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288

Now ath12k is working. If suspend is triggered, firmware will be reloaded
during resume. As same as before, firmware requests two large segments at
first. In ath12k_qmi_msg_mem_request_cb() segment count and size are
assigned:

	ab->qmi.mem_seg_count == 2
	ab->qmi.target_mem[0].size == 7077888
	ab->qmi.target_mem[1].size == 8454144

Then allocation failed like before and ath12k_qmi_free_target_mem_chunk()
is called to free all allocated segments. Note the first segment is skipped
because its v.addr is cleared due to allocation failure:

	chunk->v.addr = dma_alloc_coherent()

Also note that this leaks that segment because it has not been freed.

While freeing the second segment, a size of 8454144 is passed to
dma_free_coherent(). However remember that this segment is allocated at
the first time firmware is loaded, before suspend. So its real size is
524288, much smaller than 8454144. As a result kernel found we are freeing
some memory which is in use and thus crashed.

So one possible fix would be to free those segments during suspend. This
works because with them freed, ath12k_qmi_free_target_mem_chunk() does
nothing: all segment addresses are NULL so dma_free_coherent() is not called.

But note that ath11k has similar logic but never hits this issue. Reviewing
code there shows the luck comes from QMI memory reuse logic. So the decision
is to port it to ath12k. Like in ath11k, the crash is avoided by adding
prev_size to target_mem_chunk structure and caching real segment size in it,
then prev_size instead of current size is passed to dma_free_coherent(),
no unexpected memory is freed now.

Also reuse m3 buffer.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 64430ddfb132 ("wifi: ath12k: support suspend/resume")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  1 -
 drivers/net/wireless/ath/ath12k/qmi.c  | 29 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/qmi.h  |  2 ++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index aefe667c3dcb..420e5fb002ad 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1158,7 +1158,6 @@ static void ath12k_core_reset(struct work_struct *work)
 	ath12k_hif_ce_irq_disable(ab);
 
 	ath12k_hif_power_down(ab, false);
-	ath12k_qmi_free_resource(ab);
 	ath12k_hif_power_up(ab);
 
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset started\n");
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 2f3c6f2e342a..ebb20fc8e3ba 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2357,8 +2357,9 @@ static void ath12k_qmi_free_target_mem_chunk(struct ath12k_base *ab)
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
 		if (!ab->qmi.target_mem[i].v.addr)
 			continue;
+
 		dma_free_coherent(ab->dev,
-				  ab->qmi.target_mem[i].size,
+				  ab->qmi.target_mem[i].prev_size,
 				  ab->qmi.target_mem[i].v.addr,
 				  ab->qmi.target_mem[i].paddr);
 		ab->qmi.target_mem[i].v.addr = NULL;
@@ -2384,6 +2385,20 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 		case M3_DUMP_REGION_TYPE:
 		case PAGEABLE_MEM_REGION_TYPE:
 		case CALDB_MEM_REGION_TYPE:
+			/* Firmware reloads in recovery/resume.
+			 * In such cases, no need to allocate memory for FW again.
+			 */
+			if (chunk->v.addr) {
+				if (chunk->prev_type == chunk->type &&
+				    chunk->prev_size == chunk->size)
+					goto this_chunk_done;
+
+				/* cannot reuse the existing chunk */
+				dma_free_coherent(ab->dev, chunk->prev_size,
+						  chunk->v.addr, chunk->paddr);
+				chunk->v.addr = NULL;
+			}
+
 			chunk->v.addr = dma_alloc_coherent(ab->dev,
 							   chunk->size,
 							   &chunk->paddr,
@@ -2402,6 +2417,10 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 					    chunk->type, chunk->size);
 				return -ENOMEM;
 			}
+
+			chunk->prev_type = chunk->type;
+			chunk->prev_size = chunk->size;
+this_chunk_done:
 			break;
 		default:
 			ath12k_warn(ab, "memory type %u not supported\n",
@@ -2707,10 +2726,6 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 	size_t m3_len;
 	int ret;
 
-	if (m3_mem->vaddr)
-		/* m3 firmware buffer is already available in the DMA buffer */
-		return 0;
-
 	if (ab->fw.m3_data && ab->fw.m3_len > 0) {
 		/* firmware-N.bin had a m3 firmware file so use that */
 		m3_data = ab->fw.m3_data;
@@ -2732,6 +2747,9 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 		m3_len = fw->size;
 	}
 
+	if (m3_mem->vaddr)
+		goto skip_m3_alloc;
+
 	m3_mem->vaddr = dma_alloc_coherent(ab->dev,
 					   m3_len, &m3_mem->paddr,
 					   GFP_KERNEL);
@@ -2742,6 +2760,7 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 		goto out;
 	}
 
+skip_m3_alloc:
 	memcpy(m3_mem->vaddr, m3_data, m3_len);
 	m3_mem->size = m3_len;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index f7a5eb11ce44..0dfcbd8cb59b 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -96,6 +96,8 @@ struct ath12k_qmi_event_msg {
 struct target_mem_chunk {
 	u32 size;
 	u32 type;
+	u32 prev_size;
+	u32 prev_type;
 	dma_addr_t paddr;
 	union {
 		void __iomem *ioaddr;

base-commit: f5f3a3166c64d469150958a470f4a3ab99d45268
-- 
2.25.1



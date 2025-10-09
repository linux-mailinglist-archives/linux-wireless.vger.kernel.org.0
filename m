Return-Path: <linux-wireless+bounces-27911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1563EBC8B6B
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D90E64EFBA6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB6A2C15A0;
	Thu,  9 Oct 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aYuGlOyh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B32E1F1F
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008284; cv=none; b=En0AOfQzinb4gpTMyepaejvf24ySo/YIOlIOFgRaULtbsVm+EUh4M8yPbVhb2c5pXUaKPhiZs4jeSsisLnLlZZwR3Yr7EN0dz3YLUA9nFCdmiZYZn2i2NikfVJc8HdFpVJ305ULZeue5GuVDPkVURbcycPsVRsWDt/87Q4r8rZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008284; c=relaxed/simple;
	bh=7WbvibDdq13VZOrc06xlNaeXPc3C9fHDIGm/knXTBvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seqPdd/+bwH13HY0pt350/6P4Zm/AC/Itu4ceEFA/AVMXXNFaLjMwhYWmwnGLNOK+TySrNHNv0wtx4L40h9LrYXORr5zk7G436qtD685iS1pEuLUFaBUSp2HjXiubYV6k8fzo+wXJ/9wa4e63hbBm4gw1gRM/Ca6oZXs4BuLxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aYuGlOyh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EQEX012475;
	Thu, 9 Oct 2025 11:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/ynSbU+GA7HyICVbxPD4yzsU7JV7bss7QlFgofimmaQ=; b=aYuGlOyhiGaTUDFe
	9LzYzGPFlOcArF/NIayF/pJkAXx374cUw1+qjo7pTipTD+hGZrp2S/u9h4lQcWl3
	7XchjSXIEY6dNolRRkIOQJ/gOtK58TKrq7mEexEmLcGWpUaY/giY8nwk98hbLzlF
	kbGQRprpbyE0zdhXKmTCMhNYwkahYsRHe+OZcg4LDdnuO/L37UPuV+fkwpXx/Gtt
	XX3gxawv33NduE5MSWkTjajYRu6XQbGDNEXoKyZFkQ1Pc7xmjwGhwD2lJW88htOb
	XgO0KmTiQDCX7TX7KB19dqsyK1W3fkLP8zqw+Dw4OuuqHDF6Eaq4znUcfFwnmhhv
	AMYUlg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kjhsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBJYs011256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:19 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:18 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 12/18] wifi: ath12k: Move HAL Tx, REO and link idle setup related APIs to wifi7 directory
Date: Thu, 9 Oct 2025 16:40:39 +0530
Message-ID: <20251009111045.1763001-13-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e79858 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=6Jm8zowDP5bg4j9pKYEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hiio-4mOoOHVyKViNVaW9RZHhg14pr4W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX3vihHDf2svIi
 wwV6sGzR6qTN79J515fgwkKSmS1sakW97y4nLySM/2B8FEgCyt3upFbVcd1/J7jkwOQwMqSpVds
 8y4iOlV6iGychWIpBNHgR1fuZpGhygujPMwhpAUYgZpCpFlHa1F0rXeJCM6NQAiydS5BlFWa3+V
 nDi4o6AlG8ZmscHIoXABa6La27LFHnZ042VSu0dWwqblNx+EFPEuY0krLZ0q+9bEEKcb/+jRpHU
 o7x2sMgMb5pA7/0JjHA4AbwonWbvzS73PPGOlbYL35KZYQWyLuLVksJoaFrW8v7XqwBgIDf1O0n
 pI5R/H6izTC1mj2xuw8LMvo9xMWTkZrDtHEJRP5m5w7507+YGOLozQ5MRh6q86Zh47M0NQc3QSl
 jRPAysk+Vrrf7djhUZW82oR3cP6XvA==
X-Proofpoint-ORIG-GUID: hiio-4mOoOHVyKViNVaW9RZHhg14pr4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move the hardware specific HAL APIs to hal.c file
inside wifi7 directory. These APIs will be called
through the hal_ops mechanism, which are registered
separately by qcn and wcn

Handling following APIs:
ath12k_wifi7_hal_tx_set_dscp_tid_map
ath12k_wifi7_hal_tx_configure_bank_register
ath12k_hal_reoq_lut_addr_read_enable
ath12k_hal_reoq_lut_set_max_peerid
ath12k_wifi7_hal_write_reoq_lut_addr
ath12k_wifi7_hal_write_ml_reoq_lut_addr
ath12k_wifi7_hal_setup_link_idle_list

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c          |  33 ++--
 drivers/net/wireless/ath/ath12k/hal.c         | 148 +++++------------
 drivers/net/wireless/ath/ath12k/hal.h         |  30 +++-
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   | 150 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h   |  11 ++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |   9 ++
 .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   8 -
 .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |   5 +-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |   9 ++
 9 files changed, 255 insertions(+), 148 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 495e03498187..b2c04fc460d9 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -425,8 +425,8 @@ static int ath12k_dp_tx_get_bank_profile(struct ath12k_base *ab,
 	spin_unlock_bh(&dp->tx_bank_lock);
 
 	if (configure_register)
-		ath12k_wifi7_hal_tx_configure_bank_register(ab, bank_config,
-							    bank_id);
+		ath12k_hal_tx_configure_bank_register(ab,
+						      bank_config, bank_id);
 
 	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "dp_htt tcl bank_id %d input 0x%x match 0x%x num_users %u",
 		   bank_id, bank_config, dp->bank_profiles[bank_id].bank_config,
@@ -1149,9 +1149,7 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 		return;
 
 	if (dp->reoq_lut.vaddr_unaligned) {
-		ath12k_hif_write32(ab,
-				   HAL_SEQ_WCSS_UMAC_REO_REG +
-				   HAL_REO1_QDESC_LUT_BASE0(dp->hal), 0);
+		ath12k_hal_write_reoq_lut_addr(ab, 0);
 		dma_free_coherent(ab->dev, dp->reoq_lut.size,
 				  dp->reoq_lut.vaddr_unaligned,
 				  dp->reoq_lut.paddr_unaligned);
@@ -1159,9 +1157,7 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 	}
 
 	if (dp->ml_reoq_lut.vaddr_unaligned) {
-		ath12k_hif_write32(ab,
-				   HAL_SEQ_WCSS_UMAC_REO_REG +
-				   HAL_REO1_QDESC_LUT_BASE1(dp->hal), 0);
+		ath12k_hal_write_ml_reoq_lut_addr(ab, 0);
 		dma_free_coherent(ab->dev, dp->ml_reoq_lut.size,
 				  dp->ml_reoq_lut.vaddr_unaligned,
 				  dp->ml_reoq_lut.paddr_unaligned);
@@ -1539,8 +1535,6 @@ static int ath12k_dp_alloc_reoq_lut(struct ath12k_base *ab,
 static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
-	struct ath12k_hal *hal = dp->hal;
-	u32 val;
 	int ret;
 
 	if (!ab->hw_params->reoq_lut_support)
@@ -1568,19 +1562,10 @@ static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 	 * register only
 	 */
 
-	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE0(hal),
-			   dp->reoq_lut.paddr >> 8);
-
-	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE1(hal),
-			   dp->ml_reoq_lut.paddr >> 8);
-
-	val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(hal));
-
-	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(hal),
-			   val | HAL_REO_QDESC_ADDR_READ_LUT_ENABLE);
-
-	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_MAX_PEERID(hal),
-			   HAL_REO_QDESC_MAX_PEERID);
+	ath12k_hal_write_reoq_lut_addr(ab, dp->reoq_lut.paddr >> 8);
+	ath12k_hal_write_ml_reoq_lut_addr(ab, dp->ml_reoq_lut.paddr >> 8);
+	ath12k_hal_reoq_lut_addr_read_enable(ab);
+	ath12k_hal_reoq_lut_set_max_peerid(ab);
 
 	return 0;
 }
@@ -1678,7 +1663,7 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
 	}
 
 	for (i = 0; i < HAL_DSCP_TID_MAP_TBL_NUM_ENTRIES_MAX; i++)
-		ath12k_wifi7_hal_tx_set_dscp_tid_map(ab, i);
+		ath12k_hal_tx_set_dscp_tid_map(ab, i);
 
 	ret = ath12k_dp_rx_alloc(ab);
 	if (ret)
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 5c13eaf9c19e..b3010eea9afc 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -56,6 +56,46 @@ u32 ath12k_hal_ce_get_desc_size(struct ath12k_hal *hal, enum hal_ce_desc type)
 	return hal->hal_ops->ce_get_desc_size(type);
 }
 
+void ath12k_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id)
+{
+	ab->hal.hal_ops->tx_set_dscp_tid_map(ab, id);
+}
+
+void ath12k_hal_tx_configure_bank_register(struct ath12k_base *ab,
+					   u32 bank_config, u8 bank_id)
+{
+	ab->hal.hal_ops->tx_configure_bank_register(ab, bank_config, bank_id);
+}
+
+void ath12k_hal_reoq_lut_addr_read_enable(struct ath12k_base *ab)
+{
+	ab->hal.hal_ops->reoq_lut_addr_read_enable(ab);
+}
+
+void ath12k_hal_reoq_lut_set_max_peerid(struct ath12k_base *ab)
+{
+	ab->hal.hal_ops->reoq_lut_set_max_peerid(ab);
+}
+
+void ath12k_hal_write_ml_reoq_lut_addr(struct ath12k_base *ab, dma_addr_t paddr)
+{
+	ab->hal.hal_ops->write_ml_reoq_lut_addr(ab, paddr);
+}
+
+void ath12k_hal_write_reoq_lut_addr(struct ath12k_base *ab, dma_addr_t paddr)
+{
+	ab->hal.hal_ops->write_reoq_lut_addr(ab, paddr);
+}
+
+void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
+				     struct hal_wbm_idle_scatter_list *sbuf,
+				     u32 nsbufs, u32 tot_link_desc,
+				     u32 end_offset)
+{
+	ab->hal.hal_ops->setup_link_idle_list(ab, sbuf, nsbufs, tot_link_desc,
+					      end_offset);
+}
+
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_hal *hal)
 {
 	size_t size;
@@ -467,114 +507,6 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 	srng->timestamp = jiffies;
 }
 
-void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
-				     struct hal_wbm_idle_scatter_list *sbuf,
-				     u32 nsbufs, u32 tot_link_desc,
-				     u32 end_offset)
-{
-	struct ath12k_hal *hal = &ab->hal;
-	struct ath12k_buffer_addr *link_addr;
-	int i;
-	u32 reg_scatter_buf_sz = HAL_WBM_IDLE_SCATTER_BUF_SIZE / 64;
-	u32 val;
-
-	link_addr = (void *)sbuf[0].vaddr + HAL_WBM_IDLE_SCATTER_BUF_SIZE;
-
-	for (i = 1; i < nsbufs; i++) {
-		link_addr->info0 = cpu_to_le32(sbuf[i].paddr & HAL_ADDR_LSB_REG_MASK);
-
-		link_addr->info1 =
-			le32_encode_bits((u64)sbuf[i].paddr >> HAL_ADDR_MSB_REG_SHIFT,
-					 HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32) |
-			le32_encode_bits(BASE_ADDR_MATCH_TAG_VAL,
-					 HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_MATCH_TAG);
-
-		link_addr = (void *)sbuf[i].vaddr +
-			     HAL_WBM_IDLE_SCATTER_BUF_SIZE;
-	}
-
-	val = u32_encode_bits(reg_scatter_buf_sz, HAL_WBM_SCATTER_BUFFER_SIZE) |
-	      u32_encode_bits(0x1, HAL_WBM_LINK_DESC_IDLE_LIST_MODE);
-
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR(hal),
-			   val);
-
-	val = u32_encode_bits(reg_scatter_buf_sz * nsbufs,
-			      HAL_WBM_SCATTER_RING_SIZE_OF_IDLE_LINK_DESC_LIST);
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_R0_IDLE_LIST_SIZE_ADDR(hal),
-			   val);
-
-	val = u32_encode_bits(sbuf[0].paddr & HAL_ADDR_LSB_REG_MASK,
-			      BUFFER_ADDR_INFO0_ADDR);
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_RING_BASE_LSB(hal),
-			   val);
-
-	val = u32_encode_bits(BASE_ADDR_MATCH_TAG_VAL,
-			      HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_MATCH_TAG) |
-	      u32_encode_bits((u64)sbuf[0].paddr >> HAL_ADDR_MSB_REG_SHIFT,
-			      HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32);
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_RING_BASE_MSB(hal),
-			   val);
-
-	/* Setup head and tail pointers for the idle list */
-	val = u32_encode_bits(sbuf[nsbufs - 1].paddr, BUFFER_ADDR_INFO0_ADDR);
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(hal),
-			   val);
-
-	val = u32_encode_bits(((u64)sbuf[nsbufs - 1].paddr >> HAL_ADDR_MSB_REG_SHIFT),
-			      HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32) |
-	       u32_encode_bits((end_offset >> 2),
-			       HAL_WBM_SCATTERED_DESC_HEAD_P_OFFSET_IX1);
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1(hal),
-			   val);
-
-	val = u32_encode_bits(sbuf[0].paddr, BUFFER_ADDR_INFO0_ADDR);
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(hal),
-			   val);
-
-	val = u32_encode_bits(sbuf[0].paddr, BUFFER_ADDR_INFO0_ADDR);
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0(hal),
-			   val);
-
-	val = u32_encode_bits(((u64)sbuf[0].paddr >> HAL_ADDR_MSB_REG_SHIFT),
-			      HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32) |
-	      u32_encode_bits(0, HAL_WBM_SCATTERED_DESC_TAIL_P_OFFSET_IX1);
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1(hal),
-			   val);
-
-	val = 2 * tot_link_desc;
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR(hal),
-			   val);
-
-	/* Enable the SRNG */
-	val = u32_encode_bits(1, HAL_WBM_IDLE_LINK_RING_MISC_SRNG_ENABLE) |
-	      u32_encode_bits(1, HAL_WBM_IDLE_LINK_RING_MISC_RIND_ID_DISABLE);
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_IDLE_LINK_RING_MISC_ADDR(hal),
-			   val);
-}
-
 int ath12k_hal_srng_setup(struct ath12k_base *ab, enum hal_ring_type type,
 			  int ring_num, int mac_id,
 			  struct hal_srng_params *params)
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index b739ebba588b..0c8262675120 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1717,6 +1717,18 @@ struct hal_ops {
 	void (*set_link_desc_addr)(struct hal_wbm_link_desc *desc, u32 cookie,
 				   dma_addr_t paddr,
 				   enum hal_rx_buf_return_buf_manager rbm);
+	void (*tx_set_dscp_tid_map)(struct ath12k_base *ab, int id);
+	void (*tx_configure_bank_register)(struct ath12k_base *ab,
+					   u32 bank_config, u8 bank_id);
+	void (*reoq_lut_addr_read_enable)(struct ath12k_base *ab);
+	void (*reoq_lut_set_max_peerid)(struct ath12k_base *ab);
+	void (*write_ml_reoq_lut_addr)(struct ath12k_base *ab,
+				       dma_addr_t paddr);
+	void (*write_reoq_lut_addr)(struct ath12k_base *ab, dma_addr_t paddr);
+	void (*setup_link_idle_list)(struct ath12k_base *ab,
+				     struct hal_wbm_idle_scatter_list *sbuf,
+				     u32 nsbufs, u32 tot_link_desc,
+				     u32 end_offset);
 };
 
 u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
@@ -1726,12 +1738,6 @@ void ath12k_wifi7_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
 void ath12k_wifi7_hal_reo_init_cmd_ring(struct ath12k_base *ab,
 					struct hal_srng *srng);
 void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map);
-
-void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
-				     struct hal_wbm_idle_scatter_list *sbuf,
-				     u32 nsbufs, u32 tot_link_desc,
-				     u32 end_offset);
-
 dma_addr_t ath12k_hal_srng_get_tp_addr(struct ath12k_base *ab,
 				       struct hal_srng *srng);
 dma_addr_t ath12k_hal_srng_get_hp_addr(struct ath12k_base *ab,
@@ -1785,7 +1791,19 @@ void ath12k_hal_reo_shared_qaddr_cache_clear(struct ath12k_base *ab);
 void ath12k_hal_set_link_desc_addr(struct ath12k_hal *hal,
 				   struct hal_wbm_link_desc *desc, u32 cookie,
 				   dma_addr_t paddr, int rbm);
+void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
+				     struct hal_wbm_idle_scatter_list *sbuf,
+				     u32 nsbufs, u32 tot_link_desc,
+				     u32 end_offset);
 u32
 ath12k_hal_ce_dst_status_get_length(struct ath12k_hal *hal,
 				    struct hal_ce_srng_dst_status_desc *desc);
+void ath12k_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id);
+void ath12k_hal_tx_configure_bank_register(struct ath12k_base *ab,
+					   u32 bank_config, u8 bank_id);
+void ath12k_hal_reoq_lut_addr_read_enable(struct ath12k_base *ab);
+void ath12k_hal_reoq_lut_set_max_peerid(struct ath12k_base *ab);
+void ath12k_hal_write_reoq_lut_addr(struct ath12k_base *ab, dma_addr_t paddr);
+void
+ath12k_hal_write_ml_reoq_lut_addr(struct ath12k_base *ab, dma_addr_t paddr);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index c9e853a32378..73d86dedadb1 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -7,6 +7,7 @@
 #include "hal_desc.h"
 #include "../hal.h"
 #include "hal.h"
+#include "hal_tx.h"
 #include "../debug.h"
 #include "../hif.h"
 #include "hal_qcn9274.h"
@@ -480,3 +481,152 @@ u32 ath12k_wifi7_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc
 
 	return len;
 }
+
+void
+ath12k_wifi7_hal_setup_link_idle_list(struct ath12k_base *ab,
+				      struct hal_wbm_idle_scatter_list *sbuf,
+				      u32 nsbufs, u32 tot_link_desc,
+				      u32 end_offset)
+{
+	struct ath12k_hal *hal = &ab->hal;
+	struct ath12k_buffer_addr *link_addr;
+	int i;
+	u32 reg_scatter_buf_sz = HAL_WBM_IDLE_SCATTER_BUF_SIZE / 64;
+	u32 val;
+
+	link_addr = (void *)sbuf[0].vaddr + HAL_WBM_IDLE_SCATTER_BUF_SIZE;
+
+	for (i = 1; i < nsbufs; i++) {
+		link_addr->info0 = cpu_to_le32(sbuf[i].paddr & HAL_ADDR_LSB_REG_MASK);
+
+		link_addr->info1 =
+			le32_encode_bits((u64)sbuf[i].paddr >> HAL_ADDR_MSB_REG_SHIFT,
+					 HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32) |
+			le32_encode_bits(BASE_ADDR_MATCH_TAG_VAL,
+					 HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_MATCH_TAG);
+
+		link_addr = (void *)sbuf[i].vaddr +
+			     HAL_WBM_IDLE_SCATTER_BUF_SIZE;
+	}
+
+	val = u32_encode_bits(reg_scatter_buf_sz, HAL_WBM_SCATTER_BUFFER_SIZE) |
+	      u32_encode_bits(0x1, HAL_WBM_LINK_DESC_IDLE_LIST_MODE);
+
+	ath12k_hif_write32(ab,
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR(hal),
+			   val);
+
+	val = u32_encode_bits(reg_scatter_buf_sz * nsbufs,
+			      HAL_WBM_SCATTER_RING_SIZE_OF_IDLE_LINK_DESC_LIST);
+	ath12k_hif_write32(ab,
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_R0_IDLE_LIST_SIZE_ADDR(hal),
+			   val);
+
+	val = u32_encode_bits(sbuf[0].paddr & HAL_ADDR_LSB_REG_MASK,
+			      BUFFER_ADDR_INFO0_ADDR);
+	ath12k_hif_write32(ab,
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_SCATTERED_RING_BASE_LSB(hal),
+			   val);
+
+	val = u32_encode_bits(BASE_ADDR_MATCH_TAG_VAL,
+			      HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_MATCH_TAG) |
+	      u32_encode_bits((u64)sbuf[0].paddr >> HAL_ADDR_MSB_REG_SHIFT,
+			      HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32);
+	ath12k_hif_write32(ab,
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_SCATTERED_RING_BASE_MSB(hal),
+			   val);
+
+	/* Setup head and tail pointers for the idle list */
+	val = u32_encode_bits(sbuf[nsbufs - 1].paddr, BUFFER_ADDR_INFO0_ADDR);
+	ath12k_hif_write32(ab,
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(hal),
+			   val);
+
+	val = u32_encode_bits(((u64)sbuf[nsbufs - 1].paddr >> HAL_ADDR_MSB_REG_SHIFT),
+			      HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32) |
+	       u32_encode_bits((end_offset >> 2),
+			       HAL_WBM_SCATTERED_DESC_HEAD_P_OFFSET_IX1);
+	ath12k_hif_write32(ab,
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1(hal),
+			   val);
+
+	val = u32_encode_bits(sbuf[0].paddr, BUFFER_ADDR_INFO0_ADDR);
+	ath12k_hif_write32(ab,
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(hal),
+			   val);
+
+	val = u32_encode_bits(sbuf[0].paddr, BUFFER_ADDR_INFO0_ADDR);
+	ath12k_hif_write32(ab,
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0(hal),
+			   val);
+
+	val = u32_encode_bits(((u64)sbuf[0].paddr >> HAL_ADDR_MSB_REG_SHIFT),
+			      HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32) |
+	      u32_encode_bits(0, HAL_WBM_SCATTERED_DESC_TAIL_P_OFFSET_IX1);
+	ath12k_hif_write32(ab,
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1(hal),
+			   val);
+
+	val = 2 * tot_link_desc;
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR(hal),
+			   val);
+
+	/* Enable the SRNG */
+	val = u32_encode_bits(1, HAL_WBM_IDLE_LINK_RING_MISC_SRNG_ENABLE) |
+	      u32_encode_bits(1, HAL_WBM_IDLE_LINK_RING_MISC_RIND_ID_DISABLE);
+	ath12k_hif_write32(ab,
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_IDLE_LINK_RING_MISC_ADDR(hal),
+			   val);
+}
+
+void ath12k_wifi7_hal_tx_configure_bank_register(struct ath12k_base *ab,
+						 u32 bank_config,
+						 u8 bank_id)
+{
+	ath12k_hif_write32(ab, HAL_TCL_SW_CONFIG_BANK_ADDR + 4 * bank_id,
+			   bank_config);
+}
+
+void ath12k_wifi7_hal_reoq_lut_addr_read_enable(struct ath12k_base *ab)
+{
+	struct ath12k_hal *hal = &ab->hal;
+
+	u32 val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
+				    HAL_REO1_QDESC_ADDR(hal));
+
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(hal),
+			   val | HAL_REO_QDESC_ADDR_READ_LUT_ENABLE);
+}
+
+void ath12k_wifi7_hal_reoq_lut_set_max_peerid(struct ath12k_base *ab)
+{
+	struct ath12k_hal *hal = &ab->hal;
+
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_MAX_PEERID(hal),
+			   HAL_REO_QDESC_MAX_PEERID);
+}
+
+void ath12k_wifi7_hal_write_reoq_lut_addr(struct ath12k_base *ab,
+					  dma_addr_t paddr)
+{
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
+			   HAL_REO1_QDESC_LUT_BASE0(&ab->hal), paddr);
+}
+
+void ath12k_wifi7_hal_write_ml_reoq_lut_addr(struct ath12k_base *ab,
+					     dma_addr_t paddr)
+{
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
+			   HAL_REO1_QDESC_LUT_BASE1(&ab->hal), paddr);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
index 308f80427676..6e67f06ffa43 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -34,4 +34,15 @@ ath12k_wifi7_hal_set_link_desc_addr(struct hal_wbm_link_desc *desc,
 				    enum hal_rx_buf_return_buf_manager rbm);
 u32
 ath12k_wifi7_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc);
+void
+ath12k_wifi7_hal_setup_link_idle_list(struct ath12k_base *ab,
+				      struct hal_wbm_idle_scatter_list *sbuf,
+				      u32 nsbufs, u32 tot_link_desc,
+				      u32 end_offset);
+void ath12k_wifi7_hal_reoq_lut_addr_read_enable(struct ath12k_base *ab);
+void ath12k_wifi7_hal_reoq_lut_set_max_peerid(struct ath12k_base *ab);
+void ath12k_wifi7_hal_write_reoq_lut_addr(struct ath12k_base *ab,
+					  dma_addr_t paddr);
+void ath12k_wifi7_hal_write_ml_reoq_lut_addr(struct ath12k_base *ab,
+					     dma_addr_t paddr);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index b764d5cd8aeb..9cbae6d11dd8 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -7,6 +7,7 @@
 #include "hal_qcn9274.h"
 #include "hw.h"
 #include "hal.h"
+#include "hal_tx.h"
 
 static const struct hal_srng_config hw_srng_config_template[] = {
 	/* TODO: max_rings can populated by querying HW capabilities */
@@ -1011,5 +1012,13 @@ const struct hal_ops hal_qcn9274_ops = {
 	.ce_dst_set_desc = ath12k_wifi7_hal_ce_dst_set_desc,
 	.ce_dst_status_get_length = ath12k_wifi7_hal_ce_dst_status_get_length,
 	.set_link_desc_addr = ath12k_wifi7_hal_set_link_desc_addr,
+	.tx_set_dscp_tid_map = ath12k_wifi7_hal_tx_set_dscp_tid_map,
+	.tx_configure_bank_register =
+				ath12k_wifi7_hal_tx_configure_bank_register,
+	.reoq_lut_addr_read_enable = ath12k_wifi7_hal_reoq_lut_addr_read_enable,
+	.reoq_lut_set_max_peerid = ath12k_wifi7_hal_reoq_lut_set_max_peerid,
+	.write_reoq_lut_addr = ath12k_wifi7_hal_write_reoq_lut_addr,
+	.write_ml_reoq_lut_addr = ath12k_wifi7_hal_write_ml_reoq_lut_addr,
+	.setup_link_idle_list = ath12k_wifi7_hal_setup_link_idle_list,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
index 027e02141ec2..24f905c5b062 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
@@ -136,11 +136,3 @@ void ath12k_wifi7_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id)
 			   HAL_TCL1_RING_CMN_CTRL_REG,
 			   ctrl_reg_val);
 }
-
-void ath12k_wifi7_hal_tx_configure_bank_register(struct ath12k_base *ab,
-						 u32 bank_config,
-						 u8 bank_id)
-{
-	ath12k_hif_write32(ab, HAL_TCL_SW_CONFIG_BANK_ADDR + 4 * bank_id,
-			   bank_config);
-}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
index d0f6a174f347..07392b31d0ab 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
@@ -181,13 +181,14 @@ struct hal_tx_fes_status_end {
 /* STA mode will have MCAST_PKT_CTRL instead of DSCP_TID_MAP bitfield */
 #define HAL_TX_BANK_CONFIG_DSCP_TIP_MAP_ID	GENMASK(22, 17)
 
+void ath12k_wifi7_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id);
 void ath12k_wifi7_hal_tx_cmd_desc_setup(struct ath12k_base *ab,
 					struct hal_tcl_data_cmd *tcl_cmd,
 					struct hal_tx_info *ti);
-void ath12k_wifi7_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id);
 int ath12k_wifi7_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
 				  enum hal_reo_cmd_type type,
 				  struct ath12k_hal_reo_cmd *cmd);
 void ath12k_wifi7_hal_tx_configure_bank_register(struct ath12k_base *ab,
-						 u32 bank_config, u8 bank_id);
+						 u32 bank_config,
+						 u8 bank_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 0985f929a4b5..2e645f8f4a14 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -8,6 +8,7 @@
 #include "hal_wcn7850.h"
 #include "hw.h"
 #include "hal.h"
+#include "hal_tx.h"
 
 static const struct hal_srng_config hw_srng_config_template[] = {
 	/* TODO: max_rings can populated by querying HW capabilities */
@@ -826,5 +827,13 @@ const struct hal_ops hal_wcn7850_ops = {
 	.ce_dst_set_desc = ath12k_wifi7_hal_ce_dst_set_desc,
 	.ce_dst_status_get_length = ath12k_wifi7_hal_ce_dst_status_get_length,
 	.set_link_desc_addr = ath12k_wifi7_hal_set_link_desc_addr,
+	.tx_set_dscp_tid_map = ath12k_wifi7_hal_tx_set_dscp_tid_map,
+	.tx_configure_bank_register =
+		ath12k_wifi7_hal_tx_configure_bank_register,
+	.reoq_lut_addr_read_enable = ath12k_wifi7_hal_reoq_lut_addr_read_enable,
+	.reoq_lut_set_max_peerid = ath12k_wifi7_hal_reoq_lut_set_max_peerid,
+	.write_reoq_lut_addr = ath12k_wifi7_hal_write_reoq_lut_addr,
+	.write_ml_reoq_lut_addr = ath12k_wifi7_hal_write_ml_reoq_lut_addr,
+	.setup_link_idle_list = ath12k_wifi7_hal_setup_link_idle_list,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
-- 
2.34.1



Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3235F64B7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 13:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJFLAt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiJFLAY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 07:00:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42745140D3
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 04:00:22 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29695gMh017707;
        Thu, 6 Oct 2022 11:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4O9Fpc7HalZzX+A0j5otuePt3zJFI3ai6KItaYbq+Yo=;
 b=HsSGAsQ4QCfvhAHEVkZFs2grzvjYbUcnPuS3YPaU48XCRwf55spiT1nwAP/Zj5Qz/J5q
 RWUsMtloVh66xRIsieSV3fJZsbXEvQyk50CYHABLFzlUsn7rk1Q/6Yuhsm7tKT9RAOmt
 i9z/L7E27B6xYYFQ3qjgA/rvVdL0/O5vZJdE5mc1il2+vo0uR3lAnAE8QP7o33Ssx9o1
 DzVQynUvLoIwoeZGS15YEOpe2gFOdYxRutM/STFNoWM45n16AXwwChBNP6Az3cq3B27V
 4Ksm2Cejbw2jsJpM0PXCOJAhKKIV2vi2rIShVm9YyjlGMpaBnb2MNWcHshDXRqI+geDK lA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k1qykrrc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 11:00:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 296B0JjV008667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 11:00:19 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 6 Oct 2022 04:00:17 -0700
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 3/8] wifi: ath11k: update ce configurations for IPQ5018
Date:   Thu, 6 Oct 2022 16:29:08 +0530
Message-ID: <20221006105913.18356-4-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221006105913.18356-1-quic_kathirve@quicinc.com>
References: <20221006105913.18356-1-quic_kathirve@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FQZ0RjjTVmGckUziIuoBWnMfXmbRg48Z
X-Proofpoint-GUID: FQZ0RjjTVmGckUziIuoBWnMfXmbRg48Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IPQ5018 is a single pdev device. Update host
and target CE configurations accordingly.

Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |   4 +
 drivers/net/wireless/ath/ath11k/core.h |   4 +
 drivers/net/wireless/ath/ath11k/hw.c   | 191 +++++++++++++++++++++++++
 3 files changed, 199 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 60ff6b72bc20..e45f1c20fef9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -617,6 +617,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.internal_sleep_clock = false,
 		.host_ce_config = ath11k_host_ce_config_qcn9074,
 		.ce_count = CE_CNT_5018,
+		.target_ce_config = ath11k_target_ce_config_wlan_ipq5018,
+		.target_ce_count = TARGET_CE_CNT_5018,
+		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq5018,
+		.svc_to_ce_map_len = SVC_CE_MAP_LEN_5018,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = RXDMA_PER_PDEV_5018,
 		.rx_mac_buf_ring = false,
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index fe1055a23948..af6cc9fbf181 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1133,6 +1133,10 @@ extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq6018
 extern const struct ce_pipe_config ath11k_target_ce_config_wlan_qca6390[];
 extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_qca6390[];
 
+extern const struct ce_pipe_config ath11k_target_ce_config_wlan_ipq5018[];
+extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq5018[];
+
+
 extern const struct ce_pipe_config ath11k_target_ce_config_wlan_qcn9074[];
 extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_qcn9074[];
 int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index dbcc0c4035b6..fa722b6a71d0 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1972,6 +1972,197 @@ const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_wcn6750 = {
 	},
 };
 
+/* Target firmware's Copy Engine configuration for IPQ5018 */
+const struct ce_pipe_config ath11k_target_ce_config_wlan_ipq5018[] = {
+	/* CE0: host->target HTC control and raw streams */
+	{
+		.pipenum = __cpu_to_le32(0),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE1: target->host HTT + HTC control */
+	{
+		.pipenum = __cpu_to_le32(1),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE2: target->host WMI */
+	{
+		.pipenum = __cpu_to_le32(2),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE3: host->target WMI */
+	{
+		.pipenum = __cpu_to_le32(3),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE4: host->target HTT */
+	{
+		.pipenum = __cpu_to_le32(4),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(256),
+		.nbytes_max = __cpu_to_le32(256),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS | CE_ATTR_DIS_INTR),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE5: target->host Pktlog */
+	{
+		.pipenum = __cpu_to_le32(5),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE6: Reserved for target autonomous hif_memcpy */
+	{
+		.pipenum = __cpu_to_le32(6),
+		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(16384),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE7 used only by Host */
+	{
+		.pipenum = __cpu_to_le32(7),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(0x2000),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE8 target->host used only by IPA */
+	{
+		.pipenum = __cpu_to_le32(8),
+		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(16384),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+};
+
+/* Map from service/endpoint to Copy Engine for IPQ5018.
+ * This table is derived from the CE TABLE, above.
+ * It is passed to the Target at startup for use by firmware.
+ */
+const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq5018[] = {
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
+		.pipedir =		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum =		__cpu_to_le32(3),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
+		.pipedir =		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum =		__cpu_to_le32(2),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BK),
+		.pipedir =		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum =		__cpu_to_le32(3),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BK),
+		.pipedir =		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum =		__cpu_to_le32(2),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BE),
+		.pipedir =		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum =		__cpu_to_le32(3),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BE),
+		.pipedir =		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum =		__cpu_to_le32(2),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VI),
+		.pipedir =		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum =		__cpu_to_le32(3),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VI),
+		.pipedir =		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum =		__cpu_to_le32(2),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL),
+		.pipedir =		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum =		__cpu_to_le32(3),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL),
+		.pipedir =		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum =		__cpu_to_le32(2),
+	},
+
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_RSVD_CTRL),
+		.pipedir =		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum =		__cpu_to_le32(0),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_RSVD_CTRL),
+		.pipedir =		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum =		__cpu_to_le32(1),
+	},
+
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_TEST_RAW_STREAMS),
+		.pipedir =		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum =		__cpu_to_le32(0),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_TEST_RAW_STREAMS),
+		.pipedir =		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum =		__cpu_to_le32(1),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_HTT_DATA_MSG),
+		.pipedir =		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum =		__cpu_to_le32(4),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_HTT_DATA_MSG),
+		.pipedir =		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum =		__cpu_to_le32(1),
+	},
+	{
+		.service_id =	__cpu_to_le32(ATH11K_HTC_SVC_ID_PKT_LOG),
+		.pipedir =		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum =		__cpu_to_le32(5),
+	},
+
+       /* (Additions here) */
+
+	{ /* terminator entry */ }
+};
+
 const struct ath11k_hw_regs ipq8074_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
 	.hal_tcl1_ring_base_lsb = 0x00000510,
-- 
2.38.0


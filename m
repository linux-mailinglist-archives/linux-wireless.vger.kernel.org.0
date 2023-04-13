Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64306E16BC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 23:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjDMVwY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 17:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjDMVwT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 17:52:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798417AAD
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 14:52:18 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DJv7Av030327;
        Thu, 13 Apr 2023 21:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=epCihspHMPzrtm/vMwrnK+aBfr8BU8kaeXFujDRzLdo=;
 b=YVuOAwAO0N0LnZzYFkQLo6BOgyGkgHP4cXGNx5mmVfU5lc5GIuFvLG5QnkL/sq9q3gFP
 2w1Ybhv8mfrzu5o74hqsaWk7E5yWdGi816569dgyGac5p6hCHyQ5zZFoLFOqnn7LEjKu
 ho5zGNpn/s5s/10p9fUeegq05VUakWT/JjtOwurn0hin/f+6Wun45tdg84Khky/3sivU
 o+lsHmXWAwlFmuXSeZ4PG2w5RBx40O5P6eXfat3kpHq8ahClVLV2065M7wnK9uJK0Wmk
 eK4/Q2Tq0bDeIHwGqMxFybhGcMkmuMJhYQSi1SqeS0Kf2iYy9v4+gQRJf+B0k5cJ9Jm9 Gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxqf989re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 21:52:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33DLqBgc006714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 21:52:11 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 14:52:10 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH v3 08/11] wifi: ath12k: peer assoc for 320 MHz
Date:   Thu, 13 Apr 2023 14:51:53 -0700
Message-ID: <20230413215156.2649-9-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230413215156.2649-1-quic_alokad@quicinc.com>
References: <20230413215156.2649-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e7qvmRUL6ppkV9wzGUSNzllk6_iHZBKl
X-Proofpoint-ORIG-GUID: e7qvmRUL6ppkV9wzGUSNzllk6_iHZBKl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_16,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add required peer association definitions and processing if the
bandwidth is 320 MHz.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu<quic_pradeepc@quicinc.com>
---
v3: No change from v2.
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/wmi.c | 2 ++
 drivers/net/wireless/ath/ath12k/wmi.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index f81724260b9b..e5513e979d78 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1808,6 +1808,8 @@ static void ath12k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 			cmd->peer_flags |= cpu_to_le32(WMI_PEER_80MHZ);
 		if (arg->bw_160)
 			cmd->peer_flags |= cpu_to_le32(WMI_PEER_160MHZ);
+		if (arg->bw_320)
+			cmd->peer_flags |= cpu_to_le32(WMI_PEER_EXT_320MHZ);
 
 		/* Typically if STBC is enabled for VHT it should be enabled
 		 * for HT as well
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c2c340af3612..f348ea9e325d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1169,6 +1169,7 @@ enum wmi_tlv_peer_flags {
 
 enum wmi_tlv_peer_flags_ext {
 	WMI_PEER_EXT_EHT = 0x00000001,
+	WMI_PEER_EXT_320MHZ = 0x00000002,
 };
 
 /** Enum list of TLV Tags for each parameter structure type. */
@@ -3549,6 +3550,7 @@ struct ath12k_wmi_peer_assoc_arg {
 	bool bw_40;
 	bool bw_80;
 	bool bw_160;
+	bool bw_320;
 	bool stbc_flag;
 	bool ldpc_flag;
 	bool static_mimops_flag;
-- 
2.39.0


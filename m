Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0D6D5725
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 05:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjDDDVW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 23:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjDDDVT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 23:21:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9A2191
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 20:21:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3341n67G009577;
        Tue, 4 Apr 2023 03:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=M3itqZoiesGkJmGBRnljfnLC8sbkhk30wkEcf5Uabn4=;
 b=cbgIn8AJXC04rW3a/5tkXj2e6pXkRXAfuK0gAyKJehIGlmlUe59OUzDGEx0xMrBPwuOa
 5thp3+vpE5dHn7MWQ74yHC2x84+hc+OyGJPgKtrxyA6bof2S/fnDf8MGxrqyltH/gfwN
 1qs2lq4ow1YCQnb199a2QKasbmeWzq23K41dGySFdbe0cv+dWiE7LV58aj6a0FI9cZlB
 HCrgW6qXYMnsXHbH+G7n+CgZ0rqeWyWSPsD6Fyveew86KFbA+IoS5KeyAwTMWH8dN6rK
 /3Jtum6sOQNJPRIRFPynNFUzXHFqKYyKtFz7ai4XyVj4nujE/z9eJ/Zfhc+bDFRlWP1g 6w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqusu2bq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 03:21:15 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3343LEWC032022
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 03:21:14 GMT
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 20:21:13 -0700
From:   Carl Huang <quic_cjhuang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_cjhuang@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: add qmi_cnss_feature_bitmap field to hardware parameters
Date:   Tue, 4 Apr 2023 11:20:56 +0800
Message-ID: <20230404032057.3236122-2-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404032057.3236122-1-quic_cjhuang@quicinc.com>
References: <20230404032057.3236122-1-quic_cjhuang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jT8doHBfEig_CCCH3PpgtehXO_1KqJs7
X-Proofpoint-ORIG-GUID: jT8doHBfEig_CCCH3PpgtehXO_1KqJs7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040029
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently CNSS(Connectivity Subsystem) feature is assigned to
qmi_wlanfw_host_cap_req_msg_v01 request directly, this prevents
chip-specific CNSS features from being added easily.

Fix it by adding a new field qmi_cnss_feature_bitmap to hw_params
so chip-specific CNSS features can be assigned to this field and
later assigned to qmi_wlanfw_host_cap_req_msg_v01 request.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  | 5 +++++
 drivers/net/wireless/ath/ath12k/hw.h  | 2 ++
 drivers/net/wireless/ath/ath12k/qmi.c | 6 ++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 1ffac7e3deaa..cc47cbf93f6b 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -906,6 +906,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.hal_ops = &hal_qcn9274_ops,
 
+		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -960,6 +961,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.wmi_init = ath12k_wmi_init_wcn7850,
 
 		.hal_ops = &hal_wcn7850_ops,
+
+		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1013,6 +1016,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.wmi_init = ath12k_wmi_init_qcn9274,
 
 		.hal_ops = &hal_qcn9274_ops,
+
+		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index e3461004188b..e6c4223c283c 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -184,6 +184,8 @@ struct ath12k_hw_params {
 			 struct ath12k_wmi_resource_config_arg *config);
 
 	const struct hal_ops *hal_ops;
+
+	u64 qmi_cnss_feature_bitmap;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 03ba245fbee9..4afba76b90fe 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1942,8 +1942,10 @@ static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 	req.cal_done_valid = 1;
 	req.cal_done = ab->qmi.cal_done;
 
-	req.feature_list_valid = 1;
-	req.feature_list = BIT(CNSS_QDSS_CFG_MISS_V01);
+	if (ab->hw_params->qmi_cnss_feature_bitmap) {
+		req.feature_list_valid = 1;
+		req.feature_list = ab->hw_params->qmi_cnss_feature_bitmap;
+	}
 
 	/* BRINGUP: here we are piggybacking a lot of stuff using
 	 * internal_sleep_clock, should it be split?
-- 
2.25.1


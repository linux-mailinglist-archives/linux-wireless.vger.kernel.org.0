Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002B375BE09
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 07:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGUFyE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jul 2023 01:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGUFxc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jul 2023 01:53:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD3330F2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 22:53:28 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L5m37h021774;
        Fri, 21 Jul 2023 05:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=v04/jZu6rS74Kbl4ylaImq74Qnm9nrCiCsSm5mqFmwI=;
 b=Keh6poDFGTi1/1hN38IWOB/3C7cy/wn6I+xcexPBwGVkxCxX1cgmAocj2lK+Cp6c5IGd
 ypMq8ZPJpLAq4Xy+iD4l6loySI0gKicbfZnAQ1WjbozsvCvn6w9viiz09QFC+EzgnOA3
 u37IRLcYnMjhyCWZwtO/mGTdEYPVFTSuCOLAJpeldlYvoGowx8Aww0w5rbYilCVvZ8x+
 U4KCqYNSAWaIsSu6GcrJgoR3/T3P35SBT6vCzgYaHRMXpIsZSv+7qHBNgfdmrVqbIAeh
 IyBA2I4nGBXfuONRes4sx0neWBT09gpFAox2uOUoWVd1wuDrZ2PTtMv+ZwZKy7anzcD9 CQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryhdy894h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:53:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L5rNeC013785
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:53:23 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 22:53:22 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 2/3] wifi: ath12k: add ath12k_qmi_free_resource() for recovery
Date:   Fri, 21 Jul 2023 01:53:04 -0400
Message-ID: <20230721055305.20420-3-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721055305.20420-1-quic_wgong@quicinc.com>
References: <20230721055305.20420-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yiOdX0B4HllXqzZI0eElLCkV-OJJeQSC
X-Proofpoint-ORIG-GUID: yiOdX0B4HllXqzZI0eElLCkV-OJJeQSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath12k_qmi_free_target_mem_chunk() and ath12k_qmi_m3_free() is static
in qmi.c, they are needed for recovery, export them in a new function

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 1 +
 drivers/net/wireless/ath/ath12k/qmi.c  | 6 ++++++
 drivers/net/wireless/ath/ath12k/qmi.h  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3df8059d5512..85e49f9ff4c4 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -839,6 +839,7 @@ static void ath12k_core_reset(struct work_struct *work)
 						ATH12K_RECOVER_START_TIMEOUT_HZ);
 
 	ath12k_hif_power_down(ab);
+	ath12k_qmi_free_resource(ab);
 	ath12k_hif_power_up(ab);
 
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset started\n");
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 4afba76b90fe..d0da9b63a114 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3089,3 +3089,9 @@ void ath12k_qmi_deinit_service(struct ath12k_base *ab)
 	ath12k_qmi_m3_free(ab);
 	ath12k_qmi_free_target_mem_chunk(ab);
 }
+
+void ath12k_qmi_free_resource(struct ath12k_base *ab)
+{
+	ath12k_qmi_free_target_mem_chunk(ab);
+	ath12k_qmi_m3_free(ab);
+}
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index df76149c49f5..6d4a5ab72d45 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -566,5 +566,6 @@ void ath12k_qmi_event_work(struct work_struct *work);
 void ath12k_qmi_msg_recv_work(struct work_struct *work);
 void ath12k_qmi_deinit_service(struct ath12k_base *ab);
 int ath12k_qmi_init_service(struct ath12k_base *ab);
+void ath12k_qmi_free_resource(struct ath12k_base *ab);
 
 #endif
-- 
2.40.1


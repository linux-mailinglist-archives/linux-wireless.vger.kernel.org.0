Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A549F75A488
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 04:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGTCxA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 22:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGTCw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 22:52:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758EF1BB
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 19:52:55 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K1xqbT009192;
        Thu, 20 Jul 2023 02:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=v04/jZu6rS74Kbl4ylaImq74Qnm9nrCiCsSm5mqFmwI=;
 b=Y5/PxZ+4JhWL4PcUQuYP7yRgplA5ggmUj68zf6wDoipb1GLZpw2HNM6Frm0Wgc/TtLs7
 338VG4SCadjdRfrTOAuP+F7nuPQ75WjU8P07EN+x30ntn6XhmsLr3YHgNcRHnnlQnUuA
 b14DBHlZbTGusVYuldbCbf1RloQX8Oc1Eg/mQUL9NEHvjKDrwJs/uLtXWp05mi89E0La
 oMBxMo1FvoOoz9sfwzaB7H0UQrCjnzSqimRBZWGvuIku+sn6V5EeJ4sU0d6qWuKFV1K7
 k2KxoPTyTPr0xyt9rid8sKeWTwaaI8Uzcx7JLiLfOJAxzNPlp2SO3er2ux4R9ln6YF3N 1A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxummr31m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 02:52:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K2qojw020651
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 02:52:50 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 19:52:49 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 2/3] wifi: ath12k: add ath12k_qmi_free_resource() for recovery
Date:   Wed, 19 Jul 2023 22:52:31 -0400
Message-ID: <20230720025232.7701-3-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720025232.7701-1-quic_wgong@quicinc.com>
References: <20230720025232.7701-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w-XA8ET-hsv0TuqFtuZe9iOyU0HWGblS
X-Proofpoint-GUID: w-XA8ET-hsv0TuqFtuZe9iOyU0HWGblS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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


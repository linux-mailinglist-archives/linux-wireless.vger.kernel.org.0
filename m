Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8A60732B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJUJBz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 05:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJUJBx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 05:01:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D96250EE7
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 02:01:49 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L784gN000629;
        Fri, 21 Oct 2022 09:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=nx+bgSZzf59VKx7qmt+78u2THS80DFLehXCuYuBTseM=;
 b=jpFyuOQv4yA78a4wCCGiFLR4UCDIC5VFdioUhaRA1iqNLjAJiLnFj2Vju46mGkOJj5o1
 Tv8fx9poG1fBrFJJ2XNmqDRvmXRb2a7EHDULFSO1bOIGjXtvHcYJzInfdgMNbMsYlTCj
 X3LQTorgQrGSPL47feJJ9fsqhdMoOYp/pks3qImLtK2D+Jif792TvXf39eNQLaj7tfaI
 67yoSajaK5+ePtoN713rgt/6xbzTExHPwLuoubK0jRDiMj3XOvz8pDQSKn3AwJpXRQ41
 9VEysEDrvm/Xp0mBL29xYxdgSQI5GD4QxfOT9IC6E4yoWI25TZeNpsKqsKTXNYkR25rD Hw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kb2c635tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 09:01:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29L91eHg003840
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 09:01:40 GMT
Received: from rbhattac-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 21 Oct 2022 02:01:38 -0700
From:   Rahul Bhattacharjee <quic_rbhattac@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rahul Bhattacharjee <quic_rbhattac@quicinc.com>
Subject: [PATCH] wifi: ath11k: Fix qmi_msg_handler data structure initialization
Date:   Fri, 21 Oct 2022 14:31:26 +0530
Message-ID: <20221021090126.28626-1-quic_rbhattac@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qi_AnLDNa6awUOAZVQAu1qEecr0iBYcD
X-Proofpoint-ORIG-GUID: Qi_AnLDNa6awUOAZVQAu1qEecr0iBYcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxlogscore=941
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

qmi_msg_handler is required to be null terminated by QMI module.
There might be a case where a handler for a msg id is not present in the
handlers array which can lead to infinite loop while searching the handler
and therefore out of bound access in qmi_invoke_handler().
Hence update the initialization in qmi_msg_handler data structure.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rahul Bhattacharjee <quic_rbhattac@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 145f20a681bd..bda4921208cc 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3090,6 +3090,7 @@ static const struct qmi_msg_handler ath11k_qmi_msg_handlers[] = {
 			sizeof(struct qmi_wlfw_fw_init_done_ind_msg_v01),
 		.fn = ath11k_qmi_msg_fw_init_done_cb,
 	},
+	{/* end of list */}
 };
 
 static int ath11k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,

base-commit: 087c436cbc8b1bf3d3bc7ea94d6757d74ea2f470
-- 
2.38.0


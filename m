Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B89976389D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 16:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjGZOMO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 10:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjGZOLr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB623AB1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 07:11:04 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QCpmWf010039;
        Wed, 26 Jul 2023 14:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PIq1sGfa2rC9FQr1Tm6qDBqE2KAZFIPCIiKPaj3TQ54=;
 b=Nr4IHZq58vf6hhAMCSyWFCCvsONxgtLze4hUGYuo1fPmYxDXfnja3SDxapuU6DLuGr8E
 hbBpnAnil1O6PPqDAbP+MaUOhPMpgf42V2lzLcqLv0utBQ66cOWgEHoR0OWX+lUMFROC
 sBrcezBRYWgNktqFMGvKtl5Y2kxV7LpKbtqgKxJxoWOSqQxkuTJrEytLxI4qON/WZPi9
 Er1IOLvr1Y8YPD97eDLnvTtBq1jrOAyaqoppdFsngD9apE0BMhPceKw2aL/XBhgZD09D
 PJgKznxHgRKoUuoWg004RBlb4jxRNjvf0nAePZwF+qoUlCdalcBjjejnhxeD91ThlFS/ Iw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s32jn0a4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:10:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QEAw9I005975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:10:59 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 07:10:57 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 3/3] wifi: ath11k: Remove cal_done check during probe
Date:   Wed, 26 Jul 2023 19:40:32 +0530
Message-ID: <20230726141032.3061-4-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230726141032.3061-1-quic_rajkbhag@quicinc.com>
References: <20230726141032.3061-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7t9rbuEhyfOPQcK8-POzam4yEAefwWCZ
X-Proofpoint-ORIG-GUID: 7t9rbuEhyfOPQcK8-POzam4yEAefwWCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>

In some race conditions, calibration done QMI message is received even
before host wait starts for calibration to be done.
Due to this, resetting firmware was not performed after calibration.

Hence, remove cal_done check in ath11k_qmi_fwreset_from_cold_boot()
as this is called only from probe.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index c4eab5d7f..617abb441 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2844,7 +2844,7 @@ int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
 {
 	int timeout;
 
-	if (!ath11k_core_coldboot_cal_support(ab) || ab->qmi.cal_done ||
+	if (!ath11k_core_coldboot_cal_support(ab) ||
 	    ab->hw_params.cbcal_restart_fw == 0)
 		return 0;
 
-- 
2.17.1


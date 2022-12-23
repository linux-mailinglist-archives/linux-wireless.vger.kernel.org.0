Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F056654C24
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Dec 2022 06:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiLWFHm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Dec 2022 00:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiLWFHi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Dec 2022 00:07:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1EF12D27
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 21:07:37 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN50QoH014389;
        Fri, 23 Dec 2022 05:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PzcgMozoFB9J7s18F/3O449TD2NtEWYM+hSAROjYSHk=;
 b=Kb1fp+hhYrLapX2gQ3gy28y4IO1sDa9KHXadzbQYECrxEB24YXPbrbLcIRmsXLgcFsue
 mbQnrInE/NjUdrcQ/p8wRPWA4safOdR0oifAIex7TX4gf1MrnIseSjUu6h+au3VJBEl+
 o0WRQVHxSick+XMPpUkq9eIWVE6oMrbBvFMT/T5ivFctmAAckz0gHA6VYFzc9Vu/7fJh
 DqYI9Q1owuDxU3C7dvyJS1MbUl8ru+M7GUrWmBqDsW733FQUDnvz0YbAII9fWSOJzmTX
 UtDwgCdDZIXIOISfgVz9e3S93xfW1z2rAtHUmCYazApHov/f884/znSS2ttsnt5/PLG8 Lg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm5r2ku8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 05:07:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BN57Xek032102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 05:07:33 GMT
Received: from dinek-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 21:07:31 -0800
From:   Dinesh Karthikeyan <quic_dinek@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: Add support to read EEPROM caldata
Date:   Fri, 23 Dec 2022 10:36:46 +0530
Message-ID: <20221223050646.27785-4-quic_dinek@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221223050646.27785-1-quic_dinek@quicinc.com>
References: <20221223050646.27785-1-quic_dinek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ga6CoJ12EfL1CtPGaDhhWi_RNAIRg8RF
X-Proofpoint-ORIG-GUID: ga6CoJ12EfL1CtPGaDhhWi_RNAIRg8RF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_02,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In current implementation, there is a overhead of maintaining caldata
in the filesystem manually. To eliminate this overhead, for pci based
chipsets, if calibration data is present in EEPROM, indicate firmware
to download and read caldata from EEPROM. If the caldata is present in
EEPROM, host is notified in the target capability.
Upon this, the download request for the type ATH12K_QMI_FILE_TYPE_EEPROM
is sent to firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index a69307bea596..979a63f2e2ab 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2371,12 +2371,16 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 			goto out;
 		}
 
-		remaining -= req->data_len;
-		temp += req->data_len;
-		req->seg_id++;
-		ath12k_dbg(ab, ATH12K_DBG_QMI,
-			   "qmi bdf download request remaining %i\n",
-			   remaining);
+		if (type == ATH12K_QMI_FILE_TYPE_EEPROM) {
+			remaining = 0;
+		} else {
+			remaining -= req->data_len;
+			temp += req->data_len;
+			req->seg_id++;
+			ath12k_dbg(ab, ATH12K_DBG_QMI,
+				   "qmi bdf download request remaining %i\n",
+				   remaining);
+		}
 	}
 
 out:
@@ -2422,7 +2426,7 @@ static int ath12k_qmi_load_bdf_qmi(struct ath12k_base *ab,
 	case ATH12K_QMI_BDF_TYPE_CALIBRATION:
 
 		if (ab->qmi.target.eeprom_caldata) {
-			file_type = ATH12K_QMI_FILE_TYPE_CALDATA;
+			file_type = ATH12K_QMI_FILE_TYPE_EEPROM;
 			tmp = filename;
 			fw_size = ATH12K_QMI_MAX_BDF_FILE_NAME_SIZE;
 		} else {
-- 
2.17.1


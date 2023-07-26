Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2AD76327B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 11:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjGZJja (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGZJj3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 05:39:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9CBC
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 02:39:15 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q8d9Gp020222;
        Wed, 26 Jul 2023 09:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Zc4w4yInKkkf8P8EVgNZ/PmQEtteJiEFPLay/998uwc=;
 b=bvPqBSK1Z6B5B5TKDlxPaS8ADq3r14iGgnLWKUFx7dny+VetzsMV6am1LtNSLX0hNeLI
 pxLhCVkBAlMs8qb7peAkrZEAZjinwXo0GDorDVOl+NEeOpbDD/9bxnN3SZdHXhyRiBLn
 6YzJP/mY0M8I3hI793cVJaaB0E/jDNqjVvCvtlrbWZKXc37cotKQjnUBttx+DjiGx54M
 SFKW5Eq+rs4zUWIvbyR3bqZ6uxQEZIZ8izS7t4lodDlrXmUo7f9BqD7DA62sltdle+2y
 1D5vqrL+CEZKRlxd1CnTi8DpvANSFcHdTo17AKXulnoLoDeiMJarAsd3umL/wVUTx9cQ yQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2cf8ts0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:39:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q9dBhv019388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:39:11 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 02:39:10 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath12k: correct the data_type from QMI_OPT_FLAG to QMI_UNSIGNED_1_BYTE for mlo_capable
Date:   Wed, 26 Jul 2023 05:38:57 -0400
Message-ID: <20230726093857.3610-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0-Q58cgQCuE1IhbxIDIK9jeoT2a6Gw8F
X-Proofpoint-GUID: 0-Q58cgQCuE1IhbxIDIK9jeoT2a6Gw8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_03,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, the encoding rule for field mlo_capable in struct
qmi_wlanfw_host_cap_req_msg_v01 defined in array
qmi_wlanfw_host_cap_req_msg_v01_ei uses type QMI_OPT_FLAG.

Unfortunately, all ath12k firmware actually expects this field to be of
type NON QMI_OPT_FLAG such as QMI_UNSIGNED_1_BYTE/QMI_UNSIGNED_8_BYTE...
And as a result, firmware is unable to correctly decode the mlo_capable
field.

Change the ath12k definition as QMI_UNSIGNED_1_BYTE to match the firmware
definition so that firmware can correctly parse the mlo_capable info from
message QMI_WLANFW_HOST_CAP_REQ_V01 at wlan load time.

This is just an accidental typo and that both WCN7850 and QCN9274 firmwares
use QMI_UNSIGNED_1_BYTE.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 4afba76b90fe..83a79b25c32f 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -387,7 +387,7 @@ static struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
 					   mlo_capable_valid),
 	},
 	{
-		.data_type	= QMI_OPT_FLAG,
+		.data_type	= QMI_UNSIGNED_1_BYTE,
 		.elem_len	= 1,
 		.elem_size	= sizeof(u8),
 		.array_type	= NO_ARRAY,

base-commit: b21fe5be53eb873c02e7479372726c8aeed171e3
-- 
2.40.1


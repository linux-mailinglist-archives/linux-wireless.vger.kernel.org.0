Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64122654C22
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Dec 2022 06:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLWFHj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Dec 2022 00:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLWFHg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Dec 2022 00:07:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530C612AF7
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 21:07:35 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN4gYCV007837;
        Fri, 23 Dec 2022 05:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Da5/YnDi685NImrpSMSnBTYVUbqmoClVbiTSxZTM/jw=;
 b=BiE42uSKBZ/2j+V7KpivWexZdwpHRJsCCDg4VeO/PRiY/Tc1a/a04T1Ijd+XBC1aRuvc
 HxuvGQDYBcI31nBrA8aK2BZa6VG77iII4lMgTu+jd0H0kxPc9qfvFUXbxSgYIVg27nSs
 fS39uCQrQpAkljjvJLuroAl8x1PKwNvYklObhlET0sOmKAuRYxaKDr5Sqp0NB4NnfO0J
 chWBZHzQx0GbT0vEaTQuNvuehg0S5IclcfOAHu3Zh7OisCy/6QvypQQuRKW2fZWX+2fc
 KyNpDEjBJZQp5qFD/zIKqRRSGnJkprTUWBqx6K5MiOp3NeUIX+UV5EGIRDv5e2eDGyKE lQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mmtpfs884-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 05:07:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BN57SEx027201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 05:07:28 GMT
Received: from dinek-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 21:07:25 -0800
From:   Dinesh Karthikeyan <quic_dinek@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>
Subject: [PATCH 0/3] Add changes to read caldata from EEPROM
Date:   Fri, 23 Dec 2022 10:36:43 +0530
Message-ID: <20221223050646.27785-1-quic_dinek@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rVLuTKI4qEKHHmbtPTWS0nO_MqzviWP7
X-Proofpoint-ORIG-GUID: rVLuTKI4qEKHHmbtPTWS0nO_MqzviWP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_02,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 mlxlogscore=665 clxscore=1011 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to read calibration data from EEPROM.

Dinesh Karthikeyan (3):
  wifi: ath12k: Fix incorrect qmi_file_type enum values
  wifi: ath12k: Add new qmi_bdf_type to handle caldata
  wifi: ath12k: Add support to read EEPROM caldata

 drivers/net/wireless/ath/ath12k/qmi.c | 131 ++++++++++++--------------
 drivers/net/wireless/ath/ath12k/qmi.h |   9 +-
 2 files changed, 66 insertions(+), 74 deletions(-)

-- 
2.17.1


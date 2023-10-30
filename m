Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD37DC269
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjJ3W1q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJ3W1p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:27:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD2FE8
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:27:39 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ULqTE3027293;
        Mon, 30 Oct 2023 22:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=jXzHCSyj9C0E6i8loryrBAmW6y6X02LfmsWBoLfcjRQ=;
 b=Uv80+PfIfUv8cs+iET9chBHoRWovIqozXJGT3gAeWcxhvMbN50+0pjQW2Eb06jUCZC0h
 c2BTxPkNqlLTbtqUUUU4FIJAM1FdZqZqeFpaICrkwL+lCrZwk401n5cI5ZU79W7rc7J+
 fgvjhKEoYREA3aP4RcKt2WG0/lQbj0IV+ffCnw58zvouBYle5a7hyAQMCg1aSNsvbVOx
 azeJwqVEYJjunfIk1u8OMBNaAqogFnZsJ4xJKgFd/ObbW4cm9CShBOsbx3q6FKmwkRIK
 x1CNAdUKZ+OlhHKqPI2juOe+iPrgcSxZCY9FV1NTm3fcgBib5D1/KlsuOBTjdJFIsgbQ WQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2dey175h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMRZbJ021330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:35 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:27:33 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rajat Soni <quic_rajson@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 01/13] wifi: ath12k: Update enum wmi_direct_buffer_module
Date:   Tue, 31 Oct 2023 03:56:48 +0530
Message-ID: <20231030222700.18914-2-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IwjlGxMzqnrxfOW8SL4HgLWxMRGJrpbG
X-Proofpoint-GUID: IwjlGxMzqnrxfOW8SL4HgLWxMRGJrpbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=940
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310300176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rajat Soni <quic_rajson@quicinc.com>

Currently firmware is sending module id as 2 that is not supported.
This causes functional failure in driver.
Firmware added support for WMI_CONFIG_MODULE_CV_UPLOAD.
Add enum WMI_CONFIG_MODULE_CV_UPLOAD in wmi_direct_buffer_module to
resolve this issue.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 629373d67..8e1eda7aa 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2230,6 +2230,7 @@ enum wmi_beacon_gen_mode {
 enum wmi_direct_buffer_module {
 	WMI_DIRECT_BUF_SPECTRAL = 0,
 	WMI_DIRECT_BUF_CFR = 1,
+	WMI_DIRECT_BUF_CV_UPLOAD = 2,
 
 	/* keep it last */
 	WMI_DIRECT_BUF_MAX
-- 
2.17.1


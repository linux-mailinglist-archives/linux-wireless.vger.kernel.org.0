Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B259F7E82B4
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346118AbjKJTUn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 14:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjKJTUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 14:20:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500088687
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 23:28:22 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA4xZwT002493;
        Fri, 10 Nov 2023 07:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=F29z0DH6ltzPxFbZVijda5qq2mYS1r+J36j+smma3a0=;
 b=AubLtytXvuHfQQs+HMhOdUMHBO1XM51d6GWgyUYjvg8kbwKBCEuta+uVz0M/EjZG0E1v
 ikrrhB4njNSqYs/221ublfHiL/w6K3JsyyyvjZWsRwBUD2IFLBOs9HRxLipxN66HqksY
 sX9z3XjXciPhqUDPGL7l5+1KGGYueIK1BxSxOH7M1kWcvLn4Fk4vPvUxT4/wFCObNqBu
 C3b96sMZzaVfSPfSbGpDEieW/ciuwqoyEBJ0MqRFuA5+wtFh+2UAnY2lfQXrxHmoTipK
 U7MpzBQBvIuRjYVCLL6k2vdh1LGFvm/+7Q+bZmsG5BSSKeejjdzgr1EHKXePY2iTR/Li FA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93tq9g5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 07:28:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA7SHR7018044
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 07:28:17 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 9 Nov 2023 23:28:15 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix the error handler of rfkill config
Date:   Fri, 10 Nov 2023 12:58:02 +0530
Message-ID: <20231110072802.25290-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GgDle1GoykzNTQP0El6k9JvG-UpzS6dv
X-Proofpoint-ORIG-GUID: GgDle1GoykzNTQP0El6k9JvG-UpzS6dv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_03,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=688
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the core rfkill config throws error, it should free the
allocated resources. Currently it is not freeing the core pdev
create resources. Avoid this issue by calling the core pdev
destroy in the error handler of core rfkill config.

Found this issue in the code review and it is compile tested only.

Fixes: 004ccbc0dd49 ("wifi: ath12k: add support for hardware rfkill for WCN7850")
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index b936760b5140..5ba680379f7e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -698,13 +698,15 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 	ret = ath12k_core_rfkill_config(ab);
 	if (ret && ret != -EOPNOTSUPP) {
 		ath12k_err(ab, "failed to config rfkill: %d\n", ret);
-		goto err_core_stop;
+		goto err_core_pdev_destroy;
 	}
 
 	mutex_unlock(&ab->core_lock);
 
 	return 0;
 
+err_core_pdev_destroy:
+	ath12k_core_pdev_destroy(ab);
 err_core_stop:
 	ath12k_core_stop(ab);
 	ath12k_mac_destroy(ab);

base-commit: 553d0057523dc1d6935160613f1fbf9bb8db88f6
-- 
2.17.1


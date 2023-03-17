Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5E6BE132
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 07:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCQGZv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCQGZt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 02:25:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3378865109
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 23:25:48 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6KNhm005650;
        Fri, 17 Mar 2023 06:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=YueGEv/G3INSruoaqcwt7RwXVJ2qJU8PwXFQp9Hjj2Y=;
 b=JwybYraFiztzbEWwXjvWn3djNTga+XxTqYZhOyU2ZMcLFCnjoveGE5sK930o9HCczDhg
 9gdaVKcpLSs0BKYz3GWHM8p2QeiHhJtWHK0e1NkJ2Hvul3cp5IT3QSjSZrzvKlTb1mEG
 IvSemFfgq/2qo3sPh0yOR/VvI7R8tkko7sSpmKaeQ4DJF4QqMZWX7E7JC4Wd3nrOC+qr
 sstAiSjgpF1+p+s+K5wtk/qrMsctmgtSFXAM7qIIeAqfU51u1iEpI7Pyyg4uGSsk1pjA
 tmLUtKo4AXBs3Lhx/IfmTWbjvMDjxAz4WQOUqiAL16pFlsteR9l2vTRRlspJnmnJZpP4 lw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxjvanh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 06:25:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32H6PiCg001869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 06:25:44 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Mar 2023 23:25:43 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath12k: Enable IMPS for WCN7850
Date:   Fri, 17 Mar 2023 14:25:33 +0800
Message-ID: <20230317062533.18240-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WJRcy3WY-Lm3T5iGIJHokO-k6H89Yrm3
X-Proofpoint-ORIG-GUID: WJRcy3WY-Lm3T5iGIJHokO-k6H89Yrm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_02,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=872 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170042
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To reduce power consumption, change idle_ps to true to enable
idle mode power save (IMPS) for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 91d576fd4b0f..1ffac7e3deaa 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -944,7 +944,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.interface_modes = BIT(NL80211_IFTYPE_STATION),
 		.supports_monitor = false,
 
-		.idle_ps = false,
+		.idle_ps = true,
 		.download_calib = false,
 		.supports_suspend = false,
 		.tcl_ring_retry = false,

base-commit: 3df3715e556027e94246b2cb30986563362a65f4
-- 
2.25.1


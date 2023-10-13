Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9877C7E4D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 09:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjJMHAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 03:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjJMHAX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 03:00:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E291
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 00:00:21 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D6K8mN004841;
        Fri, 13 Oct 2023 07:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=1iTuwP352xzZDvTi8jqrD/tRqg8F/XkjG7R0hkSBj1c=;
 b=chjbLLwLreGztcTws08uRe/57IrutQaEZDHbZ3NNxPyQrO9z6GS8y7fSXCPIfAnkNOO7
 XRhiXmh4RJW/DfECFgtHUJvaBaMR2/beE+spHV107oSXllWsUv1iROtnrm5f7DJj0Mau
 Q4sN+rrvXzdJePdjJZfXBE6aczNcauqsZ4/vYj2GYViG7+7NItAFzQEWVVKoERmIDvT0
 Ub3dXO2YmurS5npDh2sdcDcdGi0J4gW/qIsVmv2/8n4XdViHZDZGIWaEBiq6QatrdN3w
 EF+vLgWDMmQoyaOyRZ+LB26iTCM36XylvbTrnpbM6cKQLDtGZ0WqbDX1jMT1jtMGzRlB LA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt1yrv88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 07:00:13 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39D70AKD020104;
        Fri, 13 Oct 2023 07:00:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3tk0dkvxwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Oct 2023 07:00:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39D70A9r020088;
        Fri, 13 Oct 2023 07:00:10 GMT
Received: from rgnanase-linux.qualcomm.com (rgnanase-linux.qualcomm.com [10.201.162.135])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 39D70AET020085;
        Fri, 13 Oct 2023 07:00:10 +0000
Received: by rgnanase-linux.qualcomm.com (Postfix, from userid 2378837)
        id 3FCFB1101FE3; Fri, 13 Oct 2023 12:30:09 +0530 (IST)
From:   Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: Enable Mesh support for QCN9274
Date:   Fri, 13 Oct 2023 12:30:06 +0530
Message-Id: <20231013070007.25597-2-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231013070007.25597-1-quic_rgnanase@quicinc.com>
References: <20231013070007.25597-1-quic_rgnanase@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: prfP12_RnrL5fJvnB46t0fvwk6gAwoQs
X-Proofpoint-ORIG-GUID: prfP12_RnrL5fJvnB46t0fvwk6gAwoQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=791 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130057
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently QCN9274 supports only AP and station interface modes.

Add interface type mesh to ath12k_hw_params for
QCN9274 to provide support for mesh mode as well.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index f69649f58e82..ac2106fa8b56 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -886,7 +886,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.vdev_start_delay = false,
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
-					BIT(NL80211_IFTYPE_AP),
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = false,
 
 		.idle_ps = false,
@@ -1006,7 +1007,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.vdev_start_delay = false,
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
-					BIT(NL80211_IFTYPE_AP),
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = false,
 
 		.idle_ps = false,
-- 
2.17.1


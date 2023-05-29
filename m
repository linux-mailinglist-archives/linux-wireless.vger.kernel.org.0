Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C1D7147C3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 12:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjE2KOW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 06:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2KOT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 06:14:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C45183
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 03:14:18 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T9W3kq026353;
        Mon, 29 May 2023 10:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=nVy9ziG9/jlOuEGpIzjRrUTWRV8olfNMe0YV0nRzZ50=;
 b=KgiPnmLu6F/RUqA7rpiCrwGctsB3vaCOINOSYkg2vplQ/2cuV7u3QgWnwqMyWBtB68xZ
 qUvxNzuWcZguIkcOcrb1QqNOsLlpSubz4NJ85uzmBwvtVOvdzSfYwcUF6pSamVJpABJW
 dyDI7695G3clE4DyIoCeyPMtqkXZ4061cWchuwy6IGRv5y4ajBbQgmCemTS77wZADpT7
 Qzb6dimKDhhN7gnF75TRoKfgSggXfMwKMjwtqtI6Yd+CCdBafX7/6tQUnLfNkIcCya+K
 AjG8QuE/QrDFfVLu7CdrRqF/98N1c7dW8W5kodVpJ+da+Rak3W53quyy1Q0WnDGfqjew Sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3quanxb52f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 10:14:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34TAEFYS018312
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 10:14:15 GMT
Received: from haric-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 29 May 2023 03:14:13 -0700
From:   Hari Chandrakanthan <quic_haric@quicinc.com>
To:     <quic_kvalo@quicinc.com>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH] wifi: ath12k: delete the timer rx_replenish_retry during rmmod
Date:   Mon, 29 May 2023 15:43:58 +0530
Message-ID: <1685355238-3282-1-git-send-email-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xIQEgal8lM9wjJbT-rfUlN_qNopXIFie
X-Proofpoint-GUID: xIQEgal8lM9wjJbT-rfUlN_qNopXIFie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=797 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305290088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The rx_replenish_retry timer is initialized in ath12k_core_alloc() when
ath12k module is loaded.
But rx_replenish_retry timer is not deleted anywhere in the code.
It is supposed to be deleted when ath12k module is removed/unloaded.

Delete the timer rx_replenish_retry in ath12k_core_free().

Found during code review.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index a89e666..d992380 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -885,6 +885,7 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 
 void ath12k_core_free(struct ath12k_base *ab)
 {
+	timer_delete_sync(&ab->rx_replenish_retry);
 	destroy_workqueue(ab->workqueue_aux);
 	destroy_workqueue(ab->workqueue);
 	kfree(ab);
-- 
2.7.4


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268C79C638
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 07:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjILFTu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Sep 2023 01:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjILFTt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Sep 2023 01:19:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478D7E5A
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 22:19:45 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C4VFH8016280;
        Tue, 12 Sep 2023 05:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rqH4i04aOnL+3UbLo/Mpkvggeg+3It7OrjPGumfD7SI=;
 b=Nl9KzhBYht/rPT94IBHHulCoEFcjHuPMkw4wNYjn+9QvZx4pfrJQNO4wocvt8q5XTHdz
 GOYtMrCHTJhOqgtWHZ0azgwXNfzQlJLKfIaxSSutxrjtYe0auPxnXQUpjjrMZHFdUvr7
 AbUFgMYBbfrZ1n8dL22A5LFsRDqejtFIMmJR/l1MY5VjZZbY7C2kSDYqF7tIDoVGO+dv
 ZaQQ9ach6rR8pnAFDd96pSQRL2cqRP3xYcbuUPE8n7IMzCldoPL/UP8EQt+bxT2+ArPC
 OhyKGxk5fGpu2wWS9Jk5iccwpmwJwU4TzYA5VEHYtPQIQuUoAidoJ3eO14B/7PRHTNWk sA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t29b0gxgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 05:19:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38C5JY25000952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 05:19:34 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 11 Sep 2023 22:19:32 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Aditya Kumar Singh" <quic_adisi@quicinc.com>
Subject: [PATCH v2 3/3] wifi: ath11k: fix Tx power value during active CAC
Date:   Tue, 12 Sep 2023 10:48:57 +0530
Message-ID: <20230912051857.2284-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230912051857.2284-1-quic_adisi@quicinc.com>
References: <20230912051857.2284-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qfBgaOcHubHXFXkakQxOiveQKtNnORoV
X-Proofpoint-ORIG-GUID: qfBgaOcHubHXFXkakQxOiveQKtNnORoV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120044
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tx power is fetched from firmware's pdev stats. However, during active
CAC, firmware does not fill the current Tx power and sends the max
initialised value filled during firmware init. If host sends this power
to user space, this is wrong since in certain situations, the Tx power
could be greater than the max allowed by the regulatory. Hence, host
should not be fetching the Tx power during an active CAC.

Fix this issue by returning Tx power as 0 during active CAC since it
is known that during CAC, there will be no transmission happening.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Fixes: 9a2aa68afe3d ("wifi: ath11k: add get_txpower mac ops")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6b5f032197ff..a36698688f89 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9045,6 +9045,14 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	if (ar->state != ATH11K_STATE_ON)
 		goto err_fallback;
 
+	/* Firmware doesn't provide Tx power during CAC hence no need to fetch
+	 * the stats.
+	 */
+	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
+		mutex_unlock(&ar->conf_mutex);
+		return -EAGAIN;
+	}
+
 	req_param.pdev_id = ar->pdev->pdev_id;
 	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
 
-- 
2.17.1


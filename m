Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22995ED76A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 10:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiI1IPr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiI1IOl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 04:14:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F80B7DA
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 01:14:38 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S5rR3A005343;
        Wed, 28 Sep 2022 08:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=StiZYGpC39uRTAXR4wo0W9GBWDRHwvdH+Rd8rUztDBk=;
 b=mm6IOD/uiH9WGFqMlSqIP5engSZq7N/CpZXnvyYqsl3c9j8MKvIyTDpuXv+g3xoAP5GL
 5JeCX0cgtUANG5e65Erfyx8+6xYsSIjuNYRMt7kZV4b72by4qyjIRJrgexVjyfpubugk
 1ys0CzzHh6ylxRww0P77OC/DCHqZ5RJLmLxuuWHcPjhn+WE1mfaxtlnpZNiSNZY1HCJ1
 7yCyJmrorHLf2IVGx1VrfBbO6a+YLA+xpdnCu0wjiPtYjVypQNwHe4aADdnV9dC+u5qY
 Mnzmw9YRPI6mHTHKA80SYfqBiLyVuIQl1OMvFilrYhSAN+MjjDn+kPsRWyaIBmD3G/5P vA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juvnnk8ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 08:14:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28S8EX4f005086
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 08:14:33 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 01:14:31 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 1/2] wifi: ath11k: change to set 11d state instead of start 11d scan while disconnect
Date:   Wed, 28 Sep 2022 04:14:12 -0400
Message-ID: <20220928081413.27339-2-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220928081413.27339-1-quic_wgong@quicinc.com>
References: <20220928081413.27339-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s1zjpZVPWAYZkRLEwSN9CL4fRj_YraWh
X-Proofpoint-GUID: s1zjpZVPWAYZkRLEwSN9CL4fRj_YraWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_03,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When switch to connect to a new AP for station which is already connected
to an AP, the time cost is too long, it arrives 10 seconds.

The reason is when switch connection, disconnect operation happened on
the 1st AP, then 11d scan start command sent to firmware, and then a
new hw scan arrived for the 2nd AP. The 11d scan is running at this
moment, so the hw scan can not start immediately, it needs to wait
the 11d scan finished, it increased the time cost of switch AP and
even happened scan fail as log below after apply the incoming patch.

[ 1194.815104] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
[ 1196.864157] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
[ 1198.911926] ath11k_pci 0000:06:00.0: failed to start hw scan: -110

Change to set 11d state while disconnect, and the 11d scan will be
started after the new hw scan in ath11k_mac_op_hw_scan(). Then the
time cost of switching AP is small and not happened scan fail.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Fixes: 9dcf6808b253 ("ath11k: add 11d scan offload support")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4218211afa30..b0c3cf258d12 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7190,8 +7190,12 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				    ret);
 	}
 
-	if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
-		ath11k_mac_11d_scan_start(ar, arvif->vdev_id);
+	if (arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    ar->state_11d != ATH11K_11D_PREPARING &&
+	    test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ab->wmi_ab.svc_map)) {
+		reinit_completion(&ar->completed_11d_scan);
+		ar->state_11d = ATH11K_11D_PREPARING;
+	}
 
 	mutex_unlock(&ar->conf_mutex);
 }
-- 
2.31.1


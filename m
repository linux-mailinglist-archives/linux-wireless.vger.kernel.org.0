Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4775FAD66
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 09:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJKHY7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 03:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJKHY4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 03:24:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D4F140D9
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 00:24:55 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B5GFsl000553;
        Tue, 11 Oct 2022 07:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=StiZYGpC39uRTAXR4wo0W9GBWDRHwvdH+Rd8rUztDBk=;
 b=PbdhXSROkBMozUnkyW5Vai0rzZa/lj1KSxiIEhXDfat9H/0Vo3sAudDQKFcqqw8IkU8m
 xNjQ2hhA6Bnrfx0nnVfGjpyW50cHKIgBQVOIYXLYwbwpKYI09ySya4GaUl3KEs26dbxw
 l6tKr1/C/4yo+HFe72joyN7i9ly2xWFReFj4E3qiEZ3vzSAlXYm4s3UKLXQbN9yGGcuX
 OK6DoI2UAGOoePMBzTTxnMJGBboes3Fpjz0VPvUawizJy86X74E+UN4Yh5hDm39uhBdx
 TXIq31heIQ9WFujiDGnrBeP4Vjtsqs2yZDMETXHs8OfSWtncvhQ5p6mheBelotEh1mfu fA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rwy1eyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 07:24:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29B7OiHH002439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 07:24:44 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 11 Oct 2022 00:24:42 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 1/2] wifi: ath11k: change to set 11d state instead of start 11d scan while disconnect
Date:   Tue, 11 Oct 2022 03:24:07 -0400
Message-ID: <20221011072408.23731-2-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221011072408.23731-1-quic_wgong@quicinc.com>
References: <20221011072408.23731-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9-eOLE8nf8NVNZMxk9eqMgmi5-UtaXG1
X-Proofpoint-GUID: 9-eOLE8nf8NVNZMxk9eqMgmi5-UtaXG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_03,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210110040
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


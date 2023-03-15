Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C86BB978
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 17:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjCOQT1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjCOQTI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 12:19:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C856197B67
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 09:18:40 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FALhJe022463;
        Wed, 15 Mar 2023 16:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=a5vkh8KYRT/AQdnIOeB7EMtU7n//se/Q0SSCfpqy7W0=;
 b=Y72DYTzkNZV5fonCFqvgF7YiBdKXimBRtHlmW7gn0nNeWvbUqovJ0d5RkDvJ1/Ozl8LI
 k5Bp4rC9RdKyfJOqCtEsAWYp1uYWZSP7CfnF3HLyNIRuXJHyTFCb8fZDfwd1vcu6unGB
 7t3RT6Ql/8Ml2rBc0AwPG+x1ld68F7Vcj1W0vTog8b7lUR1Bf3I/1+aQnii4Yn8nJBUX
 t3UBNgDaAEzm9IUe9e3kjEBitEGa3vmoG+778Kug4u3AB2aAfLhsP6BnBY/a1XdX6wRy
 7LsQLD95QiQwh9P0KuvKeQDwt/iyd6UiHZbM8fYN2OI4UgnI79/uNwZ9gjnNGTXkb2cz tw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c8a7a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 16:18:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FGIaZE009300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 16:18:36 GMT
Received: from hu-mpubbise-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 09:18:34 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] wifi: ath11k: Send 11d scan start before WMI_START_SCAN_CMDID
Date:   Wed, 15 Mar 2023 21:48:17 +0530
Message-ID: <20230315161817.29627-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OivbBqcXioSxEGtBxRh5VbpCo_b-XWyR
X-Proofpoint-ORIG-GUID: OivbBqcXioSxEGtBxRh5VbpCo_b-XWyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150137
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmwares advertising the support of triggering 11d algorithm on the
scan results of a regular scan expects driver to send
WMI_11D_SCAN_START_CMDID before sending WMI_START_SCAN_CMDID.
Triggering 11d algorithm on the scan results of a normal scan helps
in completely avoiding a separate 11d scan for determining regdomain.
This indirectly helps in speeding up connections on station
interfaces on the chipsets supporting 11D scan.

To enable this feature, send WMI_11D_SCAN_START_CMDID just before
sending WMI_START_SCAN_CMDID if the firmware advertises
WMI_TLV_SERVICE_SUPPORT_11D_FOR_HOST_SCAN service flag.

WCN6750 & WCN6855 supports this feature.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01160-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 12 ++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cad832e0e6b8..be2e17b641d1 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3755,6 +3755,18 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	int i;
 	u32 scan_timeout;
 
+	/* Firmwares advertising the support of triggering 11D algorithm
+	 * on the scan results of a regular scan expects driver to send
+	 * WMI_11D_SCAN_START_CMDID before sending WMI_START_SCAN_CMDID.
+	 * With this feature, separate 11D scan can be avoided since
+	 * regdomain can be determined with the scan results of the
+	 * regular scan.
+	 */
+	if (ar->state_11d == ATH11K_11D_PREPARING &&
+	    test_bit(WMI_TLV_SERVICE_SUPPORT_11D_FOR_HOST_SCAN,
+		     ar->ab->wmi_ab.svc_map))
+		ath11k_mac_11d_scan_start(ar, arvif->vdev_id);
+
 	mutex_lock(&ar->conf_mutex);
 
 	spin_lock_bh(&ar->data_lock);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b23b7a22bc9a..21589d8efcc7 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2102,6 +2102,7 @@ enum wmi_tlv_service {
 	WMI_MAX_EXT_SERVICE = 256,
 	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
 	WMI_TLV_SERVICE_BIOS_SAR_SUPPORT = 326,
+	WMI_TLV_SERVICE_SUPPORT_11D_FOR_HOST_SCAN = 357,
 
 	/* The third 128 bits */
 	WMI_MAX_EXT2_SERVICE = 384

base-commit: 3df3715e556027e94246b2cb30986563362a65f4
-- 
2.17.1


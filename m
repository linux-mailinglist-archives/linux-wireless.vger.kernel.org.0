Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4E979E568
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbjIMKzi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 06:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbjIMKzh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 06:55:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB6A19A6
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 03:55:32 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DAm8uH013152;
        Wed, 13 Sep 2023 10:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=0bwTGBbzQicYxM/c77x057Ze1tOUa280ERQDHTB8L0Q=;
 b=poD+cC/Et5NptM1kRSgqRAJmjlrM2ak1ja6BVyUkVk+1h5LkDLrs+CDG69hAw7zZa/Ko
 TgO/Tfi7Tm0J9I+GB/wFt9wp0Um/lxGFyDReaBgv/1H5fi50JgWSqJPilULtfnoyVPe3
 W1R5jWdMSKb20WqCNzwq9ZZPKt9wsnJbktGZAIBPCgkOhzB8AYYT+AOjueQ3p4n/0SsU
 ZUjZXoWOtfY3jFK32InaItItykUnC2F3UrT+Cewg0rIlfuwyZZkFiLhH3JNBUhEpmhoV
 ZhVzOEQZCSg2gi5vcKE1IIyvt/N1PYHtRX7ywhLufBsIDQ2/0/8Q6bmjo0KRMGSX18Wa Uw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y8q1bhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:55:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38DAtOIq008292
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:55:24 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 13 Sep 2023 03:55:22 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath12k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN7850
Date:   Wed, 13 Sep 2023 06:55:07 -0400
Message-ID: <20230913105507.17675-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KFhVsWMywy5hW2G8n4rJVvmrZ886Q7DG
X-Proofpoint-GUID: KFhVsWMywy5hW2G8n4rJVvmrZ886Q7DG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=757 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130086
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently mac80211 will send 3 scan request for each scan of WCN7850, they
are 2.4 GHz/5 GHz/6 GHz band scan. Firmware of WCN7850 will cache the RNR
IE(Reduced Neighbor Report element) which exist in the beacon of 2.4 GHz/5
GHz of the AP which is co-located with 6 GHz, and then use the cache to
scan in 6 GHz band scan if the 6 GHz scan is in the same scan with the 2.4
GHz/5 GHz band, this will helpful to search more AP of 6 GHz. Also it will
decrease the time cost of scan because firmware will use dual-band scan
for the 2.4 GHz/5 GHz, it means the 2.4 GHz and 5 GHz scans are doing
simultaneously.

Set the flag IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN7850 since it
supports 2.4 GHz/5 GHz/6 GHz in a single wiphy/ieee80211_hw.

This does not impact QCN9274, because it is not single_phy, so does not
have 2.4 GHz/5 GHz/6 GHz in the same wiphy, then it does not match the
condition and then IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS will not set for
QCN9274.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0f2af2f14ef7..d4dc03dc8d11 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7232,6 +7232,11 @@ static int __ath12k_mac_register(struct ath12k *ar)
 
 	ar->hw->wiphy->interface_modes = ab->hw_params->interface_modes;
 
+	if (ar->hw->wiphy->bands[NL80211_BAND_2GHZ] &&
+	    ar->hw->wiphy->bands[NL80211_BAND_5GHZ] &&
+	    ar->hw->wiphy->bands[NL80211_BAND_6GHZ])
+		ieee80211_hw_set(ar->hw, SINGLE_SCAN_ON_ALL_BANDS);
+
 	ieee80211_hw_set(ar->hw, SIGNAL_DBM);
 	ieee80211_hw_set(ar->hw, SUPPORTS_PS);
 	ieee80211_hw_set(ar->hw, SUPPORTS_DYNAMIC_PS);

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1


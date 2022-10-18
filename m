Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23F56034EF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 23:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJRV3A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiJRV25 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 17:28:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F5B7EE8
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 14:28:52 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IJw2F6030521;
        Tue, 18 Oct 2022 21:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=nFwYoFGcuP4gBRQQdSvjjbJhraC9dkCXwB/Emq0bBvY=;
 b=BlgrIOD7ZqZA5nVrLDiG7HXFIEiyXcvTUvh4D7qmrkteDJadbpVug7iTHPD7u8u1e7sA
 MqY1h9xRjhONbZDyJ/+3af1omEOXCHKOoUlFd3talmt1BmYlToQ5BkubcjVC30QXVDbF
 U/7j0jul+RNxpzEcZ37pRU9dg30iEAS1X3ULBBCOS3USkNZWpCN+qULmvt6Ebc9Jq5e6
 nRG43M4iiC4ANtc2KM0na87P5S4/6ZevoiZVjGuTvsTxQ8nxJhbuaqAGhNoe3Yn4TjLz
 NO0G4SsJInK1rCoOCbTGxbU3cN46EdPWZOAL7YqPDaEgHqaz8ynwi9QrvywgjaN0Uqsk tw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9n2p3148-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 21:28:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29ILSm3q018842
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 21:28:48 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 18 Oct 2022 14:28:48 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v2 4/4] wifi: ath11k: generate rx and tx mcs maps for supported HE mcs
Date:   Tue, 18 Oct 2022 14:28:21 -0700
Message-ID: <1666128501-12364-5-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
References: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UeWo84Eopu6WCvW-LWGC7XNb_bw94NB1
X-Proofpoint-GUID: UeWo84Eopu6WCvW-LWGC7XNb_bw94NB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180120
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Generate rx and tx mcs maps in ath11k_mac_set_hemcsmap() and set them
in supported mcs/nss for HE capabilities.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00356-QCAHKSWPL_SILICONZ-1

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 56335e47939b..11d6dcac74fd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5464,20 +5464,36 @@ static void ath11k_mac_set_hemcsmap(struct ath11k *ar,
 				    struct ieee80211_sta_he_cap *he_cap,
 				    int band)
 {
-	struct ath11k_band_cap *band_cap = &cap->band[band];
+	u16 txmcs_map, rxmcs_map;
+	u32 i;
 
+	rxmcs_map = 0;
+	txmcs_map = 0;
+	for (i = 0; i < 8; i++) {
+		if (i < ar->num_tx_chains &&
+		    (ar->cfg_tx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))
+			txmcs_map |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
+		else
+			txmcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
+
+		if (i < ar->num_rx_chains &&
+		    (ar->cfg_rx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))
+			rxmcs_map |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
+		else
+			rxmcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
+	}
 	he_cap->he_mcs_nss_supp.rx_mcs_80 =
-		cpu_to_le16(band_cap->he_mcs & 0xffff);
+		cpu_to_le16(rxmcs_map & 0xffff);
 	he_cap->he_mcs_nss_supp.tx_mcs_80 =
-		cpu_to_le16(band_cap->he_mcs & 0xffff);
+		cpu_to_le16(txmcs_map & 0xffff);
 	he_cap->he_mcs_nss_supp.rx_mcs_160 =
-		cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+		cpu_to_le16(rxmcs_map & 0xffff);
 	he_cap->he_mcs_nss_supp.tx_mcs_160 =
-		cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+		cpu_to_le16(txmcs_map & 0xffff);
 	he_cap->he_mcs_nss_supp.rx_mcs_80p80 =
-		cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+		cpu_to_le16(rxmcs_map & 0xffff);
 	he_cap->he_mcs_nss_supp.tx_mcs_80p80 =
-		cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+		cpu_to_le16(txmcs_map & 0xffff);
 }
 
 static int ath11k_mac_copy_he_cap(struct ath11k *ar,
-- 
2.7.4


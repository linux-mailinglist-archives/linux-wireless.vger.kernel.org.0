Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC9E5FCABF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 20:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJLShK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJLShH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 14:37:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19E72ECB
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 11:37:06 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CI4KQk003210;
        Wed, 12 Oct 2022 18:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=afAjwPb82p+I7X56ClS+IfEVa5ChNF4VT+6LxdnBFeM=;
 b=Ww7+aB8x5oM33qNN1ksc5bYQD8DV1HdttUBLbbhGYV2es+WbSkVPgogRaLTNbk8wDtHv
 ozxiXSDEWjKj4YrKrlk3F2XTTG9quNM75eKoWVxFD6xFTx1nZTtwGJswVk6QjBdhQpty
 qqXGLUJqspXkLEm9rggDfF/Ix6DHVD1q8jRcrD+Q2fKxkba9JkOTnStLX5V0FWbVI647
 rR+bkeqRhwEwuVghkNaJOpUA+vmBpP1aSvrJir5SyWfRuEzCQAFH6vKF8cq3SJ9Sf5o2
 HfRy2T6QGI3tAVNRL03iGx1v7Kc017r/t9fE5ECKtTVmCaj3CrXhwFjx4xDW3ompImAF OQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5xtf0p5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 18:37:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29CIaxAC021444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 18:36:59 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 12 Oct 2022 11:36:59 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 4/4] wifi: ath11k: generate rx and tx mcs maps for supported HE mcs
Date:   Wed, 12 Oct 2022 11:36:47 -0700
Message-ID: <1665599807-12908-5-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665599807-12908-1-git-send-email-quic_msinada@quicinc.com>
References: <1665599807-12908-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oa1nxg03_iiNLoJEg1ZIuuzg85YWC50P
X-Proofpoint-ORIG-GUID: oa1nxg03_iiNLoJEg1ZIuuzg85YWC50P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120120
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
index cf827c68af72..ba668994372c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5463,20 +5463,36 @@ static void ath11k_mac_set_hemcsmap(struct ath11k *ar,
 				    struct ath11k_pdev_cap *cap,
 				    struct ieee80211_sta_he_cap *he_cap)
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


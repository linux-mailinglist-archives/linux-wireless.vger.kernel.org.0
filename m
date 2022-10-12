Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4615FCABD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 20:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJLShI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 14:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiJLShG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 14:37:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CD973333
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 11:37:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CGmFme017200;
        Wed, 12 Oct 2022 18:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PfmdTfu+7hrtSTGCtwExBt+2rQN5x5FFX5NPsKkXV4A=;
 b=evFsRMTwpnAQckKpYfbPsgTwuvUMpC5cCeE7C7XH0n8XeGMPsKnyL9bZ2WVmZZ5FVXtv
 lqAMCro2a5N/p1AAivBMsWgd2zMNw1rnndmFrK9QkjgSj1YvSj+7qnqJCLNNftl5VWje
 x+z0fY5jzTGypaPF+3sUrJ33b5HKHrA4vz5Mm6hVCn2/xaILBR1vTGUGAW1qnlkSnabr
 vyMii1H7Uf7Sz+VbsSwlL3Cozn8I0Db9+gVuzRJg4NzDeadTh5O7V22RhwOe9k2b+knR
 0yP2u/L/ftp7vqI1t25TRQ+f7hNnHXdLwTvbsEeSHdRUTISkQpgLAGm0p6kUkzO5LHFv IA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5rtsj1mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 18:36:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29CIawkD026985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 18:36:58 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 12 Oct 2022 11:36:57 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 3/4] wifi: ath11k: move HE MCS mapper to a separate function
Date:   Wed, 12 Oct 2022 11:36:46 -0700
Message-ID: <1665599807-12908-4-git-send-email-quic_msinada@quicinc.com>
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
X-Proofpoint-GUID: 1t0oMk0SWcWMndHhROb2wWExd3p98MlO
X-Proofpoint-ORIG-GUID: 1t0oMk0SWcWMndHhROb2wWExd3p98MlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120120
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move HE MCS mapper to a separate function and call new function
in ath11k_mac_copy_he_cap().

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00356-QCAHKSWPL_SILICONZ-1

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3a2f3ffe253b..cf827c68af72 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5459,6 +5459,26 @@ static __le16 ath11k_mac_setup_he_6ghz_cap(struct ath11k_pdev_cap *pcap,
 	return cpu_to_le16(bcap->he_6ghz_capa);
 }
 
+static void ath11k_mac_set_hemcsmap(struct ath11k *ar,
+				    struct ath11k_pdev_cap *cap,
+				    struct ieee80211_sta_he_cap *he_cap)
+{
+	struct ath11k_band_cap *band_cap = &cap->band[band];
+
+	he_cap->he_mcs_nss_supp.rx_mcs_80 =
+		cpu_to_le16(band_cap->he_mcs & 0xffff);
+	he_cap->he_mcs_nss_supp.tx_mcs_80 =
+		cpu_to_le16(band_cap->he_mcs & 0xffff);
+	he_cap->he_mcs_nss_supp.rx_mcs_160 =
+		cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+	he_cap->he_mcs_nss_supp.tx_mcs_160 =
+		cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+	he_cap->he_mcs_nss_supp.rx_mcs_80p80 =
+		cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+	he_cap->he_mcs_nss_supp.tx_mcs_80p80 =
+		cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+}
+
 static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 				  struct ath11k_pdev_cap *cap,
 				  struct ieee80211_sband_iftype_data *data,
@@ -5520,18 +5540,7 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 			break;
 		}
 
-		he_cap->he_mcs_nss_supp.rx_mcs_80 =
-			cpu_to_le16(band_cap->he_mcs & 0xffff);
-		he_cap->he_mcs_nss_supp.tx_mcs_80 =
-			cpu_to_le16(band_cap->he_mcs & 0xffff);
-		he_cap->he_mcs_nss_supp.rx_mcs_160 =
-			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-		he_cap->he_mcs_nss_supp.tx_mcs_160 =
-			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-		he_cap->he_mcs_nss_supp.rx_mcs_80p80 =
-			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-		he_cap->he_mcs_nss_supp.tx_mcs_80p80 =
-			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+		ath11k_mac_set_hemcsmap(ar, cap, he_cap);
 
 		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 		if (he_cap_elem->phy_cap_info[6] &
-- 
2.7.4


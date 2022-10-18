Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21E6034ED
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 23:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJRV27 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 17:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJRV25 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 17:28:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D280B6033
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 14:28:49 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IHYFZJ017917;
        Tue, 18 Oct 2022 21:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JN2Ez6gQ/VNqgofyRH0gYCcE8+S1uzur+8LzMnY1lus=;
 b=SNM7I23SXZGc0r4XZu9UfNl7mQ77Uk1kfgtkNFsWIS+9AEimYhE/+3qMULGidqOW+9Yx
 HTA6znj7LDNVUDehzX4a8NbkojRo76xqPXXdLac7Jt76DWUiSw3kStTBwApA/2xiUCpk
 EIsXrpSTlDKEBTsdWUfzaDpCbLoBEOVip+4bud3UfjCG/ouPxvJce+1Ln+GbCgSUrdsr
 d50Az2a4mw2eGxGzlzQy3kGbMFCDW/XNkpno2Y1jKm88jyQa10HPBgL9DlbUB9oLlRZ8
 rEa3jXaBT/QyzOoSPeW2UWf0Tk3qSHLR/2QlgbH0pOBYZ2PhqWg7ynfUNd/3ocSJ1Ru+ Ag== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9bfg4ayk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 21:28:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29ILSjCl005073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 21:28:45 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 18 Oct 2022 14:28:44 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v2 3/4] wifi: ath11k: move HE MCS mapper to a separate function
Date:   Tue, 18 Oct 2022 14:28:20 -0700
Message-ID: <1666128501-12364-4-git-send-email-quic_msinada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: D0GWeXgBfA-TfKdSQjaMNqZPOKi7_HUq
X-Proofpoint-GUID: D0GWeXgBfA-TfKdSQjaMNqZPOKi7_HUq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210180120
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
 drivers/net/wireless/ath/ath11k/mac.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 83d4a565fe84..56335e47939b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5459,6 +5459,27 @@ static __le16 ath11k_mac_setup_he_6ghz_cap(struct ath11k_pdev_cap *pcap,
 	return cpu_to_le16(bcap->he_6ghz_capa);
 }
 
+static void ath11k_mac_set_hemcsmap(struct ath11k *ar,
+				    struct ath11k_pdev_cap *cap,
+				    struct ieee80211_sta_he_cap *he_cap,
+				    int band)
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
@@ -5520,18 +5541,7 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
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
+		ath11k_mac_set_hemcsmap(ar, cap, he_cap, band);
 
 		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 		if (he_cap_elem->phy_cap_info[6] &
-- 
2.7.4


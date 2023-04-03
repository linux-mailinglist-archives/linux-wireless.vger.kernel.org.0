Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93846D54E9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 00:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjDCWw1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 18:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjDCWwV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 18:52:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F78C4EDF
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 15:52:05 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333MFVrV027875;
        Mon, 3 Apr 2023 22:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=dam1V1sgoUS8yQqQv0vuXB372p4Zl0TtxoB6zEAwt8Y=;
 b=kuCok/hqr0T3/bwUjBnBaGZw6iJUJju7cw/RDOidmty+KhAciJFtEXSXNyjxB1h8Kz6W
 Ahis1mU95dBd2/WK32keJQfEUMeprUSC9BeQPa1YGbmXf89r44lz4RyEaKF7EUVoHf+I
 0ePKhjjTe9YbI+/YT658O/YPCSimGnMKv3PaT9qXseplczthEH4Q6TTV4hTs7eBMi33Z
 CHAkxCpzsDx0Q9nXQnX0itN+i6MQgETWcL3XPZcg6MG6sy8ne9F01xDaZAM3CQjTeLe5
 R6GuVNIUPZ01lGtFNt3wPRwlO7zCuO+T3yDvTrDm9m+fuQUXozy0MLVDFkrHqbHwzlGA /g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pr0kx14b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 22:51:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333Mpube012987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 22:51:56 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 15:51:55 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 01/11] wifi: ath12k: rename HE capabilities setup/copy functions
Date:   Mon, 3 Apr 2023 15:51:36 -0700
Message-ID: <20230403225146.14139-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230403225146.14139-1-quic_alokad@quicinc.com>
References: <20230403225146.14139-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gyDLSUt56J29wVTK_H2xgOcUVMsf2fmA
X-Proofpoint-ORIG-GUID: gyDLSUt56J29wVTK_H2xgOcUVMsf2fmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_17,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030180
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Functions ath12k_mac_setup_he_cap() and ath12k_mac_copy_he_cap()
propagate HE and 6GHz capabilities to the userspace using an instance
of struct ieee80211_sband_iftype_data. This structure now has a new
member 'eht_cap' to include EHT capabilities as well.
Rename the above mentioned functions to indicate that their use is not
limited to HE.

Also, replace the local variable 'band' with 'sband' and reuse
'band' for the type enum nl80211_band.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/mac.c | 58 ++++++++++++++-------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ee792822b411..ab718585411e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4206,10 +4206,10 @@ static __le16 ath12k_mac_setup_he_6ghz_cap(struct ath12k_pdev_cap *pcap,
 	return cpu_to_le16(bcap->he_6ghz_capa);
 }
 
-static int ath12k_mac_copy_he_cap(struct ath12k *ar,
-				  struct ath12k_pdev_cap *cap,
-				  struct ieee80211_sband_iftype_data *data,
-				  int band)
+static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
+					     struct ath12k_pdev_cap *cap,
+					     struct ieee80211_sband_iftype_data *data,
+					     int band)
 {
 	int i, idx = 0;
 
@@ -4294,38 +4294,42 @@ static int ath12k_mac_copy_he_cap(struct ath12k *ar,
 	return idx;
 }
 
-static void ath12k_mac_setup_he_cap(struct ath12k *ar,
-				    struct ath12k_pdev_cap *cap)
+static void ath12k_mac_setup_sband_iftype_data(struct ath12k *ar,
+					       struct ath12k_pdev_cap *cap)
 {
-	struct ieee80211_supported_band *band;
+	struct ieee80211_supported_band *sband;
+	enum nl80211_band band;
 	int count;
 
 	if (cap->supported_bands & WMI_HOST_WLAN_2G_CAP) {
-		count = ath12k_mac_copy_he_cap(ar, cap,
-					       ar->mac.iftype[NL80211_BAND_2GHZ],
-					       NL80211_BAND_2GHZ);
-		band = &ar->mac.sbands[NL80211_BAND_2GHZ];
-		band->iftype_data = ar->mac.iftype[NL80211_BAND_2GHZ];
-		band->n_iftype_data = count;
+		band = NL80211_BAND_2GHZ;
+		count = ath12k_mac_copy_sband_iftype_data(ar, cap,
+							  ar->mac.iftype[band],
+							  band);
+		sband = &ar->mac.sbands[band];
+		sband->iftype_data = ar->mac.iftype[band];
+		sband->n_iftype_data = count;
 	}
 
 	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP) {
-		count = ath12k_mac_copy_he_cap(ar, cap,
-					       ar->mac.iftype[NL80211_BAND_5GHZ],
-					       NL80211_BAND_5GHZ);
-		band = &ar->mac.sbands[NL80211_BAND_5GHZ];
-		band->iftype_data = ar->mac.iftype[NL80211_BAND_5GHZ];
-		band->n_iftype_data = count;
+		band = NL80211_BAND_5GHZ;
+		count = ath12k_mac_copy_sband_iftype_data(ar, cap,
+							  ar->mac.iftype[band],
+							  band);
+		sband = &ar->mac.sbands[band];
+		sband->iftype_data = ar->mac.iftype[band];
+		sband->n_iftype_data = count;
 	}
 
 	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP &&
 	    ar->supports_6ghz) {
-		count = ath12k_mac_copy_he_cap(ar, cap,
-					       ar->mac.iftype[NL80211_BAND_6GHZ],
-					       NL80211_BAND_6GHZ);
-		band = &ar->mac.sbands[NL80211_BAND_6GHZ];
-		band->iftype_data = ar->mac.iftype[NL80211_BAND_6GHZ];
-		band->n_iftype_data = count;
+		band = NL80211_BAND_6GHZ;
+		count = ath12k_mac_copy_sband_iftype_data(ar, cap,
+							  ar->mac.iftype[band],
+							  band);
+		sband = &ar->mac.sbands[band];
+		sband->iftype_data = ar->mac.iftype[band];
+		sband->n_iftype_data = count;
 	}
 }
 
@@ -4370,7 +4374,7 @@ static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
 
 	/* Reload HT/VHT/HE capability */
 	ath12k_mac_setup_ht_vht_cap(ar, &ar->pdev->cap, NULL);
-	ath12k_mac_setup_he_cap(ar, &ar->pdev->cap);
+	ath12k_mac_setup_sband_iftype_data(ar, &ar->pdev->cap);
 
 	return 0;
 }
@@ -6830,7 +6834,7 @@ static int __ath12k_mac_register(struct ath12k *ar)
 		goto err;
 
 	ath12k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
-	ath12k_mac_setup_he_cap(ar, cap);
+	ath12k_mac_setup_sband_iftype_data(ar, cap);
 
 	ret = ath12k_mac_setup_iface_combinations(ar);
 	if (ret) {
-- 
2.39.0


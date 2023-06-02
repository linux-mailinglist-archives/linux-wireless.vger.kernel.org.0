Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C8720C6D
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jun 2023 01:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbjFBX6m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 19:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbjFBX6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 19:58:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485851A6
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 16:58:40 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352NuoES015745;
        Fri, 2 Jun 2023 23:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=RWkQDBHrzl5vO9wpY57yXRunF2g+LgDPmFvUK4rfOhA=;
 b=evI++TBwbzcBz+lfS/dmLiblPrlY0hg7xH949O+R5LcWCMXSKMQaCGu/LPU1jjuFRRkw
 VW1AvJCNW9IHJRLECyj8Nb993Jq5ZqRwCBQsQkNOzS0PNMrD9Ky42nLIzxvzJJTX86sO
 e5UTP3iYj5TIZ24vhKXGjdRWA1VQw5wv9lmItyCPgYYWKPR63Rd4ygtJvo8MqkBCf5aL
 SBJLvnal+Wn2myjS90u7hJP01Og5XkMEseZXsAi14aPiPyCAUOZ9zrN6vHBrU28u0lZQ
 3B8i8W5zylqztuhe9rqE6ChlJrjJbf4ukde91hE9O3Zgk9R2DYIM1PkJmupEcEKnB6Tq pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qydr5hq11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 23:58:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 352NwZ7r003794
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 23:58:35 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 16:58:35 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v4 01/11] wifi: ath12k: rename HE capabilities setup/copy functions
Date:   Fri, 2 Jun 2023 16:58:10 -0700
Message-ID: <20230602235820.23912-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230602235820.23912-1-quic_alokad@quicinc.com>
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ykKEeNpvhlOHA3fDP1RZU7LgoOhnB-_N
X-Proofpoint-GUID: ykKEeNpvhlOHA3fDP1RZU7LgoOhnB-_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_18,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
v4: No change from v3.
v3: No change from v2.
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/mac.c | 58 ++++++++++++++-------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d814d74bc168..ddc293ebbd75 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4209,10 +4209,10 @@ static __le16 ath12k_mac_setup_he_6ghz_cap(struct ath12k_pdev_cap *pcap,
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
 
@@ -4297,38 +4297,42 @@ static int ath12k_mac_copy_he_cap(struct ath12k *ar,
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
 
@@ -4373,7 +4377,7 @@ static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
 
 	/* Reload HT/VHT/HE capability */
 	ath12k_mac_setup_ht_vht_cap(ar, &ar->pdev->cap, NULL);
-	ath12k_mac_setup_he_cap(ar, &ar->pdev->cap);
+	ath12k_mac_setup_sband_iftype_data(ar, &ar->pdev->cap);
 
 	return 0;
 }
@@ -6854,7 +6858,7 @@ static int __ath12k_mac_register(struct ath12k *ar)
 		goto err;
 
 	ath12k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
-	ath12k_mac_setup_he_cap(ar, cap);
+	ath12k_mac_setup_sband_iftype_data(ar, cap);
 
 	ret = ath12k_mac_setup_iface_combinations(ar);
 	if (ret) {
-- 
2.39.0


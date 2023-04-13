Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2AA6E16B4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 23:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDMVwR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 17:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDMVwQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 17:52:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F7340EE
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 14:52:14 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DLiOZe029208;
        Thu, 13 Apr 2023 21:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=13iIKRTS5b54Najj66TgBwUZthlla38qA4EUqQn0nAs=;
 b=j39FvKHp3GAgGewykPogUVb8UYqhuGyVqttxGrA2gT1Zurl2YiAeo+hyg3fCMftBG/tN
 sm3iuEmPOuMOuu2eI53V5vDrb/s1EVv5svEyhwaNJyGHuEv3EqHrLrVCXWkmVFZg12ag
 RJWNjz4TsxmMQeWX5pYcTx9NFCFU843HL1oqIVeXvWa+GVQRo/Aso4cMhqobzOtQ/Moy
 aApJytymmvTMcorhCxWMHHTVRmcO4NCvFGzFhQRkpLV31c1TKBIMi1frCpeNqdnnHN8S
 WPJfkDJ63QQqHAqQXImKlXOzG+/37Mp2wkK9aljFS9hz47co5ByxI2xX6rSqvOb+4Bry Zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxbx5swjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 21:52:09 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33DLq81X008596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 21:52:08 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 14:52:07 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v3 01/11] wifi: ath12k: rename HE capabilities setup/copy functions
Date:   Thu, 13 Apr 2023 14:51:46 -0700
Message-ID: <20230413215156.2649-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230413215156.2649-1-quic_alokad@quicinc.com>
References: <20230413215156.2649-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NIIPu9SYf2I8gD-Nl4lz_iJaH_Wvgsd0
X-Proofpoint-GUID: NIIPu9SYf2I8gD-Nl4lz_iJaH_Wvgsd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_16,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v3: No change from v2.
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

base-commit: 177555b57ca0a0519c12a2bdb64309ddbb363e11
-- 
2.39.0


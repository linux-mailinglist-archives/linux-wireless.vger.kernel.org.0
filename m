Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4A6CF6B3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 01:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjC2XMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 19:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjC2XMF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 19:12:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E174C13
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 16:12:02 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TKjJ47022290;
        Wed, 29 Mar 2023 23:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7jCGq5ZhlnNy7oJAcPpLu/e4p1pdYHFZwWCsLIhTWx0=;
 b=Fa4B1s8YiQN9TrYbsVs2+YK2FpLehnIyp5a4Ng2Z5acr6DZf+kZ9dOoqNiPmvaQ8bSH5
 +tMN4pXc5p7kqh0pzZl2wl39qyY0RkCGAef/QE0UaHSQXg9gBpdjTRhsIsXVYMqb548X
 brgep7TEvTEmzZyznvrwf5UbM/M0wzqQhsMNduQr0GhYJ6VK/we40BJAayGAmUvSo0Xa
 82+Pt8J1sbDNSV1uINWYXftHx3zfocLgwUCmu4tsI1qGlGkV6yKOuJX9U0tA6qgNF609
 +nzYxf7AMsT01lB1OqHhB2smX735O4CzalexmVb7kd9hoyI1NT0PfVOj83hINXXL0rMp 5w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmq959bb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 23:11:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32TNBwPC027608
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 23:11:58 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 29 Mar 2023 16:11:57 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 01/11] wifi: ath12k: rename HE capabilities setup/copy functions
Date:   Wed, 29 Mar 2023 16:11:35 -0700
Message-ID: <20230329231145.20171-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230329231145.20171-1-quic_alokad@quicinc.com>
References: <20230329231145.20171-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xxYxVdghPIbI_5bUB2z2y8wIy-_6I5Wg
X-Proofpoint-ORIG-GUID: xxYxVdghPIbI_5bUB2z2y8wIy-_6I5Wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_14,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290173
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


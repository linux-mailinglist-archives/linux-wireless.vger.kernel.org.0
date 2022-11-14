Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BAF628A5C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 21:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbiKNUTi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 15:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiKNUTa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 15:19:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB7CBC9C
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 12:19:29 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEHeLDw004010;
        Mon, 14 Nov 2022 20:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=LBimLlXDVayBjj4Wsb5KvfVKjuOlAWNnsdkC6HBOwk0=;
 b=JUzwE7T9/sazPV9fTL1AjkAz9DB5gojUSMq2s9eXqxLnD5TNFaQfV4BjTYT1tJjcJ+ap
 aNS6GQxOdZbCmNwiDxvh8hn0EWLVsHy9XBj0yv7vwsGXnWop5wpoYQMzwirmi4Gn7I86
 c6aBIttoVw6dSJnwdAYrXtizUr+di3JHP5J0bZEzNJujItxiPTxn0roud1dIB2LYEgil
 Zi3S11DojvV50hVDBPdoHyAaG4gC1ecJ9GUd9bdAQJxu/04DC0FptBXUVISUAcoPLKuI
 6wnswCozQXZ+0/8qPDDgKVAl2qldqDKQAw1Q52+H9APQHmBeUjnXWNB8h7WrIh8tDTN1 dA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kut98rdap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEKJPHD025246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:25 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 12:19:24 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 10/10] ath11k: configure WPA and RSN parameters for nontransmitting interface
Date:   Mon, 14 Nov 2022 12:19:12 -0800
Message-ID: <20221114201912.22893-11-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114201912.22893-1-quic_alokad@quicinc.com>
References: <20221114201912.22893-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sLgl25usnDZEY5yi0bxRf9uLN-B_sroT
X-Proofpoint-ORIG-GUID: sLgl25usnDZEY5yi0bxRf9uLN-B_sroT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set rsnie_present and wpaie_present fields for the non-transmitting
interfaces when MBSSID is enabled.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 99 ++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a47f24ba767e..766c0cbb4e64 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1376,6 +1376,89 @@ static void ath11k_mac_setup_bcn_tmpl_vif_params(struct ath11k_vif *arvif,
 		arvif->wpaie_present = false;
 }
 
+static void ath11k_mac_setup_bcn_tmpl_nontx_vif_rsnie(struct ath11k_vif *arvif,
+						      bool tx_arvif_rsnie_present,
+						      const u8 *profile,
+						      u8 profile_len)
+{
+	if (cfg80211_find_ie(WLAN_EID_RSN, profile, profile_len)) {
+		arvif->rsnie_present = true;
+	} else if (tx_arvif_rsnie_present) {
+		int i;
+		u8 nie_len;
+		const u8 *nie = cfg80211_find_ext_ie(WLAN_EID_EXT_NON_INHERITANCE,
+						     profile, profile_len);
+		if (!nie)
+			return;
+
+		nie_len = nie[1];
+		nie += 2;
+		for (i = 0; i < nie_len; i++) {
+			if (nie[i] == WLAN_EID_RSN) {
+				arvif->rsnie_present = false;
+				break;
+			}
+		}
+	}
+}
+
+static bool ath11k_mac_setup_bcn_tmpl_nontx_vif_params(struct ath11k_vif *tx_arvif,
+						       struct ath11k_vif *arvif,
+						       struct sk_buff *bcn)
+{
+	struct ieee80211_mgmt *mgmt;
+	const u8 *ies, *profile, *next_profile;
+	int ies_len;
+
+	if (arvif == tx_arvif)
+		return true;
+
+	arvif->rsnie_present = tx_arvif->rsnie_present;
+
+	ies = bcn->data + ieee80211_get_hdrlen_from_skb(bcn);
+	mgmt = (struct ieee80211_mgmt *)bcn->data;
+	ies += sizeof(mgmt->u.beacon);
+	ies_len = skb_tail_pointer(bcn) - ies;
+
+	ies = cfg80211_find_ie(WLAN_EID_MULTIPLE_BSSID, ies, ies_len);
+
+	while (ies) {
+		u8 mbssid_len;
+
+		ies_len -= (2 + ies[1]);
+		mbssid_len = ies[1] - 1;
+		profile = &ies[3];
+
+		while (mbssid_len) {
+			u8 profile_len;
+
+			profile_len = profile[1];
+			next_profile = profile + (2 + profile_len);
+			mbssid_len -= (2 + profile_len);
+
+			profile += 2;
+			profile_len -= (2 + profile[1]);
+			profile += (2 + profile[1]); /* nontx capabilities */
+			profile_len -= (2 + profile[1]);
+			profile += (2 + profile[1]); /* SSID */
+			if (profile[2] == arvif->vif->bss_conf.bssid_index) {
+				profile_len -= 5;
+				profile = profile + 5;
+				ath11k_mac_setup_bcn_tmpl_nontx_vif_rsnie(arvif,
+									  tx_arvif->rsnie_present,
+									  profile,
+									  profile_len);
+				return true;
+			}
+			profile = next_profile;
+		}
+		ies = cfg80211_find_ie(WLAN_EID_MULTIPLE_BSSID, profile,
+				       ies_len);
+	}
+
+	return false;
+}
+
 static int __ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif,
 				       struct sk_buff *bcn,
 				       struct ieee80211_mutable_offsets offs,
@@ -1402,6 +1485,7 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 	struct ieee80211_ema_beacons *beacons;
 	u8 i = 0;
 	int ret = 0;
+	bool found_vdev = false;
 
 	if (!arvif->vif->mbssid_tx_vif)
 		return -1;
@@ -1415,11 +1499,21 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 		return -EPERM;
 	}
 
-	if (tx_arvif == arvif)
+	if (tx_arvif == arvif) {
 		ath11k_mac_setup_bcn_tmpl_vif_params(tx_arvif,
 						     beacons->bcn[0].skb);
+		found_vdev = true;
+	} else {
+		arvif->wpaie_present = tx_arvif->wpaie_present;
+	}
 
 	for (i = 0; i < beacons->cnt; i++) {
+		if (!found_vdev)
+			found_vdev =
+				ath11k_mac_setup_bcn_tmpl_nontx_vif_params(tx_arvif,
+									   arvif,
+									   beacons->bcn[i].skb);
+
 		ret = __ath11k_mac_setup_bcn_tmpl(tx_arvif, beacons->bcn[i].skb,
 						  beacons->bcn[i].offs,
 						  i, beacons->cnt);
@@ -1455,6 +1549,9 @@ static int ath11k_mac_setup_bcn_tmpl_non_ema(struct ath11k_vif *arvif)
 
 	if (tx_arvif == arvif)
 		ath11k_mac_setup_bcn_tmpl_vif_params(tx_arvif, bcn);
+	else
+		(void)ath11k_mac_setup_bcn_tmpl_nontx_vif_params(tx_arvif,
+								 arvif, bcn);
 
 	ret = __ath11k_mac_setup_bcn_tmpl(tx_arvif, bcn, offs, 0, 0);
 	if (ret)
-- 
2.17.1


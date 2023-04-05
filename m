Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE416D8A74
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 00:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjDEWRJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 18:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjDEWRI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 18:17:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A4B59DA
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 15:17:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335MAfsE015969;
        Wed, 5 Apr 2023 22:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=um5EGkcw2CgtiSi18U1NlpdztWBskNaEKEBYO/sV9j4=;
 b=h556WPU0U3H7SzjT3Y7q6Uz1wIcLJecWfDenAPo0TLVLvVe+M4fVB8G5geyTw/LpGOuC
 n8GP0ehtS9LQsJOatSBLvOJSKRNcH49PjRQRO9d+NjWbmdDamqIcM0mMYNw3NQraGlap
 g/4q8u2jKhvMzDpvOjNhq0fZd/l0GQI5NWLsP4zI+Id6QVRtlGR26An3HTrWgC4ULiN/
 cOm6FNKYF1wNbvwtRPxfFMM6gZb9yMm0v0Ry3gWSDQ3u11ABU79AJzg/NvBmHrf+IIZ5
 YNq671sC9/47CVnyUiBVOk+dkKgyhI9XYaFH03KKk5TfpeS0wKwAMDcmd8prdhcntE1J Ww== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prpg23sf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 22:16:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335MGw2m002081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 22:16:58 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 15:16:58 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 5/7] wifi: ath11k: refactor vif parameter configurations
Date:   Wed, 5 Apr 2023 15:16:46 -0700
Message-ID: <20230405221648.17950-6-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230405221648.17950-1-quic_alokad@quicinc.com>
References: <20230405221648.17950-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iKfbudPUzVZKqVtuS391pe1MkMAF4aVr
X-Proofpoint-ORIG-GUID: iKfbudPUzVZKqVtuS391pe1MkMAF4aVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050199
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Security parameters for each non-transmitting profile can be
different when MBSSID is enabled and this information is included
in the MBSSID element in the Beacon frame. Current implementation
to set rsnie_present and wpaie_present does not parse this element
hence it applies only to the transmitting interface.

Move the code to a separate function to make additions for
non-transmitting interfaces cleaner.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v3: Renamed ath11k_mac_setup_bcn_tmpl_vif_params(0 as
    ath11k_mac_set_vif_params() as the parameters are not actually
    set in the Beacon frame. MLO link ID change is not required
    anymore.

v2: Changed calls to mac80211 APIs to include MLO link ID.

 drivers/net/wireless/ath/ath11k/mac.c | 41 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 87f21a3f0ac6..a10f4a6a1120 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1351,28 +1351,14 @@ static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 	return ret;
 }
 
-static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
+static void ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
+				      struct sk_buff *bcn)
 {
-	struct ath11k *ar = arvif->ar;
-	struct ath11k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ar->hw;
-	struct ieee80211_vif *vif = arvif->vif;
-	struct ieee80211_mutable_offsets offs = {};
-	struct sk_buff *bcn;
 	struct ieee80211_mgmt *mgmt;
 	u8 *ies;
-	int ret;
-
-	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
-		return 0;
-
-	bcn = ieee80211_beacon_get_template(hw, vif, &offs, 0);
-	if (!bcn) {
-		ath11k_warn(ab, "failed to get beacon template from mac80211\n");
-		return -EPERM;
-	}
 
 	ies = bcn->data + ieee80211_get_hdrlen_from_skb(bcn);
+	mgmt = (struct ieee80211_mgmt *)bcn->data;
 	ies += sizeof(mgmt->u.beacon);
 
 	if (cfg80211_find_ie(WLAN_EID_RSN, ies, (skb_tail_pointer(bcn) - ies)))
@@ -1386,7 +1372,28 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 		arvif->wpaie_present = true;
 	else
 		arvif->wpaie_present = false;
+}
+
+static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ath11k_base *ab = ar->ab;
+	struct ieee80211_hw *hw = ar->hw;
+	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_mutable_offsets offs = {};
+	struct sk_buff *bcn;
+	int ret;
+
+	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
+		return 0;
+
+	bcn = ieee80211_beacon_get_template(hw, vif, &offs, 0);
+	if (!bcn) {
+		ath11k_warn(ab, "failed to get beacon template from mac80211\n");
+		return -EPERM;
+	}
 
+	ath11k_mac_set_vif_params(arvif, bcn);
 	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
 
 	kfree_skb(bcn);
-- 
2.39.0


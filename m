Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189107C7E4C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 09:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjJMHAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 03:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjJMHAU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 03:00:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC4BC
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 00:00:18 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D6LH93024128;
        Fri, 13 Oct 2023 07:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ouXnxApDdR4+p0H7fw5hFs85+B8aTzTi2duLKiaEHuM=;
 b=VLOSyj4X4LxPCUmwb4+14mMj3GVJuFfACBAlaGj0JvAfgYKxpCb9Itv3qlmAJxrSf3mG
 fcjkHq8QATm/AgDLc2kIuuxIveqK/Z4/vP5XRlNerBdYJ8wvdL30P/U5mFpi/pDk+Lhj
 2CQ8T6X3xikZTBTlXP/5R0GnQRu8aUFuXNxr/O/O/LY6WdzvXxVHvU6pDEe+MoMvRBVY
 hKBoOStnuGG0zsmkWy9mE+wuof5XkweIW6WSD1yO1yvkyPm+vpABIN1Yg0hqxwfEVB15
 2OUv4hsrbzVy58+MzslxBvhfPB/3hDK0hts8ZgpF4FY1glsAV+BuyB9xG9myuI4MOqYA pQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt1u8vbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 07:00:13 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39D70AGN020105;
        Fri, 13 Oct 2023 07:00:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3tk0dkvxwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Oct 2023 07:00:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39D70Adl020089;
        Fri, 13 Oct 2023 07:00:10 GMT
Received: from rgnanase-linux.qualcomm.com (rgnanase-linux.qualcomm.com [10.201.162.135])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 39D70Asq020084;
        Fri, 13 Oct 2023 07:00:10 +0000
Received: by rgnanase-linux.qualcomm.com (Postfix, from userid 2378837)
        id 40EA21101FE4; Fri, 13 Oct 2023 12:30:09 +0530 (IST)
From:   Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: register EHT mesh capabilities
Date:   Fri, 13 Oct 2023 12:30:07 +0530
Message-Id: <20231013070007.25597-3-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231013070007.25597-1-quic_rgnanase@quicinc.com>
References: <20231013070007.25597-1-quic_rgnanase@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ifMuxOv3nE6klh3O99Medn6kcSHhJQrW
X-Proofpoint-ORIG-GUID: ifMuxOv3nE6klh3O99Medn6kcSHhJQrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130058
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The capabilities for the EHT mesh are generated from the capabilities
reported by the firmware. But the firmware only reports the overall
capabilities and not the one which are specific for mesh.

Capabilities which requires infrastructure setup with a main STA(AP)
controlling operations are not needed for mesh and hence remove these
capabilities from the list.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 59d8fff78e6d..aebbb762dcfb 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4554,6 +4554,48 @@ static void ath12k_mac_copy_eht_ppe_thresh(struct ath12k_wmi_ppe_threshold_arg *
 	}
 }
 
+static void
+ath12k_mac_filter_eht_cap_mesh(struct ieee80211_eht_cap_elem_fixed
+			       *eht_cap_elem)
+{
+	u8 m;
+
+	m = IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS;
+	eht_cap_elem->mac_cap_info[0] &= ~m;
+
+	m = IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO;
+	eht_cap_elem->phy_cap_info[0] &= ~m;
+
+	m = IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
+	    IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
+	    IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
+	    IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK;
+	eht_cap_elem->phy_cap_info[3] &= ~m;
+
+	m = IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO |
+	    IEEE80211_EHT_PHY_CAP4_PSR_SR_SUPP |
+	    IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP |
+	    IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI;
+	eht_cap_elem->phy_cap_info[4] &= ~m;
+
+	m = IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
+	    IEEE80211_EHT_PHY_CAP5_TX_LESS_242_TONE_RU_SUPP |
+	    IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP |
+	    IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK;
+	eht_cap_elem->phy_cap_info[5] &= ~m;
+
+	m = IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK;
+	eht_cap_elem->phy_cap_info[6] &= ~m;
+
+	m = IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
+	    IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
+	    IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ |
+	    IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
+	    IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ |
+	    IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;
+	eht_cap_elem->phy_cap_info[7] &= ~m;
+}
+
 static void ath12k_mac_copy_eht_cap(struct ath12k *ar,
 				    struct ath12k_band_cap *band_cap,
 				    struct ieee80211_he_cap_elem *he_cap_elem,
@@ -4592,6 +4634,9 @@ static void ath12k_mac_copy_eht_cap(struct ath12k *ar,
 			  IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ |
 			  IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ);
 		break;
+	case NL80211_IFTYPE_MESH_POINT:
+		ath12k_mac_filter_eht_cap_mesh(eht_cap_elem);
+		break;
 	default:
 		break;
 	}
-- 
2.17.1


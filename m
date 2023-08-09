Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702597756C7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjHIKBs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 06:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjHIKBr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 06:01:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7701BFA
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 03:01:45 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37990WSO019997;
        Wed, 9 Aug 2023 10:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=vI1aY3JzQww22/wS+uU5xHrAvFK1ei7tQ9BLwzT2GZg=;
 b=nH6kp7HUL/GwQnTz6j0i5V3iWTX+qXhGy356T8qS+MRzzqLb0BbmcTalzB7GVbYq7q5R
 xd/msWdgswk6kjrnmWeV8cKjm+lb9V2qTQBOOfUY9vX6ZeUrApHJUB/UbevwpxLkSBBh
 GBlIwXQ0ybE4wQffrm86edSRaI4YltgYxIpBsR8Z5XfP2KS+QZifXwxR4S7bPPYORpad
 DstXms1ZSptfPbpJsrMe9KobyZtbDdbULE6ahHCYG5kwyU91IWX3QENvNAlojVfR67YU
 4W6w4FgSmVUnc5ND/CkOhTahoBVDhYLGjMfEfGoMYF9F1BOiuMOao2oapsCPI9aL9Suy aA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbpqs27rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 10:01:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379A1c4u029319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 10:01:38 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 03:01:37 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band in EHT PHY capbility for WCN7850
Date:   Wed, 9 Aug 2023 06:01:24 -0400
Message-ID: <20230809100124.14732-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1prMQt1mh-ejlcCsvoXczmPBm6LMUkP8
X-Proofpoint-ORIG-GUID: 1prMQt1mh-ejlcCsvoXczmPBm6LMUkP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_09,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=932 malwarescore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

320 MHz bandwidth is reported only for single PHY mode for WCN7850, get it
from WMI_HOST_HW_MODE_SINGLE ath12k_wmi_caps_ext_params and report it for
6 GHz band.

After this patch, "iw list" show 320MHz support for WCN7850:
EHT Iftypes: managed
        EHT PHY Capabilities: (0xe26f090010768800):
                320MHz in 6GHz Supported
        EHT bw=320 MHz, max NSS for MCS 8-9: Rx=0, Tx=0
        EHT bw=320 MHz, max NSS for MCS 10-11: Rx=0, Tx=0
        EHT bw=320 MHz, max NSS for MCS 12-13: Rx=0, Tx=0

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 9ed33e2d6da0..8b6f11fce884 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4148,7 +4148,11 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 				       __le32 cap_info_internal)
 {
 	struct ath12k_band_cap *cap_band = &pdev->cap.band[band];
-	u8 i;
+	u8 i, support_320mhz;
+
+	if (band == NL80211_BAND_6GHZ)
+		support_320mhz = cap_band->eht_cap_phy_info[0] &
+					IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 
 	for (i = 0; i < WMI_MAX_EHTCAP_MAC_SIZE; i++)
 		cap_band->eht_cap_mac_info[i] = le32_to_cpu(cap_mac_info[i]);
@@ -4156,6 +4160,9 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
 		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
 
+	if (band == NL80211_BAND_6GHZ)
+		cap_band->eht_cap_phy_info[0] |= support_320mhz;
+
 	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
 	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);
 	if (band != NL80211_BAND_2GHZ) {
@@ -4177,10 +4184,20 @@ ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
 				      const struct ath12k_wmi_caps_ext_params *caps,
 				      struct ath12k_pdev *pdev)
 {
+	struct ath12k_band_cap *cap_band;
 	u32 bands;
 	int i;
+	u8 support_320mhz;
 
 	if (ab->hw_params->single_pdev_only) {
+		if (caps->hw_mode_id == WMI_HOST_HW_MODE_SINGLE) {
+			support_320mhz = caps->eht_cap_phy_info_5G[0] &
+				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+			cap_band = &pdev->cap.band[NL80211_BAND_6GHZ];
+			cap_band->eht_cap_phy_info[0] |= support_320mhz;
+			return 0;
+		}
+
 		for (i = 0; i < ab->fw_pdev_count; i++) {
 			struct ath12k_fw_pdev *fw_pdev = &ab->fw_pdev[i];
 
@@ -4236,7 +4253,8 @@ static int ath12k_wmi_tlv_mac_phy_caps_ext(struct ath12k_base *ab, u16 tag,
 		return -EPROTO;
 
 	if (ab->hw_params->single_pdev_only) {
-		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id))
+		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id) &&
+		    caps->hw_mode_id != WMI_HOST_HW_MODE_SINGLE)
 			return 0;
 	} else {
 		for (i = 0; i < ab->num_radios; i++) {

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1


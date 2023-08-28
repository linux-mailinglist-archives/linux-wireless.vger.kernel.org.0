Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3806278A4E0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 06:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjH1EFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 00:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjH1EEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 00:04:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAF129
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 21:04:40 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S2Ft3t032171;
        Mon, 28 Aug 2023 04:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=TQZJduRiEPKORw7CY1DYbG/gkyyeEliGePL7Ijut9XQ=;
 b=OsLs39ByhFQfOpH1r2wVSApecaNcyjNgo66ooztMfChbCZhIfRaK/j14KITaLsy4smeB
 ipDe//J5tJi3jZCW1M86lzZTYG9HctSiPKDJGvFyJ1NelmZsdI1wKJS0QSYREEzMTR4o
 pUsVRjA+jWKoVEk91+YPZ/SdlCgpWe7LY2wN7BSlJmMJUpmQIHU4oVeBkrLz91I/f84a
 P+mGcUxFki/N1/1284PAITJk7GMvOjo1KC2O4f10pPCn8H8MvMg/gFhqnNPwBWEhOYO7
 ltZw0/JWP4nRvAlf+XQPQgaLcWv9ukMaOcI4h7QSC4mR53AX/OSqvMaZnXEjZkdWVtr8 0g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq6ruaqce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 04:04:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37S44Ya6016276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 04:04:34 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 27 Aug 2023 21:04:33 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3] wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band in EHT PHY capability for WCN7850
Date:   Mon, 28 Aug 2023 00:04:20 -0400
Message-ID: <20230828040420.2165-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uiFrn0f3hQc9ftXvADkUxs8f7A0mQ45b
X-Proofpoint-GUID: uiFrn0f3hQc9ftXvADkUxs8f7A0mQ45b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-27_22,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v3:
   1. fix "wmi.c:4199:69: warning: restricted __le32 degrades to integer"
   2. s/capbility/capability/
   3. change "u8 support_320mhz" to "u32 support_320mhz"

v2: change eht_cap_phy_info_5G to eht_cap_phy_info_5ghz.

 drivers/net/wireless/ath/ath12k/wmi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 9ed33e2d6da0..5f46259cfa2a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4148,14 +4148,22 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 				       __le32 cap_info_internal)
 {
 	struct ath12k_band_cap *cap_band = &pdev->cap.band[band];
+	u32 support_320mhz;
 	u8 i;
 
+	if (band == NL80211_BAND_6GHZ)
+		support_320mhz = cap_band->eht_cap_phy_info[0] &
+					IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+
 	for (i = 0; i < WMI_MAX_EHTCAP_MAC_SIZE; i++)
 		cap_band->eht_cap_mac_info[i] = le32_to_cpu(cap_mac_info[i]);
 
 	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
 		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
 
+	if (band == NL80211_BAND_6GHZ)
+		cap_band->eht_cap_phy_info[0] |= support_320mhz;
+
 	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
 	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);
 	if (band != NL80211_BAND_2GHZ) {
@@ -4177,10 +4185,19 @@ ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
 				      const struct ath12k_wmi_caps_ext_params *caps,
 				      struct ath12k_pdev *pdev)
 {
-	u32 bands;
+	struct ath12k_band_cap *cap_band;
+	u32 bands, support_320mhz;
 	int i;
 
 	if (ab->hw_params->single_pdev_only) {
+		if (caps->hw_mode_id == WMI_HOST_HW_MODE_SINGLE) {
+			support_320mhz = le32_to_cpu(caps->eht_cap_phy_info_5ghz[0]) &
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


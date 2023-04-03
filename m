Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014526D54F0
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 00:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjDCWwe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 18:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjDCWwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 18:52:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23653ABC
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 15:52:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333IxxFj031153;
        Mon, 3 Apr 2023 22:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7sRYry0YmbPhdc52m9rfjRTSrXk6lugcoW3SVa68DDE=;
 b=BtuVBczOBQOCtJ5etjuc+N7y1xPmgXTHEP0PASfTv8bEu4iR8JjAYc9ELh1ZIXe+e8xO
 sUJoRfjPNp8LVS3V3dXfnDQ/F2BKEvaYvZt46LxEPIwP3GqwrLHIOcSdca0T+z1DzvxO
 J82TmvdLHxZ99ugFvtVBhfUrae49mM7IkGa6Rhr+8yDKaATBZWFbh4SZBceUbJszcGl9
 9TTD/hM/6MhdHykBpbyDLcskaC1sGmLJ0TiUkXRsPPMtjgFU17b6vFXZACPRTlGKDVCi
 zLjkROcU1xbzKZKxK60RXAE6X02HoBOi617vJY+XR3RgfHHAqlg1n32mlznYBpX5lpUe VA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pr4jm8dy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 22:51:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333Mpvpu031901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 22:51:57 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 15:51:56 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH v2 03/11] wifi: ath12k: process EHT capabilities
Date:   Mon, 3 Apr 2023 15:51:38 -0700
Message-ID: <20230403225146.14139-4-quic_alokad@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PIjryekb9qLTF4dz-iOB00BkVhH_cdK4
X-Proofpoint-GUID: PIjryekb9qLTF4dz-iOB00BkVhH_cdK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_17,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030180
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add WMI support to process the EHT capabilities passed by the firmware.
Add required EHT specific definitions in structures ath12k_band_cap and
ath12k_wmi_svc_rdy_ext_parse.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
v2: Changed 'target' to 'firmware' in the description.

 drivers/net/wireless/ath/ath12k/core.h |   8 ++
 drivers/net/wireless/ath/ath12k/wmi.c  | 112 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  38 +++++++++
 3 files changed, 158 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 9439052a652e..ed21dd78a2b9 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -579,6 +579,14 @@ struct ath12k_band_cap {
 	u32 he_cap_phy_info[PSOC_HOST_MAX_PHY_SIZE];
 	struct ath12k_wmi_ppe_threshold_arg he_ppet;
 	u16 he_6ghz_capa;
+	u32 eht_cap_mac_info[WMI_MAX_EHTCAP_MAC_SIZE];
+	u32 eht_cap_phy_info[WMI_MAX_EHTCAP_PHY_SIZE];
+	u32 eht_mcs_20_only;
+	u32 eht_mcs_80;
+	u32 eht_mcs_160;
+	u32 eht_mcs_320;
+	struct ath12k_wmi_ppe_threshold_arg eht_ppet;
+	u32 eht_cap_info_internal;
 };
 
 struct ath12k_pdev_cap {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7ae0bb78b2b5..89c3bf759bd4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -65,6 +65,8 @@ struct ath12k_wmi_svc_rdy_ext_parse {
 struct ath12k_wmi_svc_rdy_ext2_parse {
 	struct ath12k_wmi_dma_ring_caps_parse dma_caps_parse;
 	bool dma_ring_cap_done;
+	bool spectral_bin_scaling_done;
+	bool mac_phy_caps_ext_done;
 };
 
 struct ath12k_wmi_rdy_parse {
@@ -4034,6 +4036,100 @@ static int ath12k_service_ready_ext_event(struct ath12k_base *ab,
 	return ret;
 }
 
+static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
+				      __le32 cap_mac_info[],
+				      __le32 cap_phy_info[],
+				      __le32 supp_mcs[],
+				      struct ath12k_wmi_ppe_threshold_params *ppet,
+				       __le32 cap_info_internal)
+{
+	struct ath12k_band_cap *cap_band = &pdev->cap.band[band];
+	u8 i;
+
+	for (i = 0; i < WMI_MAX_EHTCAP_MAC_SIZE; i++)
+		cap_band->eht_cap_mac_info[i] = le32_to_cpu(cap_mac_info[i]);
+
+	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
+		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
+
+	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
+	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);
+	if (band != NL80211_BAND_2GHZ) {
+		cap_band->eht_mcs_160 = le32_to_cpu(supp_mcs[2]);
+		cap_band->eht_mcs_320 = le32_to_cpu(supp_mcs[3]);
+	}
+
+	cap_band->eht_ppet.numss_m1 = le32_to_cpu(ppet->numss_m1);
+	cap_band->eht_ppet.ru_bit_mask = le32_to_cpu(ppet->ru_info);
+	for (i = 0; i < WMI_MAX_NUM_SS; i++)
+		cap_band->eht_ppet.ppet16_ppet8_ru3_ru0[i] =
+			le32_to_cpu(ppet->ppet16_ppet8_ru3_ru0[i]);
+
+	cap_band->eht_cap_info_internal = le32_to_cpu(cap_info_internal);
+}
+
+static int ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
+						 struct ath12k_wmi_mac_phy_caps_ext_params *caps,
+						 struct ath12k_pdev *pdev)
+{
+	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
+		ath12k_wmi_eht_caps_parse(pdev, NL80211_BAND_2GHZ,
+					  caps->eht_cap_mac_info_2ghz,
+					  caps->eht_cap_phy_info_2ghz,
+					  caps->eht_supp_mcs_ext_2ghz,
+					  &caps->eht_ppet_2ghz,
+					  caps->eht_cap_info_internal);
+	}
+
+	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP) {
+		ath12k_wmi_eht_caps_parse(pdev, NL80211_BAND_5GHZ,
+					  caps->eht_cap_mac_info_5ghz,
+					  caps->eht_cap_phy_info_5ghz,
+					  caps->eht_supp_mcs_ext_5ghz,
+					  &caps->eht_ppet_5ghz,
+					  caps->eht_cap_info_internal);
+
+		ath12k_wmi_eht_caps_parse(pdev, NL80211_BAND_6GHZ,
+					  caps->eht_cap_mac_info_5ghz,
+					  caps->eht_cap_phy_info_5ghz,
+					  caps->eht_supp_mcs_ext_5ghz,
+					  &caps->eht_ppet_5ghz,
+					  caps->eht_cap_info_internal);
+	}
+
+	return 0;
+}
+
+static int ath12k_wmi_tlv_mac_phy_caps_ext(struct ath12k_base *ab, u16 tag,
+					   u16 len, const void *ptr,
+					   void *data)
+{
+	struct ath12k_wmi_mac_phy_caps_ext_params *caps =
+			(struct ath12k_wmi_mac_phy_caps_ext_params *)ptr;
+	int i, ret;
+
+	if (tag != WMI_TAG_MAC_PHY_CAPABILITIES_EXT)
+		return -EPROTO;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		if (ab->pdevs[i].pdev_id == le32_to_cpu(caps->pdev_id))
+			break;
+	}
+
+	if (i == ab->num_radios)
+		return -EINVAL;
+
+	ret = ath12k_wmi_tlv_mac_phy_caps_ext_parse(ab, caps, &ab->pdevs[i]);
+	if (ret) {
+		ath12k_warn(ab,
+			    "failed to extract mac phy caps ext, pdev_id:%d\n",
+			    ab->pdevs[i].pdev_id);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int ath12k_wmi_svc_rdy_ext2_parse(struct ath12k_base *ab,
 					 u16 tag, u16 len,
 					 const void *ptr, void *data)
@@ -4050,6 +4146,22 @@ static int ath12k_wmi_svc_rdy_ext2_parse(struct ath12k_base *ab,
 				return ret;
 
 			parse->dma_ring_cap_done = true;
+		} else if (!parse->spectral_bin_scaling_done) {
+			/* TODO: This is a place-holder as WMI tag for
+			 * spectral scaling is before
+			 * WMI_TAG_MAC_PHY_CAPABILITIES_EXT
+			 */
+			parse->spectral_bin_scaling_done = true;
+		} else if (!parse->mac_phy_caps_ext_done) {
+			ret = ath12k_wmi_tlv_iter(ab, ptr, len,
+						  ath12k_wmi_tlv_mac_phy_caps_ext,
+						  parse);
+			if (ret) {
+				ath12k_warn(ab, "failed to parse tlv %d\n", ret);
+				return ret;
+			}
+
+			parse->mac_phy_caps_ext_done = true;
 		}
 		break;
 	default:
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 08a8c9e0f59f..fa513a24bca4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2577,6 +2577,44 @@ struct ath12k_wmi_soc_hal_reg_caps_params {
 	__le32 num_phy;
 } __packed;
 
+#define WMI_MAX_EHTCAP_MAC_SIZE  2
+#define WMI_MAX_EHTCAP_PHY_SIZE  3
+
+/* Used for EHT MCS-NSS array. Data at each array index follows the format given
+ * in IEEE P802.11be/D2.0, May 20229.4.2.313.4.
+ *
+ * Index interpretation:
+ * 0 - 20 MHz only sta, all 4 bytes valid
+ * 1 - index for bandwidths <= 80 MHz except 20 MHz-only, first 3 bytes valid
+ * 2 - index for 160 MHz, first 3 bytes valid
+ * 3 - index for 320 MHz, first 3 bytes valid
+ */
+#define WMI_MAX_EHT_SUPP_MCS_2G_SIZE  2
+#define WMI_MAX_EHT_SUPP_MCS_5G_SIZE  4
+
+struct ath12k_wmi_mac_phy_caps_ext_params {
+	__le32 hw_mode_id;
+	union {
+		struct {
+			__le16 pdev_id;
+			__le16 hw_link_id;
+		} __packed ath12k_wmi_pdev_to_link_map;
+		__le32 pdev_id;
+	};
+	__le32 phy_id;
+	__le32 wireless_modes_ext;
+	__le32 eht_cap_mac_info_2ghz[WMI_MAX_EHTCAP_MAC_SIZE];
+	__le32 eht_cap_mac_info_5ghz[WMI_MAX_EHTCAP_MAC_SIZE];
+	__le32 rsvd0[2];
+	__le32 eht_cap_phy_info_2ghz[WMI_MAX_EHTCAP_PHY_SIZE];
+	__le32 eht_cap_phy_info_5ghz[WMI_MAX_EHTCAP_PHY_SIZE];
+	struct ath12k_wmi_ppe_threshold_params eht_ppet_2ghz;
+	struct ath12k_wmi_ppe_threshold_params eht_ppet_5ghz;
+	__le32 eht_cap_info_internal;
+	__le32 eht_supp_mcs_ext_2ghz[WMI_MAX_EHT_SUPP_MCS_2G_SIZE];
+	__le32 eht_supp_mcs_ext_5ghz[WMI_MAX_EHT_SUPP_MCS_5G_SIZE];
+} __packed;
+
 /* 2 word representation of MAC addr */
 struct ath12k_wmi_mac_addr_params {
 	u8 addr[ETH_ALEN];
-- 
2.39.0


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0A720C72
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jun 2023 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbjFBX6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 19:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbjFBX6n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 19:58:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DEDE48
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 16:58:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352NsBVV009863;
        Fri, 2 Jun 2023 23:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+Jp6CjYWpDm4RRgzV9BndqHYBJdPMYs9ff7UTCVfsbk=;
 b=EaQHqh6JLMzAG7vfL52LA3PzQHp+YUqSk2Jg7lTrjRnUEe0sToj0zu674LvbBjbOZ540
 V2iGfuRlgRrqBst85NchDmz2I0nvZirR0fdFvzRGVJQ91nuTbvpQckapy/vD9kR8QgFn
 VfNVgsyuzJwyU5IPtyS0LGf8Kcn32vCt5zcdii6T5tItF2QgauUsvLbkoKVopWWktYnP
 mN/Ga+slBHynDbh6/nRErvMBk+bW88OVBBKtmhYv4RHqAHui2VcZGPf2NNWX3gZBEyIV
 MUCu2M+X9oLIC9VX8zEHfyUBJJkEIPy5yt2IAHzZfiZqowKk21XxuDI3OStmWnRZh6KA Eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyhb9177t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 23:58:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 352NwacO022981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 23:58:36 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 16:58:35 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH v4 03/11] wifi: ath12k: WMI support to process EHT capabilities
Date:   Fri, 2 Jun 2023 16:58:12 -0700
Message-ID: <20230602235820.23912-4-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: D_jxZrHUdTRPmkF0i7KV-WlGeASHEw8k
X-Proofpoint-ORIG-GUID: D_jxZrHUdTRPmkF0i7KV-WlGeASHEw8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_18,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add WMI support to process the EHT capabilities passed by
the firmware. Add required EHT specific definitions in
structures ath12k_band_cap and ath12k_wmi_svc_rdy_ext_parse.

For single_pdev chip such as WCN7850, only one pdev is created
and only one hardware is registered to mac80211. This one pdev
manages both 2.4 GHz radio and 5 GHz/6 GHz radio.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Co-developed-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v4: Add support for WCN7850.
v3: No change from v2.
v2: Changed 'target' to 'firmware' in the description.

 drivers/net/wireless/ath/ath12k/core.h |  16 +++
 drivers/net/wireless/ath/ath12k/wmi.c  | 147 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  38 +++++++
 3 files changed, 201 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 2f93296db792..df762cabacc2 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -580,6 +580,14 @@ struct ath12k_band_cap {
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
@@ -638,6 +646,12 @@ struct ath12k_soc_dp_stats {
 	struct ath12k_soc_dp_tx_err_stats tx_err;
 };
 
+struct ath12k_fw_pdev {
+	u32 pdev_id;
+	u32 phy_id;
+	u32 supported_bands;
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath12k_base {
 	enum ath12k_hw_rev hw_rev;
@@ -670,6 +684,8 @@ struct ath12k_base {
 	/* Protects data like peers */
 	spinlock_t base_lock;
 	struct ath12k_pdev pdevs[MAX_RADIOS];
+	struct ath12k_fw_pdev fw_pdev[MAX_RADIOS];
+	u8 fw_pdev_count;
 	struct ath12k_pdev __rcu *pdevs_active[MAX_RADIOS];
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg hal_reg_cap[MAX_RADIOS];
 	unsigned long long free_vdev_map;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 6512267ae4ca..7b82e7240594 100644
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
@@ -445,8 +447,10 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 	const struct ath12k_wmi_soc_mac_phy_hw_mode_caps_params *hw_caps = svc->hw_caps;
 	const struct ath12k_wmi_hw_mode_cap_params *wmi_hw_mode_caps = svc->hw_mode_caps;
 	const struct ath12k_wmi_mac_phy_caps_params *wmi_mac_phy_caps = svc->mac_phy_caps;
+	struct ath12k_base *ab = wmi_handle->wmi_ab->ab;
 	struct ath12k_band_cap *cap_band;
 	struct ath12k_pdev_cap *pdev_cap = &pdev->cap;
+	struct ath12k_fw_pdev *fw_pdev;
 	u32 phy_map;
 	u32 hw_idx, phy_idx = 0;
 	int i;
@@ -475,6 +479,12 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 	pdev_cap->supported_bands |= le32_to_cpu(mac_caps->supported_bands);
 	pdev_cap->ampdu_density = le32_to_cpu(mac_caps->ampdu_density);
 
+	fw_pdev = &ab->fw_pdev[ab->fw_pdev_count];
+	fw_pdev->supported_bands = le32_to_cpu(mac_caps->supported_bands);
+	fw_pdev->pdev_id = le32_to_cpu(mac_caps->pdev_id);
+	fw_pdev->phy_id = le32_to_cpu(mac_caps->phy_id);
+	ab->fw_pdev_count++;
+
 	/* Take non-zero tx/rx chainmask. If tx/rx chainmask differs from
 	 * band to band for a single radio, need to see how this should be
 	 * handled.
@@ -3811,6 +3821,7 @@ static int ath12k_wmi_ext_soc_hal_reg_caps_parse(struct ath12k_base *soc,
 
 	soc->num_radios = 0;
 	phy_id_map = le32_to_cpu(svc_rdy_ext->pref_hw_mode_caps.phy_id_map);
+	soc->fw_pdev_count = 0;
 
 	while (phy_id_map && soc->num_radios < MAX_RADIOS) {
 		ret = ath12k_pull_mac_phy_cap_svc_ready_ext(wmi_handle,
@@ -4038,6 +4049,126 @@ static int ath12k_service_ready_ext_event(struct ath12k_base *ab,
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
+static int
+ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
+				      struct ath12k_wmi_mac_phy_caps_ext_params *caps,
+				      struct ath12k_pdev *pdev)
+{
+	u32 bands;
+	int i;
+
+	if (ab->hw_params->single_pdev_only) {
+		for (i = 0; i < ab->fw_pdev_count; i++) {
+			struct ath12k_fw_pdev *fw_pdev = &ab->fw_pdev[i];
+
+			if (fw_pdev->pdev_id == le32_to_cpu(caps->pdev_id) &&
+			    fw_pdev->phy_id == le32_to_cpu(caps->phy_id)) {
+				bands = fw_pdev->supported_bands;
+				break;
+			}
+		}
+
+		if (i == ab->fw_pdev_count)
+			return -EINVAL;
+	} else {
+		bands = pdev->cap.supported_bands;
+	}
+
+	if (bands & WMI_HOST_WLAN_2G_CAP) {
+		ath12k_wmi_eht_caps_parse(pdev, NL80211_BAND_2GHZ,
+					  caps->eht_cap_mac_info_2ghz,
+					  caps->eht_cap_phy_info_2ghz,
+					  caps->eht_supp_mcs_ext_2ghz,
+					  &caps->eht_ppet_2ghz,
+					  caps->eht_cap_info_internal);
+	}
+
+	if (bands & WMI_HOST_WLAN_5G_CAP) {
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
+	int i = 0, ret;
+
+	if (tag != WMI_TAG_MAC_PHY_CAPABILITIES_EXT)
+		return -EPROTO;
+
+	if (ab->hw_params->single_pdev_only) {
+		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id))
+			return 0;
+	} else {
+		for (i = 0; i < ab->num_radios; i++) {
+			if (ab->pdevs[i].pdev_id == le32_to_cpu(caps->pdev_id))
+				break;
+		}
+
+		if (i == ab->num_radios)
+			return -EINVAL;
+	}
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
@@ -4054,6 +4185,22 @@ static int ath12k_wmi_svc_rdy_ext2_parse(struct ath12k_base *ab,
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
index d89c12bfb009..b722eab281c3 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2581,6 +2581,44 @@ struct ath12k_wmi_soc_hal_reg_caps_params {
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


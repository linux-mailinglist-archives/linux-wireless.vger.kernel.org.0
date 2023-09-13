Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA18379E582
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 12:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbjIMK6a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 06:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbjIMK61 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 06:58:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A2A19AF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 03:58:24 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DAortF021288;
        Wed, 13 Sep 2023 10:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=WWGlYP9LKvOM2Jl8FWf6PugIdBbRWijJpW88A5U0JH4=;
 b=FpG5bxVyOw8+BSsGn53c3BW3WHUm5ise99sGMHS0ZOScYnJ/iTmm7tSnFblgmH5rZjr+
 iY/hp/xJVB6R7iGzVppfUJ78v0UZTW505M6dNO2hJQ+sAabhfalgLiusIjOy6VUXuMbA
 iei3m5+MSIJmxAdBHYPF7pJVLgRXPooftItcjvjpaV6ea8nCmIDqIydT5OAdFwUblAxs
 +CfC37LxJ2Qaoxk15ReVwfbu6qEyJxjr3fJLJ/X5Dt4swVtWn4hEWq9VqJMJcOhUqLzG
 qrklfX7cysMTB4FxVSxUQrnVWVxOFK68W1G+L7OMkga4+MM2CbLXCjNDEVzRuQOKKe5Y BQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t314ch5s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:58:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38DAwHUc029244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:58:17 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 13 Sep 2023 03:58:15 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath12k: add keep backward compatibility of PHY mode to avoid firmware crash
Date:   Wed, 13 Sep 2023 06:57:57 -0400
Message-ID: <20230913105757.17744-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S_yRxIsxAuLTZBt8KSH9mfFw3zF-87QN
X-Proofpoint-ORIG-GUID: S_yRxIsxAuLTZBt8KSH9mfFw3zF-87QN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_04,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130086
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In a special WCN7855 firmware release the EHT (IEEE 802.11be) support has
been disabled for size reduction. Currently ath12k always enables EHT PHY
mode during vdev start but with the special firmware that will cause a
firmware crash during vdev start in firmware initialisation. This is
because the firmware will use the EHT mode to allocate resources but as
the EHT mode is not available in the firmware, there's an internal
conflict and the firmware will crash.

To fix the crash check the WMI_TLV_SERVICE_11BE flag to see if the firmware
supports EHT. If EHT is not supported downgrade the PHY mode to HE
(IEEE 802.11ax).

This does not impact QCN9274, because WMI_SERVICE_11BE is always enabled
for QCN9274, then eht_cap->has_eht will always set for it, and the logic
of this patch will not take effect and the PHY mode will not down grade
for it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 65 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h |  3 ++
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0f2af2f14ef7..c72a7028b4b3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4553,7 +4553,8 @@ static void ath12k_mac_copy_eht_ppe_thresh(struct ath12k_wmi_ppe_threshold_arg *
 	}
 }
 
-static void ath12k_mac_copy_eht_cap(struct ath12k_band_cap *band_cap,
+static void ath12k_mac_copy_eht_cap(struct ath12k *ar,
+				    struct ath12k_band_cap *band_cap,
 				    struct ieee80211_he_cap_elem *he_cap_elem,
 				    int iftype,
 				    struct ieee80211_sta_eht_cap *eht_cap)
@@ -4561,6 +4562,10 @@ static void ath12k_mac_copy_eht_cap(struct ath12k_band_cap *band_cap,
 	struct ieee80211_eht_cap_elem_fixed *eht_cap_elem = &eht_cap->eht_cap_elem;
 
 	memset(eht_cap, 0, sizeof(struct ieee80211_sta_eht_cap));
+
+	if (!(test_bit(WMI_TLV_SERVICE_11BE, ar->ab->wmi_ab.svc_map)))
+		return;
+
 	eht_cap->has_eht = true;
 	memcpy(eht_cap_elem->mac_cap_info, band_cap->eht_cap_mac_info,
 	       sizeof(eht_cap_elem->mac_cap_info));
@@ -4626,7 +4631,7 @@ static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
 			data[idx].he_6ghz_capa.capa =
 				ath12k_mac_setup_he_6ghz_cap(cap, band_cap);
 		}
-		ath12k_mac_copy_eht_cap(band_cap, &he_cap->he_cap_elem, i,
+		ath12k_mac_copy_eht_cap(ar, band_cap, &he_cap->he_cap_elem, i,
 					&data[idx].eht_cap);
 		idx++;
 	}
@@ -5789,6 +5794,59 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&ar->conf_mutex);
 }
 
+static enum wmi_phy_mode
+ath12k_mac_check_down_grade_phy_mode(struct ath12k *ar,
+				     enum wmi_phy_mode mode,
+				     enum nl80211_band band,
+				     enum nl80211_iftype type)
+{
+	struct ieee80211_sta_eht_cap *eht_cap;
+	enum wmi_phy_mode down_mode;
+
+	if (mode < MODE_11BE_EHT20)
+		return mode;
+
+	eht_cap = &ar->mac.iftype[band][type].eht_cap;
+	if (eht_cap->has_eht)
+		return mode;
+
+	switch (mode) {
+	case MODE_11BE_EHT20:
+		down_mode = MODE_11AX_HE20;
+		break;
+	case MODE_11BE_EHT40:
+		down_mode = MODE_11AX_HE40;
+		break;
+	case MODE_11BE_EHT80:
+		down_mode = MODE_11AX_HE80;
+		break;
+	case MODE_11BE_EHT80_80:
+		down_mode = MODE_11AX_HE80_80;
+		break;
+	case MODE_11BE_EHT160:
+	case MODE_11BE_EHT160_160:
+	case MODE_11BE_EHT320:
+		down_mode = MODE_11AX_HE160;
+		break;
+	case MODE_11BE_EHT20_2G:
+		down_mode = MODE_11AX_HE20_2G;
+		break;
+	case MODE_11BE_EHT40_2G:
+		down_mode = MODE_11AX_HE40_2G;
+		break;
+	default:
+		down_mode = mode;
+		break;
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac vdev start phymode %s downgrade to %s\n",
+		   ath12k_mac_phymode_str(mode),
+		   ath12k_mac_phymode_str(down_mode));
+
+	return down_mode;
+}
+
 static int
 ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 			      const struct cfg80211_chan_def *chandef,
@@ -5814,6 +5872,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	arg.band_center_freq2 = chandef->center_freq2;
 	arg.mode = ath12k_phymodes[chandef->chan->band][chandef->width];
 
+	arg.mode = ath12k_mac_check_down_grade_phy_mode(ar, arg.mode,
+							chandef->chan->band,
+							arvif->vif->type);
 	arg.min_power = 0;
 	arg.max_power = chandef->chan->max_power * 2;
 	arg.max_reg_power = chandef->chan->max_reg_power * 2;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 8c047a9623f9..d7ab8c3ff177 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2158,6 +2158,9 @@ enum wmi_tlv_service {
 	WMI_MAX_EXT_SERVICE = 256,
 
 	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
+
+	WMI_TLV_SERVICE_11BE = 289,
+
 	WMI_MAX_EXT2_SERVICE,
 };
 

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1


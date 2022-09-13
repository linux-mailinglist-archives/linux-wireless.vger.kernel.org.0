Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1765B673B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 07:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIMFQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 01:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiIMFQA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 01:16:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7BA4BD00
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 22:15:59 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D5EwAt003405;
        Tue, 13 Sep 2022 05:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=60bRtmFjNvT6LC3UYZQHBnguRZ1sGGjmPtz8GBAj30Q=;
 b=TpWI9ZsYtGItM1lIytnX2NGtB0t66dlZzJyWPsOyzWRc9WLNaD3RPI3HNMI1iNNgi9he
 EI7RFpOZQiMAfFTe+gl4V2FXgoAXj3SHpmkf0Zts9MnXXSHBs02mm/4eto0JeqqO9ZqV
 xQE7zCkodA2xuOMljpDL4NVGLifPAaNcrWxTTmW47Z3RZOB8qo9hyzS3nHK1AKWMxg00
 21ptKoXEwD/SrPwWiy1MGwU6876H2fg3uEtHvNj0KXZRX6rrQBhGkmIPIw5wbk5qrE/f
 0EtXi1nwTHxohAUCi6+IihL/lwXmkhDSLXYc6FzJBIjgPXG6B37lfGiIhzykamrK7SVv bA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk6ke4d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D5Fqm9003324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:52 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 22:15:51 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 13/15] wifi: ath11k: discard BSS_CHANGED_TXPOWER when EXT_TPC_REG_SUPPORT for 6 GHz
Date:   Tue, 13 Sep 2022 01:15:16 -0400
Message-ID: <20220913051518.23051-14-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220913051518.23051-1-quic_wgong@quicinc.com>
References: <20220913051518.23051-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A-SufkDTlzaXjBznatA2HP9clZ54A00A
X-Proofpoint-ORIG-GUID: A-SufkDTlzaXjBznatA2HP9clZ54A00A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When station is connected to a 6 GHz AP, it has 2 way to configure
the power limit to firmware. The first way is to send 2 wmi command
WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G to
firmware, the second way is to send WMI_VDEV_SET_TPC_POWER_CMDID to
firmware which include more parameters for power control.

When firmware support SERVICE_EXT_TPC_REG, it means firmware support
the second way for WMI_VDEV_SET_TPC_POWER_CMDID, then ath11k discard
BSS_CHANGED_TXPOWER flag from mac80211 which is used to the first way
for 6 GHz band in this patch and select the second way in the subsequent
patch.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hw.c  |  6 ++++++
 drivers/net/wireless/ath/ath11k/hw.h  |  1 +
 drivers/net/wireless/ath/ath11k/mac.c | 19 +++++++++++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 712818edb4ca..5734fbfc6db5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -812,6 +812,12 @@ bool ath11k_hw_supports_6g_cc_ext(struct ath11k *ar)
 	return ath11k_hw_supports_cc_ext(ar->ab) && ar->supports_6ghz;
 }
 
+bool ath11k_hw_supports_tpc_ext(struct ath11k *ar)
+{
+	return ath11k_hw_supports_6g_cc_ext(ar) &&
+	       test_bit(WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT, ar->ab->wmi_ab.svc_map);
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 969d29aaee6a..909ddd0fa187 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -279,6 +279,7 @@ static inline int ath11k_hw_mac_id_to_srng_id(struct ath11k_hw_params *hw,
 
 bool ath11k_hw_supports_cc_ext(struct ath11k_base *ab);
 bool ath11k_hw_supports_6g_cc_ext(struct ath11k *ar);
+bool ath11k_hw_supports_tpc_ext(struct ath11k *ar);
 
 struct ath11k_fw_ie {
 	__le32 id;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e1bdfe466bc7..54d7327265d6 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3078,6 +3078,16 @@ static int ath11k_mac_config_obss_pd(struct ath11k *ar,
 	return 0;
 }
 
+static bool ath11k_mac_supports_station_tpc(struct ath11k *ar,
+					    struct ath11k_vif *arvif,
+					    const struct cfg80211_chan_def *chandef)
+{
+	return ath11k_hw_supports_tpc_ext(ar) &&
+	       arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	       chandef->chan &&
+	       chandef->chan->band == NL80211_BAND_6GHZ;
+}
+
 static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
 					   struct ieee80211_bss_conf *info,
@@ -3268,8 +3278,13 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev_id %i txpower %d\n",
 			   arvif->vdev_id, info->txpower);
 
-		arvif->txpower = info->txpower;
-		ath11k_mac_txpower_recalc(ar);
+		if (ath11k_mac_supports_station_tpc(ar, arvif, &info->chandef)) {
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+				   "discard tx power, change to set TPC power\n");
+		} else {
+			arvif->txpower = info->txpower;
+			ath11k_mac_txpower_recalc(ar);
+		}
 	}
 
 	if (changed & BSS_CHANGED_PS &&
-- 
2.31.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF797F415D
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 10:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjKVJQZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 04:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjKVJQW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 04:16:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026710C3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 01:16:18 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM7hWJm028128;
        Wed, 22 Nov 2023 09:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gb75EOK8rVJs4xegmIRTFGCVlJNg/LupmB4CW1oYH4M=;
 b=l23ZwGAz6jqyMy7b7vHHT2a1TV2wFZ+cK8sfXhlTE1YnGIDQkOk4JNZqlsW5Mv051Bir
 CyavylDGERsHZ+x02pc5RuN+SQxBU6cI82gZ9SpWSFZ8EKM0H6t1ooi87WbDK5YEjpqf
 iz1j4DRLm34c+R0XVCLPSaVu1EX+PwIs8ZjkuCwH835KxJdVGgfUkQxX6POMTOQd/Oto
 1WsXBP1X1ivvTR25xL5qTXqCmIzPf6R8K6xBrJvDmbfBfn4IJpn51/turqseyqyGS9X7
 zdogABc1FTEkHzbcOPH0Tue9lrywjYFLisUPlVs6LX4KUp0MuHmXyyn4ndDZ9jb4BuuA lw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugvt2jt1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:16:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM9GFfk008100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:16:15 GMT
Received: from bqiang-Celadon-RN.lan (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 01:16:13 -0800
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v7 04/12] wifi: ath11k: update regulatory rules when interface added
Date:   Wed, 22 Nov 2023 17:15:45 +0800
Message-ID: <20231122091553.10837-5-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122091553.10837-1-quic_bqiang@quicinc.com>
References: <20231122091553.10837-1-quic_bqiang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rGiWpPqlUdvlVaP0GijPPldlB6koUqnm
X-Proofpoint-ORIG-GUID: rGiWpPqlUdvlVaP0GijPPldlB6koUqnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311220064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

There are two power types for 6 GHz regulatory, one is AP, another
is client.

When wlan boot up, WMI_REG_CHAN_LIST_CC_EXT_EVENTID is sent from
firmware at an early stage, the interface mode is not decided at
this point, then ath11k select reg rules of AP type as default.

After interface is created, it is exactly decided the interface
type such as AP/mesh point/station. Then ath11k need to update
reg rules to the exact power type matched to the interface type.

The client power type is used for station interface, and AP power
type is used for AP/mesh point interface.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v7:
 1. move ath11k_mac_supports_6ghz_cc_ext() to
    wmi.c and renamed as ath11k_wmi_supports_6ghz_cc_ext().

 drivers/net/wireless/ath/ath11k/mac.c | 8 ++++++++
 drivers/net/wireless/ath/ath11k/mac.h | 1 -
 drivers/net/wireless/ath/ath11k/wmi.c | 6 ++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 1 +
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7f7b39817773..1e314fcab41b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6943,6 +6943,14 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				    ret);
 	}
 
+	if (ath11k_wmi_supports_6ghz_cc_ext(ar)) {
+		struct cur_regulatory_info *reg_info;
+
+		reg_info = &ab->reg_info_store[ar->pdev_idx];
+		ath11k_dbg(ab, ATH11K_DBG_MAC, "mac interface added to change reg rules\n");
+		ath11k_reg_handle_chan_list(ab, reg_info, IEEE80211_REG_LPI_AP);
+	}
+
 	mutex_unlock(&ar->conf_mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index e4835e0b7998..b593574e6b09 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -155,7 +155,6 @@ struct ath11k_vif *ath11k_mac_get_arvif_by_vdev_id(struct ath11k_base *ab,
 u8 ath11k_mac_get_target_pdev_id(struct ath11k *ar);
 u8 ath11k_mac_get_target_pdev_id_from_vif(struct ath11k_vif *arvif);
 struct ath11k_vif *ath11k_mac_get_vif_up(struct ath11k_base *ab);
-
 struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, u32 vdev_id);
 struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id);
 void ath11k_mac_drain_tx(struct ath11k *ar);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 9798072d7e2b..8083313b00ca 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -9858,3 +9858,9 @@ int ath11k_wmi_sta_keepalive(struct ath11k *ar,
 
 	return ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
 }
+
+bool ath11k_wmi_supports_6ghz_cc_ext(struct ath11k *ar)
+{
+	return (test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
+			 ar->ab->wmi_ab.svc_map)) && ar->supports_6ghz;
+}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index a34a04bd4612..f77f309771a8 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -6510,4 +6510,5 @@ void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info);
 int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 				struct cur_regulatory_info *reg_info,
 				enum ieee80211_ap_reg_power power_type);
+bool ath11k_wmi_supports_6ghz_cc_ext(struct ath11k *ar);
 #endif
-- 
2.25.1


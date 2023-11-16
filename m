Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991D07EE927
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 23:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjKPWS7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 17:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPWS6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 17:18:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D23CB2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 14:18:55 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGHqqqn005198;
        Thu, 16 Nov 2023 22:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=lLLEvk3aAHaF+KUZc+r0/1G0CF84cj18Dyv+TSM4854=;
 b=J6uQ9/VSi5OG87n6V8FJIUfOfwd3guW0MJPx4oxoZ5G4hYDPCUkt7HU2WZPGYiFxCsbB
 QwrNDrKiSqQJLTupI7k7yBpriNbHiTe3mrWtFYmz9K5J4VlCi1ojjlJjOZWy0LxqP2IZ
 nPpk8dDnvCR9PM0bEd/gmjpYnmPrsKUIhG0A/i4Cu7mOqxDuM8yGyNjMQN3I/r7saMO2
 aO4Rr8qO1ODhhmP+QfvFvRDonnQMiA3krw+VuwJP0190jz9TJJYBQCGdkL48hnAvLa5o
 OPw1ji8nSbPz3A5QFX+zoEJa7FHw/H4LogHPy7fe/rIybHSQ/yWMz5D97aNm16FTbhj7 hw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udhe1sjwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 22:18:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGMIo3K021822
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 22:18:50 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 16 Nov 2023 14:18:50 -0800
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: add 320 MHz bandwidth enums
Date:   Thu, 16 Nov 2023 14:18:39 -0800
Message-ID: <20231116221839.1303170-1-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QoW81AkFWDhdOd6_uFlbEvQpkJgnjm5W
X-Proofpoint-ORIG-GUID: QoW81AkFWDhdOd6_uFlbEvQpkJgnjm5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_23,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add 320 MHz bandwidth as a new bandwidth enum for ATH12k driver. This
is extending existing bandwidth related enums to include 320 MHz. This
is a precursor to supporting 320 MHz in the future.

Sanity test performed to confirm that there was no impact in existing
bandwidths.

Additionally update QuIC copyright to include 2023 in hal_rx.h.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 3 ++-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 3 ++-
 drivers/net/wireless/ath/ath12k/hal_rx.h | 3 ++-
 drivers/net/wireless/ath/ath12k/mac.c    | 8 ++++++++
 drivers/net/wireless/ath/ath12k/mac.h    | 1 +
 drivers/net/wireless/ath/ath12k/wmi.h    | 1 +
 6 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f44bc5494ce7..f8f66062ee1e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1091,7 +1091,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	spin_unlock_bh(&ar->ab->base_lock);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
-		   "rx skb %pK len %u peer %pM %u %s %s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
+		   "rx skb %pK len %u peer %pM %u %s %s%s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
 		   msdu->len,
 		   peer ? peer->addr : NULL,
@@ -1104,6 +1104,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 		   (status->bw == RATE_INFO_BW_40) ? "40" : "",
 		   (status->bw == RATE_INFO_BW_80) ? "80" : "",
 		   (status->bw == RATE_INFO_BW_160) ? "160" : "",
+		   (status->bw == RATE_INFO_BW_320) ? "320" : "",
 		   status->enc_flags & RX_ENC_FLAG_SHORT_GI ? "sgi " : "",
 		   status->rate_idx,
 		   status->nss,
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 9f831e3971f9..c3e2146860f7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2435,7 +2435,7 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 	spin_unlock_bh(&ab->base_lock);
 
 	ath12k_dbg(ab, ATH12K_DBG_DATA,
-		   "rx skb %pK len %u peer %pM %d %s sn %u %s%s%s%s%s%s%s%s rate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
+		   "rx skb %pK len %u peer %pM %d %s sn %u %s%s%s%s%s%s%s%s%s rate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
 		   msdu->len,
 		   peer ? peer->addr : NULL,
@@ -2449,6 +2449,7 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 		   (status->bw == RATE_INFO_BW_40) ? "40" : "",
 		   (status->bw == RATE_INFO_BW_80) ? "80" : "",
 		   (status->bw == RATE_INFO_BW_160) ? "160" : "",
+		   (status->bw == RATE_INFO_BW_320) ? "320" : "",
 		   status->enc_flags & RX_ENC_FLAG_SHORT_GI ? "sgi " : "",
 		   status->rate_idx,
 		   status->nss,
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index fcfb6c819047..095216eabc01 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HAL_RX_H
@@ -61,6 +61,7 @@ enum hal_rx_bw {
 	HAL_RX_BW_40MHZ,
 	HAL_RX_BW_80MHZ,
 	HAL_RX_BW_160MHZ,
+	HAL_RX_BW_320MHZ,
 	HAL_RX_BW_MAX,
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fc0d14ea328e..abe2561238b3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -343,6 +343,9 @@ ath12k_mac_bw_to_mac80211_bw(enum ath12k_supported_bw bw)
 	case ATH12K_BW_160:
 		ret = RATE_INFO_BW_160;
 		break;
+	case ATH12K_BW_320:
+		ret = RATE_INFO_BW_320;
+		break;
 	}
 
 	return ret;
@@ -359,6 +362,8 @@ enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw b
 		return ATH12K_BW_80;
 	case RATE_INFO_BW_160:
 		return ATH12K_BW_160;
+	case RATE_INFO_BW_320:
+		return ATH12K_BW_320;
 	default:
 		return ATH12K_BW_20;
 	}
@@ -3726,6 +3731,9 @@ static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
 	case IEEE80211_STA_RX_BW_160:
 		bw = WMI_PEER_CHWIDTH_160MHZ;
 		break;
+	case IEEE80211_STA_RX_BW_320:
+		bw = WMI_PEER_CHWIDTH_320MHZ;
+		break;
 	default:
 		ath12k_warn(ar->ab, "Invalid bandwidth %d in rc update for %pM\n",
 			    sta->deflink.bandwidth, sta->addr);
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 59b4e8f5eee0..52a3b19a2270 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -43,6 +43,7 @@ enum ath12k_supported_bw {
 	ATH12K_BW_40    = 1,
 	ATH12K_BW_80    = 2,
 	ATH12K_BW_160   = 3,
+	ATH12K_BW_320   = 4,
 };
 
 extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 629373d67421..760bfaf1a917 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2220,6 +2220,7 @@ enum wmi_peer_chwidth {
 	WMI_PEER_CHWIDTH_40MHZ = 1,
 	WMI_PEER_CHWIDTH_80MHZ = 2,
 	WMI_PEER_CHWIDTH_160MHZ = 3,
+	WMI_PEER_CHWIDTH_320MHZ = 4,
 };
 
 enum wmi_beacon_gen_mode {
-- 
2.34.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4546753661
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jul 2023 11:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbjGNJ0u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jul 2023 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjGNJ0m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jul 2023 05:26:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2712D68
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jul 2023 02:26:41 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E8VctA004220;
        Fri, 14 Jul 2023 09:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=5TudB0cDr9TQys/NcBjY/1C8S6hgvq1S910JijguzmY=;
 b=aafLPnIYodFoj/mJAfifXeR0Zp9ro7XePovObfYg8zAVxbvDfjyBzZa5Z5oOLKMMKfDQ
 lNbQNWoq26MZdrJcRNleZaDH50c9sv0hg9dstJmm9434YvbZeFdHR9R3Sp3dwYLXiLH5
 rSbFzAeOeLLl2/3K80hm8VFOh6tmVnU3apV21wDrUlCxn6xvaA22dpVUX4cmTWkcRf2F
 tliGtP+eiodEAY1rr/GlQITmoXpCDbbpptvq39n9s0cFqYzJ7h3IbxMZTrhqelk5l667
 Y5dkbPVVqooCXSt+SlRejsnx5lhADATFi2xsiHlI/p4HeceZAJCVET/DTgrIpz4HEt9r SQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpuhsauj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 09:26:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E9Q9C0007785
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 09:26:09 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 14 Jul 2023 02:26:07 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: trigger station disconnect on hardware restart
Date:   Fri, 14 Jul 2023 05:25:55 -0400
Message-ID: <20230714092555.2018-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J4eLspOTGC0DS1kYpgmXqyneqTQdy7tq
X-Proofpoint-ORIG-GUID: J4eLspOTGC0DS1kYpgmXqyneqTQdy7tq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently after the hardware restart triggered from the driver, the
station interface connection remains intact, since a disconnect
trigger is not sent to userspace. This can lead to a problem in
targets where the wifi mac sequence is added by the firmware.

After the target restart, its wifi mac sequence number gets reset to
zero. Hence AP to which our device is connected will receive frames
with a wifi mac sequence number jump to the past, thereby resulting
in the AP dropping all these frames, until the frame arrives with a
wifi mac sequence number which AP was expecting.

To avoid such frame drops, its better to trigger a station disconnect
upon target hardware restart which can be done with API
ieee80211_reconfig_disconnect exposed to mac80211.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2: add code comment explaining why disconnect needs to be done.

 drivers/net/wireless/ath/ath12k/mac.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ee792822b411..044a5901a2a0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6364,6 +6364,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar = hw->priv;
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_vif *arvif;
 	int recovery_count;
 
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
@@ -6392,6 +6393,27 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 				ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset success\n");
 			}
 		}
+
+		list_for_each_entry(arvif, &ar->arvifs, list) {
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "reconfig cipher %d up %d vdev type %d\n",
+				   arvif->key_cipher,
+				   arvif->is_up,
+				   arvif->vdev_type);
+			/*
+			 * After trigger disconnect, then upper layer will
+			 * trigger connect again, then the PN number of
+			 * upper layer will be reset to keep up with AP
+			 * side, hence PN number mis-match will not happened.
+			 */
+			if (arvif->is_up &&
+			    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+			    arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE) {
+				ieee80211_hw_restart_disconnect(arvif->vif);
+				ath12k_dbg(ab, ATH12K_DBG_BOOT,
+					   "restart disconnect\n");
+			}
+		}
 	}
 
 	mutex_unlock(&ar->conf_mutex);

base-commit: 0a00db612b6df1fad80485e3642529d1f28ea084
-- 
2.40.1


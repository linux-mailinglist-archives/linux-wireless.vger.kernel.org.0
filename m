Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021F46BAF69
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 12:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCOLjA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 07:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCOLi6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 07:38:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B46977D
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 04:38:57 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FALRB2010615;
        Wed, 15 Mar 2023 11:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=J1WFJ4r6F11pSJA5oiRldzV8jK57pPHD9YqfucrMzgg=;
 b=aYYqh1dzkU9BjSoVc6s8Gmh/aP00f9gMN5TXE0xaw5EmXeI575OVoPfZoN5SjLn7v69y
 eazvFjBQRq9OPdE6EYVeg2RyR3wXV07gw1A8jOR/bzc1dYLx06aYT3Y7Njt1tZ4msyd9
 FrrHM7xXlJj2dzaVWxC7EYr9yFzk0SL2DYZBifcP7SmpJnWdtM/LoOaRsm7JDb9LjpaO
 swt4cpSa4jNG/mZdwYp2G9RDPWqvjGRhXlDsCk3eeL/6Xn58p3xA17iwZ70BXqWTWA/d
 5xogq9p4pHPw7EIHaR9m9gI1ji1NLqJ/+6JkLpxytnK9Tk+4lCHVdiHo0qLa0tGQkPMo LA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2d2sb4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 11:32:36 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FBWZ8A013953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 11:32:35 GMT
Received: from aarasahu-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 04:32:32 -0700
From:   Aaradhana Sahu <quic_aarasahu@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix firmware assert during channel switch for peer sta
Date:   Wed, 15 Mar 2023 17:02:02 +0530
Message-ID: <20230315113202.8774-1-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4nidtc69RaKM5lEox-NkPTyWGMqNMK-N
X-Proofpoint-ORIG-GUID: 4nidtc69RaKM5lEox-NkPTyWGMqNMK-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_04,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

Currently, during change in bandwidth for peer sta, host sends the
new value of channel width via WMI_PEER_CHWIDTH set peer param command
alone. This can lead to firmware assert in some scenario since before
the command, firmware was having value of channel width and its
corresponding phymode. After the command, host tries to set the new
value of channel width alone which can become incompatible when compared
with its phymode.

For example:

Bandwidth Upgrade
~~~~~~~~~~~~~~~~~~
After association, sta is in 40 MHz bandwidth in 11ax-HE40 phymode.
After bandwidth upgrades, sta moves to 80 MHz but as per phymode,
max bandwidth is still 40 MHz. Hence, firmware assert is seen.
So in this case first phymode should be moved to 11ax-HE80
followed by bandwidth change.

Bandwidth Downgrade
~~~~~~~~~~~~~~~~~~
Similarly, reverse of above is also possible when sta is in 40 MHz
bandwidth in 11ax-HE40 phymode. Bandwidth should be changed to 20 MHz
and if host sends phymode first then, phymode will become 11ax-HE20
and will be incompatible with bandwidth value and hence firmware
assert will be seen. Hence, in this case first channel width
should be set followed by phymode.

Fix this issue by sending WMI set peer param command for phymode as
well as bandwidth based on the type of bandwidth change i.e upgrade
or downgrade.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 117 +++++++++++++++++++------
 2 files changed, 89 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index dffa687ee40e..9439052a652e 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -395,6 +395,7 @@ struct ath12k_sta {
 	u8 rssi_comb;
 	struct ath12k_rx_peer_stats *rx_stats;
 	struct ath12k_wbm_tx_stats *wbm_tx_stats;
+	u32 bw_prev;
 };
 
 #define ATH12K_MIN_5G_FREQ 4150
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bf7e5b6977b2..d7daeff2170b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3220,10 +3220,11 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
-	u32 changed, bw, nss, smps;
+	u32 changed, bw, nss, smps, bw_prev;
 	int err, num_vht_rates;
 	const struct cfg80211_bitrate_mask *mask;
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
+	enum wmi_phy_mode peer_phymode;
 
 	arsta = container_of(wk, struct ath12k_sta, update_wk);
 	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
@@ -3243,6 +3244,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 	arsta->changed = 0;
 
 	bw = arsta->bw;
+	bw_prev = arsta->bw_prev;
 	nss = arsta->nss;
 	smps = arsta->smps;
 
@@ -3255,11 +3257,53 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 			   ath12k_mac_max_vht_nss(vht_mcs_mask)));
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
-		err = ath12k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
-						WMI_PEER_CHWIDTH, bw);
-		if (err)
-			ath12k_warn(ar->ab, "failed to update STA %pM peer bw %d: %d\n",
-				    sta->addr, bw, err);
+		ath12k_peer_assoc_h_phymode(ar, arvif->vif, sta, &peer_arg);
+		peer_phymode = peer_arg.peer_phymode;
+
+		if (bw > bw_prev) {
+			/* Phymode shows maximum supported channel width, if we
+			 * upgrade bandwidth then due to sanity check of firmware,
+			 * we have to send WMI_PEER_PHYMODE followed by
+			 * WMI_PEER_CHWIDTH
+			 */
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac BW upgrade for sta %pM new BW %d, old BW %d\n",
+				   sta->addr, bw, bw_prev);
+			err = ath12k_wmi_set_peer_param(ar, sta->addr,
+							arvif->vdev_id, WMI_PEER_PHYMODE,
+							peer_phymode);
+			if (err) {
+				ath12k_warn(ar->ab, "failed to update STA %pM peer phymode %d: %d\n",
+					    sta->addr, peer_phymode, err);
+				goto err_rc_bw_changed;
+			}
+			err = ath12k_wmi_set_peer_param(ar, sta->addr,
+							arvif->vdev_id, WMI_PEER_CHWIDTH,
+							bw);
+			if (err)
+				ath12k_warn(ar->ab, "failed to update STA %pM peer bw %d: %d\n",
+					    sta->addr, bw, err);
+		} else {
+			/* When we downgrade bandwidth this will conflict with phymode
+			 * and cause to trigger firmware crash. In this case we send
+			 * WMI_PEER_CHWIDTH followed by WMI_PEER_PHYMODE
+			 */
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac BW downgrade for sta %pM new BW %d,old BW %d\n",
+				   sta->addr, bw, bw_prev);
+			err = ath12k_wmi_set_peer_param(ar, sta->addr,
+							arvif->vdev_id, WMI_PEER_CHWIDTH,
+							bw);
+			if (err) {
+				ath12k_warn(ar->ab, "failed to update STA %pM peer bw %d: %d\n",
+					    sta->addr, bw, err);
+				goto err_rc_bw_changed;
+			}
+			err = ath12k_wmi_set_peer_param(ar, sta->addr,
+							arvif->vdev_id, WMI_PEER_PHYMODE,
+							peer_phymode);
+			if (err)
+				ath12k_warn(ar->ab, "failed to update STA %pM peer phymode %d: %d\n",
+					    sta->addr, peer_phymode, err);
+		}
 	}
 
 	if (changed & IEEE80211_RC_NSS_CHANGED) {
@@ -3321,7 +3365,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 					    sta->addr, arvif->vdev_id);
 		}
 	}
-
+err_rc_bw_changed:
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -3433,6 +3477,34 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	return ret;
 }
 
+static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
+					      struct ieee80211_sta *sta)
+{
+	u32 bw = WMI_PEER_CHWIDTH_20MHZ;
+
+	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_20:
+		bw = WMI_PEER_CHWIDTH_20MHZ;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		bw = WMI_PEER_CHWIDTH_40MHZ;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		bw = WMI_PEER_CHWIDTH_80MHZ;
+		break;
+	case IEEE80211_STA_RX_BW_160:
+		bw = WMI_PEER_CHWIDTH_160MHZ;
+		break;
+	default:
+		ath12k_warn(ar->ab, "Invalid bandwidth %d in rc update for %pM\n",
+			    sta->deflink.bandwidth, sta->addr);
+		bw = WMI_PEER_CHWIDTH_20MHZ;
+		break;
+	}
+
+	return bw;
+}
+
 static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
@@ -3498,6 +3570,13 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to associate station: %pM\n",
 				    sta->addr);
+
+		spin_lock_bh(&ar->data_lock);
+
+		arsta->bw = ath12k_mac_ieee80211_sta_bw_to_wmi(ar, sta);
+		arsta->bw_prev = sta->deflink.bandwidth;
+
+		spin_unlock_bh(&ar->data_lock);
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTHORIZED) {
 		spin_lock_bh(&ar->ab->base_lock);
@@ -3607,28 +3686,8 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	spin_lock_bh(&ar->data_lock);
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
-		bw = WMI_PEER_CHWIDTH_20MHZ;
-
-		switch (sta->deflink.bandwidth) {
-		case IEEE80211_STA_RX_BW_20:
-			bw = WMI_PEER_CHWIDTH_20MHZ;
-			break;
-		case IEEE80211_STA_RX_BW_40:
-			bw = WMI_PEER_CHWIDTH_40MHZ;
-			break;
-		case IEEE80211_STA_RX_BW_80:
-			bw = WMI_PEER_CHWIDTH_80MHZ;
-			break;
-		case IEEE80211_STA_RX_BW_160:
-			bw = WMI_PEER_CHWIDTH_160MHZ;
-			break;
-		default:
-			ath12k_warn(ar->ab, "Invalid bandwidth %d in rc update for %pM\n",
-				    sta->deflink.bandwidth, sta->addr);
-			bw = WMI_PEER_CHWIDTH_20MHZ;
-			break;
-		}
-
+		bw = ath12k_mac_ieee80211_sta_bw_to_wmi(ar, sta);
+		arsta->bw_prev = arsta->bw;
 		arsta->bw = bw;
 	}
 

base-commit: 3fa9da4001890def44801dd56d5fbc134689be28
-- 
2.17.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA775F5218
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJEJy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 05:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiJEJy5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 05:54:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7F312756
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 02:54:56 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2959sX3S001111;
        Wed, 5 Oct 2022 09:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=O3YZ06+58htj5S1BwrNr/CT+16Wyx/NlubArfvg9Kjo=;
 b=W6zQfrfMS0kQiDNX1n6k9AjwWhEPJ0bUwu7jNQsnbdGkC3AeAe/q9z/qHezXQUTjuUrf
 Wqcum08qMBK/8e8Q87JjcFVVfyQN3G6Tg2nmL1eoLN/vQS5mQm/CT5MIAfIdS2TB/LI3
 dYkyJrPLQqCV8N646MNZx+GltoyCmz6K3PAElkRJN5sJPSGb3yQlq87cH+U+9iiKnKtj
 QQUIFfrIEViDqdEVIkWGy5aMhQxttQ1tpUvmrTEQ7S1sWnOb/zWm4EBw+1D2gzIvQahB
 6z1u8nE2NKaF0LE5YeVGmNh2M1koGy/kgMl/ynl+bIpizKd73sLDkNGk5DpMPQBx2WIK mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k15shg5sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 09:54:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2959slcD024465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Oct 2022 09:54:47 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 02:54:45 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix firmware assert during bandwidth change for peer sta
Date:   Wed, 5 Oct 2022 15:24:30 +0530
Message-ID: <20221005095430.19890-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UNeEDsBAE7jTn3Eei6h_04rs4fegxIOp
X-Proofpoint-ORIG-GUID: UNeEDsBAE7jTn3Eei6h_04rs4fegxIOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_01,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, ath11k sends peer assoc command for each peer to
firmware when bandwidth changes. Peer assoc command is a
bulky command and if many clients are connected, this could
lead to firmware buffer getting overflowed leading to a firmware
assert.

However, during bandwidth change, only phymode and bandwidth
also can be updated by WMI set peer param command. This makes
the overall command light when compared to peer assoc and for
multi-client cases, firmware buffer overflow also does not
occur.

Remove sending peer assoc command during sta bandwidth change
and instead add sending WMI set peer param command for phymode
and bandwidth.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Fixes: f187fe8e3bc65 ("ath11k: fix firmware crash during channel switch")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/mac.c  | 122 +++++++++++++++++--------
 2 files changed, 87 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index bbcef120c8f6..22460b0abf03 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -505,6 +505,8 @@ struct ath11k_sta {
 	u64 ps_start_jiffies;
 	u64 ps_total_duration;
 	bool peer_current_ps_valid;
+
+	u32 bw_prev;
 };
 
 #define ATH11K_MIN_5G_FREQ 4150
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 84d956ad4093..4b86769cab8b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4214,10 +4214,11 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
 	const u16 *he_mcs_mask;
-	u32 changed, bw, nss, smps;
+	u32 changed, bw, nss, smps, bw_prev;
 	int err, num_vht_rates, num_he_rates;
 	const struct cfg80211_bitrate_mask *mask;
 	struct peer_assoc_params peer_arg;
+	enum wmi_phy_mode peer_phymode;
 
 	arsta = container_of(wk, struct ath11k_sta, update_wk);
 	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
@@ -4238,6 +4239,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	arsta->changed = 0;
 
 	bw = arsta->bw;
+	bw_prev = arsta->bw_prev;
 	nss = arsta->nss;
 	smps = arsta->smps;
 
@@ -4251,26 +4253,57 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 			   ath11k_mac_max_he_nss(he_mcs_mask)));
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
-		/* Send peer assoc command before set peer bandwidth param to
-		 * avoid the mismatch between the peer phymode and the peer
-		 * bandwidth.
-		 */
-		ath11k_peer_assoc_prepare(ar, arvif->vif, sta, &peer_arg, true);
-
-		peer_arg.is_assoc = false;
-		err = ath11k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
-		if (err) {
-			ath11k_warn(ar->ab, "failed to send peer assoc for STA %pM vdev %i: %d\n",
-				    sta->addr, arvif->vdev_id, err);
-		} else if (wait_for_completion_timeout(&ar->peer_assoc_done, 1 * HZ)) {
+		/* Get the peer phymode */
+		ath11k_peer_assoc_h_phymode(ar, arvif->vif, sta, &peer_arg);
+		peer_phymode = peer_arg.peer_phymode;
+
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac update sta %pM peer bw %d phymode %d\n",
+			   sta->addr, bw, peer_phymode);
+
+		if (bw > bw_prev) {
+			/* BW is upgraded. In this case we send WMI_PEER_PHYMODE
+			 * followed by WMI_PEER_CHWIDTH
+			 */
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac BW upgrade for sta %pM new BW %d, old BW %d\n",
+				   sta->addr, bw, bw_prev);
+
+			err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
+							WMI_PEER_PHYMODE, peer_phymode);
+
+			if (err) {
+				ath11k_warn(ar->ab, "failed to update STA %pM peer phymode %d: %d\n",
+					    sta->addr, peer_phymode, err);
+				goto err_rc_bw_changed;
+			}
+
 			err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
 							WMI_PEER_CHWIDTH, bw);
+
 			if (err)
 				ath11k_warn(ar->ab, "failed to update STA %pM peer bw %d: %d\n",
 					    sta->addr, bw, err);
 		} else {
-			ath11k_warn(ar->ab, "failed to get peer assoc conf event for %pM vdev %i\n",
-				    sta->addr, arvif->vdev_id);
+			/* BW is downgraded. In this case we send WMI_PEER_CHWIDTH
+			 * followed by WMI_PEER_PHYMODE
+			 */
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac BW downgrade for sta %pM new BW %d,old BW %d\n",
+				   sta->addr, bw, bw_prev);
+
+			err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
+							WMI_PEER_CHWIDTH, bw);
+
+			if (err) {
+				ath11k_warn(ar->ab, "failed to update STA %pM peer bw %d: %d\n",
+					    sta->addr, bw, err);
+				goto err_rc_bw_changed;
+			}
+
+			err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
+							WMI_PEER_PHYMODE, peer_phymode);
+
+			if (err)
+				ath11k_warn(ar->ab, "failed to update STA %pM peer phymode %d: %d\n",
+					    sta->addr, peer_phymode, err);
 		}
 	}
 
@@ -4351,6 +4384,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 		}
 	}
 
+err_rc_bw_changed:
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -4504,6 +4538,34 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 	return ret;
 }
 
+static u32 ath11k_mac_ieee80211_sta_bw_to_wmi(struct ath11k *ar,
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
+		ath11k_warn(ar->ab, "Invalid bandwidth %d for %pM\n",
+			    sta->deflink.bandwidth, sta->addr);
+		bw = WMI_PEER_CHWIDTH_20MHZ;
+		break;
+	}
+
+	return bw;
+}
+
 static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
@@ -4589,6 +4651,12 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		if (ret)
 			ath11k_warn(ar->ab, "Failed to associate station: %pM\n",
 				    sta->addr);
+
+		spin_lock_bh(&ar->data_lock);
+		/* Set arsta bw and prev bw */
+		arsta->bw = ath11k_mac_ieee80211_sta_bw_to_wmi(ar, sta);
+		arsta->bw_prev = arsta->bw;
+		spin_unlock_bh(&ar->data_lock);
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTHORIZED) {
 		spin_lock_bh(&ar->ab->base_lock);
@@ -4712,28 +4780,8 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
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
-			ath11k_warn(ar->ab, "Invalid bandwidth %d in rc update for %pM\n",
-				    sta->deflink.bandwidth, sta->addr);
-			bw = WMI_PEER_CHWIDTH_20MHZ;
-			break;
-		}
-
+		bw = ath11k_mac_ieee80211_sta_bw_to_wmi(ar, sta);
+		arsta->bw_prev = arsta->bw;
 		arsta->bw = bw;
 	}
 

base-commit: 023baf1318ef21442fab3842bf03883bc81223e0
-- 
2.17.1


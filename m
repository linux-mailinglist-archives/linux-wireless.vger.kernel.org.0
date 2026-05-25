Return-Path: <linux-wireless+bounces-36875-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FVyEoYvFGqUKgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36875-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:16:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ECE5C9D5C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4BF302BE3A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D9F37DAC0;
	Mon, 25 May 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DlXdmITv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404237D11D
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707415; cv=none; b=N3/H7emPfEsC7re1ziTkeU/MHuXJvYiLehHKnCubhjcpVwXY12N8AEbl28rhF73iwppvAyszVdZgWo+vfx5ugGZSCrQGuhwjlK2I/3uQXOaQzyIs5ry2yzb4vXDdFFLiykI5RU4M2XOiyRVGwqp1h38xVO6R1rIqvCL8Z6NLgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707415; c=relaxed/simple;
	bh=uSbxL+/HiiGAuEplnGP4IcewC9zZoY13wNoFk5FnodI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ho3GQCK+1jcE42kz8YETk28klQjlPa4lwmZXceGAObcWYSpfSJbzrwdNJbDfDbkqlrOWHRd5I73wcz+MY2uPSMCc7bydB+bvD2+KU10u6sru6Hle1jaOEr5zmDGRARyZP+NI+G1UYmQClVPdKPfEIHAjlV7lTaLsiSND63j5cpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DlXdmITv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P686mb803976;
	Mon, 25 May 2026 11:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kagcSVU5wW6
	PE2S/+ZQiFUJ5h0/7wqZBYDFnZ3TUfrw=; b=DlXdmITv/g77W69dStiepoKk3jE
	PPcsS6giDlxU9wMypS5ITNdQPDMmUnhcGniwo+jiv8a/7Hx9u9x+VTEACc6xxvs1
	+6CGM3L0CZZCpe0qvjMh1ZEiMBq4Igc5YO/Imx8pJQOIeI5kpM50n8wXFW7JYlKW
	sfxLylr49mh899JxJyhamZt4/55cWe5KO65SHaePagfR9Ewrp2VujIn5DwaKv3sq
	ExRTETe5LRXF4CHrhB/aSewp1p0LSJNbt9UXDdSfoNXPtM7f+1KxLl5isrQTuc0Z
	4AIjznZolYvp6aGgXGTgx194PnsLXNvjLOjxr+uCLREnvYSCnidV1ZCDJsA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0wjwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PBA7JG026270;
	Mon, 25 May 2026 11:10:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4eb5ajfc32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:07 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64PBA7tO026263;
	Mon, 25 May 2026 11:10:07 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64PBA7L3026262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:07 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id CD1184195D; Mon, 25 May 2026 16:40:06 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next 2/6] wifi: ath12k: Add support for 4-address mode
Date: Mon, 25 May 2026 16:39:38 +0530
Message-Id: <20260525110942.2890212-3-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
References: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: GDGPBrz8ypO_N6mEJ2ah9jMNMWaLa216
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDExMyBTYWx0ZWRfX17oIFVq51hmq
 wY22X7L0mFTxIL6X61kVkqetrc1kInOiqsv/LrPsaIUiRi5tohcmlgULSme57mt1t0H4ZuSeJqw
 lpow9eFQQ64tTha9Qe9GkiQO0ADDXzpMnzCx4pzp24kGjXn8t0AwEVa/aLVRudkUbn0FOhbe0mw
 ZDgQPeB1AUGeiv0ZkdwJIwh1VI7tzzCvnQhK3FwjlgSNI+saFf3nbjs/sE58SURky2AOXFaKLR5
 aDvz8XFWPEqWAcMpwlueolDtuvKeqXCYzrGyz9qBDWHh/NEMgmlSDl+QZLGuejyFjw+dwlyrTl1
 FIc9ppfdfGFU2YFgXIe+SEH02Nn2UN0VfywKYJ8XsaDutdyKpLAiZfL1w/fDP/z2ZSd5PrRIif0
 c7N3lxqvD9V2MfIoEJr2agC7n5PwTT2vFufDSCAnTzC4epy7m2w53iu2d4zo9UEqs8UKdWJJTH8
 95CHLF/DgbRtwDEj8xA==
X-Proofpoint-GUID: GDGPBrz8ypO_N6mEJ2ah9jMNMWaLa216
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a142e13 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=vg3u1cjFFGf9waS3a40A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250113
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36875-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A2ECE5C9D5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current driver does not support enabling 4-address mode data traffic
in WDS mode. Add the required functionality by introducing the
sta_set_4addr() API, which is invoked when a 4-address AP/STA connects.
This API sends the WMI_PEER_USE_4ADDR peer parameter to notify firmware
about the 4-address peer, allowing firmware and hardware to transmit
and receive frames in 4-address format for that peer.

For 4-address multicast packet transmission, update the handling
to set peer metadata values in HAL_TCL_DATA_CMD_INFO1_CMD_NUM instead
of using vdev metadata values. Vdev metadata is used only for 3-address
and 4-address unicast traffic and for 3-address multicast traffic.
The peer metadata path embeds the correct peer_id, enabling proper
multicast transmission in 4-address mode.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h        |  6 ++
 drivers/net/wireless/ath/ath12k/mac.c         | 79 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h         |  3 +
 drivers/net/wireless/ath/ath12k/peer.c        |  7 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 10 ++-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |  4 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    | 18 ++++-
 drivers/net/wireless/ath/ath12k/wmi.h         |  5 ++
 8 files changed, 125 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index f6d8ec9ef7b0..70ad9742c21d 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -353,6 +353,8 @@ struct ath12k_link_vif {
 	u16 num_stations;
 	bool is_csa_in_progress;
 	struct wiphy_work bcn_tx_work;
+
+	bool set_wds_vdev_param;
 };
 
 struct ath12k_vif {
@@ -492,6 +494,8 @@ struct ath12k_link_sta {
 	/* link address similar to ieee80211_link_sta */
 	u8 addr[ETH_ALEN];
 
+	u16 tcl_metadata;
+
 	/* the following are protected by ar->data_lock */
 	u32 changed; /* IEEE80211_RC_* */
 	u32 bw;
@@ -527,6 +531,8 @@ struct ath12k_sta {
 	u16 free_logical_link_idx_map;
 
 	enum ieee80211_sta_state state;
+
+	bool enable_4addr;
 };
 
 #define ATH12K_HALF_20MHZ_BW	10
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2d02a6a8d54f..0105a1fc7929 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6567,6 +6567,62 @@ static int ath12k_mac_station_disassoc(struct ath12k *ar,
 	return 0;
 }
 
+static int ath12k_mac_sta_set_4addr(struct wiphy *wiphy, struct ath12k_sta *ahsta)
+{
+	struct ath12k_dp_link_peer *peer;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_link_sta *arsta;
+	struct ath12k_dp *dp;
+	unsigned long links;
+	struct ath12k *ar;
+	u8 link_id;
+	int ret;
+
+	links = ahsta->links_map;
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arsta = wiphy_dereference(wiphy, ahsta->link[link_id]);
+		if (!arsta)
+			continue;
+
+		arvif = arsta->arvif;
+		ar = arvif->ar;
+
+		if (arvif->set_wds_vdev_param)
+			goto skip_use_4addr;
+
+		ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+			   "setting USE_4ADDR for peer %pM\n", arsta->addr);
+
+		ret = ath12k_wmi_set_peer_param(ar, arsta->addr,
+						arvif->vdev_id,
+						WMI_PEER_USE_4ADDR,
+						WMI_PEER_4ADDR_ALLOW_EAPOL_DATA_FRAME);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set peer %pM 4addr capability: %d\n",
+				    arsta->addr, ret);
+			return ret;
+		}
+
+skip_use_4addr:
+		dp = ath12k_ab_to_dp(ar->ab);
+		spin_lock_bh(&dp->dp_lock);
+		peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
+								 arsta->addr);
+		if (peer && peer->dp_peer) {
+			peer->dp_peer->ucast_ra_only = true;
+		} else {
+			spin_unlock_bh(&dp->dp_lock);
+			ath12k_warn(ar->ab, "failed to find DP peer for %pM\n",
+				    arsta->addr);
+			return -ENOENT;
+		}
+
+		spin_unlock_bh(&dp->dp_lock);
+	}
+
+	return 0;
+}
+
 static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 {
 	struct ieee80211_link_sta *link_sta;
@@ -7861,6 +7917,28 @@ int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ath12k_mac_op_sta_set_txpwr);
 
+void ath12k_mac_op_sta_set_4addr(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta, bool enabled)
+{
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+
+	lockdep_assert_wiphy(hw->wiphy);
+
+	/*
+	 * 4-address mode disabled option is available only for station
+	 * interface from mac80211, and we have wds_vdev_param for station
+	 * interface and target will not allow to disable the wds_vdev_param
+	 * during run time. So, add support only for enable case, for
+	 * disable case station interface needs to be reconnect.
+	 */
+	if (enabled && !ahsta->enable_4addr) {
+		if (!ath12k_mac_sta_set_4addr(hw->wiphy, ahsta))
+			ahsta->enable_4addr = true;
+	}
+}
+EXPORT_SYMBOL(ath12k_mac_op_sta_set_4addr);
+
 void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_link_sta *link_sta,
@@ -10417,6 +10495,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 					    ret);
 				goto err_peer_del;
 			}
+			arvif->set_wds_vdev_param = true;
 		}
 
 		if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ab->wmi_ab.svc_map) &&
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 7b50c5976384..aba98afd4365 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -255,6 +255,9 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta);
+void ath12k_mac_op_sta_set_4addr(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta, bool enabled);
 void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_link_sta *link_sta,
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 2e875176baaa..42488b465540 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -218,7 +218,12 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		ahsta = ath12k_sta_to_ahsta(sta);
 		arsta = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
 					  ahsta->link[link_id]);
-
+		/* TODO: Split DP related field usage to DP peer structure */
+		arsta->tcl_metadata = u16_encode_bits(0, HTT_TCL_META_DATA_TYPE) |
+				       u16_encode_bits(peer->peer_id,
+						       HTT_TCL_META_DATA_PEER_ID) |
+				       u16_encode_bits(0,
+						       HTT_TCL_META_DATA_VALID_HTT);
 		peer->link_id = arsta->link_id;
 
 		/* Fill ML info into created peer */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 629084aa36d8..5f298133dee9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -59,8 +59,8 @@ static int ath12k_wifi7_dp_prepare_htt_metadata(struct sk_buff *skb)
 
 /* TODO: Remove the export once this file is built with wifi7 ko */
 int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *arvif,
-		       struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
-		       bool is_mcast)
+		       struct ath12k_link_sta *arsta, struct sk_buff *skb,
+		       bool gsn_valid, int mcbc_gsn, bool is_mcast)
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_hal *hal = dp->hal;
@@ -125,6 +125,12 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 	ti.bank_id = dp_link_vif->bank_id;
 	ti.meta_data_flags = dp_link_vif->tcl_metadata;
 
+	if (ieee80211_has_a4(hdr->frame_control) &&
+	    is_multicast_ether_addr(hdr->addr3) && arsta) {
+		ti.meta_data_flags = arsta->tcl_metadata;
+		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TO_FW);
+	}
+
 	if (dp_vif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
 	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags)) {
 		if (skb_cb->flags & ATH12K_SKB_CIPHER_SET) {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
index 24cf7972d41b..86bc813878c0 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
@@ -8,8 +8,8 @@
 #define ATH12K_DP_TX_WIFI7_H
 
 int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *arvif,
-		       struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
-		       bool is_mcast);
+		       struct ath12k_link_sta *arsta, struct sk_buff *skb,
+		       bool gsn_valid, int mcbc_gsn, bool is_mcast);
 void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_dp *dp, int ring_id);
 u32 ath12k_wifi7_dp_tx_get_vdev_bank_config(struct ath12k_base *ab,
 					    struct ath12k_link_vif *arvif);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index cb3185850439..06ab5b46b47d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -859,7 +859,9 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ieee80211_sta *sta = control->sta;
+	struct ath12k_link_sta *arsta = NULL;
 	struct ath12k_link_vif *tmp_arvif;
+	struct ath12k_sta *ahsta = NULL;
 	u32 info_flags = info->flags;
 	struct sk_buff *msdu_copied;
 	struct ath12k *ar, *tmp_ar;
@@ -941,6 +943,12 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 	if (!(info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP))
 		is_mcast = is_multicast_ether_addr(hdr->addr1);
 
+	if (sta) {
+		ahsta = ath12k_sta_to_ahsta(control->sta);
+		if (ahsta && ahsta->enable_4addr)
+			arsta = rcu_dereference(ahsta->link[link_id]);
+	}
+
 	/* This is case only for P2P_GO */
 	if (vif->type == NL80211_IFTYPE_AP && vif->p2p)
 		ath12k_mac_add_p2p_noa_ie(ar, vif, skb, is_prb_rsp);
@@ -961,7 +969,7 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 	if (!vif->valid_links || !is_mcast || is_dvlan ||
 	    (skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) ||
 	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
-		ret = ath12k_wifi7_dp_tx(dp_pdev, arvif, skb, false, 0, is_mcast);
+		ret = ath12k_wifi7_dp_tx(dp_pdev, arvif, arsta, skb, false, 0, is_mcast);
 		if (unlikely(ret)) {
 			ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
 			ieee80211_free_txskb(ar->ah->hw, skb);
@@ -999,6 +1007,11 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 			skb_cb->vif = vif;
 			skb_cb->ar = tmp_ar;
 
+			if (ahsta && ahsta->enable_4addr)
+				arsta = rcu_dereference(ahsta->link[link_id]);
+			else
+				arsta = NULL;
+
 			/* For open mode, skip peer find logic */
 			if (unlikely(!ahvif->dp_vif.key_cipher))
 				goto skip_peer_find;
@@ -1030,7 +1043,7 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 			spin_unlock_bh(&tmp_dp->dp_lock);
 
 skip_peer_find:
-			ret = ath12k_wifi7_dp_tx(tmp_dp_pdev, tmp_arvif,
+			ret = ath12k_wifi7_dp_tx(tmp_dp_pdev, tmp_arvif, arsta,
 						 msdu_copied, true, mcbc_gsn, is_mcast);
 			if (unlikely(ret)) {
 				if (ret == -ENOMEM) {
@@ -1075,6 +1088,7 @@ static const struct ieee80211_ops ath12k_ops_wifi7 = {
 	.sta_state                      = ath12k_mac_op_sta_state,
 	.sta_set_txpwr			= ath12k_mac_op_sta_set_txpwr,
 	.link_sta_rc_update		= ath12k_mac_op_link_sta_rc_update,
+	.sta_set_4addr                  = ath12k_mac_op_sta_set_4addr,
 	.conf_tx                        = ath12k_mac_op_conf_tx,
 	.set_antenna			= ath12k_mac_op_set_antenna,
 	.get_antenna			= ath12k_mac_op_get_antenna,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 14b8dcdf881d..a827b3c99f8f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2334,6 +2334,11 @@ enum wmi_preamble {
 	WMI_VDEV_PREAMBLE_SHORT = 2,
 };
 
+enum wmi_peer_4addr_allow_frame {
+	WMI_PEER_4ADDR_ALLOW_DATA_FRAME = 1,
+	WMI_PEER_4ADDR_ALLOW_EAPOL_DATA_FRAME = 2,
+};
+
 enum wmi_peer_smps_state {
 	WMI_PEER_SMPS_PS_NONE =	0,
 	WMI_PEER_SMPS_STATIC  = 1,
-- 
2.34.1



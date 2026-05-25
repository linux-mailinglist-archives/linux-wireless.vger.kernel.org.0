Return-Path: <linux-wireless+bounces-36878-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFF4CWAvFGqUKgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36878-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:15:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6A5C9D40
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 409A4302ACCD
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A202A37DAB9;
	Mon, 25 May 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M7KKJpwJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5237E2F5
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707418; cv=none; b=OTVwB980TYwNY0JhYDLNdTCM6MItiDEzvSCAmb8x/VdgDgtBGYb4JpNPCVMhtVJtXEjns3OUUapJtKPkmxdeVmDpGuedY27NNm7uAYxxpWYbKBltf6e7So3CI4Uup/DZ78CIY4hNzlUdWhZFfj1LDJDCQ77R6xYDK7+Jz2RI+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707418; c=relaxed/simple;
	bh=/SyuBj8P5VMBM2glKBkJjJRXSAToqYCJ+au7142wa7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qLRk+QF7V33wCGUqo4VHhayUHCeJgzowjgTshnVshkGTEgrQQemWiEmStlTMxsFpAAkQsMw8HHj/D/p9TDpimTGYY2KhpuXPwMO98IdqP1U/6LnEvgYopAbXh96j+B/WDS5TYUzaxIhnJcH3zxYZuMeFeYfzVQhFIIGxV9z8BC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M7KKJpwJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P5jsp7767582;
	Mon, 25 May 2026 11:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XZyCjMia0lS
	I/yxQ1HX8lc8iVyzm1i3rKHc/o2h5tg4=; b=M7KKJpwJoEyTAiTUsad75Fnm1dv
	4p/8ljxPmQgLc6Eky8biKbao0tvl1SQFb+7jwwyqchlsIWRYJ9prZGOxCItPfn+e
	ImJzTFVfdJz3+6ZrLktui42G2OrZ1ej7KB+f+P4p9lXVWyAO69vJzimK2liRGso8
	I23K5AaFgTC7xQ1askINCKJ/CeLvOtY3C6aHHKDUgMo43hv0vRtbFjtsE0+2r7w5
	VAhJiTd4MLESRVRQnc+0tlJE1UowXYrWliH9OasXFmphHAP0rrr8kaja93ftaX5L
	Qfq/68G5fAu/Iq795VE53CfvUJvcOR7hi6asR0MB9A2mZxx7IpEAPxD1l/A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0wjwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:14 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PBA6Os026072;
	Mon, 25 May 2026 11:10:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4eb5ajfc3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:10 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64PBAAer026328;
	Mon, 25 May 2026 11:10:10 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64PBAAFJ026325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:10 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id E44B34195D; Mon, 25 May 2026 16:40:09 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next 5/6] wifi: ath12k: Add support for 4-address frame notification
Date: Mon, 25 May 2026 16:39:41 +0530
Message-Id: <20260525110942.2890212-6-tamizh.raja@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Ir_6WuCLhzgWjtpXkBI21aKGVRVrc5_I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDExMyBTYWx0ZWRfX/BtVvpCz5L84
 wdK35sjCUjtwQrBiPRQJkLPeTvxvCDkx/gwicm1nsGDAkF//u3QV1xrlAlu2cUdcMVG0LBObsd8
 wN0uV63wALcbsYJB3bsSVSIEliT8FwHGp30YraCpBuTK10muxnX89rYhUlFLqIlGZBzbv1wfa+l
 0Ewc8n/l28tPQ2qZFzm/z6+pb0uElcfrsvdmaCFK8WrqOJ906m7YoVpuGyi9MGGFVuZT1pT9w3C
 8bko6/6/I6lUnosPM7gNpi0qJzDmeaty/tlO0Ju4giCM0yIMKyj0NAK9AiYIJzA0IBGp5ULyfxq
 LxHX3ScuNL4390c1db2CMg3jC84I+YVJPvH0iXYL9cbyY09ELbuNSx/wZ3dVzrZIcXntW+3zgpS
 1+AuebQ4ix2/JwnF1fKqEeYp4Lhc1AoTugxvbKPZsg7zOVB8hGjOdqp/tli5cHakp+WLibQXDjW
 9gwH8opdIY9PrluWWNg==
X-Proofpoint-GUID: Ir_6WuCLhzgWjtpXkBI21aKGVRVrc5_I
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a142e16 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=NKIaDA4WvVCVqGPpVjcA:9
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36878-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B2D6A5C9D40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mac80211 currently relies on receiving 4-address frames from connected
stations to trigger AP_VLAN interface creation. However, when ethernet
encapsulation offload is enabled, mac80211 only receives 802.3 frames
and cannot differentiate between 3-address and 4-address formats,
preventing AP_VLAN creation.

Enable mac80211 to detect 4-address traffic by converting 802.3 frames
back into 802.11 frames in the driver and setting the FROM_DS and TO_DS
bits using the RX_MSDU_END_INFO5_FROM_DS and RX_MSDU_END_INFO5_TO_DS
fields. This restores 4-address frame visibility to mac80211 and allows
it to trigger AP_VLAN interface creation.

Skip this frame conversion once the AP_VLAN interface is created and the
station is attached to it.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_peer.h     |  2 +
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 10 ++++-
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  3 +-
 drivers/net/wireless/ath/ath12k/hal.h         |  4 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  1 +
 drivers/net/wireless/ath/ath12k/peer.c        |  3 ++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 38 ++++++++++++++-----
 .../wireless/ath/ath12k/wifi7/hal_qcc2072.c   | 16 ++++++++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   | 16 ++++++++
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   | 16 ++++++++
 10 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
index 113b8040010f..f5067e66f1e1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.h
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -143,6 +143,8 @@ struct ath12k_dp_peer {
 	struct ath12k_dp_link_peer __rcu *link_peers[ATH12K_NUM_MAX_LINKS];
 	struct ath12k_reoq_buf reoq_bufs[IEEE80211_NUM_TIDS + 1];
 	struct ath12k_dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
+
+	bool use_4addr;
 };
 
 struct ath12k_dp_link_peer *
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index a4fec1dc55c6..bccb1bc0b41e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1139,7 +1139,8 @@ static void ath12k_dp_rx_h_undecap_eth(struct ath12k_pdev_dp *dp_pdev,
 void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 			    enum hal_encrypt_type enctype,
 			    bool decrypted,
-			    struct hal_rx_desc_data *rx_info)
+			    struct hal_rx_desc_data *rx_info,
+			    struct ath12k_dp_peer *peer)
 {
 	enum ath12k_dp_rx_decap_type decap_type = rx_info->decap_type;
 	struct ethhdr *ehdr;
@@ -1163,6 +1164,13 @@ void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu
 			break;
 		}
 
+		if (peer && !peer->use_4addr &&
+		    rx_info->is_from_ds && rx_info->is_to_ds) {
+			ath12k_dp_rx_h_undecap_eth(dp_pdev, msdu, enctype, rx_info,
+						   decap_type);
+			break;
+		}
+
 		/* PN for mcast packets will be validated in mac80211;
 		 * remove eth header and add 802.11 header.
 		 */
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 55a31e669b3b..0660db070e92 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -190,7 +190,8 @@ void ath12k_dp_extract_rx_desc_data(struct ath12k_hal *hal,
 void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 			    enum hal_encrypt_type enctype,
 			    bool decrypted,
-			    struct hal_rx_desc_data *rx_info);
+			    struct hal_rx_desc_data *rx_info,
+			    struct ath12k_dp_peer *peer);
 void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struct *napi,
 			       struct sk_buff *msdu,
 			       struct hal_rx_desc_data *rx_info);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index bf4f7dbae866..21c551d8b248 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -738,7 +738,9 @@ struct hal_rx_desc_data {
 	    addr2_present:1,
 	    is_mcbc:1,
 	    seq_ctl_valid:1,
-	    fc_valid:1;
+	    fc_valid:1,
+	    is_to_ds:1,
+	    is_from_ds:1;
 	u16 msdu_len;
 	u16 peer_id;
 	u16 seq_no;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2f437ecae84d..d6f7e8974c33 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6626,6 +6626,7 @@ static int ath12k_mac_sta_set_4addr(struct wiphy *wiphy, struct ath12k_sta *ahst
 								 arsta->addr);
 		if (peer && peer->dp_peer) {
 			peer->dp_peer->ucast_ra_only = true;
+			peer->dp_peer->use_4addr = true;
 		} else {
 			spin_unlock_bh(&dp->dp_lock);
 			ath12k_warn(ar->ab, "failed to find DP peer for %pM\n",
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index b5a0ba149a28..c222bdaa333c 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -255,6 +255,9 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 						 ar->hw_link_id);
 	}
 
+	if (vif->type == NL80211_IFTYPE_AP && peer->dp_peer)
+		peer->dp_peer->ucast_ra_only = true;
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 945680b3ebdf..43bb8631827f 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -323,9 +323,9 @@ static void ath12k_wifi7_dp_rx_h_csum_offload(struct sk_buff *msdu,
 			   CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
 }
 
-static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
-				      struct sk_buff *msdu,
-				      struct hal_rx_desc_data *rx_info)
+static int ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
+				     struct sk_buff *msdu,
+				     struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_skb_rxcb *rxcb;
 	enum hal_encrypt_type enctype;
@@ -347,6 +347,18 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 
 	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, rxcb->peer_id);
 	if (peer) {
+		/*
+		 * Drop the 3-address multicast packet from 4-address
+		 * peer To avoid receiving the duplicate multicast packet
+		 * Specifically from AP interface in 3-address format
+		 */
+		if (rxcb->is_mcbc &&
+		    rx_info->decap_type == DP_RX_DECAP_TYPE_ETHERNET2_DIX) {
+			if (peer->use_4addr &&
+			    !(rx_info->is_from_ds && rx_info->is_to_ds))
+				return -EINVAL;
+		}
+
 		/* resetting mcbc bit because mcbc packets are unicast
 		 * packets only for AP as STA sends unicast packets.
 		 */
@@ -387,15 +399,18 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	}
 
 	ath12k_wifi7_dp_rx_h_csum_offload(msdu, rx_info);
-	ath12k_dp_rx_h_undecap(dp_pdev, msdu, enctype, is_decrypted, rx_info);
+	ath12k_dp_rx_h_undecap(dp_pdev, msdu, enctype, is_decrypted, rx_info,
+			       peer);
 
 	if (!is_decrypted || rx_info->is_mcbc)
-		return;
+		return 0;
 
 	if (rx_info->decap_type != DP_RX_DECAP_TYPE_ETHERNET2_DIX) {
 		hdr = (void *)msdu->data;
 		hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 	}
+
+	return 0;
 }
 
 static int ath12k_wifi7_dp_rx_msdu_coalesce(struct ath12k_hal *hal,
@@ -554,7 +569,9 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k_pdev_dp *dp_pdev,
 	}
 
 	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
-	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_info);
+	ret = ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_info);
+	if (ret)
+		goto free_out;
 
 	rx_info->rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
 
@@ -1033,7 +1050,7 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 
 	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
 	ath12k_dp_rx_h_undecap(dp_pdev, msdu, HAL_ENCRYPT_TYPE_TKIP_MIC, true,
-			       rx_info);
+			       rx_info, NULL);
 	ieee80211_rx(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 	return -EINVAL;
 }
@@ -1588,6 +1605,7 @@ static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k_pdev_dp *dp_pdev,
 	u8 l3pad_bytes = rx_info->l3_pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	u32 hal_rx_desc_sz = dp->ab->hal.hal_desc_sz;
+	int ret;
 
 	if (!rxcb->is_frag && ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE)) {
 		/* First buffer will be freed by the caller, so deduct it's length */
@@ -1632,7 +1650,9 @@ static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k_pdev_dp *dp_pdev,
 		return -EINVAL;
 
 	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
-	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_info);
+	ret = ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_info);
+	if (ret)
+		return ret;
 
 	rxcb->tid = rx_info->tid;
 
@@ -1678,7 +1698,7 @@ static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k_pdev_dp *dp_pdev,
 				     RX_FLAG_DECRYPTED);
 
 	ath12k_dp_rx_h_undecap(dp_pdev, msdu, HAL_ENCRYPT_TYPE_TKIP_MIC, false,
-			       rx_info);
+			       rx_info, NULL);
 	return false;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
index 1eefb931a853..8cebb229ebed 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -184,6 +184,20 @@ static u8 ath12k_hal_rx_desc_get_l3_pad_bytes_qcc2072(struct hal_rx_desc *desc)
 			     RX_MSDU_END_INFO5_L3_HDR_PADDING);
 }
 
+static inline
+u8 ath12k_wifi7_hal_rx_h_from_ds_qcc2072(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.qcc2072.msdu_end.info5,
+			     RX_MSDU_END_INFO5_FROM_DS);
+}
+
+static inline
+u8 ath12k_wifi7_hal_rx_h_to_ds_qcc2072(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.qcc2072.msdu_end.info5,
+			     RX_MSDU_END_INFO5_TO_DS);
+}
+
 static u32 ath12k_hal_rx_desc_get_mpdu_start_tag_qcc2072(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcc2072.mpdu_start_tag,
@@ -397,6 +411,8 @@ static void ath12k_hal_extract_rx_desc_data_qcc2072(struct hal_rx_desc_data *rx_
 	rx_desc_data->seq_no = ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcc2072(rx_desc);
 	rx_desc_data->msdu_len = ath12k_hal_rx_desc_get_msdu_len_qcc2072(ldesc);
 	rx_desc_data->sgi = ath12k_hal_rx_desc_get_msdu_sgi_qcc2072(rx_desc);
+	rx_desc_data->is_from_ds = ath12k_wifi7_hal_rx_h_from_ds_qcc2072(rx_desc);
+	rx_desc_data->is_to_ds = ath12k_wifi7_hal_rx_h_to_ds_qcc2072(rx_desc);
 	rx_desc_data->rate_mcs = ath12k_hal_rx_desc_get_msdu_rate_mcs_qcc2072(rx_desc);
 	rx_desc_data->bw = ath12k_hal_rx_desc_get_msdu_rx_bw_qcc2072(rx_desc);
 	rx_desc_data->phy_meta_data = ath12k_hal_rx_desc_get_msdu_freq_qcc2072(rx_desc);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index ba9ce1e718e8..9d5180ef83b4 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -699,6 +699,20 @@ u8 ath12k_hal_rx_desc_get_mpdu_tid_qcn9274(struct hal_rx_desc *desc)
 			     RX_MSDU_END_INFO5_TID);
 }
 
+static inline
+u8 ath12k_wifi7_hal_rx_h_from_ds_qcn9274(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
+			     RX_MSDU_END_INFO5_FROM_DS);
+}
+
+static inline
+u8 ath12k_wifi7_hal_rx_h_to_ds_qcn9274(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
+			     RX_MSDU_END_INFO5_TO_DS);
+}
+
 static inline
 u16 ath12k_hal_rx_desc_get_mpdu_peer_id_qcn9274(struct hal_rx_desc *desc)
 {
@@ -914,6 +928,8 @@ void ath12k_hal_extract_rx_desc_data_qcn9274(struct hal_rx_desc_data *rx_desc_da
 	rx_desc_data->seq_ctl_valid =
 		ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_qcn9274(rx_desc);
 	rx_desc_data->fc_valid = ath12k_hal_rx_desc_get_mpdu_fc_valid_qcn9274(rx_desc);
+	rx_desc_data->is_from_ds = ath12k_wifi7_hal_rx_h_from_ds_qcn9274(rx_desc);
+	rx_desc_data->is_to_ds = ath12k_wifi7_hal_rx_h_to_ds_qcn9274(rx_desc);
 	rx_desc_data->seq_no = ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcn9274(rx_desc);
 	rx_desc_data->msdu_len = ath12k_hal_rx_desc_get_msdu_len_qcn9274(ldesc);
 	rx_desc_data->sgi = ath12k_hal_rx_desc_get_msdu_sgi_qcn9274(rx_desc);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index e64e512cac7d..efbbc1cbd3e4 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -280,6 +280,20 @@ u8 ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850(struct hal_rx_desc *desc)
 			    RX_MSDU_END_INFO5_L3_HDR_PADDING);
 }
 
+static inline
+u8 ath12k_wifi7_hal_rx_h_from_ds_wcn7850(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.wcn7850.msdu_end.info5,
+			     RX_MSDU_END_INFO5_FROM_DS);
+}
+
+static inline
+u8 ath12k_wifi7_hal_rx_h_to_ds_wcn7850(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.wcn7850.msdu_end.info5,
+			     RX_MSDU_END_INFO5_TO_DS);
+}
+
 static inline
 bool ath12k_hal_rx_desc_encrypt_valid_wcn7850(struct hal_rx_desc *desc)
 {
@@ -599,6 +613,8 @@ void ath12k_hal_extract_rx_desc_data_wcn7850(struct hal_rx_desc_data *rx_desc_da
 	rx_desc_data->seq_no = ath12k_hal_rx_desc_get_mpdu_start_seq_no_wcn7850(rx_desc);
 	rx_desc_data->msdu_len = ath12k_hal_rx_desc_get_msdu_len_wcn7850(ldesc);
 	rx_desc_data->sgi = ath12k_hal_rx_desc_get_msdu_sgi_wcn7850(rx_desc);
+	rx_desc_data->is_from_ds = ath12k_wifi7_hal_rx_h_from_ds_wcn7850(rx_desc);
+	rx_desc_data->is_to_ds = ath12k_wifi7_hal_rx_h_to_ds_wcn7850(rx_desc);
 	rx_desc_data->rate_mcs = ath12k_hal_rx_desc_get_msdu_rate_mcs_wcn7850(rx_desc);
 	rx_desc_data->bw = ath12k_hal_rx_desc_get_msdu_rx_bw_wcn7850(rx_desc);
 	rx_desc_data->phy_meta_data = ath12k_hal_rx_desc_get_msdu_freq_wcn7850(rx_desc);
-- 
2.34.1



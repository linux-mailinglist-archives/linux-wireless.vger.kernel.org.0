Return-Path: <linux-wireless+bounces-38006-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 25cxCplaOmqG6wcAu9opvQ
	(envelope-from <linux-wireless+bounces-38006-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 12:06:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C72E6B6110
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 12:06:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=X+0yIcX8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38006-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38006-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 789E0300574F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44AB2288D5;
	Tue, 23 Jun 2026 10:05:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08B2E7389
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 10:05:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209115; cv=none; b=FdPYlXf6/XSzGQtkacPjkxCHQkYfwbyh75tlG3dTFz6wqtf1oB6btLAPopmWt5nnumbOeuFhqowLP9iThQU3vL5GBrhSI1wHCFZQurJpNchS/yMkbOA4iLesLk4lCGJa5xU6t14iagPPnHUyuyAZunqqtNpfgUxBwdOqacBYgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209115; c=relaxed/simple;
	bh=unfONWBLKb0ylXgrXVTkhttU/Y6YSlqIFZnIDClv2PM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rYb9jmYa1xuVhANEl9VvNyI9M8A/MNbWl3bDw6wPw5pX6erzddcxE7vrXrQfV/8budpDCCMd3BYjxZkMQKf9s95Mn3PqHg+5zJOC1mojvxdg2kcYGQEaLJhCRAcKS3gV01Olvn38yhErc9vjlfFcuZp5N0Qp+bKiwwHvFWjK33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X+0yIcX8; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NA3QMV953078;
	Tue, 23 Jun 2026 10:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8NjygwYtud3DGtX7MwVPQSYE2dhj0Ujakfq
	d1CRlUiU=; b=X+0yIcX8PIkgt7VOq49ecOIc0N/0CTeK1SFIWlqLM43pp7I04ib
	U0z5qbzLDmVMDIijaWIO5sJmg1iifIKxB6PAXRQPG/vmldoABbzTKlKoaZl4eqpl
	CuMSIJwQP2y7nMKBAab0ChH63bbsfd1xBt2l2OtOQEgoc2WFc7vkIsNxwQKwn/V9
	rFbZlwGbNGKG5BM4BGqNXtjHMFN35iWzt5FJ5iybq51+3pP59h1sEAL6J2SFJ6eV
	xJdpKcTpGjyTYKl+ImGrWW7g4mBBfw4Il8vkX35RlU+L9Vj75uDHpt947dxhGvke
	GXnbEaRkQwcCB5OQzlO6tpoVOaEd32D8mlw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr28r0cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 10:05:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NA58O6022146;
	Tue, 23 Jun 2026 10:05:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4ewkxjnt3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 10:05:08 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65NA57pS022135;
	Tue, 23 Jun 2026 10:05:07 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 65NA57ic022134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 10:05:07 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id D4FED41A21; Tue, 23 Jun 2026 15:35:06 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Advertise multicast Ethernet encapsulation offload support
Date: Tue, 23 Jun 2026 15:35:01 +0530
Message-Id: <20260623100501.2100119-1-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MSBTYWx0ZWRfX7Z6E6ZHJPF/Y
 ftofIyDchlq+P8vc9vg+XIvIWMmiN62RHrF367nkDJwquOeToR8pRaWr9xgUGLejPV8thhZcOSg
 DzhTifwxbzH15EEvox7xtVH3yCh3wp8=
X-Authority-Analysis: v=2.4 cv=b4KCJNGx c=1 sm=1 tr=0 ts=6a3a5a57 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=SXmXk8MbY0boExpAyW0A:9
X-Proofpoint-GUID: kXEvrLLRoDqkINmui7u-kFStw4HCJMG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MSBTYWx0ZWRfX4P/UhJ+Lh8m2
 2Lo6Od4CqcLgCoujgwi6H1Z8+0rhSq14bFDA2s+yZrPn/9931On3EKWpF97qeheVmS5sXsr8OHM
 cLtD7aSGorCX8AXlKLMJsojKLYg8ScDRBEezrQpfiOdvqCjGDoExnAyYphU5Tf3dN7uCyrvg7Na
 nGtYh1QFSqu+RYBIujOAftuZ35oZqUEUbo3lc1mN7NOttLOJv6WbYTDOT3uMKrj6HzT21pRGpdD
 PngReyi4MymFgyjGXjgMBM1N51mIMMee5Zog5xT1NeEUpJAOEVGMVooI21LamgckpyP/rwRg6Us
 C/VO7vCns534cH5a1x8j4c+M0JFJcW6pEbsKGkUjRtpHnMpv+Rb16wGaGzk2EqEmn2Or7ooR2YB
 kdmjj1iRWAGVhBAZPj7JGgbWOmly0iimWWOnXh/oWEq2JjZUKYS1cirKhlBFxUhtmIr1sv1Ymam
 rM608+fdvyjIDpS/EOQ==
X-Proofpoint-ORIG-GUID: kXEvrLLRoDqkINmui7u-kFStw4HCJMG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230081
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38006-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:tamizh.raja@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C72E6B6110

Advertise IEEE80211_OFFLOAD_ENCAP_MCAST to inform mac80211 that
multicast frame encapsulation is handled in hardware. This allows
mac80211 to pass Ethernet-formatted multicast frames directly to
the driver.

In ath12k_wifi7_mac_op_tx(), refine the logic that selects the MLO
multicast replication path. Add a sta pointer check so that only unicast
Hardware-encap frames use the direct transmit path, while multicast
Hardware-encap frames fall through to the MLO replication loop and are
transmitted on each active link.

In the MLO replication loop, use skb_clone() for Hardware-encap frames.
These frames are already in Ethernet format and do not require
802.11 link address rewriting by ath12k_mlo_mcast_update_tx_link_address().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c      |  6 ++-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 61 +++++++++++++++++-----
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index af354bef5c0d..26b46a404580 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10117,7 +10117,8 @@ static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 	if (vif->type != NL80211_IFTYPE_STATION &&
 	    vif->type != NL80211_IFTYPE_AP)
 		vif->offload_flags &= ~(IEEE80211_OFFLOAD_ENCAP_ENABLED |
-					IEEE80211_OFFLOAD_DECAP_ENABLED);
+					IEEE80211_OFFLOAD_DECAP_ENABLED |
+					IEEE80211_OFFLOAD_ENCAP_MCAST);
 
 	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) {
 		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_ETHERNET;
@@ -10136,6 +10137,9 @@ static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 		vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
 	}
 
+	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
+		vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_MCAST;
+
 	param_id = WMI_VDEV_PARAM_RX_DECAP_TYPE;
 	if (vif->offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED)
 		param_value = ATH12K_HW_TXRX_ETHERNET;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 3d59fa452ec0..e5bf9d218104 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -903,6 +903,7 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 	struct ethhdr *eth;
 	bool is_prb_rsp;
 	u16 mcbc_gsn;
+	u8 cb_flags;
 	u8 link_id;
 	int ret;
 	struct ath12k_dp *tmp_dp;
@@ -996,8 +997,13 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 	    ieee80211_has_protected(hdr->frame_control))
 		is_dvlan = true;
 
+	/*
+	 * Add a sta pointer check to differentiate multicast encapsulation
+	 * offload packets, as the ATH12K_SKB_HW_80211_ENCAP flag is also set
+	 * for such packets.
+	 */
 	if (!vif->valid_links || !is_mcast || is_dvlan ||
-	    (skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) ||
+	    ((skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) && sta) ||
 	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
 		ret = ath12k_wifi7_dp_tx(dp_pdev, arvif, arsta, skb, false, 0, is_mcast);
 		if (unlikely(ret)) {
@@ -1009,6 +1015,7 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 		mcbc_gsn = atomic_inc_return(&ahvif->dp_vif.mcbc_gsn) & 0xfff;
 
 		links_map = ahvif->links_map;
+		cb_flags = skb_cb->flags;
 		for_each_set_bit(link_id, &links_map,
 				 IEEE80211_MLD_MAX_NUM_LINKS) {
 			tmp_arvif = rcu_dereference(ahvif->link[link_id]);
@@ -1016,21 +1023,45 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 				continue;
 
 			tmp_ar = tmp_arvif->ar;
-			tmp_dp_pdev = ath12k_dp_to_pdev_dp(tmp_ar->ab->dp,
+			tmp_dp = ath12k_ab_to_dp(tmp_ar->ab);
+			tmp_dp_pdev = ath12k_dp_to_pdev_dp(tmp_dp,
 							   tmp_ar->pdev_idx);
 			if (!tmp_dp_pdev)
 				continue;
-			msdu_copied = skb_copy(skb, GFP_ATOMIC);
-			if (!msdu_copied) {
-				ath12k_err(ar->ab,
-					   "skb copy failure link_id 0x%X vdevid 0x%X\n",
-					   link_id, tmp_arvif->vdev_id);
-				continue;
-			}
 
-			ath12k_mlo_mcast_update_tx_link_address(vif, link_id,
-								msdu_copied,
-								info_flags);
+			if (cb_flags & ATH12K_SKB_HW_80211_ENCAP) {
+				/*
+				 * skb->data may be modified for the iova_mask devices.
+				 * It is better to use skb_copy() for such devices
+				 * to avoid any potential skb corruption related issues.
+				 */
+				if (tmp_dp->hw_params->iova_mask)
+					msdu_copied = skb_copy(skb, GFP_ATOMIC);
+				else
+					/*
+					 * ath12k_wifi7_dp_tx() should treat cloned HW-encap
+					 * Ethernet multicast frames as read-only.
+					 */
+					msdu_copied = skb_clone(skb, GFP_ATOMIC);
+				if (!msdu_copied) {
+					ath12k_err(ar->ab,
+						   "skb copy/clone failure link_id 0x%X vdevid 0x%X\n",
+						   link_id, tmp_arvif->vdev_id);
+					continue;
+				}
+			} else {
+				msdu_copied = skb_copy(skb, GFP_ATOMIC);
+				if (!msdu_copied) {
+					ath12k_err(ar->ab,
+						   "skb copy failure link_id 0x%X vdevid 0x%X\n",
+						   link_id, tmp_arvif->vdev_id);
+					continue;
+				}
+
+				ath12k_mlo_mcast_update_tx_link_address(vif, link_id,
+									msdu_copied,
+									info_flags);
+			}
 
 			skb_cb = ATH12K_SKB_CB(msdu_copied);
 			skb_cb->link_id = link_id;
@@ -1046,7 +1077,6 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 			if (unlikely(!ahvif->dp_vif.key_cipher))
 				goto skip_peer_find;
 
-			tmp_dp = ath12k_ab_to_dp(tmp_ar->ab);
 			spin_lock_bh(&tmp_dp->dp_lock);
 			peer = ath12k_dp_link_peer_find_by_addr(tmp_dp,
 								tmp_arvif->bssid);
@@ -1065,11 +1095,16 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 				skb_cb->cipher = key->cipher;
 				skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
 
+				if (skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP)
+					goto skip_fctl_protected_check;
+
 				hdr = (struct ieee80211_hdr *)msdu_copied->data;
 				if (!ieee80211_has_protected(hdr->frame_control))
 					hdr->frame_control |=
 						cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 			}
+
+skip_fctl_protected_check:
 			spin_unlock_bh(&tmp_dp->dp_lock);
 
 skip_peer_find:

base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.34.1



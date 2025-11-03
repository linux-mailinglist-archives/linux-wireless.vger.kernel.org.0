Return-Path: <linux-wireless+bounces-28497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2859DC2B49B
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB6344716
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DEF30171C;
	Mon,  3 Nov 2025 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LIjwMkA1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006E30171A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168911; cv=none; b=nyn+hs7xEGFmjREjxakGNhPU1b+2ApkgZKvf9TxgEP8tv/mKw9EvI387x69cmHi+n11v/YrWDSf8wgjIUZjkS21cJYhVIpaC1ZWxUZS8l25EsgJ26jiAZslbFtCuKd4wEK7rgcaUJsz+aikYwmR/TvfSo7zTbV4PT7cMs1B1d20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168911; c=relaxed/simple;
	bh=Ig32eGEVT+jG9NAnAgoUGnGW3iRl2hVjj6Z1kBSlCIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqwrQuOcFZkyqnNSIfv+TjBnWsgLnCaE0DkFgYoB3NQ0VKiUYcxBo3iJ1NMv8g6FQ7RUiGtNsW4PSdhOeGom0GKNzUeYgjmzMWqmUeJCJ1G+HlzymajgxtAWun5GvMHP///ov1ZJVpt8tDaWtvoifgc05+ghzMx5cdJv4y1QYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LIjwMkA1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A38olJA2730309;
	Mon, 3 Nov 2025 11:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TBzObbEQ2OMQGsu8kx0xwiy+qWT4OHG6kffJZGAKLJ0=; b=LIjwMkA1A0nyCZtp
	PHxncu84ADnd2JDqOwGO8s1q2+gNMAD6b0aCMy2Wv+p56Ugg+Qr3qQpSUp1LSQop
	j1JI+ZWNlcEIhxvYxoUS7EhOS2jEGSRib4vrpbVKCsHw5SajwXljZeY5uGXnFEDr
	FYSE9DZXHebJtplTBLFJoSs8Rqrzp8sKIla/BRiOKe+k0tLcDOvQ4KlYBBC75gBx
	kFjmIivxvmR44N3A012CmfFfunPWG611C0xG1BiGpyYIGPCOUluE5iimgFHU4STq
	TQfts+pCealmjJOf1o/dRLzSWmneTfPomEdyZYxtd0wE3lNjcKGR0Sl0PKZJuWTY
	uShIiw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6s86ge0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:21:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3BLipO005109
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 11:21:44 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 3 Nov 2025 03:21:42 -0800
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 05/12] wifi: ath12k: Move ieee80211_ops callback to the arch specific module
Date: Mon, 3 Nov 2025 16:51:04 +0530
Message-ID: <20251103112111.2260639-6-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
References: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwNCBTYWx0ZWRfX7pF/dYXkHf7V
 LSY6aFjPT6V4GBSK6cTBIm5bIZgs0PYKGjgThpaQ01JbEfn2TTS5rqw5sJ7yudRdgJ6ACQ9Wujb
 yekxxlZipSVUIXEat7tZwL07zyARL54pN1kpWjK+gys3L406GqEdeLgx8f37lc/PSRZWD50Y+t9
 tKu5S8AE+Chy+uCDFW7jyc3bhs2H3xY0hp7HWciQEGYV0RyD27eIwXuWDaV1CXflN6HHs/hbVxA
 G6O3eorL6mY0Y5zg33+IBf6VZnNSc7jevS4yFTR3ytQcvW1PYLjyeVRlLsh3RwIisQ83zIIM00G
 xtPtvG1R1CzjYU+0oiviK6beJGqQgB35VugSIhYqfS5hJJjcazvPqEo4lfJT8CdMvXoXJJR+Tvy
 Pg3Je+qgDan/aDMTWY1MZXi4FqqmaQ==
X-Authority-Analysis: v=2.4 cv=Tq/rRTXh c=1 sm=1 tr=0 ts=69089049 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=9QFxP-3vN-HYw_SpdAsA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6s-8PWJQMhETAMAG5kznzyh52IkeUsOQ
X-Proofpoint-ORIG-GUID: 6s-8PWJQMhETAMAG5kznzyh52IkeUsOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030104

Move the ieee80211_ops Tx callback to the architecture-specific module
to avoid additional indirections caused by the common Tx function calling
the architecture-specific Tx functions via ops.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c        |   1 +
 drivers/net/wireless/ath/ath12k/mac.c         | 231 ++----------------
 drivers/net/wireless/ath/ath12k/mac.h         |  15 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |   2 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    | 208 +++++++++++++++-
 5 files changed, 237 insertions(+), 220 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3bba9c9a1a9b..4439f0a98ec4 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -28,6 +28,7 @@
 unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
+EXPORT_SYMBOL(ath12k_debug_mask);
 
 bool ath12k_ftm_mode;
 module_param_named(ftm_mode, ath12k_ftm_mode, bool, 0444);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c40c55344e64..d04606559cdf 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8833,8 +8833,8 @@ static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work
 	}
 }
 
-static int ath12k_mac_mgmt_tx(struct ath12k *ar, struct sk_buff *skb,
-			      bool is_prb_rsp)
+int ath12k_mac_mgmt_tx(struct ath12k *ar, struct sk_buff *skb,
+		       bool is_prb_rsp)
 {
 	struct sk_buff_head *q = &ar->wmi_mgmt_tx_queue;
 
@@ -8864,11 +8864,12 @@ static int ath12k_mac_mgmt_tx(struct ath12k *ar, struct sk_buff *skb,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_mgmt_tx);
 
-static void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
-				      struct ieee80211_vif *vif,
-				      struct sk_buff *skb,
-				      bool is_prb_rsp)
+void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
+			       struct ieee80211_vif *vif,
+			       struct sk_buff *skb,
+			       bool is_prb_rsp)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 
@@ -8885,11 +8886,12 @@ static void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
 
 	spin_unlock_bh(&ar->data_lock);
 }
+EXPORT_SYMBOL(ath12k_mac_add_p2p_noa_ie);
 
 /* Note: called under rcu_read_lock() */
-static void ath12k_mlo_mcast_update_tx_link_address(struct ieee80211_vif *vif,
-						    u8 link_id, struct sk_buff *skb,
-						    u32 info_flags)
+void ath12k_mlo_mcast_update_tx_link_address(struct ieee80211_vif *vif,
+					     u8 link_id, struct sk_buff *skb,
+					     u32 info_flags)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_bss_conf *bss_conf;
@@ -8901,10 +8903,11 @@ static void ath12k_mlo_mcast_update_tx_link_address(struct ieee80211_vif *vif,
 	if (bss_conf)
 		ether_addr_copy(hdr->addr2, bss_conf->addr);
 }
+EXPORT_SYMBOL(ath12k_mlo_mcast_update_tx_link_address);
 
 /* Note: called under rcu_read_lock() */
-static u8 ath12k_mac_get_tx_link(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
-				 u8 link, struct sk_buff *skb, u32 info_flags)
+u8 ath12k_mac_get_tx_link(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
+			  u8 link, struct sk_buff *skb, u32 info_flags)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
@@ -8999,211 +9002,7 @@ static u8 ath12k_mac_get_tx_link(struct ieee80211_sta *sta, struct ieee80211_vif
 
 	return link;
 }
-
-/* Note: called under rcu_read_lock() */
-void ath12k_mac_op_tx(struct ieee80211_hw *hw,
-		      struct ieee80211_tx_control *control,
-		      struct sk_buff *skb)
-{
-	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_vif *vif = info->control.vif;
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-	struct ath12k_link_vif *arvif = &ahvif->deflink;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	struct ieee80211_key_conf *key = info->control.hw_key;
-	struct ieee80211_sta *sta = control->sta;
-	struct ath12k_link_vif *tmp_arvif;
-	u32 info_flags = info->flags;
-	struct sk_buff *msdu_copied;
-	struct ath12k *ar, *tmp_ar;
-	struct ath12k_pdev_dp *dp_pdev, *tmp_dp_pdev;
-	struct ath12k_dp_link_peer *peer;
-	unsigned long links_map;
-	bool is_mcast = false;
-	bool is_dvlan = false;
-	struct ethhdr *eth;
-	bool is_prb_rsp;
-	u16 mcbc_gsn;
-	u8 link_id;
-	int ret;
-	struct ath12k_dp *tmp_dp;
-
-	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
-		ieee80211_free_txskb(hw, skb);
-		return;
-	}
-
-	link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
-	memset(skb_cb, 0, sizeof(*skb_cb));
-	skb_cb->vif = vif;
-
-	if (key) {
-		skb_cb->cipher = key->cipher;
-		skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
-	}
-
-	/* handle only for MLO case, use deflink for non MLO case */
-	if (ieee80211_vif_is_mld(vif)) {
-		link_id = ath12k_mac_get_tx_link(sta, vif, link_id, skb, info_flags);
-		if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS) {
-			ieee80211_free_txskb(hw, skb);
-			return;
-		}
-	} else {
-		link_id = 0;
-	}
-
-	arvif = rcu_dereference(ahvif->link[link_id]);
-	if (!arvif || !arvif->ar) {
-		ath12k_warn(ahvif->ah, "failed to find arvif link id %u for frame transmission",
-			    link_id);
-		ieee80211_free_txskb(hw, skb);
-		return;
-	}
-
-	ar = arvif->ar;
-	skb_cb->link_id = link_id;
-	/* as skb_cb is common currently for dp and mgmt tx processing
-	 * set this in the common mac op tx function.
-	 */
-	skb_cb->ar = ar;
-	is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
-
-	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
-		eth = (struct ethhdr *)skb->data;
-		is_mcast = is_multicast_ether_addr(eth->h_dest);
-
-		skb_cb->flags |= ATH12K_SKB_HW_80211_ENCAP;
-	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
-		if (sta && sta->mlo)
-			skb_cb->flags |= ATH12K_SKB_MLO_STA;
-
-		ret = ath12k_mac_mgmt_tx(ar, skb, is_prb_rsp);
-		if (ret) {
-			ath12k_warn(ar->ab, "failed to queue management frame %d\n",
-				    ret);
-			ieee80211_free_txskb(hw, skb);
-		}
-		return;
-	}
-
-	if (!(info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP))
-		is_mcast = is_multicast_ether_addr(hdr->addr1);
-
-	/* This is case only for P2P_GO */
-	if (vif->type == NL80211_IFTYPE_AP && vif->p2p)
-		ath12k_mac_add_p2p_noa_ie(ar, vif, skb, is_prb_rsp);
-
-	dp_pdev = ath12k_dp_to_pdev_dp(ar->ab->dp, ar->pdev_idx);
-	if (!dp_pdev) {
-		ieee80211_free_txskb(hw, skb);
-		return;
-	}
-
-	/* Checking if it is a DVLAN frame */
-	if (!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
-	    !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
-	    !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
-	    ieee80211_has_protected(hdr->frame_control))
-		is_dvlan = true;
-
-	if (!vif->valid_links || !is_mcast || is_dvlan ||
-	    (skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) ||
-	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
-		ret = ath12k_wifi7_dp_tx(dp_pdev, arvif, skb, false, 0, is_mcast);
-		if (unlikely(ret)) {
-			ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
-			ieee80211_free_txskb(ar->ah->hw, skb);
-			return;
-		}
-	} else {
-		mcbc_gsn = atomic_inc_return(&ahvif->dp_vif.mcbc_gsn) & 0xfff;
-
-		links_map = ahvif->links_map;
-		for_each_set_bit(link_id, &links_map,
-				 IEEE80211_MLD_MAX_NUM_LINKS) {
-			tmp_arvif = rcu_dereference(ahvif->link[link_id]);
-			if (!tmp_arvif || !tmp_arvif->is_up)
-				continue;
-
-			tmp_ar = tmp_arvif->ar;
-			tmp_dp_pdev = ath12k_dp_to_pdev_dp(tmp_ar->ab->dp,
-							   tmp_ar->pdev_idx);
-			if (!tmp_dp_pdev)
-				continue;
-			msdu_copied = skb_copy(skb, GFP_ATOMIC);
-			if (!msdu_copied) {
-				ath12k_err(ar->ab,
-					   "skb copy failure link_id 0x%X vdevid 0x%X\n",
-					   link_id, tmp_arvif->vdev_id);
-				continue;
-			}
-
-			ath12k_mlo_mcast_update_tx_link_address(vif, link_id,
-								msdu_copied,
-								info_flags);
-
-			skb_cb = ATH12K_SKB_CB(msdu_copied);
-			skb_cb->link_id = link_id;
-			skb_cb->vif = vif;
-			skb_cb->ar = tmp_ar;
-
-			/* For open mode, skip peer find logic */
-			if (unlikely(!ahvif->dp_vif.key_cipher))
-				goto skip_peer_find;
-
-			tmp_dp = ath12k_ab_to_dp(tmp_ar->ab);
-			spin_lock_bh(&tmp_dp->dp_lock);
-			peer = ath12k_dp_link_peer_find_by_addr(tmp_dp,
-								tmp_arvif->bssid);
-			if (!peer || !peer->dp_peer) {
-				spin_unlock_bh(&tmp_dp->dp_lock);
-				ath12k_warn(tmp_ar->ab,
-					    "failed to find peer for vdev_id 0x%X addr %pM link_map 0x%X\n",
-					    tmp_arvif->vdev_id, tmp_arvif->bssid,
-					    ahvif->links_map);
-				dev_kfree_skb_any(msdu_copied);
-				continue;
-			}
-
-			key = peer->dp_peer->keys[peer->dp_peer->mcast_keyidx];
-			if (key) {
-				skb_cb->cipher = key->cipher;
-				skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
-
-				hdr = (struct ieee80211_hdr *)msdu_copied->data;
-				if (!ieee80211_has_protected(hdr->frame_control))
-					hdr->frame_control |=
-						cpu_to_le16(IEEE80211_FCTL_PROTECTED);
-			}
-			spin_unlock_bh(&tmp_dp->dp_lock);
-
-skip_peer_find:
-			ret = ath12k_wifi7_dp_tx(tmp_dp_pdev, tmp_arvif,
-						 msdu_copied, true, mcbc_gsn, is_mcast);
-			if (unlikely(ret)) {
-				if (ret == -ENOMEM) {
-					/* Drops are expected during heavy multicast
-					 * frame flood. Print with debug log
-					 * level to avoid lot of console prints
-					 */
-					ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
-						   "failed to transmit frame %d\n",
-						   ret);
-				} else {
-					ath12k_warn(ar->ab,
-						    "failed to transmit frame %d\n",
-						    ret);
-				}
-
-				dev_kfree_skb_any(msdu_copied);
-			}
-		}
-		ieee80211_free_txskb(ar->ah->hw, skb);
-	}
-}
-EXPORT_SYMBOL(ath12k_mac_op_tx);
+EXPORT_SYMBOL(ath12k_mac_get_tx_link);
 
 void ath12k_mac_drain_tx(struct ath12k *ar)
 {
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index f785a81860ce..0c73944f527b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -191,9 +191,6 @@ void ath12k_mac_update_freq_range(struct ath12k *ar,
 void ath12k_mac_fill_reg_tpc_info(struct ath12k *ar,
 				  struct ath12k_link_vif *arvif,
 				  struct ieee80211_chanctx_conf *ctx);
-void ath12k_mac_op_tx(struct ieee80211_hw *hw,
-		      struct ieee80211_tx_control *control,
-		      struct sk_buff *skb);
 int ath12k_mac_op_start(struct ieee80211_hw *hw);
 void ath12k_mac_op_stop(struct ieee80211_hw *hw, bool suspend);
 void
@@ -317,4 +314,16 @@ int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      unsigned int link_id,
 			      int *dbm);
+int ath12k_mac_mgmt_tx(struct ath12k *ar, struct sk_buff *skb,
+		       bool is_prb_rsp);
+void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
+			       struct ieee80211_vif *vif,
+			       struct sk_buff *skb,
+			       bool is_prb_rsp);
+u8 ath12k_mac_get_tx_link(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
+			  u8 link, struct sk_buff *skb, u32 info_flags);
+
+void ath12k_mlo_mcast_update_tx_link_address(struct ieee80211_vif *vif,
+					     u8 link_id, struct sk_buff *skb,
+					     u32 info_flags);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 737651341afc..7e16bc12e36a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -57,6 +57,7 @@ static int ath12k_wifi7_dp_prepare_htt_metadata(struct sk_buff *skb)
 	return 0;
 }
 
+/* TODO: Remove the export once this file is built with wifi7 ko */
 int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *arvif,
 		       struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
 		       bool is_mcast)
@@ -378,6 +379,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_wifi7_dp_tx);
 
 static void
 ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 946771b96fb5..1f5dda73230d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -24,6 +24,7 @@
 #include "../debugfs_sta.h"
 #include "../testmode.h"
 #include "hal.h"
+#include "dp_tx.h"
 
 static const guid_t wcn7850_uuid = GUID_INIT(0xf634f534, 0x6147, 0x11ec,
 					     0x90, 0xd6, 0x02, 0x42,
@@ -653,8 +654,213 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 	},
 };
 
+/* Note: called under rcu_read_lock() */
+static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
+				   struct ieee80211_tx_control *control,
+				   struct sk_buff *skb)
+{
+	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif = &ahvif->deflink;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct ieee80211_sta *sta = control->sta;
+	struct ath12k_link_vif *tmp_arvif;
+	u32 info_flags = info->flags;
+	struct sk_buff *msdu_copied;
+	struct ath12k *ar, *tmp_ar;
+	struct ath12k_pdev_dp *dp_pdev, *tmp_dp_pdev;
+	struct ath12k_dp_link_peer *peer;
+	unsigned long links_map;
+	bool is_mcast = false;
+	bool is_dvlan = false;
+	struct ethhdr *eth;
+	bool is_prb_rsp;
+	u16 mcbc_gsn;
+	u8 link_id;
+	int ret;
+	struct ath12k_dp *tmp_dp;
+
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
+
+	link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
+	memset(skb_cb, 0, sizeof(*skb_cb));
+	skb_cb->vif = vif;
+
+	if (key) {
+		skb_cb->cipher = key->cipher;
+		skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
+	}
+
+	/* handle only for MLO case, use deflink for non MLO case */
+	if (ieee80211_vif_is_mld(vif)) {
+		link_id = ath12k_mac_get_tx_link(sta, vif, link_id, skb, info_flags);
+		if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS) {
+			ieee80211_free_txskb(hw, skb);
+			return;
+		}
+	} else {
+		link_id = 0;
+	}
+
+	arvif = rcu_dereference(ahvif->link[link_id]);
+	if (!arvif || !arvif->ar) {
+		ath12k_warn(ahvif->ah, "failed to find arvif link id %u for frame transmission",
+			    link_id);
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
+
+	ar = arvif->ar;
+	skb_cb->link_id = link_id;
+	/*
+	 * as skb_cb is common currently for dp and mgmt tx processing
+	 * set this in the common mac op tx function.
+	 */
+	skb_cb->ar = ar;
+	is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
+
+	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+		eth = (struct ethhdr *)skb->data;
+		is_mcast = is_multicast_ether_addr(eth->h_dest);
+
+		skb_cb->flags |= ATH12K_SKB_HW_80211_ENCAP;
+	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
+		if (sta && sta->mlo)
+			skb_cb->flags |= ATH12K_SKB_MLO_STA;
+
+		ret = ath12k_mac_mgmt_tx(ar, skb, is_prb_rsp);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to queue management frame %d\n",
+				    ret);
+			ieee80211_free_txskb(hw, skb);
+		}
+		return;
+	}
+
+	if (!(info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP))
+		is_mcast = is_multicast_ether_addr(hdr->addr1);
+
+	/* This is case only for P2P_GO */
+	if (vif->type == NL80211_IFTYPE_AP && vif->p2p)
+		ath12k_mac_add_p2p_noa_ie(ar, vif, skb, is_prb_rsp);
+
+	dp_pdev = ath12k_dp_to_pdev_dp(ar->ab->dp, ar->pdev_idx);
+	if (!dp_pdev) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
+
+	/* Checking if it is a DVLAN frame */
+	if (!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
+	    !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
+	    !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
+	    ieee80211_has_protected(hdr->frame_control))
+		is_dvlan = true;
+
+	if (!vif->valid_links || !is_mcast || is_dvlan ||
+	    (skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) ||
+	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
+		ret = ath12k_wifi7_dp_tx(dp_pdev, arvif, skb, false, 0, is_mcast);
+		if (unlikely(ret)) {
+			ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
+			ieee80211_free_txskb(ar->ah->hw, skb);
+			return;
+		}
+	} else {
+		mcbc_gsn = atomic_inc_return(&ahvif->dp_vif.mcbc_gsn) & 0xfff;
+
+		links_map = ahvif->links_map;
+		for_each_set_bit(link_id, &links_map,
+				 IEEE80211_MLD_MAX_NUM_LINKS) {
+			tmp_arvif = rcu_dereference(ahvif->link[link_id]);
+			if (!tmp_arvif || !tmp_arvif->is_up)
+				continue;
+
+			tmp_ar = tmp_arvif->ar;
+			tmp_dp_pdev = ath12k_dp_to_pdev_dp(tmp_ar->ab->dp,
+							   tmp_ar->pdev_idx);
+			if (!tmp_dp_pdev)
+				continue;
+			msdu_copied = skb_copy(skb, GFP_ATOMIC);
+			if (!msdu_copied) {
+				ath12k_err(ar->ab,
+					   "skb copy failure link_id 0x%X vdevid 0x%X\n",
+					   link_id, tmp_arvif->vdev_id);
+				continue;
+			}
+
+			ath12k_mlo_mcast_update_tx_link_address(vif, link_id,
+								msdu_copied,
+								info_flags);
+
+			skb_cb = ATH12K_SKB_CB(msdu_copied);
+			skb_cb->link_id = link_id;
+			skb_cb->vif = vif;
+			skb_cb->ar = tmp_ar;
+
+			/* For open mode, skip peer find logic */
+			if (unlikely(!ahvif->dp_vif.key_cipher))
+				goto skip_peer_find;
+
+			tmp_dp = ath12k_ab_to_dp(tmp_ar->ab);
+			spin_lock_bh(&tmp_dp->dp_lock);
+			peer = ath12k_dp_link_peer_find_by_addr(tmp_dp,
+								tmp_arvif->bssid);
+			if (!peer || !peer->dp_peer) {
+				spin_unlock_bh(&tmp_dp->dp_lock);
+				ath12k_warn(tmp_ar->ab,
+					    "failed to find peer for vdev_id 0x%X addr %pM link_map 0x%X\n",
+					    tmp_arvif->vdev_id, tmp_arvif->bssid,
+					    ahvif->links_map);
+				dev_kfree_skb_any(msdu_copied);
+				continue;
+			}
+
+			key = peer->dp_peer->keys[peer->dp_peer->mcast_keyidx];
+			if (key) {
+				skb_cb->cipher = key->cipher;
+				skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
+
+				hdr = (struct ieee80211_hdr *)msdu_copied->data;
+				if (!ieee80211_has_protected(hdr->frame_control))
+					hdr->frame_control |=
+						cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+			}
+			spin_unlock_bh(&tmp_dp->dp_lock);
+
+skip_peer_find:
+			ret = ath12k_wifi7_dp_tx(tmp_dp_pdev, tmp_arvif,
+						 msdu_copied, true, mcbc_gsn, is_mcast);
+			if (unlikely(ret)) {
+				if (ret == -ENOMEM) {
+					/* Drops are expected during heavy multicast
+					 * frame flood. Print with debug log
+					 * level to avoid lot of console prints
+					 */
+					ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+						   "failed to transmit frame %d\n",
+						   ret);
+				} else {
+					ath12k_warn(ar->ab,
+						    "failed to transmit frame %d\n",
+						    ret);
+				}
+
+				dev_kfree_skb_any(msdu_copied);
+			}
+		}
+		ieee80211_free_txskb(ar->ah->hw, skb);
+	}
+}
+
 static const struct ieee80211_ops ath12k_ops_wifi7 = {
-	.tx				= ath12k_mac_op_tx,
+	.tx				= ath12k_wifi7_mac_op_tx,
 	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
 	.start                          = ath12k_mac_op_start,
 	.stop                           = ath12k_mac_op_stop,
-- 
2.34.1



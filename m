Return-Path: <linux-wireless+bounces-2314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C083623F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 12:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AB01C26AF2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ABA3D549;
	Mon, 22 Jan 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UlebZWFY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBE3D3B3
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923575; cv=none; b=LMGfx+ZY48D6mOO6dkXt/b+a5Zdwy/VRbu3xqu5zjeO+O2qLaDtWsZYI2hObqpyD8rKP+aZmDQ1abGW/vV705vUb08Q1d9X9Mw0WBBcv33uBssBIW8PZDDYsJzOoZZyHhRQausqaj5sIYDp/VldDD0qjhKXdGzG4dbl5HRCJtMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923575; c=relaxed/simple;
	bh=l6msSsPIWdVEJVLthBqEiiJI5Jz1YwC7rDromXpHf/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flqKYQ9dDU5wE6ciCNiIDOhTO8mhFOm/z2dk4Fn8vKGNxL/crO4Y6ug0GtInK4zK37WUrBxTHzNgxy/ezvnY1bGHkyBzKavDvkfh5yNurLvNq6pYV0SIomQJ0XVZjaWIo8IHMCoLsdCuNQ8Wx70jI1/rtj4mI0H+U8wpgSEHZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UlebZWFY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M8hYqW008729;
	Mon, 22 Jan 2024 11:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=fG5PQ5o4zu6mTHCXaruHidP4G+7F2VJ7rLb4mPILeYM=; b=Ul
	ebZWFYKCKhYvBIJmwpozFQoXhPpkmOvoQujVO/drNG/+4JnK4M1tNKf1GWSHx8vD
	ZbZMJ2FEA+OiPu8dilbyR0v8luM13O3ANm6ATXEKZHK9kIa1SfyZ9xHT0VMWus5b
	AXWZsLATWscFKPmqTgSKnog5f3/5OHt9qmuYfHnFjCRZyWjz26F3CuH3KdHCojOO
	BIXAau24cM785qXoTMrBJ91fxGRld/cL1L1UYCBborId0ks2QvjMY7/A4BDFylpf
	AkVOcSTrxIl8RpM+BUYukqDM0vC85o94dyiPhtY2faumYQf8aBsut/LlnRJUG2GY
	dFLoj2VepPlEQPns5G/w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr6d7krxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MBdRMH022338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:27 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 03:39:25 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 02/10] wifi: ath12k: add P2P IE in beacon template
Date: Mon, 22 Jan 2024 19:38:56 +0800
Message-ID: <20240122113904.8938-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122113904.8938-1-quic_kangyang@quicinc.com>
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hwrP2-u2mi7HIznLjpvOru-9ze7a1TqR
X-Proofpoint-ORIG-GUID: hwrP2-u2mi7HIznLjpvOru-9ze7a1TqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220083

P2P Element is a necessary component of P2P protocol communication.
It contains the Vendor Specific Information Element which includes
the WFA OUI and an OUI Type indicating P2P.

Add P2P IE in beacon template, and implement WMI interface for it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v3: rebase on new ath-tag.
v2:
    1. add Tested-on tag of QCN9274.
    2. update copyright.

---
 drivers/net/wireless/ath/ath12k/mac.c | 85 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.c | 39 ++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 10 +++-
 3 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4751bfeaf46f..86eb11072aec 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1138,6 +1138,64 @@ static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 	return ret;
 }
 
+static int ath12k_mac_setup_bcn_p2p_ie(struct ath12k_vif *arvif,
+				       struct sk_buff *bcn)
+{
+	struct ath12k *ar = arvif->ar;
+	struct ieee80211_mgmt *mgmt;
+	const u8 *p2p_ie;
+	int ret;
+
+	mgmt = (void *)bcn->data;
+	p2p_ie = cfg80211_find_vendor_ie(WLAN_OUI_WFA, WLAN_OUI_TYPE_WFA_P2P,
+					 mgmt->u.beacon.variable,
+					 bcn->len - (mgmt->u.beacon.variable -
+						     bcn->data));
+	if (!p2p_ie) {
+		ath12k_warn(ar->ab, "no P2P ie found in beacon\n");
+		return -ENOENT;
+	}
+
+	ret = ath12k_wmi_p2p_go_bcn_ie(ar, arvif->vdev_id, p2p_ie);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to submit P2P GO bcn ie for vdev %i: %d\n",
+			    arvif->vdev_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ath12k_mac_remove_vendor_ie(struct sk_buff *skb, unsigned int oui,
+				       u8 oui_type, size_t ie_offset)
+{
+	size_t len;
+	const u8 *next;
+	const u8 *end;
+	u8 *ie;
+
+	if (WARN_ON(skb->len < ie_offset))
+		return -EINVAL;
+
+	ie = (u8 *)cfg80211_find_vendor_ie(oui, oui_type,
+					   skb->data + ie_offset,
+					   skb->len - ie_offset);
+	if (!ie)
+		return -ENOENT;
+
+	len = ie[1] + 2;
+	end = skb->data + skb->len;
+	next = ie + len;
+
+	if (WARN_ON(next > end))
+		return -EINVAL;
+
+	memmove(ie, next, end - next);
+	skb_trim(skb, skb->len - len);
+
+	return 0;
+}
+
 static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 {
 	struct ath12k *ar = arvif->ar;
@@ -1170,14 +1228,37 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 				    ies, (skb_tail_pointer(bcn) - ies)))
 		arvif->wpaie_present = true;
 
-	ret = ath12k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
+	if (arvif->vif->type == NL80211_IFTYPE_AP && arvif->vif->p2p) {
+		ret = ath12k_mac_setup_bcn_p2p_ie(arvif, bcn);
+		if (ret) {
+			ath12k_warn(ab, "failed to setup P2P GO bcn ie: %d\n",
+				    ret);
+			goto free_bcn_skb;
+		}
 
-	kfree_skb(bcn);
+		/* P2P IE is inserted by firmware automatically (as
+		 * configured above) so remove it from the base beacon
+		 * template to avoid duplicate P2P IEs in beacon frames.
+		 */
+		ret = ath12k_mac_remove_vendor_ie(bcn, WLAN_OUI_WFA,
+						  WLAN_OUI_TYPE_WFA_P2P,
+						  offsetof(struct ieee80211_mgmt,
+							   u.beacon.variable));
+		if (ret) {
+			ath12k_warn(ab, "failed to remove P2P vendor ie: %d\n",
+				    ret);
+			goto free_bcn_skb;
+		}
+	}
+
+	ret = ath12k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
 
 	if (ret)
 		ath12k_warn(ab, "failed to submit beacon template command: %d\n",
 			    ret);
 
+free_bcn_skb:
+	kfree_skb(bcn);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 2fa724e5851a..f202c21f8b64 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1710,6 +1710,45 @@ int ath12k_wmi_send_bcn_offload_control_cmd(struct ath12k *ar,
 	return ret;
 }
 
+int ath12k_wmi_p2p_go_bcn_ie(struct ath12k *ar, u32 vdev_id,
+			     const u8 *p2p_ie)
+{
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_p2p_go_set_beacon_ie_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	void *ptr;
+	int ret, len;
+	size_t p2p_ie_len = p2p_ie[1] + 2;
+	size_t aligned_len = roundup(p2p_ie_len, sizeof(u32));
+
+	len = sizeof(*cmd) + TLV_HDR_SIZE + aligned_len;
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+	ptr = skb->data;
+	cmd = ptr;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_P2P_GO_SET_BEACON_IE,
+						 sizeof(*cmd));
+	cmd->vdev_id = cpu_to_le32(vdev_id);
+	cmd->ie_buf_len = cpu_to_le32(p2p_ie_len);
+
+	ptr = skb->data + sizeof(*cmd);
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_ARRAY_BYTE,
+					     aligned_len);
+	memcpy(tlv->value, p2p_ie, p2p_ie_len);
+
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_P2P_GO_SET_BEACON_IE);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_P2P_GO_SET_BEACON_IE\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int ath12k_wmi_bcn_tmpl(struct ath12k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
 			struct sk_buff *bcn)
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 06e5b9b4049b..b92b37784f09 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_WMI_H
@@ -3503,6 +3503,12 @@ struct wmi_bcn_tmpl_cmd {
 	__le32 esp_ie_offset;
 } __packed;
 
+struct wmi_p2p_go_set_beacon_ie_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 ie_buf_len;
+} __packed;
+
 struct wmi_vdev_install_key_cmd {
 	__le32 tlv_header;
 	__le32 vdev_id;
@@ -4806,6 +4812,8 @@ int ath12k_wmi_cmd_send(struct ath12k_wmi_pdev *wmi, struct sk_buff *skb,
 struct sk_buff *ath12k_wmi_alloc_skb(struct ath12k_wmi_base *wmi_sc, u32 len);
 int ath12k_wmi_mgmt_send(struct ath12k *ar, u32 vdev_id, u32 buf_id,
 			 struct sk_buff *frame);
+int ath12k_wmi_p2p_go_bcn_ie(struct ath12k *ar, u32 vdev_id,
+			     const u8 *p2p_ie);
 int ath12k_wmi_bcn_tmpl(struct ath12k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
 			struct sk_buff *bcn);
-- 
2.34.1


